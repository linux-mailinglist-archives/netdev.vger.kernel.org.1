Return-Path: <netdev+bounces-214919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7AB2BD8F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3917A1C2A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371AE319863;
	Tue, 19 Aug 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ5OpnBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968793115A1
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596290; cv=none; b=L04GkQGk2FMNvx2LQ+kkmgJ557suUi25W+5Zcqe68ZTKXQ9gsXhXtW0maVOt1SMl+CUD/hC5DwcZ3Yn0WS52WyV2IbRYKWU6gH3foFTXLrvRtuHP2YAAy2oomXJND2H4KIsO7pGuvBVbv8Ydo3A+TuRZGBEj6D0TC6WBXk+xbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596290; c=relaxed/simple;
	bh=2V8M7LV7ljgsDumKXBHQhC4o9NF1oxLIPIk0ANfKKUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KTTJrNkF8/Vt1FNS89dQu3/8CL6TygaoGBzIVv6Kp5dFii+snQtSQ5UmNS6TRA566yRPlbOCya/6O371GQ3RH14Pi6ugvL6gW8A0PP/IZwc/WWB8qF7TQardarFtBI++9KA3QGM8lY8+7Qvjhzuy7DDJoW+C8nw95DkofAjXqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ5OpnBC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471756592cso3437053a12.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596288; x=1756201088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6K8gy0h4bXhy9f6BhVNVyKHxXc0oXpO4f2ZuZ3PvLY=;
        b=LQ5OpnBCqQCKxXO/BF0ocGcd07zuzSpdERlx5BAAYfsIUJbNr4b+NLz7C7wJI2WgpX
         u67emYC99RAlPV5S3PGvW4UYt1CiwjREE26o7hAvOvQNLevMuE4wVPXTDdElq0a7C3hs
         pHvS361abm+QDVAMcLuFirUoh+DbPrmgF62TPA57w0y2reH8RWarvrHOnRr2x3g8C8Xq
         lfSZjFx1wc0Avh0zs/dp672aWFd9aKq91MV/FCKW/r6Plr2oASvuk3K+8JLFEeEol2Xq
         H3zdowBzOBHJc/XRWXWlYu4xm0lmkH6J7YBdRARcralsemxJP05KmVKT18ge52T/l5yV
         4IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596288; x=1756201088;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6K8gy0h4bXhy9f6BhVNVyKHxXc0oXpO4f2ZuZ3PvLY=;
        b=FjKLONSN5oIrRQnvaz34WcPrjVaw6PPqQAqMK3zmEpCAwZg0apLRCAxVuxeML7s5w4
         70EdaZFettknUvK9jhJZsgeyhFMTdBX0k+uhOdwcflHepDWTuLU8Qrx5pTeiQUXemgc0
         bhyPU/smfGI0VZ7bOH/PpbvJX7RlXJFzl1YZC3Lesp0Gej0RbLSPVZFeJ/OMLDQGzWeM
         bCaBmo7MlQ+qGYS0lKxW2m50kDddKHAojclPx7es0Vku7EQ7u2NWxL1ZGTosIpOKZ+qN
         vlh5VNP2l32EwCNB9SexRdSS0t3noihkm1qkZWpdxn7yiVbgUZw/yy1kJRHsHjoXswbP
         Br8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlDBVEhqqaZQFe31B233auX0Q+Qw00hZj5/jMV68d8+mvaP0wL0e1alfn2ySclBqsNIByyvDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXURc6yb0dfTjH5aQZ3SSQZzlgi3B8SidbrxeqdHQdnXZ3mj4
	BSno4vsd9oRrNKXvf4sxBJppM53yUsPDspwu7QmZEHzaSchIlDXJvf1IvxXHL99E5kaA667u2Li
	+64TL+TMr8KcBW+0Jd1NuhGOW0iZ9b/Gyy2FT0iATHA==
X-Gm-Gg: ASbGncsvCD20YxxgRPyWfp0N5tWbIzjjxkM3M1tGgIXEKqicDZat4lLXU1PZHxwPTF2
	Xy2DFclAcvhnbafm/cFkFZ9bDkTS7IhRN2vpIXIolJngsnIvdbWO73CBrbfxnZLjdHzPGizp9a1
	M8N/nAYFpYtPT2jY4XVYzIDmCrQWdnFi28NL0nA6/rdza2EyY5pttt8AOJnkpY4q670CEYoLDjI
	mNP8nuwGgSGyGkB19ayFGk5/Xw+xnASTUywXBHLgD/7YKBlB+c=
X-Google-Smtp-Source: AGHT+IFIxdv+Gumf/6w+v7ffwNzZJemUXI7WRTzzUiAmKNSzZs75iWdEANwcTsNoYtnMKamFklfbi/D3t+vz0EWJMZw=
X-Received: by 2002:a17:902:f609:b0:234:ba37:879e with SMTP id
 d9443c01a7336-245e049e36cmr28797065ad.38.1755596287861; Tue, 19 Aug 2025
 02:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 15:07:56 +0530
X-Gm-Features: Ac12FXzSzL7CxVGEj_WaufEFOr4fMyspvQA0mI9KFbrlZz1H1yL9N-ZCIEodprQ
Message-ID: <CA+G9fYuY=O9EU6yY_QzVdqYyvWVFMcUSM9f9rFg-+1sRVFS6zQ@mail.gmail.com>
Subject: next-20250813 s390 allyesconfig undefined reference to `stmmac_simple_pm_ops'
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Build regressions were detected on the s390 architecture with the
Linux next-20250813 tag when building with the allyesconfig configuration.

The failure is caused by unresolved symbol references to stmmac_simple_pm_ops
in multiple STMMAC driver object files, resulting in a link error during
vmlinux generation.

First seen on next-20250813
Good: next-20250812
Bad: next-20250813 and next-20250819

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* s390, build
  - gcc-13-allyesconfig

Boot regression: next-20250813 s390 allyesconfig undefined reference
to `stmmac_simple_pm_ops'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o:(.data.rel+0xa0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.o:(.data.rel+0xa0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/stmmac_pci.o:(.data.rel+0xe0):
undefined reference to `stmmac_simple_pm_ops'
s390x-linux-gnu-ld:
drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.o:(.data.rel+0xe0):
undefined reference to `stmmac_simple_pm_ops'
make[3]: *** [/scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250818
* Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
* Architectures: s390
* Toolchains: gcc-13
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29579401/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/gcc-13-allyesconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/config

--
Linaro LKFT
https://lkft.linaro.org

