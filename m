Return-Path: <netdev+bounces-112208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21E937602
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C12B23029
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7D7C6CE;
	Fri, 19 Jul 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="NCuJuHvK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE942076
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382334; cv=none; b=k6rzP0zVk93ZeRw3DMsfHaODXh9NSHHtpQpGDMCIvyh/yNphnlVCwE8Ayl1BjyTBRmneNjO/5J4h3GNMq6Q1S5huxmbluvvDXIkLEepEf5+lb9C42wbHKSP85mcK3y6rtbfSo1KpleDtUFUbVx1ff3XItcSlHEvX43KbxKIKzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382334; c=relaxed/simple;
	bh=wvQcdEWQ3/kLHsxtgCGRA9jYHsgJ/xrav2Xn7haRcMU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FLQZiqv1Xcvh60N1oIoYc4B0pFbg2zfiMLHyzPcgV+jKWowADZo1PSlb09Kr12ONEoNXqnBuWq80wr7PZN3GWhya4nJqCs2vH3VI+aaHdlbEXTkUeK9P45N6lO5q5e/6pxT57qXxkiLo4PVKVSYA4s2vObFEVqBdWGtmXGseHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=NCuJuHvK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc5c0c65bcso1623405ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1721382332; x=1721987132; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTIjdju0ng5SZUR/ZVbr+pjq8z5bsP/PxolugfMqbFg=;
        b=NCuJuHvKq9YHT3W6tARyzFYG7j7joVlBvGUbhlkYbRpaISOVCJJpTmPv0Imma1QWeP
         vPtN9bbkKUbYA4O/qt+zmYKIyxewfrfW/R8vOuTdoD56zLi2YfGGRejdpknpM/ygZhem
         sM00TefJ3xEW4+bQAnwLl1ZciTsHh6qM/eOC4fPP1vqqRWb043oZVgBO4dL3p31btvlD
         NA6O0SdqijSlpJjbamSi/fOJmSLpmGB3z+Kk99Hkw/4SI7c+QIhsU0oJEzay5LPa0Q5S
         EqjgDFrvp1SrGcyHoLMHj71PZW82TOogC4NQ03tUNVUAd4KjWsRzyHOJhyBOTbomTo0P
         eElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382332; x=1721987132;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTIjdju0ng5SZUR/ZVbr+pjq8z5bsP/PxolugfMqbFg=;
        b=Yjegj3ghL1i6PMYmvLzbQNJxCi4ZG27X9/SRH+vWxWZKolGSE5ecCaxeTOQW972SkB
         MzCzlb1vXfxuO8ohthF99ToDMfuZPUQ4MfJXqmnzRcGrPLfEuava3c81ff0a/wxjF/rB
         /sJrODFaAz6dWbJMdfhzTA/6RIf90jBDMXXXHITUjj0dfZcOEN0W3lcvPX/roSbTo8Ho
         hV8t9OeYvNdFwxDJDETIRt0rew1+8BnYGvzKiVdNEMHDhxOCcwDyqyMbwBziOBbRf1Hb
         By6GrzlR20jFjpxkYGQQzoDI6HMLtobGGW7izFuyuBnyojRWAZt/HBL2b0im8BUaBzfd
         XJxA==
X-Forwarded-Encrypted: i=1; AJvYcCUtc0uJYTbNUQLn2mb0ke9GgcmljzuuTVxJ5+QiP7sNlY8KUFLSa2iYV+LMPVB/sSVLzyXWofW6mTk9tmHMQO/ts7d8kmkd
X-Gm-Message-State: AOJu0Yw64EeP1PSvQgvEcfxAfvZDDZ6zI32tVNODMK5XoVxcmZ2Fo2DQ
	cPnxYa5zgXuFErEfzeH9x1K/ZsLPNK4JTyptQvDb/nDKQqppniSitxwgAa83mQ==
X-Google-Smtp-Source: AGHT+IEVyJea5xxoF0+wpJnzDjtXmvoUTHSZX9gEcY2eBSEdaXs1ZKnuf11e4P64seyMGkI+54GAPA==
X-Received: by 2002:a17:902:e74e:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1fd5ec5b9b6mr14469455ad.2.1721382331995;
        Fri, 19 Jul 2024 02:45:31 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:8899:6437:d031:b9ec:7ff1:6aa1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f67esm819025ad.96.2024.07.19.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:45:31 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH 0/3] Add Firmware Upload support for beagleplay cc1352
Date: Fri, 19 Jul 2024 15:15:09 +0530
Message-Id: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKU1mmYC/x3MSwqAIBRG4a3EHSfYG9pKRJj+2YUoUXoR7T1p+
 A3OeSjAMwK1yUMeBwfe1ogsTUjParUQbKIpl3kpm6wSI5Rd4BZ1D9M57M56ZSDKArXWGKUpDMX
 WeUx8/d+uf98PcDP+bGcAAAA=
To: jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=wvQcdEWQ3/kLHsxtgCGRA9jYHsgJ/xrav2Xn7haRcMU=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmmjW1PzBconUuwkgIXGlPw5RQUNQ8xbEm8UvkG
 6vloBiAU6CJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZpo1tQAKCRAFzvXHieVa
 dCbpD/9aS52VevnNnvYRJQyq7QU3ADVpxmVpEeUX0SJrQSzSqlAch4f6iGxAxvwIWQOGfdDYMev
 7Kv6067Fj0544qQ+4t9iLZWeVxlYk7iZ/gisW9y+ZqF+sdywHAkWqXaC9lmJGu+WOn3FbG0kxJ7
 oXdyLbG8dSUpceaPFgd3b43qoBx1v/BBRCM+CWGMsw7DoooGlChFT7Fbn3rc0B8fPOiv7wViorG
 p+Tgxu9k/tFdSZ3hOagYhnB5hXNzdjfN5siI1XWSKNbV/6tjT3nhpvez7qFouoJChkdSDfSecSl
 JPcdNuwuWwcXNI45FthqCWrN/Txmxi0ym0dylq4b/vilWjcMV8iuXBrayPksG9oHjdNb5PnXvlE
 soQx7bJMsnFWm9bBX2VYkkHPvLmuMb99OxgrrUnG7IY2jEB4qhAzRP9urvGcBquduTsHrHKZ+A5
 Q5s6eNy0iRJwsZyp+zrLtD2wloyh8eEtHYq4v1f4FK1Hy0lHZTb+sffErg2EixdSk2zvLukrqbo
 EyiSBvxpRLef2fG88rg+ZaSVYiXNjiHB2VhzHt2RMfZ2aNZ9qi+KmqpiIQmSI+Svqh0y9D/3wIF
 UPYuppPh5mZmvDy0evdrAFReqQAlyLwDM9Rxp3x5UZHoFWpw7k/l+P89kGCPhKtrqk6Rr9juzW+
 9JY/V43A9FwOH+Q==
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

Boot and Reset GPIOs are used to enable cc1352p7 bootloader backdoor for
flashing. Flashing is skipped in case we are trying to flash the same
image as the one that is currently present. This is determined by CRC32
calculation of the supplied firmware and Flash data.

We also do a CRC32 check after flashing to ensure that the firmware was
flashed properly.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (3):
      dt-bindings: net: ti,cc1352p7: Add boot-gpio
      arm64: dts: ti: k3-am625-beagleplay: Add boot-gpios to cc1352p7
      greybus: gb-beagleplay: Add firmware upload API

 .../devicetree/bindings/net/ti,cc1352p7.yaml       |   4 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   3 +-
 drivers/greybus/Kconfig                            |   1 +
 drivers/greybus/gb-beagleplay.c                    | 625 ++++++++++++++++++++-
 4 files changed, 620 insertions(+), 13 deletions(-)
---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240715-beagleplay_fw_upgrade-43e6cceb0d3d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


