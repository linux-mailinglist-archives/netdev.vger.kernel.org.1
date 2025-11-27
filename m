Return-Path: <netdev+bounces-242231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F076FC8DCD5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7080B34312B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABB329C7D;
	Thu, 27 Nov 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI3O9UfB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz//7ulA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53079DA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239821; cv=none; b=NbOV2Eztwtmf/SZXcVVH0SpdDNRhdDnfGc0s5LPb1CJaAysSKTfL8XQJsfzLXrR10eQ7K3RmNOyuzxcSsGup+z2wqK/RcDq6wcnbZEDctlCSRbfXiBWMEjUCf4HE7vkdst9y3BaIInsovM1HN12Tb/GOpTe6nlhHpV+VNfoB3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239821; c=relaxed/simple;
	bh=zsMZrscbJSC5ej1CL+cuK7QTVsa/DgbjjF3adgXy8HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTLXNXdDcKxMEHowCCdh4XswttbJgrMuHzBnC4lIHLCaeuNVurcWmIn53bCXEbloKkZuYT1gYD3VMVGHE0meh6s3e3GSJPGWV5praNAWhq9voiBIeqbOFScbVgsr4axUzgLFQQDefpuxWlQzVUjmODDalbt3z2ERoaoFhzNexKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI3O9UfB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mz//7ulA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764239814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r+MlgGs88qXgfdL+n9ReF5tJArJSHzqjXvUzDrxfllg=;
	b=UI3O9UfBgwW0MDrX50a65AvgTBzPxLECHr+ByQXNU7DRXlALgtjHrRzeCLWi3rrooMEDKN
	HKX4P7qmw7somdMJ5LGXqRQNzV4KppVK8lOShQ9afz509gOH6Q1vN7WnwgU9A/oZAHGik3
	5UwtBTIWvTBBXPCsOg6s356ABJkczrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-M5JSBIzKOROoAt8OtCi2xA-1; Thu, 27 Nov 2025 05:36:53 -0500
X-MC-Unique: M5JSBIzKOROoAt8OtCi2xA-1
X-Mimecast-MFC-AGG-ID: M5JSBIzKOROoAt8OtCi2xA_1764239806
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b3086a055so571612f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764239806; x=1764844606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+MlgGs88qXgfdL+n9ReF5tJArJSHzqjXvUzDrxfllg=;
        b=Mz//7ulA4teG/p8Z+P5fSvuwAvF9xMQCWoMkzLinZwG9amMTgob1rNs4tfNVM5SKuT
         mxq2JPYMlEwwGVJiLT+VW2XyUelBbmiVf/dahkLXKK3QlBBV2BlD0NuEq4UChqWVPZa0
         2S84AKmuJncGBUBhJSJE6sMjV1oyfY6+hTnYlrjOpTXGTu9tknNXlNtu4QzZaAyiU+36
         /8KA2xRGiDHQb0uMTY5mJdLdNQHQSGLzjcOSMPMVyqpFl6Xzi/637E15vv/z5s35CLBi
         YkYpAV3v1DMLxq0WZuDCl69IKYEsU0h1FjFQ/ntiUEWQ9407EqXIOkclzC3uMz0+bEa9
         MUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239806; x=1764844606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+MlgGs88qXgfdL+n9ReF5tJArJSHzqjXvUzDrxfllg=;
        b=N05aMjKX7CxR6tL2Wh42UXnWChaQkT7U5Ab5DrND7vWYoxTGGORNCuLYOdiEY6+SfB
         G4KcYLjEJwfkkDX/AuN/rAQRVSr/KKZ6r1wxcw/HXKbT599NEGUXWEEQJY4+FTnpEFaF
         pcoiLtTBzoWpW1z8WUeB/IbIIfg3i2ucPEnHDDVYmQBAbUgM4S7zoqkNMVKj09VX50wT
         UTZ8E/YP60PBs9KCilyIrhTMH8g0Na/LGPAydy+0i9D9FJ67m8O3KJOt3QTv2oEdsa64
         FV0wJYzCMOazLERDA91amwwTpFv/V+Ambj/ne1roYwqpbhPbFXD5OAVsosdW/h9atcp9
         wtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEtv46V4Spy8207R2/TgleyH8DK8cgxlRxwT0krQlQnHpa30i24R6y1De8IUmBMXk+QmwqYuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdU352bhjLAXq0PhtgzeySRZexWBbcB1/JxTl8+4z/dZV/LQr
	82AomJc+Oi7p014QWiNYLvNSxozCBMs7Ily7uWhA3yp8vLUXbbT0hVfcBsHzGPzw+DkCe/MiLS8
	5nu3tl7PU7HDVU63VDSqSn9nQWPMfPkM8tFScfSO+eBEnz+7IqScQZNeXVQ==
X-Gm-Gg: ASbGnctrFkspsh5XMki9oLcKfPO7EUkNAW8WcFZH5ooKOrm4gz5kk/kZyxn8zGtedVA
	Q6u8O+I2SIdeJQ1yT13V/rJSzPombuMapEBqAotAJ51QxiKs36+ZTEuhRbZ993XmdT634yO06bG
	3IaaG5QtUwk6lsY7W6i+kqjXqxUhCZKQWARLEDFxZlTY6gE1yTajE4NDzGWi6CCeoRa+OrsAcMW
	Y1bCN4SAuzlbdFUKkpSzQi8h6HsE8GvecW42gpOYqtbl7cBApNsDH5+1f4eaNTO914oK7iXwCpN
	yZ5HckFhGBzAnseEc0QuqxkmicGkilSXobPTgHoen24lxeb2ScdiHfYgCFXc+xKU2ySG0hc5IP0
	CP7cvu/Nvsw2qZw==
X-Received: by 2002:adf:ed0c:0:b0:42b:3d93:9a27 with SMTP id ffacd0b85a97d-42e0f3492b2mr8227450f8f.36.1764239806073;
        Thu, 27 Nov 2025 02:36:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJYo2GyThIlij+vvWAIstPjNssVKhAIzBpEAXrV77Fq+IsFEmYZe9P2TLzAeDoin2OZX4vhA==
X-Received: by 2002:adf:ed0c:0:b0:42b:3d93:9a27 with SMTP id ffacd0b85a97d-42e0f3492b2mr8227411f8f.36.1764239805581;
        Thu, 27 Nov 2025 02:36:45 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm2940137f8f.11.2025.11.27.02.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:36:44 -0800 (PST)
Message-ID: <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com>
Date: Thu, 27 Nov 2025 11:36:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251124043310.34073-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 5:33 AM, Hangbin Liu wrote:
> The current ad_churn_machine implementation only transitions the
> actor/partner churn state to churned or none after the churn timer expires.
> However, IEEE 802.1AX-2014 specifies that a port should enter the none
> state immediately once the actor’s port state enters synchronization.
> 
> Another issue is that if the churn timer expires while the churn machine is
> not in the monitor state (e.g. already in churn), the state may remain
> stuck indefinitely with no further transitions. This becomes visible in
> multi-aggregator scenarios. For example:
> 
> Ports 1 and 2 are in aggregator 1 (active)
> Ports 3 and 4 are in aggregator 2 (backup)
> 
> Ports 1 and 2 should be in none
> Ports 3 and 4 should be in churned
> 
> If a failover occurs due to port 2 link down/up, aggregator 2 becomes active.
> Under the current implementation, the resulting states may look like:
> 
> agg 1 (backup): port 1 -> none, port 2 -> churned
> agg 2 (active): ports 3,4 keep in churned.
> 
> The root cause is that ad_churn_machine() only clears the
> AD_PORT_CHURNED flag and starts a timer. When a churned port becomes active,
> its RX state becomes AD_RX_CURRENT, preventing the churn flag from being set
> again, leaving no way to retrigger the timer. Fixing this solely in
> ad_rx_machine() is insufficient.
> 
> This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
> (Figures 6-23 and 6-24), ensuring correct churn detection, state transitions,
> and timer behavior. With new implementation, there is no need to set
> AD_PORT_CHURNED in ad_rx_machine().

I think this change is too invasive at this point of the cycle. I think
it should be moved to the next one or even to net-next.

> Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standard 43.4.17).")
> Reported-by: Liang Li <liali@redhat.com>
> Tested-by: Liang Li <liali@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_3ad.c | 104 ++++++++++++++++++++++++++-------
>  1 file changed, 84 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index d6bd3615d129..98b8d5040148 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1240,7 +1240,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
>  	/* first, check if port was reinitialized */
>  	if (port->sm_vars & AD_PORT_BEGIN) {
>  		port->sm_rx_state = AD_RX_INITIALIZE;
> -		port->sm_vars |= AD_PORT_CHURNED;
>  	/* check if port is not enabled */
>  	} else if (!(port->sm_vars & AD_PORT_BEGIN) && !port->is_enabled)
>  		port->sm_rx_state = AD_RX_PORT_DISABLED;
> @@ -1248,8 +1247,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
>  	else if (lacpdu && ((port->sm_rx_state == AD_RX_EXPIRED) ||
>  		 (port->sm_rx_state == AD_RX_DEFAULTED) ||
>  		 (port->sm_rx_state == AD_RX_CURRENT))) {
> -		if (port->sm_rx_state != AD_RX_CURRENT)
> -			port->sm_vars |= AD_PORT_CHURNED;
>  		port->sm_rx_timer_counter = 0;
>  		port->sm_rx_state = AD_RX_CURRENT;
>  	} else {
> @@ -1333,7 +1330,6 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
>  			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
>  			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
>  			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
> -			port->sm_vars |= AD_PORT_CHURNED;
>  			break;
>  		case AD_RX_DEFAULTED:
>  			__update_default_selected(port);
> @@ -1365,39 +1361,107 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
>   * ad_churn_machine - handle port churn's state machine
>   * @port: the port we're looking at
>   *
> + * IEEE 802.1AX-2014 Figure 6-23 - Actor Churn Detection machine state diagram
> + *
> + *                                                     BEGIN || (! port_enabled)
> + *                                                               |
> + *                                      (3)                (1)   v
> + *   +----------------------+     ActorPort.Sync     +-------------------------+
> + *   |    NO_ACTOR_CHURN    | <--------------------- |   ACTOR_CHURN_MONITOR   |
> + *   |======================|                        |=========================|
> + *   | actor_churn = FALSE; |    ! ActorPort.Sync    | actor_churn = FALSE;    |
> + *   |                      | ---------------------> | Start actor_churn_timer |
> + *   +----------------------+           (4)          +-------------------------+
> + *             ^                                                 |
> + *             |                                                 |
> + *             |                                      actor_churn_timer expired
> + *             |                                                 |
> + *       ActorPort.Sync                                          |  (2)
> + *             |              +--------------------+             |
> + *        (3)  |              |   ACTOR_CHURN      |             |
> + *             |              |====================|             |
> + *             +------------- | actor_churn = True | <-----------+
> + *                            |                    |
> + *                            +--------------------+
> + *
> + * Similar for the Figure 6-24 - Partner Churn Detection machine state diagram
>   */
>  static void ad_churn_machine(struct port *port)
>  {
> -	if (port->sm_vars & AD_PORT_CHURNED) {
> +	bool partner_synced = port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION;
> +	bool actor_synced = port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION;
> +	bool partner_churned = port->sm_vars & AD_PORT_PARTNER_CHURN;
> +	bool actor_churned = port->sm_vars & AD_PORT_ACTOR_CHURN;
> +
> +	/* ---- 1. begin or port not enabled ---- */
> +	if ((port->sm_vars & AD_PORT_BEGIN) || !port->is_enabled) {
>  		port->sm_vars &= ~AD_PORT_CHURNED;
> +
>  		port->sm_churn_actor_state = AD_CHURN_MONITOR;
>  		port->sm_churn_partner_state = AD_CHURN_MONITOR;
> +
>  		port->sm_churn_actor_timer_counter =
>  			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
>  		port->sm_churn_partner_timer_counter =
> -			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> +			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
> +

Please avoid white-space changes only, or if you are going to target
net-next, move them to a pre-req patch.

>  		return;
>  	}
> -	if (port->sm_churn_actor_timer_counter &&
> -	    !(--port->sm_churn_actor_timer_counter) &&
> -	    port->sm_churn_actor_state == AD_CHURN_MONITOR) {
> -		if (port->actor_oper_port_state & LACP_STATE_SYNCHRONIZATION) {
> +
> +	if (port->sm_churn_actor_timer_counter)
> +		port->sm_churn_actor_timer_counter--;
> +
> +	if (port->sm_churn_partner_timer_counter)
> +		port->sm_churn_partner_timer_counter--;
> +
> +	/* ---- 2. timer expired, enter CHURN ---- */
> +	if (port->sm_churn_actor_state == AD_CHURN_MONITOR &&
> +	    !actor_churned && !port->sm_churn_actor_timer_counter) {
> +		port->sm_vars |= AD_PORT_ACTOR_CHURN;
> +		port->sm_churn_actor_state = AD_CHURN;
> +		port->churn_actor_count++;
> +		actor_churned = true;
> +	}
> +
> +	if (port->sm_churn_partner_state == AD_CHURN_MONITOR &&
> +	    !partner_churned && !port->sm_churn_partner_timer_counter) {
> +		port->sm_vars |= AD_PORT_PARTNER_CHURN;
> +		port->sm_churn_partner_state = AD_CHURN;
> +		port->churn_partner_count++;
> +		partner_churned = true;
> +	}
> +
> +	/* ---- 3. CHURN_MONITOR/CHURN + sync -> NO_CHURN ---- */
> +	if ((port->sm_churn_actor_state == AD_CHURN_MONITOR && !actor_churned) ||
> +	    (port->sm_churn_actor_state == AD_CHURN && actor_churned)) {

Is this                                             ^^^^^^^^^^^^^^^^

test needed ? I *think* the state machine `actor_churned == true` when
`sm_churn_actor_state == AD_CHURN`

> +		if (actor_synced) {
> +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
>  			port->sm_churn_actor_state = AD_NO_CHURN;
> -		} else {
> -			port->churn_actor_count++;
> -			port->sm_churn_actor_state = AD_CHURN;
> +			actor_churned = false;
>  		}

I think this part is not described by the state diagram above?!?

>  	}
> -	if (port->sm_churn_partner_timer_counter &&
> -	    !(--port->sm_churn_partner_timer_counter) &&
> -	    port->sm_churn_partner_state == AD_CHURN_MONITOR) {
> -		if (port->partner_oper.port_state & LACP_STATE_SYNCHRONIZATION) {
> +
> +	if ((port->sm_churn_partner_state == AD_CHURN_MONITOR && !partner_churned) ||
> +	    (port->sm_churn_partner_state == AD_CHURN && partner_churned)) {
> +		if (partner_synced) {
> +			port->sm_vars &= ~AD_PORT_PARTNER_CHURN;
>  			port->sm_churn_partner_state = AD_NO_CHURN;
> -		} else {
> -			port->churn_partner_count++;
> -			port->sm_churn_partner_state = AD_CHURN;
> +			partner_churned = false;
>  		}

Possibly move this `if` block in a separate helper and reuse for both
partner and actor.

>  	}
> +
> +	/* ---- 4. NO_CHURN + !sync -> MONITOR ---- */
> +	if (port->sm_churn_actor_state == AD_NO_CHURN && !actor_churned && !actor_synced) {
> +		port->sm_churn_actor_state = AD_CHURN_MONITOR;
> +		port->sm_churn_actor_timer_counter =
> +			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);

Should this clear sm_vars & AD_PORT_ACTOR_CHURN, too?

> +	}
> +
> +	if (port->sm_churn_partner_state == AD_NO_CHURN && !partner_churned && !partner_synced) {
> +		port->sm_churn_partner_state = AD_CHURN_MONITOR;
> +		port->sm_churn_partner_timer_counter =
> +			__ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);

Same question here.

/P


