Return-Path: <netdev+bounces-286828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFDBFzFGAmpPpwEAu9opvQ
	(envelope-from <netdev+bounces-286828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330E516295
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA8D43008619
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026874D2EE0;
	Mon, 11 May 2026 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNvN+yeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1636CDF2
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533931; cv=none; b=g9vgKkJHGZfGz9/D+wCcZFjA9008fg1mZR4wkE+QENOqhJ7jG5/TQEVmy/pXxgeRia3iLHq44/+P+QEW8Sx5iWXSCQ4c+qXAsZxqXAhZc3rnb6Rd6OQ5pXhzXRVebFsFs2H1EIrVDAz4sVuBeKhgesVK1EPJlMqAYDVYVdQr0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533931; c=relaxed/simple;
	bh=nMfOcuzlsfj2HLu/5CLOguRtU+kQcstna688hRyKC7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tV72PtfKn5RBm9371+BiuMeYrWzV5zeHu5L4form14uWUp98rG7spV/X6tCgnPKH5CfsZ9iHOsg2iiye3Wc7RH8A4BSNUPtgIVeCB5MpDXEMt3qlAK1TRArrndqahR7Fyu5pzAXh5LQR72DozoODoQQt+V3VRqF2v+ClcQYmqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNvN+yeF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a535e7c00so56303207b3.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778533930; x=1779138730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhOGyLGPA7F4jxHPPar9sCu285p8q00OlGRJQCy53po=;
        b=mNvN+yeFtpHOCv1bCkB8GNdgBPEWi1wIX6R38F12u42ZjxUBlKCMg9h88mDd+d8DPW
         atr4PuAPt2W2b3CLRU7mUN1Mp39JJqKer0HyXpEy56XlcAlkFSwHEwauWiQ32H34iWo0
         VpFramousXeTLD17bR9l3wsmCKSrOqPSSwjSuJQh+s7Oa9M8RTL43OIqM2F771KxYpOr
         7iWNUW9mwYSXhsxK96+xl2gz1Zt66W/I+LzZGrxnHd/aL4XQAoVDJLya8ZrXDsLBxOgE
         W5nA5gcudlybHApOB/Smo8r2O1fW+HIEryXB+ZjsXByPMMptLl6jKThZRbhqw1eKuChO
         4pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533930; x=1779138730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhOGyLGPA7F4jxHPPar9sCu285p8q00OlGRJQCy53po=;
        b=iW4AMbTPhD9NvGU6B/Ii4PViu/IC6MkTgWRKjpsFiLIfBt7P48gCqmGeBuUzrmjXPb
         S7egGPrMm07gg6Bf+DYMBsHTNpJctioF9+3i38/o98luto/obwb3QgRTx1xxNJ6Wfq6w
         xabluVS4fr9kt09jEPrNfPh3JWHagjeVMYrBwwaSzOkb1vCfK+49WPhvW3yBK/vHodE/
         od1CRd1L3V4IGMty8XEUYOb2y5nW5dKOjNG+qgOUER5SLyg/cVite3LhEH2spszAEVSd
         AbNoshr6ZF/swn9qq26QL3V6H+hIcFKSJ/y3MWKBqG9vSNPC6V5FwA8k9EQUd7q2wEkW
         cCvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YwNr0J/MjtCo0q1SP5XwgLqZE6QEeI2hYVtIOQKRZkcy8WyGjJ9YXRo2DmS4lBllcUe2Uejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvngF4KTsWuDrpQ+D1RVS9DwKZtgAZeAVP264rFd5vEpXzK6b
	ITvbi9v6wWnd3VYJqDEq3+uN6wfMqb4AKA/ZdsCg24cM5Csu1m7g9ig=
X-Gm-Gg: Acq92OHnXEu6DUVDynObxVGRQdmhfrnL9CIp4kVNEKugiQU7b8Zv9J4A1BDPHbDWwFE
	FKtQ+4l6p4tBB5arG2cBq3U13IK2c6cEsJGJK0gv9a6QOY0XEgvFyynKrpJSHPXrkkmJTGAt1Wi
	uEBk7M+pte4ee3ptGSzGZP6vYnmintFc+2kTNJL+e7cG3H0sANSkSd5BbkQWLrDj8d7HxopvUQw
	8G+VAzpZnTC1OPANMFxAkDoCXnRZiHvl7pptigc6WQS8wiaEnliTaui3ChvTxQpqUlIqiw1kTs1
	wd/RG6h3lBU+tuDS/dKYYPFb0fIA23dGBTsM1PwOFZZiZKKJ5K5wFMT47KG7EQMxQW6MoYxSEqF
	+hN/fyJTwgiQTdUSiZ8YYFHVb0Sv7cbBTkcs8Hml0ck/vDQ5snyyG6VQ033Kmp9BYssbTe7+J1D
	FeLJGOS39x31UN+dCzzlfbzIWoEALb+vCNJ2bzk9obQQOM04b/xiInL+YK
X-Received: by 2002:a05:690c:e3c4:b0:7b8:926e:3ef1 with SMTP id 00721157ae682-7c56093e1b6mr777907b3.9.1778533929508;
        Mon, 11 May 2026 14:12:09 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd976fd09asm114553617b3.41.2026.05.11.14.12.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 14:12:09 -0700 (PDT)
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
Subject: [PATCH net-next 0/3] dpll: add SiTime SiT9531x DPLL clock driver
Date: Mon, 11 May 2026 14:11:40 -0700
Message-Id: <20260511211143.19792-1-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6330E516295
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series adds a DPLL subsystem driver for the SiTime SiT95316 and
SiT95317 programmable clock generators, along with the associated
device tree bindings.

This driver has been through multiple rounds of off-list review with
Jiri Pirko and Carolina Jubran.  This is the first on-list posting.


Ali Rouhi (3):
  dt-bindings: vendor-prefixes: add SiTime Corporation
  dt-bindings: dpll: add SiTime SiT9531x clock generator
  dpll: add SiTime SiT9531x DPLL clock driver

 .../bindings/dpll/sitime,sit9531x.yaml        |   82 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    6 +
 drivers/dpll/Kconfig                          |    1 +
 drivers/dpll/Makefile                         |    1 +
 drivers/dpll/sit9531x/Kconfig                 |   17 +
 drivers/dpll/sit9531x/Makefile                |    4 +
 drivers/dpll/sit9531x/core.c                  | 2583 +++++++++++++++++
 drivers/dpll/sit9531x/core.h                  |  282 ++
 drivers/dpll/sit9531x/dpll.c                  | 1147 ++++++++
 drivers/dpll/sit9531x/dpll.h                  |   90 +
 drivers/dpll/sit9531x/prop.c                  |  345 +++
 drivers/dpll/sit9531x/prop.h                  |   39 +
 drivers/dpll/sit9531x/regs.h                  |  359 +++
 14 files changed, 4958 insertions(+)
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


