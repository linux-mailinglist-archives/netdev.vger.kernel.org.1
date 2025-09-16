Return-Path: <netdev+bounces-223368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54EB58E39
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A731BC2FBB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520E1FBC91;
	Tue, 16 Sep 2025 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AltbzPJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8CF1917F0
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002606; cv=none; b=d+oFniq/i/JhdCSN/k1vmtQHnTgLW7ouOZAgcs9X4JYiWAsEL/3DoWZ7g8JOpEZ2rpIr9uVu6sq8sRZe9J6CBlGUxMBCGam2TihZR3a1XSr7UefNPmuAaFN52CbaMwFNiiZ5Lp4DQojHcLa4pUHPlomMssR7dquLCfL8KPreJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002606; c=relaxed/simple;
	bh=yLz9txVwcnZbWd4ywhxn8K7GFJpnpjcbZ8DpqsNG4Sw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZhGJKns8H7XnOZ/U33dw7fLJL0OOvYRGenpNCTjtEDOAjMggYJ4qHLwj7kBhOcWUciFoNoVfLo25iTsTpwMhBWZiCSZkiBoUIaQ5qtHJg2MidAfZo8VgLZ0hzSzg70J6pkd6eoay/LM5pa1OoJY0KxhkHicsfKTtedxeS7+o86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AltbzPJK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-263b1cf4d99so16033015ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758002604; x=1758607404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOJIcs5drTzBTEY0tV1pMT9TX9JsWUffwaHGsiB/nGA=;
        b=AltbzPJKCoEREjS+s073KHZbO8NHhSxyNWNEKBQI4YZdtUm3a4UluaDNDwZSvOjwnZ
         RnNcd5WQDcGn8HpMSOUxMgew6PMMi1Ya0A/AvvQdNwPk2W+okh55kDBuWCSjpQAuZsNK
         lkLcHOxmGaqBarPgODIJrcYb8scOaASeZrsml1XQisiOe16CrxuCVd8nAMhch+nP3W+d
         OE2hjlzyvzOEzTIrY3uAU0khtOKnCq0Dwu0l5VVDJwzencH+ucNFxIfhrWUhcwpy3ToH
         IH7vOjQKwE6YjgD/Vpp/j9pVz3ES/XZ7o1d3l6NhYKvtzX6RZ+SzM4QiMU90VeEJ0U0h
         6Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758002604; x=1758607404;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOJIcs5drTzBTEY0tV1pMT9TX9JsWUffwaHGsiB/nGA=;
        b=tcAX3rZoSm7Xee3aMUxcyUJbGXqSblbQK+uHy2/NOpot6/aY1QZX06wiJamxsBUeDz
         TiST0nQDrZdTFDh8+7BKAmpRLPQh/4B/q1s5lyJgj/z33WYIXS0mxB00DAgxtBqXE6IL
         3Jb+XUh/RM8pDl/ifNm9tzJehNhlvQXpjXE7FkfXnfMnysJh5oFFrS9EvK/DoX9Jwb/u
         CHzBeBuAG9unM0q+eZnfxJuoOY3EqErgoII/lrs8YIWle0VVno0UGhvT0REk3EYWaHml
         E+8jG7RBqALVQodXLXmqG1QDwDhViZ0xyEom3LuPbzwQCeIxHu0aTRid8A07m6innWl/
         fb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0hL5ZWwgT+zm/1bF0fdLbsZAMB5ylTWsCAUOyDUjvEtXmWSpEe5rG4XmQSJmOXeSrQmWkMys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSd9D6V6Xc1N1ok40rklq+z9mhVILmVCs3FwRz7rMNldmz9aru
	z+frE7dvvahkGlrfUydXnVpL2icN3hWPjrPdPHXSTpHVxYXq8y1HeE7bdwT/+Ovn3Go8iIRHtXb
	eBwVnBVxO5GXCNtJ2N8omzWfeLp0evfNAMCrGtXrJpQ==
X-Gm-Gg: ASbGnct9N37UxSX68PeGo9D0FAS+tGq1sIyXzaj8yejO+aROXR5uhT8e81bloW8qqez
	a6dInhT0NkRvEMNe+H9FpWGs8ba0r5E4cU4JJteEcqYjClzmtrVRwejKrGGOlXB3A3D00PLZXc+
	Or6SrOCfOlEO9tCqJNSQYSkyyWY+aGTE47WF9Ge9UXTyFYOCusJ4EFW2g8OQfhC50jV+sVdd6qd
	9jsTKyTfdp7x6Lym+bCRqg6flCTDwPmqVTtPj5jTPpErn3L2zyrH1JC5CL86tDrT9zeuC2p
X-Google-Smtp-Source: AGHT+IFV325JIbcAfi1+4GJFDPX/Lf6OkNWpQhdHX1kwwf8lrDz1Wr7tESi3mLj2u4jharlYlnA+pRIIqSG0XyZXHl0=
X-Received: by 2002:a17:902:d2cd:b0:267:44e6:11d6 with SMTP id
 d9443c01a7336-267d1540ec7mr19417725ad.6.1758002603798; Mon, 15 Sep 2025
 23:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 11:33:12 +0530
X-Gm-Features: AS18NWCGBnaNFEvWs2ru3e2aqzs-uznr7CWnwt9WJqflYhg3DElbi0V21AVd2FA
Message-ID: <CA+G9fYvH8d6pJRbHpOCMZFjgDCff3zcL_AsXL-nf5eB2smS8SA@mail.gmail.com>
Subject: next-20250915: powerpc: ERROR: modpost: "libie_fwlog_init"
 [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	intel-wired-lan@lists.osuosl.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Qiang Liu <liuqiang@kylinos.cn>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed on the powerpc
with ppc6xx_defconfig build on the Linux next-20250915 tag.

First seen on next-20250915
Good: next-20250912
Bad: next-20250915

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* powerpc, build
  - gcc-13-ppc6xx_defconfig
  - gcc-8-ppc6xx_defconfig

Build regression: next-20250915: powerpc: ERROR: modpost:
"libie_fwlog_init" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko]
undefined!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/swim3.o
WARNING: modpost: missing MODULE_DESCRIPTION() in
drivers/net/ethernet/freescale/fec_mpc52xx_phy.o
ERROR: modpost: "libie_fwlog_init"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: modpost: "libie_get_fwlog_data"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: modpost: "libie_fwlog_deinit"
[drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
make[3]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1

## Source
* Kernel version: 6.17.0-rc6
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250915
* Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
* Architectures: powerpc
* Toolchains: gcc-13 and gcc-8
* Kconfigs: ppc6xx_defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29894450/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250915/build/gcc-13-ppc6xx_defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4NthnSk7ehgpfv9NJaE6gjqk/config

--
Linaro LKFT

