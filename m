Return-Path: <netdev+bounces-292279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGt8OH/oFmruvgcAu9opvQ
	(envelope-from <netdev+bounces-292279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D275E466D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D30130059A1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5203D1CDB;
	Wed, 27 May 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2PxTaZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF12261B92;
	Wed, 27 May 2026 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886204; cv=none; b=XWM3lpr3c2fSlBWm4uJunrS1agg0iub7J+QWEQQJ9M/1DrQX651i1avYUtmo23il5S2SkdXvT3EqJH0lhCMHmhJy368ibBAEr1+YCrG0mY61eyztOYUabMck5PYX5TNWcj/Pj3yNY67Uw7jmHZi6pcZXW+KZfUbIvXqeAUSCumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886204; c=relaxed/simple;
	bh=OqrCutP3sa8S9NK1xPuRxZiBxJMgnAMIlpJLT3lcUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEZerf7Y2Cf5wqWWsxgeYEH9HnrHpRkSiZmqUq2QnHTmJjYv6tZWmivlo9WjMHg1XDPVeVPELtsxhfR4uJ7KdOkPJScyfvz+roiE7ERMDuqtOk7E9dsfYDeKHg8jfHoul+cgAh3uYzYqA8BnKgkrcRxDOfwcoUWHjM6z4CX5pAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2PxTaZ1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE91F000E9;
	Wed, 27 May 2026 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886202;
	bh=zxfX9VkuEdLPouDhpnJyfdIJmhG99thSuKPPL/NwenE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B2PxTaZ1+TMceB/RYfaGG5qL+c3ClCUAnXODPH0cqzmqfFKSLBhtotW/SmnL5qS1V
	 xuPVsPK2kupf18hMC8l3X8weWP0Kz86d14zcmNV84LyW8o3hbtDCmS5lU+qI4wRNqv
	 LIEFqM0m4M0MUhd0NqewUJubOYylA5PlG3OBp1l1LA87hkc1PIJnydv87tQx9lx39B
	 SNEUUtx6RFMaFYkWsR0COUqVxRrBGrLYv/5Y91lVzj0N6zsHuEthnVMpE7HPDAC3xQ
	 RzNWIo3FhdKFm3rjzX7vZBVccHT9FIZGqGNhLY10OpIfR2x5QT5Le3YGnSkisgvd6H
	 h7KpN5uOKrTqg==
From: Simon Horman <horms@kernel.org>
To: github@szelinsky.de
Cc: 'Simon Horman' <horms@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: pse-pd: guard against freed PI data on regulator disable
Date: Wed, 27 May 2026 13:24:19 +0100
Message-ID: <20260527122418.2410341-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524223306.2570676-3-github@szelinsky.de>
References: <20260524223306.2570676-3-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292279-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75D275E466D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
Subject: net: pse-pd: guard against freed PI data on regulator disable

This patch closes a use-after-free reachable from the regulator core's
deferred-disable flush during driver detach by clearing pcdev->pi after
freeing it in pse_release_pis() and bailing out in pse_pi_disable() when
pcdev->pi is NULL.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 1f27884dd4d7..752d987a7004 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -145,6 +145,7 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
>  		of_node_put(pcdev->pi[i].np);
>  	}
>  	kfree(pcdev->pi);
> +	pcdev->pi = NULL;
>  }

[High]
Is the pcdev->pi = NULL store correctly synchronized with the readers?

The reader side in pse_pi_disable() observes pcdev->pi under
pcdev->lock:

    mutex_lock(&pcdev->lock);
    if (!pcdev->pi) {
            mutex_unlock(&pcdev->lock);
            return 0;
    }

But pse_release_pis() does the kfree() and the NULL store without
acquiring pcdev->lock, and pse_controller_unregister() does not wrap
the pse_release_pis() call with that lock either:

    void pse_controller_unregister(struct pse_controller_dev *pcdev)
    {
            pse_flush_pw_ds(pcdev);
            if (pcdev->irq)
                    disable_irq(pcdev->irq);
            pse_release_pis(pcdev);
            ...
    }

In the LIFO devres scenario described in the commit message, the later
regulator_unregister() does flush_work() on the deferred disable, which
provides the necessary memory barrier, so that specific case is fixed.

However, regulator consumers in other drivers (PHY/MAC) hold a
struct regulator * to a PSE PI and can call regulator_disable() (which
may take the pse_pi_disable() path directly) on a different CPU,
concurrent with the unbind path running pse_release_pis() on this
device.

That concurrent reader can take pcdev->lock and observe pcdev->pi as
still non-NULL while pse_release_pis() is concurrently kfree()-ing the
array, leading to a UAF in the subsequent _pse_pi_disable(pcdev, id)
and pcdev->pi[id].admin_state_enabled = 0 dereferences.

Would taking pcdev->lock around the kfree()+NULL store in
pse_release_pis() (so the NULL observation under pcdev->lock is
authoritative) close that window? Alternatively, can the regulator
unregister be ordered to run before pse_release_pis() so no consumer
can invoke a regulator op while the PI array is being torn down?

> @@ -702,15 +703,21 @@ static int pse_pi_enable(struct regulator_dev *rdev)
>  static int pse_pi_disable(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
> -	struct pse_pi *pi;
>  	int id, ret;
>  
>  	id = rdev_get_id(rdev);
> -	pi = &pcdev->pi[id];
>  	mutex_lock(&pcdev->lock);
> +	/* The controller may already be unregistered (pcdev->pi freed) by the
> +	 * time the regulator core flushes a deferred disable during
> +	 * regulator_unregister(). Bail out to avoid touching freed PI data.
> +	 */
> +	if (!pcdev->pi) {
> +		mutex_unlock(&pcdev->lock);
> +		return 0;
> +	}
>  	ret = _pse_pi_disable(pcdev, id);
>  	if (!ret)
> -		pi->admin_state_enabled = 0;
> +		pcdev->pi[id].admin_state_enabled = 0;
>  
>  	mutex_unlock(&pcdev->lock);
>  	return 0;

[High]
Should the same NULL guard be applied to pse_pi_is_enabled() and
pse_pi_enable()?

Both callbacks follow the identical pattern as the disable path:
rdev_get_drvdata(rdev) -> mutex_lock(&pcdev->lock) -> unconditional
pcdev->pi[id].* access.

In pse_pi_is_enabled():

    id = rdev_get_id(rdev);
    mutex_lock(&pcdev->lock);
    if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
            ret = pcdev->pi[id].admin_state_enabled;
            ...

And in pse_pi_enable():

    id = rdev_get_id(rdev);
    mutex_lock(&pcdev->lock);
    if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
            if (pcdev->pi[id].isr_pd_detected) {
                    ...
            }
            ...

The lifetime invariant cited in the commit message ("the controller
may already be unregistered by the time the regulator core flushes...")
is a property of the LIFO devres unwind order in which
pse_controller_unregister() runs before the devm-registered regulators
are torn down.

While regulator_unregister() only flushes disable_work, regulator
consumers in other drivers that hold a struct regulator * to a PSE PI
can still call regulator_is_enabled() or regulator_enable() concurrent
with the in-progress pse_controller_unregister() on the parent device.
At that point pcdev->pi may already be NULL/freed and the unguarded
pcdev->pi[id].pw_d / pcdev->pi[id].admin_state_enabled dereferences
would be a UAF or NULL deref.

Should these two callbacks receive the same guard, or alternatively
should the unwind order be changed so that no callback can fire after
the PI array is freed?

