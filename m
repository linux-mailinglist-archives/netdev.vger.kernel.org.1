Return-Path: <netdev+bounces-101931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371F900A0B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D657F2827A7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618C19AA62;
	Fri,  7 Jun 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuoM6OcS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B719AA74
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776486; cv=none; b=QD9MNZrlg7KqwXuK7YYLHbJ2EFS+KoPYACDqu8eQFRCu879Y2g23QiQLV35Gq4Gb7TXaI9trRBHmbC6N2/xS5RBSJORHuGc4djuYfkXZ92Sid320Vc5ErnuEV6kW8B0sOHn/uBQpvs3vXxFgFERMIRyDFQfOPNNtcIoi/6b7eOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776486; c=relaxed/simple;
	bh=QglwNdcsA51J6wQYL6H/q82x8oDdhH78HGfeiSZECsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im5Gw40bPUietTnCDJjmFaZXas566haG89wGuttm3iFqBiOU5zjG/Ed1ItXEcVSQrVOcIcnpmFn5eUUhcot+1osSSGmDvoKYN64OH4DakJt5kMo8BCcKgQ/NxvXTEtL06s+XwEYmdoL67YvJc0/BdOWmp+UxY1kaGMd5xXsdPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuoM6OcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717776483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8U3+g6YznrIZbdPROW/ErLXZCEgBfJNaERO2crh9nyw=;
	b=GuoM6OcSWzpi38lX+owHtyFE9DQSB4S7K37oK7/ukL1RKTFA1qVPz9TDSemh+d3ENHGPL1
	Om+hDkgN2KAdbzsYMlV6fjGdk1D+LdEfyHR3z26f9MJkpAdSHi1upFJM1gilCtrcp2VxlB
	FLrwNQs8EuzQZv76la8x24CHqr+v/6M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543--c3oNYSePSWPKaWC3isFIw-1; Fri, 07 Jun 2024 12:08:02 -0400
X-MC-Unique: -c3oNYSePSWPKaWC3isFIw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2eaa6f40e15so21230271fa.2
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 09:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776480; x=1718381280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U3+g6YznrIZbdPROW/ErLXZCEgBfJNaERO2crh9nyw=;
        b=YFWBrFIi1nmpgNpqOAjVA2DBTIhLP3AayeWUL0D8C6ECaNPOQTED04KezZ9ZOT+Biw
         aaFTcwS83mo4Ic1I2g6fo8zL6anY8i5GjkVHQcWoPYtrJXEC1RxQUvvMg4Qf7YVMfd7M
         8NfRCyydFezEh9DdogTUa7FizrRPwx9u6GxE6iQ2wXOjF4SMAIxhQahLWyniNpJ96q5G
         OVLY8g8PqHVz/yd+jJZEkAjL3Ah/OrKLpXGICaSUqzMy3gcTYgQsfs3+ak4R6uTTqweQ
         XImR/2ovbPzV5Ga0/p2ok+II+/R+F70JSr3y8gt9puJZlwwl2wTKyCTSleadMZRGLjFh
         7rHQ==
X-Gm-Message-State: AOJu0Yz0Brkd/rpi42IgFrZhkSyhgF0yMKz4sb+pPu1w7cYs2IKAvdsj
	ISpdEEqi7RoP0RuWKL/YeUx407gaYMptu8/ScJ5bRKLRYXkjElNdltBguDQ8wyMMZ8V0w5Ok3xi
	AsRVO5+Lk1xPjoFsRuG1+7EhipeFFGpkBVgBOd2gykUi/YdOZDo/Msjo66fbk0/ml
X-Received: by 2002:a2e:890d:0:b0:2ea:904e:481c with SMTP id 38308e7fff4ca-2eadcea97e0mr23697761fa.53.1717776480047;
        Fri, 07 Jun 2024 09:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4L3C+xdL2eKbxFZaKahGICbEU8EtZXqMbTaMd8HBKPo9qrXs2Jc8UZ+3KVo8TpRZHUAsryw==
X-Received: by 2002:a2e:890d:0:b0:2ea:904e:481c with SMTP id 38308e7fff4ca-2eadcea97e0mr23697601fa.53.1717776479693;
        Fri, 07 Jun 2024 09:07:59 -0700 (PDT)
Received: from telekom.ip (adsl-dyn127.78-99-32.t-com.sk. [78.99.32.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ebd59sm264672166b.116.2024.06.07.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:07:58 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Fri,  7 Jun 2024 18:07:53 +0200
Message-ID: <20240607160753.1787105-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment in this function says, the code currently just clears the
CIPSO part with IPOPT_NOP, rather than removing it completely and
trimming the packet. The other cipso_v4_*_delattr() functions, however,
do the proper removal and also calipso_skbuff_delattr() makes an effort
to remove the CALIPSO options instead of replacing them with padding.

Some routers treat IPv4 packets with anything (even NOPs) in the option
header as a special case and take them through a slower processing path.
Consequently, hardening guides such as STIG recommend to configure such
routers to drop packets with non-empty IP option headers [1][2]. Thus,
users might expect NetLabel to produce packets with minimal padding (or
at least with no padding when no actual options are present).

Implement the proper option removal to address this and to be closer to
what the peer functions do.

[1] https://www.stigviewer.com/stig/juniper_router_rtr/2019-09-27/finding/V-90937
[2] https://www.stigviewer.com/stig/cisco_ios_xe_router_rtr/2021-03-26/finding/V-217001

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 79 +++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 5e9ac68444f89..e9cb27061c12e 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1810,6 +1810,29 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
 	return CIPSO_V4_HDR_LEN + ret_val;
 }
 
+static int cipso_v4_get_actual_opt_len(const unsigned char *data, int len)
+{
+	int iter = 0, optlen = 0;
+
+	/* determining the new total option length is tricky because of
+	 * the padding necessary, the only thing i can think to do at
+	 * this point is walk the options one-by-one, skipping the
+	 * padding at the end to determine the actual option size and
+	 * from there we can determine the new total option length
+	 */
+	while (iter < len) {
+		if (data[iter] == IPOPT_END) {
+			break;
+		} else if (data[iter] == IPOPT_NOP) {
+			iter++;
+		} else {
+			iter += data[iter + 1];
+			optlen = iter;
+		}
+	}
+	return optlen;
+}
+
 /**
  * cipso_v4_sock_setattr - Add a CIPSO option to a socket
  * @sk: the socket
@@ -1986,7 +2009,6 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		u8 cipso_len;
 		u8 cipso_off;
 		unsigned char *cipso_ptr;
-		int iter;
 		int optlen_new;
 
 		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
@@ -2006,23 +2028,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		memmove(cipso_ptr, cipso_ptr + cipso_len,
 			opt->opt.optlen - cipso_off - cipso_len);
 
-		/* determining the new total option length is tricky because of
-		 * the padding necessary, the only thing i can think to do at
-		 * this point is walk the options one-by-one, skipping the
-		 * padding at the end to determine the actual option size and
-		 * from there we can determine the new total option length */
-		iter = 0;
-		optlen_new = 0;
-		while (iter < opt->opt.optlen) {
-			if (opt->opt.__data[iter] == IPOPT_END) {
-				break;
-			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
-				iter++;
-			} else {
-				iter += opt->opt.__data[iter + 1];
-				optlen_new = iter;
-			}
-		}
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
@@ -2242,7 +2249,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
  */
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
-	int ret_val;
+	int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len,
+	    hdr_len_delta;
 	struct iphdr *iph;
 	struct ip_options *opt = &IPCB(skb)->opt;
 	unsigned char *cipso_ptr;
@@ -2255,16 +2263,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	if (ret_val < 0)
 		return ret_val;
 
-	/* the easiest thing to do is just replace the cipso option with noop
-	 * options since we don't change the size of the packet, although we
-	 * still need to recalculate the checksum */
-
 	iph = ip_hdr(skb);
 	cipso_ptr = (unsigned char *)iph + opt->cipso;
-	memset(cipso_ptr, IPOPT_NOOP, cipso_ptr[1]);
+	cipso_len = cipso_ptr[1];
+
+	hdr_len_actual = sizeof(struct iphdr) +
+			 cipso_v4_get_actual_opt_len((unsigned char *)(iph + 1),
+						     opt->optlen);
+	new_hdr_len_actual = hdr_len_actual - cipso_len;
+	new_hdr_len = (new_hdr_len_actual + 3) & ~3;
+	hdr_len_delta = (iph->ihl << 2) - new_hdr_len;
+
+	/* 1. shift any options after CIPSO to the left */
+	memmove(cipso_ptr, cipso_ptr + cipso_len,
+		new_hdr_len_actual - opt->cipso);
+	/* 2. move the whole IP header to its new place */
+	memmove((unsigned char *)iph + hdr_len_delta, iph, new_hdr_len_actual);
+	/* 3. adjust the skb layout */
+	skb_pull(skb, hdr_len_delta);
+	skb_reset_network_header(skb);
+	iph = ip_hdr(skb);
+	/* 4. re-fill new padding with IPOPT_END (may now be longer) */
+	memset((unsigned char *)iph + new_hdr_len_actual, IPOPT_END,
+	       new_hdr_len - new_hdr_len_actual);
+
+	opt->optlen -= hdr_len_delta;
 	opt->cipso = 0;
 	opt->is_changed = 1;
-
+	if (hdr_len_delta != 0) {
+		iph->ihl = new_hdr_len >> 2;
+		iph_set_totlen(iph, skb->len);
+	}
 	ip_send_check(iph);
 
 	return 0;
-- 
2.45.1


