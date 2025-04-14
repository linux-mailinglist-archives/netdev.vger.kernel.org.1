Return-Path: <netdev+bounces-182355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBCA8889B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B633B30C5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645B27FD6F;
	Mon, 14 Apr 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="kTsnBqTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D527FD48
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648171; cv=none; b=sozFU3n4pWyOXExo705b3hRubph851gmcjcl12lzvUV6iHK1TMrBtYJ0zqRZbEwFuFWkIRb9DFMKnYdcD/NdAbht8nHRTRdBUfVDmG4W/fKK/CJqaCBjygaPNuFSfHE5jOsMtptdf1wzAsqrGYKg1CUlT84a1bccqfJUab5hg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648171; c=relaxed/simple;
	bh=DqU76zbJe5zHNKBAeqcsGeDmejuY3cZMUseiG5PDm14=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bpk1fKdzfGnSfH+YYPxMyWCSZkexLFajTxA8uUWDCFD8XQJspJMDrbNuPt7kGQYhKgkQSog23Y96aLuyJpVvc30pdeUcjIW7ffzCnvU2++X6KMCoxBLMv8l3C7krgqVJEf3rH32Fx2O8RJnelRkQ7C/MSSAaVp2j1qDyD1EqCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=kTsnBqTK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so704610466b.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1744648167; x=1745252967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9YTnbSfm3obJ2BhJveT3wt+uBc2RX1rhcU/TJobOfg=;
        b=kTsnBqTKM2RnptjZL2jHQRlcgPG4plqKK+rwjGbZUgVOA8VWEU1tbfXcXVo4zlhOI8
         O/xSC99sHBFz8V0FMc3zNkvr+ZG/DeRCHsm/UJe9V80WfLV+ndbs29YLyQZP+yxsz24M
         7b3knbsGaQgBvmaLVt2iVXtqGtkv5PlRFCEtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744648167; x=1745252967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9YTnbSfm3obJ2BhJveT3wt+uBc2RX1rhcU/TJobOfg=;
        b=gGgE9yZdUaAF64jiQw2wubcSdVxRgeWNezphOd1J0vEkaoClBL7EE0hnvURoXvbIj/
         blFi9qn4neqaSCQ91ugOGZuYQ3IAAkgzvmp+1SDwp6uWEFWOKauCVd61UciOip7Rha4A
         XSR8EVEiCpkUndzXXW2bOMM34d0XkOaNM7aynozPUkTPnjJ+TGwKaqcSuHUQ3bLKOey3
         bar7heeMjEdNGRCo1f4/NgfBQp2tV3sFIshWLTiVHR50YR4McshIWRLEFL+MXa1C+qMl
         tJEev7iC3QjkDNGySf0TcZ4KVSmOOHSUmjadtW+jxnIHkgnO1gT2jl6B7NwQ6MYqJNzT
         tbfg==
X-Forwarded-Encrypted: i=1; AJvYcCX/03kNXFPKlGjx1Tqk/mpy/iorjoIFU9sHLn+5xe1ObdieWuFIIhyaIZ/K/3ncWRLmoR50A7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXhWSDxsKIIKX4UUUMgWPch7QsPql4D13anMXym2T+St96ghS
	TpsgoDrnIfWNre4mOLr7IPki2/PNcppqv874KVYOQH7PEr55ZfeVvMLtCU3GmCafiTrDDXAZZOE
	EyTBmCDPiY06LPbKFC/doC+fqJmwXrUQzgnJQ
X-Gm-Gg: ASbGncvqQnDhYOHn3YATs00bsmpVngfvCvtPHtl1LH5YhcPt3RzzG1FZ6HcBM6LIaSu
	asdhEZ6ycCydDt3wAPEjI89BKVKXZZoFl/Fvet+IwA6E6QMbl8S5S/D/w38lt5ZWRCX+0c3xTQl
	wu8rI1FwAASaY/5PXwt1E0uwc=
X-Google-Smtp-Source: AGHT+IHcrrGKFhMeLQ31WvRxBOez6r0eEL8a4TdkOGhogntyPaCZbt8wA0XHHpY25XP4nvLaxkzi/jkYTNVJWs9PghY=
X-Received: by 2002:a17:907:3fa2:b0:ac6:d9fa:46c8 with SMTP id
 a640c23a62f3a-acad36a0921mr1110877066b.39.1744648167164; Mon, 14 Apr 2025
 09:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 14 Apr 2025 18:29:01 +0200
X-Gm-Features: ATxdqUFza1CQ4W9k5JorbqPCMerunVDsLOiFHZDxpXg6-fR3ZeEgQFPD8xdXkTg
Message-ID: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
Subject: Increased memory usage on NUMA nodes with ICE driver after upgrade to
 6.13.y (regression in commit 492a044508ad)
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Cc: jdamato@fastly.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

While investigating increased memory usage after upgrading our
host/hypervisor servers from Linux kernel 6.12.y to 6.13.y, I observed
a regression in available memory per NUMA node. Our servers allocate
60GB of each NUMA node=E2=80=99s 64GB of RAM to HugePages for VMs, leaving =
4GB
for the host OS.

After the upgrade, we noticed approximately 500MB less free RAM on
NUMA nodes 0 and 2 compared to 6.12.y, even with no VMs running (just
the host OS after reboot). These nodes host Intel 810-XXV NICs. Here's
a snapshot of the NUMA stats on vanilla 6.13.y:

     NUMA nodes:  0     1     2     3     4     5     6     7     8
 9    10    11    12    13    14    15
     HPFreeGiB:   60    60    60    60    60    60    60    60    60
 60   60    60    60    60    60    60
     MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453
65470 65470 65470 65470 65470 65470 65470 65462
     MemFree:     2793  3559  3150  3438  3616  3722  3520  3547  3547
 3536  3506  3452  3440  3489  3607  3729

We traced the issue to commit 492a044508ad13a490a24c66f311339bf891cb5f
"ice: Add support for persistent NAPI config".

We limit the number of channels on the NICs to match local NUMA cores
or less if unused interface (from ridiculous 96 default), for example:
   ethtool -L em1 combined 6       # active port; from 96
   ethtool -L p3p2 combined 2      # unused port; from 96

This typically aligns memory use with local CPUs and keeps NUMA-local
memory usage within expected limits. However, starting with kernel
6.13.y and this commit, the high memory usage by the ICE driver
persists regardless of reduced channel configuration.

Reverting the commit restores expected memory availability on nodes 0
and 2. Below are stats from 6.13.y with the commit reverted:
    NUMA nodes:  0     1     2     3     4     5     6     7     8
9    10    11    12    13    14    15
    HPFreeGiB:   60    60    60    60    60    60    60    60    60
60   60    60    60    60    60    60
    MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453 65470
65470 65470 65470 65470 65470 65470 65462
    MemFree:     3208  3765  3668  3507  3811  3727  3812  3546  3676  3596=
 ...

This brings nodes 0 and 2 back to ~3.5GB free RAM, similar to kernel
6.12.y, and avoids swap pressure and memory exhaustion when running
services and VMs.

I also do not see any practical benefit in persisting the channel
memory allocation. After a fresh server reboot, channels are not
explicitly configured, and the system will not automatically resize
them back to a higher count unless manually set again. Therefore,
retaining the previous memory footprint appears unnecessary and
potentially harmful in memory-constrained environments

Best regards,
Jaroslav Pulchart

