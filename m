Return-Path: <netdev+bounces-244765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EEFCBEDBC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2171C3052209
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2F33D6C7;
	Mon, 15 Dec 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0/MwqUlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3433BBCB
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808263; cv=none; b=dXwicp7oKFyx5gwWZi7zwDfH4OAwShtPPs40X9dOEtCU/D2RzG8wv/1QSYSYVarGeeBKsIu6LAIKRNehmWO49S0MGrDnba6gQhH41wy7VTnsHU9Avo3JLoyjMs1R80Huk5TBwbe6gU2jQjcoMdmDTEcbBWpcbxsE+FAsOclBq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808263; c=relaxed/simple;
	bh=KVuyHGeUtpLkpGJYZbfb5WtDJicjtg3giXBlS+vhN0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sc7znAvEAFYjxXXtBACrvrHs6GyTXE1TU4oF8PZXchNqXmzkmwRjO7w5mMuhJ64R7k0uu3xC1U3JrnkTuCb6yi29M1njzFz42iu2wxtgYGx+sj2jyIJBmSYX2ckrIVrAo4nh+lmhewnB1i9goscpLgCx8+y5HPRzfeEheLaNLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0/MwqUlQ; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso5527821a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808255; x=1766413055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=0/MwqUlQdu789oy/P41nfqLWb7EnWXY85sbaj1smEzYO15dtuHKqLxDRGab17o4MUA
         D9TVJCvajbSn5mubZh7M9K5h4OT9pI/1qbh3beoBI1s+cs7/fK/G4sJRfPkfXVwqwBh3
         SXWcXenTFagxpnUecAa9mbcMVNCQ0U0akf+J4xD5CfLDcNwb1vJBMEz8cd19gt/edXo+
         6prwzju0rCEY9Jjuz4PQX50jj8chQizO7srmUjvdHU5PwJBwJQDO9vd0BIIvgTsOQttn
         fOSTaGyo9VctrEKOw8TJvYNlkT8bhVXwWSOKvHyDcKwgwrFzGeqWEX80uILWCX3i0XTf
         hi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808255; x=1766413055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppOcPFqIwq9P7NGqZqTz1/tjn18c3F+fMKSBb9x2/Cg=;
        b=mICbGPzTZgnleBoq43L0fHyENqrrEmz4l2yNCJ815Px1CcuUniUqRGRtysKrQSRlpO
         VdcZy8VDWKMpTVzzKoGHFaYmogwBrt4q4ll7N+uF9Ez7sIoPyWyBGAtVpnRBzaoab+fn
         lS5EApvQuywbwOUyexRlgkhEF2CtHlmquyVOZ1dLpWu+2//mfkB3ERqxAGBn7diVwbec
         ahGROvkgNVp0AiRstS63Ts8m/D+PsB/TYpoELRbYEboSDsEfq3BYa5YnmBCQT24eRGaJ
         TNan1Gmpiof/3oEBclZgG6CwSNLB7a53ylXhj2Dc9NqHKQF7funixBN9QBooEFTfW+GT
         z4bg==
X-Forwarded-Encrypted: i=1; AJvYcCVmYTyu7m+l1OfPDx6qLWt+BjDaKFJ9dX5TH67QKE27LD10SUQ7K+V9AkTdiTJutGPJlWVH/IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bNw3qof4TUVB5xl+85eSABITJCBN0vkF9CoOQt1X3b5NgKbm
	TI9pirmVZwwYqrR626d9r0cbaJAXh47Cpd8lP46B6aaLXL4M4Gi28SVEJL2b831OPk8=
X-Gm-Gg: AY/fxX754s2xwEQWVQ6uIpfj+QqPi9IavcS7KIWmxwsgXzXAoAcsZD6SEPI2GUItW7v
	Orrio7y4oL7tAWm4qb+Vt+C2iML8rJSpC28AxM+CdlY145rKy3TsPlr5BlLJRfUGkNzEz111LxH
	2/aafyCoc7XtXn9PbZKR0EuACM75Cx6RUe3t0PjddB8/Z0Nv+FrbEDvdN3uYXsc/nYXo+qxKk4F
	0nQe8ti/q1ggha/wMJbbC7q1sm4ZqvgDk4ETJKp5Gu5yRX0zjl24cvzcvpTzkWOsC3gsixvENOZ
	mqElq3/GKDKj5VumL9dvYnuZzpyU9iLKEnUMbwbbF8tCgMaEBQz94019yXPXXfXoX0MAeloKiB0
	HOZ28IDXVrdk+Y3n4ySdVbj3mSOUT8zSPMZsMOeGYkgZa4TGdIIzeOM0TGIihdcMeKSmdCxfSw1
	15IEt3VDGYlRl9LBe75nX6eNw9t1DuNLt+0um5qT2nx9cIYJYCSNdKgt3vrg==
X-Google-Smtp-Source: AGHT+IF5kWl8asvVZ2gDn2/ukMC7FmJVzWuHgbBPUo4GSSTrWpKfiHxIiV3JEK3vNep6zj7EVQ2rxQ==
X-Received: by 2002:a17:907:a909:b0:b7c:cc8d:14ef with SMTP id a640c23a62f3a-b7d218d55fdmr1188092466b.32.1765808254923;
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa56c152sm1380034166b.56.2025.12.15.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
Date: Mon, 15 Dec 2025 15:16:30 +0100
Message-ID: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KVuyHGeUtpLkpGJYZbfb5WtDJicjtg3giXBlS+vhN0U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhBsL1Z+rYFoGFHUfEy6nbD85QotpwGnuS0G OxYNqNRFI2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYQQAKCRCPgPtYfRL+ TugUB/9E31O/wKyUkNJNEPUiyayhLen3mT/3afyja8AKlZtLRRSDYD85SklWs8WUYR25f620Tug HCQFCBGP6zvWFDFUJWDts8iS5V7u/2f3fzK4EwWEIO8RjWf//RCGbcOXzrjD+gHhyiO4ntF2NWr 3ospR0B/APcHFEMI3zfkmIaPNlyEhNrddsNRbaHKA+WTWhZm7A/yqOnVYIJ6MLuTrhjHLZZoL5u gBimMOyT/Dmu6TUF9ex7Rhk+vookCt9jpn+vbxsz0ArRtMIo0W8fVdouxPDFA9SMn/bCn6BBJ+B fl85F7WiQwNbfWoeC8/qrjWMCGDfxgyRZi39jRQ+nWgTC5V5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of this series is to make tee driver stop using callbacks
in struct device_driver. These were superseded by bus methods in 2006
(commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
methods.")) but nobody cared to convert all subsystems accordingly.

Here the tee drivers are converted. The first commit is somewhat
unrelated, but simplifies the conversion (and the drivers). It
introduces driver registration helpers that care about setting the bus
and owner. (The latter is missing in all drivers, so by using these
helpers the drivers become more correct.)

v1 of this series is available at
https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylibre.com

Changes since v1:

 - rebase to v6.19-rc1 (no conflicts)
 - add tags received so far
 - fix whitespace issues pointed out by Sumit Garg
 - fix shutdown callback to shutdown and not remove

As already noted in v1's cover letter, this series should go in during a
single merge window as there are runtime warnings when the series is
only applied partially. Sumit Garg suggested to apply the whole series
via Jens Wiklander's tree.
If this is done the dependencies in this series are honored, in case the
plan changes: Patches #4 - #17 depend on the first two.

Note this series is only build tested.

Uwe Kleine-König (17):
  tee: Add some helpers to reduce boilerplate for tee client drivers
  tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
  tee: Adapt documentation to cover recent additions
  hwrng: optee - Make use of module_tee_client_driver()
  hwrng: optee - Make use of tee bus methods
  rtc: optee: Migrate to use tee specific driver registration function
  rtc: optee: Make use of tee bus methods
  efi: stmm: Make use of module_tee_client_driver()
  efi: stmm: Make use of tee bus methods
  firmware: arm_scmi: optee: Make use of module_tee_client_driver()
  firmware: arm_scmi: Make use of tee bus methods
  firmware: tee_bnxt: Make use of module_tee_client_driver()
  firmware: tee_bnxt: Make use of tee bus methods
  KEYS: trusted: Migrate to use tee specific driver registration
    function
  KEYS: trusted: Make use of tee bus methods
  tpm/tpm_ftpm_tee: Make use of tee specific driver registration
  tpm/tpm_ftpm_tee: Make use of tee bus methods

 Documentation/driver-api/tee.rst             | 18 +----
 drivers/char/hw_random/optee-rng.c           | 26 ++----
 drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
 drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
 drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
 drivers/rtc/rtc-optee.c                      | 27 ++-----
 drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
 include/linux/tee_drv.h                      | 12 +++
 security/keys/trusted-keys/trusted_tee.c     | 17 ++--
 10 files changed, 164 insertions(+), 138 deletions(-)

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3


