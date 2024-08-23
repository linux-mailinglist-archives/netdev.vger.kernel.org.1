Return-Path: <netdev+bounces-121513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054C95D7BF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83531B2146D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5A195B37;
	Fri, 23 Aug 2024 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Rsrd9QZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF21195B18
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444185; cv=none; b=h542sNqq6pDKddr+hufT3PcggbdOBH3vivc8d+dBmx6rVmFT3FJn937GFSfLux3v9wgpeQeCnJr8lWH/6WI1LqduhMayWXGGqKwB5JWHvBsf+d/hypf8eug3IZA1nsWfEGMNlOWrngrEFzKdroNMO/Vrmp+uqPVB9PUlUtajmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444185; c=relaxed/simple;
	bh=6JYdaM/A69YpsXWisJPTYRJ+hdU6tbac4E9JIlFlgg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwoXOegJhZiNr1lJP23z+8kCzJnZcxKAFBzQXDP5kSer9Ke2Y8sLIbsm+udYaCz/ULhWOhQxfy/J11h88YWflBGdWqX1IIPr0z9xTfXsrcA8JqFrA3wP21Y9E42qmjoaP/qcY9nhb/XujkLnQ+e7HzLVEZVczhvIoWMkDZlcQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Rsrd9QZ8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2103457b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444183; x=1725048983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsvEhGAimRsV6DWolEHWd/q0y3eSkl7ku9bx5TLRyN4=;
        b=Rsrd9QZ8/AnJaiOqOqkVytrOtMXK/mGjPEMm6ym57f4O5vs7qNjAaGH8RKCZ/P7xoH
         UNWte3SIpwvzxhcDpCOq3PlTDKgEt2/qfhkRZk33w36aU89ONIBzEM8vZP+cTNQZxpp1
         bOV/7goCm8vKXQaGlivbejJR6c8X9S7/3MVWukBn3+s4+xPbn/JxievGIytCfw8WApUV
         IiuJCgem4yzuUfx5jxoUeDDfS28DD5LRd2eTNanIgmvOo/W9ER6D/ssN6NiFR4s6qJR5
         REpSBR5fivx+fgX2JnstoqCVmK+3o5gVODKL3cWuh+Jdy/9lKT9A8QGicGIP0FyryFCu
         sBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444183; x=1725048983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsvEhGAimRsV6DWolEHWd/q0y3eSkl7ku9bx5TLRyN4=;
        b=Pn1Xiv9Fl1KFFaCzIpiMAAy2kpr7DW6GLLLrbe8ca6dh3rtGbrdwS1XWBlq+f/0ebN
         iSun4Csuq64cUTCsJOQP23N/+++QJswW75ypRpsZyU0YqeQwU1ilYsVJP6YOAd0DvkhB
         +GNQXgxPuZXHG8Op0XEafyPO3MzmwAfAZeL2pA9uhuBX1O/jHasnWuhCDj7so3XuzhAq
         Z/mmFQ0wB5SpOz3MGmuN998k3jH8Z+E2lQOzkbMY14Yv+O4fhUWTH3hJZvObdSZleMYA
         YJP9AgSb5CtLG4HxPeFr17cOYDBUKqto8uJnBdNRA+pKr9lvhp72Lb7fg9evOFyfjQ34
         cnPA==
X-Forwarded-Encrypted: i=1; AJvYcCWglKKyLkcRmwXAB6yajRHnh0OqVMGzAam/Nh2RMxeNE3+H139BUvCLxdU+e++qpjBWLr9sZ9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjUPLj/DDBwuITdOvJx87YRcElkagq1i1vbVBb7qHLC2QoEQ7
	Jk6KABfNlfMfzMHiIDdEsO7Tyco67deQvnw4pdiKPlY8babSo38UgNFVttJOJw==
X-Google-Smtp-Source: AGHT+IGJoBGUi3+PypMTvPRfYTlUwgxq3qHbJRDlZXUHLTlqW7/NMRSYK1OB/ZEqW144KpeAH1xKdA==
X-Received: by 2002:a05:6a00:9187:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-714457c1845mr3352941b3a.15.1724444182955;
        Fri, 23 Aug 2024 13:16:22 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:21 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 10/13] flow_dissector: Parse GUE in UDP
Date: Fri, 23 Aug 2024 13:15:54 -0700
Message-Id: <20240823201557.1794985-11-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse both version 0 and 1 of GUE encapsulated in UDP. Add helper
function __skb_direct_ip_dissect to convert an IP header to
IPPROTO_IPIP or IPPROTO_IPV6 (by looking just at the version
number)

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1deb9c3a75aa..b59a9e896a31 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -821,6 +821,61 @@ __skb_flow_dissect_geneve(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static __u8
+__skb_direct_ip_dissect(void *hdr)
+{
+	/* Direct encapsulation of IPv4 or IPv6 */
+
+	switch (((struct iphdr *)hdr)->version) {
+	case 4:
+		return IPPROTO_IPIP;
+	case 6:
+		return IPPROTO_IPV6;
+	default:
+		return 0;
+	}
+}
+
+static enum flow_dissect_ret
+__skb_flow_dissect_gue(const struct sk_buff *skb,
+		       struct flow_dissector *flow_dissector,
+		       void *target_container, const void *data,
+		       __u8 *p_ip_proto, int *p_nhoff,
+		       int hlen, unsigned int flags)
+{
+	struct guehdr *hdr, _hdr;
+	__u8 proto;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	switch (hdr->version) {
+	case 0:
+		if (unlikely(hdr->control))
+			return FLOW_DISSECT_RET_OUT_GOOD;
+
+		*p_nhoff += sizeof(struct guehdr) + (hdr->hlen << 2);
+		*p_ip_proto = hdr->proto_ctype;
+
+		break;
+	case 1:
+		/* Direct encapsulation of IPv4 or IPv6 */
+
+		proto = __skb_direct_ip_dissect(hdr);
+		if (proto) {
+			*p_ip_proto = proto;
+			break;
+		}
+		fallthrough;
+	default:
+		return FLOW_DISSECT_RET_OUT_GOOD;
+	}
+
+	return FLOW_DISSECT_RET_IPPROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -1002,6 +1057,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, const struct net *net,
 		*p_ip_proto = fou_protocol;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
 		break;
+	case UDP_ENCAP_GUE:
+		ret = __skb_flow_dissect_gue(skb, flow_dissector,
+					     target_container, data,
+					     p_ip_proto, p_nhoff, hlen, flags);
+		break;
 	case UDP_ENCAP_SCTP:
 		*p_ip_proto = IPPROTO_SCTP;
 		ret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
-- 
2.34.1


