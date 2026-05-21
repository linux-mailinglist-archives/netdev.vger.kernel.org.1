Return-Path: <netdev+bounces-290205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJUpO9FrDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6F59E016
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53FB7301477F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49753655CD;
	Thu, 21 May 2026 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY+JSHbD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7597360EF0;
	Thu, 21 May 2026 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329995; cv=none; b=Sw9q7pc80Jg3YbjfFgF9NKflNHnhzLNpR5+FqdSv2CyVTdotO0o9NsIewoP2E2EE/xU5QlNLVOL5WfAuRNJ78GqT8AGPWmPmK4dyChhLWuW3//G2Z4ZlFak52Y0mII3IpBDPT49uZH0Clbe2THe3pf+WwSDmaEfL/xeygcPmFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329995; c=relaxed/simple;
	bh=baWwEB+FHrcigTgN4Vfl1iH8UvU+Gd9nHBNwmcJsfNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1nzVYrdWb9sIDCVrfOxT5ik/poQup3iUPSo2AFl9BpuhpM2krqDIMMIQ1S6bwen7VzDYABnKDgHYApV+HpqYhHQFbkbuPxK4XQ7LrrcqdOGpxttsuM3I2VDW+2qCS1qbe4kjdq7AcWp4wcxNuUV4WygBvcA6XWJdHMX4JbJWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY+JSHbD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDE71F000E9;
	Thu, 21 May 2026 02:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329979;
	bh=F+Kw+Xvl9UpA+E1GczNvGRvLmVj0lW5NPUEpmZV5H5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FY+JSHbD7vnlpTPx4WaqSEgypwnWbS6ricHVxk3jhf+qDX5Zs6ZDNSbhOl8e5vGgP
	 bg+tVVQ/t9GiaozYmZkpjYLLYeQm8gB83qelb/C+QPDie9c+2duIAc7ronXKLvA9dW
	 Jkeoaf7j8nfg+RmbykUyZNSH8soTBbMSoBg9+zbo5CPl+kjuCUBQjVwoHjLftpQ/YM
	 75j1osAYgiS6SutK9nyOoZaw4mHMWAsw+xB/zTzmVAnci7EfNyGJWGLWYNSRiWg45E
	 05RNn7fLlz7mjRIjy+sqiuDuhHjrysyNS9QIvfA3XN0/LD4yxv8TXVu/+yDM924klN
	 J48g0/yq9NezA==
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
Subject: Re: [PATCH net 2/2] dpll: filter pin->dpll_refs by cookie in dpll_pin_on_pin_unregister
Date: Wed, 20 May 2026 19:19:32 -0700
Message-ID: <20260521021932.688001-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516191317.1005612-3-poros@redhat.com>
References: <20260516191317.1005612-3-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290205-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3DF6F59E016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: filter pin->dpll_refs by cookie in dpll_pin_on_pin_unregister

This commit fixes a warning triggered when unregistering a pin that is
reachable through multiple parents with different supported DPLL sets. It
filters the DPLL reference iteration by the parent cookie to ensure only the
entries contributed by the specific parent are removed.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 4a058b46c69d4..4779976682fdb 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -1024,8 +1024,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
>  	mutex_lock(&dpll_lock);
>  	dpll_pin_delete_ntf(pin);

Does this send a premature deletion notification to userspace when a pin has
multiple parents?

While this patch correctly fixes the kernel-side handling of multiple-parent
pins, it appears the userspace notification lifecycle remains asymmetrical in
this scenario.

Because dpll_pin_delete_ntf(pin) is called unconditionally before removing
the parent or DPLL references, dpll_pin_available(pin) evaluates to true and
the DPLL_CMD_PIN_DELETE_NTF event is broadcasted to userspace.

If a pin is registered via both parent_A and parent_B, unregistering it from
parent_A alone will instruct userspace to tear down its state for the pin,
even though the pin remains fully registered and active via parent_B.

Could this cause desynchronization between kernel and userspace states when a
shared pin is partially unregistered?

>  	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> -	xa_for_each(&pin->dpll_refs, i, ref)
> +	/* pin->dpll_refs is the union over all of pin's parents; only
> +	 * touch entries actually registered via @parent.
> +	 */
> +	xa_for_each(&pin->dpll_refs, i, ref) {
> +		if (!dpll_pin_registration_find(ref, ops, priv, parent))
> +			continue;
>  		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
> +	}
>  	mutex_unlock(&dpll_lock);
>  }
>  EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);

