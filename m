Return-Path: <netdev+bounces-53648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086380403D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1978B28133E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAF33CC0;
	Mon,  4 Dec 2023 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vcJlRby9"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDB7281
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zFFrdwdMxDeLDOu1EEArT/I/Iqq/BUGLwkci9F/B7pM=;
	t=1701722415; x=1702932015; b=vcJlRby9PUBS+G6Ewag/s34/rQx2nPCnwzC4YiGX3B8KKOU
	4cJ2tGDhkxNUtIy/bm/DiVD3Fm248Q94AtUYpdqyH89YfpnMIJoIxcKBwaah0nh8ksczKaKIjpo/J
	YAXTcAvysn6cQG2WzXyStGvvBWnXMCdFEDNGsvTMHVbbl+QKwdWtuG71bP2KQqH44tyLpOWtMdUS1
	h7VzhJPofHuoEjEZAWiDmJrKkSy1sB/2vvc4BUDyzgbfjOnUF95oxBe4IZ6ONVXJdLCDGiTSptAWC
	YzAkFtdwm93PsJyiLsd+tymB0Oh/ZuKyRQ77TMT0KiXVl/yC8mnZInV5xwz9DwkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAFjd-0000000FFW4-2RPw;
	Mon, 04 Dec 2023 21:40:10 +0100
Message-ID: <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Marc MERLIN <marc@merlins.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 04 Dec 2023 21:40:08 +0100
In-Reply-To: <20231204203622.GB9330@merlins.org>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231204200038.GA9330@merlins.org>
	 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	 <20231204203622.GB9330@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 12:36 -0800, Marc MERLIN wrote:
>=20
> So, ipc is not a module for me
> sauron:/usr/src/linux-6.6.4-amd64-preempt-sysrq-20231203# lsmod | grep ip=
c

I think the driver is "igc", not "ipc".

> sauron:/usr/src/linux-6.6.4-amd64-preempt-sysrq-20231203#=20
>=20
> Is that a build config option I can reaonably turn off without breaking
> networking altogether?
>=20
> Previous boot, before your patch that I just compiled and will test now,=
=20
> it ended with this. I also see ethtool lower down, maybe run randomly by =
network manager
> but isn't the hang happening before in these loglines, or the order of th=
e logs is not
> the actual sequence order of the problem?

The order of this doesn't tell us much, I believe.

> [ 4230.596282] INFO: task kworker/0:2:132 blocked for more than 120 secon=
ds.
> [ 4230.596288]       Tainted: G     U             6.6.4-amd64-preempt-sys=
rq-20231203 #5
> [ 4230.596289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 4230.596291] task:kworker/0:2     state:D stack:0     pid:132   ppid:2 =
     flags:0x00004000
> [ 4230.596294] Workqueue: ipv6_addrconf addrconf_verify_work
> [ 4230.596305] Call Trace:
> [ 4230.596310]  <TASK>
> [ 4230.596317]  __schedule+0x6c3/0x727
> [ 4230.596330]  ? update_load_avg+0x43/0x3ba
> [ 4230.596340]  schedule+0x8b/0xbc
> [ 4230.596349]  schedule_preempt_disabled+0x11/0x1d
> [ 4230.596359]  __mutex_lock.constprop.0+0x18b/0x291
> [ 4230.596367]  addrconf_verify_work+0xe/0x20

This is just a worker trying to acquire RTNL.

> [ 4230.596506] INFO: task NetworkManager:3153 blocked for more than 120 s=
econds.
> [ 4230.596507]       Tainted: G     U             6.6.4-amd64-preempt-sys=
rq-20231203 #5
> [ 4230.596508] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 4230.596509] task:NetworkManager  state:D stack:0     pid:3153  ppid:1 =
     flags:0x00000002
> [ 4230.596511] Call Trace:
> [ 4230.596512]  <TASK>
> [ 4230.596513]  __schedule+0x6c3/0x727
> [ 4230.596515]  schedule+0x8b/0xbc
> [ 4230.596517]  schedule_preempt_disabled+0x11/0x1d
> [ 4230.596519]  __mutex_lock.constprop.0+0x18b/0x291
> [ 4230.596521]  nl80211_prepare_wdev_dump+0x8b/0x19f [cfg80211 7e4322db91=
48b7482d4806580d3e58073444690f]

This is just wireless trying to acquire the RTNL on behalf of NM.

> [ 4230.596743] INFO: task ThreadPoolForeg:9425 blocked for more than 120 =
seconds.
> [ 4230.596745]       Tainted: G     U             6.6.4-amd64-preempt-sys=
rq-20231203 #5
> [ 4230.596745] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 4230.596746] task:ThreadPoolForeg state:D stack:0     pid:9425  ppid:94=
16   flags:0x00000002
> [ 4230.596748] Call Trace:
> [ 4230.596749]  <TASK>
> [ 4230.596750]  __schedule+0x6c3/0x727
> [ 4230.596752]  schedule+0x8b/0xbc
> [ 4230.596754]  schedule_preempt_disabled+0x11/0x1d
> [ 4230.596756]  __mutex_lock.constprop.0+0x18b/0x291
> [ 4230.596758]  ? __pfx_ioctl_standard_call+0x40/0x40
> [ 4230.596760]  ? __pfx_ioctl_private_call+0x40/0x40
> [ 4230.596762]  wext_ioctl_dispatch+0x4b/0x1a7

I don't know why something should be using wireless extensions, but same
thing. Also wext is going away for WiFi7 devices. ;)

> [ 4230.596890] INFO: task ethtool:20272 blocked for more than 120 seconds=
.
> [ 4230.596891]       Tainted: G     U             6.6.4-amd64-preempt-sys=
rq-20231203 #5
> [ 4230.596892] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 4230.596893] task:ethtool         state:D stack:0     pid:20272 ppid:1 =
     flags:0x00004006
> [ 4230.596894] Call Trace:
> [ 4230.596895]  <TASK>
> [ 4230.596896]  __schedule+0x6c3/0x727
> [ 4230.596899]  schedule+0x8b/0xbc
> [ 4230.596900]  schedule_preempt_disabled+0x11/0x1d
> [ 4230.596902]  __mutex_lock.constprop.0+0x18b/0x291
> [ 4230.596904]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 4230.596908]  igc_resume+0x18b/0x1ca [igc 33cdaa7f35d000f01945bed5e87ca=
b1e358c8327]
> [ 4230.596916]  __rpm_callback+0x7a/0xe7
> [ 4230.596919]  rpm_callback+0x35/0x64
> [ 4230.596921]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> [ 4230.596922]  rpm_resume+0x342/0x44a
> [ 4230.596924]  ? dev_get_by_name_rcu+0x25/0x41
> [ 4230.596926]  ? dev_get_by_name+0x3c/0x4a
> [ 4230.596928]  __pm_runtime_resume+0x5a/0x7a
> [ 4230.596930]  ethnl_ops_begin+0x2c/0x8d

This one's still the problem, so I guess my 2-line hack didn't do
anything.

[snip rest, they're all just waiting for RTNL]

johannes

