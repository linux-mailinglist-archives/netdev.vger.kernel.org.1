Return-Path: <netdev+bounces-272490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN5mEFBZxmkrJAUAu9opvQ
	(envelope-from <netdev+bounces-272490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:17:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE5342599
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C22830DAE07
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C23A8741;
	Fri, 27 Mar 2026 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoXDgh0d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rfN200iY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB23A6EF9
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606287; cv=none; b=gZouQUqd2+xooQbAdiPpME0CV1sx6S30AzikTasWgHyY2QuWUhhf9OOtIDPR1jV9TaRFT3jnk0kFrvLD+FrgZQH1l/aSIvmjwocVCdf0Xe+Ili6sClKVd7Fcs5xj5nwuxYIheBK1Gl5IUq5L1BmWmc8PjT8lTDIo7cXaRq5gni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606287; c=relaxed/simple;
	bh=UePfgCVIMdwnsiSP/Ict/OfV+6Z2KDwQBisMnTe2L64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0/eoM8V/U91Uf742K247TUZ0EyhjvHUmDUEOxFpqPhGmg8dFyDzmuWiMTYBUdSXSKlEP66Dxf+lh6DFuv3S6gSHgxTJER2q4bnmXdPUGTLL9qJHo5U/lTHcOJ1xtJjlGDyC3X+WaDSFHxE0Kr2vbxh610S4s5ZtyMRtg3kqELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoXDgh0d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rfN200iY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774606285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRnbNl3u/p+FGuGPfwMKlR/+7x5aDIRiANz+ZN11JbI=;
	b=QoXDgh0dc+CouqXmLHNrHgcUw1rgBB8ELCTgR5w1J5fh6GAGrmcvXrdUJ0IJ4u63FZWNHb
	XdYeGzW4NVMOe2KG1vRYLOq6OrU4/tSMOIe3lLKYEILE5tsbEc2hKD8Uwl7Q2fysoESPU7
	YTTqEhCSxL63Elvlfnc5YDwHFXoY4/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-nnPnfrgLO1WUdv2i4NcLxA-1; Fri, 27 Mar 2026 06:11:24 -0400
X-MC-Unique: nnPnfrgLO1WUdv2i4NcLxA-1
X-Mimecast-MFC-AGG-ID: nnPnfrgLO1WUdv2i4NcLxA_1774606283
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso28217375e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774606283; x=1775211083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRnbNl3u/p+FGuGPfwMKlR/+7x5aDIRiANz+ZN11JbI=;
        b=rfN200iYHV/Q6TjOW5iZxFpIdUoAvfcbQzTlg3n2ITZPxlZ/zR3rQhmqroSUF+oVOI
         PANE9eon12ffa+mLxsz3Fx53B2zXKoMNO4pqVvKi+x8vcaT6H70X4OjjlJnbdqvYh5vL
         EhI3EFCr4zgK3A5WeOEfXBI1X/N3T6BjNqrDSlhcsg24cCV6MjFsz5p6GymWDdZsW95s
         Hc8tw+kXmtOupERqdLsX9nhDQz4vvu03q/Jc9qAWdQYA2PaCbNOTh1p/QZ3jSIbAXCib
         Oefrjtf+GTWT1kJfARR/aoC7IP5JSg/EkPMLvqLPIxD9NOVTC2cVybs5XPecCKa2PHuh
         N5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774606283; x=1775211083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRnbNl3u/p+FGuGPfwMKlR/+7x5aDIRiANz+ZN11JbI=;
        b=eu8p9r1gFGa8FnpP5/r6BcpctydKeoGsyNqMPG4HMMdSqc1RMQP0zx+rgN6jRzA+p1
         lsNCAPW2uNSYESmxWcK1CnTgI/IvJv5qNvESzdhQHrBLJXGTs0Su7uNlBI+YpHiFWRlQ
         +IU7nfwH4idgP3u0zpIMAaNglXzrFpHrkGTs2CF67DbPUynC0hgFFjRSAb9UJA064GMY
         LggsQPMOVgHC/oN7GGQ0P2l3M8r8f/ioo+ddiQ+0xx1upnD+C/Ce0cBesMGe97ZXPH/P
         H7IcKFroUcHC7UP50ikqvA7fCXdLDHCQRbA9y7pBBc+H5zrcyJuIFLQN8ZV2ZxLoQep6
         xM1g==
X-Forwarded-Encrypted: i=1; AJvYcCX9oU3uNuk14LwhdDG7tVTB6wIvONsr2x0tWgeTWhhy9THfyxq+BPXGejmipatpAyltyvWsZ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7W8j1mD0+grGvln84U9O59oYIO6IgzjZ6edQk/nMHIIWmi3g
	THMke/bUOwniJ9nrfMXyXAylqd2t4KTASWLkfIBQtmgEa5GRT6joWiEXHK7eA1BsricvHesMqhQ
	BHgfHZ39Mdgk9VpaeUa+cwm7w13clbrbrSlHe7ouQa8dy9J6kUTJ3F7j8yA==
X-Gm-Gg: ATEYQzzmfrbSU00pfGvVV9jz38kPKQnu+SyUOawlC9jr5Z6TOA8uKbnmRMClbshZ3LQ
	z7WhtB6uTni655veIYu2/eWqYoFIt+OdF/mlQbpgUBHtVZYgK5z/6OtHcJwl6DLUjBWa4bb4gHm
	CgINujczLV/+bg0jit0ay/ZeNQk6iZ6hTlPiLpbKDxhDxCpUhaLo9Tyzhh6a+92bcc/+3Zme/lZ
	ADKq4Nlqo6nx0ScXArSDNeGQcsrntyfXDr4QI5OKEjP4+HfBFXGACIPByTDF5MXug3npLk+mGLf
	VwEdls1C2w//NJsIcs69NqLFSxf/PNPFZlFbwWYovheitLp/OhZETh5XZ206y/Zu7RvExI74L54
	hgnaqcf/TjBttK3GEUgNW
X-Received: by 2002:a05:600c:3b24:b0:485:6ec7:2df with SMTP id 5b1f17b1804b1-48727d5f7a5mr27184005e9.8.1774606283096;
        Fri, 27 Mar 2026 03:11:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3b24:b0:485:6ec7:2df with SMTP id 5b1f17b1804b1-48727d5f7a5mr27183455e9.8.1774606282661;
        Fri, 27 Mar 2026 03:11:22 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e68a6sm16570703f8f.33.2026.03.27.03.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 03:11:21 -0700 (PDT)
Message-ID: <f13b66b1-95c0-4027-a255-c03d127cc999@redhat.com>
Date: Fri, 27 Mar 2026 11:11:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] dpll: zl3073x: use FIELD_MODIFY() for
 clear-and-set patterns
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
 <20260319174826.7623-3-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260319174826.7623-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272490-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95AE5342599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Replace open-coded clear-and-set bitfield operations with
> FIELD_MODIFY().
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.h  | 17 ++++++-----------
>   drivers/dpll/zl3073x/core.c  |  3 +--
>   drivers/dpll/zl3073x/flash.c |  3 +--
>   3 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
> index e0f02d3432086..481da2133202b 100644
> --- a/drivers/dpll/zl3073x/chan.h
> +++ b/drivers/dpll/zl3073x/chan.h
> @@ -66,8 +66,7 @@ static inline u8 zl3073x_chan_ref_get(const struct zl3073x_chan *chan)
>    */
>   static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mode)
>   {
> -	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_MODE;
> -	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode);
> +	FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_MODE, &chan->mode_refsel, mode);
>   }
>   
>   /**
> @@ -77,8 +76,7 @@ static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mode)
>    */
>   static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)
>   {
> -	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_REF;
> -	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
> +	FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_REF, &chan->mode_refsel, ref);
>   }
>   
>   /**
> @@ -110,13 +108,10 @@ zl3073x_chan_ref_prio_set(struct zl3073x_chan *chan, u8 ref, u8 prio)
>   {
>   	u8 *val = &chan->ref_prio[ref / 2];
>   
> -	if (!(ref & 1)) {
> -		*val &= ~ZL_DPLL_REF_PRIO_REF_P;
> -		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
> -	} else {
> -		*val &= ~ZL_DPLL_REF_PRIO_REF_N;
> -		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
> -	}
> +	if (!(ref & 1))
> +		FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_P, val, prio);
> +	else
> +		FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_N, val, prio);
>   }
>   
>   /**
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 6363002d48d46..7eebfc1ad1019 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -743,8 +743,7 @@ int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor)
>   	value = (factor + 1) & 0x0f;
>   
>   	/* Update phase measurement control register */
> -	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
> -	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, value);
> +	FIELD_MODIFY(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, &dpll_meas_ctrl, value);
>   	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
>   	if (rc)
>   		return rc;
> diff --git a/drivers/dpll/zl3073x/flash.c b/drivers/dpll/zl3073x/flash.c
> index 83452a77e3e98..f85535c8ad246 100644
> --- a/drivers/dpll/zl3073x/flash.c
> +++ b/drivers/dpll/zl3073x/flash.c
> @@ -194,8 +194,7 @@ zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 operation,
>   	if (rc)
>   		return rc;
>   
> -	value &= ~ZL_WRITE_FLASH_OP;
> -	value |= FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
> +	FIELD_MODIFY(ZL_WRITE_FLASH_OP, &value, operation);
>   
>   	rc = zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
>   	if (rc)
LGTM.

Reviewed-by: Petr Oros <poros@redhat.com>


