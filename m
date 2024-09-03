Return-Path: <netdev+bounces-124475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA8969A4A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A91C2356D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AB1C62A5;
	Tue,  3 Sep 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2e+A8fn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D01B983B
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359753; cv=none; b=cnLr0SybKEdBalOPckdguJuD5G6WR19gwPWhlVFAaY4W5xPRB1rx0SsFasZgvD5m2w8cXLHc638kneQABDTeEWmhCmhNxrFV90eG9xctn+eD678bOHmB/o7ziLSwcVXsCHZhTzW+ZXcEA/jWI9M2AxrRWJ4OxoI6laVYWXCfHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359753; c=relaxed/simple;
	bh=fvgsf92nqMBdARtfvJv/PBUbMrLG2lAXixMqbev6HBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXsCBkJxR7h+Qq9w4ZfKrFs5Ao5btcJfQKPGbkCep+kYgBqvWSlipC1gGS0XzEEzvFzNf5kKjGuwAkh6ChA1eZIRfg2NimsJ1U8VVN/nKilRe8YWWp3N5L245Wdp990uqd/gwzktHkX8bGvbblZC87pCbir3jQp0zw7fykKFX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2e+A8fn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725359750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiZ7LPo+lDEnGu3WcQsi41pio1O8K0ltTaNGTAhXDRM=;
	b=S2e+A8fn1dcgTR3Kcv5e8Vx32xlBFfnb4YEnBsInedZODeJttJ71vAwWVe7P7Iqj75BN4z
	yj6G892c24Xt1nLzj1iiLvZ7osJ4bt8uJZOK8/DvWLE1b9+D0F63GaIWKbGd47ROI5SAAh
	NKC2YnDF296bKDO7jzoX/zH4rJUSnbo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-6HIOz9Q8N8WeBj1UrCbPJQ-1; Tue, 03 Sep 2024 06:35:49 -0400
X-MC-Unique: 6HIOz9Q8N8WeBj1UrCbPJQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c7aa6c13cso24576305e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 03:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359748; x=1725964548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiZ7LPo+lDEnGu3WcQsi41pio1O8K0ltTaNGTAhXDRM=;
        b=nQk9eZ46xZukG1zyHsvz37O4oGp/YBzWNK8Cb+GQW7lWHovKF/auP+6qpD+ZNCZfwM
         SBRzPnISJ4mNkwdtKkmmewBp7X3wD8XoJcGFWZhGTunfGgjVBKmh37ve9AOudl8CnNMz
         evcMkFVe9N6EQa1xLQOXG7m7/NvwVVtzzqEpU/7UA4e16DKUNKrQixDxGYoFKsQ55O3f
         TLppNNu17wC8VivpnfHhMmsAshLEecivyfpDYbuBnTogj6sMgf0tlnToEANXzT8+CeBZ
         ZZOASkPEDumd+8Gqd0fwAjBzQa2xlosMIH9S2WyMsjNd6KoUnCLlmH7cHW/8EW3hRK/p
         k0kQ==
X-Gm-Message-State: AOJu0YxCdHmqbrrDwt9ceK1WRD26+bb0YFGqGUqCLU++mhh70wbWa9e2
	KCrxziOEO22IqLe4SAhb1Otpm8lbyqAuzxlJUvPeuHtFMtj9reUpRMBkgkRWTP2X7r5lS467EhU
	BUbkzByPdcpDPNIt4malLMnqjYVhvI6xo6nK8Ny3ajWbt0V3rcwX/Vg==
X-Received: by 2002:a05:600c:46c9:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42bbb436e9amr91344475e9.25.1725359747913;
        Tue, 03 Sep 2024 03:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYGR7qmmE7vWGhfaxlsISt+xOye6QRxYXMRiPyUKwRGTdlFbFeD1SmFuAzGdvXISiz/N+1A==
X-Received: by 2002:a05:600c:46c9:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42bbb436e9amr91344305e9.25.1725359747457;
        Tue, 03 Sep 2024 03:35:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df100csm165965525e9.20.2024.09.03.03.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:35:46 -0700 (PDT)
Message-ID: <e767ec8e-e25d-4880-86be-d23e1875a428@redhat.com>
Date: Tue, 3 Sep 2024 12:35:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 2/3] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
References: <20240829183603.1156671-1-vadfed@meta.com>
 <20240829183603.1156671-3-vadfed@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829183603.1156671-3-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/29/24 20:36, Vadim Fedorenko wrote:
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 46369de8e30b..e7479b9b90cb 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3361,6 +3361,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
>   static EXT_ATTR_RO(freq, frequency, 2);
>   static EXT_ATTR_RO(freq, frequency, 3);
>   
> +static ssize_t
> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *ea = to_ext_attr(attr);
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);

Out of sheer ignorance on my side, why a trailing '\n' is not needed 
here? do we need to copy the format string from the old link verbatim?

Thanks!

Paolo


