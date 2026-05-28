Return-Path: <netdev+bounces-292839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C4zNmCpGGpolwgAu9opvQ
	(envelope-from <netdev+bounces-292839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:45:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054F5F976E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CD830D5C8C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61A9313539;
	Thu, 28 May 2026 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGTPcdRK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCED532AAD6
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000690; cv=none; b=r82x64yuDeWXkXfY6UyLce8OBgCFgIDRCQ8Hhc+GU1kFhMEHnRDHJoXTedpjGUGXqrKX8aCX/l0oLLqFRFwWivYirh/brPwVAdsLSVma4vuhQht6V/t6CUQii6aWl6n1a0Dra5FKusAktgWHfUCcnb+UlsEg1OyF+JEI9l7wCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000690; c=relaxed/simple;
	bh=yBpdHgpdNh02jZW09C83mqq7E+sngggtWGPyLaj1o3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbZZIdI+Prn3D0Gf2A9gFmz7QXBhRRJ/WaM2glmooNs5FOdHzCwSWQC53Koi2yqrCAQdTTpsvktiuqgtJrNc7VwP4V0PvsXZYCMtobWhLpMno1NogZcV8jrXTOoBNaEh9EqiZD9gbTLoRPESLmg60B9p2jr7SK0mrGFNwVgHSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGTPcdRK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7161F00A3A;
	Thu, 28 May 2026 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780000689;
	bh=1ZaVeXBMGyCxq8n45RUkSY8vNTiPwJbvNoT5WSsO0Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RGTPcdRKs5zMZZ50LTS5044CwUK25ZJduzanMjo5NfsBLO9pBqtrWx+APNwcLYecE
	 cftHxvdAzJ5yV4X5UuGPiY0w+/LiSD54CNTyUViP2mB+aD1N/nE3BNFsLlup6G6VnR
	 WpH0OiqfE9WGP5Vmx+4xb/Iz0+7My6XPC55rTF0EhPZUcWPQQYVUof/3uXlxoBGEV+
	 B/+c+auV/wIn+TrINMPbJlIPfJljJLrLT8Gyk/hmbq2m55X5pYNM55J/GWy/yjoZ5K
	 V7atnrbfvW79kt/zMtINapDrfhLZcY+lW+dZu/418Fw5SXkj35+bSugT/JrZCDcL+X
	 y7jUk34RSaEvQ==
From: Simon Horman <horms@kernel.org>
To: louis.scalbert@6wind.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com
Subject: Re: [PATCH net v7 4/6] bonding: 3ad: fix carrier when no usable slaves
Date: Thu, 28 May 2026 21:37:15 +0100
Message-ID: <20260528203715.2739597-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526084048.1696544-5-louis.scalbert@6wind.com>
References: <20260526084048.1696544-5-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,jvosburgh.net,google.com,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-292839-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6054F5F976E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
bonding: 3ad: fix carrier when no usable slaves

Apply the "lacp_strict" configuration from the previous commit.

"lacp_strict" mode "on" asserts that the bonding master carrier is up
only when at least 'min_links' slaves are in the Collecting_Distributing
state.

> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index f0aa7d2f21717..1247a1e048df9 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c

[ ... ]

> @@ -2151,6 +2167,7 @@ static void ad_disable_collecting_distributing(struct port *port,
>  			  port->actor_port_number,
>  			  aggregator->aggregator_identifier);
>  		__disable_port(port);
> +		bond_3ad_set_carrier(port->slave->bond);

[Severity: High]
Does this approach miss carrier state updates during mux state machine
transitions?

When transitioning to AD_MUX_DETACHED, ad_disable_collecting_distributing()
is called before the LACP_STATE_COLLECTING and LACP_STATE_DISTRIBUTING flags
are cleared:

ad_mux_machine() {
    ...
		case AD_MUX_DETACHED:
			port->actor_oper_port_state &= ~LACP_STATE_SYNCHRONIZATION;
			ad_disable_collecting_distributing(port, update_slave_arr);
			port->actor_oper_port_state &= ~LACP_STATE_COLLECTING;
			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
    ...
}

Since bond_3ad_set_carrier() is called inside ad_disable_collecting_distributing(),
will __agg_usable_ports() still incorrectly count the detaching port as usable
and keep the carrier up?

The flags are cleared right after the function returns, but bond_3ad_set_carrier()
isn't called again.

Similarly, when transitioning to AD_MUX_COLLECTING, the port drops the
LACP_STATE_DISTRIBUTING flag (making it unusable in lacp_strict mode):

ad_mux_machine() {
    ...
		case AD_MUX_COLLECTING:
			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
			port->actor_oper_port_state &= ~LACP_STATE_DISTRIBUTING;
			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
			ad_enable_collecting(port);
			ad_disable_distributing(port, update_slave_arr);
    ...
}

Since ad_disable_distributing() does not trigger a carrier state update like
ad_disable_collecting_distributing() does, will the master carrier incorrectly
remain up even if the number of usable links falls below min_links?

>  		/* Slave array needs an update */
>  		*update_slave_arr = true;
>  	}

