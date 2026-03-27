Return-Path: <netdev+bounces-272497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGh8KT5dxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:34:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD13429EA
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACD42300CA30
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC43A8749;
	Fri, 27 Mar 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpmwWsts";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg3HBhMS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF433ADA7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607674; cv=none; b=LiG27aQUHPGybtCiP1iIHj5pRAbc3EwiiAzRI2jKX0oGQEz2TACpyEVR9CLT9sBpsSXeDA4imjcYPXYgcghgYCrfdDNhtkFP4aDQOzyJfOTi9/Dkik3s27cc1hjISJuWL7rjPQAlgsYspJ7zIZ63Hd/5ku1MbQWCxMMIzBqoTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607674; c=relaxed/simple;
	bh=BCw/Xc+yPQOPqxvqPfk22LM6xF38n2ci3+5e8iEcT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1+0xv0Dqe+JJ+Gbme2emeFO+b9rmL/FcboRYNloDi+J1UM7Mc0m+mUwiKbUUs5pzt6vAEq7yo3kxHLVBx1MsvApwlx9q6gFZfBZ/m7vbUy+ULmRzws84BK/ebKRpusRvmJiYQLO89JS+Ess+Vb7Ppy69eYIP2OJn6orp2px3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpmwWsts; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mg3HBhMS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774607672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DVZ0ZiCH5gLAQgROkR7a+AA1Jb2BcwfjDddpxmGZHU=;
	b=OpmwWstsHZWDdF8KpPSAgBffNDl0sDJMzITa0DiZFi0Bk/h3AYc94Cj8muY7P2lo3djQEx
	1725QbmgjDGe9PNl7dQs5XDhnZCd2si0T3Gvapynqf7QAmqA0OCxeOfHecDAjWtV1LP7xl
	B/RzB8x6NhfdVCwcZ6hc2Rrk+oOu5ms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-K4-584lrOuaDQwTgmBOaig-1; Fri, 27 Mar 2026 06:34:30 -0400
X-MC-Unique: K4-584lrOuaDQwTgmBOaig-1
X-Mimecast-MFC-AGG-ID: K4-584lrOuaDQwTgmBOaig_1774607669
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fb142205so24763605e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774607669; x=1775212469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DVZ0ZiCH5gLAQgROkR7a+AA1Jb2BcwfjDddpxmGZHU=;
        b=Mg3HBhMSafW1oZKQLv7JLuMYm/Zn9EoVgIgOica1fTsYht5G43xp+PQVEpZcDnbkEc
         UrbKDAz96T2jM041we/gGovGKVfVFe6GBeqDLqdw5RpE59WDqwY6CwT2lcZzEHKurdS5
         mW6d5AKQ0/hYHHxTigDebTwSFZBMP+XArLS5hN/SbVl4vYoG0RP98qwxBGFC4HEOFBJ9
         u2D2L5A3Lq0iSvHpkDw7sVWOJaLTZ/7okAafKoNzsZ6joLhstjBrea6Z2qIGn6xft+OB
         WyuLVUfayT62wzD8FHBs4zxgpY1HAMuvdWiMUFQEewxLs6riTo/6AxxDmV0bwwub0wbf
         5hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607669; x=1775212469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DVZ0ZiCH5gLAQgROkR7a+AA1Jb2BcwfjDddpxmGZHU=;
        b=qOwwd1eiO0tNd8md9lc5GZXqtb1qxsRB1mHQYKNubCaxFzdiPu8X8hfiYZNhxU4ElU
         tge0tVY4Vk/gd9ySF60vVKb2GRiXD7vK7a7idcJZ1z1xKukId3Tar8dKQtwPYX7BX77L
         1lXcW0hoVabTheDA4eIuTMeyQVBDW8hZjyvSZFxUXLazfu69ze9nmTJJrP+YahJxdjB2
         3IAIEcjroAxjurF1kDSLlSornfH70ABxd+wZh4hRjh8cLqtG7am3aPssBgAuMPKR6aeM
         3nV8tWC4jRkpQM0go1Z+FkjkHZct4DlK/YOBoM9u+WyIbA7jDdOrdQeUM57eWQy0K+Re
         V/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpIzKJt/VTN8GX7Bi+Y+EvIuA5TRtVAa74FedbEzIqISLIQ3OlwAm3aOWdD7XGgjHcVFdAvdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGsWUvWKz/kwCVQrcB0zhTMgi1/ktK60/2Jl5ZfasZVtWxIiX
	X5l51ClOF3Ad1EQ3DnBJuNuLCLlAEKYS+t2R72hgqIqG+MbFvLwhU83uGcD52QsPv95wpZ7e9zd
	+BSW9n7W/LpM8KTb2aH0/nI84t/EXignl3eRW9rnS3uWRTPvBgdaLdugShQ==
X-Gm-Gg: ATEYQzzCcd8lnS6i089AGkpuqqL+oJVpL1DipaC38DZLrFlRVmTirwETBwJKT9qz0kH
	/yXPbecNds9OlBB018kcPNN5k5ACuqpg1JA9ePj7G0mAbr6aNef+f5jXdTTSfO5aBN4CrSbf1IL
	JtplcGGBAnDZpcN2+QUnbs/v3vmBVNo94LDTTM/pMc8EErJyuzk+OxZQnJMwX7bMuiC6WSGR8od
	M9ivCPjdxdqHSY5mUCINTFzGGvWDla58AYubiwTIvICSfgfGKd1K3zNtgSe5tTBNZ5n/ec3/+yA
	vTdue2BtavZshVV5khHnJnCoVCbkZSZ1MrBF7W9fkhErUyAEBbk2X3XPMUfbBI6Rs++TlxsZdaA
	Nh6EanqZ1XvpXekooH9y6
X-Received: by 2002:a05:600c:a010:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-48727d4588cmr33714685e9.7.1774607669048;
        Fri, 27 Mar 2026 03:34:29 -0700 (PDT)
X-Received: by 2002:a05:600c:a010:b0:485:ae14:8192 with SMTP id 5b1f17b1804b1-48727d4588cmr33713955e9.7.1774607668538;
        Fri, 27 Mar 2026 03:34:28 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65989sm139918865e9.2.2026.03.27.03.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:34:27 -0700 (PDT)
Message-ID: <416f5f4f-93a8-41f7-93f5-fdf1fc0f7768@redhat.com>
Date: Fri, 27 Mar 2026 11:34:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] dpll: zl3073x: add ref-sync pair support
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-6-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260319174826.7623-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272497-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44FD13429EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add support for ref-sync pair registration using the 'ref-sync-sources'
> phandle property from device tree. A ref-sync pair consists of a clock
> reference and a low-frequency sync signal where the DPLL locks to the
> clock reference but phase-aligns to the sync reference.
>
> The implementation:
> - Stores fwnode handle in zl3073x_dpll_pin during pin registration
> - Adds ref_sync_get/set callbacks to read and write the sync control
>    mode and pair registers
> - Validates ref-sync frequency constraints: sync signal must be 8 kHz
>    or less, clock reference must be 1 kHz or more and higher than sync
> - Excludes sync source from automatic reference selection by setting
>    its priority to NONE on connect; on disconnect the priority is left
>    as NONE and the user must explicitly make the pin selectable again
> - Iterates ref-sync-sources phandles to register declared pairings
>    via dpll_pin_ref_sync_pair_add()
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 207 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 206 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 276f0a92db0b1..8010e2635f641 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -13,6 +13,7 @@
>   #include <linux/module.h>
>   #include <linux/netlink.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/slab.h>
>   #include <linux/sprintf.h>
>   
> @@ -30,6 +31,7 @@
>    * @dpll: DPLL the pin is registered to
>    * @dpll_pin: pointer to registered dpll_pin
>    * @tracker: tracking object for the acquired reference
> + * @fwnode: firmware node handle
>    * @label: package label
>    * @dir: pin direction
>    * @id: pin id
> @@ -45,6 +47,7 @@ struct zl3073x_dpll_pin {
>   	struct zl3073x_dpll	*dpll;
>   	struct dpll_pin		*dpll_pin;
>   	dpll_tracker		tracker;
> +	struct fwnode_handle	*fwnode;
>   	char			label[8];
>   	enum dpll_pin_direction	dir;
>   	u8			id;
> @@ -184,6 +187,109 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
>   	return zl3073x_ref_state_set(zldev, ref_id, &ref);
>   }
>   
> +static int
> +zl3073x_dpll_input_pin_ref_sync_get(const struct dpll_pin *dpll_pin,
> +				    void *pin_priv,
> +				    const struct dpll_pin *ref_sync_pin,
> +				    void *ref_sync_pin_priv,
> +				    enum dpll_pin_state *state,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll_pin *sync_pin = ref_sync_pin_priv;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll *zldpll = pin->dpll;
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	const struct zl3073x_ref *ref;
> +	u8 ref_id, mode, pair;
> +
> +	ref_id = zl3073x_input_pin_ref_get(pin->id);
> +	ref = zl3073x_ref_state_get(zldev, ref_id);
> +	mode = zl3073x_ref_sync_mode_get(ref);
> +	pair = zl3073x_ref_sync_pair_get(ref);
> +
> +	if (mode == ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR &&
> +	    pair == zl3073x_input_pin_ref_get(sync_pin->id))
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +
> +	return 0;
> +}
> +
> +static int
> +zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
> +				    void *pin_priv,
> +				    const struct dpll_pin *ref_sync_pin,
> +				    void *ref_sync_pin_priv,
> +				    const enum dpll_pin_state state,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll_pin *sync_pin = ref_sync_pin_priv;
> +	struct zl3073x_dpll_pin *pin = pin_priv;
> +	struct zl3073x_dpll *zldpll = pin->dpll;
> +	struct zl3073x_dev *zldev = zldpll->dev;
> +	u8 mode, ref_id, sync_ref_id;
> +	struct zl3073x_chan chan;
> +	struct zl3073x_ref ref;
> +	int rc;
> +
> +	ref_id = zl3073x_input_pin_ref_get(pin->id);
> +	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
> +	ref = *zl3073x_ref_state_get(zldev, ref_id);
> +
> +	if (state == DPLL_PIN_STATE_CONNECTED) {
> +		const struct zl3073x_ref *sync_ref;
> +		u32 ref_freq, sync_freq;
> +
> +		sync_ref = zl3073x_ref_state_get(zldev, sync_ref_id);
> +		ref_freq = zl3073x_ref_freq_get(&ref);
> +		sync_freq = zl3073x_ref_freq_get(sync_ref);
> +
> +		/* Sync signal must be 8 kHz or less and clock reference
> +		 * must be 1 kHz or more and higher than the sync signal.
> +		 */
> +		if (sync_freq > 8000) {
> +			NL_SET_ERR_MSG(extack,
> +				       "sync frequency must be 8 kHz or less");
> +			return -EINVAL;
> +		}
> +		if (ref_freq < 1000) {
> +			NL_SET_ERR_MSG(extack,
> +				       "clock frequency must be 1 kHz or more");
> +			return -EINVAL;
> +		}
> +		if (ref_freq <= sync_freq) {
> +			NL_SET_ERR_MSG(extack,
> +				       "clock frequency must be higher than sync frequency");
> +			return -EINVAL;
> +		}
> +
> +		zl3073x_ref_sync_pair_set(&ref, sync_ref_id);
> +		mode = ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR;
> +	} else {
> +		mode = ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF;
> +	}
> +
> +	zl3073x_ref_sync_mode_set(&ref, mode);
> +
> +	rc = zl3073x_ref_state_set(zldev, ref_id, &ref);
> +	if (rc)
> +		return rc;
> +
> +	/* Exclude sync source from automatic reference selection by setting
> +	 * its priority to NONE. On disconnect the priority is left as NONE
> +	 * and the user must explicitly make the pin selectable again.
> +	 */
> +	if (state == DPLL_PIN_STATE_CONNECTED) {
> +		chan = *zl3073x_chan_state_get(zldev, zldpll->id);
> +		zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
> +					  ZL_DPLL_REF_PRIO_NONE);
> +		return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>   			       const struct dpll_device *dpll, void *dpll_priv,
> @@ -1100,6 +1206,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
>   	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
>   	.prio_get = zl3073x_dpll_input_pin_prio_get,
>   	.prio_set = zl3073x_dpll_input_pin_prio_set,
> +	.ref_sync_get = zl3073x_dpll_input_pin_ref_sync_get,
> +	.ref_sync_set = zl3073x_dpll_input_pin_ref_sync_set,
>   	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
>   	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
>   };
> @@ -1190,8 +1298,11 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
>   	if (IS_ERR(props))
>   		return PTR_ERR(props);
>   
> -	/* Save package label, esync capability and phase adjust granularity */
> +	/* Save package label, fwnode, esync capability and phase adjust
> +	 * granularity.
> +	 */
>   	strscpy(pin->label, props->package_label);
> +	pin->fwnode = fwnode_handle_get(props->fwnode);
>   	pin->esync_control = props->esync_control;
>   	pin->phase_gran = props->dpll_props.phase_gran;
>   
> @@ -1236,6 +1347,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
>   	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>   	pin->dpll_pin = NULL;
>   err_pin_get:
> +	fwnode_handle_put(pin->fwnode);
> +	pin->fwnode = NULL;
>   	zl3073x_pin_props_put(props);
>   
>   	return rc;
> @@ -1265,6 +1378,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
>   
>   	dpll_pin_put(pin->dpll_pin, &pin->tracker);
>   	pin->dpll_pin = NULL;
> +
> +	fwnode_handle_put(pin->fwnode);
> +	pin->fwnode = NULL;
>   }
>   
>   /**
> @@ -1735,6 +1851,88 @@ zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
>   	kfree(zldpll);
>   }
>   
> +/**
> + * zl3073x_dpll_ref_sync_pair_register - register ref_sync pairs for a pin
> + * @pin: pointer to zl3073x_dpll_pin structure
> + *
> + * Iterates 'ref-sync-sources' phandles in the pin's firmware node and
> + * registers each declared pairing.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_dpll_ref_sync_pair_register(struct zl3073x_dpll_pin *pin)
> +{
> +	struct zl3073x_dev *zldev = pin->dpll->dev;
> +	struct fwnode_handle *fwnode;
> +	struct dpll_pin *sync_pin;
> +	dpll_tracker tracker;
> +	int n, rc;
> +
> +	for (n = 0; ; n++) {
> +		/* Get n'th ref-sync source */
> +		fwnode = fwnode_find_reference(pin->fwnode, "ref-sync-sources",
> +					       n);
> +		if (IS_ERR(fwnode)) {
> +			rc = PTR_ERR(fwnode);
> +			break;
> +		}
> +
> +		/* Find associated dpll pin */
> +		sync_pin = fwnode_dpll_pin_find(fwnode, &tracker);
> +		fwnode_handle_put(fwnode);
> +		if (!sync_pin) {
> +			dev_warn(zldev->dev, "%s: ref-sync source %d not found",
> +				 pin->label, n);
> +			continue;
> +		}
> +
> +		/* Register new ref-sync pair */
> +		rc = dpll_pin_ref_sync_pair_add(pin->dpll_pin, sync_pin);
> +		dpll_pin_put(sync_pin, &tracker);
> +
> +		/* -EBUSY means pairing already exists from another DPLL's
> +		 * registration.
> +		 */
> +		if (rc && rc != -EBUSY) {
> +			dev_err(zldev->dev,
> +				"%s: failed to add ref-sync source %d: %pe",
> +				pin->label, n, ERR_PTR(rc));
> +			break;
> +		}
> +	}
> +
> +	return rc != -ENOENT ? rc : 0;
> +}
> +
> +/**
> + * zl3073x_dpll_ref_sync_pairs_register - register ref_sync pairs for a DPLL
> + * @zldpll: pointer to zl3073x_dpll structure
> + *
> + * Iterates all registered input pins of the given DPLL and establishes
> + * ref_sync pairings declared by 'ref-sync-sources' phandles in the
> + * device tree.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int
> +zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
> +{
> +	struct zl3073x_dpll_pin *pin;
> +	int rc;
> +
> +	list_for_each_entry(pin, &zldpll->pins, list) {
> +		if (!zl3073x_dpll_is_input_pin(pin) || !pin->fwnode)
> +			continue;
> +
> +		rc = zl3073x_dpll_ref_sync_pair_register(pin);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * zl3073x_dpll_register - register DPLL device and all its pins
>    * @zldpll: pointer to zl3073x_dpll structure
> @@ -1758,6 +1956,13 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
>   		return rc;
>   	}
>   
> +	rc = zl3073x_dpll_ref_sync_pairs_register(zldpll);
> +	if (rc) {
> +		zl3073x_dpll_pins_unregister(zldpll);
> +		zl3073x_dpll_device_unregister(zldpll);
> +		return rc;
> +	}
> +
>   	return 0;
>   }
>   

LGTM.


Reviewed-by: Petr Oros <poros@redhat.com>


