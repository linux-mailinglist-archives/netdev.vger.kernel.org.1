Return-Path: <netdev+bounces-272019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ2+EmokxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:19:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EE3351AC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16611303F98A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23973F788D;
	Thu, 26 Mar 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp7OwJXk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D53F786B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527550; cv=none; b=RhJhy20ay/+/PN9owHaIwcyTCICNm10uJLG2WHF/2wdeNPw5HnmWyQ3F+mKY7kfNeir0aCkv4g7/wYoXKdxuUaiYjbFOYiC5KIsRTak2NCDbAH5Vd4+uI48irbqFbt1VmHQ0vtAP7wlw/J3Fib3m6g2VG86ZmqaXHV5dVsl32hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527550; c=relaxed/simple;
	bh=6QxCbieJJleZEWz03PvwCXWOh6SMITR1YbIicVfha6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RC4uMq9HbtW2A7TKA+oL0J35Q+AO+KfnROvJYY9ApQiFQx8uHXe29TLWvcFbvET3/XRubtxk160DZZPtJoWKNRpJQ/ZjlaXDjjVRgz3KiNewGglyxVWue2FHpkCkp4lCTZszjEtgtavXL/a1GCcU93QCrT928BPw2f9xn2S/KQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp7OwJXk; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso1379352c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527549; x=1775132349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G29ArKF84b4SeGetKeNGKRAR6Wyr/iQ+64xYn6vES30=;
        b=cp7OwJXkeX8ZrguPRm6SJc116/R76b0tmxRSslXRgvCkEmqaxU1aFqm0epSfZPxSz2
         yDO4RQ/eOa+07xqGdupAArpO5xLKShkQXi5D46/OVh80jNdMG+7feiKZGu4AKddZ7WXv
         5ch1C3Lh+WUvelZOS5N1istCseryP1n8gMh3q+++SVUJzmmieMij+ix/u9OVk1OBJFm0
         VvxBZ/BMkJ6yJkhJnfeHEHHVlTLreWW7VQO/sYszRp+W7TSOAg0NOnASvwd/bTiHckht
         XKVx3ViYuTwZsImp9Daq3R/EIigMGF4uWHUZnbgjhz4/tPgZ9BQhwU6tXcplOfgNjgkQ
         01Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527549; x=1775132349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G29ArKF84b4SeGetKeNGKRAR6Wyr/iQ+64xYn6vES30=;
        b=U6GsTFtH9oc/A1AaF1Hk3jlkJWyHrBHcQchj2UOp/NdKUZ2FXyP2Mr80KIE6549cqK
         hBXG4fu3wMQM17olZHWfHiF5C4OcQKVa6GzZa7ZBtPoARbaRDqkvIGJVHgNxAgcfUuqS
         TTaaHYFw8UPBOpfecM4JOykPN8fINNHbg5R+IktPOVDcEG+kXGFJv1qPgoV6D5sICeli
         fvsOmNVSkjXOpYYUFTngZn5xrwTGfNlGmcJn/2G6xvs8rhXu+UP3cQF9v1trlCpW7n/X
         eqPg+2ag9d0C0GffHbMRcUl7b7G3BdMD7e8PujgQ4lCK2W39THOwzlYg9fZcPWnype6+
         1Hnw==
X-Forwarded-Encrypted: i=1; AJvYcCWoqArqYhcaJASLEI5ctIUd7JD5TTjBaV0IU54jIcsZU/21MUCKWXEKw4w4QpWRulNmaRfw/GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93sJDnROEPd6vPWzMrcsO2djgbA9TlLQK6xbXIS5obzF+VWAB
	TP+BWLrQitjxleybmNPTmKo6mZCT9vYgwJGK+5rieR1Ls1nqA/Fbw/F9
X-Gm-Gg: ATEYQzw/seXXltkRa0MNvc6rGhTj1kiJMxhIXk971jkG8GwiUxXj+kDGkQq3xuq6HYc
	jwL20YcBjjCKHlwo2SwxcMTgcSBziHBdBA6rhKh/ZSgv1HOmx7AdNu7tkJl3nwubKnKWN0MzlTh
	K0NITN0QopJg6W8njkC7uoU5slIOw4klrZR4s+7hpJ4lVTaJVChDyZ30FVYxt053FzuIhiFJyiK
	T2hKxFoweU5KrpcrjfIdCtzQkZZdLm8TUuG3lpIGDTpx7laX6KOw61N1D536gTaCiW0JkZAfRH4
	qQ3Y+YXpzbCL0y/Z8cOlEh+A1Xy1pQsoALyR6hOjRLBKzvCqT6hZCfqLRrSpzK2BhziCJZmj9nY
	bC3kxCfrbc7eWM7ZLXEgPvltoRzN7BCjG3OomUS3WzMwloNGzX8f6ORx8qNKdIHtTsxoAp7c+F5
	H1s2J3oLOrg0eLe69s+cXS9Y5M0bePlzLJnnJ6OR2EfZYM09WcbNkgzXLj+FkXpQSpG6samjpGm
	Q==
X-Received: by 2002:a05:7023:b0b:b0:128:d577:dc21 with SMTP id a92af1059eb24-12a96e68023mr3835481c88.13.1774527548431;
        Thu, 26 Mar 2026 05:19:08 -0700 (PDT)
Received: from DellG15.lan ([134.195.101.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa72492e7sm2473117c88.5.2026.03.26.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:19:07 -0700 (PDT)
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
Subject: [PATCH net v6] net: use skb_header_pointer() for TCPv4 GSO frag_off
Date: Thu, 26 Mar 2026 20:18:13 +0800
Message-Id: <20260326121813.457049-1-yss2813483011xxl@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <willemdebruijn.kernel.1a9f35039caab@gmail.com>
References: <willemdebruijn.kernel.1a9f35039caab@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272019-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: E03EE3351AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reported a KMSAN uninit-value warning in gso_features_check()
called from netif_skb_features() [1].

gso_features_check() reads iph->frag_off to decide whether to clear
mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
can rely on skb header offsets that are not always safe for direct
dereference on packets injected from PF_PACKET paths.

Use skb_header_pointer() for the TCPv4 frag_off check so the header read
is robust whether data is already linear or needs copying.

This also removes the SKB_GSO_DODGY special casing: skb_header_pointer()
already fast-paths linear data, so a separate direct-access path is not
needed.

[1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407

Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1a9f35039caab@gmail.com/
Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
---
v6:
 - Use skb_header_pointer() for both DODGY and non-DODGY TCPv4 GSO
   packets in gso_features_check().
 - Drop the SKB_GSO_DODGY special-casing for IPv4 header access.

v5: https://lore.kernel.org/netdev/20260320141459.9691-1-yss2813483011xxl@gmail.com/
v4: https://lore.kernel.org/netdev/20260319005421.14908-1-yss2813483011xxl@gmail.com/
v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/

 net/core/dev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..8a15ca67cfed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3805,10 +3805,16 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * segmentation-offloads.rst).
 	 */
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
-		struct iphdr *iph = skb->encapsulation ?
-				    inner_ip_hdr(skb) : ip_hdr(skb);
+		const struct iphdr *iph;
+		struct iphdr _iph;
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		int nhoff = skb->encapsulation ?
+			    skb_inner_network_offset(skb) :
+			    skb_network_offset(skb);
+
+		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
+
+		if (!iph || !(iph->frag_off & htons(IP_DF)))
 			features &= ~dev->mangleid_features;
 	}
 
-- 
2.34.1


