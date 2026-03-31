Return-Path: <netdev+bounces-273717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPf0IIgHzGn+NQYAu9opvQ
	(envelope-from <netdev+bounces-273717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F9036F2A5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DE6E3013B4A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35D3FFAAA;
	Tue, 31 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG8740+2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27432E143;
	Tue, 31 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978650; cv=none; b=l6kS9QWRAMhZU+cj4rSoa0UGifwJEc+ro243X4POOB72GgxE0vt6ba+pFUF1FpS4kBSPacGuE704B2b6nStV220fsNxegYWFSnFA3INfwUmHAm5ubNB6k7tGgCKB+IQczBFKCZTpnB3sdzp3UtPb2IAL7VlJrth9mi8nyU8J/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978650; c=relaxed/simple;
	bh=WpksPXyIw99SXHP6XfvYRIkFqPTyrE4cKVEoLSPOGjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IBmSMptGbItx4o1xBAbQtOR91FXzLHeVhM3Ldj27Fk09BSLmZp3TpDeWeBzQARiuKHhFeB9INpb5cvHy9NyneMuDQZ7QZWqthaJGf9l0i+VsFdgNP5FGTawfVHuoQTU/QOmp2Skf8Wg9l9Zv70Ka5PgUxzv+oyKQ7jR5cD1Q7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG8740+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC550C19424;
	Tue, 31 Mar 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978649;
	bh=WpksPXyIw99SXHP6XfvYRIkFqPTyrE4cKVEoLSPOGjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gG8740+2jWsBB00A/DGIMlZt4K6JOxU/WvIpb+wuD8JausTJEDb406FlA5+BejckJ
	 L1FgnjFO2WC9OvEWzMnTKEtsWanbjPH/VLFpePdQhsJsutw2Vr9tEFlAFQX/2wmNbL
	 x5jHIwDjqzf+oegOQptAITdZYTUXDLzKzqR/pM5skk9ss7t2sIBV2UaIY+SqhmgW4C
	 2QOm+qD3krGLt6g2p7/ZiaQVNhRyNYaWtU+/XuS/QUeaJTut6DGtygKO3DpoVxY/yk
	 TVzjAHFWTVooRrgLPvwNqNVhOgUQJ9CKM+Fg0QY26EOX51zaq8TsmsCse5XvJSAO/l
	 DF/LWj63WXKCw==
Date: Tue, 31 Mar 2026 12:37:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
	dima.ruinskiy@intel.com, mbloch@nvidia.com, leon@kernel.org,
	linux-pci@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	lukas@wunner.de, bhelgaas@google.com, richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with
 rtnl locked
Message-ID: <20260331173728.GA146742@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330230248.646900-2-anthony.l.nguyen@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,intel.com,nvidia.com,wunner.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2F9036F2A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:02:30PM -0700, Tony Nguyen wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> When runtime resuming igc we get:
> 
>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> 
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.

Taking the rtnl lock unconditionally certainly makes the code nicer,
but the commit log only mentions the "avoid the warning" benefit, not
the actual reason this is safe to do.

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 72bc5128d8b8..98024b46789f 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7536,7 +7536,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
>  	netif_rx(skb);
>  }
>  
> -static int __igc_resume(struct device *dev, bool rpm)
> +static int __igc_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct net_device *netdev = pci_get_drvdata(pdev);
> @@ -7581,11 +7581,9 @@ static int __igc_resume(struct device *dev, bool rpm)
>  	wr32(IGC_WUS, ~0);
>  
>  	if (netif_running(netdev)) {
> -		if (!rpm)
> -			rtnl_lock();
> +		rtnl_lock();
>  		err = __igc_open(netdev, true);
> -		if (!rpm)
> -			rtnl_unlock();
> +		rtnl_unlock();
>  		if (!err)
>  			netif_device_attach(netdev);
>  	}
> @@ -7595,12 +7593,12 @@ static int __igc_resume(struct device *dev, bool rpm)
>  
>  static int igc_resume(struct device *dev)
>  {
> -	return __igc_resume(dev, false);
> +	return __igc_resume(dev);
>  }
>  
>  static int igc_runtime_resume(struct device *dev)
>  {
> -	return __igc_resume(dev, true);
> +	return __igc_resume(dev);
>  }
>  
>  static int igc_suspend(struct device *dev)
> -- 
> 2.47.1
> 

