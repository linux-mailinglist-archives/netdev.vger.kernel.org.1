Return-Path: <netdev+bounces-178899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6FA79774
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60D21893A16
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A61F2367;
	Wed,  2 Apr 2025 21:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84A126F0A;
	Wed,  2 Apr 2025 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.203.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628719; cv=none; b=D/nLhtaPvi4N+utrH58o4Hm5l3N9X7JGkfnnbv63ja+0TIZWEDvETwthP3qNE4fkvEoGnxSIHDUo36ffJXocys/3+sd1IpIFDo87NVym0z3lO1Vowz3e0p97FZY88hLIxVbLd1NdNBIR4eQHAQ1ZTxLAUJfHCjF5incQVLpD2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628719; c=relaxed/simple;
	bh=TRKe2C2yWQUuu/9WP0Vtkv/UsPx1qc3XdDhBsmf2WZs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Wa5aoscKWgrAX24asCoWkAYPGZ46M8ouw6gNx9biIJR/VEJiykU0+40kaWI/tUG68embEeJWevvBr0nzwj68LWFoY0ptsnOt5Xwa1dnB07AwU8rgcoEKOJI4tSFAHGqOaUpuDtkqkTJOJZvT83/PCVr8tRudqHR00P5bovwoNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de; spf=pass smtp.mailfrom=webked.de; arc=none smtp.client-ip=159.69.203.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webked.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webked.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C65AF62B75;
	Wed,  2 Apr 2025 23:12:13 +0200 (CEST)
Message-ID: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
Subject: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com,  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Apr 2025 23:12:07 +0200
Organization: WEBKED IT Markus Fohrer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I'm observing a significant performance regression in KVM guest VMs using v=
irtio-net with recent Linux kernels (6.8.1+ and 6.14).

When running on a host system equipped with a Broadcom NetXtreme-E (bnxt_en=
) NIC and AMD EPYC CPUs, the network throughput in the guest drops to 100=
=E2=80=93200 KB/s. The same guest configuration performs normally (~100 MB/=
s) when using kernel 6.8.0 or when the VM is moved to a host with Intel NIC=
s.

Test environment:
- Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
- Guest: Linux with virtio-net interface
- NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
- CPU: AMD EPYC
- Storage: virtio-scsi
- VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
- Traffic test: iperf3, scp, wget consistently slow in guest

This issue is not present:
- On 6.8.0=20
- On hosts with Intel NICs (same VM config)

I have bisected the issue to the following upstream commit:

  49d14b54a527 ("virtio-net: Suppress tx timeout warning for small tx")
  https://git.kernel.org/linus/49d14b54a527

Reverting this commit restores normal network performance in affected guest=
 VMs.

I=E2=80=99m happy to provide more data or assist with testing a potential f=
ix.

Thanks,
Markus Fohrer


