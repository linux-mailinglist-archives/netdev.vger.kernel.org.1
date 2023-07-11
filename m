Return-Path: <netdev+bounces-16833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BC74EDB9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE99D281742
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8E18C03;
	Tue, 11 Jul 2023 12:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7F1774C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2655AC433C7;
	Tue, 11 Jul 2023 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689077414;
	bh=j1j3Om+f/weamMS17lDUfHXZOGqdetaPn7zYnPzhwgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6Q+rpa13Lk191/ltGcjaFZacyr1Nl9sx4nSW4T91bDRUWnG+nuOq7+xRTtx1A0Ze
	 EtMa5W7bHyC4GAXp1gQiBhBJJufCskOXqnp9KbQMmHLQr5hGvCZ6QVJtgiQeTmmXxA
	 iMhNXJDXqvcaiUJ25iF6RXDJxoGoQCfdzOePTTq2GdzJAGkBbO2Uq/XjhqApbj7zf7
	 P1MQycVWIGcfapUFfcU4kOP0IiVujXvNTo83A/bmrk9NlDq55enNEICOcc4r0DNnzx
	 0e8W3riIkbb5rb+aztio/0sSkczARwVuJmthD664OxkkI+ckrxnDqBBigLVdLzgUaI
	 b4Vets3g3pKFQ==
Date: Tue, 11 Jul 2023 15:10:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>, Ma Yuying <yuma@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 2/2] i40e: Wait for pending VF reset in VF set
 callbacks
Message-ID: <20230711121009.GQ41919@unreal>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
 <20230710164030.2821326-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710164030.2821326-3-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:40:30AM -0700, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Commit 028daf80117376 ("i40e: Fix attach VF to VM issue") fixed
> a race between i40e_ndo_set_vf_mac() and i40e_reset_vf() during
> an attachment of VF device to VM. This issue is not related to
> setting MAC address only but also VLAN assignment to particular
> VF because the newer libvirt sets configured MAC address as well
> as an optional VLAN. The same behavior is also for i40e's
> .ndo_set_vf_rate and .ndo_set_vf_spoofchk where the callbacks
> just check if the VF was initialized but not wait for the finish
> of pending reset.
> 
> Reproducer:
> [root@host ~]# virsh attach-interface guest hostdev --managed 0000:02:02.0 --mac 52:54:00:b4:aa:bb
> error: Failed to attach interface
> error: Cannot set interface MAC/vlanid to 52:54:00:b4:aa:bb/0 for ifname enp2s0f0 vf 0: Resource temporarily unavailable
> 
> Fix this issue by using i40e_check_vf_init_timeout() helper to check
> whether a reset of particular VF was finished in i40e's
> .ndo_set_vf_vlan, .ndo_set_vf_rate and .ndo_set_vf_spoofchk callbacks.
> 
> Tested-by: Ma Yuying <yuma@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

