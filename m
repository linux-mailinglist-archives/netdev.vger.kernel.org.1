Return-Path: <netdev+bounces-268892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DycMvpKummWTwIAu9opvQ
	(envelope-from <netdev+bounces-268892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:49:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA22B68E1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A243057E8B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA136894C;
	Wed, 18 Mar 2026 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbT3p7Iw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313A4A02
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816539; cv=none; b=KWYCdddgoLI1qebk6UugwriwwvjBjCHYyYRcbTUNzLpYoC8/+2/tw8GtaSLZckXNi8pQAHRVclsdNPQebZe1K2cXrGJDgzbMYW4KHx7zr0vO+L1e4tunj/eS9fqe/pLtDz8c8hRAyQ0HjIRUFaRQxaZaDZ+EcobMxKwSTN5pmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816539; c=relaxed/simple;
	bh=Qj1QkGketFTLM6FhMiga1uXkk9E+QIhjnrMOjTAq2ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PazMCrC2L4/AtJlynEV1jx1eWbG9p6PEFioOSita6ZaiWDpYRLBsmruLOX5hwx++9PCSzaE63Ba9WV9b/4ctRGQ1vFr5dHr5Y0ISRpwRMgTrFSJ9P/5OP5nculu/C7JZzICrrIsjHygEo2MLN9iLMOzDjO4FuS43ZsNFPOynw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbT3p7Iw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b05761bec1so2623225ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773816537; x=1774421337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=YbT3p7IwofRR4B71gvIvW4EYvPkkHFAZKnxd325boEmEBFUL/kF+aumEjLzU6wTeVi
         J4wJ1MlBDsN9y0A5iwvtdSJ6WmSy1fgLfWvB1FcCA0c8hEajcFDp+KLme9ciDi1sDa9W
         wnj86JwfQquO42V7nWuafBoYJRLPlLE19MJG+CpRN+HqUHcmgB/T5sXbp7udQ4DobENp
         Xa/wkzsznNFEVBZm/0k3L+K7vwji1nj4hG6WTj/rGJcx2MP6k5mzBQJ72ADF+v+qddPj
         LNIAfnrimodMiZ9rkFX+rnCICM9/mmWOs4sgDi4BOs8m1Dd4IA6kPtUJd0AnV3ZN6DcP
         1olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816537; x=1774421337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVGV5+seuNEQDXpmjKxLE/WMiIEl6PzK6G5vJJXXZA=;
        b=qxGECOqrknN94QbopnZh7T9bMYe+By/pXNKwTVKAqO3bofBwpRpaz/JN5zQsEZPHsJ
         wMOvXDzvJpFTFqhkrATDWOJcQyRiEftX85yERmHdq7L04OF7o59xRm9o95QotmxNRWF+
         IoL3QudZhPxTZw5mRWseZz6mPO+XfUKI2IyCFrseeLvqhmOXBopulqIFdrYQZRBiyoPp
         sjfWAeC5pNdNTvbJeMypswVTn+nZm1V6yFuYOIKDndVcgFKWL9c97uwIlXbEEq0cgfcD
         rWj+AmeGJT9BbVRrraCUX0pta9xdtFg7b5pYTkPrGcNJEiFO1hZwThYfhpDqadk/zOL+
         WWDw==
X-Gm-Message-State: AOJu0YxbNZQpGUMHM//f//atHHfzodJQTKainZ/NhGGtCjgDoAAKhmBS
	Sk6jaO1HYeq9IRHRN6+FS2vljTb1XmHF2YShmeAjTo6Z2DGLr2PDKhqq
X-Gm-Gg: ATEYQzxxqbMM8VG7aXLGzHRmd09Dj8rjEImxLTHuqx2byxZ/yzdYq4dXW1s2svU5cKB
	sst3OTs05mzvqMH0Gc/Trrhe3B32g9UyYbXD1Oug9ygwWzWeAOvfCRchEXEeAWjfo1Q7DBg5ZXR
	RN06mIMUllTqNwwa+BdCS8PqABZ7u743ko3ftoSbMg/gSpiTSEN7/SKIRSt/SK7UkYLyj3BqqC0
	/4ikSY8Eao95sL1SJ9LGndZ0tUg9aK98ZT2nM6QjtVaGu9Uab+Nz6wIO64W6lFUn2mLKRuzq8jj
	6qLz0GddWT/cyaqIxgyVfoQ7QMUEBpyylGVD0aZK2ARQhdccJ0dIAMAZ5c4d32J49FXPWqdEUoT
	MHXYCZ6HK+jyWSNxS1Ic9XxESQ10kP5VKnZTf7hyECcjgWuy6kgHTjHuaZR5WNN+4MPqksa9iEg
	fcIyjv/vaeNyU+Mo7FuYTnbMToaGzdc1K/
X-Received: by 2002:a17:903:94b:b0:2ae:5a38:96bb with SMTP id d9443c01a7336-2b06357efd3mr61873795ad.2.1773816536783;
        Tue, 17 Mar 2026 23:48:56 -0700 (PDT)
Received: from localhost.localdomain ([101.5.20.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6315dcsm19262845ad.80.2026.03.17.23.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:48:55 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net] net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer
Date: Wed, 18 Mar 2026 14:48:47 +0800
Message-ID: <20260318064847.23341-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268892-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FFA22B68E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smc_rx_splice() allocates one smc_spd_priv per pipe_buffer and stores
the pointer in pipe_buffer.private.  The pipe_buf_operations for these
buffers used .get = generic_pipe_buf_get, which only increments the page
reference count when tee(2) duplicates a pipe buffer.  The smc_spd_priv
pointer itself was not handled, so after tee() both the original and the
cloned pipe_buffer share the same smc_spd_priv *.

When both pipes are subsequently released, smc_rx_pipe_buf_release() is
called twice against the same object:

  1st call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [correct]
  2nd call: kfree(priv)  sock_put(sk)  smc_rx_update_cons()  [UAF]

KASAN reports a slab-use-after-free in smc_rx_pipe_buf_release(), which
then escalates to a NULL-pointer dereference and kernel panic via
smc_rx_update_consumer() when it chases the freed priv->smc pointer:

  BUG: KASAN: slab-use-after-free in smc_rx_pipe_buf_release+0x78/0x2a0
  Read of size 8 at addr ffff888004a45740 by task smc_splice_tee_/74
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xce/0x650
   kasan_report+0xc6/0x100
   smc_rx_pipe_buf_release+0x78/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

  BUG: kernel NULL pointer dereference, address: 0000000000000020
  RIP: 0010:smc_rx_update_consumer+0x8d/0x350
  Call Trace:
   <TASK>
   smc_rx_pipe_buf_release+0x121/0x2a0
   free_pipe_info+0xd4/0x130
   pipe_release+0x142/0x160
   __fput+0x1c6/0x490
   __x64_sys_close+0x4f/0x90
   do_syscall_64+0xa6/0x1a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  Kernel panic - not syncing: Fatal exception

Beyond the memory-safety problem, duplicating an SMC splice buffer is
semantically questionable: smc_rx_update_cons() would advance the
consumer cursor twice for the same data, corrupting receive-window
accounting.  A refcount on smc_spd_priv could fix the double-free, but
the cursor-accounting issue would still need to be addressed separately.

The .get callback is invoked by both tee(2) and splice_pipe_to_pipe()
for partial transfers; both will now return -EFAULT.  Users who need
to duplicate SMC socket data must use a copy-based read path.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/smc/smc_rx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index d833e36f7fd4..c1d9b923938d 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -135,9 +135,16 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	sock_put(sk);
 }
 
+static bool smc_rx_pipe_buf_get(struct pipe_inode_info *pipe,
+				struct pipe_buffer *buf)
+{
+	/* smc_spd_priv in buf->private is not shareable; disallow cloning. */
+	return false;
+}
+
 static const struct pipe_buf_operations smc_pipe_ops = {
 	.release = smc_rx_pipe_buf_release,
-	.get = generic_pipe_buf_get
+	.get	 = smc_rx_pipe_buf_get,
 };
 
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
-- 
2.43.0


