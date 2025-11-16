Return-Path: <netdev+bounces-238940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06BC617E1
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3553AE2BC
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542530CD9D;
	Sun, 16 Nov 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC7jjZEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4392DBF5B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308622; cv=none; b=OHr25n7oYNVHr1sWtN9gs6DxF6Jua5xVDoCY8VLrB9661fDvyT+VIPNGE/8B7hUvu9Db/M9WyAiiWiYR89EC+md60oW744koX7PhElk+Oc3d/OI3TVbdtIOxmC4t/QyGWHSB5widushyco3eLO8j+jcTRhqcz4Sdt2kYqXPGJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308622; c=relaxed/simple;
	bh=6UiFijM/zOyeh0Ls0U6ZbiIJFi1p1hV3m3U4DmZPA98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cccsCkKgailWtQe5e8C6ANQH6Bz+ZEudgphvCgB9pOxHNyvnmUTnPzKnguyXBWeu6cM6E7aGKl9bU4hLdHlMfNxJIThtOwluaENjoJEOtMKAQPvolehd9r3++vBDqEABwrvHZJEPIqLolEblWxMPo6dcrFPgGezs4P7K8pYleSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC7jjZEC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1343095b3a.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763308619; x=1763913419; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPvprIY4qMT2bCIRdhfvkg3XFFOgGut8Hky7O8BHyG4=;
        b=WC7jjZECNIDyw6t1P9F39lg/PNYPdBPNyJUNsiY/SwELdo0KJXcdkWvHUeFyYGQpuD
         Nel1XcP5/GA6ljVhMaPSb3ita5lVyOaykrQiB/iFOWXMiYMd+RaeaxqQM/Y2ywI8r/00
         DizAH4KrAZ+8EjcU4g+aHw/vFGH3AEmJukvnb/nUK4U8c3mnkQsKHIn16IuGdQCCsl2z
         AGW5DQkC0tPIh5uh8vt2SgN0khavcHry1uoENF77JrYYE+gdg8GAXTPnV5vS1lVNKsEW
         arvtOsBdABh4aom7yk9QXBn+YQqyAX7uXsVoq5znRVxR4QQTNmcK5jPQdbhBHeWfZ3iP
         qSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763308619; x=1763913419;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPvprIY4qMT2bCIRdhfvkg3XFFOgGut8Hky7O8BHyG4=;
        b=FcXOuv9+rSTVQRqxKFcHVLJ/SOkxDCYdHxIxhVu9EqI8Uwum0MErJE6oJsFkv0MCxu
         o9Ul3McHQWYRYFp/u/lwL+7EyHW3oD/75jNNx4rqPyT4jCYzcDgmJO9uErizkMFWGpC5
         5vN/nRx2zfMLlufzul8Bf8Hu8Ff7rBhCJpax4bxZF7HTNp4XefD9bkhSTIq/UrgiUB+Z
         H8dcjBnqtYNNEu3hjTbr0hMJGBRCtkvENn5JP5CBBR/pciHntWboGQ0dzVIurOfEMiFh
         GQ+k3lq+rJ8ZWadaucpJYwhnXOMRNaECzN7qXS/FDlelAMoIDzaw/zuWDThQD2bE5/pI
         27aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb9PiXXw1kSQsR/zMgh8+KuZ8I8+k9nuQ+rURSP8zMWonw+tL4rfrwHwjqEqS5FX2bPoNV3oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5I/YhRwueTfJEJKHS0VEvfuPH+pfD59B0hR/7Ahe7nbaANUZ
	QZZySYOaXS7hF3eViMPDESLTqoIDJL4RMIIR5kV1Hap4AMhXyLokrjk0
X-Gm-Gg: ASbGncvmj8X83OooKPy40ATyeCWN+aiB+Eop9//ZZ3B3kjVUv0nzlXC83HSosESmKSI
	rMYqBuW3TLX79ONtLSIVPeN8ENHmzScsKGa1eJguxnYIsYSOvN+mySp4o/DEr8Tuez1KegXFSIt
	ugvMRSay9hOd1TeqKp4jXwxumUs68I36MOOcSn86lE8fl+YLov6tjGNGM2J6AJgdWY48rmtMw9l
	doNbiUgMB3dRw/nZLwCLCF4fMaIkNyG+3153yAJ8BkYg9coBghJQgJ5Xy4qkFPSrhQrNjCyBazM
	532wwdmGHkDsTZBwNbs8LGVeiqqnbD79fcbnVVfWe4v2oSk7iqGPQln8yRbpLUOMy6II1GT+Y0/
	RMDhGiuE1o/6cJ8l9nC+UlhHVuJI55lBMKf5+d96sB2wXl6GoQOxCVjtycEpOBCzComTXEMBIzg
	==
X-Google-Smtp-Source: AGHT+IGdQeL3pObeJ60Bq2doKAMjEPTO+Zen4o0GvF1bhsmgfhLOaHmqVNZ07yEu4UnbGsnsNDPKAA==
X-Received: by 2002:a05:6a00:148a:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-7ba3a0ca29amr12169535b3a.12.1763308619119;
        Sun, 16 Nov 2025 07:56:59 -0800 (PST)
Received: from aheev.home ([106.215.173.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924ae6943sm10677038b3a.6.2025.11.16.07.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:56:58 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Subject: [PATCH RFT net-next 0/2] ethernet: intel: fix freeing
 uninitialized pointers with __free
Date: Sun, 16 Nov 2025 21:26:47 +0530
Message-Id: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/0GWkC/x2NQQrCMBBFr1Jm7UATEasH8ADSnbiIya8ZKGNJY
 imW3t3o8sF//62UkQSZzs1KCbNkeWkFs2vIR6dPsITKZFt7MMbs2UVg5kEWHhLAbxWVIm6UDwJ
 PJWVGiUiKwqIFI7uHb70/2WMXOqq3U0K1/8kbXS9985sqlkL3bfsCYK0ExpAAAAA=
X-Change-ID: 20251113-aheev-fix-free-uninitialized-ptrs-ethernet-intel-abc0cc9278d8
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ally Heev <allyheev@gmail.com>, 
 Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=6UiFijM/zOyeh0Ls0U6ZbiIJFi1p1hV3m3U4DmZPA98=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDIlv7i8v1k/2dblhLLWC3+HhkOrpisfezD72DGrSP+7T
 o5vhMokO0pZGMS4GGTFFFkYRaX89DZJTYg7nPQNZg4rE8gQBi5OAZjIuikM/9R+fXbwEJ36+4PD
 Zqu1YlL5S9k2ucg2GT7Lj1nH8/HCi18MfyX0Vb/IhnHc63y2wV6QU9eycn+41mz/OJ/1E5nUdLL
 X8gAA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

We could just fix it by initializing the pointer to NULL, but, as usage of
cleanup attributes is discouraged in net [1], trying to achieve cleanup
using goto

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Ally Heev (2):
      ice: remove __free usage in ice_flow
      idpf: remove __free usage in idpf_virtchnl

 drivers/net/ethernet/intel/ice/ice_flow.c       |  6 ++++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 28 +++++++++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)
---
base-commit: 24598358a1b4ca1d596b8e7b34a7bc76f54e630f
change-id: 20251113-aheev-fix-free-uninitialized-ptrs-ethernet-intel-abc0cc9278d8

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


