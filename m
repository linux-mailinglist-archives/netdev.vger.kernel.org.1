Return-Path: <netdev+bounces-266960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAAoLH+Jsml4NQAAu9opvQ
	(envelope-from <netdev+bounces-266960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:38:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F5526FB00
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 447AE300D6A0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B83B9D98;
	Thu, 12 Mar 2026 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN8T9sO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E193B7B93
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308268; cv=none; b=gqgaSW9zi5vSsYC14e5XTnhjHb7T85oqHBD6dIToIxpDlj5meWwSy9NZZ4vM/z82laMaChyByIWIkKMtOBmpGUdcQIe1RXEN9KSk3ompr2/dFjKkKfGLuuI7sxMAOFi4vE/X6Gi1sbwdjXvHH0/n4SVRjermhqbHHd/Z9IHGWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308268; c=relaxed/simple;
	bh=mvv6oxB30rMFszrqgjy8372h+esaWwH8rnqok0C6PLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThdON/nr/qWCWtIAXfSQHcCb0yvyE4Xd8LirI1GRILKZMwMNAjna6318hdsM1FbiwMdfu0MnOeowBvUcBrLGpOSEY/BP2iVozpCqLp6Ttk7bsLdusLGBdqhjrvtFgE/5Bq0cO3XhIkdnJovaqQ+UHwxzeVQ1Q13bhFPwKi7iqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN8T9sO6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-662a1855af2so1225017a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773308263; x=1773913063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0oW3W/hp5cy/K113g2ybbnVjhiUgsa8zlwDOLSWtZk=;
        b=DN8T9sO6m26Y5YQH4nnJZ/6ogeOr8gCtQyIZVMQ3UW9f+GIrYh3/Tcedg5D3LCDC8R
         qdYmK4AxHu7slD2CRxhG+gFb2ujAwDP5i3+08vllQwf1GjD19R6IEl9FO1An/z+mDFYV
         K51As0G3UVFprZHN3zhqRKz0ou48hEFcKtJ6+Ax9JeaX1OGj/h9ym1HyQioj+wn3TymI
         rH+qiFgAfzHr/5FX/oF2injPvyXjNFKLjy8/ADpzdCQAFSwaXOClV8uFU/JD9JWZMhwW
         v+4yfb97UFP9yg4Ai2svhXt8aoTMNdRebOojHmpyDVMWIbLW9I75mLvRjI/d730UCa/Z
         fSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308263; x=1773913063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0oW3W/hp5cy/K113g2ybbnVjhiUgsa8zlwDOLSWtZk=;
        b=nXpcUmEoRd1K+Zb02FD+VJjWB9zBvatBDIvs1b80EOvyGySxZh26iAUjpypLs261KE
         NylblsHnSB7Ex8H8a3vVTrjJFjwTQZcv2GIljoG9M6UT8709o7w+RnzJCcDRhkeRbfdn
         hEfk7EhmmS6mwSAlY3QixgovcPK1/8ErtpwTSA9sZ5Htjvhyk5S1kjXlzWpumvD5i40q
         zaDSdu+423IXtLp2l3SnDjYQva8pSAo0I3XGNdEtj5fAyeR+I7gL8tWSPC8oBHB8rrlo
         raZ9Q3cfkt8WxSUgxseEz/QgisZog4ij7u2KvNjW+OxTWbl/D2wLAD/SinQSS/PVK9Z7
         dxyw==
X-Forwarded-Encrypted: i=1; AJvYcCWKuynk53W9RgL9dsKDBqcf8v8NKmi83/OIDGt3LJzaKt9KcKBpMYW+M0EQLrwfuuN1mR6bTnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vjm4r9gTdfEkKNMbKcNqpQeVLiUGuEf0imrW1qIHYGjgnUYF
	GEwmHiqz49YL8jAOJj8RhywQx25yRnLbwg2EqP0rwWqDVjEmWGSXwujQ
X-Gm-Gg: ATEYQzw/QCHnyON5Y2YYfzCAWJmL3F2brPuIMmMof1QnIxtaYEkaUp+OXZ3kHr/yInA
	Wyu8Kk3GhHbuLKvBLm531YXtGYbXx8jwc9zPhA2nmdKZK2tRaqLQrx/PiASrYEFfrkUguGNUiUj
	h4Hwx2gCMmYWKnRHI7WBmJYT92v7Y8Bf9iDcfW1jlfoG9w2CNglKcPffGzDlm1pvu9CN7dQp072
	DO2xJ3HqhCzkrzIq8ti67AhXI4aPBS+8rweeSl60jx7syW25yjN8+5bw+/DetM9Po87modJ1faC
	PJ/ggpUhNNT6cctr+6nYHFRuT/wb1b9aCAk9wG7YpX/EwFY+E9JezoRP+0dSHdAfdVLC7taz9IN
	4yiUdjHJtfiUFhZqOFhYFky4qy6+/mjZSMPtUdLQruK64dhU/VBEl4WsWVrUoWmOKVbxnE416
X-Received: by 2002:a17:907:1b13:b0:b88:6542:86a0 with SMTP id a640c23a62f3a-b972e59297dmr323289066b.54.1773308262767;
        Thu, 12 Mar 2026 02:37:42 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5560::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de82bc0sm114022666b.27.2026.03.12.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:37:42 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH net-next 2/2] ppp: remove pch->chan NULL checks from tx path
Date: Thu, 12 Mar 2026 17:37:31 +0800
Message-ID: <20260312093732.277254-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312093732.277254-1-dqfext@gmail.com>
References: <20260312093732.277254-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266960-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42F5526FB00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that ppp_disconnect_channel() is called before pch->chan is set to
NULL, a channel from ppp->channels list on the transmit path is
guaranteed to have non-NULL pch->chan.

Remove the pch->chan NULL checks from ppp_push(), ppp_mp_explode(), and
ppp_fill_forward_path(), where a channel is obtained from the list.
Remove the corresponding WRITE/READ_ONCE annotations as they no longer
race.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ppp/ppp_generic.c | 68 +++++++++++------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index ad480b584e25..a036ddfe327b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1602,10 +1602,7 @@ static int ppp_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (!pch)
 		return -ENODEV;
 
-	chan = READ_ONCE(pch->chan);
-	if (!chan)
-		return -ENODEV;
-
+	chan = pch->chan;
 	if (!chan->ops->fill_forward_path)
 		return -EOPNOTSUPP;
 
@@ -1928,9 +1925,9 @@ ppp_push(struct ppp *ppp, struct sk_buff *skb)
 
 		spin_lock(&pch->downl);
 		chan = pch->chan;
-		if (unlikely(!chan || (!chan->direct_xmit && skb_linearize(skb)))) {
-			/* channel got unregistered, or it requires a linear
-			 * skb but linearization failed
+		if (unlikely(!chan->direct_xmit && skb_linearize(skb))) {
+			/* channel requires a linear skb but linearization
+			 * failed
 			 */
 			kfree_skb(skb);
 			ret = 1;
@@ -1991,28 +1988,23 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 	hdrlen = (ppp->flags & SC_MP_XSHORTSEQ)? MPHDRLEN_SSN: MPHDRLEN;
 	i = 0;
 	list_for_each_entry(pch, &ppp->channels, clist) {
-		if (pch->chan) {
-			pch->avail = 1;
-			navail++;
-			pch->speed = pch->chan->speed;
-		} else {
-			pch->avail = 0;
-		}
-		if (pch->avail) {
-			if (skb_queue_empty(&pch->file.xq) ||
-				!pch->had_frag) {
-					if (pch->speed == 0)
-						nzero++;
-					else
-						totspeed += pch->speed;
-
-					pch->avail = 2;
-					++nfree;
-					++totfree;
-				}
-			if (!pch->had_frag && i < ppp->nxchan)
-				ppp->nxchan = i;
+		pch->avail = 1;
+		navail++;
+		pch->speed = pch->chan->speed;
+
+		if (skb_queue_empty(&pch->file.xq) || !pch->had_frag) {
+			if (pch->speed == 0)
+				nzero++;
+			else
+				totspeed += pch->speed;
+
+			pch->avail = 2;
+			++nfree;
+			++totfree;
 		}
+		if (!pch->had_frag && i < ppp->nxchan)
+			ppp->nxchan = i;
+
 		++i;
 	}
 	/*
@@ -2071,25 +2063,7 @@ static int ppp_mp_explode(struct ppp *ppp, struct sk_buff *skb)
 			pch->avail = 1;
 		}
 
-		/* check the channel's mtu and whether it is still attached. */
 		spin_lock(&pch->downl);
-		if (pch->chan == NULL) {
-			/* can't use this channel, it's being deregistered */
-			if (pch->speed == 0)
-				nzero--;
-			else
-				totspeed -= pch->speed;
-
-			spin_unlock(&pch->downl);
-			pch->avail = 0;
-			totlen = len;
-			totfree--;
-			nfree--;
-			if (--navail == 0)
-				break;
-			continue;
-		}
-
 		/*
 		*if the channel speed is not set divide
 		*the packet evenly among the free channels;
@@ -3035,7 +3009,7 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	ppp_disconnect_channel(pch);
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
-	WRITE_ONCE(pch->chan, NULL);
+	pch->chan = NULL;
 	spin_unlock_bh(&pch->downl);
 	up_write(&pch->chan_sem);
 
-- 
2.43.0


