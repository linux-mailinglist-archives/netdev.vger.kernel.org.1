Return-Path: <netdev+bounces-254505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGhfAv+4emkr9gEAu9opvQ
	(envelope-from <netdev+bounces-254505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:33:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBCAACD4
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0839F303EA9D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9973148B7;
	Thu, 29 Jan 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGmsQxXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472792236FA
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650151; cv=none; b=c58rXL7K8kpWTNW2ip3XKo44+qggPM4SaFBt3gpLYfLeD0e+smQbfANKR0IPYz9Yh4MXofVIhRRi43Hja4q6/LdSMn5mkVs6WxTTceYDmozvOHjvge6UbFZsumy4gIr9+hjyKe0PzvYHIv0vbQ0pV11scgmGpCZiOJ26RDcmiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650151; c=relaxed/simple;
	bh=MoBOphXc78MTKLid5zGiMU4m+2RBEI6B8y9JnvhBT0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRVo4iw99SsAHVjqzwRdFGc2iCjGNfeJjQppu8EuuH+NDfBw1d54vlrjZJZTmgbLyeUNVyaE6RH1SLj2l7wCkWb7+4CxCKatb5w94zATP5DVn3N9ZWsQOajC3my/m8FGCuhOWLmNZknKjKnzfK33C6reCGvR/OKcgdXsatrBddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGmsQxXp; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233bc1117fso1099805c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769650148; x=1770254948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fz0HF8QIciQ8W/jFc7CcxIuPePjE9HmoHDdQJI7gnFg=;
        b=bGmsQxXpjC9buvm2ON6Jfd3Re50mmEqwBVKtBNnMBW7fFxwrWkfSN5IfBNM8zeSzRn
         dbkwJZ+A/ikbcBQBFGIMUKMul/W+Y/8fE7nT5rnra/8fUE9sugv44UiuQ52JroRLh6DG
         FTpXPMdq1zPE8mh7ra/fGoEgeEI7hMybrBD5ZZX3pB03L0wPR6410P3Uji3Dp61IMQ5T
         NajZaBJUk1Y52dksS/6hiy+DtAvje3nv1y8c/zn47mKcqvvbIUQb2so6Fio85Wpk82Oj
         t0Me679qXVAD3yiyuY/K/3J1NkBQBljkMAXQqX3HeFR1qEpwB9tJ7adJHptLtD7UlS/L
         EtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769650148; x=1770254948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz0HF8QIciQ8W/jFc7CcxIuPePjE9HmoHDdQJI7gnFg=;
        b=KU4Nw5MVvu71CxK0U0OaKhtfhDAUB+0qsfo48dcMzuDqeh8b0nA3RirhP0rR2KsRcf
         inuHJZ8swSy6YG586/8KNwYalpTx/4uhtsBQ4Pptb5BNH66kyIU7IAQe0GGmBHFANG8W
         UIrTnvXEKrKEchzgUgmb0XCDVcEYRS/EixXEP5I3HJDem2IK7eFo57fNt6iCQkG66d9q
         +okRvNn5aZW0k6RdAZoim0ItDxka86cNoSUdacC1baCaf5B2JVLoRmN/0N/ByNlRszv2
         G1k4HYIzB+hbj82FAuk9Ad5kDTBPnbbs8tvPm8lz7xQ4Vq8nM7ZBgZszx9BQNbGPADIh
         VsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNMOV29ZsIHGUUHt26+aTpq4EUtKKQB4ZpN38ml3ZH4oomRIgm/xFlJT277IDGUUg42/7tQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3xf2eNeV3e2bZ7nK9LkrUtE0nAgyOBFeJ19mTjv9rNEhfhYL
	OrllKIr0L/6YDZgCj9Q3M0i7H/QF3seeL63LYjtmeS5dhtMDKuv9gu38
X-Gm-Gg: AZuq6aJmNh2/fypZ9vTWKvnjjn59f8Or5h0cFMdsGBx0fDd6f0+2GwqPtIx+2x+WKZL
	yA41m7DnaGvwN2x7FUNW/Yjn/GxlKfva4Wn24i4EDsoCHyC6Ww+je0AoiwdulGodwlENrwZLuko
	4uSi93Fwqk/xH98+ee9CnuRbHHIor/M2b4RaMZ/G3sVZs3d8ZHCK5Crc72pRj7jbuMtgGLNpf8A
	iFdM5T5f7H4CEp3+JYSFzZ6Byr3uCIxKDLGPHY2q4WM5Gn4MJ4R7IU6+fmfrqwe1XBzW7pH8rT5
	PRZiPF1LbHxOHdhCyehvUNu4n3KK+i5OpRIDqz+wAn2jNcxM2SxyAPjKnbFdszrRBGxCoBnKgeF
	c+13gm09icERmKWt/AqzgMmM0rNkOir+/0k7alT8cMHBzV7E5BPijteyTdqeUCIg=
X-Received: by 2002:a05:7022:f90:b0:11b:ca88:c4f1 with SMTP id a92af1059eb24-124b1060aa3mr729929c88.20.1769650148153;
        Wed, 28 Jan 2026 17:29:08 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0b:28::4:34a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efd3b8sm4488034c88.17.2026.01.28.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:29:07 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4] ppp: enable TX scatter-gather
Date: Thu, 29 Jan 2026 09:29:02 +0800
Message-ID: <20260129012902.941-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FEBCAACD4
X-Rspamd-Action: no action

PPP channels using chan->direct_xmit prepend the PPP header to a skb and
call dev_queue_xmit() directly. In this mode the skb does not need to be
linear, but the PPP netdevice currently does not advertise
scatter-gather features, causing unnecessary linearization and
preventing GSO.

Enable NETIF_F_SG and NETIF_F_FRAGLIST on PPP devices. In case a linear
buffer is required (PPP compression, multilink, and channels without
direct_xmit), call skb_linearize() explicitly.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v3 -> v4:
 Always expose SG and FRAGLIST, and linearize the skb if necessary.
 - https://lore.kernel.org/linux-ppp/20260123014214.225278-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f9f0f16c41d1..f8814d7be6f1 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1641,6 +1641,8 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_destructor = ppp_dev_priv_destructor;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
+	dev->hw_features = dev->features;
 	netif_keep_dst(dev);
 }
 
@@ -1710,6 +1712,10 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		ppp->xcomp->comp_extra + ppp->dev->hard_header_len;
 	int compressor_skb_size = ppp->dev->mtu +
 		ppp->xcomp->comp_extra + PPP_HDRLEN;
+
+	if (skb_linearize(skb))
+		return NULL;
+
 	new_skb = alloc_skb(new_skb_size, GFP_ATOMIC);
 	if (!new_skb) {
 		if (net_ratelimit())
@@ -1797,6 +1803,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 	case PPP_IP:
 		if (!ppp->vj || (ppp->flags & SC_COMP_TCP) == 0)
 			break;
+
+		if (skb_linearize(skb))
+			goto drop;
+
 		/* try to do VJ TCP header compression */
 		new_skb = alloc_skb(skb->len + ppp->dev->hard_header_len - 2,
 				    GFP_ATOMIC);
@@ -1894,19 +1904,26 @@ ppp_push(struct ppp *ppp)
 	}
 
 	if ((ppp->flags & SC_MULTILINK) == 0) {
+		struct ppp_channel *chan;
 		/* not doing multilink: send it down the first channel */
 		list = list->next;
 		pch = list_entry(list, struct channel, clist);
 
 		spin_lock(&pch->downl);
-		if (pch->chan) {
-			if (pch->chan->ops->start_xmit(pch->chan, skb))
-				ppp->xmit_pending = NULL;
-		} else {
-			/* channel got unregistered */
+		chan = pch->chan;
+		if (unlikely(!chan || (!chan->direct_xmit && skb_linearize(skb)))) {
+			/* channel got unregistered, or it requires a linear
+			 * skb but linearization failed
+			 */
 			kfree_skb(skb);
 			ppp->xmit_pending = NULL;
+			goto out;
 		}
+
+		if (chan->ops->start_xmit(chan, skb))
+			ppp->xmit_pending = NULL;
+
+out:
 		spin_unlock(&pch->downl);
 		return;
 	}
@@ -1991,6 +2008,8 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 		return 0; /* can't take now, leave it in xmit_pending */
 
 	/* Do protocol field compression */
+	if (skb_linearize(skb))
+		goto err_linearize;
 	p = skb->data;
 	len = skb->len;
 	if (*p == 0 && mp_protocol_compress) {
@@ -2149,6 +2168,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 
  noskb:
 	spin_unlock(&pch->downl);
+ err_linearize:
 	if (ppp->debug & 1)
 		netdev_err(ppp->dev, "PPP: no memory (fragment)\n");
 	++ppp->dev->stats.tx_errors;
-- 
2.43.0


