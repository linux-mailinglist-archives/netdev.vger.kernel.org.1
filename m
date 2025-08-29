Return-Path: <netdev+bounces-218362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1EB3C2E3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39DEA014D0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDB230BF8;
	Fri, 29 Aug 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEScj7Ao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32744A23;
	Fri, 29 Aug 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494743; cv=none; b=Ww8gfOFtjOJfDkh5W/0q50bmnA4BrsCrsCrAvPxweQ4EIIBN6LA+NHUqTWUsZEOVhCFqE239EF4WBI8Pm44fDqLUFpDLGHPMiwlGTxe0QrFaqNgMEsoR8tf6+naLRT2ZqVPia+TTjTkhJZyv2a9ghblo/SuyvZV5SGHYVlUUI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494743; c=relaxed/simple;
	bh=xpI5ehQpgkg/VoesxnCvFaPbWVKsstPUrT/FYr8jYbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPMqEkcq5pGFsFh0P/W+d3FcED7jl6qm6TSHUT+3E+SDcKb39ocEt3Hd1lauY/JPmQTOsAith/HDpElHl45dHfzGrlKJtl+37TUrWHMSFP715lXwAQxBkh50Kr1UDGsIFu/fnsZyh8wqcdiA/HW33tKO+3n5/4FcmfyVxOIqNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEScj7Ao; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54003fb8be9so581643e0c.1;
        Fri, 29 Aug 2025 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756494740; x=1757099540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv9pQLpTht4+b30fMm1psRIJSTWM6neQVSDae5ds2JQ=;
        b=EEScj7AolE3KRp8HF/JUEsjLyaCTI2hJijJi9PVmciIhoRaUFKXamHktBP8tqyXpuG
         7q0080kFVeXAKGN7CwQPSbj8GTMSUQXA26zpdXlaVr7ReGk/I1It/JOqL3SAcKpiIxNN
         b2G2/CpyZ5WSTnvXsa88ntVD71x8WWJg+CkwUr4gW7IIu9uLPjsp1LuUPwbOsgoKjFDw
         fEWLr75kdwBlswBSslpccJ/Ylg3D10otJsHkOzkXwNAd0HTFLBuamAavPW9+ytWXvAsw
         +3O0cLpNU9rIf6Uwhg8JWBloJCjLe3YfI08WnE+TmsUNPW40nDyM/+htC6keVOUnWi0S
         HePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756494740; x=1757099540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lv9pQLpTht4+b30fMm1psRIJSTWM6neQVSDae5ds2JQ=;
        b=iT4YfGGIhlyxyZmSN2tLRSofNWMpmccT/AnqL9I+j6kgU7afF362yQFw3FonScxuDb
         jseJKwK952GyxAzb5Q5Fx1Zdr3dOTofCvFNeonZcfmG83BE0jdZp9t2dxT8I3iKe6eTH
         Gl5ZwrtGLTdW5PW5PLmcsXepuQVEvi1RRoOTbpU0N7jfx9mROVRCT7yInfqcx5tR9nSB
         Qkyd6R9n9C0Byl3TGG9MTi0Uj1HaBonJ4Ao8Mh99ZJz2c8hV0cQbjDJULQUqgdWLvQvg
         cbci8ov4ILI6TOEIy2I7CM4suAOkmm0uIYFLS0FeVAE21t5KJZ/KL37PxZC8EBSaPeGF
         o4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWALT1NXc1jhaV2Z7Hss6x3tiLzmAy/lg+zqxtDg0zRhDJCLaJazI2+WHNms9l/o/yM3whTYvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDrYAy17F7FZraEit1HhGhW9QtyFCmIKIy6oYKy7o1vSlELm4
	B7qdF76Ux7Xma7aVhtXUZTZl+rSOsvG69P16sgiajwyKc01QxLoW4FtyitB4ROxm
X-Gm-Gg: ASbGncsARjolcOD2ZZc0ms1dQfuYYPh1V5MM1Jug2Gg9Fa80dpoVUKLqrapq9YYpBHl
	4fYiPnwIY6WWePD1OW6XiaEK98v4VQDGFNGf6ewQjRcfSgSUbIfKAt6Jhvvp8CEYTmILBMgMcIE
	Bmy82JRmxiD/Zcq4/k0//KCZTxggDv2NE9guH7tW4r757B9Ub8IYqD20Ucgua38e4I5sLkyA5sa
	rFtbZyCzP40KK/f1eDoRxmFjPggADTfy5zIsmadnG3bym68k/yqVSQHMhlYBRwNh4V7pDXEwmGy
	y2L1Nfcigo8Hq008+JcOnx6gXUIVzdTVLZgqrVJ0glNFc2f8YdSNtK/ctdIwPt6Clnt7KY7hl2A
	49U/LJDVAUG4JyedO6U0gxCbj554NMk5QbYUx+CNSzssrxzHHo85mlKRQkz5GGYjcoTWtR1BC/K
	wZRnCFfoZhPzOi6yjcUvYynyHdsnWDawbaFG50pMw=
X-Google-Smtp-Source: AGHT+IECuIfPzTKAoKLnb5CCkqctpSjM4duv5G7WWCZ4jAtAQ9D+zyG5Bwm9OD6S6aWTtrYYwHepAw==
X-Received: by 2002:a05:6122:251d:b0:544:93b6:a096 with SMTP id 71dfb90a1353d-54493b6a1a3mr971147e0c.8.1756494740458;
        Fri, 29 Aug 2025 12:12:20 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491464b7dsm1331889e0c.15.2025.08.29.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:12:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-08-29
Date: Fri, 29 Aug 2025 15:12:10 -0400
Message-ID: <20250829191210.1982163-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 5189446ba995556eaa3755a6e875bc06675b88bd:

  net: ipv4: fix regression in local-broadcast routes (2025-08-28 10:52:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-08-29

for you to fetch changes up to 862c628108562d8c7a516a900034823b381d3cba:

  Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen() (2025-08-29 14:51:06 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - vhci: Prevent use-after-free by removing debugfs files early
 - L2CAP: Fix use-after-free in l2cap_sock_cleanup_listen()

----------------------------------------------------------------
Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files early

Kuniyuki Iwashima (1):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()

 drivers/bluetooth/hci_vhci.c | 57 +++++++++++++++++++++++++++++++-------------
 net/bluetooth/l2cap_sock.c   |  3 +++
 2 files changed, 44 insertions(+), 16 deletions(-)

