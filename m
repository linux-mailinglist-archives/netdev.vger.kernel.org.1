Return-Path: <netdev+bounces-278203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBC5GtVg3WlpdQkAu9opvQ
	(envelope-from <netdev+bounces-278203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8C3F38B6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 779433018B62
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A139524E;
	Mon, 13 Apr 2026 21:32:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8F3537C4;
	Mon, 13 Apr 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115923; cv=none; b=jmfUIzBFBF/m44QDBSgQEclhwoTFmSiGOxJncsBHnZ5cKiLIvQCtSGXfsBJg3UBkea1Q6Jk/fzKzNZ/Hp42e+GtOblBBBSDkRDu8ouL0Tmz932VWx07RX1KxE0zuIsJ9AtWJuiHWjiJ2WwZrEjid+QIZ6vJj2QXViKGLhz02c6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115923; c=relaxed/simple;
	bh=MZoCFJEcd1rlZbihzaPj9mcGjtYih9+dFesBfopE024=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hpt5Ztni4MaC+U8KaaeAz+3ySg+swcqQALZdlBXCO6j9LweH+Ldul/l4Kdh5bSoVcJqzht/39KrehZxHgavs7w5IZ/RyDBTsUKVLW/UmbSA79MPwn/va77MDsNDr7hFSm2dxiqIvMmj8a31Hh66pp/ylVYCGq3An9PVaxU5bkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af789.dynamic.kabel-deutschland.de [95.90.247.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 05AB94C2C37F0B;
	Mon, 13 Apr 2026 23:30:53 +0200 (CEST)
Message-ID: <e539632b-9f02-436d-ac77-34e7673d8100@molgen.mpg.de>
Date: Mon, 13 Apr 2026 23:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion in
 ice_cfg_tx_topo via ice_init_dev_hw
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Dave Ertman <david.m.ertman@intel.com>,
 jacob.e.keller@intel.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
References: <20260413191420.3524013-1-poros@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278203-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,intel.com,gmail.com,blackwall.org,google.com,lunn.ch,kernel.org,redhat.com,davemloft.net,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 12F8C3F38B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Petr,


Thank you very much for your patch.

Am 13.04.26 um 21:14 schrieb Petr Oros:
> On certain E810 configurations where firmware supports Tx scheduler
> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
> may need to apply a new 5-layer or 9-layer topology from the DDP
> package. If the AQ command to set the topology fails (e.g. due to
> invalid DDP data or firmware limitations), the global configuration
> lock must still be cleared via a CORER reset.
> 
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
> scheduler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
> lock and re-initialize hardware via ice_init_hw() afterwards.
> 
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
> breaking the reinit path introduced by 86aae43f21cf. This creates an
> infinite recursive call chain:
> 
>    ice_init_hw()
>      ice_init_dev_hw()
>        ice_cfg_tx_topo()         # topology change needed
>          ice_deinit_hw()
>          ice_init_hw()           # reinit after CORER
>            ice_init_dev_hw()     # recurse
>              ice_cfg_tx_topo()
>                ...               # stack overflow
> 
> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
> during its reinit, it only needs the core HW reinitialization. This
> breaks the recursion cleanly without adding flags or guards.
> 
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
> are preserved, only the init-side placement of ice_init_dev_hw() is
> reverted.
> 
> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 ++
>   drivers/net/ethernet/intel/ice/ice_common.c      | 2 --
>   drivers/net/ethernet/intel/ice/ice_main.c        | 2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index 6144cee8034d77..641d6e289d5ce6 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1245,6 +1245,8 @@ static int ice_devlink_reinit_up(struct ice_pf *pf)
>   		return err;
>   	}
>   
> +	ice_init_dev_hw(pf);
> +
>   	/* load MSI-X values */
>   	ice_set_min_max_msix(pf);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ce11fea122d03e..b617a6bff89134 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1126,8 +1126,6 @@ int ice_init_hw(struct ice_hw *hw)
>   	if (status)
>   		goto err_unroll_fltr_mgmt_struct;
>   
> -	ice_init_dev_hw(hw->back);
> -
>   	mutex_init(&hw->tnl_lock);
>   	ice_init_chk_recipe_reuse_support(hw);
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e2a5534819d194..a27be29f9bbbfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5314,6 +5314,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   		return err;
>   	}
>   
> +	ice_init_dev_hw(pf);
> +
>   	adapter = ice_adapter_get(pdev);
>   	if (IS_ERR(adapter)) {
>   		err = PTR_ERR(adapter);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

