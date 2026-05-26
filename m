Return-Path: <netdev+bounces-291661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aManHw99FWoQWAcAu9opvQ
	(envelope-from <netdev+bounces-291661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:59:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D935F5D486D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB3D306F4A5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527A3DE43D;
	Tue, 26 May 2026 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW+nkjyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E13DDDDF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792824; cv=none; b=EzfpDUO5RNWhed0pgjFRSsiBzfcnD2zCjoqtSnqeBSFvV+0LH5Nz+6Me11Eck3RugzPFTXmjZWhLmWaYS89bk3Qpezupw/jSESkS+2J7b8KNKlH/EFpfGcTvwrILSURpot6r8vAv4J3LYcexNeQm26jXcLSWa5xOwqQYLUfLPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792824; c=relaxed/simple;
	bh=mIS5FfeMLEK5xo19MQvezVYgpgeq7zsYacRy2aECSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rWSOcaHi1hWMZ8RrzJL4WDBs9HVp3g0fyClk+0AbkUsBBlBQ06qCt7FIV5Kjk0aH0wNSDPGXGHen5Zej1Zxj8MEiWvvKR92C6UgIBvZieX6nhVG0JTr7y95v4c2c0sDJpJ/srRqOtyA5Aboz1uOkKOYSrIZ7RcSQ+W/lakrEonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW+nkjyx; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bc763e2ba8so52410625ad.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792823; x=1780397623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iafKChOw/GhPOwNFz8grpDGPqirBO1tdJ3FKqFhithM=;
        b=BW+nkjyxsGn3JD0LZXAL+rnGEujsR67mg/0PWb/EMOagkxMMrnE3Qviud72stioqHd
         VKw4Xz0RCZQ2P40XZl16iQ+lNlBYla2K+5NVvmnAD7/Iz/LbqEpE2RVDn5gUP/GKnl4n
         1zHtXmgqj180W0mQ0vhxkwsp362Jv6ZNgmRLUy/A4oyQynTyDBm8mqmmqC/9e5AfJf/z
         2CUBcQ1HVro4Crt+0zEulr04JGQW4rRw5pQUaoSyXdh5aedZA2kS7cLN9D+79FM4KeHs
         mzWaHv1G2J6RO3lDt1F9k+iixNSTx2R+qFWuiCoz0i45q3TaMIrcjwCyn0ZJFyfyUXbx
         v7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792823; x=1780397623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iafKChOw/GhPOwNFz8grpDGPqirBO1tdJ3FKqFhithM=;
        b=r7IQNaWhT5BDRepfnOhjvPH3esyQEi0ZqHA7IFb7/70NmmmgAo4eIJw/fPQASpHI/x
         jiHy5vShcrGOKhaIGhIASnf0BHW5zXddEz5R5J3HfWgFwuQMD8OhI6c97CRGUosCpPS4
         4BrChjRfXz8QUTQBuTYLUJdG96kTjy2Iykr9F5c8OKFiPm3qKUD9hJti0njxdL6cJ794
         RMHROcs7pYaaiqg/dGgXnxIdrCdXtLg6MrVQMBv6lO0oNuD9OsnRzQfGFdYcEBjmmRJ8
         tuSLH/GZ7zc6ukWopuv6CD8ITcCesoNeE7dWvPgFjPWOvMl51rB4h711Pz+t8h1IuiYc
         1yLA==
X-Gm-Message-State: AOJu0YyloRt4onJhrkKFZVWa//1lifLggY8m6GD8Tj4zbPpGnXwFXQGK
	zK/TElPs9+aNsFmYDEeMlp4mIec5B9OM1WD6liHtT13ZKTWP+ZiihCQ1DvRS7F8wQSdU9cLg
X-Gm-Gg: Acq92OF9PWB2Joc9Q8fB2At4wsKWgi4B6w67bZwXoUjBV/T9CgMnLcIzaU8VGs6Rvn6
	tZAzXwI5Df5qch5wiUxm+tm+8ZuXGmqvD8TWT5o72JtIN6D8MrCy/vIq3Kt127PVFf2/gOyXP6O
	uOYcktFoUoBieSjtpW82W0icvmWxvylJZEUi3Qe0zzv7ZarPap2tsWw2O4PgilPVLMhzmF7Z8PZ
	eAG87nAVCz4JL7cvyHs+/RuM1w0YA+dSLj/okquWf+iYtNKax1krSJ1J9iTxArfMr9YWSSM+/H8
	Jc3vLylba+iHdDlUKsIFSP1dK4rOJrMEeWM+XlTACigkQv+3QjfO/Gvkjv0PybLT/PNNVfAPiaV
	VTofiNUDP823qY8hXFbhyDAFBU6fPaA6FETmn2zKNcMxMJcA1YgrKZ83Z0nrG9QvqWaDNxFiz7D
	0ITy27riQFNjYuWD6/nZkZr+h7dc+tUIndrR8gEovkz6UfODBOvzhjDY8L5SKdS4BM/mybuzywq
	xgqVb+9tQ==
X-Received: by 2002:a17:902:d2ce:b0:2b4:5cea:f619 with SMTP id d9443c01a7336-2beb074f65cmr208279865ad.22.1779792822634;
        Tue, 26 May 2026 03:53:42 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591d102sm118158385ad.81.2026.05.26.03.53.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:53:42 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH xfrm] xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload
Date: Tue, 26 May 2026 18:53:28 +0800
Message-ID: <20260526105328.87078-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291661-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D935F5D486D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__input_process_payload() stores first_skb into xtfs->ra_newskb under
drop_lock when starting partial reassembly, then unlocks and breaks out
of the processing loop. The post-loop check reads xtfs->ra_newskb
without the lock to decide whether first_skb is still owned:

    if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb)

Between spin_unlock and this read, a concurrent CPU running
iptfs_reassem_cont() (or the drop_timer hrtimer) can complete
reassembly, NULL xtfs->ra_newskb, and free the skb. The check then
evaluates first_skb != NULL as true, and pskb_trim/ip_summed/consume_skb
operate on the freed skb — a use-after-free in skbuff_head_cache.

Replace the unlocked read with a local bool that records whether
first_skb was handed to the reassembly state in the current call. The
flag is set after the existing spin_unlock, before the break, using the
pointer equality that is stable at that point (first_skb == skb iff
first_skb was stored in ra_newskb).

Fixes: 3f3339885fb3 ("xfrm: iptfs: add reusing received skb for the tunnel egress packet")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55ba..c5172ac523b8 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -954,6 +954,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	u32 first_iplen, iphlen, iplen, remaining, tail;
 	u32 capturelen;
 	u64 seq;
+	bool first_skb_partial = false;
 
 	xtfs = x->mode_data;
 	net = xs_net(x);
@@ -1161,6 +1162,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 			spin_unlock(&xtfs->drop_lock);
 
+			first_skb_partial = (first_skb == skb);
 			break;
 		}
 
@@ -1172,7 +1174,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		/* this should not happen from the above code */
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
 
-	if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb) {
+	if (first_skb && first_iplen && !defer && !first_skb_partial) {
 		/* first_skb is queued b/c !defer and not partial */
 		if (pskb_trim(first_skb, first_iplen)) {
 			/* error trimming */
-- 
2.50.1 (Apple Git-155)


