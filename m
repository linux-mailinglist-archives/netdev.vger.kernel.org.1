Return-Path: <netdev+bounces-164869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7DA2F7BB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF618857B0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1D25E452;
	Mon, 10 Feb 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="q9OFMfGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42625E447
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213235; cv=none; b=mmpT33AwTrwj0t692Kax2hyDSzA/miBuu7ltazfYpuFSFIn7F980CrA6eS2+Ma4o+fnNWTj664jd18DAh3Yrm4PkdW62ZesBuvkXe36Bp1I7T7WKKT5jr5cg7QtIJtgMRiz6zhY9plea2Q72qH8dwja5rVTBTeMVLjEog+agjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213235; c=relaxed/simple;
	bh=kR4uIcLTdOkQ46tM2mJVGzJisWBafHjyrT4N+VLUGMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEkbI6Yys9IFhYA9iNEZPg5clTLrVkBf5WGbJs4MbOQJyEV+JjtHDM01qx1AvPt3PMTRHU69eUhf8B5ztUUZm7ffHqwbBfGSGOG8juQ8/AZHMDgtS4Wm60yD0w7oL+kyU+HV459OLmlcKhxmlUZJBqOKvNSu0NdL3LW9MzNSxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=q9OFMfGf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f7f1e1194so46948715ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739213233; x=1739818033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vS+R9r6QwfgQsutdOUsz1zbnMNHKHHCfPpNBqcMo6M=;
        b=q9OFMfGfHZ8O/jUXOE7FqioxELS9mbDDnm/pYSVgoXVDsySiQK29m2IeGEFTH7+7eo
         N8O7nlf6pjGu/BQ1iH49URpC8hYWbUYXp9jTJtYCWrVjN8YFLvAs82e8+GOpewsfhqm9
         n+d37KLf3t2LiHi5pHETIMRmsdq9gC2CQkgAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739213233; x=1739818033;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vS+R9r6QwfgQsutdOUsz1zbnMNHKHHCfPpNBqcMo6M=;
        b=wgky9iT4D4uSzYmvaasjQP1jjL7cchYBO5OLKDxZ64hLEQKHSepBQKSKDHpt9MP56o
         2Zr4TRBKkq2uVWHL5NU+WAUZGTeV1hCoPPm+6X3O5hqdCKxWpDk7Jtor4vppLN6ouy2C
         Z1ZBygLy/BYhoHC0SuSnExeL5AZN1bjb5fj8PzTgkggCWWD5AFG31mDcXjjf+qUhlLXC
         hYZHmzwgKcO/KvzU4MNAJkAyCjQ/m0906t0EZ1KG4JrSuro1+hF7TwC6KxpEskm1u2c3
         mfEvCjNmo9wl9KBvMp9vgCJ18fQJkOldpsCeZZJqSkViBGdW+Xu3m/AkYPEj+mUJwTrI
         drAg==
X-Forwarded-Encrypted: i=1; AJvYcCUDM0Qu42staSNESl9Tmz6ZmOm5M4Xh38wbCpllGwpoqJ1clAYpFZWn6f1j/0V+L/9mO0DctL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVU6fD6WB05zSDzF2UKt6S/r8Ws8MPizZO+NP0ctC39KZeiP+w
	FJQGArUQDGeLBzfXb+NkunQJ6o1mwmfpnUCt4/5fG12gcGRGQ2TymEnadzPmdnM=
X-Gm-Gg: ASbGncveuJKf+jieusyYL62lZRZWSgDXorltOaaJZ+KVcxg1lbxQvOZy4+aVmR4Hy8q
	/WSzD0J2A7TMZvO+k+VU+LE6L2D58s+cg4JyARVme1nr/uXcBoCmB7BAh/y9jjb/YzB6Tg41Th8
	ubuKdHTOY0Xlpk8SoT7lHtFeoFBIfni/v27+WGH6M9MGzrgGSsMO4EQLV0ctaYUdfrslxvVoJ4w
	4Q3+DpnRWvOfDTg0Q8ccHYYrjQdCwH/nj6Cc7VnsVjCCwQuaPcXO95El9nZGzi9Ait608X5/sQZ
	prpSQEMI6iAkq1Ks8OBvrT2OZ3sS4SU4BceZM3U1r5CycMEhPoLCHS5BrQ==
X-Google-Smtp-Source: AGHT+IH/pmfRtbhhKoGspZi03DIQ2MheVXjwe1mrxcsIVwMzba26/0KygkRTSGNq6EQufftaUIcDEg==
X-Received: by 2002:a17:902:f60a:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21f4e73b2c6mr262378865ad.40.1739213232932;
        Mon, 10 Feb 2025 10:47:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad54f1691ddsm2747458a12.61.2025.02.10.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:47:12 -0800 (PST)
Date: Mon, 10 Feb 2025 10:47:09 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] igb: Link queues to NAPI instances
Message-ID: <Z6pJrRRqcHYhZWss@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-2-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-igb_irq-v1-2-bde078cdb9df@linutronix.de>

On Mon, Feb 10, 2025 at 10:19:36AM +0100, Kurt Kanzenbach wrote:
> Link queues to NAPI instances via netdev-genl API. This is required to use
> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy polling
> support") for details.
> 
> This also allows users to query the info with netlink:
> 
> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> |                               --dump queue-get --json='{"ifindex": 2}'
> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
> 
> While at __igb_open() use RCT coding style.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>  drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
>  3 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 02f340280d20a6f7e32bbd3dfcbb9c1c7b4c6662..79eca385a751bfdafdf384928b6cc1b350b22560 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -722,6 +722,8 @@ enum igb_boards {
>  
>  extern char igb_driver_name[];
>  
> +void igb_set_queue_napi(struct igb_adapter *adapter, int q_idx,
> +			struct napi_struct *napi);
>  int igb_xmit_xdp_ring(struct igb_adapter *adapter,
>  		      struct igb_ring *ring,
>  		      struct xdp_frame *xdpf);
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4128d19cc08f62f95682069bb5ed9b8bbbf10cb..8e964484f4c9854e4e3e0b4f3e8785fe93bd1207 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2099,6 +2099,22 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
>  	wr32(E1000_CTRL_EXT, ctrl_ext);
>  }
>  
> +void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
> +			struct napi_struct *napi)
> +{
> +	struct igb_q_vector *q_vector = adapter->q_vector[vector];
> +
> +	if (q_vector->rx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->rx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_RX, napi);
> +
> +	if (q_vector->tx.ring)
> +		netif_queue_set_napi(adapter->netdev,
> +				     q_vector->tx.ring->queue_index,
> +				     NETDEV_QUEUE_TYPE_TX, napi);
> +}
> +
>  /**
>   *  igb_up - Open the interface and prepare it to handle traffic
>   *  @adapter: board private structure
> @@ -2106,6 +2122,7 @@ static void igb_check_swap_media(struct igb_adapter *adapter)
>  int igb_up(struct igb_adapter *adapter)
>  {
>  	struct e1000_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>  	int i;
>  
>  	/* hardware has been reset, we need to reload some things */
> @@ -2113,8 +2130,11 @@ int igb_up(struct igb_adapter *adapter)
>  
>  	clear_bit(__IGB_DOWN, &adapter->state);
>  
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&(adapter->q_vector[i]->napi));
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igb_set_queue_napi(adapter, i, napi);
> +	}

It looks like igb_ub is called from igb_io_resume (struct
pci_error_handlers). I don't know if RTNL is held in that path. If
its not, this could trip the ASSERT_RTNL in netif_queue_set_napi.

Can you check and see if this is an issue for that path?

igb_reinit_locked looks OK (as the name implies).

>  
>  	if (adapter->flags & IGB_FLAG_HAS_MSIX)
>  		igb_configure_msix(adapter);
> @@ -2184,6 +2204,7 @@ void igb_down(struct igb_adapter *adapter)
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		if (adapter->q_vector[i]) {
>  			napi_synchronize(&adapter->q_vector[i]->napi);
> +			igb_set_queue_napi(adapter, i, NULL);
>  			napi_disable(&adapter->q_vector[i]->napi);

Same question as above. It looks like igb_down is called from
igb_io_error_detected. I don't know if RTNL is held in that path. If
its not, it'll trip the ASSERT_RTNL in netif_queue_set_napi.

Can you check if that's an issue for this path, as well?

>  		}
>  	}
> @@ -4116,8 +4137,9 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  static int __igb_open(struct net_device *netdev, bool resuming)
>  {
>  	struct igb_adapter *adapter = netdev_priv(netdev);
> -	struct e1000_hw *hw = &adapter->hw;
>  	struct pci_dev *pdev = adapter->pdev;
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>  	int err;
>  	int i;
>  
> @@ -4169,8 +4191,11 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>  	/* From here on the code is the same as igb_up() */
>  	clear_bit(__IGB_DOWN, &adapter->state);
>  
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&(adapter->q_vector[i]->napi));
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igb_set_queue_napi(adapter, i, napi);
> +	}

The above looks fine. __igb_open is called from __igb_resume which
takes care of RTNL. So, I think this part is fine.


>  	rd32(E1000_TSICR);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 157d43787fa0b55a74714f69e9e7903b695fcf0a..a5ad090dfe94b6afc8194fe39d28cdd51c7067b0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -45,6 +45,7 @@ static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
>  	synchronize_net();
>  
>  	/* Rx/Tx share the same napi context. */
> +	igb_set_queue_napi(adapter, qid, NULL);
>  	napi_disable(&rx_ring->q_vector->napi);
>  
>  	igb_clean_tx_ring(tx_ring);
> @@ -78,6 +79,7 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  
>  	/* Rx/Tx share the same napi context. */
>  	napi_enable(&rx_ring->q_vector->napi);
> +	igb_set_queue_napi(adapter, qid, &rx_ring->q_vector->napi);
>  }

These seem fine to me.

