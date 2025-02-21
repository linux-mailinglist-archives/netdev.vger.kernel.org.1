Return-Path: <netdev+bounces-168428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B85A3F040
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A081117F088
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCC2036E3;
	Fri, 21 Feb 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YC5LJdQA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941D200136
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130175; cv=none; b=Sd7BS9BfPG3MaUQsoHjiug7plZGFW4YYJfI4MK/8j6z5g2UcxmkJsbr1nrTcT5Gixa1BXpO99Z8k1nYA/6W4UB65cMX4XvWd0vkkfd3CvYNdMoOLaxdF2tKn8lPZ7n9FH58dRlv9S0Bkdmn00PX5W4HirF/5EELBx4BDze6ARso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130175; c=relaxed/simple;
	bh=dwqQ8axOzrVIZKuT8nsCXpDIbeRqR8E1aQ+bx//aUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ak77V3C12E0saGtenk6+J/2P0OFl3l6CxWZgctQeJ5nrlVoPQBX1Tr2l9CqyF3a4Os2mYTgDtMgrIecd+kSgBqpNgObGEDAo9ZqrbORoGC/Z25OppYCbjgPePNs15DxN9xobJvRA1sq6ahs1gqptlp+neO38/cQ3f2Hkog3lgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YC5LJdQA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so3466541a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740130171; x=1740734971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+pe1zKHG38o4fj70O5to/QT/d7+CbHMoiYeNNxFCh8=;
        b=YC5LJdQAfjpTKL1tZw1Alu6YAlqtBR+4Thgni9ljSFm/ppHIrUAaFw4slOg84vDeIs
         mONF2KcLVULxNjlv2KsF43J4jNgHt+4bsO/IsYTpcFL1pXpoUuQ/AzUQMYw6L1v38L5w
         jyHt4YG+gM3RyCj2olGEgNt/65dfxSYss3iWR6yoMaQzw6qMUpb+d8i7wiQN4zwcVf5A
         1OFhcHZihkqOMVN9cJZv5uOeT4sGWN5kbE1TVOLcBv5UTft8Ir3Qlb2M9sv0BnvoV7mi
         Ug16areg13j2cS1W7RZVa6wjjcajEND6w5ZKoiuyJE0dv5jda45dTxp7UrHPpXVk31Bx
         kABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130171; x=1740734971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+pe1zKHG38o4fj70O5to/QT/d7+CbHMoiYeNNxFCh8=;
        b=hw4ujK04FXeD4+Zvo/HcMc7g+hZdb357Zqhkikp+BSNQzU8aWDnMGM4WuGVDsjWJ3h
         3qFPtF2iSsZjtIJcd8R0l9NASff3VAK/KEdF+1hLUCxLKv+Rsbrx2dsi166yIQ8K1cG4
         NYJWge0G1gc9AiJE3BiIz3khtfD+dsfu21cyOaEzu8NsJiQoo5+wHRaLZorQkt5Bvu9a
         BPzQGe9IiWshL/haVamXdyVAb4AK8Rkp48Gra9ab1g91ujON7StDE+XDElIAFhAs+/5z
         KeR2E65/Q5GdPrc18nDjFZv62GJFDmMngPLWG9g7MRDptHr4GOXR/jdZ0P1pV/IkpNcr
         kaUQ==
X-Gm-Message-State: AOJu0YwfCShvqT5j4DH67lSnGFQAWW6H4QUmF09xB/LdDj2qxKR6Aco0
	nd/lCmiYmnSF64mW3fwZJ+B0RdYJyiiN33/BEUhtP1zXUe4/JVS/C7i58VXkgSrxjNWrSLLbk4U
	evWoqNw==
X-Gm-Gg: ASbGncsNVBhxhq7nez14ZiCQuCs3KwMC5q/LA/JAjqFMplZjIinbKJXKlk5FyAi4oHL
	ffER3uL7qKidqpBHut/gT/wRA8PasXk2Lpqasq0nMhOUup5oZTf0iA5/Fgp7VvC7c6UfJXKyuGD
	W4mHDAYV265Qzjv7WTAs+7hn7nVJDD8As8ssBNsrog77terwgNQyoO6F5M0CodBadgq9hfYdFqp
	vsCZ4TDtZ+vS5WikbpOzsFTDXonUWFnjDzkYj8SYg6x4QGWb/zPmBVkAdDN4gQ0PHvf1u2WgOrO
	lMTwk921EMIR3nDiOC4SJz65q2sF
X-Google-Smtp-Source: AGHT+IE2wklY0BCAo7KjMdUCilJj+Yug2DJLIYgL8ZWYGLsIhI7qJyXvXO4KQTFKk6qnth7twGl6ZA==
X-Received: by 2002:a05:6402:3496:b0:5e0:815d:4df2 with SMTP id 4fb4d7f45d1cf-5e0b6fe567amr2127569a12.0.1740130171192;
        Fri, 21 Feb 2025 01:29:31 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b5415sm13272161a12.4.2025.02.21.01.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:29:30 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org
Cc: mkoutny@suse.com,
	mkubecek@suse.cz,
	Davide Benini <davide.benini@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] ss: Tone down cgroup path resolution
Date: Fri, 21 Feb 2025 10:29:25 +0100
Message-ID: <20250221092927.701552-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v1 (https://lore.kernel.org/r/20250210141103.44270-1-mkoutny@suse.com)
- notice about 'unreachable' in commit message
- add README.devel clarification

Michal Koutný (2):
  ss: Tone down cgroup path resolution
  README.devel: clarify patch rules

 README.devel | 2 ++
 lib/fs.c     | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.48.1


