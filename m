Return-Path: <netdev+bounces-290979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ4tOYX0EGrvfwYAu9opvQ
	(envelope-from <netdev+bounces-290979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3615BBFE6
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5145E30131CE
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97F1A6827;
	Sat, 23 May 2026 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut23YJmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AE175A8B;
	Sat, 23 May 2026 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496066; cv=none; b=ip8a3DZdycwZv8XslUI+8rnDIGBzAbiGaPsPP+trCT4Nci3fVehy1/NcQqq7kVP5jXRnWVB4ZvJ3qU04pHhySuKwEYF1+Y9ScL1gZWVB1W1o2wIOspkGgyKFiKVqr5KZeVSth97qC0finxW+FBkcUju852AuEeOPDV3kqukQfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496066; c=relaxed/simple;
	bh=SZzLTbJtK5K+t/rN+g7ArCuvDbjb5XsteUZg3t3JUmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JylxwoLIF0LgACZmFTbH8NMyjZ2MD+cbZ4gr5IDBsyCWY9Vk7SOZy+7NgnOddeX8jEqBz/DFwG7DuvMcTxIs15n33ZVX1zd7kqk0yz48lcZK8tWoOnfXnh0SjGlG13WkCY7mpZ3zoRct1/Kb/YhJcGoroNXScjCNoSWCsmVQ1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut23YJmY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9BE1F000E9;
	Sat, 23 May 2026 00:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496065;
	bh=bMRUNIb5a/ZalbsvuELB/RVRSLrozN9NGhglbVjJya4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ut23YJmYux+CGL4K0cZhBIr0p+hDfyyxiTIfe9B7/BVaLd2ZUAIdNTMK77FYLOYL7
	 LSywi0YI3xcY8aj591dRB8pwv1/502H0ediUQNXEAkOZOMik5OCiM7ftIPVutf8Y9i
	 ZoIL0QAu4SnWpSRAIdZHR8TxuaDmZmpoF4teKqrWyhqfuamHV2DFo6XI/vWvvEfN5/
	 bmeYiLs/Jk8aN5ay0wiXlTpXtDmImecFd2YcdYrBP7WCr0XWkg993m5GbXjRO12PB7
	 i8sGmJqP9Yemb5GYOvIUSdz/jZ4SkM23Sqrpo8U+NiCeo31+x31Au/rbwinf/+N0NC
	 TLEI7dTVzCIZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	poros@redhat.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	jiri@resnulli.us,
	mschmidt@redhat.com,
	pabeni@redhat.com,
	pvaanane@redhat.com,
	Prathosh.Satish@microchip.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] dpll: zl3073x: add NCO virtual input pin
Date: Fri, 22 May 2026 17:27:42 -0700
Message-ID: <20260523002742.1766902-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521074220.432590-3-ivecera@redhat.com>
References: <20260521074220.432590-3-ivecera@redhat.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,intel.com,davemloft.net,gmail.com,google.com,resnulli.us,microchip.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-290979-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F3615BBFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "I think the report / question about the SEM wasn't asked
on v2?"
---
dpll: zl3073x: add NCO virtual input pin

This change adds a virtual NCO input pin that lets userspace switch a
DPLL channel into NCO mode, and registers it with the new
DPLL_PIN_TYPE_INT_NCO type. It also rearranges chan->df_offset
handling so it is only read when the DPLL is locked, and adds a
ZL_REG_DPLL_CTRL register cache plus state_set support.

> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 2fe3c3da84bb..f5d6c7917e57 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -21,6 +21,11 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>  	u64 val;
>  	int rc;
>  
> +	/* Serialize with zl3073x_chan_nco_mode_set() which also
> +	 * modifies chan->mode_refsel and chan->df_offset.
> +	 */
> +	guard(mutex)(&zldev->multiop_lock);
> +
>  	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(index),
>  			     &chan->mon_status);
>  	if (rc)
> @@ -31,7 +36,10 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>  	if (rc)
>  		return rc;
>  
> -	/* Read df_offset vs tracked reference */
> +	/* Read df_offset only when locked to a reference */
> +	if (zl3073x_chan_lock_state_get(chan) != ZL_DPLL_MON_STATUS_STATE_LOCK)
> +		return 0;
> +

[Medium]
With this early return, when the DPLL boots in NCO mode and
zl3073x_chan_state_fetch() calls zl3073x_chan_state_update(),
chan->df_offset is left at the kzalloc-zeroed 0 (NCO mode is not
ZL_DPLL_MON_STATUS_STATE_LOCK).

zl3073x_dpll_nco_pin_register() then calls zl3073x_chan_state_set() to
update the ctrl bits, but state_set() never reads
ZL_REG_DPLL_DF_OFFSET. The only place that populates df_offset in NCO
mode is zl3073x_chan_nco_mode_set(), which only runs on a userspace
CONNECTED transition for the NCO pin.

Does this leave zl3073x_dpll_nco_pin_ffo_get() reporting ffo=0 forever
on a system that boots already in NCO mode, until userspace explicitly
disconnects and reconnects the NCO pin?

The commit message says:

    The value is static for the duration of NCO mode and serves as the
    FFO snapshot reported to userspace.

Does that statement still hold for the boot-in-NCO-mode case?

>  	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
>  				  ZL_DPLL_DF_READ_SEM);
>  	if (rc)
> @@ -56,6 +64,50 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>  	return 0;
>  }
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

[Medium]
Should this read use the same DF_READ semaphore handshake that
zl3073x_chan_state_update() uses for the same DF_OFFSET register?

The existing path does:

    poll ZL_DPLL_DF_READ_SEM == 0
    write ZL_DPLL_DF_READ_SEM | ZL_DPLL_DF_READ_REF_OFST
    poll ZL_DPLL_DF_READ_SEM == 0
    read ZL_REG_DPLL_DF_OFFSET

The new path writes MODE_REFSEL=NCO and then immediately reads the
48-bit DF_OFFSET register without any handshake.

The commit message says:

    The nco_auto_read populates df_offset before the mode switch
    completes so no delay is needed.

Is there a datasheet reference for this guarantee that could be cited
in the code comment?

If the auto-capture takes any non-zero amount of time after the
MODE_REFSEL bus write completes, can this read return stale REFLOCK-era
data or a torn value across the multi-byte 48-bit register? Combined
with the early return added to zl3073x_chan_state_update() for non-LOCK
states, would such a value persist for the entire NCO session?

[Medium]
There is also a question about reader synchronization for chan->df_offset.

zl3073x_chan_nco_mode_set() writes chan->df_offset under
zldev->multiop_lock. The periodic worker zl3073x_dpll_changes_check()
calls zl3073x_dpll_pin_ffo_check(), which reads chan->df_offset via
zl3073x_chan_df_offset_get() without holding multiop_lock:

static inline s64
zl3073x_chan_df_offset_get(const struct zl3073x_chan *chan)
{
    return chan->df_offset;
}

Consider: DPLL is in REFLOCK with a pin locked, the worker has finished
zl3073x_chan_state_update() (released multiop_lock), is iterating pins,
and enters ffo_check just as a netlink connect of the NCO pin calls
zl3073x_chan_nco_mode_set() and overwrites chan->df_offset.

drivers/dpll/zl3073x/Kconfig has no 64BIT dependency, so on 32-bit
builds the s64 store is two 32-bit stores. Can the worker observe a
torn value, push it through atomic64_xchg into pin->freq_offset, and
emit a dpll_pin_change_ntf with that value?

Pre-patch, df_offset was only written from state_update() in the worker
context, so writer and reader were sequential. Should the ffo_check
reader take multiop_lock, or chan->df_offset be promoted to an
atomic64_t/READ_ONCE pair?

> +
>  /**
>   * zl3073x_chan_state_fetch - fetch DPLL channel state from hardware
>   * @zldev: pointer to zl3073x_dev structure

[ ... ]

