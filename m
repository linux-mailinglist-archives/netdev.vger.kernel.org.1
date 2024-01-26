Return-Path: <netdev+bounces-66139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5283D76D
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E2929FB5E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C81B582;
	Fri, 26 Jan 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKiNFbKP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724341B94D
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260927; cv=none; b=CqI8+xKchB5uqFMEybtvhZ4rCCkKlf+yeQuXNgBRJjvhp4GT3NJLNA9vmITzIChx/DR+sN6JMQG9Gk48EbiUF390fub9DKYEnoOWTdHgMG/gVdYo5ZBUnjDChZcBdpbzPRn4R/4r7ahnmNe0Vb2h7JsG84TwpkS64TpLBBNz0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260927; c=relaxed/simple;
	bh=8VuQJQ/LbKKyBH8L8aOeX+wDqokfhQNjKOn0vYiJ47M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgqbHefO/5rXu/7I92b3hij/O2dfjUjkluW5h1PWenPKPFiYZ2daalFoU18gKH63Byy14yCs9v2eJRmh4wKEVtLCxhlGyjg3Ocr12XSVvHG9fenCapyq/aR5z6wLjOgHTKeYU944C3FVzLm1lWloC8YwPrjqgFRombPdcrm9mcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKiNFbKP; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bda5be862eso332184b6e.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706260925; x=1706865725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3liS84clJwp9yv2JprNwEDWQHC6chMV+FL0K4jjBCCA=;
        b=NKiNFbKPwebc44SXj+s6pOSjX6SUxLTNQgeQ4eg4V9Mpj9NBezHnP5opKZd8DS/3Uw
         Qn/3V35HdfXbzEqng/6s96AiW+o11gA8KQ3atWJ3y2jyZZY5cGdU1Nto31giV204NwMu
         7DvHXamjXmvx2ZWPe+nV7vd+nZ9+kjwqHvsfCRCNHW6LU9nj0AG+RSWnAv1+6DMsua7h
         HdSAlb2faMeOYfryeIfNxTHkhGF0DMWiW8rlLqCZMUL8nrk7wX41WM+oX4sqzkxeiylc
         Os2QwS/JaFMOL/VqO5mSTuEkKC5FlDYkGNz8dA2YuJoaOGIMmhgJaFuGzNbkzsfa8UmO
         7bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706260925; x=1706865725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3liS84clJwp9yv2JprNwEDWQHC6chMV+FL0K4jjBCCA=;
        b=wC2HQbZhS5SwrIGLOwScHFt4wM2PEPdnrGaP8/DEWtJZuDmG4oqdq5MVqRF/BaoX2W
         X4KL39i0RECTXME8Pwng7H4Ki8HvqC8G7Tj9yUtBBgPoOoEpxdrrOZkFBdXaBPWGWRc4
         pbx7ytGxFMCwUyT5I7m4e1onjy1uZr5hMaHmC9h3u3b5OasW3bJ7YesTdel6IYptCMs2
         oKkvrzzJrDusMjsAYLd6jRdsOWbHk4juciMNSSjo5jjuOI5zhH6p3dX6amPRID+YUg3i
         PSRAoIOpkQPHWxbGV8968mfb0l0S0yhPxhkN6YPe1Osa+hkeBbAvnbO9XQsUFa1A612T
         Jf2A==
X-Gm-Message-State: AOJu0YymTJuCpQ8Ax7BzA1V9HNHP0XSnuSTEnUe5QlM7nh5MUBLejuDv
	gxPwZ1gPdemER9sHWw0CvXYd1j0IRuPsx44Qdg4oaPCrr859NOx8
X-Google-Smtp-Source: AGHT+IHRuoZIwLzZlCGIz9JXGEA1cA5HXBYDolAP8hbyCOAiSbVCekv/YLd2CwTRq/o3g/e0H5aVAQ==
X-Received: by 2002:a05:6808:628a:b0:3bd:df10:9cd3 with SMTP id du10-20020a056808628a00b003bddf109cd3mr1104200oib.97.1706260925428;
        Fri, 26 Jan 2024 01:22:05 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e17-20020aa79811000000b006da022d1bc8sm726277pfl.25.2024.01.26.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:22:04 -0800 (PST)
Date: Fri, 26 Jan 2024 17:22:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net-next 1/4] selftests/net/forwarding: add slowwait
 functions
Message-ID: <ZbN5uAeqEKJth5Jv@Laptop-X1>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
 <20240124095814.1882509-2-liuhangbin@gmail.com>
 <31c8afe0-86fe-4b39-ba7d-a26d157972c9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c8afe0-86fe-4b39-ba7d-a26d157972c9@intel.com>

Hi Przemek,

Thanks for your review.

On Wed, Jan 24, 2024 at 02:25:57PM +0100, Przemek Kitszel wrote:
> > +# timeout in seconds
> > +slowwait()
> > +{
> > +	local timeout=$1; shift
> > +
> > +	local start_time="$(date -u +%s)"
> > +	while true
> > +	do
> > +		local out
> > +		out=$("$@")
> > +		local ret=$?
> > +		if ((!ret)); then
> 
> it would be nice to have some exit code used (or just reserved) for
> "operation failed, no need to wait, fail the test please"
> similar to the xargs, eg:
>               126    if the command cannot be run

Return directly instead of wait may confuse the caller. Maybe we can
add a parameter and let user decide whether to wait if return some value.
e.g.

slowwait nowait 126 $timeout $commands

> 
> > +			echo -n "$out"
> > +			return 0
> > +		fi
> > +
> > +		local current_time="$(date -u +%s)"
> > +		if ((current_time - start_time > timeout)); then
> > +			echo -n "$out"
> > +			return 1
> > +		fi
> > +
> > +		sleep 1
> 
> I see that `sleep 1` is simplest correct impl, but it's tempting to
> suggest exponential back-off, perhaps with saturation at 15
> 
> (but then you will have to cap last sleep to don't exceed timeout by
> more than 1).

Do you mean sleep longer when cmd exec failed? I'm not sure if it's a good
idea as the caller still wants to return ASAP when cmd exec succeeds.

Thanks
Hangbin

