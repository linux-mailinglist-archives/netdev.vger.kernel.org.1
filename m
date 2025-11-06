Return-Path: <netdev+bounces-236498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968EC3D3F2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC604E5DEC
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18478351FCA;
	Thu,  6 Nov 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcSuY0Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C434CFA6
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457320; cv=none; b=Hw0AjvX4puRkTkagJTvy8JAmR+p8UB2UG9dwtQSBQlWjJuoGbHvkj0bescmOeBWRogyigX+Ok8z/pOo4K7JN5RbelMlSFZ2py9YgIMibWS+rXAV8P2IJV09MXCcvBHhsDgaL35bQ7Sb+WKCxkK0zuHZNLh4fa8q6m5urO6zFEhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457320; c=relaxed/simple;
	bh=5FI0IkQm6myrpbP8yVqdkn6nt1ygJomCbomTQtpmXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epDQm/YG9SHg1gxkbpLDK9OArD8Nq46mArvXojp1szBTUZpEj41wmHPW3NlNMi/Q97z3vbXY157AGBahplRzM4M9qr5oM+hASAfm4lDyUFwKz4ZR7IE4hJm+Z24Y5kyqi5b6uLBKydrxClqk06dQkTl5tkIMYmhVp0Q+UqXmNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcSuY0Kv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so2869a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457318; x=1763062118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=bcSuY0KvGVN2+arn4a3CjE+tbYNNFG1sD7tQwv8+hYKAr14cZF16RZ+8biloVmz2fw
         fiMhuxK9uvT+CLOpRl8iw62j5cgRRLtbrq8h1izxju4UtIUqLkGrKZitqdxiN8RP/l5g
         xJAeetaVAOom4jXJ8IP09Vwb8HNeexWRV67GVeg5+3k9dEWtFqABC6HFpmU+pjQjLult
         92pcuje88Z3QF1W7yWxEAUTgMD1wPiJOH2uvipqSrNAYk6fWeIDvKfVrk4btV/PsV/fP
         KynUBwgVdc2Mvt78AZXoz/RALPZGwGPmIUGbZ1bigQiA2fa7tStQUrznvywmeJPedz0H
         BgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457318; x=1763062118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=LR1sVIRc5iXQhUkK52+VgmCRoeeA8NAULRdaklDxyvxMb8EPXAG8GgVNdxQRCFapt2
         LqwhDqcUhHb6HLAgaz9pNOjuI6qaaRgJaeOGRYa2YuQT+a2Sl32LSRcJKwMbdBUGYbHy
         XGWrhgfwK1FZivUuER3j0NhL1nVDLxj5ApxbfBi+z/+3DAKfBViTfa/7mD2FjkW2ktSK
         m3GhGX9TCqEb6lWNNwl/HWerTE+PIKRPQRqUQCa87ZkEQP9W6bjw5jLPa/yk4KHoxUuh
         PEbmb+fZ1eeZ+rQH7a/2tPiuTaUR2G/FfaexpjnMcpWLS31kc1IXKrEFDBabey/OAqwP
         b2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMnconZoRGASjKciJYW9PYWCL1guOG4zFaAcatjXal7Ja0+0GWFq6gI4vRPC+50ce2AQD+Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4FuCtMuyBKEn05A9lVlgvsqXiNcOEU/J3uecMs8pCE3+JmLO
	xZNNlQibImufUnPTo6mHmTTuYIA9sWBMvk1GVyFjKTToAkoGN766kXcu
X-Gm-Gg: ASbGnctiedWRYpJ7B/9DhyTQve1nul3UgY1kgKnL1k5+yE71wFvO1vFW2qxKrqAs2v4
	u6MBy+42KvHCJ1keYLxIqKOmEIuPRp0Wuj68hnHsyBLq9DIxfhfHkuzPu9qWRK837BBi+cJYDhw
	I1rAzBBGNCb3HMY1cPdI3R1MYz8s0JGu8jE/Qcyw7X+awKQf6//QFBVUSfzrFc9RkE4szpNN7tO
	vMmj79gu2UYzlr3ZC7AYuVa8tvw9pkICy8JdpUCZ2m37n4SmI/TAHcwA63LSdA8YWn2Qz3+Qc2c
	SqhHqIU1qPESeJvrzUhXLmhqxtBhX2EXucDMurHYNflBljbXeJvMzrAov6qMPkN0EoD5eeEVlM9
	sO8qJbR6+L5fAlIj2TqY6vqtMHucow1a8Et3BPHGRhWttZtOJTfNatXL75PwCVIw9Mm0v24yZRw
	GIGKgAD1zd/CcxAaR85vKuOdzJteU5dDECU/MkGq3ang==
X-Google-Smtp-Source: AGHT+IGvyt/J+mRIlP7wDwLyYUFozm585qUU/+U8wKdGfZXJuM/V4hzwm0ca6tnKePGfbJK0qRSMLQ==
X-Received: by 2002:a17:903:11cd:b0:27a:186f:53ec with SMTP id d9443c01a7336-297c0481612mr3853765ad.9.1762457317780;
        Thu, 06 Nov 2025 11:28:37 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:fe91:a1ef:9f13:366a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d66dsm36286685ad.37.2025.11.06.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:28:37 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com
Cc: vnranganath.20@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] net: sched: initialize struct tc_ife to fix kernel-infoleak
Date: Fri,  7 Nov 2025 00:58:19 +0530
Message-ID: <20251106192822.12117-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series addresses the uninitialization of the struct which has 
2 btes of padding. And copying this uninitialized data to userspace
can leak info from kernel memory.

This sereies ensure all members and padding are cleared prior to 
begin copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v3:
- updated the commit messages and subject.
- corrected the code misisng ";" in v2
- Link to v2: https://lore.kernel.org/r/20251101-infoleak-v2-0-01a501d41c09@gmail.com 

Changes in v2:
- removed memset(&t, 0, sizeof(t)) from previous patch.
- added the new patch series to address the issue.
- Link to v1: https://lore.kernel.org/r/20251031-infoleak-v1-1-9f7250ee33aa@gmail.com

Ranganath V N (2):
  net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
  net: sched: act_ife: initialize struct tc_ife to fix KMSAN
    kernel-infoleak

 net/sched/act_connmark.c | 12 +++++++-----
 net/sched/act_ife.c      | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.43.0


