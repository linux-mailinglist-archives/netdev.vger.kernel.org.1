Return-Path: <netdev+bounces-289560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLDwBpSkDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:57:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158B5835B0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8398E302D112
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1353FC5D9;
	Tue, 19 May 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZS7gD+3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDEhzDo8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E73EA967
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213445; cv=none; b=UlrAT81FAvFtHmj1jaxlplh1N+bWe5lhxAtmaFS112fzDXy8BSUECQQXbHQBcetTkFpIOfWMuFTJml3sOd2ABMsHH7b4lZ5dX6tZzldHrmLoP4dozOL01JObUMpAu6hI+fzMFbSwALsFLf9XtXDgwhV4SKH37+7OaZ/Zr7jSoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213445; c=relaxed/simple;
	bh=vkoynDGSpVeSVFbV9f3qS3Nx1JQAP0/c6gzLPHB5RWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsFgkTqhpAEdbROtybV/2LrhmURyVyAdctH9rn1KxE0JH/wCPdbtv+2Qqv6F+iFg7dKWKZ5FTRZELw9kGpk1RNWa9FXCGy97E5BwfPy7cbqYcrFQnYgFtvy+XOlS46ZvxU71nvdu+rmYkUoAUk/BmOWMgPb5GTY7oTwQ62XThWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZS7gD+3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDEhzDo8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779213440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6nBBqpqHHTvoMuGKJr2dd32xf7ULOt3K91E6qF6iQ=;
	b=JZS7gD+3bHpORUgVSsdQwqhGOvG2L3ZE4zTvg/AIml4G7td5b6wXO2vcBTLMKsuJM7/63x
	YDQN8SOIZOi0UvLCz3vDMf/hxh1zOqd83rX56zSA1Fkf1oQziW9M9J8esaAW8UXjYIE8mf
	UUapsOLUVmZNbiNgrHQqor7We+U7BOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-hV6aKMSyM-CLe5-RPhGtFg-1; Tue, 19 May 2026 13:57:19 -0400
X-MC-Unique: hV6aKMSyM-CLe5-RPhGtFg-1
X-Mimecast-MFC-AGG-ID: hV6aKMSyM-CLe5-RPhGtFg_1779213438
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so3308101f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779213438; x=1779818238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC6nBBqpqHHTvoMuGKJr2dd32xf7ULOt3K91E6qF6iQ=;
        b=EDEhzDo8uMNCeGekernNQ+CgY22RIutDVZN9FHCvW8f6GbDx9ZiRj5X3PQj4njwx85
         0zaTEGPgCi8lh8BRnZp2OgwbTcNXz5P5sw0uKO4Oq3QDio4KmyShvc3xeXqR6pOVC6EE
         Wueb1prAMix3r3Ho4XJfDCLMlzKlTCU1ZR0T/r+0COuXPY4bKn6FkH19jOZ761UFEQR1
         QlGkqcNR9qo1c0ix0ZTyTiDe+SnVXb9BaEhI3ZXkvK9fwQXvHUbw86mKVa3DPs2F2P2q
         9CrkYAKEOF+SrlFqadjSTqz9qWDUTfGrYiyjFRA5ORsBx77BEoz4ZMkExzUpCZ47g2yn
         0jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779213438; x=1779818238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC6nBBqpqHHTvoMuGKJr2dd32xf7ULOt3K91E6qF6iQ=;
        b=gnpzClyVAXoA7tKwP4CKbKszgaXko6tlE44BytSbjGjbdaVNqAHuSMZV6AwLYJctLS
         +HRf4Q+o/ENtf6ZmYbuPOymDkJFLjefKJzrO+8cvTuJrWkvGfKe6xbV2eGCzXXLt8CxX
         G55abHTYnYsesAvbD9VNEgrEm5XR8pKZXaTXkglQRHUuxWaKpUfxaZT7fQz2qnJ73kBa
         mfJ7yncEL4iiFtlQYMkp6kIbzSdcqArndiyKKpk0jqMXIDJT0vAC3jsGOmH3lZAkC2ic
         Rys6g0l3QeKyZEgU8QoLLHDDh9D9CfRqF8LApZ1Kt0w3H8OBhPQwWMj4rE4hUyw+oJZR
         F6RQ==
X-Forwarded-Encrypted: i=1; AFNElJ94vq5zAFhaarRsWLzVJ7O8noFY02NOk6+lsjnETjZcphWLAs58Eqx5WVIXWGvEOfSkOlVoeRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGdeCT5BrbBoo7v5u9hKhxtfAdy4n2vWkn0HQbQxhwP9g9Y4k
	0nrC0PMEFTPYn6imsryGIeVqy7LygbDs2ImWJouOpqXU0Lhcm9ioEct/HQAIo2v9owz7yL1VyTe
	NXKP0671NAPEe5FJ5lwgR+Lywq18Pe8v9Iol/dKUXx5lO9763MyFNfLFWTQ==
X-Gm-Gg: Acq92OG4Sbh8RphDJbIssWsKCWGfyzVYY48aAwRmp7/7GMyjOh416TBypB1rgrmMTHc
	dNS6cN7eUnWngxAvaenAezqY5QAdHRrGHyUFfnq2LorCdjB3KX35KY+AdmaBsxsHWL4PBGOQcV9
	pnkXWVpC10MVkO3BthORu7XiijdTm2QZXKnZk54HibDfMRrFWMhudaIXCuEph3sf6PqRRkeIZsU
	1cMKmTF6+7lkOmZYGmHQgeAF7l5wyE9+6xGE8w1AsvoYT+Cdp0ICX/XUnaJCMIoJtfZCH8Y02l9
	YXXQbg3Vvmo0di8siUj1JRk0gjjpm9hr58qOj8N83eVQQ0xaSOKJkkx1IQhz+iTobfyvwdhqmbk
	AksUItjW4eijn0G4wKZ4e
X-Received: by 2002:a05:600c:3f1b:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48fe60e7fa1mr321684665e9.13.1779213437798;
        Tue, 19 May 2026 10:57:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3f1b:b0:489:1c5f:3a9e with SMTP id 5b1f17b1804b1-48fe60e7fa1mr321684365e9.13.1779213437216;
        Tue, 19 May 2026 10:57:17 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm50321831f8f.25.2026.05.19.10.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 10:57:15 -0700 (PDT)
Message-ID: <73d41358-8712-4cc6-bca0-ea972ba1bafa@redhat.com>
Date: Tue, 19 May 2026 19:57:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add NCO virtual input pin
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260516175744.26749-1-ivecera@redhat.com>
 <20260516175744.26749-3-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260516175744.26749-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-289560-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6158B5835B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/16/26 19:57, Ivan Vecera wrote:
> Add a virtual NCO (Numerically Controlled Oscillator) input pin that
> lets userspace switch a DPLL channel into NCO mode. A single NCO pin
> is shared across all DPLL channels — each channel has its own
> independent connection state. The NCO pin is registered with the new
> DPLL_PIN_TYPE_INT_NCO type and reports DPLL_PIN_STATE_CONNECTED /
> DPLL_PIN_OPERSTATE_ACTIVE when the channel is in NCO mode.
>
> At NCO pin registration the following bits are configured in
> dpll_ctrl_x:
>    - nco_auto_read: auto-capture tracking offset on NCO entry
>    - tod_step_reset: apply negated ToD step accumulator on NCO exit
>    - tie_clear: PPS DPLLs set 1 to re-align outputs on NCO exit,
>                 EEC DPLLs keep 0 to prevent an unwanted TIE write
>
> On NCO entry the df_offset captured by nco_auto_read is read from
> the register. The nco_auto_read populates df_offset before the mode
> switch completes. The value is static for the duration of NCO mode
> and serves as the FFO snapshot reported to userspace.
>
> Disconnecting the NCO pin switches to freerun rather than holdover
> because holdover averaging is not updated during NCO mode.
>
> Input reference pins are now always registered regardless of the
> initial DPLL mode. Previously they were skipped when the DPLL was
> in NCO mode, but the NCO pin provides the proper mechanism for
> mode transitions.
>
> ---
> v2:
>    - Configure nco_auto_read, tod_step_reset and tie_clear once at
>      NCO pin registration since these are persistent R/W bits.
>      In v1 nco_auto_read was set at registration, while tod_step_reset
>      and tie_clear were set on each NCO exit path.
>    - Add zl3073x_chan_nco_mode_set() helper that writes mode_refsel
>      directly and reads df_offset from the register without the
>      DF_READ semaphore protocol. nco_auto_read populates df_offset before
>      the mode switch completes (confirmed by HW testing). In v1 the full
>      DF_READ semaphore protocol with zl3073x_chan_state_update() was used.
>    - Zero df_offset on read failure instead of keeping stale value.
>    - Serialize zl3073x_chan_state_update() and
>      zl3073x_chan_nco_mode_set() with multiop_lock to prevent
>      concurrent df_offset access from the periodic worker.
>    - Gate df_offset read in zl3073x_chan_state_update() on LOCK state
>      instead of skipping NCO channels in chan_states_update(). This
>      keeps mon_status and refsel_status fresh in all modes.
>    - Send __dpll_pin_change_ntf() for the NCO pin when leaving NCO
>      mode via mode_set() or input pin connect, since the periodic
>      worker skips the NCO pin.
>    - Add comments explaining the inverted sign convention of the
>      dpll_df_offset register.
>    - Document why NCO disconnect selects freerun over holdover, the
>      shared NCO pin design, and the input pin registration change.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c |  68 ++++++++-
>   drivers/dpll/zl3073x/chan.h |  25 ++++
>   drivers/dpll/zl3073x/dpll.c | 277 +++++++++++++++++++++++++++++++-----
>   drivers/dpll/zl3073x/dpll.h |   2 +
>   drivers/dpll/zl3073x/regs.h |   7 +
>   5 files changed, 339 insertions(+), 40 deletions(-)
>
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
>   	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
>   				  ZL_DPLL_DF_READ_SEM);
>   	if (rc)
> @@ -56,6 +64,50 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   	return 0;
>   }
>   
> +/**
> + * zl3073x_chan_nco_mode_set - switch DPLL channel to NCO mode
> + * @zldev: pointer to zl3073x_dev structure
> + * @index: DPLL channel index
> + *
> + * Switches the channel to NCO mode, waits for the hardware to
> + * auto-capture the tracking offset via nco_auto_read, then reads
> + * the captured df_offset directly from the register.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index)
> +{
> +	struct zl3073x_chan *chan = &zldev->chan[index];
> +	u8 mode_refsel;
> +	u64 val;
> +	int rc;
> +
> +	/* Serialize with zl3073x_chan_state_update() which also
> +	 * reads chan->df_offset from the same register.
> +	 */
> +	guard(mutex)(&zldev->multiop_lock);
> +
> +	mode_refsel = chan->mode_refsel;
> +	FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_MODE, &mode_refsel,
> +		     ZL_DPLL_MODE_REFSEL_MODE_NCO);
> +
> +	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
> +			      mode_refsel);
> +	if (rc)
> +		return rc;
> +
> +	chan->mode_refsel = mode_refsel;
> +
> +	/* Best-effort read of df_offset captured by nco_auto_read.
> +	 * Mode switch already succeeded, so don't propagate a
> +	 * df_offset read failure back to userspace.
> +	 */
> +	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_DF_OFFSET(index), &val);
> +	chan->df_offset = !rc ? sign_extend64(val, 47) : 0;
> +
> +	return 0;
> +}
> +
>   /**
>    * zl3073x_chan_state_fetch - fetch DPLL channel state from hardware
>    * @zldev: pointer to zl3073x_dev structure
> @@ -71,6 +123,10 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
>   	struct zl3073x_chan *chan = &zldev->chan[index];
>   	int rc, i;
>   
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_CTRL(index), &chan->ctrl);
> +	if (rc)
> +		return rc;
> +
>   	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
>   			     &chan->mode_refsel);
>   	if (rc)
> @@ -145,7 +201,15 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>   	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
>   		return 0;
>   
> -	/* Direct register write for mode_refsel */
> +	/* Direct register writes for ctrl and mode_refsel */
> +	if (dchan->ctrl != chan->ctrl) {
> +		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_CTRL(index),
> +				      chan->ctrl);
> +		if (rc)
> +			return rc;
> +		dchan->ctrl = chan->ctrl;
> +	}
> +
>   	if (dchan->mode_refsel != chan->mode_refsel) {
>   		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
>   				      chan->mode_refsel);
> diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
> index 4353809c69122..b9412d223f793 100644
> --- a/drivers/dpll/zl3073x/chan.h
> +++ b/drivers/dpll/zl3073x/chan.h
> @@ -13,6 +13,7 @@ struct zl3073x_dev;
>   
>   /**
>    * struct zl3073x_chan - DPLL channel state
> + * @ctrl: DPLL control register value
>    * @mode_refsel: mode and reference selection register value
>    * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
>    * @mon_status: monitor status register value
> @@ -21,6 +22,7 @@ struct zl3073x_dev;
>    */
>   struct zl3073x_chan {
>   	struct_group(cfg,
> +		u8	ctrl;
>   		u8	mode_refsel;
>   		u8	ref_prio[ZL3073X_NUM_REFS / 2];
>   	);
> @@ -38,6 +40,7 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>   			   const struct zl3073x_chan *chan);
>   
>   int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
> +int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index);
>   
>   /**
>    * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
> @@ -152,6 +155,28 @@ static inline u8 zl3073x_chan_lock_state_get(const struct zl3073x_chan *chan)
>   	return FIELD_GET(ZL_DPLL_MON_STATUS_STATE, chan->mon_status);
>   }
>   
> +/**
> + * zl3073x_chan_mode_is_auto - check if channel is in automatic mode
> + * @chan: pointer to channel state
> + *
> + * Return: true if channel is in automatic mode, false otherwise
> + */
> +static inline bool zl3073x_chan_mode_is_auto(const struct zl3073x_chan *chan)
> +{
> +	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO;
> +}
> +
> +/**
> + * zl3073x_chan_mode_is_nco - check if channel is in NCO mode
> + * @chan: pointer to channel state
> + *
> + * Return: true if channel is in NCO mode, false otherwise
> + */
> +static inline bool zl3073x_chan_mode_is_nco(const struct zl3073x_chan *chan)
> +{
> +	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_NCO;
> +}
> +
>   /**
>    * zl3073x_chan_is_ho_ready - check if holdover is ready
>    * @chan: pointer to channel state
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index cff85cdb9d0e5..2efefb1d7e224 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -81,6 +81,18 @@ zl3073x_dpll_is_input_pin(struct zl3073x_dpll_pin *pin)
>   	return pin->dir == DPLL_PIN_DIRECTION_INPUT;
>   }
>   
> +/**
> + * zl3073x_dpll_is_nco_pin - check if the pin is a virtual NCO pin
> + * @pin: pin to check
> + *
> + * Return: true if pin is a virtual NCO pin, false otherwise.
> + */
> +static bool
> +zl3073x_dpll_is_nco_pin(struct zl3073x_dpll_pin *pin)
> +{
> +	return pin->id == ZL3073X_NCO_PIN_ID;
> +}
> +
>   /**
>    * zl3073x_dpll_is_p_pin - check if the pin is P-pin
>    * @pin: pin to check
> @@ -120,6 +132,19 @@ zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
>   	return NULL;
>   }
>   
> +static struct zl3073x_dpll_pin *
> +zl3073x_dpll_nco_pin_get(struct zl3073x_dpll *zldpll)
> +{
> +	struct zl3073x_dpll_pin *pin;
> +
> +	list_for_each_entry(pin, &zldpll->pins, list) {
> +		if (zl3073x_dpll_is_nco_pin(pin))
> +			return pin;
> +	}
> +
> +	return NULL;
> +}
> +
>   static int
>   zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
>   				 void *pin_priv,
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
> @@ -676,6 +706,12 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
>   	if (rc)
>   		return rc;
>   
> +	/* If leaving NCO mode, notify userspace about the NCO pin
> +	 * state change — the periodic worker skips the NCO pin.
> +	 */
> +	if (nco_pin)
> +		__dpll_pin_change_ntf(nco_pin->dpll_pin);
> +
>   	return 0;
>   invalid_state:
>   	NL_SET_ERR_MSG_MOD(extack, "Invalid pin state for this device mode");
> @@ -989,6 +1025,114 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
>   	return 0;
>   }
>   
> +static int
> +zl3073x_dpll_nco_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
> +					   void *pin_priv,
> +					   const struct dpll_device *dpll,
> +					   void *dpll_priv,
> +					   enum dpll_pin_operstate *operstate,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	const struct zl3073x_chan *chan;
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (zl3073x_chan_mode_is_nco(chan))
> +		*operstate = DPLL_PIN_OPERSTATE_ACTIVE;
> +	else
> +		*operstate = DPLL_PIN_OPERSTATE_STANDBY;
> +
> +	return 0;
> +}
> +
> +static int
> +zl3073x_dpll_nco_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
> +				       void *pin_priv,
> +				       const struct dpll_device *dpll,
> +				       void *dpll_priv,
> +				       enum dpll_pin_state *state,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	const struct zl3073x_chan *chan;
> +
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	if (zl3073x_chan_mode_is_nco(chan))
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +
> +	return 0;
> +}
> +
> +static int
> +zl3073x_dpll_nco_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
> +				       void *pin_priv,
> +				       const struct dpll_device *dpll,
> +				       void *dpll_priv,
> +				       enum dpll_pin_state state,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_chan chan;
> +	int rc;
> +
> +	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +
> +	switch (state) {
> +	case DPLL_PIN_STATE_CONNECTED:
> +		/* Already in NCO mode, nothing to do */
> +		if (zl3073x_chan_mode_is_nco(&chan))
> +			return 0;
> +		/* NCO is only allowed in manual mode */
> +		if (zl3073x_chan_mode_is_auto(&chan)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "NCO pin cannot be connected in automatic mode");
> +			return -EINVAL;
> +		}
> +		rc = zl3073x_chan_nco_mode_set(zldpll->dev, zldpll->id);
> +		break;
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		/* Not in NCO mode, nothing to do */
> +		if (!zl3073x_chan_mode_is_nco(&chan))
> +			return 0;
> +		/* Switch to freerun - holdover averaging was not
> +		 * updated during NCO mode.
> +		 */
> +		zl3073x_chan_mode_set(&chan,
> +				      ZL_DPLL_MODE_REFSEL_MODE_FREERUN);
> +		rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
> +		break;
> +	default:
> +		NL_SET_ERR_MSG(extack, "invalid pin state for NCO pin");
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
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
> +
>   static int
>   zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
>   		      s32 *temp, struct netlink_ext_ack *extack)
> @@ -1057,19 +1201,7 @@ zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
>   				 void *dpll_priv, unsigned long *modes,
>   				 struct netlink_ext_ack *extack)
>   {
> -	struct zl3073x_dpll *zldpll = dpll_priv;
> -	const struct zl3073x_chan *chan;
> -
> -	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> -
> -	/* We support switching between automatic and manual mode, except in
> -	 * a case where the DPLL channel is configured to run in NCO mode.
> -	 * In this case, report only the manual mode to which the NCO is mapped
> -	 * as the only supported one.
> -	 */
> -	if (zl3073x_chan_mode_get(chan) != ZL_DPLL_MODE_REFSEL_MODE_NCO)
> -		__set_bit(DPLL_MODE_AUTOMATIC, modes);
> -
> +	__set_bit(DPLL_MODE_AUTOMATIC, modes);
>   	__set_bit(DPLL_MODE_MANUAL, modes);
>   
>   	return 0;
> @@ -1163,6 +1295,7 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
>   		      enum dpll_mode mode, struct netlink_ext_ack *extack)
>   {
>   	struct zl3073x_dpll *zldpll = dpll_priv;
> +	struct zl3073x_dpll_pin *nco_pin = NULL;
>   	struct zl3073x_chan chan;
>   	u8 hw_mode, ref;
>   	int rc;
> @@ -1186,6 +1319,9 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
>   		else
>   			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
>   	} else {
> +		if (zl3073x_chan_mode_is_nco(&chan))
> +			nco_pin = zl3073x_dpll_nco_pin_get(zldpll);
> +
>   		/* We are switching from manual to automatic mode:
>   		 * - if there is a valid reference selected then ensure that
>   		 *   it is selectable after switch to automatic mode
> @@ -1217,6 +1353,12 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
>   		return rc;
>   	}
>   
> +	/* If leaving NCO mode, notify userspace about the NCO pin
> +	 * state change — the periodic worker skips the NCO pin.
> +	 */
> +	if (nco_pin)
> +		__dpll_pin_change_ntf(nco_pin->dpll_pin);
> +
>   	return 0;
>   }
>   
> @@ -1310,6 +1452,15 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
>   	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
>   };
>   
> +static const struct dpll_pin_ops zl3073x_dpll_nco_pin_ops = {
> +	.supported_ffo = BIT(DPLL_FFO_PIN_DEVICE),
> +	.direction_get = zl3073x_dpll_pin_direction_get,
> +	.ffo_get = zl3073x_dpll_nco_pin_ffo_get,
> +	.operstate_on_dpll_get = zl3073x_dpll_nco_pin_operstate_on_dpll_get,
> +	.state_on_dpll_get = zl3073x_dpll_nco_pin_state_on_dpll_get,
> +	.state_on_dpll_set = zl3073x_dpll_nco_pin_state_on_dpll_set,
> +};
> +
>   static const struct dpll_device_ops zl3073x_dpll_device_ops = {
>   	.lock_status_get = zl3073x_dpll_lock_status_get,
>   	.mode_get = zl3073x_dpll_mode_get,
> @@ -1457,7 +1608,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
>   
>   	WARN(!pin->dpll_pin, "DPLL pin is not registered\n");
>   
> -	if (zl3073x_dpll_is_input_pin(pin))
> +	if (zl3073x_dpll_is_nco_pin(pin))
> +		ops = &zl3073x_dpll_nco_pin_ops;
> +	else if (zl3073x_dpll_is_input_pin(pin))
>   		ops = &zl3073x_dpll_input_pin_ops;
>   	else
>   		ops = &zl3073x_dpll_output_pin_ops;
> @@ -1510,20 +1663,13 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
>   				enum dpll_pin_direction dir, u8 index)
>   {
>   	struct zl3073x_dev *zldev = zldpll->dev;
> -	const struct zl3073x_chan *chan;
>   	bool is_diff, is_enabled;
>   	const char *name;
>   
> -	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> -
>   	if (dir == DPLL_PIN_DIRECTION_INPUT) {
>   		u8 ref_id = zl3073x_input_pin_ref_get(index);
>   		const struct zl3073x_ref *ref;
>   
> -		/* Skip the pin if the DPLL is running in NCO mode */
> -		if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_NCO)
> -			return false;
> -
>   		name = "REF";
>   		ref = zl3073x_ref_state_get(zldev, ref_id);
>   		is_diff = zl3073x_ref_is_diff(ref);
> @@ -1564,6 +1710,64 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
>   	return true;
>   }
>   
> +static const struct dpll_pin_properties zl3073x_dpll_nco_pin_props = {
> +	.type = DPLL_PIN_TYPE_INT_NCO,
> +	.package_label = "NCO",
> +	.capabilities = DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE,
> +};
> +
> +static int
> +zl3073x_dpll_nco_pin_register(struct zl3073x_dpll *zldpll)
> +{
> +	struct zl3073x_dpll_pin *pin;
> +	struct zl3073x_chan chan;
> +	int rc;
> +
> +	/* Configure ctrl bits for NCO operation:
> +	 * - nco_auto_read: auto-capture tracking offset on NCO entry
> +	 * - tod_step_reset: apply negated ToD step on NCO exit
> +	 * - tie_clear: PPS DPLLs re-align outputs on NCO exit
> +	 */
> +	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	FIELD_MODIFY(ZL_DPLL_CTRL_NCO_AUTO_READ, &chan.ctrl, 1);
> +	FIELD_MODIFY(ZL_DPLL_CTRL_TOD_STEP_RST, &chan.ctrl, 1);
> +	FIELD_MODIFY(ZL_DPLL_CTRL_TIE_CLEAR, &chan.ctrl,
> +		     zldpll->type == DPLL_TYPE_PPS ? 1 : 0);
> +	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
> +	if (rc)
> +		return rc;
> +
> +	pin = zl3073x_dpll_pin_alloc(zldpll, DPLL_PIN_DIRECTION_INPUT,
> +				     ZL3073X_NCO_PIN_ID);
> +	if (IS_ERR(pin))
> +		return PTR_ERR(pin);
> +
> +	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, ZL3073X_NCO_PIN_ID,
> +				     THIS_MODULE, &zl3073x_dpll_nco_pin_props,
> +				     &pin->tracker);
> +	if (IS_ERR(pin->dpll_pin)) {
> +		rc = PTR_ERR(pin->dpll_pin);
> +		goto err_pin_get;
> +	}
> +
> +	rc = dpll_pin_register(zldpll->dpll_dev, pin->dpll_pin,
> +			       &zl3073x_dpll_nco_pin_ops, pin);
> +	if (rc)
> +		goto err_register;
> +
> +	list_add(&pin->list, &zldpll->pins);
> +
> +	return 0;
> +
> +err_register:
> +	dpll_pin_put(pin->dpll_pin, &pin->tracker);
> +err_pin_get:
> +	pin->dpll_pin = NULL;
> +	kfree(pin);
> +
> +	return rc;
> +}
> +
>   /**
>    * zl3073x_dpll_pins_register - register all registerable DPLL pins
>    * @zldpll: pointer to zl3073x_dpll structure
> @@ -1609,6 +1813,11 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
>   		list_add(&pin->list, &zldpll->pins);
>   	}
>   
> +	/* Register NCO virtual input pin */
> +	rc = zl3073x_dpll_nco_pin_register(zldpll);
> +	if (rc)
> +		goto error;
> +
>   	return 0;
>   
>   error:
> @@ -1644,8 +1853,8 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
>   		return rc;
>   	}
>   
> -	rc = dpll_device_register(zldpll->dpll_dev,
> -				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
> +	zldpll->type = zl3073x_prop_dpll_type_get(zldev, zldpll->id);
> +	rc = dpll_device_register(zldpll->dpll_dev, zldpll->type,
>   				  &zldpll->ops, zldpll);
>   	if (rc) {
>   		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
> @@ -1752,6 +1961,10 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
>   		return false;
>   
>   	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	/* df_offset register has inverted sign, but we report FFO as
> +	 * pin-vs-DPLL (not DPLL-vs-reference), so the two inversions
> +	 * cancel out: ppt = df * 5^12 / 2^36
> +	 */
>   	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
>   			      244140625, 36);
>   
> @@ -1815,10 +2028,8 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   	struct zl3073x_dev *zldev = zldpll->dev;
>   	enum dpll_lock_status lock_status;
>   	struct device *dev = zldev->dev;
> -	const struct zl3073x_chan *chan;
>   	struct zl3073x_dpll_pin *pin;
>   	int rc;
> -	u8 mode;
>   
>   	zldpll->check_count++;
>   
> @@ -1837,15 +2048,6 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   		dpll_device_change_ntf(zldpll->dpll_dev);
>   	}
>   
> -	/* Input pin monitoring does make sense only in automatic
> -	 * or forced reference modes.
> -	 */
> -	chan = zl3073x_chan_state_get(zldev, zldpll->id);
> -	mode = zl3073x_chan_mode_get(chan);
> -	if (mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
> -	    mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
> -		return;
> -
>   	/* Update phase offset latch registers for this DPLL if the phase
>   	 * offset monitor feature is enabled.
>   	 */
> @@ -1863,10 +2065,9 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>   		enum dpll_pin_operstate operstate;
>   		bool pin_changed = false;
>   
> -		/* Output pins change checks are not necessary because output
> -		 * states are constant.
> -		 */
> -		if (!zl3073x_dpll_is_input_pin(pin))
> +		/* Only physical input pins need monitoring */
> +		if (!zl3073x_dpll_is_input_pin(pin) ||
> +		    zl3073x_dpll_is_nco_pin(pin))
>   			continue;
>   
>   		rc = zl3073x_dpll_ref_operstate_get(pin, &operstate);
> diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
> index 434c32a7db123..0920e4d31ab35 100644
> --- a/drivers/dpll/zl3073x/dpll.h
> +++ b/drivers/dpll/zl3073x/dpll.h
> @@ -19,6 +19,7 @@
>    * @ops: DPLL device operations for this instance
>    * @dpll_dev: pointer to registered DPLL device
>    * @tracker: tracking object for the acquired reference
> + * @type: DPLL type (PPS or EEC)
>    * @lock_status: last saved DPLL lock status
>    * @pins: list of pins
>    * @change_work: device change notification work
> @@ -33,6 +34,7 @@ struct zl3073x_dpll {
>   	struct dpll_device_ops		ops;
>   	struct dpll_device		*dpll_dev;
>   	dpll_tracker			tracker;
> +	enum dpll_type			type;
>   	enum dpll_lock_status		lock_status;
>   	struct list_head		pins;
>   	struct work_struct		change_work;
> diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
> index 9578f00095282..8f1dd3a2ac214 100644
> --- a/drivers/dpll/zl3073x/regs.h
> +++ b/drivers/dpll/zl3073x/regs.h
> @@ -17,6 +17,7 @@
>   #define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
>   #define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
>   				 ZL3073X_NUM_OUTPUT_PINS)
> +#define ZL3073X_NCO_PIN_ID	ZL3073X_NUM_PINS
>   
>   /*
>    * Register address structure:
> @@ -164,6 +165,12 @@
>   #define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
>   #define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
>   
> +#define ZL_REG_DPLL_CTRL(_idx)						\
> +	ZL_REG_IDX(_idx, 5, 0x05, 1, ZL3073X_MAX_CHANNELS, 4)
> +#define ZL_DPLL_CTRL_TIE_CLEAR			BIT(0)
> +#define ZL_DPLL_CTRL_TOD_STEP_RST		BIT(2)
> +#define ZL_DPLL_CTRL_NCO_AUTO_READ		BIT(7)
> +
>   #define ZL_REG_DPLL_DF_READ(_idx)					\
>   	ZL_REG_IDX(_idx, 5, 0x28, 1, ZL3073X_MAX_CHANNELS, 1)
>   #define ZL_DPLL_DF_READ_SEM			BIT(4)

Reviewed-by: Petr Oros <poros@redhat.com>



