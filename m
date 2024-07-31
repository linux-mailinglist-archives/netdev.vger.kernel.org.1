Return-Path: <netdev+bounces-114646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C69434F4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A805228BD97
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9091BE85C;
	Wed, 31 Jul 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="XfOLmJGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CC1BE849
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446648; cv=none; b=GCo9rjPyetpAGse4o9H/qEFYyq2VjsuUBaCq8+ueRZS7YMOgaPpr1lOCOaYSUO6BkLBqtlI3v8Runpin40DyEgBlqi7FIiaDvTwTjIk+Gz2ih7b2Z+VaC2k63+nBLsidVuNxDgjfSy6vd+iAf3F5jm9nFDXniIfsXp5ehoTdnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446648; c=relaxed/simple;
	bh=uCrzGnflXBB/wO7tIWXlW2Kk1gddFbDJri8RoliGZIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClvMF9EVrOKVniUj/KuQG2fkIe9okM/iCtxGjP0suO/NZ4SkLC5NVUC2Q+YAUsJVGITv9o62IkrY/dU1Iq46YUy4aETlzy9irM+Y4W7LZ3AHWuNPT1VO5EeB+xFx+B76IkZMAAjeeaalWPbaE9tVmFkSQi5q3xc6PhVIWrl7cio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=XfOLmJGl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so4526678b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446646; x=1723051446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VAIcPmR4c/mUmwEAsZgDFV7MJlQirW9DYXFb4pZbSk=;
        b=XfOLmJGlib0OmnqszaMjiZP3LJxAzYNr7rIpeJ/vEbpUekK7vd6NTPMB42Jp+Owzgw
         AwYh6ywxj9rYgtdVA01tLvSuhZ6u0Vsy5nclz6sxnuqW2CX/OvC8Xgstc5c3Lg1EqyKf
         /GauV+HRpJ2xbm4NCSqii9DfrL/vyH/I5f/oB56Li/71Rl8+/rXsGpeDA8Yox4GDN5iu
         x9gwJfqRSLXAgaMGFSRxNj7OF6mTu+swa9OivzwD5t3nxOldfxqcydaTPxnBoQd0o9C7
         +x5UxUffjfq2BYUu4ksK2BFcePazeOWdFNHENRSeLuTSAHMcw8DcRruWzBxsXNZHDPJZ
         22mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446646; x=1723051446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VAIcPmR4c/mUmwEAsZgDFV7MJlQirW9DYXFb4pZbSk=;
        b=bHq39W35EIdMTPfBVVJi8O6W72LgfmH9zK6aQs/pAEIOeSqFrp4RLauoW4rbvXt4GU
         oBVYuEBGdYuo7yp/7nPRaIsYcdh+nIdy6NUQ9GTw9dDZNKvkDozGJAZUiYmi2EbKF4Wg
         CzcjcDfyLi4fh4RIhdfm4KQILJPINxfucrYDSp8uv90wZ5y1raEMKYE8hCVmftM8I+h/
         1Hl8EzKa9r8wbg/Y6gHQx694f+eI8YFwURNSJH1ltrf+NeY6zVTVwJQizrE581Rj4VJM
         AAz8l+7CQnyMwMAtX5PAb1tgYVbhPWjT1UBn3XUiI4DO1ukGE1edQ+i+YkILmorZg/eZ
         xi4g==
X-Forwarded-Encrypted: i=1; AJvYcCXrLfg1ZwVbiphPGnYo+s3z0jijIyb5bjWrLjp0MWMm3vuG4+Orv4kVHbrBtksfndy1GtWoTlhfzrycMEa+AHrA3oo5wlk3
X-Gm-Message-State: AOJu0Yw5RYAfpw/EQMGhyL7kmeIPYF8En/URJRrA8Yl1UHnCYyYiih4j
	CyHG61FfsdP2g9KbtJSnduU6poOweul3Pdvs1PYCIVgYrTSOuM6CCuqw/qb/BfoSuvHVef3RniR
	QSw==
X-Google-Smtp-Source: AGHT+IEWst+YGDsEisZO52gN7YdaR80YMovtazfFNrY9HVXqIh2Dt0YnB1ROB8bpMAy+M8t8Xeni0Q==
X-Received: by 2002:a05:6a21:114d:b0:1be:e6d8:756e with SMTP id adf61e73a8af0-1c68d265253mr72285637.53.1722446646236;
        Wed, 31 Jul 2024 10:24:06 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:05 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 11/12] flow_dissector: Parse GUE in UDP
Date: Wed, 31 Jul 2024 10:23:31 -0700
Message-Id: <20240731172332.683815-12-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
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
index 4fff60233992..7f0bf737c3db 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -832,6 +832,61 @@ __skb_flow_dissect_geneve(const struct sk_buff *skb,
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
@@ -988,6 +1043,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
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


