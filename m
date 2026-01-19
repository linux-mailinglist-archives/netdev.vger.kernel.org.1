Return-Path: <netdev+bounces-251055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34CD3A76F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037303063F74
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD7318EDD;
	Mon, 19 Jan 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UxeO3Jbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736B318B9A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823557; cv=none; b=deK0pAq29PmUTmV5eIkBvQA9RlD0NmsiT+PNl+mFvYzB88d5qV79Y9A+x3BU85AyNtWG79VyJIkRDmvCCpE+PuHx5LQo8Sf1lua3SfqpRQB+i7OCB9IdiWaTm08yW1Eca9DGu4UTB97uDQwOfDXsomzS64QGJGS32ms4Ws9Z4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823557; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbI+5nP1qd3OH4aTMJXeW2KN+71RmS/xZTRF/ce7mUAlCi40XfHtRikBrnsbor4Li+SS1Q811sBeGWt06NVbTnQs2HeluoZXrfKwT//US1EXtXSfCzxMAh7K8Jym7bDTw61xLVcADUwYbbctBO7kAU8zI016osQVGPNlaK6NTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UxeO3Jbq; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-81ea900c5dfso339168b3a.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823555; x=1769428355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=j+nYF6kD8eBzvvBDOg1+TgWdqfYBjOU/QzxXrCMOr8b24LdI6nLOWTdGRHzjX7OKcu
         lihQV6ZTYnuMaiXibgnGlTXKcDxfOkFpmrTAl84J32GX4YZ2IVDDWOP0AD4s6G5EhWO5
         +5iMdSS4yllJ+B4qGvC5cM/AAEA80XAZeGdMa8jhiYlu59/O+bTv/43PqFL+aCc3dPeM
         IQ5RATTuTMCfSAkmuu7bBXmFlztzU9JZXSRD8vbLYLCD+/JUgtToXKEQQTQPvT/+s5mg
         SZUdeJuytrQAj+vGw6ff6CktHZk/He0o3L12cBp5DU531dRC6usAv37jznSqRLmw9AC+
         dlAA==
X-Forwarded-Encrypted: i=1; AJvYcCXKV0kMM/6H8mY5Yq2X+/CPfrA8X5B2RYa32PSADFlciJRWLygW60lGiRyuGHnppCUIMB2FEXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzncOhd81XgfRi4yBnh5tb8Yn4OsIMWZpj1gEz5s1nGjd6SYBTL
	5otgaeySFI7bOaWIaJdpI+/7qwUdSM7qL0T1TMAqXf6QXk4522fPjQWcokrluS6HcO8kfmInnWP
	Jnt5QS2rP/e4xwm3ml+zZx7EwIlcz7bu0HISxWG+tRod3iVzzmANQXl7o1JfzXbJ1Z4hmNje8jW
	ykbhdgkuZ3JJDWXjSjzGVoM3B/J/yP0sv9fNDSo3eVvJKgN/8EeohG7ERivFyp48BUnFLsWZnMe
	4CGFjpRXyvWfmQwmgahsGcuvKp5AJs=
X-Gm-Gg: AY/fxX6TIpVCWUre8294VdvtyEBAQEaHv9+nep7zrCDzMlAX7CaDarbU3fZ39thkKIH
	5A8/JYxOWNckmf3k8dzP3OE7XkljhrtDwbZJM2oQM9WXC8BvWEjTs+urzwpirm+Vkva4/lyTR8i
	MhVZ0AyChlf8xWW45tf65iRUWw0NTAI6aWpOwTGY0g4wdpC6ocua8ct0OdzSmi3/4bhd0Egi40z
	I+Y0xBpp7RRzedL5bq6TbPXXs+1BMCYqdkX0IH5jcTiYmmeKptUjctNOaxorJHZTsnfiBJYVKwi
	xsAiSce1Me+jzJ52jnIVjd/jsQNCWiYt8bJV8dFg7/1mU0ZUtXK/+VMV3G4z3Sg8VBIXZYd6uW+
	Y02J5AgU+AywXaMnfJ+K5PxjBtEwLdNRlsyquM8agmTgYiWAkeLJwng+syohmU7DNeBDEoWzvzR
	GEITrB4LllGyVwXSlvrWpORbJSQsdh5OCEpWvXpaXfuAcaYPE6I8Z5rxOCaGxxvD9V
X-Received: by 2002:a05:6a20:12c5:b0:35d:fce2:cb28 with SMTP id adf61e73a8af0-38dfe9ca3e3mr8072028637.8.1768823555562;
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c5edf2bfb6esm487225a12.8.2026.01.19.03.52.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c536c9d2f7so160905385a.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823554; x=1769428354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=UxeO3JbqnbXagaa7QFNEcZf0J3D1OxQh+2fttI5wqB4e5O1Z+VhtirxwdO6BOHHDSS
         4dy36JY+NXKgQ8vLaZirHMzge6FfSOUIGoStnbud/vY0o4eQveDCtwGlCOB6BjhUI6CT
         HnuvTQ9o7BPZfgAm6TCJSnHZ5vCb5Mi0FSRao=
X-Forwarded-Encrypted: i=1; AJvYcCW8aDb9XyLo3Oc+IP0kOVt7bJDOagzotQl1SlnX5JUhJfNdwLJBNoOZqMm8ERdaghCGaQM1Nfc=@vger.kernel.org
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146997485a.2.1768823554188;
        Mon, 19 Jan 2026 03:52:34 -0800 (PST)
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146994885a.2.1768823553648;
        Mon, 19 Jan 2026 03:52:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 11:49:08 +0000
Message-ID: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


