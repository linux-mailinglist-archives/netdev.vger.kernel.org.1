Return-Path: <netdev+bounces-282861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFKrJv5Y82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 119194A36EE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A783007650
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6B42669E;
	Thu, 30 Apr 2026 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKaweblP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF85423A9B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555707; cv=none; b=kxEdhMRFoYy04XOZQsaIWNZev6tvOVSn02qNqyfi6s0AXvvbiB2fuJz8ovSOH5t+JBdef3d8WTlax6Fi+/YFeeDc7h2p1tGBaBpbETuPNO2Y4XB2E3ma8dJQmvGsRAy7qo0DFfCZZuYJojrUp3Q+UdFro4eHvqGcsUoZqu3yrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555707; c=relaxed/simple;
	bh=6IRZDJj+r5sp+QVknT1l4Md6WM8TiqCR6LQHlxM2R3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9mnOctD5f6hsuUaiTwmkkYonhimfPrxEgjrioCdmgfYQdpc3eqyxfS+KHVKYB1UUW8/dBBe+vKTH4vTqafq7bz4HdDfJe77eBwal2dmDSI4K/e6oG74ZbzM1JsB7QAj8hb8r09Axr80Ph4n0jfxNhPnbm/uAJylkGYVpeqQ46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKaweblP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7b23713eac9so9878877b3.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777555705; x=1778160505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey+vtW5zGSIcS5Imm4MD7T8reur80NswJgiOxTbyp3o=;
        b=RKaweblPPPKB2u6vCMtKE8JKAFu7aHW4Mq1o7zNyOD7s9Q5r5LPKYtkz0RWLAv0IF3
         kQPa330GniI+5e2QfTiBpMk6PMxeLrNfpxHOaqolFKJ0DZe2lW3N7ee7CXaQRwki0tpf
         XX++sGG3NpG5GDJaRY9WcCzKvM04090lWNyHCB2W9xT934BF/xKBvSWktA3WcZ/26xUn
         xkfz0cDOqvmCnwF9czR1/IXrnokAkb8mx2kfzxZZLTRAs9boZjtrsSSN28q6vpfmCmz4
         cZmfjVD7CDyKRD3YWuCHTVxjXcegT8wpHR2DSvt2a00selJilFT0SmwHjdxP+U9qcudM
         i8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555705; x=1778160505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey+vtW5zGSIcS5Imm4MD7T8reur80NswJgiOxTbyp3o=;
        b=hBO1Z58smCTrDPg7A8xWaG1SHsQSIxhpOg/w8u+8Y5TYZ0ZGSfEJ0cOMaQTB/w9Xbg
         A3lb1l63XekPlodenUjBNPKQoaGshGmxxOQGirkJV44Qu6cYrFSc3s06JSljQTrnVMh7
         JdSXTWz6lN66fKKyqIFZRE6WiabbhNsDvQgZhhlT6fNr7lD7Zd3jKiu+dWvzmHo512J9
         biv+TAeUFVVbF1ocqC3XmRhntSEsEvf541e+nkoSs/ICvc77ngYmlSrEiZ9WAeG6gJ+u
         YCjPoWvOjeMw6eGiPs4Ug1uY1kdnfIcav+paXjNhsNWptvtAZMSoGqlaIrMs2OC7Fu6k
         xE3Q==
X-Gm-Message-State: AOJu0YzVqrp1o5sjCktVAPNk/phD4YWNCOL+WlV5SN+26wQVn8op9udz
	IPQBtS2fCVRL5LQSktsmV2G0Mf8b4L1MmEY754vIJMIbWeEFJfUcP0NS6elvoA==
X-Gm-Gg: AeBDiet1jfHSggI2KmkB8QgE/qxN+fFb8yuWc+BxB3Fm+fNLwjTLeKYBt7xRfCjEJXv
	jC53LniCSdX2gWVnHLjaS8TDvbZG6IPJdRJyuzKSm+AZJjIPH+6yEqbGf6rxe7SOBMHpi6b9Sgy
	CsNXb1adX5T+nLJz3inb/peUJk+invCWrZrdr0FDX7I5+Ii7JOiJxd2TgybpiElzaVdXCCWcfYc
	D/Bhgy0aO83hx8OJ+My1K/AExHNVmNoI7pVpdbtc9yvJdqpZHeNRIFaQkHDGNodWVvDxKXNo2PP
	SsXS/rWSkuz9WIjbnIla8mQ5TQRdj8QitaImCXXB6IGJ0bKUX1zYunAIQRWIbmxcAiqPHQGn2+z
	NVaB+L/PxLjU9Sw/e+OOhkrlZKtc3dx+PvEaElyoL+tV7FhBrj0Ex77Gi/ZGAsinElKVsGtLlLd
	JZG7XZw2irdMvrLIaLUzzQ5IH6Aj3S+8x1ILozDZ7O4x+s5hmObAaQfCcDMe9tKLr9/EZHuhb65
	hnLPTmwoERiquKQmV0teKane+aaXKwM1cuGJw==
X-Received: by 2002:a05:690c:d1d:b0:7bd:6043:7eab with SMTP id 00721157ae682-7bd604387ffmr4540877b3.45.1777555705511;
        Thu, 30 Apr 2026 06:28:25 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b332fcsm8592957b3.16.2026.04.30.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:28:24 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 0/3] selftests: drv-net: convert so_txtime to drv-net
Date: Thu, 30 Apr 2026 09:28:03 -0400
Message-ID: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 119194A36EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282861-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

In preparation for extending to pacing hardware offload, convert the
so_txtime.sh test to a drv-net test that can be run against netdevsim
and real hardware.

Two preparatory patches
1. support negative tests, where tests are expected to fail
2. add a tc helper 

See individual patches for details.

Willem de Bruijn (3):
  selftests: net: py: support cmd verifying expected failure
  selftests: net: py: add tc utility
  selftests: drv-net: convert so_txtime to drv-net

 .../testing/selftests/drivers/net/.gitignore  |   1 +
 tools/testing/selftests/drivers/net/Makefile  |   2 +
 tools/testing/selftests/drivers/net/config    |   2 +
 .../selftests/drivers/net/lib/py/__init__.py  |   5 +-
 .../selftests/{ => drivers}/net/so_txtime.c   |  25 +++-
 .../selftests/drivers/net/so_txtime.py        |  95 +++++++++++++++
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/Makefile          |   2 -
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/utils.py   |  18 ++-
 tools/testing/selftests/net/so_txtime.sh      | 110 ------------------
 11 files changed, 141 insertions(+), 124 deletions(-)
 rename tools/testing/selftests/{ => drivers}/net/so_txtime.c (96%)
 create mode 100755 tools/testing/selftests/drivers/net/so_txtime.py
 delete mode 100755 tools/testing/selftests/net/so_txtime.sh

-- 
2.54.0.545.g6539524ca2-goog


