Return-Path: <netdev+bounces-231361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0DBF7E8E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93FF18A0C09
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98634C157;
	Tue, 21 Oct 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne9DUyQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CA3112B4
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067934; cv=none; b=UnZrMmR4ct56IBkxuUb1wGUJMhHznC6XxDF29DuuvSAfxJTvlJ7OkhS1E4djassGRk1lqerdAysw4LEeSBmWSn+049urXmLm7FXKIvhvhFDTRnfDU5ib7XH1KFCh5DP4MvJF0MVJR8ay7GyvEnu3VQ8Dkfw2bRj4CQCMNYUjFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067934; c=relaxed/simple;
	bh=Z6X3mqZcPYraf2DVQKy1+mGtHY5lO4bJYnXE5CeEFvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaFMg0KMiBJR5h0HrpgMSjHjXn2WQlBi9CMAHsteYBQJduASA/Lrchwcfr2okgW9kpk1vfc7hpiPXTghEh74XdDuANNrnTNQ2xOJcgkX64l1AFRST3QDDsRGaCAyceHE/lHJDCcmcxwrkSFgRdOhDiPvZYtchvOfwP3zk7TMU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne9DUyQi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290c2b6a6c2so53729775ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067931; x=1761672731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=Ne9DUyQi6jQQJwWvr4DrlTjDDf1bFrIXEOf1fa225G4PlaxZmJZWTVQJngmFQ6GDpN
         BUa6Z6RPQHPTecOOxP5BSLVNvS7rRSljLdFMMbqHjG4u/x/Dg+WiFQQjmIqFPfGJwLgV
         4D4SO3XuuwAn+8zu1a5j86P5ea287pVTUbMWfntenWAuj6ESrPj7SIJOzlu3jyKgFcMn
         Yh7jQo0wfvYUdwNvDwHG0shHbi/+S3AQ6sVkMLaAD/n+UY8c9mAWxWjDuuIqhYvpyAu1
         TQmunr7oCRfmwvE6ghPBcnmmuFjtQxf2lSmkYNZFEkFFeI0oyRrZlVzNn/Ko53d8jE5P
         eG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067931; x=1761672731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=UNtQm2MfhKd54Tg47STFsIEAZzidwncOYTzQNBVyk18pd7QKsprlXAjQJIXF7XtlqG
         D8okAtv8PAGq7A24ZfbCa7VIPu8KFuP3eaB4t2ievDYyJrml2U0dcss19BgAubv7Yyok
         xNFUMRCZWvkB4MZfD9Srwr7ttNlJP2K/cQ4bqGbGjErNHNXKRPs98vd9ejAGxcVr+l7S
         VF/EtVvM2kZ/1HXYOqjwepW82Tg13s3VkIIAz8/XSg9Xssmn2qj4Ae8raa8iVkYUs+/m
         mvzJxCRl5NHhvWvWyO2+opEljmKOPZv3ETM4pX615EVw5rsDbTpZXqNnr3V335UFh6gS
         s/oQ==
X-Gm-Message-State: AOJu0YwW5+W6q9bXIqxWZ4KxUUQi5U3V412GO6H82Wt/K+rtD4ZYb1v4
	9kdI1HYnOz59l9dGhzImS5MLoQalE3aom4bzVtVsuK5KMSDptblPYCYxvV07ewG3kOE=
X-Gm-Gg: ASbGncsgxma2NXa3W0WRpYC+FYtzxUMQKSBli7j7klVde8bR3Dkc/pENQxjLnzicscr
	6JKfw91i6azjgz5VKYA29/dq4dvfkPTzt/TIVoVSsR66gjf1J+Hw2Pac4aprU5sZYJ08UBTmWY/
	Ni2ILyDkeWDg+pMF9935Fra/kQiCxGPhN+VU7xRyx2xAXbF3/E8SatTM1fTbuuJ4U+Dx89NWs/p
	r7LmUm8wunHRvWjfcPoaI0V+a1sPa6qwRvYD88t732QNO71CrWQKNJ4A2yf4oT59KKNoEvlzdyI
	xznW/REoZdu1/XQ/076WFa0kXAWlrZtP/87FXlD0qxhpdPnzkXDWBma87W8KQdmaqP243yUgsxp
	aspXzCwspYr4SSh9zMJfFrQcFrPXBva12P4u/9IsEHRVFhN/rmDhRfFdNrWR+gVN1f4hTd77fmK
	PYFFOzSd61Gk420A==
X-Google-Smtp-Source: AGHT+IHBTh8hb/ic48yiyeOWMvVLJaZLWfjl5/Ft3cSUM4e+h+FFQOTWZmBhfmoXN8HdMJnPfxcabQ==
X-Received: by 2002:a17:902:c950:b0:292:fc65:3584 with SMTP id d9443c01a7336-292fc6538acmr13530505ad.50.1761067930650;
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b346aasm10941006a12.20.2025.10.21.10.32.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v2 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Wed, 22 Oct 2025 00:31:59 +0700
Message-Id: <20251021173200.7908-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submitting v2 since while linting v1 I moved the ntp definition in the
wrong place. Apologies for the noise.

Link to v1: https://lore.kernel.org/netdev/20251021135913.5253-1-alessandro.d@gmail.com/T/#u

Changes since v1:
 * advance next_to_process after accessing the current descriptor

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 49d34f3dd8519581030547eb7543a62f9ab5fa08
-- 
2.43.0


