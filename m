Return-Path: <netdev+bounces-304463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id shMEAcuAR2r0ZgAAu9opvQ
	(envelope-from <netdev+bounces-304463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:28:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B46700A46
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:28:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MRV3q5Eq;
	dkim=pass header.d=redhat.com header.s=google header.b=m4ktJBvC;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304463-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DE23091110
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF53B2D0B;
	Fri,  3 Jul 2026 09:20:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3D3B14DE
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:20:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070457; cv=none; b=MgAJmFiTWa0X7PKL4fJNIVzImPNnyHMkNAyLVowYpdvknB2tpdpgxi/iYG5H0c9znXsj/RZUxXIhW8KRdpNjD93d2zJ9iLKuO1NAM2yTeGuN+im38TrAj7T5t159E6tEQ/jIxsMgAgoZFbk8yuY9VWwJD4gJwGzEZ1ViWwgnNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070457; c=relaxed/simple;
	bh=waf8YB5JOcisYKCb56zlKtfs43hjRImfVTRJ4GBFOjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hta0n1oY7k3wQvZ/DMrS9izEzssV9P2WkxFsbp6xGTSvmokyR+tiLPjGOrPSJW+An4H+ztoS1ZERDPuMXAqQPnJxr0Y4H071kbKqermJy9RLgTp17JK+Xt75n+vP5oaHQWprRl8DDVHqeqbAq4F+9SPttnJcttyKgTU31tMkYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRV3q5Eq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4ktJBvC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783070453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCV2rXEVGo7ASYXPyXZn6dLz7sNMihlc8V7+SsXxmwQ=;
	b=MRV3q5EqKN/imOGxbQpVfImzlEi1MYEGE4ps71VS3nskgHQ1stSPtLssnNsNujqzJvJ7Nt
	NWM9Y9i5ZweayxZFpaiDALD3nCgyzkj18TIYunoMihGsR2TLlvAkdh9zBR80srk2aMNVcI
	7Qg/u6PoZmqyJ+mNkiT8Kw6JfaxAiPc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-rIHYCSzCNlKX3wUvvbSCTA-1; Fri, 03 Jul 2026 05:20:52 -0400
X-MC-Unique: rIHYCSzCNlKX3wUvvbSCTA-1
X-Mimecast-MFC-AGG-ID: rIHYCSzCNlKX3wUvvbSCTA_1783070451
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4629f312a67so315559f8f.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783070451; x=1783675251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCV2rXEVGo7ASYXPyXZn6dLz7sNMihlc8V7+SsXxmwQ=;
        b=m4ktJBvCuXodkXshGtWeTlbk+fow500tqwhvcPj3LP5NfdWLBSWXGO3OLf9exxn0dK
         K8DItS1T0b7R+n9WJqcQ+Cn1RIIQMC9NY5biHLJl7hr1qmqVz6KvEki/SDbDU6OxGB2D
         81zPDvsoJkYnTrUeMXMPb3XWQxqkmabyx6yQMuhsar5Cnm+1EBR2l6ZNP3UL5OutcIWJ
         ywZbfvbHR0/mhW3mDevmKhpBui+YJC3HPC5w2Y9Z8YrKqzdq24qwM2Yb2avCQo+UEeQ4
         QgwCUe5m2nxj+2YyPWq39E2qcYdreBhtnDQwV85q+vqLrRkqdN98JVTbBs/5Vdy9HVS+
         ooxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783070451; x=1783675251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCV2rXEVGo7ASYXPyXZn6dLz7sNMihlc8V7+SsXxmwQ=;
        b=VUFoUli2aIcxsAkisjxxFAtGg/7dbEJkIB2FXilviZj2cWJxdD10zugrB/FD4xJzpZ
         R7juMb+5472ksRWiW2ji1TqYZA9wOr8nSZ5JRJq8IC4BNzh02n1geG6gmbmNYLbFK7Wl
         5NXXrJQf8uiUMVr0lbywr+++iZHM/WjVCYLt68QtM5P4Mo9wRMW/n5CCY+Ol+dRWRm71
         Y1VkiMjWb+GtwXr3DFKwhiNUSVgekuKIdpOdNphtbg2RwHtVUQ3ATmoPEE6749KX+PZL
         HbVrnfSZ+BiHOHAJz+RCmFT9iVu7mFG8Og74coInRWqar3j6VuYXaA8am7HQAYcyljS5
         b2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/yjc0g0/pRg3nG6hQkivrvOc9Io1LgvFREOIV88s3HPx3rt5E4TCZY92ZRMMql5e2BAN1zup0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn2/T6wHTyBt5EI7MJCGNhIp6VpS+dG6Tuxn3WP7SzOWSRUsY
	7TL/UamaX2xyuJ1nbb/xRgalN6W7JUL0XerN0nl28XB7PW6ejFL8BnHKucrFRVG3eXipdkGL/bk
	6b/e7VXfs9oA1/Z2jAo91L78DELWKKwKmbKI6vlxu8fDghr5ykH5XAZmOGQ==
X-Gm-Gg: AfdE7cnJIHRz6Z6MGtErH6VXyVy0kfJ1/q5aJ6HmfcSmRs6LSIfcs29fvhFDujsGdSR
	L3gdIjL3aPTuvmR6ROAIM5Y6HIfn9h4Q2sG7gKbJx1zaI8juLcn0xC5oCYtAd47pT8LkQcnudu1
	B17+MAv8ONUOsyyy0gWKl/5zCEiXxxZEy8rlMjpxKOtNYRJk1Nw7Lu/S2FKmdT9VduD2LQK5BRy
	IgGNTm7xiE0zwSCPlUPh3StOX0WPGxxqy+v5hwWEku8gN3y5bVb5hy2BZrBbVwt61CZI9Y2X/CY
	jQeyU+Qg517dfbo2OpN4zYHCHsSJSyKbjBFbYHnStmguvTYsfNKbKmPmm8/A/B4x8xSCVOAn1yO
	jc/qpUIJsLQ==
X-Received: by 2002:a05:600c:6d14:b0:492:3763:aeb9 with SMTP id 5b1f17b1804b1-493c2b7cb1cmr100820535e9.21.1783070451262;
        Fri, 03 Jul 2026 02:20:51 -0700 (PDT)
X-Received: by 2002:a05:600c:6d14:b0:492:3763:aeb9 with SMTP id 5b1f17b1804b1-493c2b7cb1cmr100820205e9.21.1783070450741;
        Fri, 03 Jul 2026 02:20:50 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef1807asm153536325e9.1.2026.07.03.02.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 02:20:49 -0700 (PDT)
Message-ID: <d5929bed-9d29-4d26-bba1-babade301f38@redhat.com>
Date: Fri, 3 Jul 2026 11:20:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/5] dpll: zl3073x: use per-operation poll
 timeouts
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
References: <20260630125536.720717-1-ivecera@redhat.com>
 <20260630125536.720717-4-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260630125536.720717-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-304463-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B46700A46


On 6/30/26 14:55, Ivan Vecera wrote:
> Replace the single 2s timeout in zl3073x_poll_zero_u8() with a
> per-caller timeout parameter. Different HW operations have different
> expected completion times so using per-operation timeouts improves
> error detection. The timeout values are based on proprietary source
> code provided by Microchip and own measurement.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c |  6 ++++--
>   drivers/dpll/zl3073x/core.c | 29 +++++++++++++++++------------
>   drivers/dpll/zl3073x/core.h | 10 +++++++++-
>   3 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 2fe3c3da84bb5..677a920c16254 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -33,7 +33,8 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   
>   	/* Read df_offset vs tracked reference */
>   	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
> -				  ZL_DPLL_DF_READ_SEM);
> +				  ZL_DPLL_DF_READ_SEM,
> +				  ZL_POLL_DF_READ_TIMEOUT_US);
>   	if (rc)
>   		return rc;
>   
> @@ -43,7 +44,8 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
>   		return rc;
>   
>   	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
> -				  ZL_DPLL_DF_READ_SEM);
> +				  ZL_DPLL_DF_READ_SEM,
> +				  ZL_POLL_DF_READ_TIMEOUT_US);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 8e6416a4741de..0b2050aa2ed92 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -311,17 +311,17 @@ int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val)
>    * @zldev: zl3073x device pointer
>    * @reg: register to poll (has to be 8bit register)
>    * @mask: bit mask for polling
> + * @timeout_us: timeout in microseconds
>    *
>    * Waits for bits specified by @mask in register @reg value to be cleared
>    * by the device.
>    *
>    * Returns: 0 on success, <0 on error
>    */
> -int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
> +int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
> +			 u8 mask, unsigned int timeout_us)
>   {
> -	/* Register polling sleep & timeout */
> -#define ZL_POLL_SLEEP_US   10
> -#define ZL_POLL_TIMEOUT_US 2000000
> +#define ZL_POLL_SLEEP_US 10
>   	unsigned int val;
>   
>   	/* Check the register is 8bit */
> @@ -335,7 +335,7 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
>   	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
>   
>   	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
> -					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
> +					ZL_POLL_SLEEP_US, timeout_us);
>   }
>   
>   int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
> @@ -354,7 +354,8 @@ int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
>   		return rc;
>   
>   	/* Wait for the operation to actually finish */
> -	return zl3073x_poll_zero_u8(zldev, op_reg, op_val);
> +	return zl3073x_poll_zero_u8(zldev, op_reg, op_val,
> +				    ZL_POLL_MB_TIMEOUT_US);
>   }
>   
>   /**
> @@ -377,8 +378,8 @@ zl3073x_do_hwreg_op(struct zl3073x_dev *zldev, u8 op)
>   		return rc;
>   
>   	/* Poll for completion - pending bit cleared */
> -	return zl3073x_poll_zero_u8(zldev, ZL_REG_HWREG_OP,
> -				    ZL_HWREG_OP_PENDING);
> +	return zl3073x_poll_zero_u8(zldev, ZL_REG_HWREG_OP, ZL_HWREG_OP_PENDING,
> +				    ZL_POLL_HWREG_TIMEOUT_US);
>   }
>   
>   /**
> @@ -609,7 +610,8 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
>   	 * to be zero to ensure that the measured data are coherent.
>   	 */
>   	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
> -				  ZL_REF_PHASE_ERR_READ_RQST_RD);
> +				  ZL_REF_PHASE_ERR_READ_RQST_RD,
> +				  ZL_POLL_PHASE_ERR_TIMEOUT_US);
>   	if (rc)
>   		return rc;
>   
> @@ -628,7 +630,8 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
>   
>   	/* Wait for finish */
>   	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
> -				    ZL_REF_PHASE_ERR_READ_RQST_RD);
> +				    ZL_REF_PHASE_ERR_READ_RQST_RD,
> +				    ZL_POLL_PHASE_ERR_TIMEOUT_US);
>   }
>   
>   /**
> @@ -648,7 +651,8 @@ zl3073x_ref_freq_meas_latch(struct zl3073x_dev *zldev, u8 type)
>   
>   	/* Wait for previous measurement to finish */
>   	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
> -				  ZL_REF_FREQ_MEAS_CTRL);
> +				  ZL_REF_FREQ_MEAS_CTRL,
> +				  ZL_POLL_FREQ_MEAS_TIMEOUT_US);
>   	if (rc)
>   		return rc;
>   
> @@ -669,7 +673,8 @@ zl3073x_ref_freq_meas_latch(struct zl3073x_dev *zldev, u8 type)
>   
>   	/* Wait for finish */
>   	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
> -				    ZL_REF_FREQ_MEAS_CTRL);
> +				    ZL_REF_FREQ_MEAS_CTRL,
> +				    ZL_POLL_FREQ_MEAS_TIMEOUT_US);
>   }
>   
>   /**
> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
> index addba378b0df4..6b55a05a222ed 100644
> --- a/drivers/dpll/zl3073x/core.h
> +++ b/drivers/dpll/zl3073x/core.h
> @@ -7,6 +7,7 @@
>   #include <linux/kthread.h>
>   #include <linux/list.h>
>   #include <linux/mutex.h>
> +#include <linux/time64.h>
>   #include <linux/types.h>
>   
>   #include "chan.h"
> @@ -19,6 +20,12 @@ struct device;
>   struct regmap;
>   struct zl3073x_dpll;
>   
> +/* Per-operation poll timeouts */
> +#define ZL_POLL_DF_READ_TIMEOUT_US	(25 * USEC_PER_MSEC)
> +#define ZL_POLL_FREQ_MEAS_TIMEOUT_US	(50 * USEC_PER_MSEC)
> +#define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
> +#define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
> +#define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
>   
>   enum zl3073x_flags {
>   	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
> @@ -127,7 +134,8 @@ struct zl3073x_hwreg_seq_item {
>   
>   int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
>   		  unsigned int mask_reg, u16 mask_val);
> -int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
> +int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg,
> +			 u8 mask, unsigned int timeout_us);
>   int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val);
>   int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val);
>   int zl3073x_read_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 *val);
Reviewed-by: Petr Oros <poros@redhat.com>


