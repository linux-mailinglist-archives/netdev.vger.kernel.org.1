Return-Path: <netdev+bounces-196226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25FAD3EFE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3463A4F44
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9423FC49;
	Tue, 10 Jun 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6cdJNuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C176BE46;
	Tue, 10 Jun 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573121; cv=none; b=njzBn93VuAtyql0aej88yQ0hhpZjv0i+89cqytw3yw9wUNJKDwe/Ctt1uArFbM6jv8H5wtn2VDUUyIx8+CaZoVNusUaIkbnLOy3wJ1eCgimvGCPU5dcbhiKGzI0JMoykUGoc020V9faaJ7fE6VBeAxaQ7NTlzL4Bx0PA3220bXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573121; c=relaxed/simple;
	bh=XqhjCuvxCuxQHQuuAXSnHg+MRdHvVNkNcu0482rMnKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gR/NakmTpyq2sTFU1Mly73MzaWO9l5WboAogUeD+/h8Z4Tv+ZB7R6leKfT5AEBJEiHjw1CnkSxToe+cwy/cSLNBmzy3pUBtjbQsJgf6z0VXdM9kHawN6PpxqtRPa2RPmaQSw+AwlIvC7aGX68Jo5pHAcjlN+NUQ62ZuG37iJOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6cdJNuC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a52874d593so5457413f8f.0;
        Tue, 10 Jun 2025 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573117; x=1750177917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUVmRn1PGPKIP8YksNnxi8k05jxTc+s4plCyaneI958=;
        b=V6cdJNuC+OZwr4R/YfEECvj1hyUGEbi8NqLrwe64hhmwK/x0XTa1aEp5r8Mj0MdRPP
         flzty4ujhczSt6a6i5SqgfO9jvcyhDTnbcgwlSnk8uSDN7DKwJlHqMg/XmhkrRgkv7V0
         NlQPaSrefWXaSJ/wPBaNWoXWQO9GiOO1QgiTopOzD5s8CoLAch1L/EcjwN6ALbWfK7V6
         yE25AjB174ApXurZSE3vrWcNq4vL0s1qQ6VHzq89tsuSY4Ojso+iTvoJ10yooONFrOou
         X1mBwobuMCb/ojKRncbdH+9rEc9wHZi+NztiRpSpH4K+ZT3xZAeUBvBS8qjqRx8NnQYw
         FAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573117; x=1750177917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUVmRn1PGPKIP8YksNnxi8k05jxTc+s4plCyaneI958=;
        b=HU8a+LCnBo0IsBef8ZGEJLaSfE60oXHa0GsCbGBatEub62+hCJpH2DldX/O4ZnBE4b
         bS000weppIpretCckfzA1e+NkzwHHGKaIWnmCKyU9t+JBkn9m2nzvCqE9zxZdqa9+hDE
         ZQ+Xny1V1sDFzD59VtFmswKMPtKK2HwGjcMAYRw/RztdrVOOKeU0fKDcl2tXMB9bIRgL
         i8DO3PPJhHd2qqcLqaHPsdGBzqSt/pCX5B9XfDOFV5GblHIOqx6qxluuOSUiZpRlgS2n
         5dVVAJfqODBeih78M5PcMQg6AKUob1UxgFXNwYM76HiQVztdivWusNC3z8BYAIMCvALz
         V+HA==
X-Forwarded-Encrypted: i=1; AJvYcCUzC4KsOaR+130pX6+THAEyyCc6gNaULj7eP3ZapOwpEYB3SDyCwVc3zZ/m39+ma+GCrRagLsJK@vger.kernel.org, AJvYcCXiqUDO45ryWnymRmSxRhiXyrAjmAQ+8cr4okr3/orENPeXIBN75dkzygHiLXEEC8lfu5yvXjulV9kKmOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzotOn9F0G/R5Ud/6yTtaoc+8n0W+vSF4pjEPwzzaxKklXV+Xen
	2ShiWbaVgKuO3ZmuC5Ne8m++wW1W/2j3Eu4AQz/1j0eY3YyWPC+SvODL3CtxPg==
X-Gm-Gg: ASbGncsjkdtSj5/50QZdzgipVIpvKJIID7ovlzC6ftl8+JRGlBcbqPevL2cQcySTYFU
	ucNZsH+v9FxExTu+hR8REEqo+U0x95GyaTxllIvWihFjvxmKOTUXPAWQy8EpzO6q+ORprBfEb/v
	/6MFgMXPbnkke0WbHEsgQXEpxQFoGC43/y00aIuwC4GwTX+14KIer1eRZ8Ypu4Dblpokw136arL
	jLXHY02Ilb7I6uVlpbXmOfAy+/ehFx5cXD4p2zywpldNKy9URMkePGUyA/25BMz267q3tvtaQkR
	1lROIpPRP9HqxaAx1W+WuTSr+Bep+1EYTZfS6wRSWpCLJ6NWvWTnDiv6akTwaS1lFZsKwjP4dU9
	w+vgkJr0rSLiqH+Wq62QoVnunB+dYlqnpOWxCpQy6leUSOOvQwC3wYYYsSRYWUhM=
X-Google-Smtp-Source: AGHT+IH9blqVZmvKw5L61Ti2+ZgpjoHVoxX1v90TLcA+X69Cf8Uxd/XsLtT39DwqAVIuKxYZo2LCEQ==
X-Received: by 2002:a05:6000:4023:b0:3a4:eed7:15f2 with SMTP id ffacd0b85a97d-3a531ab6c4bmr11993770f8f.43.1749573117164;
        Tue, 10 Jun 2025 09:31:57 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1900-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fa6sm12494857f8f.48.2025.06.10.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:31:56 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v2 0/3] net: dsa: brcm: add legacy FCS tag
Date: Tue, 10 Jun 2025 18:31:51 +0200
Message-Id: <20250610163154.281454-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The existing brcm legacy tag only works with BCM63xx switches.
These patches add a new legacy tag for BCM5325 and BCM5365 switches, which
require including the FCS and length.

Álvaro Fernández Rojas (3):
  net: dsa: tag_brcm: legacy: reorganize functions
  net: dsa: tag_brcm: add support for legacy FCS tags
  net: dsa: b53: support legacy FCS tags

 v2: replace swab32 with cpu_to_le32.

 drivers/net/dsa/b53/Kconfig      |   1 +
 drivers/net/dsa/b53/b53_common.c |   7 +-
 include/net/dsa.h                |   2 +
 net/dsa/Kconfig                  |   8 +++
 net/dsa/tag_brcm.c               | 119 ++++++++++++++++++++++++-------
 5 files changed, 111 insertions(+), 26 deletions(-)

-- 
2.39.5


