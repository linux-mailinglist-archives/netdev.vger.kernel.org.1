Return-Path: <netdev+bounces-193226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB542AC2FF8
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8CD9E1072
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E1C1DE4E7;
	Sat, 24 May 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixVvdNT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A317B402;
	Sat, 24 May 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748096317; cv=none; b=MwZB82N1Szp5tjqtZY3PQColHGcioM5Ld6E8U8wn6OsIgt+u8fSemyUY0bOIyOrvm/MNNYz74dxa5KcH062V8PVnFivL30+l+7Y55N3UneM9yrYIbLfJ5i+EXhQngavfh0863/nQL/Rm6B1TXldlreBGXdEYAFvxnDcZaPW/+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748096317; c=relaxed/simple;
	bh=Fje1IWkF5DAWqqJlSc71din6EX68HuRRYJLfOd6yges=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A24FgIAPmLqnVuG+yWBGAMyfU4cL9frWuArr57fFILSMANKRGIrOosa9a3e9GrLMCcEK81RvreToL95ebT84j4+JS3ZCjG2sEGa9mwKPFZ38Iinz1P1cGvCxH17juMvSCOnLBavKmkS0s+rNgzWiVIiBxbErYMUfqnsV5r62eIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixVvdNT7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4769aef457bso9620011cf.2;
        Sat, 24 May 2025 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748096314; x=1748701114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FV/c03q8EvdsPIJqLZEm6rPEVvmTmkh9EJsmPCeIoY=;
        b=ixVvdNT7P2Bqos7RjBQI9QxP6salW/YQav2XaBbc0ltNH2e7P9PzI5wZKJDNAo1DCQ
         uoBv869Csp/ErXOJheBw9GBlOKLZG/lACFyHKVvOV5xu5PT8m61nafzkH1SlLN6SjjXj
         pYzf1awN9eECEaCx674DesM+wekYIJrH/7nIeaXHpQOMi8lwRDUGYAfFZsJ51kLWXxpY
         sNmfeTDrAf3X9d2hyFy7SK+KvzgMLvI2noxZpa/U0I+stUG2c1fMoaAHvNAnVn+reSuh
         yx9jKyxB6CqOEbqFPFO5pskBoFvDX7LKtbV7tWjsCFVqQwvhbvTXr/qScayMkIBRoXle
         gf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748096314; x=1748701114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FV/c03q8EvdsPIJqLZEm6rPEVvmTmkh9EJsmPCeIoY=;
        b=mHCMycb7RAw66eky4lLHFqyIw7xP8IcayTH1Y90Dul6+/C9hQ72/Snr4pcSYopD7RN
         IO9Ji9G9B31xIiuY9mLPYjcLAaK1aztTJPFPMDIyNfPADvkZWhvkI3rRQISypdVrcIV+
         rQrmQOns/m2XAgZ7ISbhXCfDVYO9ga7EyZP3Q9Ud8GQYZ01CGF15GLtWbk/FTcjfI703
         JEfs9ndHeop23q8Xuv3+VrAZFs10rlfKwLtxTiToNi4B/bIGTW9nOwIzeh2MABFmc7BB
         WrPl9hiAnzVJdr0UAJaV5O/NQfx76m6Q3MrSukHmyqGyfrkmJJBO4JlgdJrZeSw0RYMr
         eJDA==
X-Forwarded-Encrypted: i=1; AJvYcCVx6WYGzlBucD0rcPyq1gnJBIbT+/u9o9zws++g/WY5En9BgWmzUgJACZR0wgHfvrHm23Ruo6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52s1GlsC62YQ2yI8lCXrBcmjWNkZjKaU9XgnTaE4XzHYPkFUy
	WjLT3UMRQxPTNA/od2DSGYD0gxV4BhuZWNx3NrfY8mi96gEaNcwtUdr2
X-Gm-Gg: ASbGncv5b4IiJ7FHOn/XAxs4SSW0WA2Wus31ExCLakShiwjdPrswhSvblJhNGcoC2ZK
	4tQrzY2jbFnD7a7GvDckt8nqMLpXp2hgiMTB4XLPc5pMD3McFkPfTiBS87aMLR/VOBsmIsLVWIt
	9lyyo0HRiNksF6NmRXDQMcA2drTXD73wp9Ls5kecbqXc6dOaGI4KXeBc8xrxQDLqumYH1eEQJrv
	Bn4UJYvWOyrBu5YK7jzDyOJYtorqKwyvmTw3AwWIWoTNWrd2gebxmmy1yzp/6qUGHYIg+Y0+2Ui
	GV0e2uGPr2IXOUrFNWtcJ9pvfv0DGnCRKDWncOqr9tcmCWW4FV/Uoi1Rha7t3Tnkwg3yWjI4en5
	T4Quz5DOgEbHPEa++XQfFMKk=
X-Google-Smtp-Source: AGHT+IGdtkpwayNnipXyzxgtiwvqSJW9xN+QrM51O7pgKhdxVswsVQzyFybG2MmmMFSbBoY/+EUDVQ==
X-Received: by 2002:a05:622a:2449:b0:476:7806:be7e with SMTP id d75a77b69052e-49f46056c9fmr66223761cf.11.1748096314324;
        Sat, 24 May 2025 07:18:34 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae4277a0sm131998601cf.43.2025.05.24.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 07:18:33 -0700 (PDT)
Date: Sat, 24 May 2025 10:18:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rafal Bilkowski <rafalbilkowski@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 Rafal Bilkowski <rafalbilkowski@gmail.com>, 
 alex.aring@gmail.com
Message-ID: <6831d5396ead5_1e734029446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250524055159.32982-1-rafalbilkowski@gmail.com>
References: <20250524055159.32982-1-rafalbilkowski@gmail.com>
Subject: Re: [PATCH]    net: ipv6: sanitize RPL SRH cmpre/cmpre fields to fix
 taint issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rafal Bilkowski wrote:
>    Coverity flagged that the cmpre and cmpri fields in
>    struct ipv6_rpl_sr_hdr are used without proper bounds checking,
>    which may allow tainted values to be used as offsets or divisors,
>    potentially leading to out-of-bounds access or division by zero.
> 
>    This patch adds explicit range checks for cmpre and cmpri before
>    using them, ensuring they are within the valid range (0-15) and
>    cmpri is non-zero. Coverity was run loccaly

No indentation on comment.

Also in networking please add target in the subject, here [PATCH net]
 
>    Fixes:  ("Untrusted value as argument (TAINTED_SCALAR)")

Invalid Fixes tag. This should here be

  Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")

> 
> Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
> ---
>  net/ipv6/exthdrs.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 02e9ffb63af1..9646738cb872 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -504,6 +504,15 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	}
>  
>  looped_back:
> +
> +	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct ipv6_rpl_sr_hdr)))
> +		goto error;

This check likely is indeed needed before inspecting the header.

No need for a goto if only result is a return. Also the skb needs to
be freed, see other error paths.

> +	// Check if there is enough memory available for the header and hdrlen is in valid range
> +	if (skb_tailroom(skb) < ((hdr->hdrlen + 1) << 3) ||
> +	    hdr->hdrlen == 0 ||
> +	    hdr->hdrlen > U8_MAX)

How is ipv6_rpl_sr_hdr hdrlen defined. I don't immediately see it in
the struct definition comments or in RFC 6550

> +		goto error;
> +
>  	hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
>  
>  	if (hdr->segments_left == 0) {
> @@ -534,7 +543,18 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  		return 1;
>  	}
>  
> +	// Check if cmpri and cmpre are valid and do not exceed 15
> +	if (hdr->cmpri > 15 || hdr->cmpre > 15)
> +		goto error;

These are 4-bit fields. This cannot happen.

> +	// Check if pad value is valid and does not exceed 15
> +	if (hdr->pad > 15)
> +		goto error;
> +
>  	n = (hdr->hdrlen << 3) - hdr->pad - (16 - hdr->cmpre);
> +	// Check if n is non-negative
> +	if (n <= 0)
> +		goto error;
> +
>  	r = do_div(n, (16 - hdr->cmpri));
>  	/* checks if calculation was without remainder and n fits into
>  	 * unsigned char which is segments_left field. Should not be
> @@ -638,6 +658,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	dst_input(skb);
>  
>  	return -1;
> +
> +error:
> +	return -1;
>  }
>  
>  /********************************
> -- 
> 2.43.0
> 



