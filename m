Return-Path: <netdev+bounces-123901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EF966BFF
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DC91C20A0D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73E516E875;
	Fri, 30 Aug 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZzM9beZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F615FCED;
	Fri, 30 Aug 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055384; cv=none; b=gmAZY2kFkTMhB+xrhSerZnTHsAKAn+JQvAlDZKURNLd6mR2JIwrlga4d4KOpCUFgt0Dl6bGbQGSXJofQkYCj2spjrMLTGtkanQEVeFcxz4ZoGiykRSlXmXzsNFft+m8Yh5baE6KotzFoAXDzAen+ZXOjNOvJitOaOhxhRRWv2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055384; c=relaxed/simple;
	bh=3wDcgQbQay/ZjdpjMQAnL+OZtLlxbsXO/Rf+7gqIl7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hr1/rMnCCLf1g8TvEQVb12thFwCYZnSGvTrAksFidWLd5w0S9Ss5VZ2hMNOSTBNDG8pNjkTixWxgnV6OZ6nsCNtYGa02fwS6mMD/ZL9MsvHq1U7S2TsXXoPdDarpyVfcJ+aEC1DareVIFz1zu/+3KGZ1GzK1LNombfv/lCGRzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZzM9beZ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943713472so1111656a34.2;
        Fri, 30 Aug 2024 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725055382; x=1725660182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUcbysriA6GVRHVGaJkOokd72ymRlKfFYkktesq7y1c=;
        b=CZzM9beZzhOixc5b3Ij3IIoy9UO4MXYwmxqhUE/EHImGcaKkIgdCxS1suc/PY0eeZc
         RJd+DNFWaW/+WtjCiAZJ0JNOZiJDyRF3vPDmCK4rEEYSDDH14xng4v8tbRzAg66pWLhz
         ryOLgWQRMYIQooWfxyDXeY8qvwP9k8366oqMnCQ08RHzmrGILYTsQIZLl1uC7y2OO877
         EDY6ClZzGJAosckq6MWjHuLcHSOj7lQpa2DekYt6I0T6FVfo9g4eOsIB8KKu47SUE6HS
         uSOokWkhxwljPjjt5Yjnbjb5tgl6KYgXs3pYmXOS0SW/61XsHsCA+6FIfyOWTvp7cLOy
         DKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725055382; x=1725660182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUcbysriA6GVRHVGaJkOokd72ymRlKfFYkktesq7y1c=;
        b=Ul3tdErjLOvCsYD4g3m7YuAavmQEYHzIMt2KW1G2/CrIflqaj9oxcp0fQBkdlN4oCQ
         Cm+ZpzU4d2s6ZA46T33Knir1BJ8KV7AYbzO+CU9WcOb6hxlyVmwN5yEHz3UWIirB00WV
         vi8MIem//Jhwq7Cap0WpwuzCsiWkxUsZ/0rA5Qa8etrfQMcu27rVgZpE18zR3Bf7hUbY
         MymGg6PFnUuUE/uMYldgUPIjuW+0amOLBB2tE6/1IfyeZtgvNh6I9v6//ijBl1FcnvY6
         dgWZW4VF0El3fu1MrrC4c9zwFXtTL6fSsZx9XBLsuC4bAJ6DUomA+DiAxCh5f43gVIze
         fpyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm4xgfNiQyipzS/6ETyDmr8Vl331rELgM6DaDGbgKYmqRcGVH/toFEyEL76ATyarmvOXEZDf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpJLD+50SbqVB5fW5bHQDkYFX5MXa6tDXt8DTylbRQt0qvCvC
	XP6s923IwTZwTrp/4js2YXsmzL/3ez2UwqJ+4cY2ilIsmwTStrqV
X-Google-Smtp-Source: AGHT+IFnvtxXHBvDmLwkYvfTRHxK3Kcb2jpHdAf5gOBT1cCXzSDKXCkb8Q0MAzJkD1OS9Z59pNDmcw==
X-Received: by 2002:a05:6830:2d87:b0:70f:7123:1f34 with SMTP id 46e09a7af769-70f7123212bmr847595a34.30.1725055382227;
        Fri, 30 Aug 2024 15:03:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-500716644b3sm576859e0c.45.2024.08.30.15.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:03:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull request: bluetooth 2024-08-30
Date: Fri, 30 Aug 2024 18:03:00 -0400
Message-ID: <20240830220300.1316772-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit fe1910f9337bd46a9343967b547ccab26b4b2c6e:

  tcp_bpf: fix return value of tcp_bpf_sendmsg() (2024-08-30 11:09:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-30

for you to fetch changes up to 1e9683c9b6ca88cc9340cdca85edd6134c8cffe3:

  Bluetooth: MGMT: Ignore keys being loaded with invalid type (2024-08-30 17:57:11 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - qca: If memdump doesn't work, re-enable IBS
 - MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
 - Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
 - MGMT: Ignore keys being loaded with invalid type

----------------------------------------------------------------
Douglas Anderson (1):
      Bluetooth: qca: If memdump doesn't work, re-enable IBS

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type

 drivers/bluetooth/hci_qca.c      |   1 +
 include/net/bluetooth/hci_core.h |   5 --
 include/net/bluetooth/hci_sync.h |   4 ++
 net/bluetooth/hci_conn.c         |   6 +-
 net/bluetooth/hci_sync.c         |  42 +++++++++++-
 net/bluetooth/mgmt.c             | 144 ++++++++++++++++++---------------------
 net/bluetooth/smp.c              |   7 --
 7 files changed, 117 insertions(+), 92 deletions(-)

