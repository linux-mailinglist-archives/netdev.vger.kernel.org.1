Return-Path: <netdev+bounces-114661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9E9435DF
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F302B283616
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C812B176;
	Wed, 31 Jul 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="zyjOkoSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9386250
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451993; cv=none; b=leHDIlfidfw1aK+CXSuqEJ4qxgLKuktXHhUwfTL+BU4F2Uj6PrbxQ5N0ClEgCzzz99Yjk1iCK8dKME860fJ9TWCydotooG09fhYvpFuwxREkrR0uKBOqzuOU1btVEHz4iSDhVTUGwAksuKLstH5IZdo3KbSyNZWjUcq61OsIasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451993; c=relaxed/simple;
	bh=KMCuH83HN8KlHmBA/0LgLY6pB6mLwm5fk9j8iVVPqmY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dv+tFGfk+0L4B4tJeykhskxRPtFn8kC/PYY6/4rxih+D34VNX4ngrTcXX2kbPeQAypMWndDP483XXHI4sIQnQXWGLqkW9GhnIYWz9ZzJtns3TTL5PnZtw3A7XZRCs74DPl+mbB4WCv+NH1Na2EyzshvEggUPwtAwAEcL9GyD/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=zyjOkoSr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4e010efdso2406465ad.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1722451990; x=1723056790; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEfk5ncIt83x7m+YjdXKWTAuZRXipE5lQH8P1TgSxxk=;
        b=zyjOkoSr9Ylv2HJZ2QNumyzdC8vHQTLfvffR51Tt+iP+B7pXyV7/bH9a7qaXcxM2YH
         ROdKDHCume7tVRNpdGr5+feurOzeLrfVi//9MmgU8tlII6/5googZSfVFHmN80LtSt1F
         XvrnCdAMN+Vt4/enYROOONHV5BOpwdlNTtuIntuXwhe1vRbFx+Xbe7iYyKSCBendPF8Z
         fn0BP4hZi/xWxSpbAnfD3hyLz1drz65mNdcE1zrFp2pGiImxIoXkTqnQW/IUhZiafVkU
         FgjVxmDP1IbQt0Wj9JIS7n2hHsSBw8yXf8Xkh66aKdIQhdEMUnOGZjlfycF8FvzHEZXW
         djrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451990; x=1723056790;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEfk5ncIt83x7m+YjdXKWTAuZRXipE5lQH8P1TgSxxk=;
        b=SxSm1Pr7wAcSCQtzYcxikvZ5mwT/EemBRKjgCJvcRappgpqOkxYpecGwUHoF8qGD4y
         uf0UYqEJuiG5SwO5fU2fzcaT5KVZuTRDKK2fxNBShy/3+/xbn9hZo68nI8FAJh30+new
         DIcrhdwzkBLRfom0VVN6Ko9goOgR+OM4NcI+lfv4XsjaRYgYlx8QoNcu2pLfA1yltjRM
         c4Ook2MaTGVSgs2xJNitnTWFzz2Th8q91mFXGpw1HgO3tzbus26O22oe4JAg/1OuibkJ
         0E3a5F8f2rf2w337l1R8V0CG3c4wQBtut0xMkqzTPzqRS92pb3LgYnxz4a2exxRZieWI
         ZJ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUbHlKSgSM1yPHWQh0tsvi+5ooZ5kJTSV/Jb5749URdNF3f5HI2tqbIlTylNR16s7Ziv6lR0Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tHGpVThR943Ga5rMIHV9io1lFItk7V1PYYyUUfbAAYGrGGnp
	Ib567Jdh1nQgKeTxUGNBq7oJC4wKwQD4IpZGrY6rGNT8xyS7EP9NyfCE96N8KQ==
X-Google-Smtp-Source: AGHT+IEd+Xm0W4rzAj9Ge+Z6pqWDl86lXrzFgFPRiCGmSEioNJ82NKUarMvpuVJei24NUE3crSe5NA==
X-Received: by 2002:a17:903:22c9:b0:1fc:4377:d946 with SMTP id d9443c01a7336-1ff4d2715e7mr1565605ad.7.1722451989787;
        Wed, 31 Jul 2024 11:53:09 -0700 (PDT)
Received: from [172.16.118.4] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff3d64sm123182825ad.299.2024.07.31.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:53:09 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH v2 0/3] Add Firmware Upload support for beagleplay cc1352
Date: Thu, 01 Aug 2024 00:21:04 +0530
Message-Id: <20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiHqmYC/x3M2wqEIBRG4VeJfZ3g2AnmVSLE9M82RInSiejdR
 +byu1jroYTISPQtHoo4OPG2ZqiyIDub1UOwyyYlVS27TyNGGL8gLObW06n34KNxEHWF1lqM0lW
 OchsiJr7+33543x+DqvWwZwAAAA==
To: lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=KMCuH83HN8KlHmBA/0LgLY6pB6mLwm5fk9j8iVVPqmY=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmqogPi0vwzJBN8N67/Uo/+Auvt6abDVkOuhzE9
 sWnqSJIZnaJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZqqIDwAKCRAFzvXHieVa
 dFhYD/4n6dksvaVAzW8JNYa3TZa9J6e/KJlomwxI2vZ+cHEleryRg4eHJWbVwYmT3wUuOjen1rS
 dSUKVQNkNO4Y6rnuyzcgvDKibNcmt+92wfMbzv6d5Z8bEn57FFH8menncGCzQ6L38NrTkc6TSID
 jeO9z14XniNECUluww6/xP46PgLmX+L0+ofZSkgqTi+rSJXOQH2CS3tfm8IKD/OwEzwGkF6LKeI
 1RGhIz/ouzeb+jR0+l6Vb5zDlwpc1mnjAKcE6sw85BgAGWa+4ZkuJGzdwiE0KzuYWE8Q6uOBO99
 kGoeKkWzZe+ungbu/psrCgVMiuyUXjMRsS+WCI1otwbhIynu8qdomoijTKpUwxYCEQtmlI+wMTL
 Bh2mVBGFe5wqpHw8VFlPIKTr/JTIpB94ONzjx17ACLheHE9EVZgiHwwMejOn0nQM7bDJot29Rk8
 MShJBN5VlbXNC9TUGvsWIZfCTR1mywoqdJTUG0talE7h06cHzKTml7y1fchuxWUllzkCNHB01ny
 EM/GWiiS0dsLm4yZE4CVA+Rg3LAXdNs9ohJtwgaP7a0iinKrffC3jFOvXV7TKN9FqQu464zXPaT
 HcLQBY3DZ+roJDxxpbFK7XuCrXNntH6uzdRn7pt54oie9uiak5fp8hZ2yk1EPR494ceGypvqa7W
 fqZBwz+jBHy4QGQ==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Adds support for beagleplay cc1352 co-processor firmware upgrade using
kernel Firmware Upload API. Uses ROM based bootloader present in
cc13x2x7 and cc26x2x7 platforms for flashing over UART.

Communication with the bootloader can be moved out of gb-beagleplay
driver if required, but I am keeping it here since there are no
immediate plans to use the on-board cc1352p7 for anything other than
greybus (BeagleConnect Technology). Additionally, there do not seem to
any other devices using cc1352p7 or it's cousins as a co-processor.

Bootloader backdoor and Reset GPIOs are used to enable cc1352p7 bootloader
backdoor for flashing. Flashing is skipped in case we are trying to flash
the same image as the one that is currently present. This is determined by
CRC32 calculation of the supplied firmware and Flash data.

We also do a CRC32 check after flashing to ensure that the firmware was
flashed properly.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification
Link:
https://lore.kernel.org/all/20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org/
Patch v1

Changes in v2:
- Spelling fixes
- Rename boot-gpios to bootloader-backdoor-gpios
- Add doc comments
- Add check to ensure firmware size is 704 KB

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (3):
      dt-bindings: net: ti,cc1352p7: Add bootloader-backdoor-gpios
      arm64: dts: ti: k3-am625-beagleplay: Add bootloader-backdoor-gpios to cc1352p7
      greybus: gb-beagleplay: Add firmware upload API

 .../devicetree/bindings/net/ti,cc1352p7.yaml       |   7 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   3 +-
 drivers/greybus/Kconfig                            |   1 +
 drivers/greybus/gb-beagleplay.c                    | 658 ++++++++++++++++++++-
 4 files changed, 655 insertions(+), 14 deletions(-)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240715-beagleplay_fw_upgrade-43e6cceb0d3d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


