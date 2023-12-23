Return-Path: <netdev+bounces-60116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCB981D741
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 00:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD721C2101E
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A619BD3;
	Sat, 23 Dec 2023 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPpeo/+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3641D527;
	Sat, 23 Dec 2023 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-554ae571341so313851a12.1;
        Sat, 23 Dec 2023 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703374575; x=1703979375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29EMoIYluWAxowNn35akgo5ZU3ui59UzWlGkKdTNPS8=;
        b=cPpeo/+DDbg97Z/uMU9Err1ZLkNtfB7Ld5Nek5BjdqzrDlBwYXOTQ7/4aPBwvk7RUD
         P/k4TBN3nmFLzU+EWn60ELJ94NhjUx4PhJ6UoGQWhxlFsBZsR3qOAJb9sVFawAYnihoa
         jhIv6DN7+w+P51KNVIogpdmK3xqUeqC0lR95z7MaJcbexmN8ny+Rd72wMWvnq9+6xx5r
         vPVxzYyq+tAE2Z4yMTYgPXDx0QXKL0waceGtJwpKbVIedkgM3keV+oOApPW6FamFJrZ6
         d7ds7GY8SXdxEm8oD99nDBbIaGlErNtoHyLmuyT/myvLMfDV41jqnjF5dDaq3paIz/yo
         cZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703374575; x=1703979375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29EMoIYluWAxowNn35akgo5ZU3ui59UzWlGkKdTNPS8=;
        b=Pe7OyhcrGszFUr8qy2AU9CVMkKJOluWljCvszPdgEgtBTfqBqjuZFUA0K5Cfm8ccYz
         QRNW2+Nx7gqC9gdLPaPO/0LOn3g3HENuqvSLg/yh68W8BLQlZY/fHx2QHNOU8IDgouHr
         cPSu/aQL74QMzNDZiOWbt/a/A/1SQS4sBiabByslqEa/nAMHgR2CnSivp+y+vwFL3PBf
         gCKqWlUzce70U2c3v7zptUGiF9EwwP1Uj/6a5yosI4RL4DQquxze+1PjkNT4DbwoAPDx
         PKiQ8s9+AARO5ETeNoxB2dthDxaaUWlHldr5e5Gi7W8MUBXIpgEOSB/2mPq5FkNoiACk
         QBmw==
X-Gm-Message-State: AOJu0Yyi8QQ2lCWqSot6l1cSYgNh52r5iDSasTx6diybvYYFCB6UBg1U
	GFNeO3mV5CJu/+fP5V9OgXk=
X-Google-Smtp-Source: AGHT+IEbdbFV/XUqsIdTT8Cecpt5mzbVRU09mEu6QbZDa2yrAmwDjRdOigSYiup4qbUHBpR5xWPnUg==
X-Received: by 2002:a17:906:cb81:b0:a23:6d24:94cd with SMTP id mf1-20020a170906cb8100b00a236d2494cdmr1698251ejb.14.1703374574683;
        Sat, 23 Dec 2023 15:36:14 -0800 (PST)
Received: from localhost ([5.255.99.108])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b00a2369d8ca07sm3472088ejc.203.2023.12.23.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 15:36:14 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hayes Wang <hayeswang@realtek.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH net 0/2] r8152: Fix a regression with usbguard
Date: Sun, 24 Dec 2023 01:35:21 +0200
Message-ID: <20231223233523.4411-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction of r8152-cfgselector broke hotplug of Realtek USB NICs on
machines that use usbguard. These patches are supposed to fix it.

Tested on RTL8153 (0bda:8153) that has two configuration descriptors:
vendor and CDC.

P.S. I'm not sure whether it's supposed to go through the USB or netdev
tree, therefore submitting to both mailing lists and marking for "net",
but please advise.

Maxim Mikityanskiy (2):
  USB: Allow usb_device_driver to override usb_choose_configuration
  r8152: Switch to using choose_configuration

 drivers/net/usb/r8152.c    | 18 +++++++++---------
 drivers/usb/core/generic.c | 10 ++++++++++
 include/linux/usb.h        |  3 +++
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.43.0


