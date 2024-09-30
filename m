Return-Path: <netdev+bounces-130569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27D98ADB1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C580E1F234F4
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6EB1991A5;
	Mon, 30 Sep 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Fe7oDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146153BB21;
	Mon, 30 Sep 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726617; cv=none; b=LpjE4rVrbaNRI05+/1Cce0SB8M8/jTeqHCT4ynNRkw7h7m+rByYLL1AiGkWCc2fnnueUhIb/3+KdcGNvwb1o3fG7CEqLAVcm/Udz7PK+pZfbLFQDBcKji0BYD2xEaBqFQ4MutA97KnvpFdHot3ReNX38WV/yT6bBA93QdGDdcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726617; c=relaxed/simple;
	bh=47I8xfCitENoyApbDJeb8z83ysVQ1fPkC3PWZWQevPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nACpHYCM2JnvSQ+JiGjlhcxzrQsuJ6XGA5bNpBU6PbHxpRnrQgGrvyP13AO1hU8ZbseQV2fHPVOjQv8p5n1zQtJ3x9ylLEgs5BYbz9BinLXqKYjhSo7Z38sb0IQrtV0GWvOV7o2tJXjsF5aOmjcsRSmpbElmU1XNE/nLCmDjShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Fe7oDg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so43982005e9.3;
        Mon, 30 Sep 2024 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727726614; x=1728331414; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fI+zx8QsdFx8s2KuJaXhZ3U2Smejzcc3UCHD/eWxk+0=;
        b=K2Fe7oDg1peK5S0D56OJwfRDRRnBg6W0tnqHIPwnJbXO7pKtMRSCT931lwOWe04YO3
         QM8DSnisDLHPuWvkptgiB3wCT0Hf9gAGbJgtHopMwipZE0blqJMcosgeqZII7doWM2iS
         hYr3+afp3gCG2xQVJ5M3jau0jwmd1PFRcPnIOvZpLFNFV4L5v+X8cMZVWvP4qcErAOLZ
         vcjrzyz2PVeol7eJFHqCXkKi4rUUTy8sT4hB+HRI8/xYfALdzVSCk2MG/a8w2bNISb5a
         wi4ks+pmD55Z1FZSVmDfSI9W5TrdXdth+etl6aKm2FLzTjgUAzpF8yZ5dgLzOsknzCH9
         CDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726614; x=1728331414;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI+zx8QsdFx8s2KuJaXhZ3U2Smejzcc3UCHD/eWxk+0=;
        b=U6YNLGa9Ya7sdb+KFew14GN7ldLssfOUzsWptW/k/PkKPmQVFSx09Y5e8pmYDG44no
         4u03KllGr+zVoDmEdt/Bzxqf9EqSdJswf/C5j93yVfIB0dz30IWqLTz5DKyAP8cSz8ml
         lJkeWq2WoqJRW2gv3ug/IDb65xes0r/yRyLeTfELShjGfyBJ2n0fsAmAe4xOOqHZRmo2
         Pdj4C3hA/D8majm4b57IxKIRx4DH6bKwQED9qCNR+kU26jE8EIDdu+6ySLBBnuTcBHaf
         dj7ru2NgXqykTrjNn53ExMJzBbvhGgPUbo87i28VHWZzFFief7R+zc3OcVkbJgUVPn/9
         cyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAN3Tcwwcg3SoTiGOWp5yikP6jQZLdmPYtdvfzbU2aGgY05AQJfSDHWn5D9hQgbGqeqdJDO7hsv4953k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7pZGUjZ11jbcawiWpX2wwTMP2oKrQuu2tHjr3ikiN3sXgQXW
	HayYPeVZMdEf+qcQ0pspwlGfNHP8kBdiPLKCz9B83Zt+g3SDAKex
X-Google-Smtp-Source: AGHT+IHnCQnrjvKFLZYwwqwdUTur1D6PH/M5shpmrDIYAZ5w7uc5Og6Wq0leja+bZ7tFe6lANpnqFQ==
X-Received: by 2002:a05:600c:4ba4:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-42f5b906471mr99196045e9.16.1727726614276;
        Mon, 30 Sep 2024 13:03:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm162591215e9.30.2024.09.30.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:03:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] net: switch to scoped device_for_each_child_node()
Date: Mon, 30 Sep 2024 22:03:28 +0200
Message-Id: <20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAE+2YC/x2NUQrCMBAFr1L220CMwapXEQnt7otZkKQkRYTSu
 zf4OTDMbNRQFY0ew0YVX21acofzaSBOU37DqHQmZ52394s1GauRLjJCLDVg4hQ46UdCLoLQuCw
 QgxlXF0fvbn6k3loqov7+n+dr3w+Bc7IgdwAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727726610; l=1463;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=47I8xfCitENoyApbDJeb8z83ysVQ1fPkC3PWZWQevPk=;
 b=dstzo1kf04lTfSLbpTt9N58T8KXqTYaM0Df4obIEGXCd/VsJuN7Jd8PqPpsPt1WBiFURzp6Dt
 HR11lFMOtpSAc75I/F/KnzDWgM+xqMWLxtaawb8n/AvYlpKe6WuBLjH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series switches from the device_for_each_child_node() macro to its
scoped variant. This makes the code more robust if new early exits are
added to the loops, because there is no need for explicit calls to
fwnode_handle_put(), which also simplifies existing code.

The non-scoped macros to walk over nodes turn error-prone as soon as
the loop contains early exits (break, goto, return), and patches to
fix them show up regularly, sometimes due to new error paths in an
existing loop [1].

Note that the child node is now declared in the macro, and therefore the
explicit declaration is no longer required.

The general functionality should not be affected by this modification.
If functional changes are found, please report them back as errors.

Link:
https://lore.kernel.org/all/20240901160829.709296395@linuxfoundation.org/
[1]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      net: mdio: switch to scoped device_for_each_child_node()
      net: hns: switch to scoped device_for_each_child_node()

 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 10 +++-------
 drivers/net/mdio/mdio-thunder.c                   |  4 +---
 2 files changed, 4 insertions(+), 10 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-net-device_for_each_child_node_scoped-ebe62f742847

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


