Return-Path: <netdev+bounces-243198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74388C9B541
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 12:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293143A782D
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1643009F2;
	Tue,  2 Dec 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwHoKlCl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mGf3hGyf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F431E7C03
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675427; cv=none; b=n4zE2G7sZ7RB8lXyc/XYzQHFLEu4DWCreQ+lv7iBIQfi+vorRew+bjw5daNhPTVdc6q/+ToHGCmm9x6NtHN03A+MnTLWafHRVuZ7PIknuko4YN/4waCzLNj83YU+S9htvnFMGHAZLPy9pYdLqY44hure+tw0wNw2GUOHMR2dsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675427; c=relaxed/simple;
	bh=NAPv1ampMjARoJc3nghhAODO9GL33HnTABR9T+HZtBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lWeuaaOz3Vx1KNHzDu12OI/x4Yo3Yoyr9nK5RX+56cqFFsD2qeS2mESCedi4jFEyDUp2c5uZSjSP8TIZKl6UkUu4zTfRQI9jpfUPp6RYURalSb3o1peYJn6R0vRdUK+DARzQ92SvZYZF2qez8mCOJJdxGaD+c1v71dnzlnM2Leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwHoKlCl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mGf3hGyf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764675423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7t1jXNC1DXz9eXr1TkTwgKmmbSmBVZBUechbASQ+QUw=;
	b=dwHoKlClY9k28tBSiaRIeSP4YbKq3cLljrssBlq13Scxwt7zXqsIErleMXworLNR6QhHKu
	VDMvw2Ok2+5P/FlsaYq4FH877wg0mtn8wYEjCT5DplXrDq9r4OgOVHUrGo3VhqdmxouZl5
	dS8T1GXtN8tG1ES9eZGpm3yuFesjRvs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-BjhFAIduOSqGECpkS7d0wg-1; Tue, 02 Dec 2025 06:37:02 -0500
X-MC-Unique: BjhFAIduOSqGECpkS7d0wg-1
X-Mimecast-MFC-AGG-ID: BjhFAIduOSqGECpkS7d0wg_1764675422
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63de18a36f1so6000074d50.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764675421; x=1765280221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7t1jXNC1DXz9eXr1TkTwgKmmbSmBVZBUechbASQ+QUw=;
        b=mGf3hGyf9TemULbBJqg8AHrWGEsw6MgYtl3ZaZ5kdPpDMbH9EjghlJZxU4nUe/F+Gd
         PTQMrHj/b3PnhZqsaWBxpYDa4hGs1rMJweHbyI7w6b6pIju6bByZlBAVHH5nh3fuaQY6
         PbC61POABTZtQnv352ij/Ya/NJ6cZrzBTtlCdKhvYG+0/wkBFG5AvAEl7MM5ojfkKBP5
         +zmYX5cGM0bH13GwUoMcRqEcfyQk0bEma416liKG0U3YDcD+iacMMOX+9NMUwqRQeH5E
         zde0orog16RIODDmtqPEmxPzuECHWM51sAIl0YK8YmKEYw+ZnRwMgSutnIe6yiUQn/lY
         LCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764675421; x=1765280221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7t1jXNC1DXz9eXr1TkTwgKmmbSmBVZBUechbASQ+QUw=;
        b=unpZnPRyFX8N1WPJAbS8oiviPZJyyxl7w38jmL/zNvWx3N1A8d8vrib8LoAQirZGV4
         FwC6cIIvAr2XnWOt2EYQgoiIwyczPdOX5TSK9Qe3I96/W8/F1b0JlugCUjaV8AgAT5Ui
         zwS9IsKKp50u5LNcLsAtb303NCRPITX66YVDW83+ydbGi0RS+nSZsYFjmxZM+aNb+eOQ
         0lH1vaYyF0rdCoeaLz4Wu23SewfVYmnQzZfcWQNMh4ccMSdHe32+tG5C/nSlLHL7vvxi
         Uoh21ugI0RPVSiHyw3fjwOCDtMbBsHe/IbW9Nplb6V+/p/1camLMzC0OEIStsWG3lPtY
         CI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdsLUQyV4J7GBnHU/kfAcZIsXZgni7EF/Bq4KV7HFG3crvkS/wTnO7+uV0XmL43l/z2961S9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRdhu72K2yEl8gAkQQ7fkfJT6WgDRWS2qhNP1QKZL5Cwv7p5b
	N2DMAtl3rFtUdbsvixDeWKpQOxtTmU8x5JWgDnQYkhG2lKyqNnSkioJqiEd/2usZaF82sRTP0Ad
	AJ/4EZRuY8VX666JgYkUCdtGrxHZQoeabFK6I37XNEFj80S65uMp45oKUag==
X-Gm-Gg: ASbGncsbVwCn0Z7ej9frBM/b9QU4jXw2qloNH5WZ+Kc41zc/ZIcl1M2k0BigISxL2TJ
	+A/xIcAro1WGQUWT/IRSTvtT0vHom7uYmLqT2fauF8j8U5qSiEHfRtddOZo4vYsk3Xgd8uBm4qO
	Z9ro/AR9Ppc0WFEAInFwFvisbaDdzzvk+dhTkO4rRrlhwoXFhK50KjDjtrcODmm4KeQJl4GGraj
	JYSzBDcy3NaKDtIxq3JAtaNAuTniPwL/ZJcXn5uIkWYeXmVbgXZqiz6aMxwVbYZgPjo4cKqQIHy
	7qzQYK+qiISn/HxaeEYSGwoKCQOfPj+EWug52HXOEX5aRTIq1VLSs66j/QO0eZ7EBNuyVncN2DU
	/L4KHM0Dh6uiD0g==
X-Received: by 2002:a05:690e:1596:20b0:63f:9473:4749 with SMTP id 956f58d0204a3-64302b08cf9mr25312286d50.56.1764675421669;
        Tue, 02 Dec 2025 03:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHTTDoPn3D5Le3GWsAcOo7YpmtPqdCHs2MHH0zgAvcynzX0aUZJ6HEg8ueejT6leGtmiPPyQ==
X-Received: by 2002:a05:690e:1596:20b0:63f:9473:4749 with SMTP id 956f58d0204a3-64302b08cf9mr25312276d50.56.1764675421365;
        Tue, 02 Dec 2025 03:37:01 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c4445fasm6100739d50.15.2025.12.02.03.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 03:37:00 -0800 (PST)
Message-ID: <a7b90a3a-79ed-42a4-a782-17cde1b9a2d6@redhat.com>
Date: Tue, 2 Dec 2025 12:36:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-2-maklimek97@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251127091325.7248-2-maklimek97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 10:13 AM, Mariusz Klimek wrote:
> This patch fixes an issue in skb_gso_network_seglen where the calculated
> segment length includes the HBH headers of BIG TCP jumbograms despite these
> headers being removed before segmentation. These headers are added by GRO
> or by ip6_xmit for BIG TCP packets and are later removed by GSO. This bug
> causes MTU validation of BIG TCP jumbograms to fail.
> 
> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
> ---
>  net/core/gso.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/gso.c b/net/core/gso.c
> index bcd156372f4d..251a49181031 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c
> @@ -180,6 +180,10 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>  	unsigned int hdr_len = skb_transport_header(skb) -
>  			       skb_network_header(skb);
>  
> +	/* Jumbogram HBH header is removed upon segmentation. */
> +	if (skb->protocol == htons(ETH_P_IPV6) && skb->len > IPV6_MAXPLEN)
> +		hdr_len -= sizeof(struct hop_jumbo_hdr);

Isn't the above condition a bit too course-grain? Specifically, can
UDP-encapsulated GSO packets wrongly hit it?

/P


