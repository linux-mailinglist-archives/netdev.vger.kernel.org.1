Return-Path: <netdev+bounces-279688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOOuI+Xj5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2CD428226
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C756302D0A1
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD1388E63;
	Mon, 20 Apr 2026 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drnb0lUw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B17388E58
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673726; cv=none; b=pZU69en+S+ZCJW0KIVuD8Sm1AaulfRW1eEbHIiSRQjTzkOf94B0E3kk7+CzvDTHvH9Z+1968ANXoebvq5t6VgwKFbApY26bSahEnWzFDNnF9+MilObSpvXmqPDJw3zb3/AceatwABaYNYhS35v3He1qRwhBPtsw1+KgEbk/GrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673726; c=relaxed/simple;
	bh=wrkHdYhTf4x4809WOQkzFGwlZJzDIyxVtAhg3DDbp1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elZzIZDLoORLvSTpodJjE+YKObB4Rwp4bSxfAUTaTsQP5V0Pq25I/tyPKC/6s6/+0doYZFygYjHjUDSultwhQjLhDHS1oBjfXB9C0euhDWTG939Jwn9tuy8JfX10sOu49wA7D5Ah8E4m24W6WvSVmafHuWtnTUMxtxEA5pRGkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drnb0lUw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso999503a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673725; x=1777278525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG4ZH/amOFQbdJ4PgfMAq4mwRwIpao5txIPTQLeOJII=;
        b=drnb0lUwS9Zn64ww9h3po7ECODnj+rrZSnY4UKtkFv4WPQc8a8g2MxxqQ1gkbk8Yo5
         X4xnOcHfJ0cQ9gn6wj3ptcAimjTXBfxmOHyzsI+EOJQLixgOv9S2cKcRgquEe/52Zdmz
         /2bJhSOYSzyFCRlAcyzvdFfb5hACH7o7g2kCd6ZK5y9AoamxzePVnh7DNaSTTE8DZwGV
         oknfDUEBVHmCgL6+grkUTT/sBNqJjLCYGV5Hux/mowKQ6TmwyvuPB+ksINbbAEqJZ8OS
         MNRK3xPeu6TyPWC8iG5fcf1KCLxsv+KFAPGJOx96kqRLiQ84ZXP5jcLm9/AUr9CigscQ
         lwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673725; x=1777278525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rG4ZH/amOFQbdJ4PgfMAq4mwRwIpao5txIPTQLeOJII=;
        b=s8Gz8a2Aat7jRCaHZwU+HqAAGPeNstXwdEwibzrJelPlMeVKkJflJpy3jHTHMrMCCH
         psmspAXb0P5+GNgg4Y1jgC9SorRam7k5GDt9VsDSLYg/7b4Xt/nBHtDSWRYM7exP2lRy
         hT9tI9Y+7cGJ8fbj8NDW0/m42EjvmdFDp6gIbzUnZPKYqRFEMZYGfhxo+f6iE7ni/j2u
         aOVt+LI6AlcumWg+B6j21AL7gs6+N23+dsEi2TF1JyCah+f3WQiwI1c0hMpdOk8dvrw6
         HXybEIpNhy36f+VQhsn7cR8vYUwoaDftNM5nJ1AqMZNbztaAWjEsDyX/tD4eNmlquGo6
         rlfg==
X-Forwarded-Encrypted: i=1; AFNElJ9tt3KiatIbNcmw6wgZboEEmce/Kn7j4mr4FVFUua4RwJiGWzdgOfk2c4uNW1pUnD5elYPuHV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ93ZzU768+f/6YeiHf8tL4rFn0YtxLY3CAU6mLtUajY6AQnFG
	Qe6DnB44oMt9+VQXW8dfmUFzMde8DOESHFoJOYBjWQkHE/pgazx9Apls
X-Gm-Gg: AeBDieu55uVZ84Endgesxpz5R6SfNWflBV4IoKZvEdTuxA8XJ3t43siaq/L96Yiv7qP
	PeG+4vShpKra1XiH8ZhkH5rNvDTGR+wjp/dbuwKT9B30Cp2uGZcwytqKjq97ruJNWpnVul5pQVN
	6iJp1AT8AG5rzLtVVzJIZGtuquvYJuOXrcgmegnSUAE/9dtZqwSQpCGlDLKfn/cPHy5A15lukDx
	bAp/vMHs5NMduiOqh6ko+6MJVQC7MlajxHDTwwQutdcg3Lqx08NHBgErZ5FE7MIIv122MWZFFTH
	8czmFG5weYCl59piSz/jaP+cVr3PllU9uVHRLp/aAMdVgSyTTYPVbfbnpNOEDP61xit0Pgfk43b
	Betegx+gpIoUfbrOuaER+6l4nrhO4cxOtDZlF7SoXkUHAS6/p93pQFDECTcuRkA6uAKgF980lIO
	nVzmn2UqDKSy8VlFhx5VB0wH3h2sNMUCGG9SF452kOYSyfzdjCNLjDl6usrVfnJdoGiFY3aiq6P
	anTQwQW
X-Received: by 2002:a05:6a20:3d85:b0:39b:989e:6d39 with SMTP id adf61e73a8af0-3a08d8a947dmr14941354637.35.1776673725087;
        Mon, 20 Apr 2026 01:28:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Mon, 20 Apr 2026 16:28:03 +0800
Message-Id: <20260420082805.14844-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 0B2CD428226
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 51f76e9d6ffd..9236ec32b54a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -784,8 +784,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				xsk_drop_untrans_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3


