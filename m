Return-Path: <netdev+bounces-143131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451989C13A2
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3141F22B70
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E27462;
	Fri,  8 Nov 2024 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9EmM7Ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2905629;
	Fri,  8 Nov 2024 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029426; cv=none; b=C31uvZslwAIiQCuRwC0ko7YEZRwvlYNViadgCCpeFvRmv/tFofZQpU0+Dsj8zgBMe0QvVslJ07hIgPyIOe89tvw2WbTH4dmag7Bdc1dJOperlOr7GgzLpr2BasN2N6Fl5oyFbR38wqVZrniTLEPSLvk5J/TUk5gkUKlqg0Ik+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029426; c=relaxed/simple;
	bh=S/9/j6FUbIcaR9RHlMMQB+PgLnJTmy30591468e+I04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeI4YT3NVoovrN5V+/ypHKq6q42ZwnOuYLPF60vB/RLJ3Gfi7Y7GMRpA2MxcYnyJPG5GdhugRV/bCt8pnskHwwNcmv+E9hhA5qfiFdx5xJwUkJFUuwzSgm5BB3Gd53jUDMaGlpCvKBjnHwHwwNqeMXC7eJSlB6qA2fGbB2eJfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9EmM7Ng; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7206304f93aso1444609b3a.0;
        Thu, 07 Nov 2024 17:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731029424; x=1731634224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UioVIAhAAoIIRLR5ZHxhfDYGKnHy3tOSVMJqhMhhZ3U=;
        b=R9EmM7NgqM6C6BNv6/hi9EM8DKWUWPxuivWU75NoI4B4E0Yexe0lMm0f2CZwHri1Cf
         NHQePZcsDOfvFakk8z7X9EOYfZIzf6LVCNBWyxgEQwDNCQeGuXZgCGcVsnLbNdqq8b9T
         S279DsT6Kk2ufVD2fH11KZGOdvr3xG21dlu2H0CY06WJ9zTKGyAKmT3NIVpXrwfONGtR
         IrSfcIe5TKvJylwpXued+czERhQnu4Pv6NAfovD6dqH7lHQtfSFr6JTTcDhT/3kXZ6l6
         zPy2w4p3BYR5rxn4/vDyq7XbXdDkWvbWzH1YZloJhAe5OVpDkG8wDsgcXUKHFMW4U7Jh
         7VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731029424; x=1731634224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UioVIAhAAoIIRLR5ZHxhfDYGKnHy3tOSVMJqhMhhZ3U=;
        b=enESvXbTfmRNujcskJYF926LzMO+MX3kofhfE+zezjA/FN721QMTw6DhAMPnxvY73h
         6pek1//saYLiQcJA+BbuJ3bYlPvsWKPhmBA2WFfPWxXAOng80ZflsUE4l75Xihg6IDD7
         mKdWrWfmEJ4BPiOvPMZV/Ps2sHQyrCUqIZPAqFlXQKdMAzEdQQUjfQKxMCckptxkrdGw
         utV7rM6ZgFBlNb6OwhPNJ+Y9bZOxnQDgqjk5QRGRfgf6Ffmex7gvosGJclGU9/uF/uTT
         NeBXRSfr5iEAa2V5BiDXzKUu0OTSoavWXCwPTL6ZKiTmtUzBhtu9ZxqiI2O6SozcyhjE
         FjKg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Zm6LS7rgEiVVtjiivcE9pc/wCyUt7eAWavVv4k3E03zL5Swp1CyVDJsmHuNSZ/PJekY6LyPZ7uZdATLA@vger.kernel.org, AJvYcCWQrWzlpSbPs2nCHolY61jf08Rz2jIhvivByUi5TjzHzTxFCTwLHxnYD8NTXvxvo5hXU+AgqsQXUa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWaM4t2UpS1zFEtg2RZGHFU5la3RmHOJcFzbn1iAagZWKLw6l
	XzUEKghyE5iyD/SpfeSEqVqNT0wCJF0g4KEYx8ZMK5KcYMNHaTg=
X-Google-Smtp-Source: AGHT+IEi5xYPuOgwt2ax1Vo18EyjHVIaR52TiXVG+znK30AfG2Dz1ycLcP86zYWCDNPMRplymaw21g==
X-Received: by 2002:a05:6a00:114f:b0:71e:b8:1930 with SMTP id d2e1a72fcca58-72413380e98mr1576712b3a.16.1731029423986;
        Thu, 07 Nov 2024 17:30:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078cd2bcsm2421405b3a.84.2024.11.07.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:30:23 -0800 (PST)
Date: Thu, 7 Nov 2024 17:30:22 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Yi Lai <yi1.lai@linux.intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net v2 2/2] net: clarify SO_DEVMEM_DONTNEED behavior in
 documentation
Message-ID: <Zy1priZk_LjbJwVV@mini-arch>
References: <20241107210331.3044434-1-almasrymina@google.com>
 <20241107210331.3044434-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107210331.3044434-2-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> Document new behavior when the number of frags passed is too big.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/devmem.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> index a55bf21f671c..d95363645331 100644
> --- a/Documentation/networking/devmem.rst
> +++ b/Documentation/networking/devmem.rst
> @@ -225,6 +225,15 @@ The user must ensure the tokens are returned to the kernel in a timely manner.
>  Failure to do so will exhaust the limited dmabuf that is bound to the RX queue
>  and will lead to packet drops.
>  
> +The user must pass no more than 128 tokens, with no more than 1024 total frags
> +among the token->token_count across all the tokens. If the user provides more
> +than 1024 frags, the kernel will free up to 1024 frags and return early.
> +
> +The kernel returns the number of actual frags freed. The number of frags freed
> +can be less than the tokens provided by the user in case of:
> +

[..]

> +(a) an internal kernel leak bug.

If you're gonna respin, might be worth mentioning that the dmesg
will contain a warning in case of a leak?

