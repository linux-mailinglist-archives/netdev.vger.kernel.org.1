Return-Path: <netdev+bounces-53316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D180255F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE588280E3F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7615AE2;
	Sun,  3 Dec 2023 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmaC0b9Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB2DDCD
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 16:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93742C433C7;
	Sun,  3 Dec 2023 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701620573;
	bh=b+HQxmADgxcaKYfeScRrPsfKr0PQRdIqvtndccl3ae4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmaC0b9Q3y99uYWwDy4aWaK9FS3j8sGI8mDZMM0SvvBB0fEePNO9ybiMgkdbL4S1s
	 OBNwyiiu8/CgZY6HObBKsCai9VmIx3JfLI3vTZ6nriF2+0bjCez+Cu1KvbOeMFLXSG
	 UZS68FQA/2EU/gGoeEO4oo6c6Rh54yEAHZYby+3BKnsPH4OgZVAyMGeDRTCGDpCNqy
	 t56n8URjbEiMfsMHTXvwGHduSi3gkicJGtIAiVHQ9EWu/LIXJbSCTm1yY/ZctljnyG
	 6Vt3kEPjHYHvGYqsgqv6vFEzwqbB440vE6uu8ieZ699NfXH1pmxl6eKZj2eqstIgib
	 D6GqmzTo61q2Q==
Date: Sun, 3 Dec 2023 16:22:48 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, mschmidt@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/5] i40e: Remove VEB recursion
Message-ID: <20231203162248.GJ50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-6-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-6-ivecera@redhat.com>

On Fri, Nov 24, 2023 at 04:03:43PM +0100, Ivan Vecera wrote:
> The VEB (virtual embedded switch) as a switch element can be
> connected according datasheet though its uplink to:
> - Physical port
> - Port Virtualizer (not used directly by i40e driver but can
>   be present in MFP mode where the physical port is shared
>   between PFs)
> - No uplink (aka floating VEB)
> 
> But VEB uplink cannot be connected to another VEB and any attempt
> to do so results in:
> 
> "i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"
> 
> that indicates "the uplink SEID does not point to valid element".
> 
> Remove this logic from the driver code this way:
> 
> 1) For debugfs only allow to build floating VEB (uplink_seid == 0)
>    or main VEB (uplink_seid == mac_seid)
> 2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
>    sub-VEBs
> 3) Ditto for i40e_veb_rebuild() + simplify the function as we know
>    that the VEB for rebuild can be only the main LAN VEB or some
>    of the floating VEBs
> 4) In i40e_rebuild() there is no need to check veb->uplink_seid
>    as the possible ones are 0 and MAC SEID
> 5) In i40e_vsi_release() do not take into account VEBs whose
>    uplink is another VEB as this is not possible
> 6) Remove veb_idx field from i40e_veb as a VEB cannot have
>    sub-VEBs
> 
> Tested using i40e debugfs interface:
> 1) Initial state
> [root@cnb-03 net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [   98.440641] i40e 0000:02:00.0: header: 3 reported 3 total
> [   98.446053] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [   98.452593] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [   98.458856] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 2) Add floating VEB
> [root@cnb-03 net-next]# echo add relay > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  122.745630] i40e 0000:02:00.0: added relay 162
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  136.650049] i40e 0000:02:00.0: header: 4 reported 4 total
> [  136.655466] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  136.661994] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  136.668264] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> [  136.674787] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> 
> 3) Add VMDQ2 VSI to this new VEB
> [root@cnb-03 net-next]# dmesg -c
> [  168.351763] i40e 0000:02:00.0: added VSI 394 to relay 162
> [  168.374652] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  195.683204] i40e 0000:02:00.0: header: 5 reported 5 total
> [  195.688611] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  195.695143] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  195.701410] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  195.707935] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  195.714201] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 4) Try to delete the VEB
> [root@cnb-03 net-next]# echo del relay 162 > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  239.260901] i40e 0000:02:00.0: deleting relay 162
> [  239.265621] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left
> 
> 5) Do PF reset and check switch status after rebuild
> [root@cnb-03 net-next]# echo pfr > $CMD
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> ...
> [  272.333655] i40e 0000:02:00.0: header: 5 reported 5 total
> [  272.339066] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  272.345599] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  272.351862] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  272.358387] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  272.364654] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 6) Delete VSI and delete VEB
> [  297.199116] i40e 0000:02:00.0: deleting VSI 394
> [  299.807580] i40e 0000:02:00.0: deleting relay 162
> [  309.767905] i40e 0000:02:00.0: header: 3 reported 3 total
> [  309.773318] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  309.779845] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  309.786111] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


