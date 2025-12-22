Return-Path: <netdev+bounces-245696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0CCD5D53
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8250C300C170
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46E31A579;
	Mon, 22 Dec 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrniaUU1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ra4/gW8i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67C3128A3
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403775; cv=none; b=JtiI+ceHMYw0P3If209x1YDpkL7qBCT+vRk/UYZbgIt3n2r/9yLPpMeIZA8LiVPeUFFXy6A+bZxdCaJAe84XbJHEU9Yk1PQ4KcE2V/0RolgsFKHpfNnKPJ8PCZ7PqaoYKq4wIz9JRZY5Hoxjs+ZcxwZwKvWRmtfYaB0amoTqg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403775; c=relaxed/simple;
	bh=LC5Es/H47EQiWgj2ATM095BYi7nqSkflTvEx1KYBu5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMCRb0Cdp3R3ny8sC3R+q7PqJRgkRcxBNwykcl9m5CfTrnOjpjxrsVUhfW9xW83nVELMfHYR8y+sz5Z7Tt5DQJH2+LLsY4o9oUyaGT66iY64/+tTK9MzGVBf+BW15oL6SY8G2A8/WA1tJGY6j0v0YfA2/TZMu2XLLws1/acapyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrniaUU1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ra4/gW8i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766403773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL2rPpTN43V/NT2Oxv6ZcxzlRknVU1jWoTmSb8azg6U=;
	b=RrniaUU1dHADX4ZiF+f/d9q5WogwEo8IjYeJF+MZgfowZRcebXeZg6h2wxU/1tS0FFpACx
	u4psvBS7Bay4pWoiYlKNx0hHD8ehBxJbUGKR2ZAduzfYpZwgh0aR09d1BqaAmtbNq+S+69
	vr/kwnw7ueEt/tkFBfPCIBhwvEooXYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-0plPZcNoMsWJ9aeoJXKmFg-1; Mon, 22 Dec 2025 06:42:51 -0500
X-MC-Unique: 0plPZcNoMsWJ9aeoJXKmFg-1
X-Mimecast-MFC-AGG-ID: 0plPZcNoMsWJ9aeoJXKmFg_1766403770
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779981523fso47491345e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766403770; x=1767008570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL2rPpTN43V/NT2Oxv6ZcxzlRknVU1jWoTmSb8azg6U=;
        b=ra4/gW8i529+LX1zAj+sFr6roXU6npsp7WYn5b2wsvMi/eaAmbXQ0DaDC+RgcYQQ7q
         pCPolFoXB98P1ky+CmMPGoJYub6Uqza6kFK642o1uvohCCi+NdUb2rFEZ4yETrHhh13x
         7xSBbezcVcey81p5iKfZXD4Lx9SDbEfMA6LYi8s67NelSQBolJsQ7wK3Qux0QbTy+mKx
         vdPDZWrnRVAcbhkCLQfk92eSUZUVK7NQOoGSylv1AznMr3BT9YLj5FtJfFP2KG0O3tli
         G+D2tBYLuxDsYg+z7UnzsmCoA5ccisbpQL/5I5SL9IwmeWeqrPgSAz95bjjRh9nIYBzH
         j1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766403770; x=1767008570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OL2rPpTN43V/NT2Oxv6ZcxzlRknVU1jWoTmSb8azg6U=;
        b=fJFJ+KxMPlZMPhUtNB7tAr/GV9GPtymuXmpN4jE9zlb/q5qeg4RJ9PrB4wp/SxwYBu
         5jkZo//FrdBhsTz8keISx0CjeARzfisqqWvWTcx8uDidHJhHWHD+RyX19ZOg9nUrO4WE
         xXBeXYTlJnZR7k2s15LkR9LjYNP1HqwyuHTDwk+l2cjnn41lXlH4hOoIlTvc4dlJ0uSG
         SlzuarYKL92UQKAfVypy9Xy/kss1papN5szRONNoKG8FQyu/6T8hBXcPMNdaoj8cTi6P
         gomA457o91i8PmNqpg7w9g+37fs35lttOHNrxVOBqhRI6eTZX5RcEXe41cSNET4pkxaR
         agtw==
X-Gm-Message-State: AOJu0Yy1yUGKpSnmBSttr1a9BKWyfUXAoslbbUTIXfHO5y8QZwQKsuI8
	ADCbA/GR1MXiAHLE1M2rXbfwnNxlSh9jpauzsX7SQt884Hf0qRXEbKKArGP6WJjehtwbzrEjXlU
	W3herR7rCR+tb0TDlG0e2h0xsrg97Tapg9h6i6AitG9HiplFYt+3Q2iTDzQ==
X-Gm-Gg: AY/fxX5UFWXYuNbPklwsYWnfmt98svutwTvufeF2PMBxvU21cBncvHSY8G+7vit4+xw
	Bw1liNNtbmnVMUDcXbuKqKs0b2pOH8QeddiFHfo4exVsE8Tj4WCFUpgWvcAq6x5OG0U2Xshy2/E
	fMnJYGsrBphT47+CXuTvpjk/7pbv0xtFjyvs+gnf8jnnUkNnlEVI6Z6OHaphxG4US0WBta70VFF
	VqjoPtD+CKoavcyH5jHcPCYolmjQr2FpARLHR6i6/KRC/MFojILSYZOqPi7ZGav4VuAF8VUJxQ5
	AdMXSAoj8tBQ/aGTyfxsDhJ8oPr//LahPIDHXzfmoS/XTzAhP8mCliMZ2whhDakrOknKQzFr5tF
	wmb7jUpnwlu6f
X-Received: by 2002:a05:600c:1c98:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47d195a7351mr134797385e9.21.1766403770242;
        Mon, 22 Dec 2025 03:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaGxZ5s7QwvagSljRfUqA1tEtTHBTejTtnXxbuyyLQTAicT6p8TfzcBFjNe2w4AsD9SZ8jhQ==
X-Received: by 2002:a05:600c:1c98:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47d195a7351mr134797075e9.21.1766403769866;
        Mon, 22 Dec 2025 03:42:49 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a541d6sm92914235e9.8.2025.12.22.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:42:49 -0800 (PST)
Message-ID: <e3f77ae4-e612-4926-bd13-4fe174079768@redhat.com>
Date: Mon, 22 Dec 2025 12:42:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipconfig: Remove outdated comment and
 indent code block
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251220130335.77220-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251220130335.77220-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/25 2:03 PM, Thorsten Blum wrote:
> The comment has been around ever since commit 1da177e4c3f4
> ("Linux-2.6.12-rc2") and can be removed. Remove it and indent the code
> block accordingly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/ipv4/ipconfig.c | 87 ++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 45 deletions(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 019408d3ca2c..d577ef580f8c 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -705,51 +705,48 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
>  		e += 4;
>  	}
>  
> -	/* always? */
> -	{
> -		static const u8 ic_req_params[] = {
> -			1,	/* Subnet mask */
> -			3,	/* Default gateway */
> -			6,	/* DNS server */
> -			12,	/* Host name */
> -			15,	/* Domain name */
> -			17,	/* Boot path */
> -			26,	/* MTU */
> -			40,	/* NIS domain name */
> -			42,	/* NTP servers */
> -		};
> -
> -		*e++ = 55;	/* Parameter request list */
> -		*e++ = sizeof(ic_req_params);
> -		memcpy(e, ic_req_params, sizeof(ic_req_params));
> -		e += sizeof(ic_req_params);
> -
> -		if (ic_host_name_set) {
> -			*e++ = 12;	/* host-name */
> -			len = strlen(utsname()->nodename);
> -			*e++ = len;
> -			memcpy(e, utsname()->nodename, len);
> -			e += len;
> -		}
> -		if (*vendor_class_identifier) {
> -			pr_info("DHCP: sending class identifier \"%s\"\n",
> -				vendor_class_identifier);
> -			*e++ = 60;	/* Class-identifier */
> -			len = strlen(vendor_class_identifier);
> -			*e++ = len;
> -			memcpy(e, vendor_class_identifier, len);
> -			e += len;
> -		}
> -		len = strlen(dhcp_client_identifier + 1);
> -		/* the minimum length of identifier is 2, include 1 byte type,
> -		 * and can not be larger than the length of options
> -		 */
> -		if (len >= 1 && len < 312 - (e - options) - 1) {
> -			*e++ = 61;
> -			*e++ = len + 1;
> -			memcpy(e, dhcp_client_identifier, len + 1);
> -			e += len + 1;
> -		}
> +	static const u8 ic_req_params[] = {
> +		1,	/* Subnet mask */
> +		3,	/* Default gateway */
> +		6,	/* DNS server */
> +		12,	/* Host name */
> +		15,	/* Domain name */
> +		17,	/* Boot path */
> +		26,	/* MTU */
> +		40,	/* NIS domain name */
> +		42,	/* NTP servers */
> +	};

I think you additionally need to move the const definition at function
start. Besides...

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


