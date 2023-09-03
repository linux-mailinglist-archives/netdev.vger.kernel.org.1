Return-Path: <netdev+bounces-31852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D06A790D5D
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A8B280F61
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFFAD48;
	Sun,  3 Sep 2023 17:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7423AA
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F2FC433C7;
	Sun,  3 Sep 2023 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693763915;
	bh=HHN7TtKjh8/irZevGxQsYwPgVQottw+Irb2rc4Pquos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0+CCUE4MWxM5MoC50KEbunQ3SXgwUzmAT89Di6mVbn6xGvE7TUDb+utwBS5brGAZ
	 VLFYcyISHFNOluCKrDjvvUIM8jJapymwAB1zWhCPh4sCg6gbCyvVDMGkqkEMDwDxPm
	 fixLEf+vrt4IHlc/Lcc73H5XPes7eyVIbBpoyeMZSSVWTZCSGFyeqi8nFE5EnYfvhQ
	 vnbr6CPv+vQKG59Gs0wqgOtFS7BOV+pS2LIXDCxLnmq38s/TyWjc1zNSh7xae+Lz87
	 UAHquydIaoCmvzho40EJIWzR2ZFUJC8Ae9+zYTRryTmxiNdG7dTkIdmfWWcewUZrau
	 DsqfDmsRhcm5A==
From: James Hogan <jhogan@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Sasha Neftin <sasha.neftin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 "Neftin, Sasha" <sasha.neftin@intel.com>
Subject:
 Re: [WIP v2] igc: fix deadlock caused by taking RTNL in RPM resume path
Date: Sun, 03 Sep 2023 18:57:46 +0100
Message-ID: <2158798.irdbgypaU6@saruman>
In-Reply-To: <87zg2alict.fsf@intel.com>
References:
 <20220811151342.19059-1-vinicius.gomes@intel.com>
 <5962826.lOV4Wx5bFT@saruman> <87zg2alict.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 29 August 2023 02:58:42 BST Vinicius Costa Gomes wrote:
> James Hogan <jhogan@kernel.org> writes:
> > On Sunday, 2 October 2022 11:56:28 BST James Hogan wrote:
> >> On Monday, 29 August 2022 09:16:33 BST James Hogan wrote:
> >> > I'd be great to have this longstanding issue properly fixed rather than
> >> > having to carry a patch locally that may not be lock safe.
> >> > 
> >> > Also, any tips for diagnosing the issue of the network link not coming
> >> > back
> >> > up after resume? I sometimes have to unload and reload the driver
> >> > module
> >> > to
> >> > get it back again.
> >> 
> >> Any thoughts on this from anybody?
> > 
> > Ping... I've been carrying this patch locally on archlinux for almost a
> > year now. Every time I update my kernel and forget to rebuild with the
> > patch it catches me out with deadlocks after resume, and even with the
> > patch I frequently have to reload the igc module after resume to get the
> > network to come up (which is preferable to deadlocks but still really
> > sucks). I'd really appreciate if it could get some attention.
> 
> I am setting up my test systems to reproduce the deadlocks, then let's
> see what ideas happen about removing the need for those locks.
> 
> About the link failures, are there any error messages in the kernel
> logs? (also, if you could share those logs, can be off-list, it would
> help) I am trying to think what could be happening, and how to further
> debug this.

Looking through the resume log, the only network/igc related items are these:

Sep 03 18:28:17 saruman kernel: igc 0000:06:00.0 enp6s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
Sep 03 18:28:17 saruman NetworkManager[1016]: <info>  [1693762097.7180] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Sep 03 18:28:17 saruman NetworkManager[1016]: <info>  [1693762097.7181] device (enp6s0): state change: activated -> unmanaged (reason 'sleeping', sys-iface-state: 'managed')
Sep 03 18:28:17 saruman avahi-daemon[989]: Withdrawing address record for 192.168.1.239 on enp6s0.
Sep 03 18:28:17 saruman avahi-daemon[989]: Leaving mDNS multicast group on interface enp6s0.IPv4 with address 192.168.1.239.
Sep 03 18:28:17 saruman avahi-daemon[989]: Interface enp6s0.IPv4 no longer relevant for mDNS.
Sep 03 18:28:17 saruman NetworkManager[1016]: <info>  [1693762097.8202] manager: NetworkManager state is now CONNECTED_GLOBAL
Sep 03 18:28:17 saruman NetworkManager[1016]: <info>  [1693762097.8657] manager: NetworkManager state is now DISCONNECTED
Sep 03 18:28:17 saruman NetworkManager[1016]: <info>  [1693762097.8660] device (enp6s0): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Sep 03 18:28:17 saruman systemd[1]: Starting Network Manager Script Dispatcher Service...
Sep 03 18:28:17 saruman systemd[1]: Started Network Manager Script Dispatcher Service.
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3075] device (enp6s0): carrier: link connected
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3076] device (enp6s0): state change: unavailable -> disconnected (reason 'carrier-changed', sys-iface-state: 'managed')
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3080] policy: auto-activating connection 'Wired connection 1' (f6634f16-77ca-34f7-846a-8c41e15a8ad1)
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3082] device (enp6s0): Activation: starting connection 'Wired connection 1' (f6634f16-77ca-34f7-846a-8c41e15a8ad1)
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3082] device (enp6s0): state change: disconnected -> prepare (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3083] manager: NetworkManager state is now CONNECTING
Sep 03 18:28:21 saruman kernel: igc 0000:06:00.0 enp6s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
Sep 03 18:28:21 saruman kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp6s0: link becomes ready
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3506] device (enp6s0): state change: prepare -> config (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3512] device (enp6s0): state change: config -> ip-config (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:21 saruman NetworkManager[1016]: <info>  [1693762101.3515] policy: set 'Wired connection 1' (enp6s0) as default for IPv4 routing and DNS
Sep 03 18:28:21 saruman avahi-daemon[989]: Joining mDNS multicast group on interface enp6s0.IPv4 with address 192.168.1.239.
Sep 03 18:28:21 saruman avahi-daemon[989]: New relevant interface enp6s0.IPv4 for mDNS.
Sep 03 18:28:21 saruman avahi-daemon[989]: Registering new address record for 192.168.1.239 on enp6s0.IPv4.
Sep 03 18:28:22 saruman systemd[1]: systemd-rfkill.service: Deactivated successfully.
Sep 03 18:28:23 saruman NetworkManager[1016]: <info>  [1693762103.3544] device (enp6s0): state change: ip-config -> ip-check (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:23 saruman NetworkManager[1016]: <info>  [1693762103.3553] device (enp6s0): state change: ip-check -> secondaries (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:23 saruman NetworkManager[1016]: <info>  [1693762103.3554] device (enp6s0): state change: secondaries -> activated (reason 'none', sys-iface-state: 'managed')
Sep 03 18:28:23 saruman NetworkManager[1016]: <info>  [1693762103.3555] manager: NetworkManager state is now CONNECTED_SITE
Sep 03 18:28:23 saruman NetworkManager[1016]: <info>  [1693762103.3556] device (enp6s0): Activation: successful, device activated.
Sep 03 18:28:27 saruman NetworkManager[1016]: <info>  [1693762107.3532] device (enp6s0): state change: activated -> unavailable (reason 'carrier-changed', sys-iface-state: 'managed')
Sep 03 18:28:27 saruman avahi-daemon[989]: Withdrawing address record for 192.168.1.239 on enp6s0.
Sep 03 18:28:27 saruman avahi-daemon[989]: Leaving mDNS multicast group on interface enp6s0.IPv4 with address 192.168.1.239.
Sep 03 18:28:27 saruman avahi-daemon[989]: Interface enp6s0.IPv4 no longer relevant for mDNS.
Sep 03 18:28:27 saruman NetworkManager[1016]: <info>  [1693762107.5266] manager: NetworkManager state is now CONNECTED_LOCAL
Sep 03 18:28:27 saruman NetworkManager[1016]: <info>  [1693762107.5267] manager: NetworkManager state is now DISCONNECTED
Sep 03 18:28:27 saruman systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.

As mentioned previously, CONFIG_PROVE_LOCKING=y and I'm seeing splats during boot, notably RTNL assertion failed at net/core/dev.c (2877) and suspicious RCU usage.

Cheers
James



