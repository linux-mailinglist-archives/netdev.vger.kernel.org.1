Return-Path: <netdev+bounces-290206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOlHIVNsDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E973159E050
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA4E308CD0F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A141360EF2;
	Thu, 21 May 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpMIaL+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2735AC16;
	Thu, 21 May 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330007; cv=none; b=dVSXcXQ2YSZzyjN5VqETp0HyqQlRuDISxROUjFTF7y3bIAlm9hVzdVLvozjl8jdrLBTsN+CgnWd383V4LoYrOtuwQA7aOJzRgS20ztOOWI3vSr+Ua4D4yO9V85Xw5awkmefYatlnOEq0I1/prqsZsA6K2+J82QM+yFUJAp9M7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330007; c=relaxed/simple;
	bh=EwcKMgCqeiakWJc2uhXVGqk/7K/uDWBZu/OPG+qCHsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxa3LHbd+amdULVLf0A8uE4XLGnrLNSZ/gto3plb0sX/ICNJeVNhrZAZkEDRr5rJfDuc++CnZ4fY6RhsAstUcTFZkcWGfy2ykQsSmTrjrfhy7+twtr5SKpDf819bsCtpmTN8xjv7vkm4aXtDH16trbDiGdGpTH8/4XPB9OyLcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpMIaL+c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D1B1F000E9;
	Thu, 21 May 2026 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329996;
	bh=xstjoF/zJ5oZYerl5FVu9kOlDFuapp4BsgXi3VaC0Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpMIaL+cAI1j6hm0NlgZFY8RpYGZmAom/bO9wxzbrC0W3tnKOn6LZl3c+LmJc0gk4
	 6YSBQpKEa3x4U74D7pLTs+j5PZUW76yN+sQOcg9wSe2sNvDnd7EzHEglhbndJ7H7q6
	 kXSFik/VF8EXgajkRzuIZTTBuByVI/9HB894cykF8A3z15Ex4RcN23UfBeVsLWJkPX
	 86F7kLvF2T8lcfKutPynZyg9CaKQyOZl/V315XJTC8sUvnJO9NFgVL0CIqgYWOmHpm
	 cXA3sRGCfI078lp8JmSECsmtvi3rWn5tKa2Db4xjAb26TEsXEtRD+TpWB8xv3hssa6
	 MHn1n+dv6GAJw==
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
Date: Wed, 20 May 2026 19:19:53 -0700
Message-ID: <20260521021953.688132-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290206-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E973159E050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: fix NULL deref in dpll_device_ops() during teardown race

This patch tolerates an empty registration_list on a still-indexed dpll
by dropping a WARN_ON in dpll_device_registration_first(), making
dpll_priv() and dpll_device_ops() return NULL in that state, and adding
an early return in dpll_cmd_pin_get_one() when the first dpll-ref of a
pin is already torn down.

> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index cbb635db4321..4a058b46c69d 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -1060,12 +1060,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);
>  static struct dpll_device_registration *
>  dpll_device_registration_first(struct dpll_device *dpll)
>  {
> -	struct dpll_device_registration *reg;
> -
> -	reg = list_first_entry_or_null((struct list_head *)&dpll->registration_list,
> -				       struct dpll_device_registration, list);
> -	WARN_ON(!reg);
> -	return reg;
> +	return list_first_entry_or_null((struct list_head *)&dpll->registration_list,
> +					struct dpll_device_registration, list);
>  }
>  
>  void *dpll_priv(struct dpll_device *dpll)
> @@ -1073,6 +1069,8 @@ void *dpll_priv(struct dpll_device *dpll)
>  	struct dpll_device_registration *reg;
>  
>  	reg = dpll_device_registration_first(dpll);
> +	if (!reg)
> +		return NULL;
>  	return reg->priv;
>  }

[High]
With dpll_priv() now silently returning NULL for any half-dead dpll,
the contract for the ~28 in-tree callers of dpll_priv() changes.  The
commit message asserts that the only path which can observe the new
NULL return is dpll_cmd_pin_get_one() reached from
dpll_pin_event_send(), and that this path is "gated here" by the new
check in dpll_cmd_pin_get_one().  Is that gate actually coextensive
with the set of dplls walked by this code path?

> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index ea6360263786..b73d718e8a56 100644
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

[High]
The check only validates the dpll returned by
dpll_xa_ref_dpll_first(&pin->dpll_refs), i.e. the first ref.  Later in
the same function, when pin->parent_refs is empty, control falls
through to dpll_msg_add_pin_dplls(), which walks every entry of
pin->dpll_refs:

    xa_for_each(&pin->dpll_refs, index, ref) {
        ...
        ret = dpll_msg_add_pin_on_dpll_state(msg, pin, ref, extack);
        ...
        ret = dpll_msg_add_pin_operstate(msg, pin, ref, extack);
        ...
        ret = dpll_msg_add_pin_prio(msg, pin, ref, extack);
        ...
        ret = dpll_msg_add_pin_direction(msg, pin, ref, extack);
        ...
        ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
        ...
    }

Each of those helpers calls dpll_priv(ref->dpll) and passes the
result as the dpll_priv argument to a driver ops callback.  Can a
non-first ref->dpll in this loop be in the same half-dead state (entry
still indexed in dpll_device_xa, but registration_list empty), so that
dpll_priv() now hands a NULL back to a driver callback that expects a
non-NULL private pointer (e.g. ice_dpll_pin_state_get does
struct ice_dpll *d = dpll_priv; struct ice_pf *pf = d->pf;)?

The teardown path the commit message describes
(zl3073x_dev_dpll_fini iterating list_for_each_entry over zldev->dplls
and calling zl3073x_dpll_unregister on each) drops dpll_lock between
per-dpll unregisters.  If a pin from a foreign driver references two
dplls of the unloading provider, can a notify work observe one
already torn down and the other still healthy, with the new gate
inspecting only the first?

Should the same NULL-tolerant treatment also be applied to the
xa_for_each loop in dpll_msg_add_pin_dplls(), or should the gate skip
half-dead refs there as well, so the commit message claim "those
callers cannot see the new NULL return ... only path that can is ...
gated here" actually holds?

[Medium]
Separately, the new -ENODEV return interacts with dpll_nl_pin_get_dumpit():

    ret = dpll_cmd_pin_get_one(skb, pin, cb->extack);
    if (ret) {
        genlmsg_cancel(skb, hdr);
        break;
    }

dpll_pin_available(pin) returns true as long as any of the pin's
parent_refs or dpll_refs is still DPLL_REGISTERED, so a pin can be
"available" while its first dpll_ref is the torn-down one.  In that
case the new -ENODEV breaks out of the dump loop and propagates to
userspace, hiding every later pin from a single dump call.  Should
this dumpit caller treat -ENODEV from dpll_cmd_pin_get_one() as a
"continue" rather than a fatal error, so the dump skips the transient
pin instead of failing wholesale?

