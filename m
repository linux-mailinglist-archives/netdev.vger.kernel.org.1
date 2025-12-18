Return-Path: <netdev+bounces-245376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 056E7CCC8AC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2A33085C92
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45A034CFDE;
	Thu, 18 Dec 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rid5MBdR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kZopEdPm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E534D3B0
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072187; cv=none; b=ga3TNVmEaMzSsgvfELiZqf3h4U4/FmkDt84iXptwv/7WSxNz461SvimTNlLVqI+aXR8C7DSJNgdCk9NeuDa+PNJqmA5SeXpKgDPjXAM7mmy+ALCws6SKgtJMgGfTk/ZtgRRaxBorlRefY5SdnNR5POKB7iYahm5EuBEsKC/yYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072187; c=relaxed/simple;
	bh=HcQ1T2QJAcsrKq4bBhpA/oJASDi8MBf1Z81/YkVUoCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpiprKE4SNmFHAgW4xTMjAxqNd+XWymjKbqvXxUx6dKac4NVreDsW1I1i8G+ewbwcge0y0PQZcWFv5TzmeBOn2m+at+5Eckek2G4YilhWt9gdB4IFyClA2Qw28Ncgk8qKSs6DtX12os9qtFH3SGr39AZjfrXUx7UWbitcf3P7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rid5MBdR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kZopEdPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766072182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
	b=Rid5MBdRbP2LvF4k2r199jYESawZisvHni/1GwrFsrdBG6nlfW7J8jM9miiBxWSpKWQzt9
	dog5dg+b4dQWfCal6wFYYd/0b5MEIKE4KRLw2I2a4kK0a28o6RTB9xk5BtNdGFfI3cEyOC
	HBAYKb2fcyxXHfTWyaBrGCbImDJqooI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-iAc8rHr9Og-J5G5u3NcH3g-1; Thu, 18 Dec 2025 10:36:21 -0500
X-MC-Unique: iAc8rHr9Og-J5G5u3NcH3g-1
X-Mimecast-MFC-AGG-ID: iAc8rHr9Og-J5G5u3NcH3g_1766072180
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso6238515e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766072179; x=1766676979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
        b=kZopEdPmCyHl9AV1+J8QP/KusGO6TszEXNqSO10GnqThS6iXgIO4YeRJR2H5O6P1Vo
         3nNjQ9rnplabaSVmJwLSrBxvKFN9W0HaUyhMC1ihFR6c96PSooogUTtssPy+hkmGenwk
         DwWJmZR/G3KR9mMKbzYDHMtEw2YEIjVYMSzkdSjk9HmDpR6TsoNedjMqatrfSF4YhAPE
         2MdGU8+BxylToOYZDU8uh1byqwhP3K++exnisT0mIrnzVT85N4gOAG58tdJyHPoG8iys
         mpS/P1ZxGGwYBxHMcIpqwP8TOxawBwXtyinOsvdEbP+8J77wxtq7dpJEPmGSDi8TDbPm
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072179; x=1766676979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kllYXFX7V4tWutE1vmgm986dWSjj3DAqVKD7yh7tPZU=;
        b=az85S16lhGREoKeLiDo2VRmnH0wdc8FKkUHcc44V9PC5WOxu0++qxS4RVnvmZSvc+9
         3Q4MmP+7voqyISQy4T6B4vNButaDXOxW0WgCtXHVFVD2YxDPT99g/QqIBdKV7WXhbFIp
         TBQQAUJT1aLpQrgrDhMfGPmpULFG0Jqo0AeSBMzih+L8pCd2gp81AG1BOXigJ32TvkK6
         TjYXnMnFh7mHDQFHYIZEvoAYGoe+btwWpuekcOZf8RCmIsxT/rvzHEoTZIIIJgYFIcpe
         ptufWW3yVeDzZS9LgdwEac7QwlW9dgwfaTRwyVSEA+oXG2RqkSDHdnkYZ1t2AeeRyhaa
         ZWww==
X-Forwarded-Encrypted: i=1; AJvYcCWI001HfMRBTDzg/XG6fxW+4lxsTB4irj4sDXXEwBUhYUVBgEVb74Lr4AGVC/lLr9Kz3JbNnNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIepsCVa/tx5/3z9r4m/7N/Ikz+9l1r1Y1Aj4dcS22W3PMZ9nF
	42lmy4/nA65Q+tPov3GNNqp8HCBY6V5Yg3K9+mv2IRru0FhGUllfEIDF7fgx8fWNP/v5klwalMk
	bicY0oUJtU8rSAWOjZsdmlCZSm8l0/dZ0LSo0Ar/Nn2lIO55FlwD2LwrasTN/TYUa3g==
X-Gm-Gg: AY/fxX4PY8BxhJC2xFYSDEO8k60eSFrGsNuhpq6yN+V3jcH9Qsk6WzNG7zcpqzASyVk
	Ql2sBuh3IrvJqJTHGd1WQz6eB5brRx6u8W5s7IwH82irzAZIq6l+/9rGeOdihMlErVfKTt7FNY3
	lOcX7sdnTTWvcBO3orIH2CCFKftE3tSZ25AoL2/ZMUZ3bBcd3C9K5xPAZJhDX4SeBUM5ORcsF0N
	poSd76xggtIEQdZn0m3kBSC5B4R7yddQEwdAg2LSICfMiG9UJbewhmFJiJbGug6xNavTbLKN2Op
	GJI19gAF11gIKGXNuxGYYvHYJdTX/v889M61RismBHzY7Vw8ci4XLT2i83WJqUbIoYx+w178qXY
	w/WoE7YonINyLAA==
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-47a8f903800mr213401755e9.20.1766072179188;
        Thu, 18 Dec 2025 07:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzPSeaBpb5nGbuAxNoRgvwXIaPYaxEWF8FWstO/zIN8aNHf3vr7XOZckTOB1XmAE6KBJF8VA==
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-47a8f903800mr213401505e9.20.1766072178704;
        Thu, 18 Dec 2025 07:36:18 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be395d9cfsm16877665e9.0.2025.12.18.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 07:36:18 -0800 (PST)
Message-ID: <743244a0-41ea-4e7f-bd81-6814e852971d@redhat.com>
Date: Thu, 18 Dec 2025 16:36:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: nfc: nci: Fix parameter validation for packet
 data
To: Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20251210081605.3855663-1-michael.thalmeier@hale.at>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251210081605.3855663-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/25 9:16 AM, Michael Thalmeier wrote:
> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.
> 
> The mentioned commit tries to fix access of uninitialized data, but
> failed to understand that in some cases the data packet is of variable
> length and can therefore not be compared to the maximum packet length
> given by the sizeof(struct).
> 
> For these cases it is only possible to check for minimum packet length.
> 
> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
> Changes in v2:
> - Reference correct commit hash

Minor nit: you should include the target tree ('net' in this case) in
the subj prefix.

>  net/nfc/nci/ntf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index 418b84e2b260..5161e94f067f 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -58,7 +58,8 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
>  	struct nci_conn_info *conn_info;
>  	int i;
>  
> -	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
> +	/* Minimal packet size for num_entries=1 is 1 x __u8 + 1 x conn_credit_entry */
> +	if (skb->len < (sizeof(__u8) + sizeof(struct conn_credit_entry)))
>  		return -EINVAL;

You can still perform a complete check, splitting such operation in two
steps:

First ensure that input contains enough data to include the length
related field; after reading such field check the the length is valid
and the packet len matches it.

>  
>  	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
> @@ -364,7 +365,8 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>  	const __u8 *data;
>  	bool add_target = true;
>  
> -	if (skb->len < sizeof(struct nci_rf_discover_ntf))
> +	/* Minimal packet size is 5 if rf_tech_specific_params_len=0 */
> +	if (skb->len < (5 * sizeof(__u8)))

Instead of using a magic number, you could/should use:
	 offsetof(struct nci_rf_discover_ntf, rf_tech_specific_params_len)

and will make the comment unneeded. Also the same consideration about
full validation apply here.

>  		return -EINVAL;
>  
>  	data = skb->data;
> @@ -596,7 +598,10 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
>  	const __u8 *data;
>  	int err = NCI_STATUS_OK;
>  
> -	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
> +	/* Minimal packet size is 11 if
> +	 * f_tech_specific_params_len=0 and activation_params_len=0
> +	 */
> +	if (skb->len < (11 * sizeof(__u8)))
>  		return -EINVAL;

Again all the above applies here, too.

/P


