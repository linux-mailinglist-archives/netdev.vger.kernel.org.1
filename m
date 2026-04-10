Return-Path: <netdev+bounces-277427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEUFOi/82GmRkggAu9opvQ
	(envelope-from <netdev+bounces-277427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:33:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA83D826A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97591300D4D2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174E3A7849;
	Fri, 10 Apr 2026 13:33:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB6388E40;
	Fri, 10 Apr 2026 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828012; cv=none; b=WQ36mzsq+eQansfLsrKpdRmbD4nCNgEa5KlU+2C1Nl6H/DjFEQC4PidJyVzJQDnLr17gn4RNhuTPk31rkP1ycGbjbhotZhVDdpmFTw9OBmuZNB3jHIUukY6x2EDTrkG4gFBjI7h3JvwNnM2+yUVeyyqVw/S/7cSPp6lbVk5aPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828012; c=relaxed/simple;
	bh=4q75PxGtQMEjd1qrWb2q48Z/ykzfKOA2kScs3WI76/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWOpaj2oScI3O8gZqjzCWCFTyhyPlv0IiOb1qI95dcC/4UoXcSy/GD6afoCAa8iN5eGBa/ZgSCQPLVUYWOQph+BDMVYiWpdQSK3RWn0ekG166wWQmtXyxfo74dBMTFkZFSbopWAqbwXAmyjc2pXvYVLaQnCg+TXemS9MxIPSaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ADF1D4C2C37D58;
	Fri, 10 Apr 2026 15:32:37 +0200 (CEST)
Message-ID: <0941aca7-66b9-4bd4-aa9f-c8e020e32bb1@molgen.mpg.de>
Date: Fri, 10 Apr 2026 15:32:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix double free in
 ice_sf_eth_activate() error path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Piotr Raczynski <piotr.raczynski@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, stable@kernel.org
References: <2026040919-junior-glue-10d0@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2026040919-junior-glue-10d0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FCA83D826A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Greg,


Thank you for the patch.

Am 09.04.26 um 17:11 schrieb Greg Kroah-Hartman:
> When auxiliary_device_add() fails, the aux_dev_uninit label calls
> auxiliary_device_uninit() and falls through to sf_dev_free and xa_erase.
> The uninit invokes ice_sf_dev_release(), which already frees sf_dev via
> kfree() and erases the entry from ice_sf_aux_id.  The fall-through then
> double-frees sf_dev and double-erases the id.
> 
> This is reachable from userspace via the devlink port function state-set
> netlink command.
> 
> Fix this by returning right after uninit because the release callback
> handles all cleanup correctly.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Piotr Raczynski <piotr.raczynski@intel.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Fixes: 177ef7f1e2a0 ("ice: base subfunction aux driver")
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> index 2cf04bc6edce..6bc8aa896762 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
> @@ -304,7 +304,9 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
>   	return 0;
>   
>   aux_dev_uninit:
> +	/* ice_sf_dev_release() frees sf_dev and erases the xa entry */
>   	auxiliary_device_uninit(&sf_dev->adev);
> +	return err;
>   sf_dev_free:
>   	kfree(sf_dev);
>   xa_erase:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

