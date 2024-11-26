Return-Path: <netdev+bounces-147472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E133B9D9BE5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305A7B23A77
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AA1D7995;
	Tue, 26 Nov 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTe7Jzil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59369137E;
	Tue, 26 Nov 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639915; cv=none; b=tEu/LZFU4jOaOonZiGR1u6vHWSDIqlCedJwoHngQzx2BwK5eab5D45DRWFaF6yuFFlKdqkt2oeFpzlzw4dEQCT9ijFbJ+EzRD9giDu5Eod8VxdqHZygbro2s0OLKIATF4x+BliGEET7o+GJk3EiegDmCIGRMaPXCZH1zsvTzKz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639915; c=relaxed/simple;
	bh=S8GDrZXc8nZDsZx6cSbrbBGt/1GpmYD7+KrEtXeWRX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llhPajCO44A0n1vCTk1H4vxJeBCrJS/fJ+4/yvTSkda2EDnPxi0/jKSuLAlJLg2TL79ONzcde+2trCyCIeAITbuxfIYbUtIpjeJ+wROHRBnmDG5OPzkOOmzyAslfMBllh63dVG+AfdOukHmRbLWy+4AS/7xtITJ9jdHOA1zv6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTe7Jzil; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4af38d1a28fso260310137.1;
        Tue, 26 Nov 2024 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732639913; x=1733244713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/mARhGUKlyx+9RuH/Zb7cWyZB0cXl/qM2bYRbYREDw=;
        b=QTe7JzildrSdJOx3/n5AsXHoqwyeZAMqr1BJ//vQL7q8+v4n0Q/oafgHZZTwDzx5M4
         Ed7+4eVauvV5vHWMR4mDC7vak86pSlKoRLLXTo5S3efOF5Hd22/hzVNadThqr+Vs0hXp
         KqRnierI+wD9+8hrGoBOpuacLer4YzVqVuDAbx3niOi9GYgFRS3xLL6F2Gro8PxFCYqQ
         +Ft9Mriu2Ka+ciH6Hob5YuLpQv+SA4Q6s7OfWorfYaprEhYMXc6GbQ4vRZoW9LZV1nTr
         beFUlPwfodfeN2G/jfXuywrYaEB6yep8y5xRmkbAt5NyJvEgzGMX0iJetEL080JQQdmR
         cOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732639913; x=1733244713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/mARhGUKlyx+9RuH/Zb7cWyZB0cXl/qM2bYRbYREDw=;
        b=VJ3XeWeA1sI0U3ukFEi2lEAfuZ807+SX0QaekiwyK0m8XqQM/PJ15CRRdWC9dEuO0M
         JRhOC+wJCNQChcwM4348toPe8+B/1pW4uKKzAytpoZqmAniysYQvVINXb0e/Gv+yvHFA
         XdK+cYR6P+BDtqyPQneh5aYQFbMiK/RVDR9UZeYIlJygIyv5KRbOedk8vRQO7xDVd4XM
         XAYZLqWP2B8Ya1zBfEAly6jJmvvaoJl6+XG/JJzX3fBgGfQ+kC//kJGfwHIhEkypGwyN
         r8FrBIPW9DBKETH777VkPfpv8B0zoo0ay3fYKxjq7KFWh+RNPZ4YgBUiaHia91vW+NaU
         Vw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH+ivrEZa97cxNPnK1ARMcXRwZUlbWKxQticLxVTRRAfc90r/wtxsreXhUME/Yl8LM5A1/kws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcMlj7rpZ4XHxwNwHfrpGEy5emmD4n+PJu6RvSQjw9oHbSR5p
	CSM+TzQ5APugYmTgLoGT1v+XaNriVxqIocRZYCH8x1qlmiOx4CVUvi4pcA==
X-Gm-Gg: ASbGncu0GOp+vOJB2dnM0kht4+s/eXgcYjGO5/uFljTC1bmSiI5lWXYB8Mz1MhNsbgG
	qhmIbfsdX8lR5vScXSbIBrpzNJi+TXxVsNMdd7Thjhong9Lqm9z2I0sv/7ARluDd4/ef58uZBpG
	mzI8tCErxr80hzlhyoUd688iVvfGRa1Sw6DCwP5I2FjbeqEwbBZ4TbcVZ4pgr/a/feue7wmTq67
	lQTK/6rIfUWaA7M/QFzNCcWI3D+yZ5VICxx4gcIsQ4T3vzGPsdInByfA6iVVJlh4Iq/OW4sBDY1
	F9DBBl2SzPit+2azdSbDuA==
X-Google-Smtp-Source: AGHT+IGCF/CijAQIXGPAdRZf1xutIaAD334E6OMCyv8eqEBC10+/CZI8pR9er8XZEBFLNmn7p5Qeaw==
X-Received: by 2002:a05:6102:cd0:b0:4af:3cb5:e3b4 with SMTP id ada2fe7eead31-4af4488f2eamr98713137.16.1732639913159;
        Tue, 26 Nov 2024 08:51:53 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af357c7272sm430876137.1.2024.11.26.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:51:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-11-26
Date: Tue, 26 Nov 2024 11:51:49 -0500
Message-ID: <20241126165149.899213-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 5dfd7d940094e1a1ec974d90f6d28162d372b56b:

  Merge branch 'bnxt_en-bug-fixes' (2024-11-26 15:29:34 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-11-26

for you to fetch changes up to ed9588554943097bdf09588a8a105fbb058869c5:

  Bluetooth: SCO: remove the redundant sco_conn_put (2024-11-26 11:07:28 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - SCO: remove the redundant sco_conn_put
 - MGMT: Fix slab-use-after-free Read in set_powered_sync
 - MGMT: Fix possible deadlocks

----------------------------------------------------------------
Edward Adam Davis (1):
      Bluetooth: SCO: remove the redundant sco_conn_put

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
      Bluetooth: MGMT: Fix possible deadlocks

 net/bluetooth/mgmt.c | 38 +++++++++++++++++++++++++++-----------
 net/bluetooth/sco.c  |  2 +-
 2 files changed, 28 insertions(+), 12 deletions(-)

