Return-Path: <netdev+bounces-209974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EBAB11A39
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A021668D3
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807772046A9;
	Fri, 25 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IfN/1RrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2631F03D5
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433346; cv=none; b=LurojmghE2dMpCqPtqeWJvmsC/SLwNiH+be58bS8+2ZgTUBQ2zmdgUk+HjrMHzaX4TcxrXLlU5uE9nByO4M6Uflz7331RCuPL0OXIZ2qQ54JWZHp8thFuDhNG3CApov418eBWY19Vi6g4TGyBlz1lrTAoufH4LHZoY5MEFiHZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433346; c=relaxed/simple;
	bh=mLb2N9Sk52gxfDFaR98oVbkimyev4kEyhPLHisBUWOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcjg4QbEF3eMfCI489lK1jITDzYOdBKOKrg0FPoXa8ytjv3pfs0NWfYI7GkKPpIeuk8yi69Uuxo5z6/z/NoJmC5yKnnpj0h3UmkrvvPFcfQEZ1mb9Sf1PQA84uEqVGlsz5OsqAosjQaQ3dfmnPocddV0ZQpN2/KARUQoCbDCXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IfN/1RrF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so4176448a12.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1753433343; x=1754038143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbgBxVqvuAaSCTHnKyGAvWS3c7FK3JV6irIi80dt/AA=;
        b=IfN/1RrFygL+ZxwARMQ11mpRaZn4LauNY1cGiOE5F55rnCEbD3nsumjGn3dWlocqXO
         9qmco4aZkXo0tcAqEKNc5ClmKQbLBNRMJXNy7MFwB9v1U+84WCz94nGqaln5Rs+OPnEv
         nMySxJomILi2wJ92QbSwEja4a0LHsT+USdTa9EqGgn0TBxLvS9uRZD4IMVA8dFVnc0Wn
         y+0Gho9j986qI5NuTNYeIXKihMbLurHQPodqF+fjOy/CcYXjyD46S0DRJJjV9DNpdBIR
         gxe9lf496P2+ygJi+AOL3yLWyXwIs/DML8DyDXarWhv4NOXvpNPyZNNToTbXI6tfAkDz
         5G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433343; x=1754038143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbgBxVqvuAaSCTHnKyGAvWS3c7FK3JV6irIi80dt/AA=;
        b=Iuw5GdiLKmw4a1mCZTbylGClUrmpAj1/+q+rDq/Vlv7htyPN61QhC07xuc4sEauA41
         XJSCvTqW2LMe8zAQiPNJNhbiFNHSvt1D1qklCat5ur4dMG1XkzFrEKzbJztFFKaQBNNc
         dg+YsnprRVaqUzuz+qpqg4CYUk+w7NtlGST4s9H8I8rVMmRpnBbQj/DJxPLJMY6AuGbC
         HeokiEFFpy0gZMifz1794d1bigtbkLEKocSH5VGb+EsKVJpLejJOQKvEM6dtIBHyZKQJ
         Gdc0KEoubki1wV7ur2R7xANuF/r0v1nCHftfCpmriN2Zw0oWbOMPORWrtSgFzKXJjzx2
         7Nsg==
X-Forwarded-Encrypted: i=1; AJvYcCUleZ1nKKCAanY8OXnyWWiAFyCcAzIjwD8288RjZe9pXEmjqInGgedewj54AkMQJcX6vhV6C9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWGLiifQ9N/FgxLqapJKS9fccqPMFr+2mT9DcubTNexW+hwxI
	HtDrU4NEm518sBBPeI0vPXKh59ciVmMZr01iilJoHE2Nr8uF0eEM0p3wcukf/AAMY5I=
X-Gm-Gg: ASbGncvizD1KhK51ZrtbAwWm4TsK8XfNdHQxAMnStP5K15YNpyGWygAw8X5Y+TuKXfD
	tQrJD9VnL6Xgd2XUJw7x2CcEKujfIVQNFfDGOYysLqdv/TebZjrWpjPJdVTpaIPpY0SN1T6lP4Q
	lwX+ohThDeE094870cFBTwGt+XMqgsRYSFQokJEA9pMFXznPAvvLLDj3DCehDHed/9OMUCRUcnL
	N/9DrjDY9anwz4WmAeMlMRB9ojiAwTIJ07GEaoVNJuExE5XLb6eRbEXTCP3/XTEz4LHvJOTacuZ
	jVpGJjwnlOBfAvAXVQ7PPTTAiUzbRvV2EPnwQB9T2Sng9bx+WDOcndJqsmelSN6WfuGprU8csM7
	zFtHtiIPv7FW8ihY0o+f343p1dnwdq0+K41FI8RABeXysLoGcIoFE1Ipu2MaHFITf
X-Google-Smtp-Source: AGHT+IGp/h33UX4VuxGPj+pY0fYttSnIKhYoSPyGHW4EMhc9+8Q1n1iPPrKA8O8mMIX/IrOuoIiu3w==
X-Received: by 2002:a05:6402:50cb:b0:607:2e08:f3e6 with SMTP id 4fb4d7f45d1cf-614f05f6207mr1099160a12.17.1753433342161;
        Fri, 25 Jul 2025 01:49:02 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd336253sm1883539a12.65.2025.07.25.01.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:49:01 -0700 (PDT)
Message-ID: <367f9bbb-537b-4828-b8c8-cfc9d8ca8c2c@blackwall.org>
Date: Fri, 25 Jul 2025 11:49:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] bonding: send LACPDUs periodically in passive
 mode after receiving partner's LACPDU
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alessandro Zanni <alessandro.zanni87@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725062848.18889-1-liuhangbin@gmail.com>
 <20250725062848.18889-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250725062848.18889-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 09:28, Hangbin Liu wrote:
> When `lacp_active` is set to `off`, the bond operates in passive mode, meaning
> it only "speaks when spoken to." However, the current kernel implementation
> only sends an LACPDU in response when the partner's state changes.
> 
> As a result, once LACP negotiation succeeds, the actor stops sending LACPDUs
> until the partner times out and sends an "expired" LACPDU. This causes
> continuous LACP state flapping.
> 
> According to IEEE 802.1AX-2014, 6.4.13 Periodic Transmission machine. The
> values of Partner_Oper_Port_State.LACP_Activity and
> Actor_Oper_Port_State.LACP_Activity determine whether periodic transmissions
> take place. If either or both parameters are set to Active LACP, then periodic
> transmissions occur; if both are set to Passive LACP, then periodic
> transmissions do not occur.
> 
> To comply with this, we remove the `!bond->params.lacp_active` check in
> `ad_periodic_machine()`. Instead, we initialize the actor's port's
> `LACP_STATE_LACP_ACTIVITY` state based on `lacp_active` setting.
> 
> Additionally, we avoid setting the partner's state to
> `LACP_STATE_LACP_ACTIVITY` in the EXPIRED state, since we should not assume
> the partner is active by default.
> 
> This ensures that in passive mode, the bond starts sending periodic LACPDUs
> after receiving one from the partner, and avoids flapping due to inactivity.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Shouldn't the fixes tag be lacp_active commit id?
E.g. 3a755cd8b7c6 ("bonding: add new option lacp_active")

> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_3ad.c     | 72 ++++++++++++++++++++++--------
>  drivers/net/bonding/bond_options.c |  1 +
>  include/net/bond_3ad.h             |  1 +
>  3 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 2fca8e84ab10..aa64b397bb19 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -95,13 +95,13 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
>  static void ad_mux_machine(struct port *port, bool *update_slave_arr);
>  static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
>  static void ad_tx_machine(struct port *port);
> -static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
> +static void ad_periodic_machine(struct port *port);
>  static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
>  static void ad_agg_selection_logic(struct aggregator *aggregator,
>  				   bool *update_slave_arr);
>  static void ad_clear_agg(struct aggregator *aggregator);
>  static void ad_initialize_agg(struct aggregator *aggregator);
> -static void ad_initialize_port(struct port *port, int lacp_fast);
> +static void ad_initialize_port(struct port *port, struct bond_params *bond_params);
>  static void ad_enable_collecting(struct port *port);
>  static void ad_disable_distributing(struct port *port,
>  				    bool *update_slave_arr);
> @@ -1307,10 +1307,16 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
>  			 * case of EXPIRED even if LINK_DOWN didn't arrive for
>  			 * the port.
>  			 */
> -			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
>  			port->sm_vars &= ~AD_PORT_MATCHED;
> +			/* Based on IEEE 8021AX-2014, Figure 6-18 - Receive
> +			 * machine state diagram, the statue should be
> +			 * Partner_Oper_Port_State.Synchronization = FALSE;
> +			 * Partner_Oper_Port_State.LACP_Timeout = Short Timeout;
> +			 * start current_while_timer(Short Timeout);
> +			 * Actor_Oper_Port_State.Expired = TRUE;
> +			 */
> +			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
>  			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
> -			port->partner_oper.port_state |= LACP_STATE_LACP_ACTIVITY;
>  			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
>  			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
>  			port->sm_vars |= AD_PORT_CHURNED;
> @@ -1417,11 +1423,10 @@ static void ad_tx_machine(struct port *port)
>  /**
>   * ad_periodic_machine - handle a port's periodic state machine
>   * @port: the port we're looking at
> - * @bond_params: bond parameters we will use
>   *
>   * Turn ntt flag on priodically to perform periodic transmission of lacpdu's.
>   */
> -static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
> +static void ad_periodic_machine(struct port *port)
>  {
>  	periodic_states_t last_state;
>  
> @@ -1430,8 +1435,7 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>  
>  	/* check if port was reinitialized */
>  	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
> -	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
> -	    !bond_params->lacp_active) {
> +	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY))) {
>  		port->sm_periodic_state = AD_NO_PERIODIC;
>  	}
>  	/* check if state machine should change state */
> @@ -1955,16 +1959,16 @@ static void ad_initialize_agg(struct aggregator *aggregator)
>  /**
>   * ad_initialize_port - initialize a given port's parameters
>   * @port: the port we're looking at
> - * @lacp_fast: boolean. whether fast periodic should be used
> + * @bond_params: bond parameters we will use
>   */
> -static void ad_initialize_port(struct port *port, int lacp_fast)
> +static void ad_initialize_port(struct port *port, struct bond_params *bond_params)
>  {
>  	static const struct port_params tmpl = {
>  		.system_priority = 0xffff,
>  		.key             = 1,
>  		.port_number     = 1,
>  		.port_priority   = 0xff,
> -		.port_state      = 1,
> +		.port_state      = 0,

1 == LACP_STATE_ACTIVITY :)
Just noting that this lets LACP_STATE_ACTIVITY to be set based on lacp_active.

>  	};
>  	static const struct lacpdu lacpdu = {
>  		.subtype		= 0x01,
> @@ -1982,12 +1986,14 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
>  		port->actor_port_priority = 0xff;
>  		port->actor_port_aggregator_identifier = 0;
>  		port->ntt = false;
> -		port->actor_admin_port_state = LACP_STATE_AGGREGATION |
> -					       LACP_STATE_LACP_ACTIVITY;
> -		port->actor_oper_port_state  = LACP_STATE_AGGREGATION |
> -					       LACP_STATE_LACP_ACTIVITY;
> +		port->actor_admin_port_state = LACP_STATE_AGGREGATION;
> +		port->actor_oper_port_state  = LACP_STATE_AGGREGATION;
> +		if (bond_params->lacp_active) {
> +			port->actor_admin_port_state |= LACP_STATE_LACP_ACTIVITY;
> +			port->actor_oper_port_state  |= LACP_STATE_LACP_ACTIVITY;
> +		}
>  
> -		if (lacp_fast)
> +		if (bond_params->lacp_fast)
>  			port->actor_oper_port_state |= LACP_STATE_LACP_TIMEOUT;
>  
>  		memcpy(&port->partner_admin, &tmpl, sizeof(tmpl));
> @@ -2201,7 +2207,7 @@ void bond_3ad_bind_slave(struct slave *slave)
>  		/* port initialization */
>  		port = &(SLAVE_AD_INFO(slave)->port);
>  
> -		ad_initialize_port(port, bond->params.lacp_fast);
> +		ad_initialize_port(port, &bond->params);
>  
>  		port->slave = slave;
>  		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
> @@ -2513,7 +2519,7 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>  		}
>  
>  		ad_rx_machine(NULL, port);
> -		ad_periodic_machine(port, &bond->params);
> +		ad_periodic_machine(port);
>  		ad_port_selection_logic(port, &update_slave_arr);
>  		ad_mux_machine(port, &update_slave_arr);
>  		ad_tx_machine(port);
> @@ -2883,6 +2889,36 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
>  	spin_unlock_bh(&bond->mode_lock);
>  }
>  
> +/**
> + * bond_3ad_update_lacp_active - change the lacp active
> + * @bond: bonding struct
> + *
> + * When modify lacp_active parameter via sysfs,
> + * update actor_oper_port_state of each port.

It could also be netlink, right? I'd just say something like:
Update actor_oper_port_state when lacp_active is modified.

> + *
> + * Hold bond->mode_lock,
> + * so we can modify port->actor_oper_port_state,
> + * no matter bond is up or down.

nit: this last part about bond up/down is unnecessary

> + */
> +void bond_3ad_update_lacp_active(struct bonding *bond)
> +{
> +	struct port *port = NULL;
> +	struct list_head *iter;
> +	struct slave *slave;
> +	int lacp_active;
> +
> +	lacp_active = bond->params.lacp_active;
> +	spin_lock_bh(&bond->mode_lock);
> +	bond_for_each_slave(bond, slave, iter) {
> +		port = &(SLAVE_AD_INFO(slave)->port);
> +		if (lacp_active)
> +			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
> +		else
> +			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
> +	}
> +	spin_unlock_bh(&bond->mode_lock);
> +}
> +
>  size_t bond_3ad_stats_size(void)
>  {
>  	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 1d639a3be6ba..3b6f815c55ff 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1660,6 +1660,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
>  	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
>  		   newval->string, newval->value);
>  	bond->params.lacp_active = newval->value;
> +	bond_3ad_update_lacp_active(bond);

To me it looks like this fix needs to be in a separate patch.

>  
>  	return 0;
>  }
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index 2053cd8e788a..dba369a2cf27 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -307,6 +307,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
>  			 struct slave *slave);
>  int bond_3ad_set_carrier(struct bonding *bond);
>  void bond_3ad_update_lacp_rate(struct bonding *bond);
> +void bond_3ad_update_lacp_active(struct bonding *bond);
>  void bond_3ad_update_ad_actor_settings(struct bonding *bond);
>  int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
>  size_t bond_3ad_stats_size(void);


