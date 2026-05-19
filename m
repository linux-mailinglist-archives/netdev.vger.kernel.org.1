Return-Path: <netdev+bounces-289210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDInK1GpC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 556AA5755DF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B43693019D38
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4FDDCD;
	Tue, 19 May 2026 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNv68EPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970764;
	Tue, 19 May 2026 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149135; cv=none; b=h6H+4wrWxYaS8SHqR8S85h0txGS1CzWt7WSoTUDHmKEnWi6zOvN1CmC/YrXPyFUruCs7AaU00LBJ571PEuzyM6w/kh3cbsTiOJrJcvvY3Sx7Eml/a6WJ/WeiuRqjZZeMjeHZluZ8UJsjrv/wihUAZRgQx1FHMc1S3nEhBTk89Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149135; c=relaxed/simple;
	bh=B+tGK2sD/mSA1Huk0PGxyqQXzJj6RM5/LAw/YAm7V78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLW+qonRb8gaEGaC7II5AiKCInIAn3pjgK7/COfDV7pErZa0igAZZjkDWFx1dOgqZ6WxY0Iq76YjLV51OXPV8sx9pr92f2O/jz5EwJHThiK1q6vkE7dzU2Bpdj/HEewe/7R+DDkyLSQQP6EkSoSstI87RRp9hmTuhGdF2IRo3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNv68EPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A836C2BCB7;
	Tue, 19 May 2026 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149135;
	bh=B+tGK2sD/mSA1Huk0PGxyqQXzJj6RM5/LAw/YAm7V78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNv68EPpF0yDehb3dD5vCH5Qxt8mJ/ZN3/bweaGE2pgiBydIlyaMfI8L+jSOs98Nh
	 OLupnTbnIs5gwosZBBeDwqh1K/4wlk9aIg4jzgsTMdVDaK2NIMwjng6LmWy+TSL0O3
	 Kyo8/MX3DjI8tJpZBZleGGFwO8s0Tr+eB3k20SFQu6WnHH0+tGtQM2L/Wdw6afoQ9Z
	 yGbUDi17pO3LPdna8aWKF4Zh1chCmniTVDU6yH3cq0x5CpSTUlft2x7vLjcPnsx4go
	 znKY3ZMy+f3nISu4Wow8tkN+iN8ifantt/xwe16rTm11LnXbmJLwqEufufjQMNVN9R
	 W/dNWocg+sdbg==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	poros@redhat.com,
	Prathosh.Satish@microchip.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dpll: zl3073x: fix memory leak on pin registration failure
Date: Mon, 18 May 2026 17:05:27 -0700
Message-ID: <20260519000526.3259243-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515193956.351092-1-ivecera@redhat.com>
References: <20260515193956.351092-1-ivecera@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 556AA5755DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "Looks related enough to fix together"
---
dpll: zl3073x: fix memory leak on pin registration failure

This patch frees the freshly allocated pin when zl3073x_dpll_pin_register()
returns an error, since the pin has not yet been added to zldpll->pins and
would otherwise be missed by the unregister loop.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 6fd718696de0..a39dedac8b58 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1597,8 +1597,10 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>  		}
>  
>  		rc = zl3073x_dpll_pin_register(pin, index);
> -		if (rc)
> +		if (rc) {
> +			zl3073x_dpll_pin_free(pin);
>  			goto error;
> +		}

[Medium]
Can the new zl3073x_dpll_pin_free(pin) call trigger a spurious warning
when zl3073x_dpll_pin_register() fails at the dpll_pin_get() step?

Looking at zl3073x_dpll_pin_register():

	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
				     &props->dpll_props, &pin->tracker);
	if (IS_ERR(pin->dpll_pin)) {
		rc = PTR_ERR(pin->dpll_pin);
		goto err_pin_get;
	}
	...
err_register:
	dpll_pin_put(pin->dpll_pin, &pin->tracker);
	pin->dpll_pin = NULL;
err_pin_get:
	fwnode_handle_put(pin->fwnode);
	pin->fwnode = NULL;
	zl3073x_pin_props_put(props);

	return rc;

On the err_pin_get path, pin->dpll_pin is left holding the ERR_PTR value
returned by dpll_pin_get() (only err_register clears it).

Then zl3073x_dpll_pin_free() does:

	WARN(pin->dpll_pin, "DPLL pin is still registered\n");
	kfree(pin);

Since an ERR_PTR is non-NULL, would this WARN fire on every dpll_pin_get()
failure (for example ENOMEM), producing a misleading "DPLL pin is still
registered" backtrace and panicking kernels booted with panic_on_warn=1?

Would it be appropriate to either set pin->dpll_pin = NULL in the
err_pin_get path of zl3073x_dpll_pin_register(), or change the WARN
condition in zl3073x_dpll_pin_free() to use !IS_ERR_OR_NULL(pin->dpll_pin)?

 \
  		list_add(&pin->list, &zldpll->pins);
  	}
-- 
pw-bot: cr

