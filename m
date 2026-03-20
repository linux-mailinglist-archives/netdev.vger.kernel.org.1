Return-Path: <netdev+bounces-269993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mISsBDKDvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:26:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC12DE966
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21FF430BC819
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B93CCFDE;
	Fri, 20 Mar 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLyu20iZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F43A5425;
	Fri, 20 Mar 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027062; cv=none; b=HolgVOrZbFmNnICA4g4LQnKelLYi6YCLLxZgBf1i2LZ710Adfg0zLEuOjUjbCWZePapAW7hRz2ci4qFRzoa3rN38emAQSNmWJysBOhEvIb0mOPQuegwdS8kAP8VfUBLjXXPK1siFMJL/Sq0bIUGoAYlxvcwY3B/AULHxepj05FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027062; c=relaxed/simple;
	bh=YkX7VJwogIY7Ii8WZ8idT79FuE2Ged5Vz4oWmQZ91vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq5WwPWrkLBeb1defCwxw4rSUZ/St5Zu0ruhST4SycjKPybrboPWxetcRXlYbYHeuD/WiKKo/6VoenVahlfklYwt+xMJbfMzkbM2wM+lXbyH9ge9kVQ0clvKWHLr+2IRlQDkUXujWQYY/xmLQcWDANVDmw3SQrIYgYBayHY+SnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLyu20iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067F1C2BCAF;
	Fri, 20 Mar 2026 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027061;
	bh=YkX7VJwogIY7Ii8WZ8idT79FuE2Ged5Vz4oWmQZ91vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLyu20iZ+DAtbq10yQ7DclyX0WJny5yY8yjnhGl6RILwWJLUCFB726KzFIdKYG+oh
	 l9IMy2Uc6jFzpYXW3OQg2zVdz02ArdfzAHlgqrY1Bslx0FiLha6yQPkuSdlU3LVPp4
	 ffKlCflnX2lbxT7P9fisxYj9OKVeT3yEL9mhRSa6s4+3/UtRJJNb9uaEQ5u/fQZaiQ
	 7+lEaZmEiAY6zhO845UzszKUtlS993i/wyVAxPp1TeeWC8ZegH9faw6n+q5YLqDIR7
	 kpcbcd+mees1CeSsiEzgEscTVFZFNBmeohgW6R/zmsaor/fejcq41ttQ0T7S1RLgXq
	 E5EJ0BQvvBocQ==
From: Simon Horman <horms@kernel.org>
To: ivecera@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	pvaanane@redhat.com,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	Prathosh.Satish@microchip.com,
	mschmidt@redhat.com,
	poros@redhat.com
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
Date: Fri, 20 Mar 2026 17:17:25 +0000
Message-ID: <20260320171725.112558-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319174826.7623-2-ivecera@redhat.com>
References: <20260319174826.7623-2-ivecera@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7EC12DE966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()

Return -EOPNOTSUPP early in esync_get callbacks when esync is not
supported instead of conditionally populating the range at the end.
This simplifies the control flow by removing the finish label/goto
in the output variant and the conditional range assignment in both
input and output variants.

Replace open-coded N-div signal format switch statements with
zl3073x_out_is_ndiv() helper in esync_get, esync_set and
frequency_set callbacks.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index a29f606318f6..79ef62d69a32 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -131,6 +131,12 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>  	ref_id = zl3073x_input_pin_ref_get(pin->id);
>  	ref = zl3073x_ref_state_get(zldev, ref_id);
>
> +	if (!pin->esync_control || zl3073x_ref_freq_get(ref) == 1)
> +		return -EOPNOTSUPP;
> +
> +	esync->range = esync_freq_ranges;
> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> +
>  	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
>  	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
>  		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
> @@ -142,17 +148,6 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>  		break;
>  	}
>
> -	/* If the pin supports esync control expose its range but only
> -	 * if the current reference frequency is > 1 Hz.
> -	 */
> -	if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
> -		esync->range = esync_freq_ranges;
> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> -	} else {
> -		esync->range = NULL;
> -		esync->range_num = 0;
> -	}
> -
>  	return 0;
>  }

The refactoring changes the behavior when the reference frequency is 0 Hz.

The old code checked 'zl3073x_ref_freq_get(ref) > 1' which excluded both
freq==0 and freq==1 from having the esync range exposed. The new code checks
'zl3073x_ref_freq_get(ref) == 1' which only excludes freq==1.

When freq==0 (which can happen when freq_base, freq_mult, or freq_ratio_m
is 0), the old code would return 0 with esync->range=NULL and
esync->range_num=0, while the new code returns 0 with
esync->range=esync_freq_ranges and esync->range_num=1.

The removed comment documented the original intent: "if the current reference
frequency is > 1 Hz". Should the new check be 'zl3073x_ref_freq_get(ref) <= 1'
to preserve the original behavior for 0 Hz frequencies?

>
> @@ -582,8 +577,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>  	struct zl3073x_dpll_pin *pin = pin_priv;
>  	const struct zl3073x_synth *synth;
>  	const struct zl3073x_out *out;
> +	u32 synth_freq, out_freq;
>  	u8 clock_type, out_id;
> -	u32 synth_freq;
>
>  	out_id = zl3073x_output_pin_out_get(pin->id);
>  	out = zl3073x_out_state_get(zldev, out_id);
> @@ -592,17 +587,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>  	 * for N-division is also used for the esync divider so both cannot
>  	 * be used.
>  	 */
> -	switch (zl3073x_out_signal_format_get(out)) {
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
> -	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
> +	if (zl3073x_out_is_ndiv(out))
>  		return -EOPNOTSUPP;
> -	default:
> -		break;
> -	}
>
>  	/* Get attached synth frequency */
>  	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
>  	synth_freq = zl3073x_synth_freq_get(synth);
> +	out_freq = synth_freq / out->div;
> +
> +	if (!pin->esync_control || out_freq == 1)
> +		return -EOPNOTSUPP;
> +
> +	esync->range = esync_freq_ranges;
> +	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
>
>  	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
>  	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
> @@ -610,11 +607,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>  		esync->freq = 0;
>  		esync->pulse = 0;
>
> -		goto finish;
> +		return 0;
>  	}
>
>  	/* Compute esync frequency */
> -	esync->freq = synth_freq / out->div / out->esync_n_period;
> +	esync->freq = out_freq / out->esync_n_period;
>
>  	/* By comparing the esync_pulse_width to the half of the pulse width
>  	 * the esync pulse percentage can be determined.
> @@ -623,18 +620,6 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
>  	 */
>  	esync->pulse = (50 * out->esync_n_width) / out->div;
>
> -finish:
> -	/* Set supported esync ranges if the pin supports esync control and
> -	 * if the output frequency is > 1 Hz.
> -	 */
> -	if (pin->esync_control && (synth_freq / out->div) > 1) {
> -		esync->range = esync_freq_ranges;
> -		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
> -	} else {
> -		esync->range = NULL;
> -		esync->range_num = 0;
> -	}
> -
>  	return 0;
>  }

Similar to the input variant, this changes the behavior for 0 Hz output
frequencies.

The old code used '(synth_freq / out->div) > 1' to decide whether to expose
the esync range, which excluded both out_freq==0 and out_freq==1. The new
code uses 'out_freq == 1' for the early -EOPNOTSUPP return, only excluding
out_freq==1.

When out_freq==0 (which can happen when synth_freq is 0 or synth_freq <
out->div), the old code returned 0 with esync->range=NULL and
esync->range_num=0, while the new code returns 0 with
esync->range=esync_freq_ranges and esync->range_num=1.

The removed comment documented the intent: "if the output frequency is > 1
Hz". Should this also use 'out_freq <= 1' to maintain consistency with the
original behavior?

[ ... ]

