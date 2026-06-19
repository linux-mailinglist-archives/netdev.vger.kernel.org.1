Return-Path: <netdev+bounces-300711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8T7KLlpANWqAqAYAu9opvQ
	(envelope-from <netdev+bounces-300711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:12:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AE6A601F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 15:12:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m2swHUjb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300711-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEA4D300983E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DE390CBA;
	Fri, 19 Jun 2026 13:12:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EF3839B3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:12:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874772; cv=none; b=V3mc5xf+Azt79cLFS55NNk0L3G2s2VAlnEM94kv7pCUqQOELVeprUDVEH4sKUEMhiKghFhh5byKY0mcKOaqBXv8lH7VeMwGdaKNhBXYroIo9cOgQYgHiuMA8QcBV1eqSQrLLP134AEedLKKGiTPDAqlk7j+vCmIO+zLHW7U/2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874772; c=relaxed/simple;
	bh=Nkuj7e0uLIcw2dQ+72Ht/EJgUArLcj7dXa28YZgE0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyRujzzGmNzuUuYbG9OGfs7biBbawztozOZFW7Bbug31QNUUm6Cg77vs8GC+87IVnhWXH2VY9sPMvGvScGPx2wx+v5I4iSVdV1aeBCnQ2TAhBDMyqQKF2LZjppxTY2gnUWFUie8Yq91NFzFcUfihBe2cX2AjdUeqFZkc2gtOa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2swHUjb; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-463f1165e16so1946827f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874768; x=1782479568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYYIAxjrT/iNiD/3UYstOUuE19cihfkCG33B5fDVbBM=;
        b=m2swHUjbXSoTp6MOCg72HAv5y/+zClcauNiU8Q/5IOeS+TgDn5P9BZ8BMHvDD4C1Cs
         xJfvaTUOTSE8Ns9RV79cjIwNdfocl5E4GZr32924oCOp6d9ycUndMPe73zI2hJFrhqLj
         kMtpReM53tcAEEbyg52JU054ALYJDZ98GQEe9Pdb5J7T3ntMMx1pk3vDp5KpCInqopft
         P0eDwLGOQJUKvFtgmEzddeB5xfFMmbM0Rvs+1dpP4bp/cgMuEVnncRwRU/pyQx0Ad73M
         tXDDWh/3ASLZbJspZ0VUqedfnbo2WAIeGYa7gQUpp8Jl3LTCSJ3cwxX80/cD7Ts36CDn
         axOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874768; x=1782479568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYYIAxjrT/iNiD/3UYstOUuE19cihfkCG33B5fDVbBM=;
        b=K2E57g/G77y0tpVpfpgne+wB92A051P47+nkRiNDkfirq9RvKsPZwue6RVQBpdess5
         BMyvBmLANURo47KMZInYAHOdrAGFYiQhQhW5JqFUmBO9ooBbjzdmc5GgIeCQmS5GmLy1
         ZltAuCHz6aerhv92ojSsKeAItUvf2ajGA+37zTukTOb+fOiOVspAbCEv4r/aZb2o/JJy
         IxZ7zT5YR9OT0PgmAOUTX9nmqGdWXrrfV/sE0NLkZZwF23HLgyJjG/H9Mpy1wyYYK7BS
         kzRwIV6MipEHCL1wJ5i8Suz36a9EBQKuue2qDi5bZpYzwKEhDk5iO9+OUxF0ByXR5KLN
         PUdA==
X-Forwarded-Encrypted: i=1; AFNElJ+tI63BJsd4x8FmpoW4kvnbhtwJgu4AlDkRXLQcjbo8dib4cL7UduHBxP3P3gAslk2LPSyPBF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLIaHR6qcCBfXeE8wlyEdWYDrLmwpgk3PmfWmFMbxcLyUC/ic
	VXIt522TWtCJz7eaByrGyq+yPYEcUensF24BVRFu4HAMbKJO7cqAwfaE
X-Gm-Gg: AfdE7cmIn4k+y+cw+U/jb3sqStIPfu4tJzEXd/YWxv/o33KONvk7Xl58BNMPgVvRcx2
	oDYuiXDvwbWKEixEzITb06ZFGaCrs9rSgS1Kynf+lpCO5X6ZTXnQVhEDxc5WyyLlmgqnXNzN2DB
	McvQjmpFh/U3TLzn7b6gXI7UTPSbCycR6TJs7I+sZIeG+7hBomRYsiuj9n1Zz4YY7jxRdjD0ae8
	EX4GSV8neAZyOCJFxfxpDgMHrrKcblR0Trl2FayhgkUKboR9lxjHfB5wcVNZRy1MQPYhU5+Co4m
	aMUgrIxWtM7T6bOhkeTVW63pJNEdeT+QK+w/JrDrU+ejZNFeyrm5Vm8T3VRSFfyG8fs1KMkhYIw
	eoRhiD9qp4AyTfdizM9XLp9bYSIAol83D6Fh6GOAR0x/+swZj+Mpd/v8Ac0a/BUEfUhy3JIMfb4
	r721TkjhtT/YFsDRXhOYAV88QDI64LGrjkG09Ns2Lnsrlthpnzvs5NmNIPLCGfRTzEHaH2AV+fm
	LoWxSpDh0tcVg==
X-Received: by 2002:a5d:5d8a:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46508afa0eemr6766999f8f.30.1781874767770;
        Fri, 19 Jun 2026 06:12:47 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc42a3asm7999337f8f.31.2026.06.19.06.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:12:47 -0700 (PDT)
Message-ID: <f28ab562-5caa-487e-a837-dbc0ac24a46c@gmail.com>
Date: Fri, 19 Jun 2026 14:12:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 1/5] sfc: add cxl support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300711-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:Jonathan.Cameron@huawei.com,m:alison.schofield@intel.com,m:dan.j.williams@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,intel.com:email,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B31AE6A601F

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
...
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b98c259f672d..de3fc9537662 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1197,14 +1197,23 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +#endif
>  };

The documented cxl_pio_initialised member does not appear to exist.
Will this not cause a kerneldoc build error?

