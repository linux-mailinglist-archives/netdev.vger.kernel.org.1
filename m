Return-Path: <netdev+bounces-286229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAyDOiPe/2lP/gAAu9opvQ
	(envelope-from <netdev+bounces-286229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE345021CC
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F2033002D1C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142431E5702;
	Sun, 10 May 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgl8A6lS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FA1E1A17
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376223; cv=none; b=btJmCRrHXfna4ZG89vUr4vid9trx8+bLe7o0xZEmxoasJJJYiMdS3XMSWcOt/47ztdYRttTSpOxJi0kqrvOx331aLMk8Ic2w9fD2j6aeN7X5glJNIEFkEVjzrrgml96cShnJMnjfc8S62IzxCXR+PmTMFxH5ajKHtqSh21xotU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376223; c=relaxed/simple;
	bh=iODLSWvYErewxkSJ4DWoizA7FGAtrQRwNwqk/ehR3nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmQs6a3a0aFgA86NrnIuLp/+3ry5drDAVYcrjPRtSi6/d7uJpXZbKbnNOqxy2EXKRDUkFzQfiiGI17NdnwWea9Oc9w6AHSuECxYByi4I8J6DwBvv8jCccCR0Y/Nb6ykeq3ZA0KheNj7mE8sGDhtCaXgmsbYstkRYquZHXRwJpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgl8A6lS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-364f7c42c62so2751799a91.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376221; x=1778981021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKyBJPKDix5Ds6v+uMzeJx1wbcB1pTmVkewQYBnHqcM=;
        b=Bgl8A6lSTdu44sMGAV/a5m3XzfvWaBaupwgCsN3hcwXxs0xg3jqBC78rBFkCy5Bf9B
         AtWbrHoCB+ifbduXvlM6uEJUJknSEfKTZi5RocuD8Dxc8hGvrNliJScsqYU9BQsbsJSK
         zif/SpBRyGFRrJTkbYErmx5DNDxgZbsYQRQ5T1J6IQAbBq8yzxUj7iK0sezL9ooOIb+d
         31M/JMoMYiZ7WGKCy0NHoywIFl/QF6qCT/5v5talfsLY7JwTcSt245FDahO2Dk44/jW8
         kz0M1BCXUeaUBzAltqtt6LCmFlRy03/ToIAUbcXDIDDzTpdTxdLJpI24IfFRP1YzWatO
         foeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376221; x=1778981021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKyBJPKDix5Ds6v+uMzeJx1wbcB1pTmVkewQYBnHqcM=;
        b=nhhnlc8UDBeECS3tfqA8TgMZ/OMPseTv1IWTGwrimV4Xm1W4iA+VTc5mNyYi34vJuq
         4JSt0hYRo33fESiPveGSMy8Dncx7x/nK+oZy+mPIGOaOyT5J8sYfQOwNE2NI2N7EGXK4
         X71GHiRTa44JGeULCAtsGsnhukH1ifGT4NhHoDyWLJGc7Ey0V+YiZHsTCeikXEh5NstL
         A5itSi9ZxOzlqDOsJsetDwGVIPbp/wW3IWE5SQLSnCofnx0o/sQqkmeSIgdK1xApXVOp
         j0atKml/BUXdE26+YacJDunVGOmlNrDVoEJZDP54w1+T+FmPqU7ZKkbMGYvVXjOd3VKr
         AQOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xWbY1fZJb++19bsH29/GV3d+HlGZ2sQGt4rKC5jRsMZ7HYu2qTkyNR9EKYWz5nqj2Aq+39Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXJuMzbvweDVrepIgpD8sRelaSF7FWnFPOYi2/5pJPYz7sRhK
	VlCZcPK163tAiOQ1YjFtaOZzo+Cw13fiBvkGSylNst/HG6VLrg79pk3h
X-Gm-Gg: Acq92OEM4UDlA0p8T1Lhe0SgiyBXyKq7pT7HGonNT+vjCeppIy61W8JM/6osZ7sk4Ca
	vfSdGzFi/gUuhSSArheJVDfuYWK4AJLzxfhfl+9a8b5gB/czGZEvOeCBVRzCCf2+VWPfIKJMhRo
	oeqKgoQGHi968UPPc6GZxXw7RfaE+r5qvhYGatWx8w+x3g4FsTlgQ2XADJJJMskG4F9teqtoeY6
	6ToXW5IAtip1lxgIfQPN44yiPHkaGAaB5P8Oj9fzKrN2eh7PpdqCKHBg7WxVpN2Sr/VXVF0NivI
	HVaNQbhV9208DiZAthpH84H0cSfom0yJO6JYJeMArvtHXQUQ4NbA5+K716nhng8Y/3h9rF0LTcj
	ySoQmcsRg2rxEh46+qyYR57uIoaxeNwcPZEODbai2nhqUqV5VxHPO2qi84SjpTAn0GaWpeNi/24
	7iJABs5h0OikJG5nObZhchO26qfW0qPwqQvwhLVaolDStJ1tTDyPLddHDc4lXk4rwHwIItrrkpW
	Q2M0akZo8DIwyf+0Y++5/Gi+fZE29E=
X-Received: by 2002:a17:902:ef87:b0:2ba:30fb:d777 with SMTP id d9443c01a7336-2ba78b3fce3mr129072165ad.6.1778376221049;
        Sat, 09 May 2026 18:23:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:40 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 3/4] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Sun, 10 May 2026 09:23:09 +0800
Message-Id: <20260510012310.88570-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FE345021CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.906];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
only the current descriptor is released from the TX ring. The remaining
continuation descriptors of the same packet stay in the ring. Since
xs->skb is set to NULL after the drop, the TX loop picks up these
leftover frags and misinterprets each one as the beginning of a new
packet, corrupting the packet stream.

Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
The main TX loop in __xsk_generic_xmit() then handles continuation
descriptors one at a time: each gets a normal CQ reservation (with
backpressure), its address is submitted to the completion queue, and
the descriptor is released from the TX ring. When the last fragment
(without XDP_PKT_CONTD) is processed, the flag is cleared and the
function returns -EOVERFLOW so the next call starts with a fresh
budget for normal packets.

This reuses the existing CQ backpressure and budget mechanisms, so if
the CQ is full the function returns -EAGAIN and userspace drains the
CQ before retrying. Zero buffer leakage, zero packet stream corruption.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..1958d19d9925 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -80,6 +80,7 @@ struct xdp_sock {
 	 * call of __xsk_generic_xmit().
 	 */
 	struct sk_buff *skb;
+	bool drain_cont;
 
 	struct list_head map_list;
 	/* Protects map_list */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 3f1e590c855d..232dd7126905 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xs->tx->invalid_descs++;
 		}
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(desc))
+			xs->drain_cont = true;
 	} else {
 		/* Let application retry */
 		xsk_cq_cancel_locked(xs->pool, 1);
@@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			unsigned long flags;
+			u32 idx;
+
+			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
+			idx = xskq_get_prod(xs->pool->cq);
+			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
+			xskq_prod_submit_n(xs->pool->cq, 1);
+			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
+
+			xs->tx->invalid_descs++;
+			xskq_cons_release(xs->tx);
+			if (!xp_mb_desc(&desc)) {
+				xs->drain_cont = false;
+				err = -EOVERFLOW;
+				goto out;
+			}
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-- 
2.41.3


