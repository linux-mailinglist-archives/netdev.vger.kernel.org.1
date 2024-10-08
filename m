Return-Path: <netdev+bounces-133098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE6994959
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29805B21750
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CE1DF72F;
	Tue,  8 Oct 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcA6uv8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCB1DEFE3;
	Tue,  8 Oct 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390109; cv=none; b=UiSz0/FhAuEzYaIQTFwBaYKIgnMQJkjTr34BKTwjy3UvF9fLOExbrZP0L/DaBHncHQikc3LplKDXJv9PlFRV4Aol9NO2RrsFLfkMoLRmncoRNabpKvzdM3JbdjZJmQEK9DAUCWMPCK3ge3Pl36IA5yxPKnc1PVEvepbOYLNrlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390109; c=relaxed/simple;
	bh=8Zz5iuoVqBXnmoZlhFKseth5oPQfJGWObYTalDjnUO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZjD4tszg3WkkoKgmcjhpkHYEhjqbnWa42IFkwdYCWijHAzyeYNVJGdyOvsEebIC6D65k42uTCUiOjkR0YHn60mqbtJQx1jtgANTyEMlt5+A0l7LPi2v9tan1H1UQACleD3riaSZq8diLxTobQ8a+oIb8K7JaJvOC7M8cBGucTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcA6uv8Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b78ee6298so35403595ad.2;
        Tue, 08 Oct 2024 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390107; x=1728994907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6n89iXl4sTBj8JpdXByeqakCgAbxJDxDCdZbwUfb1A=;
        b=dcA6uv8Y50Uh8rttLDdrMkY6/VMy/ujjNnMueXJZAiRWWCHxym3Oh3pvCRKfCopdil
         o8mDsG2EqafLeBKsQAEFJHUsozF0qtjwkXVmPHY67TtVOfUwu0qFpXZ/BDiW7mIHeCSg
         FCvRl+YM+kg2zUJYXVjMvTiLlYva/dkWd+q0GTcxIZ0hPuPNe35UG6i7q8+4bJPyes3q
         BScCOiwIQ1PRnXB7ykKBcVYgNrNtX6/dhSci7FQgS0BsNxdq2jYXLu7Lc8rpEk98ezRt
         VfuMXxCYpDmSND8GMgwjK1EJkCe9PPPg61dxeZR1O2g0r775vz9319oZc1r44Y7sCrWI
         cziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390107; x=1728994907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6n89iXl4sTBj8JpdXByeqakCgAbxJDxDCdZbwUfb1A=;
        b=MEUzSkzUxqa8HUMuF94xmWwMuuKnWo5IRBLbD6N/6UZaap/ovnlk6DnRrgFxj+Hzet
         e0HYtCVr8SqmmKN/6v9kpzNst7xVDr/edDaJPifo0Osv8UhaQA/TRD5p0SYbsPUXo9Jj
         7KjwTGJ3eWnRYEs+SLpBzJt0SSsorUelopnfClGUb1YWTTVrnA6uptWoPmhsADYSa15k
         wdQpSbaFxkj3P7MIJzuEIJyG48auHQ0xtue5CcfISObfvC9R14ogXb6kFh2xFtpB+GY6
         CSP3N/jAHkKCbD6sIsAJPwl4xGPASIkvBAGeRB9Sg+Q5uBa/evcOTm6JNEcZCFOGznuU
         p7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+k7iZCQttHWqhzmfWnv4qthXfB3i3wRbBfsQ3WQt7zMwSskqSjPKz6LbadDi4tJSn7NQ7Tp4WQVdzw2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2O7u6GwfSFdSsWcp3pO5zf+af11gtkAZPvqE6//UCjjm1kBA
	E+e1niRo/Vm7sZIgJy0zeGSOn0OgRXmBdAGOTOk3m8WxzPZnONHZJWU+1QKx
X-Google-Smtp-Source: AGHT+IGXaAVBfD0w5JeLhbNwr/MIxhyRI6PLBppgFJpDpzXw9LujtG8/vAz6aQtg7XvbTbQS7+wFEw==
X-Received: by 2002:a17:903:4408:b0:20b:775f:506d with SMTP id d9443c01a7336-20bfe0412d0mr194566305ad.34.1728390107313;
        Tue, 08 Oct 2024 05:21:47 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393175csm54737175ad.140.2024.10.08.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:21:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/2] netdevsim: copy addresses for both in and out paths
Date: Tue,  8 Oct 2024 12:21:34 +0000
Message-ID: <20241008122134.4343-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008122134.4343-1-liuhangbin@gmail.com>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code only copies the address for the in path, leaving the out
path address set to 0. This patch corrects the issue by copying the addresses
for both the in and out paths. Before this patch:

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] tx ipaddr=0.0.0.0
  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] rx ipaddr=192.168.0.1
  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

After this patch:

  = cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] tx ipaddr=192.168.0.2
  sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] rx ipaddr=192.168.0.1
  sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/netdevsim/ipsec.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 102b0955eb04..88187dd4eb2d 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -180,14 +180,13 @@ static int nsim_ipsec_add_sa(struct xfrm_state *xs,
 		return ret;
 	}
 
-	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN) {
+	if (xs->xso.dir == XFRM_DEV_OFFLOAD_IN)
 		sa.rx = true;
 
-		if (xs->props.family == AF_INET6)
-			memcpy(sa.ipaddr, &xs->id.daddr.a6, 16);
-		else
-			memcpy(&sa.ipaddr[3], &xs->id.daddr.a4, 4);
-	}
+	if (xs->props.family == AF_INET6)
+		memcpy(sa.ipaddr, &xs->id.daddr.a6, 16);
+	else
+		memcpy(&sa.ipaddr[3], &xs->id.daddr.a4, 4);
 
 	/* the preparations worked, so save the info */
 	memcpy(&ipsec->sa[sa_idx], &sa, sizeof(sa));
-- 
2.46.0


