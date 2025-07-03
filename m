Return-Path: <netdev+bounces-203779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EBEAF72CD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989737B3483
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837AF2E54CC;
	Thu,  3 Jul 2025 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bUlfBSXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1892E427B
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543161; cv=none; b=ADhB5jvn4IoHiegi6nHHQqPgb7/zcwAwTwLWXJ2n/oE3LYRAA33Q3yICDMFkFkbpA5SvzSW2P3VQmE1jY69yqh0P5GLN8mWY7REfbdyrtnM040krMMWFvGVJyck40d0ObVngLe+CYyzePU7ZpVJMPELKdQ/Xp72vdTkTk2XM3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543161; c=relaxed/simple;
	bh=Eez0k9X3BpQNBMGADN7BGI2xWsDm4RGJ6+ww5u74t3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WS6fY3nlprNBpzoyg7HSWHakzqxVUGmWidj8/w5tvsokP5dzjitUdvqFmQNC4iblSku6Sdt2MZ1+LuTka8nIae60Bc5dr7VmJh9zOKhZTVvAH6+dYrojPQUDYL+QvxctvENmDCRga7diXnVtOgMa1+sSk5Z5qb6ctNFTPJDrFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bUlfBSXl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so53836665e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1751543157; x=1752147957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFxhxPl7hOACdG2MmWqK4blKK7hdP6cHDcOjL9B1Lic=;
        b=bUlfBSXlkc02ENM3IJT+jtge/1leVUzDuqHGDHtco7prZsU8hfvcEL4PNL2sgMrigC
         1sbv/txMMVmb3MFzmkcBRt62FNIPtI/t30XFUIgBwtEByn5SNbsEys4kXRlkbA2eeuOi
         Jt2s1/JwYRZrR11PHSdLSdiR6TZCyg9KR+Y7yc9rehxOdO3LWkF3qhDXqHxu8Nr4TP7x
         ifrXWM7wYlG5ZtieyOVVvz7nVblvGOv5gouFO3ejzeIbC42IM2tJ79lMemyjVAPq61IN
         msUadErZS6dqpNEV6DoPtqJ3dbsukoNJnrvB/00l1k1qP/SoVyUfLUIIRBUSkNhoLEdr
         GLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751543157; x=1752147957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFxhxPl7hOACdG2MmWqK4blKK7hdP6cHDcOjL9B1Lic=;
        b=QZI/ftsUpsMdA1FUZ2lbM9zoDpdtFNA1c/3Njw4Bv1GuT7fBGTKH1WVoyyTn4H3r9Y
         aJvzEH9ueu3gxVlE8TZNdDxOdmD2Sk2j7KtqOoghPVhxcXDfKMl6jRVw5YUSuIQn9EpD
         SD2YCDV/RUH2TDg1dnB/GaBS6wBq1vTNtbsAhvBpxgcwEK1FbFtZ05xDC/QdzItjd64C
         Ze+kHhGGWPkzOT7uJBZsAnF4ZYlc9ZoyA0gAKUtNE5PuwoEA/KalVSmpDB1TPoNTuoYb
         vOA7PNbB9r/x4XsUmrxf1jpt7FmgCHXkkqyejv7VLmrlKzBXhvNPxuUX/Ocsyx4auv0i
         AkMA==
X-Gm-Message-State: AOJu0YxjKk17zxu4F5gfcJvox1jvvsiYdZrZ0pc1RATFHUetbUn1nZUr
	jt5p0Vr7rfHz401/I/oJXWM3TKmsBsmCie/Q1+n0kB8/2xxRvJzTs8gRhQrsMWrcYG+kX7Tx05Q
	H04IqMf66J5am/TkUNXQCGMfw8dvoWBNv7MU21bdLEmx+S4WhNh9m9KHA76oETHeo
X-Gm-Gg: ASbGncsJwMTlNxKIJYYimO6eSZB3mChyrXHhYLZ51AbQgU1qsQFmfq4QEqyHlChnk15
	Z8Nl/1P5UqFvr7L121h0KTk43lht49QGrfjJwx1cbhLDU+OHQyT3XfgKABO8VNSfw+9BoRs6PyT
	2gnDYND2dJSorv9b1kZvZzPMX3fy6JqAq6WR3atRr0aKuCGVq4OnuF9dorvQN+BqG4Drx76LNfU
	bRnSE4vKFKk2KUAg03Fdhthu5zW2lq1aj6GkP1hgY4MHVFieRxRXp6CKCgROSvqVMZho1ZwOF/X
	UNJP+mHdlwwscyuLd34C65VQjWseKvy8vb88QRe/8aY42xzmhC1gX+ASGjOFtwhFWlA+EqywAvD
	eZ12pr1pP
X-Google-Smtp-Source: AGHT+IHSOX8UztzxXOfy1qh+NnveAkxaIDxEmwRaFE/7dTqXvhsC+ePdt/KFAgoEVTblQVSpzVuF+Q==
X-Received: by 2002:a05:600c:a115:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-454ac374dbdmr14971915e9.11.1751543157111;
        Thu, 03 Jul 2025 04:45:57 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:aeb1:428:2d89:85bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be5bbfsm24174145e9.34.2025.07.03.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:45:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/3] pull request: ovpn for net 2025-07-03
Date: Thu,  3 Jul 2025 13:45:09 +0200
Message-ID: <20250703114513.18071-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi netdev-team,

In this batch you can find the following bug fixes:

Patch 1: make sure to propagate any socket FW mark set by userspace
(via SO_MARK) to skbs being sent over that socket.

Patch 2: reject netlink PEER_NEW/SET messages if the read-only attribute
OVPN_A_PEER_LOCAL_PORT was specified.

Patch 3: reset the skb's GSO state when moving a packet from transport
to tunnel layer.

Please pull or let me know of any issue!

Thanks a lot.
Antonio,

The following changes since commit 72fb83735c71e3f6f025ab7f5dbfec7c9e26b6cc:

  Merge tag 'for-net-2025-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2025-06-30 18:58:47 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next tags/ovpn-net-20250703

for you to fetch changes up to 3d75827928ed01b548eb148f3292092bb07c6bcc:

  ovpn: reset GSO metadata after decapsulation (2025-07-03 13:22:15 +0200)

----------------------------------------------------------------
This bugfix batch includes the following changes:
* properly propagate sk mark to skb->mark field
* reject read-only OVPN_A_PEER_LOCAL_PORT in PEER_NEW/SET
* reset GSO state when moving skb from transport to tunnel layer

----------------------------------------------------------------
Antonio Quartulli (1):
      ovpn: explicitly reject netlink attr PEER_LOCAL_PORT in CMD_PEER_NEW/SET

Ralf Lici (2):
      ovpn: propagate socket mark to skb in UDP
      ovpn: reset GSO metadata after decapsulation

 drivers/net/ovpn/io.c      |  7 +++++++
 drivers/net/ovpn/netlink.c | 11 +++++++++++
 drivers/net/ovpn/udp.c     |  1 +
 3 files changed, 19 insertions(+)

