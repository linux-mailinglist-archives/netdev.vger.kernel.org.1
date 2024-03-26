Return-Path: <netdev+bounces-81892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA488B887
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F364B2E3492
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7041292E8;
	Tue, 26 Mar 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxyR8Us9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE68128381
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423829; cv=none; b=qVWA0zFlljmQmL1UXtManEudfsjvDggSR9Gx2rMUaKMFjdS16jgtD7SKpNdSoOYzia5Xf8VLUuOLssZRwr2PiDXNj3/AijZZyCvzlGYCOJz7ozgBkHsdV458Rlwa/4PU8mWcZ/DhIuKkXAZ3DHVPvvulINZKFbp4UudYFbWXKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423829; c=relaxed/simple;
	bh=GO9Bi1wFuxZ0JKZOfZEoYVEb2v5ZwyPeqUxWOY9JwwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsCIX2AunctWeidiIcHbQZ8iE0E/g/zDrG8PIsVMiXz3PLcP7pi8MlFUGEBfCFpOPKdeshgj7khfzYoKwE11X3rCvEmEJfBDwLWAsmAtVtZlyIOisbRh68OuJTYY0DHhWfAZJoQwVGpviWywIkwor4T71EytE+ovGYkDqTM5EXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxyR8Us9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2829277a12.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711423827; x=1712028627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=FxyR8Us9Qh9lnli03be+0+IhIxbUVw3VrhsfP7PG8E2u90qWxBH1ADeGFzEvqSGyhf
         ZjYwbk1f+W8QBO73eTv3wvHfIfu6fYRBMzdLJRof4zbZL0IWo1ev6EfJerkN2KPBPy1u
         ufMFeE9MRZ9uouf06USoNGM8TF+Ka0QoNuJoWpbp6dj+qDb0LPC1YMrl3EGp+NED/qNI
         81ZW8w6WRuuayL8+woPgG3E8xTGbApId9q0qgToa66312ZaK8CRmDUdH/RS0/a4T0/bf
         OsgR1TcBssapI3c+I9oOxYLg1V4wZxEpG9A2d+7NahZn67GplWVGI5CHtbgMeAi7+xrL
         hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711423827; x=1712028627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=wiH3Bw4C2wijcEdtLrftZB4MljVEK9CEyIDUh1w7LRkGFUMVfJVFP2ffbZcuxNYLtn
         52UwxYfMZ1n7GR8gYDMqRrUPyQH3q71Osswj+tYRZj9rD73G4tDuR9N0KuWzicLfGPJs
         aI6CL6/wsU7XWxqDXPIjQOHblkMNus8TsAFZ9ErydyXzLUJlip5b/qJT+ISdkl0E9wEl
         W0BkWgrtL9TpnHp88RVO0KwqgD29XiDlRvUAHzu+bpym4tlk0I4ynL29HlHdKMB8DA6a
         oEVZ9LgeuL1b51+7hDG3uEmcvIUOujxGdzO6XUswhPGNQW1rxkYCAntxxeDr/86c8LiM
         Ffaw==
X-Gm-Message-State: AOJu0YwScnWlJWg4USVsnFjuxS+F/Cga9lRYP2LqvJeJRjfnCJCmXDaz
	cNU9bviY/KBvAvtwCSkm1/wAfwA5EsSzz9GpIOPpMuTicnt0Xhtf/8YZcWwczgYO0A==
X-Google-Smtp-Source: AGHT+IEtZTd3C0j1aZXV517o/Zse7cmUfxiFgFT2UjkdewDoa4uyY6Djfo1PT5ILtUPbac/duhOeZA==
X-Received: by 2002:a05:6a20:1581:b0:1a3:a79b:490a with SMTP id h1-20020a056a20158100b001a3a79b490amr1809213pzj.60.1711423826800;
        Mon, 25 Mar 2024 20:30:26 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902654d00b001dd99fe365dsm5676310pln.42.2024.03.25.20.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:30:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/4] net: team: rename team to team_core for linking
Date: Tue, 26 Mar 2024 11:30:02 +0800
Message-ID: <20240326033005.2072622-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326033005.2072622-1-liuhangbin@gmail.com>
References: <20240326033005.2072622-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with commit 08d323234d10 ("net: fou: rename the source for linking"),
We'll need to link two objects together to form the team module.
This means the source can't be called team, the build system expects
team.o to be the combined object.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/Makefile                | 1 +
 drivers/net/team/{team.c => team_core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/net/team/{team.c => team_core.c} (100%)

diff --git a/drivers/net/team/Makefile b/drivers/net/team/Makefile
index f582d81a5091..244db32c1060 100644
--- a/drivers/net/team/Makefile
+++ b/drivers/net/team/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the network team driver
 #
 
+team-y:= team_core.o
 obj-$(CONFIG_NET_TEAM) += team.o
 obj-$(CONFIG_NET_TEAM_MODE_BROADCAST) += team_mode_broadcast.o
 obj-$(CONFIG_NET_TEAM_MODE_ROUNDROBIN) += team_mode_roundrobin.o
diff --git a/drivers/net/team/team.c b/drivers/net/team/team_core.c
similarity index 100%
rename from drivers/net/team/team.c
rename to drivers/net/team/team_core.c
-- 
2.43.0


