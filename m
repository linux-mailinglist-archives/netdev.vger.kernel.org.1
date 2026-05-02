Return-Path: <netdev+bounces-283453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE1VLVs19mk5TAIAu9opvQ
	(envelope-from <netdev+bounces-283453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D74B311A
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6645630053B5
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE73859D3;
	Sat,  2 May 2026 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc4Z3YjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9B2DAFAF;
	Sat,  2 May 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777743192; cv=none; b=pg79EqgmLzWbXZXonRR4v/WroAHq4akrUKxHvFdA+bNIqahrxIT34QqvQxOlK3R6MrgEIl82gnIxN9UO+9ChHsGGdY3hrgY0x6QBXq4F/gVkOfhHe4E/BKzX5b4ZqyniCB8VdptVAFJCY6To2bBmobFAHLbnvEFMNyvT7f/TrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777743192; c=relaxed/simple;
	bh=UHjulvWLpJvBJU8CiE9lHSQ7XsvcJ0jHyHDPECWHrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7twAwEBlka9pjc2aJsrpWdkcyiIiWRWwYNidnqKVIJDO2mrZbKLqXrJ2YBU613GvWChrgslyRPkwqH94aSUS/PTSBdyDbCSsovwptr5oNOy2DMcD/53RRoz8EWVCKLFVYCxEb8Wd2GSfsF2duFCRf4HVHP9vs290LETJlxAbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc4Z3YjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC311C19425;
	Sat,  2 May 2026 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777743191;
	bh=UHjulvWLpJvBJU8CiE9lHSQ7XsvcJ0jHyHDPECWHrsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rc4Z3YjMuUC4hec2lJO5HlqXf0fS4qNkli1cWXaUyaTRwGhdLX9E0JSCeMHzcvLid
	 8dnI/RnnzFgTU8G2BJOJElpSpw7gfiwPVzAFpbA9aIwX7owP3YS9R0bImsp9/y17w8
	 IFyi0ddJR9OE9tkI9EJ45t8Kfd/jufOgDGY1UnUuhm/LfeQDgSYGdNtKQZ60Scqd/U
	 ATl347fRQCkgdR+HeZr+FLlUBhVXiS7GmtZEXOTB3JrK4QwgqI1c1xMFL/Ijc8BK6x
	 Y8YkEedzoN5/YErpQ52k2o62A6Z20T0G5ercvnP7bnYYXqMr8jl6QF7aKb5lzQCzx7
	 IDteOKdp7LE3g==
From: Jakub Kicinski <kuba@kernel.org>
To: grzegorz.nitka@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ivecera@redhat.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	edumazet@google.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	donald.hunter@gmail.com,
	linux-kernel@vger.kernel.org,
	arkadiusz.kubalewski@intel.com,
	andrew+netdev@lunn.ch,
	intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	Prathosh.Satish@microchip.com,
	anthony.l.nguyen@intel.com,
	pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH v7 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state change
Date: Sat,  2 May 2026 10:33:09 -0700
Message-ID: <20260502173309.3849677-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430094238.987976-5-grzegorz.nitka@intel.com>
References: <20260430094238.987976-5-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C3D74B311A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,linux.dev,resnulli.us,google.com,intel.com,gmail.com,lunn.ch,lists.osuosl.org,microchip.com,davemloft.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-283453-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: zl3073x: allow SyncE_Ref pin state change

This patch advertises DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE on the
output-direction branch of zl3073x_pin_props_get() with the stated intent
of allowing dynamic enable/disable of the SyncE_Ref pin.

> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978..acd7061a741a 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
>
>  		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
>
> +	       /*
> +		* The SyncE_Ref pin supports enabling/disabling dynamically.
> +		* Some platforms may choose to expose this through firmware
> +		* configuration later. For now, advertise this capability
> +		* universally since the hardware allows state toggling.
> +		*/
> +		props->dpll_props.capabilities |=
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

Is this capability actually supported by the output pin ops?

Looking at drivers/dpll/zl3073x/dpll.c, the output pin ops vector does
not install a .state_on_dpll_set callback:

    static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
            .direction_get       = zl3073x_dpll_pin_direction_get,
            .esync_get           = zl3073x_dpll_output_pin_esync_get,
            .esync_set           = zl3073x_dpll_output_pin_esync_set,
            .frequency_get       = zl3073x_dpll_output_pin_frequency_get,
            .frequency_set       = zl3073x_dpll_output_pin_frequency_set,
            .phase_adjust_get    = zl3073x_dpll_output_pin_phase_adjust_get,
            .phase_adjust_set    = zl3073x_dpll_output_pin_phase_adjust_set,
            .state_on_dpll_get   = zl3073x_dpll_output_pin_state_on_dpll_get,
    };

and the corresponding getter hardcodes the state to CONNECTED with no
hardware read:

    zl3073x_dpll_output_pin_state_on_dpll_get(...)
    {
            /* If the output pin is registered then it is always connected */
            *state = DPLL_PIN_STATE_CONNECTED;
            return 0;
    }

On the netlink side, dpll_pin_state_set() first checks the capability
bit and then requires the setter to exist:

    if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE & pin->prop.capabilities)) {
            NL_SET_ERR_MSG(extack, "state changing is not allowed");
            return -EOPNOTSUPP;
    }
    ...
    if (!ops->state_on_dpll_set)
            return -EOPNOTSUPP;

With this patch, the capability check now passes for every output pin,
but the operation then fails with -EOPNOTSUPP because no setter is
provided, and the reported state will remain CONNECTED regardless of
what userspace requested.

Should this series also add a .state_on_dpll_set callback (and a
matching hardware path, for example via zl3073x_out_state_set or the
output-enable mailbox) before advertising the capability, so the commit
subject "allow SyncE_Ref pin state change" can actually be honored?

Separately, should the scope of this change match the commit message?

The subject and the first sentence of the new comment describe a change
scoped to the SyncE_Ref pin:

    * The SyncE_Ref pin supports enabling/disabling dynamically.

but the assignment lives in the generic else-branch of
zl3073x_pin_props_get() that runs for every output pin (SMA outputs,
1PPS outputs, internal-oscillator outputs, MUX outputs, etc.), and it
executes before the fwnode "connection-type" parsing below can classify
the pin as ext/gnss/int/synce/mux. The last sentence of the same
comment acknowledges this:

    * universally since the hardware allows state toggling.

Would it be clearer to either gate the flag on the SyncE_Ref pin
specifically (e.g., via firmware-node property, as the comment hints
at), or to update the subject and leading comment sentence to reflect
that the capability is being advertised for all output pins?

> +	       /*
> +		* The SyncE_Ref pin supports enabling/disabling dynamically.
> +		* Some platforms may choose to expose this through firmware
> +		* configuration later. For now, advertise this capability
> +		* universally since the hardware allows state toggling.
> +		*/

This isn't a bug, but the indentation of the comment block is
inconsistent. The opening "/*" is prefixed with one tab followed by
seven spaces, while the " *" continuation lines and the closing " */"
are prefixed with two tabs, so the opening "/" does not align with the
continuation asterisks. Adjacent comment blocks in the same function
(for example "The output pin phase adjustment granularity...") use pure
tab alignment.

> +		props->dpll_props.capabilities |=
> +			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

This isn't a bug, but props was just obtained from kzalloc_obj() and
nothing in this else-branch writes to capabilities before this point.
The symmetric input branch immediately above uses plain "=":

    props->dpll_props.capabilities =
            DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
            DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;

Would "=" be more consistent here, since there are no pre-existing bits
to merge with?
-- 
pw-bot: cr

