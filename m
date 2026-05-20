Return-Path: <netdev+bounces-289851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJt2Cdx+DWosyAUAu9opvQ
	(envelope-from <netdev+bounces-289851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:29:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711AC58AC9C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4993124793
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA43B2FC7;
	Wed, 20 May 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4LhfCgj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AC3932DC
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267510; cv=none; b=fa3tqlaLoSJFhyoKdxMIq79v7AjS3N9ubSbO37Ys3s3CH9+ZE4jyvnjVh/CVoKenx+zZUcT4s+q9t2i/jetrCsiG3+n9Q30PVpVZPh6AigLECHcYo8AGdOH6si7Fxm4JLhP9Imw33QGx9GMIyp9iou6eUyQwxg1Oea6mNFrgnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267510; c=relaxed/simple;
	bh=pUMU/P2CEVLR7r/H//y4B3kv/0wQhHOFYYiKWIB5spE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t3vjx3CL6ohz8JjQdmSFvu2w590NL4l47Pnmtf7gmPdY/mnELc3EiiPqGMq33jkkJuFFEO20BGvcQTqxYCPb/8X54H/v5H9gp25avCDBTqrlm6wcHZvTyMfPkCpL74LBfNmAN054u7jo9UbK16K6Cov0+vr65qBYqyVHvtQ2rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4LhfCgj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779267497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYjEawSFilUImjuvb443qOSaRqxrooF94EekmmihcgA=;
	b=V4LhfCgji8GqTj7LFw7K20CQCvlTlUI/+Q9iGsIr0VxqaqE2Ue9kVHJJWrAPxcOo32sk/Q
	Gl7GNz1+a8IAumahlaGI6L7KN5Pg+E8hdVasnZBihUPBlTsJb+o4rWlQWO6m530w7BeSlY
	/VEbf/9GvDsgxH2sjlRNnN99274HEIw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-hZoo2lfKODCZU6FZiJFdMg-1; Wed,
 20 May 2026 04:58:14 -0400
X-MC-Unique: hZoo2lfKODCZU6FZiJFdMg-1
X-Mimecast-MFC-AGG-ID: hZoo2lfKODCZU6FZiJFdMg_1779267492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAF71195609F;
	Wed, 20 May 2026 08:58:11 +0000 (UTC)
Received: from [10.44.32.79] (unknown [10.44.32.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A491B1956053;
	Wed, 20 May 2026 08:58:07 +0000 (UTC)
Message-ID: <0a63ee24-024b-4f96-a66a-f949b3559bf7@redhat.com>
Date: Wed, 20 May 2026 10:58:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add NCO virtual input pin
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260516175744.26749-1-ivecera@redhat.com>
 <20260516175744.26749-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260516175744.26749-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289851-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 711AC58AC9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko findings clarification inline below...

On 5/16/26 7:57 PM, Ivan Vecera wrote:
> Add a virtual NCO (Numerically Controlled Oscillator) input pin that
> lets userspace switch a DPLL channel into NCO mode. A single NCO pin
> is shared across all DPLL channels — each channel has its own
> independent connection state. The NCO pin is registered with the new
> DPLL_PIN_TYPE_INT_NCO type and reports DPLL_PIN_STATE_CONNECTED /
> DPLL_PIN_OPERSTATE_ACTIVE when the channel is in NCO mode.
> ...
> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 2fe3c3da84bb5..f5d6c7917e57a 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -21,6 +21,11 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   	u64 val;
>   	int rc;
>   
> +	/* Serialize with zl3073x_chan_nco_mode_set() which also
> +	 * modifies chan->mode_refsel and chan->df_offset.
> +	 */
> +	guard(mutex)(&zldev->multiop_lock);
> +
>   	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(index),
>   			     &chan->mon_status);
>   	if (rc)
> @@ -31,7 +36,10 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   	if (rc)
>   		return rc;
>   
> -	/* Read df_offset vs tracked reference */
> +	/* Read df_offset only when locked to a reference */
> +	if (zl3073x_chan_lock_state_get(chan) != ZL_DPLL_MON_STATUS_STATE_LOCK)
> +		return 0;
> +

Sashiko commented:

> If the device boots already in NCO mode, can chan->df_offset ever be
> populated?
> Walking through zl3073x_chan_state_fetch() at probe time with the
> hardware already in NCO mode:
>   - state_fetch() reads ctrl and mode_refsel, then calls
>     zl3073x_chan_state_update()
>   - state_update() now early-returns above when lock_state is not
>     STATE_LOCK, and an NCO-mode channel is not LOCK, so df_offset
>     keeps its kzalloc default of 0
>   - zl3073x_dpll_nco_pin_register() updates ctrl bits via
>     zl3073x_chan_state_set() but does not touch mode_refsel, so the
>     edge-triggered nco_auto_read does not fire (it captures only on
>     the transition into NCO)
>   - zl3073x_dpll_nco_pin_ffo_get() then reports
>     -mul_s64_u64_shr(0, 244140625, 36) = 0
> The commit message states "Input reference pins are now always
> registered regardless of the initial DPLL mode", so boot-in-NCO is a
> supported configuration.
> Should zl3073x_dpll_nco_pin_register() (or state_fetch) read
> ZL_REG_DPLL_DF_OFFSET when the channel is already in NCO mode, similar
> to the read in the new zl3073x_chan_nco_mode_set()?

In boot-in-NCO configuration the df_offset is zero... so this behavior
is correct.

> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index cff85cdb9d0e5..2efefb1d7e224 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -605,6 +630,7 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
>   {
>   	struct zl3073x_dpll *zldpll = dpll_priv;
>   	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll_pin *nco_pin = NULL;
>   	struct zl3073x_chan chan;
>   	u8 mode, ref;
>   	int rc;
> @@ -634,6 +660,10 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
>   			goto invalid_state;
>   		}
>   		break;
> +	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
> +		if (state == DPLL_PIN_STATE_CONNECTED)
> +			nco_pin = zl3073x_dpll_nco_pin_get(zldpll);
> +		fallthrough;
>   	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
>   	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
>   		if (state == DPLL_PIN_STATE_CONNECTED) {

Sashiko commented:

> When a REF pin is connected while the channel is in REFLOCK and the
> NCO pin is then connected, the channel transitions REFLOCK -> NCO via
> zl3073x_chan_nco_mode_set(). The previously-locked REF pin now
> reports DPLL_PIN_STATE_DISCONNECTED via the default branch in
> zl3073x_dpll_input_pin_state_on_dpll_get(), but no immediate
> __dpll_pin_change_ntf() is sent for that REF pin.
> The periodic worker zl3073x_dpll_changes_check() will eventually pick
> up the operstate change and call dpll_pin_change_ntf() for the REF
> pin so userspace re-queries.
> Should the same explicit-immediate-notification pattern that this
> patch introduces for the NCO pin also apply to the previously-
> connected REF pin when its connection state changes due to a mode
> transition?

No, explicit notification for NCO pin is sent because NCO-type pin is
not monitored. For regulard HW input references the implicit
notification will be sent by peridic monitor function.

> ...
> +static int
> +zl3073x_dpll_nco_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
> +			     const struct dpll_device *dpll, void *dpll_priv,
> +			     struct dpll_ffo_param *ffo,
> +			     struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	const struct zl3073x_chan *chan;
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (!zl3073x_chan_mode_is_nco(chan))
> +		return -ENODATA;
> +
> +	/* NCO register has inverted sign: f_offset = -df_offset / 2^48
> +	 * Convert to PPT: ppt = -df * 5^12 / 2^36
> +	 */
> +	ffo->ffo = -mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
> +				    244140625, 36);
> +
> +	return 0;
> +}

Sashiko commented:

> The new pin is registered with type DPLL_PIN_TYPE_INT_NCO. The UAPI
> header include/uapi/linux/dpll.h documents that type as: "When
> connected as a DPLL input, the DPLL enters NCO mode where the output
> frequency is adjusted by the host via the PTP clock interface."
> Does this driver satisfy that contract?
> There is no PTP clock device registered anywhere under
> drivers/dpll/zl3073x (no ptp_clock_register, no ptp_clock_info, no
> adjfine/adjphase). The new zl3073x_dpll_nco_pin_ops exposes only
> ffo_get, state_on_dpll_get/set, operstate_on_dpll_get and
> direction_get, with no frequency or phase control. The pin properties
> declare only DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE.
> The commit message also says "The value is static for the duration of
> NCO mode and serves as the FFO snapshot reported to userspace", so
> zl3073x_chan_nco_mode_set() captures df_offset once and never updates
> it.
> Generic userspace recognizing DPLL_PIN_TYPE_INT_NCO will reasonably
> expect a controllable NCO. Should this mode either expose a frequency
> adjustment path (PTP or otherwise) or document that this device
> exposes a read-only frozen-offset variant of the NCO type?

The PTP support for zl3073x will follow this series.

Thanks,
Ivan


