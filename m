Return-Path: <netdev+bounces-248297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA6D06B0B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74473030598
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6825F1917CD;
	Fri,  9 Jan 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4vygikD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD714F5E0
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920952; cv=none; b=eV+cFIE6fWTrokta+L04CVWhHVZzwd3rq3WmXIlu+usbd15WDQkdSAZAE3D/2mJ9xZ2OqEVgKlhACY2dS1ub03jJl34AsSM9CibLf0YOWDxgxpe0o7OmhIkpAEMetJCvtup3x3BFYvhKA3p3eXls13TZxPEccpVXd8RIzQDezOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920952; c=relaxed/simple;
	bh=ONqeCW4HiSBwf0bq5i0c3lGVgnWCp3rE0EEr6vpHezs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHCODPKvxO3jjPQ3YhvUwyxpii5vxxkw1xVSsAxnVQkjB/aGndsowgNuOWIaeRYXY2rhT3M8TM7eQFcQqovwr9XwTAUhME/i0jBPJlRokyR+y33360iD22LI3cGjjkKiucuY815XjQJwDyIAT7JLqAW41zdd3eVb1+fW+/M8Cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4vygikD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb2314f52so1948156f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920949; x=1768525749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovaqthgiiNyRjRaRjKkpYbqq5VZXGfCJzYDNQIWreQY=;
        b=c4vygikDR74dPPZpgkILHun6J3sX2p8qU/N0hCET8hbX8enJKQS+AF58/UqzYL7CaP
         KNvV0FaT32Hz4LI++oJ6UwfPD7KIX+Vrt5hq8F0lOYOJd3oPmFdtJnwj/mKHkyEg3bGL
         nacEXN55mNpCHngmAqSrSLOF/DSQk9S3lU8q8l99qKDC7/28GnLl6EtT5KJB5XykAcR+
         xcc93zyAnPOw41tZ6vTpgcv8zLeKyjK/wFl85mzOL+Gx4PlZvgLaF5I2MEXqoyX0AF9P
         aHtZZtszNz0+Lq64hTrFblYhyZXPnKEIuzxKJjmn1ToNhhbPqI3S8+P0OYpAwIF42GKQ
         ZYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920949; x=1768525749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovaqthgiiNyRjRaRjKkpYbqq5VZXGfCJzYDNQIWreQY=;
        b=iUUg2YlWyj+WCGoCaKrjtTybdS/AHxFmcUpHbjAU9f4/zVzN0pQ0hQoUI6uHPW4yey
         CmrShSLNaN+z8DksnWZFFgSNlNq1OQOJvfQYVvGcDeTkJaJnyr54CW4syhjrxVmzbzmX
         q4mv26nG9eIby6oPsiRhrAI4EWccKLeZmViAjb9FcD73pZnXNvzE03KeG0wM4mCpfXUS
         RmXNc29iuWDGGTxeVNci/uHrpELVJnwk1c3oyoG57CozMEXMlT81xxPnYQplW7oIJ3Jl
         hlXIsUPmzCwJjdN21+IdViVh/vIOmJWjKT6vcVIZnML1k7TdvZrH5/dP2a1M96+OoXEw
         Pgiw==
X-Forwarded-Encrypted: i=1; AJvYcCWma5TqejkNOUA9DrGOKnCtjYRTET7c9JBHaZtuG19n/VM3idCTZRyqtbNVrq6JEy4iK8J1RHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfok7fCTZ9GsYYAg4BoTUE90Cqr5JLWwfXL2frIiq2/BtPkKge
	BZ5/IemeJ1quZ+XHJMhD8t2fGOVeG+KVbEI03bpzV6eX8zuGne/3nVir
X-Gm-Gg: AY/fxX4PwfcJMQSP99A+e0bBd6ymSp571NCSppYIn+uLqi5mXhPINbr+rNVd6ZcKMn6
	x6rr6SW4WeGznjs/c4vNaGZiBxLAP3kKoqIUfr/5KRl64/BDLQoyJ7SBPUoAx05p5b6M2PGVWeR
	CNcyHQoUxlP4g7vLv2+vv7QWmlEF/C6nKsuLIzhFFHdql4JtQo2l5FWGKM91xp/7WR1qMxuaDj/
	293t0ZM2w29pTXk0CQ0w7yy7dBs7WV+cVsMu++kDYYAeUX/nx09y0FK4TBlwxpFm77xzKnR2xLl
	+7phVw7o/Jg4OHOCxUetytNLI7rTcrGi0KUaxMYr4koRRT/CJS7o626v3w6i59p/uXJJK4kkPDL
	3S69UlrXFyzhqKkSi+83Pg7ox5vzh/BFFvPn0aVcR21x7BoZRhTJuG1h1GiVXPVlIOvWk/nRQob
	P4zotNI+I89Q==
X-Google-Smtp-Source: AGHT+IEiyNefltXIhrxLXN74WJ/hUyRYJKct7FokS4L4Pm02ADMDRmARI2ZImVGd+obdB+y//IBmSA==
X-Received: by 2002:a05:6000:1845:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-432c379dbbemr8476027f8f.36.1767920948842;
        Thu, 08 Jan 2026 17:09:08 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:07 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Daniele Palmas <dnlplm@gmail.com>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v5 0/7] net: wwan: add NMEA port type support
Date: Fri,  9 Jan 2026 03:09:02 +0200
Message-ID: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series introduces a long discussed NMEA port type support for the
WWAN subsystem. There are two goals. From the WWAN driver perspective,
NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
user space software perspective, the exported chardev belongs to the
GNSS class what makes it easy to distinguish desired port and the WWAN
device common to both NMEA and control (AT, MBIM, etc.) ports makes it
easy to locate a control port for the GNSS receiver activation.

Done by exporting the NMEA port via the GNSS subsystem with the WWAN
core acting as proxy between the WWAN modem driver and the GNSS
subsystem.

The series starts from a cleanup patch. Then three patches prepares the
WWAN core for the proxy style operation. Followed by a patch introding a
new WWNA port type, integration with the GNSS subsystem and demux. The
series ends with a couple of patches that introduce emulated EMEA port
to the WWAN HW simulator.

The series is the product of the discussion with Loic about the pros and
cons of possible models and implementation. Also Muhammad and Slark did
a great job defining the problem, sharing the code and pushing me to
finish the implementation. Daniele has caught an issue on driver
unloading and suggested an investigation direction. What was concluded
by Loic. Many thanks.

Slark, if this series with the unregister fix suits you, please bundle
it with your MHI patch, and (re-)send for final inclusion.

Changes RFCv1->RFCv2:
* Uniformly use put_device() to release port memory. This made code less
  weird and way more clear. Thank you, Loic, for noticing and the fix
  discussion!
Changes RFCv2->RFCv5:
* Fix premature WWAN device unregister; new patch 2/7, thus, all
  subsequent patches have been renumbered
* Minor adjustments here and there

CC: Slark Xiao <slark_xiao@163.com>
CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Daniele Palmas <dnlplm@gmail.com>
CC: Qiang Yu <quic_qianyu@quicinc.com>
CC: Manivannan Sadhasivam <mani@kernel.org>
CC: Johan Hovold <johan@kernel.org>

Sergey Ryazanov (7):
  net: wwan: core: remove unused port_id field
  net: wwan: core: explicit WWAN device reference counting
  net: wwan: core: split port creation and registration
  net: wwan: core: split port unregister and stop
  net: wwan: add NMEA port support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

 drivers/net/wwan/Kconfig      |   1 +
 drivers/net/wwan/wwan_core.c  | 280 +++++++++++++++++++++++++++-------
 drivers/net/wwan/wwan_hwsim.c | 201 +++++++++++++++++++-----
 include/linux/wwan.h          |   2 +
 4 files changed, 396 insertions(+), 88 deletions(-)

-- 
2.52.0


