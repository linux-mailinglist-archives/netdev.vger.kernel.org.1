Return-Path: <netdev+bounces-101803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5FF90021B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6495A1C21C3F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA52187347;
	Fri,  7 Jun 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6Uc2teN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DE15ADB3;
	Fri,  7 Jun 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759637; cv=none; b=UgdwfQW1ipjNyfg/ON5/X2tZnkjwnBoljY3jxizMmTW21EZZ4JobmMTbrAyAgZvmmf2iHDONqboKqzidlnSTNMfaS1/pfTL4IjJU+TsElKMIM1mIe3OEK2yKQDQcPd2Vf3frZ5Gms34xzw8HKAMN1Ncz/xHHaTFObrkjOwFt7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759637; c=relaxed/simple;
	bh=J05QWbbiw+VgL/MK4wms+4MGEX63h3UCS8wgStsYmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxRyemsQUW0qoGUkjNkVxgVvoibpJ4sHGA0nfGi0vajh6UF+0gjs1lJp536bfV2F8crYmyo04/wNASygtZpCjaij0D/A/hqnH9xrjGFJmi2Vp53hRcBX8jWt3UdlWVou/gN000xI6w2bA2+22EKA1FB4ggTQaBqNmeonk7SLMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6Uc2teN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eadaac1d28so13719191fa.3;
        Fri, 07 Jun 2024 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759634; x=1718364434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O8PWUHgswtnudfxQ4Sax/Sp/jhho0l5dtDe9E7a3bM=;
        b=M6Uc2teN2G+Q6/lXaZdQikXeOkA6ZGsy6DsS3wif2Eda2OQKGSCHRl0EGqd6fefaDO
         ZQnjMOIIeYO7Us6zKVSxN0yjQ0sBggnJT4NP8IMIGNVVArGzzUvqMzLAHb2oYAR172ug
         +nctpJSQ5A+KBMenkeMQKEydL4JR/Qfi4LUc+mxaDd//quV40xPZiNtQzWF1cs8MWqWY
         5FFQfNX5uLD301leEOug79T+1yvaQBJoxVVgZVOGvgEhdBnmdS0yWf3bohqMnelbaUs9
         FV9m90JUBQO7lMZZVCVw7cPhpeadCjukUWw8de7w+rKgh3Wm/ObMgpdaOverIYmk4w//
         saGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759634; x=1718364434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8PWUHgswtnudfxQ4Sax/Sp/jhho0l5dtDe9E7a3bM=;
        b=b8W77/1BBh7BQQkbKAqtLJu5O2xn73gPPvPcD6bcgTxmHsreWJQK7mENDBEF/TBJIL
         Yfznraoudd73ysUoG8XBAh10vgtqKYdY6i+NmZalR8gRzhzS7OB5O98/3sA2JWLjSkA0
         FBxrCYOYZABhXma9kznZQZr8Z9nJcHQNNscUx+01Q2bXJdEffoS03gV3PYcimXjuCT+1
         A/A4vBFf4YHMyFC1v71ht2j2vv6poCDoff4RuniH7CKqE68SnsRhwP9EL+KiANKQZGTb
         n1ytAQE/TwR363dKvio2X8UgudjcbOAeAjXgbYBmwex4PdzMDHPN+3LGdOiO7vMw0oIF
         Of2g==
X-Forwarded-Encrypted: i=1; AJvYcCUcMFCC/pDp6l84KZHQUsStsTvpotE29eFqEpbXHvcCrcdBrhG7bMhRT++KFNzYCNdnRTlNhp33rt5TuzlLylnyWdIyzY7CfbV1SuDfHpKd0GpjJ80CftESAyr26e/DGevqj/VZU319Z4ofLJ85SXHPv1uzoWf51kkjpebfqxGJoQ==
X-Gm-Message-State: AOJu0YzBcfgDSMQDOFTQpBX2KTavzfm+NWfdMAeZjT/c4On5GTvc5gTe
	HIwF2y1hYJRB/wYcJBTckamDLmlEsnJ4Gs7aB5LxcnRYI7KQuEXc
X-Google-Smtp-Source: AGHT+IEm4PlMM5a0ezDNwQ+BL+xESu9UWDny+jAb9AZVTsOALuaSYaPxKESuoehsonsvu/kH+e/j1Q==
X-Received: by 2002:a05:651c:2119:b0:2e9:4a5b:b6c2 with SMTP id 38308e7fff4ca-2eadce74611mr18005101fa.41.1717759633358;
        Fri, 07 Jun 2024 04:27:13 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202965sm2605980a12.77.2024.06.07.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:27:12 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:27:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/13] net: dsa: lantiq_gswip: Fix error message
 in gswip_add_single_port_br()
Message-ID: <20240607112710.gbqyhnwisnjfnxrl@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-11-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-11-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:31AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The error message is printed when the port cannot be used. Update the
> error message to reflect that.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index d2195271ffe9..3c96a62b8e0a 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -658,7 +658,8 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
>  	int err;
>  
>  	if (port >= max_ports || dsa_is_cpu_port(priv->ds, port)) {
> -		dev_err(priv->dev, "single port for %i supported\n", port);
> +		dev_err(priv->dev, "single port for %i is not supported\n",
> +			port);
>  		return -EIO;
>  	}
>  
> -- 
> 2.39.2
> 

Isn't even the original condition (port >= max_ports) dead code? Why not
remove the condition altogether?

