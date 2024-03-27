Return-Path: <netdev+bounces-82415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB688DAEB
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBEEB235F5
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FEC4779F;
	Wed, 27 Mar 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De8ngcmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E2481D8
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533819; cv=none; b=rjM2UuQUne6lLbY1VbsJJji8lDiTMiK3Ye26O30YivYNlbW1zJwoR4spUIFsDTERKjpaUAqxPr1Pk9N87/63Khj/uo9+3BcDL64n5wtYH896SpOB0aQdUpMGCYl9lCNkhChlWSgk/3Op7rB2/5HnTR2DMdkNXXqpYoRPiOutXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533819; c=relaxed/simple;
	bh=GO9Bi1wFuxZ0JKZOfZEoYVEb2v5ZwyPeqUxWOY9JwwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev3OPAEmNyajRh9WSMhT8yxpFV1awH6uSU6PgkKsMhbybNw2u30U6PU7jueAKluM6ogGozKlYu2XWvyI1kIfENHZQRkNsJFA+I4G0fWuAUKQzJWJBWVTiU3xet+kYebxsZFR/aq8ynXbJonwPub+2d0wfkUaxsRqKt3xBSA5vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De8ngcmz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so4412265b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533817; x=1712138617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=De8ngcmzHPmIK9oybOr+VOhN0lEbf/R+su/LUA7KB/8ZKcM6kWb6UjQ87STUuWm1K6
         wwGOisZqjlREaHRl7T9Xx681JvFOTl80ZnBjap20InyH5ODt5qgkNx66zdW4Y42oNSbo
         SNCUdhO2kGpUZMDD7vxF179o0xVeRMZ9qctd/CG5VunGLyti/uqZ4ffOHYrxQZswQeTB
         wQEgCCUwCcjYwIQ4f3DfFYrEtgBD4EJXkTxokJrGcq5s0GhDXJwANsr6APg7e0t2OP6A
         TAdardI+mGvMqmR5jz+eDzy0FA0GsXC5+tqFcWaT51i2HSwt3BkjoTN7Io9NcBUvZUNJ
         9alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533817; x=1712138617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta6lFKix1FeG0oCBnTR9Exq62WqMGnwL+ghoDg1tdM8=;
        b=O4KtWECWHowTW/JDxN1gNny7F46ffsGBE43/Vkmsxh7tKWJNT/blXuK4TwArnuFs/S
         x6JAvMoINSQqgUdcD9tjZLWC7syUqHhGksB8RTJgpN7VCYmEKyXmKdowf6HVKPUzZP9Y
         vpue6EMgurrZ0e26ipOIfqvzsu7GilZaZuL1MX8ppVVfXUS5Bh98jsdM96FBFRF481HB
         vEJrBzIP/knBdlyzZz6SqtgaNovYZ/6ATzxkXSCuAdaBx4h0XR9lcLfjHq4mHQci94wk
         Z7nHF0GbKsQFRGm9C53lgM5KclbWFse5UmEFBIp+5xRiP+eAy06WADXjuBCZmn8RmbNG
         98PA==
X-Gm-Message-State: AOJu0YyIjUVdfoB02zkNd7giWeZkQWyO/S77eYa7Md+aboUsVoE6+2fI
	uxIjwM6c/KJcYP6lIJHW4jJUxaYBA9dD9hpy+6gHu7NWqMxlVKlTBIDKMfcYgb6GK7Fx
X-Google-Smtp-Source: AGHT+IEDDz9/lvmsiHu8BHCKDI3B5/ezgHtcyl2P1bjzC+X0nIO+Ums7LJpz/mV83CdsTNUNQwS8sw==
X-Received: by 2002:a05:6a00:1814:b0:6ea:b690:f146 with SMTP id y20-20020a056a00181400b006eab690f146mr2808247pfa.15.1711533816997;
        Wed, 27 Mar 2024 03:03:36 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm7478913pfn.138.2024.03.27.03.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:03:36 -0700 (PDT)
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
Subject: [PATCHv2 net-next 2/4] net: team: rename team to team_core for linking
Date: Wed, 27 Mar 2024 18:03:16 +0800
Message-ID: <20240327100318.1085067-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327100318.1085067-1-liuhangbin@gmail.com>
References: <20240327100318.1085067-1-liuhangbin@gmail.com>
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


