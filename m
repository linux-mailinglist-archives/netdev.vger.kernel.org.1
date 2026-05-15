Return-Path: <netdev+bounces-288251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNXqCT3lBmoHowIAu9opvQ
	(envelope-from <netdev+bounces-288251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:19:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7A54C481
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 718953085813
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47946426D1D;
	Fri, 15 May 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwdJwuu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC44266BE
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835485; cv=none; b=EYm5t+dnYX8uung8XSHO0RLUCQ3/+LeRwJaWuqFVsLKE0lHl0Nfxq2jYz845nw7Abtnqmhrg7Ca27ufrDyoFf0Jjep8O9iK5ZdTyNmMMGCe9F6UqfiFioNqIyavtToeI56bxB6jj3ZQVCwvaXJatab5YdFiXALjwmOJLJnze5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835485; c=relaxed/simple;
	bh=dyP4n9uPfOXLtZxIOJmI/uU/nI5UYjP6DCnh6DbN2Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XC8qy5UeiehWCfCWFXdu3KDKEOzl5sUP0GvLxRI6IFuLoTXnJVZjosVY1ic+yjaAa2muGVGrMxMnVzefD2Vi7hI3uSbBUjHNDo6oQYw4lbxF1GymAcEn8tUORc+Drms1xUAY5RSNOjsE+MiKU6r99cyZkBc25jn2X8nRlLgVaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwdJwuu3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd2c147abaso20569795ad.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835483; x=1779440283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JI5rbOuDA7OsqPK6rS6KZm2RpgqeyURJ5czLB7dxhv4=;
        b=IwdJwuu3fbspKY4M46qwfE07A8WvFOSz4mMgl34oOxhRdGNhwzqBAkAzgmDJONgcWO
         /rfrYcNtRiGEnyAdrmqYH84LLCQeREjdpE0zwj5994JUXOoj/DAkMppV2j5NZuXIPy/Z
         CAFd7/E9sd+mjo+k5Nh9NvOcNjYIuF/OZ+Fisj83doFwXoSObViUphY97xLhYncQSPUL
         VVtx2JdUsemqY9xKlxSj8mwZz7fPIlHoJFxZea9sY4qW5mhQiYPX7IhVOIB7DpFKo0sY
         igrikZblRT7S9fnn8mpMayBfG/pL35ZYWfBObHkmDZ5RJKXklCdxeH9Bg0OAftjaCVKH
         F+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835483; x=1779440283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI5rbOuDA7OsqPK6rS6KZm2RpgqeyURJ5czLB7dxhv4=;
        b=alUReNonfbAyXp2h7pgo6I8e44vHqKrXodWY9Qt4f3ylxdPVvL54+Mofu5Udowlej2
         hG2FwcfKjF184HzsRJApH5bHH8pXnYpkPhknlVlNrh01Ef2CqCzaO2j9vSghWSlZOvyr
         ILQVvsMgOhbG4zQG+kZRd0fZ0ze1oRMJNJkHS6X3PbDp+YTK38nZuBx2Qx3zkf1B7m/v
         NPSa1OllkFCrBSGa4S3EbCNH2epmT0A5sL8KBDGJJEo149adn9uCep+oQePVwBJW5+9u
         bk7w6PSUId9pCbaPDPKk6Lazn9UCsyS5M1McUXevJ7wayIVn+PyWwLA6c47KXiuLemC2
         ccUg==
X-Forwarded-Encrypted: i=1; AFNElJ9gDeuy6Dp/womllBx6fdR+tvDXiq3x7VLulsL8xGE6yvCp6ufA6Qi80nWPeEUXYu7HXOzW+i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhGo6oty+QMjo2peFq8wQMH3HaWI1i7zB+Ayg7Jv8XqpR6NEs
	/fD1/O5IRDVxiiQr/5hecbyhAjzaXyQdB7amXFQHA6e2Qb9jetV67Jd+1evC1A==
X-Gm-Gg: Acq92OHxPgpTR2AzeoSyryRlv4PfzGP5kIuM9EcBMPV42Ayo8g41D/hGwowji5qnTO5
	ypjDhTKU91VhlT4TFdSxKVjF4NReIIbSUTkSB3eq+epM9ZtmczoKqh/yMlWPKquzoca3CIv01nH
	Y3+7ZsfZdHhHHqePhByQzKPYTwO5VltnHaElvkrhPYyOnckxOHfyPijOPn4ay/Zk7ARvrsh8/yT
	TPeFewgareknAQ/DdQXf2hzSPEC6aguUeN+RhonYOh/+yPP74knEMZWINGE/3q4E38OJVuxeGuv
	oGsYIYwI1lbkcT5q3A8maBjwP+L1CdIiEpFfXrUHd3UcIgjH+1KZLLVAc9GCsGnlbvf4gCwAgcs
	5t5wmwzwVHrQB5VY55haf1qaAG0RKNM30YsoXEHwJ/HpkQlYs2ZrFMVChLvhP8eCprvZemxiZN0
	0dm0PCdnA94nuclIBNPJy+LM8MU3YO6NEZPpCCppoCEtjyVrzta7qgAy7XJE+f6eRA1Q==
X-Received: by 2002:a17:903:390b:b0:2bd:1903:6ced with SMTP id d9443c01a7336-2bd7e93cf74mr34268585ad.41.1778835482629;
        Fri, 15 May 2026 01:58:02 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6512sm52249325ad.52.2026.05.15.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:02 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v4 0/1] mfd: nct6694: Refactor transport layer and add HIF (eSPI) support
Date: Fri, 15 May 2026 16:57:45 +0800
Message-Id: <20260515085746.114361-1-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CE7A54C481
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288251-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Action: no action

From: Ming Yu <a0282524688@gmail.com>

The Nuvoton NCT6694 is a peripheral expander that provides GPIO, I2C,
CAN-FD, Watchdog, HWMON, PWM, and RTC sub-devices. Currently, the
driver only supports USB as the host transport interface.

This series refactors the NCT6694 MFD core to support multiple transport
backends and adds a new Host Interface (HIF) transport driver that
communicates over eSPI using Super-I/O shared memory.

Changes since version 3:
- Remove redundant module type macro definitions from sub-device drivers
  that are now provided by the shared header <linux/mfd/nct6694.h>,
  fixing -Wmacro-redefined warnings.

Changes since version 2:
- Restore per-device IDA and mfd_add_hotplug_devices()/PLATFORM_DEVID_AUTO
  to avoid child device ID conflicts with multiple NCT6694 chips.
- Validate irq_find_mapping() return value before dispatching IRQs.
- Check superio_enter() return value in nct6694_irq_init().

Changes since version 1:
- Reworked the Super-I/O access helpers.

Ming Yu (1):
  mfd: Add Host Interface (HIF) support for Nuvoton NCT6694

 MAINTAINERS                         |   1 +
 drivers/gpio/gpio-nct6694.c         |   7 -
 drivers/hwmon/nct6694-hwmon.c       |  21 -
 drivers/i2c/busses/i2c-nct6694.c    |   7 -
 drivers/mfd/Kconfig                 |  47 +-
 drivers/mfd/Makefile                |   3 +-
 drivers/mfd/nct6694-hif.c           | 663 ++++++++++++++++++++++++++++
 drivers/mfd/nct6694.c               | 111 +++--
 drivers/net/can/usb/nct6694_canfd.c |   6 -
 drivers/rtc/rtc-nct6694.c           |   7 -
 drivers/watchdog/nct6694_wdt.c      |   7 -
 include/linux/mfd/nct6694.h         |  54 ++-
 12 files changed, 813 insertions(+), 121 deletions(-)
 create mode 100644 drivers/mfd/nct6694-hif.c

-- 
2.34.1


