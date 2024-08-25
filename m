Return-Path: <netdev+bounces-121733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95795E46B
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE12B20B62
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880C15B11E;
	Sun, 25 Aug 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="cchbt2UN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FA1547EB
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724604444; cv=none; b=PPm5RgrDyvPlXNaTuos5JbC5sgQ9afW4eMCW5irTPLb+WJXT9QceiuUgL7LttlAWHrxtoJJwbY/soTyS+XRyrcfmFCH2qcIJFpHB2C+H0uqYwv1sdrFWtZL+ZPR5zB2nMRN+VGxG60z+VHZTWfERlQWodT+WPAr3laC+pk0TVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724604444; c=relaxed/simple;
	bh=k0BeDYnqSBfodOslNY/mdXSjosr5XizIxqn3N69Vyj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q4hU+yvGtkeVrT0a03V77mHef1VLCeYaxzMtqCQfTyGeoNkJhGOErgbj3wbGzGgKYKFNZQrTIDu9SsX6zqnCigkSPFBvgZABqNybY9kIgYhn0hrmDfv70ok6ClonRp551NaM0L5nGBpJ/Tmts5b4whyEvzOy3EqgaR2Bxev0lPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=cchbt2UN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fc47abc040so29872765ad.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1724604441; x=1725209241; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jwkJDd2+orcK4mtu4nJD6Uj2vRnYFfyrcCU5EsSQgTQ=;
        b=cchbt2UNjyi2sLHmyG7A9rJud4phKK6CEJj3iU0tKQRu4BdT09qi2dV+s9uyL8Coer
         O8dvxhqlhJ9iU22XGTQ/8NHHDX6by9XszOmGFzJNvVrTqkMqmRudf6SEB/iFFFBnQ6g2
         NgtVSl7caEK/JR3DM06maDRhOtgAPg2XXYvodcb3cNXrD44uj4UiBxrzC2yX+M1HqY4L
         1aB1Ko20MsoizrgzdpU2lur/OTEUNY2zOFh63FB/Ykzl8sIufbC627ldq89XDHh58QjZ
         tP9dTXpJo1TFFrFJ55ppD1Xp7nsHGNtqba4WQVrkrvPMEsl7mZlGTw6zYcgvIGLQEn2M
         w/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724604441; x=1725209241;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwkJDd2+orcK4mtu4nJD6Uj2vRnYFfyrcCU5EsSQgTQ=;
        b=vjbIfAG7k8Esyt5/k7fB8P5QXxPDpG27FjVKWC+jiwVOX1UuBYqw4zuCjDFPYa82eb
         X3o+JygtAYMKfw0dioLdyB5KbKa+5t3Ktd+ry0RyewbxsKeyMbK15Db4A49wu49VHjiP
         EU6Wg0NYvb32/rRbdw8fMmPIXPFJQ2dpbGV4Nc+Fdx0qcVCivq4KY/F1LXl8811jJTp/
         6Y1riyP3AlzOGj1m/5pIZG56SfPyEDcnpgedu4tQpM5Y/0UyBNkPi+9bsLwhIkhlFfwm
         pNlIL/gPJIvibpvePGnIN3ExptP3reTQ0eBP751x5v8e1MXfyndho+Gl6UKMCYpfmD22
         ETvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxeF+9Sh3/9qkXfGn0uqhulOLboZUSehKVmXXVsDOc5elujfCE8LCaMiP/iey9GL8KJ+3lHGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqR406eNSFjufNCWoKhOxxEtDWCNDDCMHXOVMMPEpLkeN8Bozw
	N/ejZvRoUzpNGXZM1yFhPtNpOckWaf3nBpVEeftcAb003jSvhJla+g6QK1cVAg==
X-Google-Smtp-Source: AGHT+IGUoNDaU5BtVxFVUeKLs3SX8LIv697nC5BrkumL6cO5K0BgHADqN4xtXahOQLjurs/znyMK4Q==
X-Received: by 2002:a17:902:db09:b0:1fc:6a13:a39f with SMTP id d9443c01a7336-2039e48a2eemr111659305ad.25.1724604441343;
        Sun, 25 Aug 2024 09:47:21 -0700 (PDT)
Received: from [192.168.41.46] ([2401:4900:5ae1:9eb1:890a:6b80:a16d:5ab4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm55411465ad.196.2024.08.25.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 09:47:21 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH v3 0/3] Add Firmware Upload support for beagleplay cc1352
Date: Sun, 25 Aug 2024 22:17:04 +0530
Message-Id: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhgy2YC/3WNyw6CMBREf4XctTWlRV4r/8MQ0tJLaUIouVWUE
 P7dCmuXZzJzZoOA5DBAnWxAuLjg/BRBXhLoBjVZZM5EBsFFxov0xjQqO+I8qrXt3+1rtqQMskx
 i3nWouZEG4nYm7N3n8D6ayIMLT0/rcbOIX3oaS57+MS6CcYYyr0Spi0oYfT972isyV08Wmn3fv
 zfjrvLAAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=k0BeDYnqSBfodOslNY/mdXSjosr5XizIxqn3N69Vyj4=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmy2AP/GQMSC238xGe6JdG69qWl4ZvxhBcxg6Os
 x8RIXGX2ZuJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZstgDwAKCRAFzvXHieVa
 dLK7EADCfwwUW4dSX3kPDqJ4DkfS4rRcxs3EiuHQegFqfJKuG+S1c8ZBYlewQkECMKQwHztzs2S
 Mt+hHIinS5htx1+k0vhLrAixpkKEYKU3cv6auG2iCdz9/9oc36WQ+NWpTQ/tKQlUDwQ6B0dJmWk
 7qLehY04zG2ni6rpXzilz97gYvrqmLwlOlZKc+K+4apZA/Rsbl8KIMzoE4oCZk1VbTp372q7MvS
 fHtQ1lOzvGtPgi+rHIZ9/sgAmOAHOcP+EHyBPWOqTdTgpwu3bH54yxlDnU2Xhzq5YjMSTjJvPE5
 s9wR07rRo3gxmFo46EXjgU2NBsEuCkMq/+aWAg9v+DOWPLt3AeJlmdjB5ACD9nDpnUZfNoo5Kp5
 Pp2q52F6J4kaB7END7Yci7GXCJVQL4phi5MuN09alQ59Cbhtb5jlsBWaXR+VG1cJlpATk12Baoy
 jQMG8qgOT6bjAmzPyE/SPvACY9j/OsYgN+VJ04bAHi+GINRaP7LnYOuMfKlUqb8F8WaNdMScShR
 K9B8i46wWsvG1Kz49la1NwYMx+/lXsTs/Xvj58cTXBEZJftdKvPUonRsF/ax0vnIqFFZKVyfLSW
 se2zs/50blyZW2966cOpRTbQue2BUYUfyahEaVBr+7UvqhtVPVosCN//XTFbsTjc5uNfmqTAXGn
 ew8ve264nE+ueGw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Adds support for beagleplay cc1352 co-processor firmware upgrade using
kernel Firmware Upload API. Uses ROM based bootloader present in
cc13x2x7 and cc26x2x7 platforms for flashing over UART.

Communication with the bootloader can be moved out of gb-beagleplay
driver if required, but I am keeping it here since there are no
immediate plans to use the on-board cc1352p7 for anything other than
greybus (BeagleConnect Technology). Additionally, there do not seem to
any other devices using cc1352p7 or its cousins as a co-processor.

Bootloader backdoor and reset GPIOs are used to enable cc1352p7 bootloader
backdoor for flashing. Flashing is skipped in case we are trying to flash
the same image as the one that is currently present. This is determined by
CRC32 calculation of the supplied firmware and flash data.

We also do a CRC32 check after flashing to ensure that the firmware was
flashed properly.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352P7 Technical Specification

Changes in v3:
- Spelling fixes in cover letter
- Add Ack by Rob Herring on Patch 1
- Link to v2: https://lore.kernel.org/r/20240801-beagleplay_fw_upgrade-v2-0-e36928b792db@beagleboard.org

Changes in v2:
- Spelling fixes
- Rename boot-gpios to bootloader-backdoor-gpios
- Add doc comments
- Add check to ensure firmware size is 704 KB
- Link to v1: https://lore.kernel.org/all/20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org

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


