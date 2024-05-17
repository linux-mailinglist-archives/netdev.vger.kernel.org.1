Return-Path: <netdev+bounces-96953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3448C866E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F73283034
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17B381BB;
	Fri, 17 May 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5/HJtc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E17F9
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949899; cv=none; b=kLzUGEhniPoNR5bVAh/pXOctwPb5wHvRTrmWcv1OoTOdWS6SsJol5jy28tDArhfdNT+OihNcpEiDc1kWeqWuWOcDCa+0vfwzLralBa7iZfyLK05dSfh9++lzlfX8vaGpubHJgRrTvTQ0Tj5WfVsEeFD+960zMnkMaZyEHmrrWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949899; c=relaxed/simple;
	bh=N4SkCGjshUN4eJuToZsKFaUSBMc/3WhERcLt1nqXB6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rWT9OwPotQf+1CBetByWTQAeNwgQv7IHNwTr0nXBpjivXICqXK34e+SPAD9SY5UC0mkFriXD1iOkCiIFetn9hTWR6KzDU3mRh3HOVF9WEmrM+pazIM2ITqu4CYgJkUsLZb6qZAVMHWaygL4EPxPJnf1Sd6XzWDvcUJT9uFiRzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5/HJtc5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so24797691fa.1
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715949895; x=1716554695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3PYkTpN4fQGOYaxhQag2GrvMR581M+PXzEscclulAac=;
        b=X5/HJtc5AVKl2ec1NiHPt29GzL/t66Dntm6VNAdFRtMo2rjS4j5nE7CeCN2IkBsndC
         sbDemWANnOEPlJwNEQWgJScr7YqjUHHWaFv+2W1HyllCsZ4Ix4Pz/gnty5e+1lqp1+V0
         MbaI0iu8gY6XC73E7ZpHo7zp56NVOMsin7OJRGxMDw1KNafIVZzj+xbMtXWkKTBMUqyD
         q2vDNHXKky+WXo8fepa7AExdzNMW0172ORxx0a008gAt449MNa9S2csbrwD5yprCqJvA
         PnaM7hOjeyqZ41zSro45z7QgpPK3XbjdE/LjvAdtd10GRAXzqm8XJ4N+YmI2e3HNcHBn
         /tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715949895; x=1716554695;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PYkTpN4fQGOYaxhQag2GrvMR581M+PXzEscclulAac=;
        b=K9rElszhvXbfGBQresaUoS8PZzBbprk0l31eSEfbSauCQGSW+3nRzptc9j0i/xw+CD
         cNZtMvpYa7cngGhWbJEkIUxhyZEWpvOHIB0W8FjsP11PLJC/1aEtzDvpf0vflKLBqf79
         2AeTx9flmBtxwg4xkjXUZLLSl1L3maWboy/XEHLOtrp929spz7zO4bncfyjCAQ5SoxEo
         EDu4nlU/xY4rhEZIQG4sUBdDScF6yGsUkDO61IcxW/TNl6rktgodGHp4Jdncj4Obb1xs
         EP6euvrfqrkcl50Vr7P4Xl30g1rAUkm7PsDutxS9559Nbe3B+XE9q6wAW3j857K1Wxod
         ES8w==
X-Gm-Message-State: AOJu0YykO02+B0r0EsYCoKwNsyZZf/7omAJ+ve8ohjhH5y8E8GXsd3I8
	IL3kLBBihn0toRS3UoA7YUuDJI5Lew92FF9QfA4nssec7d7Yzqts6v4Qwwn/d6ljgpZRWqaKxrl
	L2T+6MdSFqViaMj8MU+4/2fVQPLYB04Up
X-Google-Smtp-Source: AGHT+IFVm9ZhoublnKIWP4W1XYqx7bYhBOuBy9xlYkSieOYIjOX/CS2lF/P3ah+/cZ+x1ofZmOzHz7iOVcAb5eP2bKg=
X-Received: by 2002:a05:6512:6ca:b0:523:8f5e:4aa0 with SMTP id
 2adb3069b0e04-5238f5e4b78mr6259101e87.63.1715949895021; Fri, 17 May 2024
 05:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Krishna Kumar <krikku@gmail.com>
Date: Fri, 17 May 2024 18:14:19 +0530
Message-ID: <CACLgkEYHqmN-Kf93PNcWKJd5FKtwENxLOk7e7Z-VcxcDfXFdOA@mail.gmail.com>
Subject: Large TCP_RR performance drop between 5.x and 6.x kernel?
To: netdev@vger.kernel.org
Cc: "Krishna Kumar (Engineering)" <krishna.ku@flipkart.com>, vasudeva.sk@flipkart.com
Content-Type: text/plain; charset="UTF-8"

Dear maintainers, developers, community,

We are using Debian (Bullseye) across the multiple Flipkart data
centers in India with many thousands of servers (running QEMU/KVM).

Recently, as part of testing for upgrading systems to Debian 12, we ran into
a performance regression (~27%) in VMs running on the upgraded hypervisors.
In both cases, VMs run Debian 12.

Hypervisor configuration:
- 144-core Intel Xeon Icelake (8352V), 750 GB memory, Intel E810 NIC, IRQ
  and XPS set.
- System has two bridges - one for hypervisor connectivity (one VF to
  this bridge), and one for VM (one VF to this bridge). The system has
  exactly one VM powered on, connected to the second bridge.
- Command line for both Debian 11 and Debian 12 are similar to the
  following (except for the vmlinuz* version):
  BOOT_IMAGE=<path-to-vmlinuz> root=UUID=<uuid> ro rootflags=<xyz>
      loglevel=7 intel_iommu=on iommu=pt quiet crashkernel=512M
- VM is pinned to CPUs 1-12 of the host, nothing else is running on the host:
        NUMA node0 CPU(s):                    0-35,72-107
        NUMA node1 CPU(s):                    36-71,108-143

VM configuration:
    - 12 core, 120GB, MQ virtio-net, runs on NUMA socket #0 (no HT) of
      the host. Always runs Debian 12

We are testing VM performance running on the same bare metal server, which runs
Debian 11 (5.10.216 kernel and 5.2 QEMU) before upgrading it to Debian 12
(6.1.90 kernel and 7.2 QEMU). The VM runs Debian 12 in both cases.

VM Test: 32 processes TCP_RR for 60 seconds to another bare-metal server:
     Debian 11: 440K
     Debian 12: 320K (27% performance drop).

Packets are well spread across the TX/RX queues on the guest virtio* and the
VF on the physical host.

We expect some setting that is causing this degradation but we are not
able to figure out what it is (though we do not make any changes to the
system after upgrading distribution).

We did the following test, expecting that the degradation is either
due to the higher kernel or qemu version:

Kernel     QEMU      Rate     Notes
6.0.2      7.2             320K     Downgrade kernel to lowest 6.x,
                                                   same QEMU.
5.10.216   5.2/7.2    440K     Downgrade kernel to Debian 11, any QEMU.

From here on, do manual "bisect" between 5.10.x towards 6.0.2 without changing
QEMU to identify when it degraded.

5.19.11    7.2          310K     Highest kernel version in Debian 5.x.
5.16.18    7.2          330K     Go down a version.
5.15.15    7.2          443K     Good number, start going forward.
5.16.7     7.2           300K     Bad
5.15.158   7.2         448K     Now go ahead to find closest
                                                    version with degrade.
5.16.1     7.2          340K     Degrades, go back a little.
5.16.0     7.2          336K     First version after 5.15.158

There's a huge set of changes between 5.15.158 and 5.16.0. So, at this time,
we are blocked knowing that the last 5.15.158 performed well at 448K while
the next version reduced to 340K.

Any help on what we could further look for to identify the reason for this
drop, and if any setting/config change is expected?

Thanks,
- KK

