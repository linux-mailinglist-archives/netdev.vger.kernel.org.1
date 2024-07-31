Return-Path: <netdev+bounces-114645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881A9434F3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C86B2266E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A72A1BE24B;
	Wed, 31 Jul 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KIY4ZiIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F61BE258
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446647; cv=none; b=NpbuVaw2ArhADqbG5rfOkFU9sRFGcdmtVfJo+v6BIzt2uZHiCBFmuYxTYPE/Xo1tlD+pRkpx08H67PJJXdHwB1ikVCoXby+aYM+BJ5uZcQS/AYGqlJYdOM8gtmtSs4A3ZmMeYVue1HcYniVHI9CHlpWBKyyarxlkyvw4iL9trkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446647; c=relaxed/simple;
	bh=WqE54iqgsL7Gq5r/FGZzatFq3v1Ubfb/TsjD/HB0MWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJ7kH80MfjbRRjvHLGSka0Io0811aIlEy6XgKAA/+FJvCuiQB5/1MZ7A6UbWTqKIN83WzBiIgfY1hwJgxnrQUBJe8dBxojGXeAg+2HMRocmAAQX24mHvSxa0GZGWFis1oN3IozWCVP2VkagLV+a2NI9X/w42TifAXELg68Z5CJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KIY4ZiIq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4120089b3a.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446645; x=1723051445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMX0tr1XqQIXXYv8t8puiyUaD8WbuWDFc/Hh6oAxUxs=;
        b=KIY4ZiIqgFO3UD9N1n98ar2uZTVuV16lUydIcejn4wJO7n0V82oM0rKwGBQkg9VuGW
         o+Hi57S/Xh9eGXadx1DRn1kKZI6Aw6c2cKhvQQZsTUw6Q8gpQw0NjVBTAuFUiNlWUJ55
         n15Ois+pw4EVZwcyje3ykuVsx+BZs2OgST9a9h5kZb8amwhy7ZEdE1PMFjeMW1zq5WnW
         cwRZodFHQef+cZ1iSTMW2phd1+49CDGxNxOBR/+hkIuRdSSL18tG5vmfKWZyhbahFwIS
         PNkG43ob5liy94vQQCewJ1BuWhvuBbqiBG19goBiky/S1YWhzh1ADpbnwEiX251uvJhe
         VizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446645; x=1723051445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMX0tr1XqQIXXYv8t8puiyUaD8WbuWDFc/Hh6oAxUxs=;
        b=Ehl9GT93G9ejJLrHpL1yaGtDQtWTEpSgRywg3SqoSMh0VLirVQqDfX9S9MOLzOmS3x
         j6f34KvPqV3XbvkvCtyamIuOMWWII0RtjYEJupprh37c9ijSSkkYraUA8gQLQUqgbieK
         f5843aLIFdhzIMNxcKk0t4yHNmlcQsPVxNKGrELuBTJMSUQKLpbiEdGrMqhvVfQ3F9oK
         XX1/4cpHrHL+R9RAxj2Rmy5ZMakjkivWiUkcnq+z8V7+itGQtciBYvDjRbHdoT9nsW8P
         RDUu6MROwxIzZ47K8Ls4VeK49HlxAsdOANyG8m/BW7OTvNdDnPgbXCJgxFpXrEDkX0fK
         iAbg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ERSplkaVCVO5u+Oacub6tXGAq6sBkFooj+mYDUP/9lfMYTvcZXk/rsGC3t29GCCqb3nJb9M43TBo7s4v1tUNbRTh0JOc
X-Gm-Message-State: AOJu0Yx/sv4b/+pyRs3VeJxWzRSMUWZOegt/pdyadi9ttnQgFminU16t
	tXgN1LUvT/jazyf2tQ3BgCoQSOQFTgaa4XUIX1eSHJ9tZNahrC8iBSCD0MikkaGWBcJiYO6FDDq
	lwg==
X-Google-Smtp-Source: AGHT+IE/wgjjpDpaouCZpQnlB9N9HP12Y0QRdbb5N2mjjfhMMS5fNqgmYVEXLId2Cv4kDNe/8lohEw==
X-Received: by 2002:a05:6a00:178e:b0:706:8a67:c395 with SMTP id d2e1a72fcca58-70ece9ebb3amr18997465b3a.6.1722446644859;
        Wed, 31 Jul 2024 10:24:04 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:24:04 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 10/12] flow_dissector: Parse Geneve in UDP
Date: Wed, 31 Jul 2024 10:23:30 -0700
Message-Id: <20240731172332.683815-11-tom@herbertland.com>
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

Parse Geneve in a UDP encapsulation

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 3766dc4d5b23..4fff60233992 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -11,6 +11,7 @@
 #include <net/fou.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/geneve.h>
 #include <net/gre.h>
 #include <net/pptp.h>
 #include <net/tipc.h>
@@ -808,6 +809,29 @@ __skb_flow_dissect_vxlan(const struct sk_buff *skb,
 	return FLOW_DISSECT_RET_PROTO_AGAIN;
 }
 
+static enum flow_dissect_ret
+__skb_flow_dissect_geneve(const struct sk_buff *skb,
+			  struct flow_dissector *flow_dissector,
+			  void *target_container, const void *data,
+			  __be16 *p_proto, int *p_nhoff, int hlen,
+			  unsigned int flags)
+{
+	struct genevehdr *hdr, _hdr;
+
+	hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
+				   &_hdr);
+	if (!hdr)
+		return FLOW_DISSECT_RET_OUT_BAD;
+
+	if (hdr->ver != 0)
+		return FLOW_DISSECT_RET_OUT_GOOD;
+
+	*p_proto = hdr->proto_type;
+	*p_nhoff += sizeof(struct genevehdr) + (hdr->opt_len * 4);
+
+	return FLOW_DISSECT_RET_PROTO_AGAIN;
+}
+
 /**
  * __skb_flow_dissect_batadv() - dissect batman-adv header
  * @skb: sk_buff to with the batman-adv header
@@ -974,6 +998,11 @@ __skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
 					       target_container, data,
 					       p_proto, &nhoff, hlen, flags);
 		break;
+	case UDP_ENCAP_GENEVE:
+		ret = __skb_flow_dissect_geneve(skb, flow_dissector,
+						target_container, data,
+						p_proto, &nhoff, hlen, flags);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1


