Return-Path: <netdev+bounces-88395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE38A6FCE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C225281FC6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35DB130AE6;
	Tue, 16 Apr 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjFRw6fp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695D130E2B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281372; cv=none; b=Yq/c8U2/4KCxsA0p54l2YVkIrn4+iTO9KRNju37l4XsSltqFfzRqI7p8OwG2qNdvNi0vvHaNRuiOk54auNWMSFmnr+366zcdcv3Xih3KUsNjWOSw4rjyxSt/81uhqAEI6d+CwJ0BVQisdVPq8LLXyDVBSD2pdRobE0/d0CYjIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281372; c=relaxed/simple;
	bh=dJtlT/Lh6eLucgT5D9gqd+bfgITRG/RgeBLIC/GWMC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq2OKkCPR2ZpDbftF8qxK9eFsydS2PrK+PvArWmIfZDWpUhewwTminR+1JgFIlhEvk9bW4u44iaEID9FEd7BvYJNs5h2EwTWkyDR/zXuGTqMHOaUWTgzDXpyP9sSIoTvcgYsPMRCXV1x6q7AXnftRJVl0jLjEfFFH435w+iwtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjFRw6fp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713281370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAMdkE1tXdQC85mwGK8FhTiOuXJsAzds2KdQUoME7ek=;
	b=PjFRw6fpj39sTIdE7e+xEqv5bz4LiNFQT+QGOUi/AohfhPrWnvSmcJUhzXba3NKIm7Wn9l
	JkYpeA48ktMZP+Zo6/cb1qjMKgF8Sr4ZghhIHHRxhTvJxMs9BRPJhfzKjTGH9joIHoFvWY
	IBpCF+fVJgXR/6n/9+3dLLR+UqE4EdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-PWSCgPC6M76ItTgju1v-cw-1; Tue, 16 Apr 2024 11:29:27 -0400
X-MC-Unique: PWSCgPC6M76ItTgju1v-cw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4147de378b9so21196015e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281366; x=1713886166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAMdkE1tXdQC85mwGK8FhTiOuXJsAzds2KdQUoME7ek=;
        b=Vir/86jqVX6vDREYtoCZyG9yREQcAdIBtuiwqEp5E5sODdoaYBZHO6AFeHWXi7GydF
         mn+x2d1r8xLI10fKwKf8eiVVciOvjArMCVycsM9I1+kVjRg9alLvL5j+NnAnoPzSezhR
         7HnLYmIAvG1ASIyNpYYObatZN5vDo0+vFZTsQ46w9g0rbZGq6jEZmEbmW3l43XN4I2aL
         XhBlj44SJ909E1/qRH9nhh8O8ZZYzkJ0yzLbGknYufPm1rhqUEd5LzRyabwNRGW1knP0
         2twNmyLsLnw1ZnygsYPEvvEShxlo/EhIvjrSWqh8+SnA+nZb61dQJiiIcWDqi+PhXCjU
         9Zwg==
X-Gm-Message-State: AOJu0YxB/bM9oJWwobUKYf7VPhOwnIjrJ4F7PeUnRsKc2xyov1Uns/Ya
	LugqkAiHvvTaA2b/2goXnUHUtuM2sZU6tdEXi0bdBi0SELA4RHZZ8uLl24z7mmtm5nL56t+PSoq
	FhnKiTUx0/99oKr4nvRX+SiIyUjAkxigDDcCBpuECDf5PqfjC2LqVwg==
X-Received: by 2002:a05:600c:5246:b0:417:fd7b:ab30 with SMTP id fc6-20020a05600c524600b00417fd7bab30mr10905111wmb.16.1713281366421;
        Tue, 16 Apr 2024 08:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEabo6w3q9w/SGplRDpNbx2W4lrqNPEp+Bo9NqoDoz1K2maVc/wDejqLUkqIxT6NSfPaDg4bQ==
X-Received: by 2002:a05:600c:5246:b0:417:fd7b:ab30 with SMTP id fc6-20020a05600c524600b00417fd7bab30mr10905101wmb.16.1713281366064;
        Tue, 16 Apr 2024 08:29:26 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm14695155wmq.11.2024.04.16.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:21 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Tue, 16 Apr 2024 17:29:13 +0200
Message-ID: <20240416152913.1527166-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416152913.1527166-1-omosnace@redhat.com>
References: <20240416152913.1527166-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the comment in this function says, the code currently just clears the
CIPSO part with IPOPT_NOP, rather than removing it completely and
trimming the packet. This is inconsistent with the other
cipso_v4_*_delattr() functions and with CALIPSO (IPv6).

Implement the proper option removal to make it consistent and producing
more optimal IP packets when there are CIPSO options set.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 89 ++++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 75b5e3c35f9bf..c08c6d0262ba8 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1810,6 +1810,34 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
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
+			if (WARN_ON(data[iter + 1] < 2))
+				iter += 2;
+			else
+				iter += data[iter + 1];
+			optlen = iter;
+		}
+	}
+	if (WARN_ON(optlen > len))
+		optlen = len;
+	return optlen;
+}
+
 /**
  * cipso_v4_sock_setattr - Add a CIPSO option to a socket
  * @sk: the socket
@@ -1985,7 +2013,6 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		u8 cipso_len;
 		u8 cipso_off;
 		unsigned char *cipso_ptr;
-		int iter;
 		int optlen_new;
 
 		cipso_off = opt->opt.cipso - sizeof(struct iphdr);
@@ -2005,28 +2032,8 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
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
-				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
-					iter += 2;
-				else
-					iter += opt->opt.__data[iter + 1];
-				optlen_new = iter;
-			}
-		}
-		if (WARN_ON(optlen_new > opt->opt.optlen))
-			optlen_new = opt->opt.optlen;
+		optlen_new = cipso_v4_get_actual_opt_len(opt->opt.__data,
+							 opt->opt.optlen);
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
@@ -2246,7 +2253,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
  */
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
-	int ret_val;
+	int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len,
+	    hdr_len_delta;
 	struct iphdr *iph;
 	struct ip_options *opt = &IPCB(skb)->opt;
 	unsigned char *cipso_ptr;
@@ -2259,16 +2267,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
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
2.44.0


