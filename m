Return-Path: <netdev+bounces-284446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NA4LF8B+ml1HAMAu9opvQ
	(envelope-from <netdev+bounces-284446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:40:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68F4CF97E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 584853052CB2
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312C3E1220;
	Tue,  5 May 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtEvhuaQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grm+l1L4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954E37B020
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991678; cv=none; b=RGkeHtXJRk7eq7fiOVGPTFBM7E+u6x0mYDis24V2zdKund+i7udXuproFdaQfa61lHj715mVo7b1nhAKe6d+mdjopy4OQDRDhdk7ReFU19qH4Qu3XW49ae5pjqn3JRENwQoxUaB+5IfRv5VmER8imFf6vwtvwhXuyBvtUNJjuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991678; c=relaxed/simple;
	bh=xpYQ5xINCBW/rjAWaX5B54dA6JkSuP4NotlvSz1qqhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OK/wbrp/gC/fpo+psLuej6s9mafKseGTRgPD8GHb7vHeUfXhal8SRHxvMH3EG/RbBUdBUb8F/WGWPwgNfcG2z9GCVR/BAeNCyrh+8s9HOES3m8l9LC4WP2ghvKVoBHz8y5NJhihlGG/w5WfAoiRlmYHDggFqKYVoY1CV09lDe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtEvhuaQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grm+l1L4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777991672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UN/pWjbXr2kRlWqI8skizRwArcCRYfsBOnsQELDYJPE=;
	b=MtEvhuaQ8qd4I9LF5W1OZ7iFiCsoH5a5kubW+TTHJtlQdnW8gxvjQv7infBX72MPt55OAV
	IMPqBhUTaG4e6qCRT8vz1hCMo7M7oJPR51PcRhXorusoiTZvRqalufDqWMGFC9hRLbfSTN
	nkqueSxjQW/e/uT7nftRko5mwOAkY0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-sm-Y69rROtW1PgGaMBkglw-1; Tue, 05 May 2026 10:34:28 -0400
X-MC-Unique: sm-Y69rROtW1PgGaMBkglw-1
X-Mimecast-MFC-AGG-ID: sm-Y69rROtW1PgGaMBkglw_1777991667
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso67802505e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777991654; x=1778596454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UN/pWjbXr2kRlWqI8skizRwArcCRYfsBOnsQELDYJPE=;
        b=Grm+l1L4RESfnQktc5VrH0un6pBU0Ng0+YWJz5cD6Bu29MAEv+4FcxeBgpsnBiH6e0
         X+0jD6l8fzOELR1bmJLfKwiXgtRu0r8iE0Z/ybHszt33f8iyyKrXN12Ni7pxAxytWsoO
         W6KWhsNej/AERK3tgrUavrtD6ruU4o3wcxb0JIgwxKKLuxS5bP8W+CNkfkuz+YGiZagY
         zt4CFUkWjJCNyatrDNZIK2bBB4D3QbuF8XYSN5fET4IkB81ZcKHmNDLRUKHtHAhkdTLk
         2RFsPgI3zHD9Phn+F2+Q0MIqcBUR5hzKku8MTDIVjJbo9l75BS9pTyplwc93bHsXLF5x
         cz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991654; x=1778596454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN/pWjbXr2kRlWqI8skizRwArcCRYfsBOnsQELDYJPE=;
        b=A1P3BkXYEupWGunIgepRkVFHmnvV0g30dft0ILuoCJEh6aL8sq0rRcIpTfZaY3wYe5
         3F3SO1ZXLiYXa1fmkD+O4VEL8+VFQ0rIqjnAYcaP636Hg3vIc67Z3Wj6XOTZFGbnADTD
         qhGpKssDWAdFgpjChALar35bC1iWdPurUhJoPbah4KcGWmVwajnVZtXurc8q9RfHyHiX
         71+wcdYWNnr0S4zaUz3aU6TWKEbD3PL/09tCp3gmDqiurQrywc0umnTIAHuKbzzHrhWh
         jo3dYjIveu9jJRz8rRARty/ON19wiDDGrU7+/Pc7tOMfAHDtY6Aa2EwjVrEQA15n2XDS
         tqrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WZeNGW0ywB9zfZ7hwxksFCwloxyrmF05tPL9Oe8KdvAmKjp+P4HhPWHEVbKCDTwUmlynLAhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpI7xA5X/p8kI3VHPmAN12cQdDkoxB48qB6txkq4hTnFq2HxC
	XiGMTjlLhqr9I0atG21srprx8YturqQmDefoyxjn4e8ImDFNjIMAFXgdRev91OEjc9zOMnxAkxr
	fNligSiHszmZMC/b7V2iQD6INE/KXK3RtLkt0DM31pDJ3X2MWMISk7PYbJA==
X-Gm-Gg: AeBDieuj4pgEPI4hTLh5h3NSJpjObdVV7NyNWr1RP+UUPHP6Ug5MzmdfDFJI26m+2aW
	/1UHS8tKHtoSAyu2Ynf9VREKn/3nN8YD/XkaMQigIKbDxmt30BcNX9z43DN/UeJ3SfT/INYBJWd
	m2K3EbGhqp9+jW7XtfOcD+hUJ0UPQ7xGdpbYT10YJdlauCirV2oKc1FFA5/L8VCR+RQ8x4nQ+AK
	oE7vXNyw9j/DDF4jjoMElrk3AvMPNgqgmJwU+9KzxDgBNbbvhIGClXEc/QyqJ1Bo01KaX2yfc4q
	/Nre2kK/gv5odb9pxqgxncrWsFv2t4w1eU/ZyU71MNTMlUEcG4RDSxrqXvEQT9+Zd+rn6R3L+Re
	BY8WbPIjKbZcptWeyiRhhvhBnd2gh+L/jvLfTQ0N96A==
X-Received: by 2002:a05:600c:8b11:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48d186dc79bmr54076465e9.5.1777991653951;
        Tue, 05 May 2026 07:34:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b11:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48d186dc79bmr54075705e9.5.1777991653340;
        Tue, 05 May 2026 07:34:13 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149e8a09sm20837475e9.2.2026.05.05.07.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:34:11 -0700 (PDT)
Message-ID: <7af593ca-ce20-42ab-b76e-e09f4ec7c411@redhat.com>
Date: Tue, 5 May 2026 16:34:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] dpll: zl3073x: report FFO as DPLL vs
 input reference offset
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-3-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260504155340.411063-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C68F4CF97E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284446-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


On 5/4/26 17:53, Ivan Vecera wrote:
> Replace the per-reference frequency offset measurement (which was
> redundant with measured-frequency) with a direct read of the DPLL's
> delta frequency offset vs its tracked input reference.
>
> The new implementation uses the dpll_df_offset_x register with
> ref_ofst=1 via the dpll_df_read_x semaphore mechanism. This
> provides 2^-48 resolution (~3.5 fE) and reports the actual
> frequency difference between the DPLL and its active input.
>
> FFO is now reported only for the active input pin in the nested
> (pin vs parent DPLL) context. Top-level FFO returns -ENODATA.
>
> Rewrite ffo_check to compare the cached df_offset converted to PPT
> instead of using the old per-reference measurement. Remove the
> ref_ffo_update periodic measurement and the ref ffo field since
> they are no longer needed.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c | 31 +++++++++++++++++++++++--
>   drivers/dpll/zl3073x/chan.h | 14 ++++++++++++
>   drivers/dpll/zl3073x/core.c | 45 -------------------------------------
>   drivers/dpll/zl3073x/dpll.c | 34 ++++++++++++----------------
>   drivers/dpll/zl3073x/ref.h  | 14 ------------
>   drivers/dpll/zl3073x/regs.h | 15 +++++++++++++
>   6 files changed, 72 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 2f48ca2391494..2fe3c3da84bb5 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -18,6 +18,7 @@
>   int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   {
>   	struct zl3073x_chan *chan = &zldev->chan[index];
> +	u64 val;
>   	int rc;
>   
>   	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(index),
> @@ -25,8 +26,34 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   	if (rc)
>   		return rc;
>   
> -	return zl3073x_read_u8(zldev, ZL_REG_DPLL_REFSEL_STATUS(index),
> -			       &chan->refsel_status);
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REFSEL_STATUS(index),
> +			     &chan->refsel_status);
> +	if (rc)
> +		return rc;
> +
> +	/* Read df_offset vs tracked reference */
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
> +				  ZL_DPLL_DF_READ_SEM);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_DF_READ(index),
> +			      ZL_DPLL_DF_READ_SEM | ZL_DPLL_DF_READ_REF_OFST);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
> +				  ZL_DPLL_DF_READ_SEM);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_DF_OFFSET(index), &val);
> +	if (rc)
> +		return rc;
> +
> +	chan->df_offset = sign_extend64(val, 47);
> +
> +	return 0;
>   }
>   
>   /**
> diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
> index 481da2133202b..4353809c69122 100644
> --- a/drivers/dpll/zl3073x/chan.h
> +++ b/drivers/dpll/zl3073x/chan.h
> @@ -17,6 +17,7 @@ struct zl3073x_dev;
>    * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
>    * @mon_status: monitor status register value
>    * @refsel_status: reference selection status register value
> + * @df_offset: frequency offset vs tracked reference in 2^-48 steps
>    */
>   struct zl3073x_chan {
>   	struct_group(cfg,
> @@ -26,6 +27,7 @@ struct zl3073x_chan {
>   	struct_group(stat,
>   		u8	mon_status;
>   		u8	refsel_status;
> +		s64	df_offset;
>   	);
>   };
>   
> @@ -37,6 +39,18 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>   
>   int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
>   
> +/**
> + * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
> + * @chan: pointer to channel state
> + *
> + * Return: frequency offset in 2^-48 steps
> + */
> +static inline s64
> +zl3073x_chan_df_offset_get(const struct zl3073x_chan *chan)
> +{
> +	return chan->df_offset;
> +}
> +
>   /**
>    * zl3073x_chan_mode_get - get DPLL channel operating mode
>    * @chan: pointer to channel state
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 5f1e70f3e40a0..b3345060490db 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -704,44 +704,6 @@ zl3073x_ref_freq_meas_update(struct zl3073x_dev *zldev)
>   	return 0;
>   }
>   
> -/**
> - * zl3073x_ref_ffo_update - update reference fractional frequency offsets
> - * @zldev: pointer to zl3073x_dev structure
> - *
> - * The function asks device to latch the latest measured fractional
> - * frequency offset values, reads and stores them into the ref state.
> - *
> - * Return: 0 on success, <0 on error
> - */
> -static int
> -zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
> -{
> -	int i, rc;
> -
> -	rc = zl3073x_ref_freq_meas_latch(zldev,
> -					 ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF);
> -	if (rc)
> -		return rc;
> -
> -	/* Read DPLL-to-REFx frequency offset measurements */
> -	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
> -		s32 value;
> -
> -		/* Read value stored in units of 2^-32 signed */
> -		rc = zl3073x_read_u32(zldev, ZL_REG_REF_FREQ(i), &value);
> -		if (rc)
> -			return rc;
> -
> -		/* Convert to ppt
> -		 * ffo = (10^12 * value) / 2^32
> -		 * ffo = ( 5^12 * value) / 2^20
> -		 */
> -		zldev->ref[i].ffo = mul_s64_u64_shr(value, 244140625, 20);
> -	}
> -
> -	return 0;
> -}
> -
>   static void
>   zl3073x_dev_periodic_work(struct kthread_work *work)
>   {
> @@ -776,13 +738,6 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
>   		}
>   	}
>   
> -	/* Update references' fractional frequency offsets */
> -	rc = zl3073x_ref_ffo_update(zldev);
> -	if (rc)
> -		dev_warn(zldev->dev,
> -			 "Failed to update fractional frequency offsets: %pe\n",
> -			 ERR_PTR(rc));
> -
>   	list_for_each_entry(zldpll, &zldev->dplls, list)
>   		zl3073x_dpll_changes_check(zldpll);
>   
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index f2d430d1a8e7b..af50cd6200001 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -299,8 +299,12 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>   {
>   	struct zl3073x_dpll_pin *pin = pin_priv;
>   
> -	/* Only rx vs tx symbol rate FFO is supported */
> -	if (dpll)
> +	/* Only nested FFO (pin vs parent DPLL) is supported */
> +	if (!dpll)
> +		return -ENODATA;
> +
> +	/* Report FFO only for the active pin */
> +	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
>   		return -ENODATA;
>   
>   	*ffo = pin->freq_offset;
> @@ -1733,37 +1737,27 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
>   }
>   
>   /**
> - * zl3073x_dpll_pin_ffo_check - check for pin fractional frequency offset change
> + * zl3073x_dpll_pin_ffo_check - check for FFO change on active pin
>    * @pin: pin to check
>    *
> - * Check for the given pin's fractional frequency change.
> - *
> - * Return: true on fractional frequency offset change, false otherwise
> + * Return: true on change, false otherwise
>    */
>   static bool
>   zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
>   {
>   	struct zl3073x_dpll *zldpll = pin->dpll;
> -	struct zl3073x_dev *zldev = zldpll->dev;
> -	const struct zl3073x_ref *ref;
> -	u8 ref_id;
> +	const struct zl3073x_chan *chan;
>   	s64 ffo;
>   
> -	/* Get reference monitor status */
> -	ref_id = zl3073x_input_pin_ref_get(pin->id);
> -	ref = zl3073x_ref_state_get(zldev, ref_id);
> -
> -	/* Do not report ffo changes if the reference monitor report errors */
> -	if (!zl3073x_ref_is_status_ok(ref))
> +	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
>   		return false;
>   
> -	/* Compare with previous value */
> -	ffo = zl3073x_ref_ffo_get(ref);
> +	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
> +	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
> +			      244140625, 36);
> +
>   	if (pin->freq_offset != ffo) {
> -		dev_dbg(zldev->dev, "%s freq offset changed: %lld -> %lld\n",
> -			pin->label, pin->freq_offset, ffo);
>   		pin->freq_offset = ffo;
> -
>   		return true;
>   	}
>   
> diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
> index 55e80e4f08734..e140ca3ea17dc 100644
> --- a/drivers/dpll/zl3073x/ref.h
> +++ b/drivers/dpll/zl3073x/ref.h
> @@ -22,7 +22,6 @@ struct zl3073x_dev;
>    * @freq_ratio_n: FEC mode divisor
>    * @sync_ctrl: reference sync control
>    * @config: reference config
> - * @ffo: current fractional frequency offset
>    * @meas_freq: measured input frequency in Hz
>    * @mon_status: reference monitor status
>    */
> @@ -40,7 +39,6 @@ struct zl3073x_ref {
>   		u8	config;
>   	);
>   	struct_group(stat, /* Status */
> -		s64	ffo;
>   		u32	meas_freq;
>   		u8	mon_status;
>   	);
> @@ -58,18 +56,6 @@ int zl3073x_ref_state_update(struct zl3073x_dev *zldev, u8 index);
>   
>   int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
>   
> -/**
> - * zl3073x_ref_ffo_get - get current fractional frequency offset
> - * @ref: pointer to ref state
> - *
> - * Return: the latest measured fractional frequency offset
> - */
> -static inline s64
> -zl3073x_ref_ffo_get(const struct zl3073x_ref *ref)
> -{
> -	return ref->ffo;
> -}
> -
>   /**
>    * zl3073x_ref_meas_freq_get - get measured input frequency
>    * @ref: pointer to ref state
> diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
> index 8015808bdf548..9578f00095282 100644
> --- a/drivers/dpll/zl3073x/regs.h
> +++ b/drivers/dpll/zl3073x/regs.h
> @@ -164,6 +164,11 @@
>   #define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
>   #define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
>   
> +#define ZL_REG_DPLL_DF_READ(_idx)					\
> +	ZL_REG_IDX(_idx, 5, 0x28, 1, ZL3073X_MAX_CHANNELS, 1)
> +#define ZL_DPLL_DF_READ_SEM			BIT(4)
> +#define ZL_DPLL_DF_READ_REF_OFST		BIT(3)
> +
>   #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
>   #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
>   #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
> @@ -176,6 +181,16 @@
>   #define ZL_REG_DPLL_PHASE_ERR_DATA(_idx)				\
>   	ZL_REG_IDX(_idx, 5, 0x55, 6, ZL3073X_MAX_CHANNELS, 6)
>   
> +/*******************************
> + * Register Pages 6-7, DPLL Data
> + *******************************/
> +
> +#define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
> +	ZL_REG_IDX(_idx, 6, 0x00, 6, 4, 0x20)
> +#define ZL_REG_DPLL_DF_OFFSET_4		ZL_REG(7, 0x00, 6)
> +#define ZL_REG_DPLL_DF_OFFSET(_idx)					\
> +	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
> +
>   /***********************************
>    * Register Page 9, Synth and Output
>    ***********************************/
Reviewed-by: Petr Oros <poros@redhat.com>


