Return-Path: <netdev+bounces-278709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULcdOndM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 682BC401FA9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF6E530A3252
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E43CF691;
	Wed, 15 Apr 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APb6LZ4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FF3CF662
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241682; cv=none; b=NgtNRwMCjECGtmll8lknKsbWlum+9FH4+dnNoEhxUW9Aiibcfnm6kCO+zac0TJJ2wv/jAskc0VMO8sgyQH7fxEW71myOhjcpg8SBFrR80/urwaTCF7wG4g4h0vjfxpkTeVZCQaufbrz8o+JV7RnXNBsX7b++9XslqvBJlFgggt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241682; c=relaxed/simple;
	bh=3mHXFHK70OSdJNBZjn/0H04y2sG+NOM/khAr0FoqF/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epdRfVTQGx3x1GFMqFoo895HgXOTDDHFeKW4wLOrvVPCAIr9SB1vp1n/gYmCk1/fQJMF2pYkhYaAKtNCPWBGhskNqJztYd9fr6mOhtRWsio4TWzbgGHIPh6mZyUVjndRhIPDgnsMolAwdx/BKbBCKz8I62uhwOFQC3de20ADETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APb6LZ4w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aae146b604so46597445ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241681; x=1776846481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/MNUs3KKL19o802zzgTmKKF9qbiyfFCqHVSPcscCsI=;
        b=APb6LZ4w5RKHfIsjLq8LkFXNk05ocAbHa1dmSH1M2n/RU96BZzbg9DHvt7aJOAymng
         jXlKtP5/aegT+f1r62idIdD+qhxzTttAz51xlm3ThZFkE/arQP8sRmBAaxXGz5vh6lJC
         ILl7kq/jc/ltTsLfpK0AA/Wwjm5xHbSjUaj0Es4LXlPP46RVRBvA2EpDhYJty5k5hCyq
         PDd0iE8mlLlzGZrp4bxJ/uVqa5UtqeuVwp6csN4zM7kqQdYmQfdwuDQz/8g7Wj7XdBOY
         aXlTJ3zeLai69jEtzoQ7z4j7qwjZFrnMv8NAlX5IDIaMS8fQAMLA6pRKNcC08UtI7pLy
         KLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241681; x=1776846481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/MNUs3KKL19o802zzgTmKKF9qbiyfFCqHVSPcscCsI=;
        b=QTLJwkfDK9JOahKVMyUSjwrzzR49/9SlXxKCbLlGULJRzOeN/2Pc6oCW3vz7n/iEVc
         yR+HRashCPDD/qlp8uHQJPUjUWf7fSx9f9p13y7zNip7jExKSgduLpNuoldxcn38lsic
         pYgw4xVgQGrWY4SKN8QLQ5DIPKPlIt2GTCv/NFAiFfIGPdPjTFsN1wjDIOmLEv6TbGKb
         SoKqMjn1KwJZlZdaidHdKk8kNiKWrCDUPr8Z1HHH7MUY1X+yee5w3QF+iitxB8QdBINz
         kSnyofykkJLERXyqhgyxcVE+7ZwDrDLv0c3iybuKpr1/3owZl4v3I2/VSM4RyKeEZgws
         fjFA==
X-Forwarded-Encrypted: i=1; AFNElJ/LER/zkzc+WZGbmPQrwLg+qYAnCw2MWg2YPl5Dj32cP1Bk9sjR+EoLtA9/vcNWkEj0ST/Qtpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eZKkR3TZ7V449NL4NkYnwMrEAgnw8acLZXjncCJeh1bv6yGm
	kA8WjVPgprGRzLqiiqJqVlwqXYOAJjDd3mFubdXMmg6EKMKKcQtLxrzKpUqo/4YWAqFTSQ==
X-Gm-Gg: AeBDiesYg+gGGC7De9lfT51qAVC4rYeEM8jpWexi1jTswshLFCEbyH3igtoyvR+qLap
	/mViC4yQLJf67xjs576RxIeL8HT5Ct9YLdwQnf0O6o46r3yqq0EuEwscHn1pOF/EKq229YlRUTX
	RcebO2ADDJhIqLrDjhpDQaNKwyEtvvl5adQSp7jonKR4SPvil2fxjgOrYS+GtFwTEX49UIzZ0yU
	i2Xs5IrHLrFb356camWxu/es4FyIwTum0wDolZVz77lM8S9F/OO/nwHJeie0nET4XFa3va0mPen
	cJzcyKK1OH8GOPNlScXPvb4K17Qrs/DQeYpzVLKBtU3ZhRlBo7TkNPa0pKugbUxdxFS2Euzc6QY
	4CreHG27bjZKHxD2D1DQHputCokepTtpOvPH8BmFz2YbXIxa6Dz2vVe3OkQZWDBvVMuFioIS+yv
	GddWMtmfuHKhGex6yHuxG64N4Xg+TvqRXvT8+Oaf7bYYC/YrI54O/OPjuecL+EDvAslSTwdaHnr
	gXwh+dc
X-Received: by 2002:a17:903:3def:b0:2b0:cb96:9815 with SMTP id d9443c01a7336-2b2d5a90324mr153302545ad.43.1776241680653;
        Wed, 15 Apr 2026 01:28:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:59 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 09/14] xsk: extend xskq_cons_read_desc_batch to count nb_pkts
Date: Wed, 15 Apr 2026 16:26:49 +0800
Message-Id: <20260415082654.21026-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278709-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 682BC401FA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add a new parameter nb_pkts to count how many packets are needed
practically by copy mode with the help of XDP_PKT_CONTD option.

Add descs to provide a way to pass xs->desc_cache to store the
descriptors for copy mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index ec08d9c102b1..354f6fe86893 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -263,12 +263,12 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	parsed->mb = xp_mb_desc(desc);
 }
 
-static inline
-u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+static inline u32
+__xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			    struct xdp_desc *descs, u32 max, u32 *nb_pkts,
+			    u32 max_segs)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
 	u32 total_descs = 0, nr_frags = 0;
 
 	/* track first entry, if stumble upon *any* invalid descriptor, rewind
@@ -288,9 +288,11 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		if (likely(!parsed.mb)) {
 			total_descs += (nr_frags + 1);
 			nr_frags = 0;
+			if (nb_pkts)
+				(*nb_pkts)++;
 		} else {
 			nr_frags++;
-			if (nr_frags == pool->xdp_zc_max_segs) {
+			if (nr_frags == max_segs) {
 				nr_frags = 0;
 				break;
 			}
@@ -304,6 +306,14 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 	return total_descs;
 }
 
+static inline u32
+xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
+			  u32 max)
+{
+	return __xskq_cons_read_desc_batch(q, pool, pool->tx_descs, max,
+					   NULL, pool->xdp_zc_max_segs);
+}
+
 /* Functions for consumers */
 
 static inline void __xskq_cons_release(struct xsk_queue *q)
-- 
2.41.3


