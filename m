Return-Path: <netdev+bounces-290073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPP3BsokDmr26QUAu9opvQ
	(envelope-from <netdev+bounces-290073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03659AA8D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F19153024801
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052DC33F8D9;
	Wed, 20 May 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2oIsDOd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B6306B1B
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304851; cv=none; b=SjI+5BvEWqopOgJsDBoecIYFVztgHWvf8qsB5dHxdMarusAJvon6wtDynP7PW3vKhDOijHv8tuXEm/buDSLOIeWT+rtoRVYnLoyz501fPBpB15xc8pSox0TUqNGIUjoEcI6zhBDny8p/HpbeSCFdfV8c9Ykn7E3Vnrz1ii4aXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304851; c=relaxed/simple;
	bh=4/Lo7ChhuzCpClfioxkED+8KA9Q5Jky/0/oWzVmGRRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpVtUaFIVHCB7xLZqWUSci2rq6Xlk1+FOldaTkiIcdBLDJj1Eu1LoNyYnYzNblLUL9zjrLKQxxOhqHJynRx76Qqdu5nWdFkChLTQgcCmW2zjlABALvjeIn44E4sxti7RpPNz2yq02HzdTZiUEsvfG7LH8w6jV1MmGiw2hLjUd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2oIsDOd; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7cfc382d896so18776007b3.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304849; x=1779909649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9UA9aEbbdQ0kKVzOUrQK9f5EhaQWo43O1Q7AsJtofw=;
        b=h2oIsDOdoLo5f3q0/5La5e7SVctBEHZH6WpbU5HldSuwqWt/o6o+1PGCRKu6OooQhT
         pHvRM+v93zP33fuPks3DSWMSJu8RISUqrF5JF8/eFl1MMqMODdZ//JZm/oNxItGJmWPC
         xRwaJk1zfECe1i+2RwtVKFwEzcvt+3SE7wZy6FbkI8vcEZTrAdoVP2tMrUPLa9sz9Mlz
         fpvm9FU57LtOK6FFaFBUfvC4ueQ53/3lOwpYTtxoy8iYdqg37crHICO5FWMGl9bXBi5i
         RgmmBhQ++L92+Zy794JltufIuAFUoz9NaQZiVLSHz6/GfNR6pww6UvoDgYONsvwwllMq
         ZjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304849; x=1779909649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9UA9aEbbdQ0kKVzOUrQK9f5EhaQWo43O1Q7AsJtofw=;
        b=biZcVUgTh1hv3UIVMYJvJ6mmMsh3LXsYPZJ3FxGA7TAAvIynyycB/EG+Qn7xDhZZnP
         SeymRJDZ9YLE/TOLWX9GQwstRDdc/cAFOcDMUnkZWI1DDn31BW+xqMKy5IO4aBJoGtHQ
         v5iJ/aP3Fft5GOq6Ho1uSi3x/HSIrjqLyDoPAFNI2ZG0xOYKZL1R4D5pbD8MO2JIpRpF
         Ew5OoWzMyqFMsHHdnEi+HXUm5/jVv2s24EQNu1osBxj9n36Po5ZlMUsLiBsMI+iZ11Wm
         PK6APVWJNl8bwx0riQCOE7JuUTqkt/Lwvej3aS5m1M7nwIksW1I4IUZmtn1wcqFScFG4
         O/0g==
X-Forwarded-Encrypted: i=1; AFNElJ+OaqExFB4CfObazbeWmOWchwde81vdatCtNNHoLswSJU2EXBOju3YOBUcUVsgi/PdmUwDDyDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxyHnJWP/DPWZLcRzNat0uX7+4yd2QNLN0SNxZaps061RTT1r
	2gv4djExpUkQMLUEeQD6cKzBslQb/Pyqdr1NbIbzIdAs6/WM1uXPXrU=
X-Gm-Gg: Acq92OF1N2F+iyK/XcyGeTWphKHcq/iXJ1dkBj5ky9bzdmNtINEJqpp7hp1yq7XkaVC
	JXMV/CadKUsN8TlDj9DnXmT16T17QGKGjCoBKRULoX+nQxOJ8KyGIu2Nqp1/W57JxsS6Ijnic7L
	5NUbLuHX5AbzLX4SPEA7xj3qnaig7todpGwKmePlwb0NsYiEuU33Cs2spCDbjj3RJldAb2s2OIP
	cQ31CeCXzHuUxH+5MlJmf45HAflsQJMxN8nOKZoekEfbpNlHeL6vzryzR9qZNfRVVxZJqjtbqmq
	+eyxwElISdpBHUfyIRPcsZP2H7LW9QV+T1Av4awHCL8r46XQELsJdeYH9hevaSQ1Py8Ch1dEdS/
	Jwh1eCvqU15jZTmzyDppqwK+6N+rtHcVLJJ8E1g2KV0OwFUU3T7S5JW+GpbJ8yve7cR9NzdePD6
	zyE/yPbzQgEBLk2Kp1Hj7js55te7Q0MARxAgah7I54XfbnnQ==
X-Received: by 2002:a05:690c:350d:b0:7d1:9c6a:d60c with SMTP id 00721157ae682-7d19c6b0ec5mr19272437b3.18.1779304849408;
        Wed, 20 May 2026 12:20:49 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm56346757b3.49.2026.05.20.12.20.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 May 2026 12:20:48 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH v2 net-next 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Date: Wed, 20 May 2026 12:19:40 -0700
Message-Id: <20260520191943.73938-1-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-290073-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sitime.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,0.0.0.68:email]
X-Rspamd-Queue-Id: 1B03659AA8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a DPLL subsystem driver for the SiTime SiT95316 and
SiT95317 programmable clock generators, along with the associated
device tree bindings.

This driver has been through multiple rounds of off-list review with
Jiri Pirko and Carolina Jubran.

v1: https://lore.kernel.org/netdev/20260511211143.19792-1-arouhi@sitime.com/

Changes in v2:
- Patch 2/3 (DT bindings):
  - Remove Linux-specific runtime description paragraph (Conor)
  - Simplify reset-gpios, interrupts descriptions to hardware behavior (Conor)
  - Add allOf: $ref: /schemas/dpll/dpll-device.yaml#, switch to
    unevaluatedProperties (Conor)
  - Add pin sub-nodes in example 2 (Conor)
  - Rename node clock-generator@68 to dpll@68 to match dpll-device.yaml (Sashiko)
  - Add clocks/clock-names properties for xtal reference clock
- Patch 3/3 (driver):
  - Fix SiT95316 num_inputs: 8 -> 4 (Carolina)
  - Initialize xtal_freq at probe via devm_clk_get_optional_enabled
  - Move DPLL/kworker init before IRQ registration to prevent NULL deref
  - Clear notification latches in periodic worker to prevent IRQ tight loop
  - Use clkout_map[] in output_phase_adjust_set() for correct register addressing

Ali Rouhi (3):
  dt-bindings: vendor-prefixes: add SiTime Corporation
  dt-bindings: dpll: add SiTime SiT9531x clock generator
  dpll: add SiTime SiT9531x DPLL clock driver

 .../bindings/dpll/sitime,sit9531x.yaml        |  145 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    6 +
 drivers/dpll/Kconfig                          |    1 +
 drivers/dpll/Makefile                         |    1 +
 drivers/dpll/sit9531x/Kconfig                 |   17 +
 drivers/dpll/sit9531x/Makefile                |    4 +
 drivers/dpll/sit9531x/core.c                  | 2636 +++++++++++++++++
 drivers/dpll/sit9531x/core.h                  |  282 ++
 drivers/dpll/sit9531x/dpll.c                  | 1147 +++++++
 drivers/dpll/sit9531x/dpll.h                  |   90 +
 drivers/dpll/sit9531x/prop.c                  |  345 +++
 drivers/dpll/sit9531x/prop.h                  |   39 +
 drivers/dpll/sit9531x/regs.h                  |  359 +++
 14 files changed, 5074 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
 create mode 100644 drivers/dpll/sit9531x/Kconfig
 create mode 100644 drivers/dpll/sit9531x/Makefile
 create mode 100644 drivers/dpll/sit9531x/core.c
 create mode 100644 drivers/dpll/sit9531x/core.h
 create mode 100644 drivers/dpll/sit9531x/dpll.c
 create mode 100644 drivers/dpll/sit9531x/dpll.h
 create mode 100644 drivers/dpll/sit9531x/prop.c
 create mode 100644 drivers/dpll/sit9531x/prop.h
 create mode 100644 drivers/dpll/sit9531x/regs.h

-- 
2.43.0


