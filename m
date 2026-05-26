Return-Path: <netdev+bounces-291662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKJRJfJ8FWoQWAcAu9opvQ
	(envelope-from <netdev+bounces-291662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:58:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A035D4856
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3FB0305CB95
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB083E0C6D;
	Tue, 26 May 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3yBcS1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A33E0C55
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792939; cv=none; b=ajzKxWSoIbYRPP84X7r9bnRWoF8KZtHeKFSfF0yN11fcRYFKfUCcLd1hb5ycl1bCOagNtBgCVKVnnvkaj8v1uXzYyrdp4hL6EY4QT2rW47fcIJEY/f5NLYsJUT/jkU4Z2kNqFBYs/6d7a1DUmTgN8Hg2Cpn8IvEpYIhkFezaPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792939; c=relaxed/simple;
	bh=2gcbO38M93ZmH0puGdXgvr6IhGL+3COtsKvQNkKoWhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnsgzAUEmAC8DWksMF/Iloc+bhQzcln/XBDW/Pj3deiuYvBrXdg46VFOmr3W8LCoFJxO30jyjPIlWChQs9eMubIYyAd8pLvnlcw7QtCqpvGsgJyBVuLpK8ls7M017Y7sgdAPNgaHTagZjXbXI62obpTCIs8Hm+ZNydMQqQM0TUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3yBcS1T; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2b788a98557so66562455ad.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792938; x=1780397738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjNiDxS5X0RGSoGHt/9B156+vYFsy8VcDqwbQDLpwrw=;
        b=k3yBcS1TNBWWjDCVaghR38X2Sl5wiUHWUP6EyjkdPvDjtdQpc+bo9c7jS7n8ejWipv
         ReB9/G3nopSGPoQzu6liA4lQ692hS70vHfVW469c5f1WIDtM9AbM+dI82fI996rNSrIG
         3uEhYbpzTiaN0j9iEdnW07J25RjLHDsosAZRXjYg7fdMKDpQBMTfx17VvDGAcs5U3xRX
         lIT0pk59CL39ZkAGxnBuAmvw1nVnA0akiYy2FEVRDF2TpgnP4bdrAYS13R50OJ/BID3O
         Yk8ZbUynK2adCwM7n8JAhp/tMAc2SrLgINpcCdsztsJSWNI6qQyMRTDMCWQ1VNvl5LAs
         afZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792938; x=1780397738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjNiDxS5X0RGSoGHt/9B156+vYFsy8VcDqwbQDLpwrw=;
        b=qVfC9uz4GgWvrofP50+fcEYRUwPjkS669BIANqWQ/oZzEc3A8f0LfIXOkY8pII/SSn
         eOEIve6dy1wz4tIxyx8RHDXTEqk7Lb9XGc3XOv1PmP6fw0LOj4wrruCwU2dNh5r4p4Yp
         i+cB/AnOfFKSSX2vKymjBOpQ6paudeq0VdtMYVMxBoX7L73mlqGGA27IUe/DEzYqU0Gp
         XNWcESJ48XNLukpFPNUuqxCMgyIdXkFL2mGjrS/AWtQ2c/cz2GCn2R/Cg5aEsPEOgg10
         /BpKu6PLU9FGPocoBznq3O9WNV2493rkaO1vCCF6ltdtUcnFhG39sg5nRCXm2+HLBdq6
         EOBw==
X-Gm-Message-State: AOJu0YxdgPJUVaW4ckUwYHlFmZ5m3tFW5BgKfS6BCD/kd5TtejZyo4CE
	2szNG/V1W668B1b5smRaVTCL4J7sSkdALxpt8obstqh4qn0lrx8OhJqc1RkghbyKgT43exvx
X-Gm-Gg: Acq92OEL0xiaT9rI90CEXeD4+/HVlYSzeWQq5RjSKDm5pGDajrvCsbnrxZgo4mXP029
	c995KLVX2MSsfSxwgrvEbwmKzJTaeZEGWzgl47mQoY9hs+AWNnoVCh2QuvD+GfUOOptl5t8bu+l
	paX8MYGZOIuzuqExEJxlv4c3ahbq3TsCl5R4Rl3NUpFy8OZm+kLcQX4kZkOXSKZQnNnOe3sz7ti
	WeTSSA3BO8+PM5IjQkkWWcZ8K7tNE3f6jILMEOCAPcgj8n+Xnj8QwYyoUsstGcqI+hoLjivDyKJ
	6gWA1MqfnaDCyGs9oTp9SKc7nsBs9FWr3zzEXqBL/XGf63SAJMycsokoyM04Ry1Okl/T2bi6J9Y
	CVhKZU0lpJOZTuUoiulq75LzzjCkUquBDhIE1NwxYxqouxDkQOi8bT+LRkq0KBBnZ4uw1C4cCol
	IPtApDERrF+BW8MWw7jf1eQUUfL7bSRrH6EMqgouaAGWzXt1rb8sRCSBZDhCw3
X-Received: by 2002:a17:902:e88b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2beb02460fcmr172543195ad.0.1779792937586;
        Tue, 26 May 2026 03:55:37 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695c92sm122619465ad.7.2026.05.26.03.55.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:55:37 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Chas Williams <3chas3@gmail.com>
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] atm: br2684: restore VCC push/pop handlers on close
Date: Tue, 26 May 2026 18:55:23 +0800
Message-ID: <20260526105523.99216-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32A035D4856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

br2684_close_vcc() frees the br2684_vcc and NULLs atmvcc->user_back but
leaves atmvcc->push and atmvcc->pop pointing to br2684_push/br2684_pop.
If the ATM driver completes a TX after the close (delayed pop callback),
br2684_pop() dereferences the NULL user_back at offset 0x18, causing a
kernel panic.

Restore push and pop on the atmvcc before clearing user_back, matching
the pattern in pppoatm_unassign_vcc().

Fixes: 137742cf9738 ("atm/br2684: netif_stop_queue() when atm device busy and netif_wake_queue() when we can send packets again.")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/atm/br2684.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index 6580d67c3456..dbdc31ce5c53 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -412,6 +412,8 @@ static void br2684_close_vcc(struct br2684_vcc *brvcc)
 	write_lock_irq(&devs_lock);
 	list_del(&brvcc->brvccs);
 	write_unlock_irq(&devs_lock);
+	brvcc->atmvcc->push = brvcc->old_push;
+	brvcc->atmvcc->pop = brvcc->old_pop;
 	brvcc->atmvcc->user_back = NULL;	/* what about vcc->recvq ??? */
 	brvcc->atmvcc->release_cb = brvcc->old_release_cb;
 	brvcc->old_push(brvcc->atmvcc, NULL);	/* pass on the bad news */
-- 
2.50.1 (Apple Git-155)


