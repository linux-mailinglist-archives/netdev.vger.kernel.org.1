Return-Path: <netdev+bounces-198117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0061ADB51B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0DB7A542B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8531E501C;
	Mon, 16 Jun 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="t0E3nMNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB781DF749
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087097; cv=none; b=B3GvUYtit/UWwalvwkYnx0ToqICa9rjcMRPqTV2wIW++sohOBB4OeBV9W810xYjFDcTO5k3QB93X4flUlANUH67dgw54GiCpX+V/Zj/4gTnOlpj0eWcvjpuNGEvCbn6jb7+4eZWv8cqMS1nXjhiFEj7aV0nbTPtHmKd07ts3S9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087097; c=relaxed/simple;
	bh=0Uwi5HcvGSgIv33Xf6N3b39LRxabNPsVu39qZpDYCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsv4bCKqyM3P/h6mBP+Q3qnsGzbKdhgTHRsPH9Bd1ZFzogKHxcyAGa4A98SuKwd8gYgZegy+ID3GCVfjJMq8HvooGC2h0j0t1YthhTGQd9QLt4X2dg4nyeUDFWptfwqqHpYfhfwVj3snu3sWkLnaR4IuQ1g9a6hugj7Uk5MMWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=t0E3nMNi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4389833f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087093; x=1750691893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWtX9vXAE4ylrzNWM+gtRkVXqnOFx0L8cYcLFK9zXB4=;
        b=t0E3nMNi2s7g6juabHyfHWlSvMdnK5BXsQ26jgq4NtPZvXM0X6FPKzrdL+mzSAZFWi
         ohwhGAx3l3hyEWjRC5h3zFfBisZWS1lgM4EorW9OYf7BlUiABwrN19/Q6tYUA1x49yQr
         D6xfaDgObiAnRk1mYl6xj+jEr2rwGXpp7cokcyknSrz4kHa3N5avxoFqVjzYRGVGwUgC
         QUj//5/q/GsEUWjIGqy/GChA3FCf5HnQRZko9pP0WGJzNIn1W1e3AqgNGTNoi7u4LKuh
         ffIUp7eJe4A673VqE7usfg00TXC4br3/X8MvW4rBqV9W1WO2/MC7z3Xd/IvtG+/IY71O
         VojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087093; x=1750691893;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWtX9vXAE4ylrzNWM+gtRkVXqnOFx0L8cYcLFK9zXB4=;
        b=ZZpOIE2r17Ygs3M3IjMawLfmk/ZcsmKXySKrGvr3SGBzKwGa4SpQJfP8tx8vc2Sf10
         tO/WoVVPwrcSM7Tei7r3GmJwuScugFP4SNZoPZndz2oqv83wIAlZ/VXBNWv+G0XelIgw
         RJf+vHhQB8E3cCcy4kKsPv0gSCX+aJONiNse0bNUfnH7UjOmxzEBAIGQaxYJ2O/YmnnO
         UOhhzpg0nz8Jmk8b9Ieni6caNUe53YrhLSxG64Qeb9UmQSJpHJYf2jcnK0s9d9zN8z1a
         kusDUvFF42p4rQpTLuwi5cx3DK8j3+j6amoy+S45WUSgBBBXwlu1GjZj5I1cjzmqlsPD
         WAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiuMPqPE54FQCpl0Qz1ZqD39QDOn2JzGhFEbynirxJTht5xlvfTjKO9mRjxauGqLuAsystFrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUtGif4Gsdp77CktcltMsCmQk2nwxP2rIiVYcLItqqerjnbce
	PceD/BjZ5KAKoXnSHwumXfDj0WUYm+kMYRPAccyWOeo2tx1w7g4lntSRhScwKpEcvCQ=
X-Gm-Gg: ASbGncuDMEWsqU9yfLgx5zDENbLQVznS5MKjwgJcmQVzUlMPn7Tvj2GWFrFs7+03LzH
	ipdbPpAPIKETFiUNVzsvLh+TbpkhML6DJbtDjA7tEhRV40+QDrEMxnypuFBG/2wmt7QpSLb2U9+
	1qnxTCBliP8qUlhVBYE5OAKTwHvcicpQXaAodb5b2tWg7lXKFnae+vHaVPt2hLRPTSRMgQWwBg8
	9OwbrQPm7curHJ+GP9xr/dtdcQcjgaYMvOsfadur8aoWYNaCJjGl9qLibMIj0t27p7s7QSchZQV
	4+78GowC+duuGbXgX9gwjVRY9W36rOU1Z8RalbC8Kt0Q3LItHoS1pxRnkmzNxcaD5syTJtA6yV4
	G0w==
X-Google-Smtp-Source: AGHT+IG2wziWgDzPPtUiGHhkgZrnXbFFCxJ48YmTR61+iBYCNtEv6FH/PDzXC8sc2DbQNu0Loh/3kQ==
X-Received: by 2002:a05:6000:26c4:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3a572e99553mr7820909f8f.51.1750087092712;
        Mon, 16 Jun 2025 08:18:12 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e232b68sm145949525e9.10.2025.06.16.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:18:12 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:18:09 +0300
From: Joe Damato <joe@dama.to>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2] Fixed typo in netdevsim documentation
Message-ID: <aFA1seeltkOQROVn@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Dave Marquardt <davemarq@linux.ibm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250613-netdevsim-typo-fix-v2-1-d4e90aff3f2f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-netdevsim-typo-fix-v2-1-d4e90aff3f2f@linux.ibm.com>

On Fri, Jun 13, 2025 at 11:02:23AM -0500, Dave Marquardt wrote:
> Fixed a typographical error in "Rate objects" section
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
> - Fixed typographical error in "Rate objects" section
> - Spell checked netdevsim.rst and found no additional errors
> -
> ---
>  Documentation/networking/devlink/netdevsim.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For future reference, since Breno gave a Reviewed-by for the last patch [1],
you could have included his tag since there were no substantive changes.

In any case:

Reviewed-by: Joe Damato <joe@dama.to>

