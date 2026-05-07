Return-Path: <netdev+bounces-285285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wInfJhp8/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80474E7B79
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853C03013A6B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25896391E4B;
	Thu,  7 May 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df6/mn91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B232C0F81
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154408; cv=none; b=JlVuycSH/mpYcc+HOvujzWuYvl7Yz+0TIgsCLsy1p6gfF1aaavMe12DTtZ1BP5sbbyRgnMcDMIT4zxATsaItGf454zY2ExL+JN6g3Z7/HnDq8OC516l5cYHFgtVGa8SZZu84XeUV6+919XVapnRTeepwZ+X7mqFzDF0tQiPv+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154408; c=relaxed/simple;
	bh=sfcWi70OrJmTlIsQy/5eBouz7VizDbkkSc+bXyA42Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLQTgZz2kgTlcB4SJqxfSVhr4JM0jJ6fxfp6AZjRln2H41cbEWOTMLcQk7vthaoipezMTcx0JlGOaApBKAErdMcuQYo5vqYDfFxzDfAdM9kEXyRBhSdfKbOh5uwjJzWgeq+4gWPYRH+C96WOzcgRufPWlhVxZTx748M7jPwOkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df6/mn91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED95C2BCB2;
	Thu,  7 May 2026 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778154407;
	bh=sfcWi70OrJmTlIsQy/5eBouz7VizDbkkSc+bXyA42Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Df6/mn91eCgAO0YqDxN2RNhD9vBAvJNq7Xpipg/plNYuNtnKrCwnnXfj34QEdlkEC
	 PTbxPDONSQmhdLpGeC/ra9hLrG/c57ocwP1d/XhWJfwZh1XGlwT8oF7pbyuBDo3s5a
	 VzW8CiQR3lKCRxa0LZWpWQm9SKyw6Bpt58UfnMoFnWHb5hR+pnvLK/wufABvKz22Je
	 ml29tCUCRWOFpK0gD79VX3Qv4I9nXpVvYD5JdQl/ci204eA9HMYp8afNk6HtXvqpvv
	 5zwx74dYgcz9eQtOQWPAN4gUKHp1Nsjstt9t+vqK4PeMqgFvkTpxTkSNrwahRv4GPG
	 y5iF3N84eJmIA==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 3/5] ice: add correct handling of SMA/u.FL states
Date: Thu,  7 May 2026 12:45:11 +0100
Message-ID: <20260507114507.910365-5-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504142451.4161845-4-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E80474E7B79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285285-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

I would also like to add that as a fix the patch description should
describe the user-visible effects of the bug, and how the fix addresses
them.

Thanks!
---
ice: add correct handling of SMA/u.FL states

This commit renames ICE_SMA2_UFL2_RX_DIS to ICE_SMA2_UFL2_RX_EN, stating that
the hardware bit is actually active high for enabling RX. It updates the uses
of the macro in ice_dpll.c to reflect the new name.

>     The ICE_SMA2_UFL2_RX_DIS bit name is wrong: the bit is active high
>     (setting it *enables* RX for u.FL2 / SMA2), not active low.  Rename
>     it to ICE_SMA2_UFL2_RX_EN and invert the use sites in ice_dpll.c so
>     that enabling the u.FL2 pin clears the bit (as it used to do) and
>     disabling sets it.

The commit message claims that setting the bit enables RX (active high), but
then states that enabling the pin clears the bit (active low). Could this
description be clarified to explain exactly whether the hardware uses active
high or active low logic?

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d6520..7e8bb63b262a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -672,7 +672,7 @@ ice_dpll_sw_pins_update(struct ice_pf *pf)
>  		p->active = false;
>  
>  	p = &d->ufl[ICE_DPLL_PIN_SW_2_IDX];
> -	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_DIS);
> +	p->active = (data & ICE_SMA2_DIR_EN) && !(data & ICE_SMA2_UFL2_RX_EN);

If the bit is renamed to an _EN suffix and is active high, should the logic be
inverted here? This code still treats the bit as active low by checking for it
being cleared (!(data & ICE_SMA2_UFL2_RX_EN)).

[ ... ]

> @@ -1264,10 +1264,10 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
>  	case ICE_DPLL_PIN_SW_2_IDX:
>  		if (state == DPLL_PIN_STATE_SELECTABLE) {
>  			data |= ICE_SMA2_DIR_EN;
> -			data &= ~ICE_SMA2_UFL2_RX_DIS;
> +			data &= ~ICE_SMA2_UFL2_RX_EN;
>  			enable = true;
>  		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
> -			data |= ICE_SMA2_UFL2_RX_DIS;
> +			data |= ICE_SMA2_UFL2_RX_EN;
>  			enable = false;
>  		} else {

Similarly, does this code still apply active low logic by clearing the _EN bit
when enable is true, and setting it when enable is false?

If the bit is truly active high as the commit message suggests ("setting it
enables RX"), shouldn't the bitwise operations be inverted to match?

