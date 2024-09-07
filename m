Return-Path: <netdev+bounces-126264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CE97045D
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2A5B21F4D
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A69157488;
	Sat,  7 Sep 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5RMBnHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9325632;
	Sat,  7 Sep 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747711; cv=none; b=JxvyaGxSzi6T8lfZf7aXBfyf4YQcomQwoNs5IJ3d7Nff2JNxx42V6lZYdON94TQTBsnDF2YplmbrXQNQJlgvm0ifaHubRaH4Z9mgTB2u9EOdRBg0X+DXM4ZCKeXI098Nevn6jHwNuTjAdyjOZDQCsQXPOuS76x6coEcR0ZeyWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747711; c=relaxed/simple;
	bh=8kcpUpr1hxQBi8b2gUJnOnytGaOJshcqnipQPIHbhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGNRWupJEwBA+89IuwEQ45+JdVVKaMJU3EvRcM7wVHLalUGh3BYumVg98tj86nfnpEoHmuHAtt2Act3rNN7whL7jG0Jizv2LFV443lH/d9BniiJd2QnIZsXv7c1IB0mqZfOUl0Y9fy+DM6O2HGmQhpZ+WHonNDBxqSav8ErphMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5RMBnHM; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2689e7a941fso1975658fac.3;
        Sat, 07 Sep 2024 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747709; x=1726352509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1BKcLAuwncB4jWy3yTOSrntLdmhF3PJ1M67DrT6Bq4s=;
        b=Q5RMBnHMYvzLSHCS6BABogpS4a6QHV+D95bj64h7N5TmOVwBV3GWZ2CjfKjgESVMtI
         zsY34MV/nJpna64Xu9GS/YMnyuqXMIT3fK4J/IkKiWsaYmA5ZLQNOgCBpYVUXCSqaJG4
         +2rFqyVmLvAjtZA6FdpPO0fVhBfmSSykP4SYN0YvgXuOeQLvTK3SOKNWH9AkaFx65K7b
         eLvd28AKGPiP9O799PqxC8AOy69peyQpiBjuGbTn2U0XfvksSa6FFlKI7v6TIIdlo4yl
         fK0aAG372haplKi4R+5CEPj+QrqkVss5s2sxwZ9fPY5bUWAsG2rUd92jw2Sh0AyTfJKx
         EVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747709; x=1726352509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BKcLAuwncB4jWy3yTOSrntLdmhF3PJ1M67DrT6Bq4s=;
        b=jSmC0Gx9/zL9Nae6wtlxfYemZjWC2rRWqxvCAh2ARLKgSWFldhOJtycsv7ak3UJ1pU
         xuXOaTOlh/gWIjRAQdQbCZxAYKb94WPHEEDcRXnnj30HDF/9hSoPTyG7ipNHXayAhTks
         Ip+YZSmfl1PFxDfUKYaqm/CGapZGzr8fzmAsNlyQbp1SOJu8yRPwE2LzgnzEmzX9CVE/
         23wQhEspGLHj21FTNi9PHzJbhG8I5OVGWnRifCcEFWnD9j5yRdQZzewP9TtNpzkpQ0PJ
         SjdqCTyhNjtQGyAYIh/wfYr9rPoXhsRy2ngAWRCCgwL6/wTmTuiAtD57biO/t66jUGHp
         GI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSveBYJX/zyDTnHpmBYFeZOC9WofEeJ/SF6oUxOquIAGrK9l3Wt3TCRzO8U1ZuvSpnwlzd8iTcTWQ6r10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITecX5WyyBAIyjyIcdt5GrFdPdNTDSJtRr5dJww9eTnsyK2Lj
	9L/0enH61RBf7doM2ox2an1e3eQ9Ta1uCPeks+aAh02lBa8h8WSTXN1koB8R
X-Google-Smtp-Source: AGHT+IF7QJoHrTZ83cll1S9s88dEV/HCAQ/5C1incxaOiVglfa1yczenR5RFOwHBKGdzfF2leHcu1A==
X-Received: by 2002:a05:6870:478f:b0:260:fc35:b37e with SMTP id 586e51a60fabf-27b8301cecemr7835713fac.44.1725747709353;
        Sat, 07 Sep 2024 15:21:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d860a4d202sm1077198a12.85.2024.09.07.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 15:21:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 0/4] net: ibm: emac: modernize modules
Date: Sat,  7 Sep 2024 15:21:43 -0700
Message-ID: <20240907222147.21723-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm and dev_* instead of printk.

Rosen Penev (4):
  net: ibm: emac: tah: use devm and dev_err
  net: ibm: emac: rgmii: use devm and dev_err
  net: ibm: emac: zmii: use devm and dev_err
  net: ibm: emac: mal: use devm and dev_err

 drivers/net/ethernet/ibm/emac/mal.c   | 144 +++++++++++---------------
 drivers/net/ethernet/ibm/emac/rgmii.c |  76 +++++---------
 drivers/net/ethernet/ibm/emac/tah.c   |  60 ++++-------
 drivers/net/ethernet/ibm/emac/zmii.c  |  53 ++++------
 4 files changed, 127 insertions(+), 206 deletions(-)

-- 
2.46.0


