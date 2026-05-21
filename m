Return-Path: <netdev+bounces-290204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDaENMdrDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9613959E000
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B711301CD8E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B5357D05;
	Thu, 21 May 2026 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D20xBi3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10761349CC5;
	Thu, 21 May 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329985; cv=none; b=BWTou5m7zH3kVAmxHaYWrsOeKCY+DpieDhij6CChu2R3FWYDd1hOHbIjtyQZddVwDERr0ekNnK2Xyfg+4JW9v4WcSZaegWlo6Yk+OzX/qA1sCb5BRMa7YY6yO0ba8nVunOZW5X9CPKdUbQg9hmhqojVuWfCq2Aw0ljC2csXytIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329985; c=relaxed/simple;
	bh=KTTc4pVyJaw2BLAJ+Cj0DYkFEgxr3kWHQDqX67x9NQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoGDKSeNz1Az0DdE0u7cP+sBkCPyHo0Yr8taioZx7E4+YJuxol/9ILwHnpKMyvXQWAq2rg+DTw1iTEVtjwEqmfYeFsV3mW4qJZL+3BM67JU4nU6tC759oh17nr06gGC9YOnL1HB7l1pnr51eDipsS0Jks/eYDlPLUeQilr3mZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D20xBi3t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022AD1F00A3B;
	Thu, 21 May 2026 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329972;
	bh=4qYYkqM+e411SAnzdNvs5i/VNUW7PjsPk4PqI00t0Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D20xBi3t9qkxahuOhtEJLEYQilXMxX1c6sJ9qR3VRMqRLNzgPBDOt/b4qCNgT2tWp
	 DBciZCM6J0/GFhWSmBuT2UgrSq/UIko4SLo33SrU3yvw2gDdkHE2I/pwaLdKKz9WiV
	 0BwLX+pG9FtiM56oi0FdZuJUllGf12LNYL39dRf2uJXTo+befsfBQQ7Ro3eE+ZQVwG
	 te8OS2Nv0vuCRGt5LHFTbI9v9OovNlL/IrLa1ZGkIeBgat0ehJ79eDsjzoU6cYuuaF
	 KKch/bMtgUpYjDpkr4PQCO+jiASCYS8IeQKiGNuFh/+MO59PRyIZwlQjypIlxnJB4g
	 x/li3kxnMcB/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: poros@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ivecera@redhat.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	milena.olech@intel.com,
	davem@davemloft.net,
	michal.michalik@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] dpll: fix NULL deref in dpll_device_ops() during teardown race
Date: Wed, 20 May 2026 19:19:30 -0700
Message-ID: <20260521021930.687910-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516191317.1005612-2-poros@redhat.com>
References: <20260516191317.1005612-2-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290204-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9613959E000
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: fix NULL deref in dpll_device_ops() during teardown race

This commit modifies dpll_device_ops() and dpll_priv() to return NULL during
a teardown race when the registration list is empty. It also adds a check in
dpll_cmd_pin_get_one() to drop the notification if the first referenced dpll
is unregistered.

> In-tree doit/dumpit callers of dpll_priv() / dpll_device_ops() obtain
> their dpll via dpll_pre_doit() -> dpll_device_get_by_id(), which only
> returns DPLL_REGISTERED devices; dpll_device_unregister() clears that
> mark only after observing list_empty(&dpll->registration_list), so
> those callers cannot see the new NULL return. The only path that can
> is dpll_cmd_pin_get_one() reached from dpll_pin_event_send(), gated
> here.

Is this description accurate for pin operations?

Looking at doit and dumpit paths for pins, they appear to use
dpll_pin_pre_doit() which relies on dpll_pin_available(). That function
allows the operation if at least one dpll referencing the pin is registered.

If a pin references multiple dpll devices, and one is registered while
another is half-dead (being unregistered), couldn't a user trigger a panic by
executing a pin dump or configuration command during a driver unload?

> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index ea63602637866..b73d718e8a56d 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -709,6 +709,12 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>  	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>  	ASSERT_NOT_NULL(ref);
>  
> +	/* The first dpll the pin references may be torn down while still
> +	 * pinned by foreign-driver refs; drop the notification cleanly.
> +	 */
> +	if (!dpll_device_ops(ref->dpll))
> +		return -ENODEV;
> +

Will returning -ENODEV here break the netlink pin dump globally?

Since dpll_cmd_pin_get_one() is called inside the dumpit loop of
dpll_nl_pin_get_dumpit(), returning an error aborts the entire dump process.
A single pin in this transient state seems to break the pin dump operation
for all pins.

Also, for notifications sent via dpll_pin_event_send(), this return value
silently cancels and frees the netlink message. If the pin is shared with
other active dplls (which might be later in the xarray), won't their valid
state change notifications be permanently lost? Should the code skip
unregistered dplls instead of unconditionally aborting the operation?

Furthermore, does this check fully prevent the NULL pointer dereference?

This only validates the first dpll reference returned by
dpll_xa_ref_dpll_first(). If the first dpll is registered but a subsequent
dpll is half-dead (its registration list is empty), this check passes.

Execution would then proceed to functions like dpll_msg_add_pin_dplls() or
netlink set operations like dpll_pin_phase_adj_set() which iterate over
all dpll references in pin->dpll_refs. For the half-dead dpll, dpll_priv(dpll)
now evaluates to NULL, which is passed to driver callbacks
like ops->state_on_dpll_get that might unconditionally dereference it
(for example, ice_dpll_pin_state_get() uses struct ice_pf *pf = d->pf),
causing a kernel panic.
-- 
pw-bot: cr

