Return-Path: <netdev+bounces-269929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP8sE/FWvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:17:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F092DBB10
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DDD130160E4
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9773BB9F2;
	Fri, 20 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D37JZ78H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3E25F98A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016134; cv=none; b=Sp0mSHKJ0lYWz6tEKpCZUJyKpJSJmEVXOo6J75njDuTaBfSNISrUPSvddPQewp6H1bxC5nC25GpbOlOPLuJHverN9F2WbhzdB6cvNwrqAt/eMzllIDez+ljHlyOCccvPYV/MdwjbC6jwP+8Szd4vVFpcV6gVkfrsu2KF2oOcNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016134; c=relaxed/simple;
	bh=4I3Gu/m6+PyLRyI8ZpPfl0UW8vRvYK8wawDdcjka2bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfyalilebCIwhfkVWBfNWHSrPJXE4UNFadcWpwOWS+jJkV710VoiKOl1tjgOMmh6l8rf5DD0NoQo+VLybM8FPOqJeySgNOZ9BMYndWw+DaaksYyOWTUzm7tVuIhzDpflwTFeHtUI9YcHUKLd7dIWUEUU8jAKBoCn6zSH2xKOSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D37JZ78H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so249847a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774016133; x=1774620933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXuWvTQVp0L/2Sb42ubq5GFx/aw501bQtxZ0KpV3t18=;
        b=D37JZ78H80qQfDH+/zHM6KoX7RnIUMMu/kty9KE1S8IY/OCGX4yO7Bn8pLoc10XQfl
         rXrXpRbZMXpX0GsIFKL9ibb8FBbZX8K71bu3FKAqGWEcvDwLQKGPnZRq9GQusj0RSKhY
         iDwJxDMw5fks68+wDaF+WFdoTsjBVm9adChGQOXWrpm4tJHW24IKHNZHlevwCuhaPyla
         zilYguVTzg8ujYsDNSuXlTuHscfnc4+MhsIQvvVmca4f785W+v/ZH8EJc2OLH2FN9pDB
         VqAloq9LZ10ncJaJCxaoZ8Bzu4v/FjCATi0Epu8ZD0mS3uOaXg3KuP+3GA9ewcVPqPIY
         9u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774016133; x=1774620933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXuWvTQVp0L/2Sb42ubq5GFx/aw501bQtxZ0KpV3t18=;
        b=cQFcvFa8r0byuplzUPKpSHt6I9pkmpya2HbUwes7yXTz25E/6eqIyqWNcQH8LV/468
         +YiUxMjCQyg6Q6aBtC0k6E91tAYhnNhnLCZfVRjeRnj0tdws+Iyo6ZsM/T4kqa5cW/YQ
         CkO1Fza3ev6ebAiGWSZzChWfS2gVlvWhO+X6Ut1vXK6A2KHaUISvMC+jlgsiv7MExVbs
         dfqpOkHv4rkYyEw6Dc9aDwDmqzqkUvqpVTy9UF1uQQk1VJMYkm4usLXs9VUqt1bz7Ss/
         dtwnlWJOKdUYjclqOl1gxDzuAJpKLW1UII+G+0449NLkxE2yGo+xARNYJsf+0VKwO94S
         E2+A==
X-Forwarded-Encrypted: i=1; AJvYcCVFkvwZo8ZhgyhlLkA9ixNc29qZU8r6SeU9FdJ0uhBXkc4VsZ1rbo/HXNs0ADiR0wV4s9/y0x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQC4qMH1Ew7sdrFQYniCzbOrFezh10Y+1881iSLEG23Sa6SVuX
	iGcF215NZWOLlUzokG0Xc6CVgggyYqW4IsvCQ6fPVIeQtAkX+Z7rnWro5Bb1QDXRgNsBOISHkkU
	=
X-Gm-Gg: ATEYQzyp37yYgAUq0+f5zabGmPXyQWZVerXOM3QsqHO39CalWEtTQjl37Pslxsdi2Pm
	fScMLvg9OUYaQ+Hi6GqKNoA7mHT74VAav0Tw+lIGHb4EsImgLp+x3VhICRCE40j+OATgR4t/7lq
	2sMpyBcaXfqKyls4AIU90hQuYo+4WZp9TTPo7DX/VTnYkKQzY++1PWHX9ALH3ysaYRYTenkXZvd
	GPByc1V4wkoCkT9QFNRAV042wHJLg2QX8iI7W4aDA6l4EYpB46HXRCIDGNPYDHGkLONkPvx7NN3
	IVFwGYUXbtnh9qjInN+pv/25sieZOfLv6QmmFb9k9qJIqtIrK3PfSaqdP9blVqHB0SfHSyl57Wh
	iMLJy1HvkFDzKF8/bA16xF1+T4kkjCdQJ/SIAiO55EBxmfoI5ZZX++J1GFvV0Z5Y2STmIkqizre
	zuuxjAQLjO6yMxqTGf1hbsTdJBI8YrchyeyJgZGpPDrLEl5aEvvJlnu7mcukkns2a45NIH5pMeO
	q1BwSTx/M8pOAVh4kNHqg30KaQaAV4jqcStnhIpywAHmgNv4iiz1DkxaPM3HFfA3Yt8jekCVYvS
	4GiNvK3op/0=
X-Received: by 2002:a05:6a20:244f:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-39bce9b60d1mr3175667637.12.1774016132564;
        Fri, 20 Mar 2026 07:15:32 -0700 (PDT)
Received: from DellG15.localdomain (2001-b030-8055-ffc7-2d87-7642-b84f-7a21.hinet-ip6.hinet.net. [2001:b030:8055:ffc7:2d87:7642:b84f:7a21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a7ff529sm2027246a12.2.2026.03.20.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:15:32 -0700 (PDT)
From: Guoyu Su <yss2813483011xxl@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com,
	Guoyu Su <yss2813483011xxl@gmail.com>
Subject: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4 GSO skbs
Date: Fri, 20 Mar 2026 22:14:59 +0800
Message-Id: <20260320141459.9691-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269929-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.575];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B0F092DBB10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported a KMSAN uninit-value warning in gso_features_check()
called from netif_skb_features() [1].

The current direct skb->len check is not sufficient for SKB_GSO_DODGY
packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can build
a DODGY GSO skb whose total length is large enough, while the IPv4
header is not fully available as initialized linear data for a direct
iph->frag_off access.

Use skb_header_pointer() to fetch the IPv4 header only for DODGY packets
and clear mangleid_features conservatively if the header cannot be
accessed or the DF bit is not set.

Keep the existing direct ip_hdr()/inner_ip_hdr() access for non-DODGY
packets so that buggy internal callers are still exposed.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
v5:
 - Move nhoff into the SKB_GSO_DODGY branch.
 - Drop the explicit nhoff < 0 check.

v4: https://lore.kernel.org/netdev/20260319005421.14908-1-yss2813483011xxl@gmail.com/
v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..be0cc69fa534 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3805,10 +3805,20 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		const struct iphdr *iph;
+		struct iphdr _iph;
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
+			int nhoff = skb->encapsulation ?
+				    skb_inner_network_offset(skb) :
+				    skb_network_offset(skb);
+
+			iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+		} else {
+			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
+		}
+
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1


