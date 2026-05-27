Return-Path: <netdev+bounces-292295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LnsLhjtFmruvgcAu9opvQ
	(envelope-from <netdev+bounces-292295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBB5E4A9C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62369305EA0C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086031F9A4;
	Wed, 27 May 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2xya97M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED023F431;
	Wed, 27 May 2026 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886779; cv=none; b=qdRq8Oikj0TQSLb9IF2Etau1UKAWv213pO31ffEAZV0hXPpk3Kwk9CWH0nr3NFcK5jRCezwKA35giLqzVATya6esv7xyTT9RfJA8qb5lsM+PLDWh0osRY0x3cdES3zzx6zZ5N5BDuygrWyXbm1qDyehMgkKI/mRha7zumo3wP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886779; c=relaxed/simple;
	bh=hoWmPSRATqFhROrs6GCfdc0zt4sxaWjiKAUubvnK474=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J05bDffzea3cDW2T1kW43Dsh+WIYF2WWdDpDmaCnaO/QA/feGO7jLOwrueaGJKtdpO/ZgRhH0Zcfyn81t2FUCZ3rx7o7wnhQM0lzn8shClNieYiaIMQ8r8O6U1+NCyPzzgFUyCWz+6g1+JWWqS8d+0KRlSTl4MznreYOxNo/S+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2xya97M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67511F000E9;
	Wed, 27 May 2026 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886778;
	bh=1V5rm1uBNj5LGMgLlR1vY3XBD1PgvozlU3dzAGtw/kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2xya97M/ohL+OzF4ebPgA2TkbhHJu/j5pjgJQuppa6EIvAO6lo9sqqdLyGfH63bb
	 QYgdiJ0yzGBJv0lxbMPA5c5hb3VxbMfCGdDgs8pl6NLmmMIp0UHwUF6vPe0TNBHuPL
	 smBPK5xyH82cE0m3ceyeBzv5pmPUAEdGoIK+oe5TdbfL/6GD6HlZ6QHEu+9UbadbUR
	 dDUcSk28DMJaAfScbjSXbSij5B1MoopBx1CAi3SGu2KoRll1qr5br+ZDXC+YFEKd8c
	 3iP5kbTJ/NhFmC5lDacbgljcopC6beLde4bCLtGFFN2CdDMjumEEPrBLNQ5lYo3Xug
	 GumIHTxGMZrbQ==
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
Subject: Re: [PATCH net 1/2] net: pse-pd: disable IRQ before freeing PI data in unregister
Date: Wed, 27 May 2026 13:55:53 +0100
Message-ID: <20260527125551.2425511-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524223306.2570676-2-github@szelinsky.de>
References: <20260524223306.2570676-2-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292295-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 37BBB5E4A9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: pse-pd: disable IRQ before freeing PI data in unregister

pse_controller_unregister() frees the PI array via pse_release_pis()
before disabling the controller IRQ. The threaded IRQ handler pse_isr()
walks pcdev->pi[] (via pse_set_config_isr() and
regulator_notifier_call_chain() on pcdev->pi[i].rdev), so an interrupt
arriving in the window between pse_release_pis() and disable_irq()
dereferences freed memory.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 69dbdbde9d71a..1f27884dd4d70 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1115,9 +1115,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
>  	pse_flush_pw_ds(pcdev);
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);

Simon says: The issue flagged below seems to warrant investigation
            within the context of this patch.

[Severity: High]
This is a pre-existing issue, but does leaving pse_flush_pw_ds() before
disable_irq() risk a use-after-free of a regulator during an interrupt?

pse_flush_pw_ds() drops references to power domains, which can trigger
__pse_pw_d_release() and free the regulator via regulator_put(pw_d->supply).

If an interrupt arrives after this but before the IRQ is disabled:

pse_isr()
  _pse_pi_disable()
    pse_pw_d_retry_power_delivery()
      regulator_request_power_budget(pw_d->supply, ...)

Could this access the freed regulator? Should disable_irq() be the very
first operation in the teardown sequence?

> +	pse_release_pis(pcdev);
>  	cancel_work_sync(&pcdev->ntf_work);

Simon says: Although this is a pre-exiting issue, it does seem to
            warrant investigation within the context of this patch-set.

[Severity: High]
This isn't a bug introduced by this patch, but can calling
cancel_work_sync() after pse_release_pis() cause an indirect
use-after-free of pcdev->pi?

The worker blocks during cancel_work_sync(), and it can call:

pse_send_ntf_worker()
  pse_control_put(psec)
    __pse_control_release()

Since __pse_control_release() explicitly dereferences
psec->pcdev->pi[psec->id].admin_state_enabled, can the worker execute this
release path while or after pcdev->pi is freed by pse_release_pis()?

>  	kfifo_free(&pcdev->ntf_fifo);
>  	mutex_lock(&pse_list_mutex);
>  	list_del(&pcdev->list);
>  	mutex_unlock(&pse_list_mutex);
>  }

Simon says: I believe the remaining issues should be investigated
            in the context of possible follow-up or separate bug
	    fixes.

[Severity: High]
This is a pre-existing issue, but does removing the device from the global
list at the very end of unregister allow concurrent lookups to access
freed memory?

The device remains discoverable via of_pse_control_get() while its
resources are actively being destroyed. If a concurrent thread calls
of_pse_control_get(), it will find the pcdev and call
pse_control_get_internal(), which accesses pcdev->pi[index].

Because pse_release_pis() has already freed pcdev->pi earlier in this
sequence, could this cause a use-after-free?

[Severity: High]
This is a pre-existing issue, but does the unregistration sequence lack
synchronization with external pse_control consumers?

of_pse_control_get() provides a pse_control struct to consumers (like PHY
drivers), using try_module_get() but without incrementing the device
reference count or creating strict device links.

When a PSE controller is unbound, pse_controller_unregister() synchronously
frees pcdev->pi. However, external clients may still hold struct
pse_control references.

When these clients are later removed, they call:

pse_control_put(psec)
  __pse_control_release()
    dereferences psec->pcdev->pi[psec->id]

Since pcdev->pi was already freed, does this cause a use-after-free on
client teardown?

[Severity: High]
This is a pre-existing issue, but does the devm teardown sequence free
internal structures while the PSE PI regulators remain fully accessible?

pse_controller_register() registers regulators using
devm_regulator_register(). Afterwards, devm_pse_controller_register()
registers its own release callback.

During driver unbind, the LIFO devm sequence means
devm_pse_controller_release() runs first, freeing pcdev->pi via
pse_release_pis().

However, the regulators are still active and visible in sysfs until the
subsequent devm teardown phase unregisters them. A concurrent sysfs access
(e.g., reading regulator state) during this window will invoke regulator
operations like pse_pi_is_enabled(), which dereference the already freed
pcdev->pi[id].

Could this result in a use-after-free?

[Severity: High]
This is a pre-existing issue, but is the globally shared and
reference-counted struct pse_power_domain object incorrectly tied to the
lifetime of the device that allocated it?

devm_pse_alloc_pw_d() allocates pw_d using devm_kzalloc(). The memory
lifetime is therefore bound to the registering PSE controller. This pw_d is
added to the global pse_pw_d_map and uses kref for reference counting.

pse_register_pw_ds() allows other PSE controllers to discover and share
this pw_d by incrementing its kref.

If the device that originally created pw_d unbinds, devm will unilaterally
free the pw_d memory, ignoring the kref counts held by other devices. Any
subsequent access by those other devices will result in a use-after-free.

The __pse_pw_d_release() function seems to omit kfree(pw_d) because it
relies on devm, but doesn't this break the kref requirement?

