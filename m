Return-Path: <netdev+bounces-194391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57FAC92CC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC273A2A73
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF552356C7;
	Fri, 30 May 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOP/+MQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE01235346;
	Fri, 30 May 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620584; cv=none; b=CCbGYK58jxxMs97rCv+4eOi4JAYes226UN0Dtn/jj+aENIje6RfIEyUaq3xUiycmNeeIXG0LIPHnfJkzlFywHidmuwEk6Qet62MiP4sUkTjaHcRCbpvDuputRBtHpNCmQb66wEYyV7es418ehcV0BdlViFchlnmB3vfGLCE89yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620584; c=relaxed/simple;
	bh=AD0Ki6SWTzpLn8aU7fwOntIH55X1QYvwkqjUoszGwGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KxgH3TJoh9z1uyZ4nlkzcCXdst17jw4VHV3R2GBf2ieqB65oqP+4ZTNa/+KyUpGaIKJT2Q/C5viukSX/uWzasCVU1kSHpFDZ/PqSD4+0YLtciGLLi8VOkdWYkkGmxIl8x98tISXK6CHEs/RiIX3LqKln9NVOH51SqsW003fdqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOP/+MQU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a361b8a664so2155137f8f.3;
        Fri, 30 May 2025 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620582; x=1749225382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iy1tt218F4IwK8PlrWhyBFc9NYA/5PWiYpKnhTWXkAA=;
        b=fOP/+MQUST9ZnriGBL89QDu8ZHVBAIFoUtP+gKA3JU9NWKdK/xlyb+DhGBfDzRfd5Y
         kWfbGVxEmj8lWMI6TfTR/6KzkE//DbIfqJyJzQWdleqrTOwAsC5IGqRpHX87Jx9/WKvn
         dqF3RB+58lbdAn1OuFsAjVsN0qgOm4vVbkd/AkInpvq7o1b7UU42ThdiZRnk9jApZ4Yr
         5m8GEGQhdD8lPKTEgP4nqh5HuM1/hns6dh6GhwyzA4OBERXoPAzu49l7GurIUnijZyIV
         BsO/7vWRybdlqogNXh7CxePtZ61SY2q/0GtTTrjfJvGUEvR9nq/jaDC58NOYYDcRmHXe
         bgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620582; x=1749225382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iy1tt218F4IwK8PlrWhyBFc9NYA/5PWiYpKnhTWXkAA=;
        b=cW4bja9ZOhSYUboXICJghkj/GIxAn0yGreB/iwyqK/fyH3JTWVdETflNfXJkyDHP1T
         si94T0YB7aoiOl7jWyt6o7V6HWQOhJafTUF51VgT1+GWmwAJAEP8IBBVX/7KMvkvj973
         EQpDtD/+gq52WaZHd5TKaWqyDRWVV45LJlx+uHG5NnQcoTFCaWV3VK/1aIdjd6uYO1aJ
         hsn1XUsJGT3yTfx5IbUMNBikc0jjwYhVIGQLOqeDHB03xf31JG6nftEiAVWkXBRuWKBL
         KEMwKm32kXQ2IIc5SWZzOlJv7mNkK2inQM1N88nT/Bkf7I0eVjdniRRIDfq3DzMjDZo9
         BXOg==
X-Forwarded-Encrypted: i=1; AJvYcCW/N3qEtg8yFAOOBXjcL3Yes/jGDKWq0XE/fmps/xrI+HKfCPe9U1B6xvdgDzpc3DhW2c/cMN3uiOTsED0=@vger.kernel.org, AJvYcCWGqWGi8fxgl4lKF5zRmG+GKV0M7WKK0BgCfPrxOS51jo0u5loOrHtvyLIRiyPIefcQPyWQx0Kx@vger.kernel.org
X-Gm-Message-State: AOJu0YxpmrxxBwJfv94fwmLt6Od59Jse4JzzIoGMUJcBSDmvsAL6AkZM
	s8A0/Wb7jVB5LUyT8njTLtkSB8F6o02SfHQE7IqhZwKUKtAkPjnE9PtuH4GXRA==
X-Gm-Gg: ASbGnctykGL8hStA7IJGEv0wkAJvalzCqhM+aymTtRx4JA1O7PGvcdweU928Bc5/bju
	Gj71n6hxuRtVyDjlq/a5hHtEsQdnhOoRCdMU33dDODPkKlwLERmWKeXzlxkk+QobxM0JvxToHS1
	VZMNoTq6t2gmsv3Li5ICDf6Py49WmiuGkps1W4EvJb8USKoO846y8OK5nt3Udqum0/C6gRC3kQU
	Wp43Dlz7xtl2fUoNeEyEWrKhRw3iYfUUNUcU3z04/s+F6Pje2JdpaFQouIOueJ1S51Gn9/DSa9r
	7R0JeYN4GBv1YqGIwQE8jYKt/v8aMV2Fw5yNDZWupDwzmT7yY414Ut8NcwZu79Fb/rK3TQBPlmE
	QvOQv//CqaaHb+id7Y6kT8X0cHIlUxyNIKPVE6t0eB8CpCVJ+uVsq015/KpMb/nI=
X-Google-Smtp-Source: AGHT+IEJDQy3UlayczvuvcXAish7JNZeKcxGj1Hbh3xGg4s4JGgnZ8HlbSdwU38Zijw+TLhv6OFlCA==
X-Received: by 2002:a05:6000:240b:b0:3a4:f24c:d719 with SMTP id ffacd0b85a97d-3a4f7a816a9mr2841552f8f.29.1748620581395;
        Fri, 30 May 2025 08:56:21 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm5211620f8f.53.2025.05.30.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:56:20 -0700 (PDT)
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
Subject: [PATCH] net: dsa: brcm: add legacy FCS tag
Date: Fri, 30 May 2025 17:56:15 +0200
Message-Id: <20250530155618.273567-1-noltari@gmail.com>
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

 drivers/net/dsa/b53/Kconfig      |   1 +
 drivers/net/dsa/b53/b53_common.c |   7 +-
 include/net/dsa.h                |   2 +
 net/dsa/Kconfig                  |   8 +++
 net/dsa/tag_brcm.c               | 117 ++++++++++++++++++++++++-------
 5 files changed, 109 insertions(+), 26 deletions(-)

-- 
2.39.5


