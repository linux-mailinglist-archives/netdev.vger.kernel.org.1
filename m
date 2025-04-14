Return-Path: <netdev+bounces-182013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98770A8752B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E38316A503
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E961714B2;
	Mon, 14 Apr 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5xGVMCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4414F117
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592969; cv=none; b=mEokMb6jatWPaxnrvBvXzIkeCBmE7NJVfnCXkf+NT6a0tfyuj2N2AciPSXnlxoe2IdzENTAti6M5jL1899U7HX7AyQJwd2wHVNq2H66932nCrKX2btIs6PAzZMkOrX7TRASRhUnhrSP5sXotsoxgwLhSk3TBEIamG0pBIdEPQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592969; c=relaxed/simple;
	bh=nlpm6ZOeAuvYmxEPwBipXmD8meC9EQVuE9dX0c+ps/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxNHraUpqTOs89tZx/FNYYiNg8iNiqJd1m+16Q1uNPnZbVtmWjbf5xx6BDX2oXExboH4JZm7T5UzRBKw6tQxOtvw8OMyISmNPGJMDT6IDVDi71azXfzuzvpGjYFJLntjAhj+z0+oI4/J5rHGdx73YoQrFBmgk9VZsRbQjN5T1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5xGVMCo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso3246538a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744592967; x=1745197767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYUtDZHL43fMnZUmCBiw9wW0hkSCwL/BRK5ugWxpzg4=;
        b=m5xGVMCo1MHveW2SrdXac0KKh8aj4vatyI0suObl2JqTP3GMHKyg1dEqE0hhSlsLAR
         flLwM/52HscyW8VK7PHI3PEP5YEAIiH41FBQTlcYl9bcWN29qrMfZn3JxO2MO4mkOInB
         PikL2xNYXGbhL24cOQNy/aHnbB7wHS2VtpIy2x7hijtZTKTM4/vOD7bEnMcxgLNxR6or
         NYPo8JXbP9Y015FSC0W845ZayFUT38g2Ej69HRD6PuVSGEtvBkdpr3za3gQTQ5wrnW+y
         oko34T9iDsb/2ch4MnIkgm4UwPtLG+2GOdzl7ofeJv5GTn+Ckjp3cvOiIdzVGABM+4KT
         gMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744592967; x=1745197767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYUtDZHL43fMnZUmCBiw9wW0hkSCwL/BRK5ugWxpzg4=;
        b=F+8WfQCwC/ZLZZd1J1P+orW5BkBXBUMGVW2Bw8eAhtNJdPPnAqnToORYT4BAwkAChR
         J/UHKIn8Jr4D8q5QiAt5Vwugdfxm5MnHUJuY43dZT6teOulaX2+ceB2gmfdj6a+Wm1Wu
         1gxGjoWiL/bOoOz139leChzxHeYzjqum5z7aGs4AvGp3SNg1dv5LPU+l1DHvLu4M9ikr
         hIz7NvqVbdrj6F79cz4W4jazo4mWCN2ZSjkyRzBMMLXZIeOAl/k6fqR1BR8260LJgotu
         TMEr0BDqmNF5Nt4CwOsp9ZONZ2phtroufwD+eI0D+laxlZ6eelNq3jq7t0sKsp0/1aq7
         YwJg==
X-Gm-Message-State: AOJu0YzaNdWZtevBAOHuU9Pbbj9rsntXfMrVn2RDnZ5dXE76w+K2rHzi
	15Nw/HRdULN2lPxr1V8RrzgiNJO1fup+SqpNY+xYJwFFtdhdUeymB8MXIw==
X-Gm-Gg: ASbGncsJo1Hbtv7Twu+o6eC5u2NGliHieWby1FIM3kndyWto3Rn+Bb5tjT1IzTtJXUH
	ySMfeU2WGYJNRntLohFsMOGOr2nNCrILQ7qvChbFVS5qjUZdFZicSnDBGJGZmv1a6k52TIylqhT
	U/cDy0paYk2wVuNXEFOGAALlQELSsUD6F/Wjxm896+f1/LTLVHMfIFSNovfPVainb2uApCbgFfl
	eUvay5IoIDM7aTTDmtwh5evarvaib8QWbKldCfFg+hhyOAqfmxJald2csa9kgsEBG0aIXZBDsEL
	lam+zgGsQ44qA1I1m+Hvs3y8Bu4dxxBjw2EQwFmfxBirXc8SvIzLDdG5
X-Google-Smtp-Source: AGHT+IGDAjxH2XAu/TNkbGyuTnklKlPw2N8Wn/ngI8sE2kzU/cViYw0BOvwrDiYsMTeHVLj22xl+2A==
X-Received: by 2002:a17:90b:2752:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-308237ba788mr14340651a91.27.1744592966716;
        Sun, 13 Apr 2025 18:09:26 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:66ce:777d:b821:87fc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm10158183a91.31.2025.04.13.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 18:09:26 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>
Subject: [Patch net 1/2] net_sched: hfsc: Fix a UAF vulnerability in class handling
Date: Sun, 13 Apr 2025 18:09:11 -0700
Message-Id: <20250414010912.816413-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a Use-After-Free vulnerability in the HFSC qdisc class
handling. The issue occurs due to a time-of-check/time-of-use condition
in hfsc_change_class() when working with certain child qdiscs like netem
or codel.

The vulnerability works as follows:
1. hfsc_change_class() checks if a class has packets (q.qlen != 0)
2. It then calls qdisc_peek_len(), which for certain qdiscs (e.g.,
   codel, netem) might drop packets and empty the queue
3. The code continues assuming the queue is still non-empty, adding
   the class to vttree
4. This breaks HFSC scheduler assumptions that only non-empty classes
   are in vttree
5. Later, when the class is destroyed, this can lead to a Use-After-Free

The fix adds a second queue length check after qdisc_peek_len() to verify
the queue wasn't emptied.

Fixes: 21f4d5cc25ec ("net_sched/hfsc: fix curve activation in hfsc_change_class()")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index ce5045eea065..b368ac0595d5 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -961,6 +961,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -991,9 +992,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
-- 
2.34.1


