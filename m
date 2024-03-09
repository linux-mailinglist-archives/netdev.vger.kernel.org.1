Return-Path: <netdev+bounces-78995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9D8773EE
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 21:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C78B20EB2
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 20:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2034E1BA;
	Sat,  9 Mar 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECBTE9LX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344F1BF53
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017133; cv=none; b=owCWtceUDk6C1G2bwBzIY4tDXdgmzfSVp6QN7+jrTVO9Tj0XF8/WCKHXCuGdOeWzGYhLnTrSrPj8uIb/VcaOQgnUZnmE72dqEgz1lj63GuEQCufyw/twwqamIQ/w3ME2q/HyCuekjTxcpU77U0nuKgA9z61pQ1+v00PTonnUMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017133; c=relaxed/simple;
	bh=2xVQ6YLBTJufLI/pUinDakNOFXXAi/CnbR0aJFke73M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2kGAdz0/Y+TKdUBexhgiuEKOSx2YeVcbnRoX3IolzNEScPyDKjfJXEQY2qaXjF+v+E95Qdv7qrKR1N4P1iVs/1dl3+ISYjui7hgvuBblhJ94LqKzVaL0tlArzjpxdCKOyhAUYTFvqpj8I7dntviXY/tP1rxygCgmMhNseDEd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECBTE9LX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2119485a12.3
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710017131; x=1710621931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cSVrzPl017CQylbPoOYG8VdJXWFcmVE4EDs2UuqbY=;
        b=ECBTE9LXQlzDQXbOeXAR0S6fjndJIFe88GjyLMRFeb5uWmZX3puGcvstsG3MnenZI5
         JoWQabF2GMk5TjxbhQOItm+lA/H17L7pUJt1qoM9hERHsVK0GIf1JKiE5gOlpiRwuTUA
         N6Z1GkjKMC1S5+CnprGRg09uzauUR7tStRqME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710017131; x=1710621931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cSVrzPl017CQylbPoOYG8VdJXWFcmVE4EDs2UuqbY=;
        b=CRLT3zq/FreHWF7LLx6NCkadQJKtoNHGrRCwmWruwYAvDRWXuuUmyJ7NHRTElV1WW5
         bdJMrIRcIEljtj3riIKG+TBQGg6Bv8Yl2LE5+2+avoQSqMfYnDa7xZegvRq52ZRP/Nd3
         w0FKkSsphV7KTqtRivrSVeYYPD71BcPiBTWcu5Ssf04TX6O9fq6pkaVcEGL+fx7O7pmx
         he1Fw+0OFaz/L88LfHbLgYhfyHNWTb7nQgBPvF+VrCQv6RnJD305s1NH17L7z9aa/6UX
         lf1Qp/jR443RKAWh4ecKId7yMtREkmsx234/SrNIhuBoNsr/slXtA7TiBlLSgVRNZ1qS
         wIBg==
X-Forwarded-Encrypted: i=1; AJvYcCXgPohVQdrXLQfB4klAuPVNPe2iRpFaok1Nfw1xWOzg/L16dYZ9Hmy0hxxAIr2BkLP0Fqh+ekqXV6RvgOR3Ff6R6EBO5QHo
X-Gm-Message-State: AOJu0YyRhDyUwAZfOg2qEbMQWDRSfGWk6zn2C/8DWKrE6Q50D8CdT2Gz
	kWmcSvmfON/M1BIdLcA/9DVxwA+/FijzBP+wJ0p6hAXwKSznVN/zrVyFmnz1pg==
X-Google-Smtp-Source: AGHT+IEVVeTTmm+IlHRR7hp/Tp6eeDE6zj05vKbKaiwtCd8bjKCSTAtgUYYU7bL+A/ciRLcAq7YIIw==
X-Received: by 2002:a17:903:124c:b0:1dc:dfb7:a6e0 with SMTP id u12-20020a170903124c00b001dcdfb7a6e0mr2665355plh.50.1710017131440;
        Sat, 09 Mar 2024 12:45:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001dca99546d2sm1696286plg.70.2024.03.09.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:45:30 -0800 (PST)
Date: Sat, 9 Mar 2024 12:45:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Satanand Burla <satananda.burla@cavium.com>,
	Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
	Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] liquidio: Fix potential null pointer dereference
Message-ID: <202403091243.99279C61@keescook>
References: <20240307092932.18419-1-amishin@t-argos.ru>
 <20240308201911.GB603911@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308201911.GB603911@kernel.org>

On Fri, Mar 08, 2024 at 08:19:11PM +0000, Simon Horman wrote:
> On Thu, Mar 07, 2024 at 12:29:32PM +0300, Aleksandr Mishin wrote:
> > In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
> > but then it is unconditionally passed to skb_add_rx_frag() which could
> > lead to null pointer dereference.
> > Fix this bug by moving skb_add_rx_frag() into conditional scope.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 1f233f327913 (liquidio: switchdev support for LiquidIO NIC)
> 
> A correct format for the tag above is:
> 
> Fixes: 1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")

FWIW, I have this in my ~/.gitconfig[1]:

[alias]
        short = "!f() { for i in \"$@\"; do git log -1 --pretty='%h (\"%s\")' \"$i\"; done; }; f"


then I can type:

$ short 1f233f327913f3dee0602cba9c64df1903772b55
1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")


-Kees

[1] https://github.com/kees/kernel-tools/blob/trunk/ENVIRONMENT.md#git-command-aliases-gitconfig

-- 
Kees Cook

