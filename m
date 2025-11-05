Return-Path: <netdev+bounces-235788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5EC35A49
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF43A600D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266B313E17;
	Wed,  5 Nov 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA8ICoLX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A1314A6D
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345616; cv=none; b=LeWXoR4IgbFHu+wQfnhDZ2u0zMrcaZdsZHjzytwQn8bmTS1wEbrDxmYOQZO75WVTjapqHvA+4YoPMU2CVb/SpcI+pHp/tH6UR3N5p2MY6P471EBVC84Xcx6ghfPg2gNlqY3NVMXpNruyQUi2Yk4/T3reKsqKJnWEUWEtKt10eHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345616; c=relaxed/simple;
	bh=fcuYPwU4TimMOTUunc+Hh3TCgMbgiRZ/hYuPF3TLqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOhL/edhEl28wIJB2EOy2SdatPdBNnF5IvPXxpxtHrL1OL5Q8yGSYJuybdbQr3SyJcg9l67kS/wliYG4QBkWgZJvc+/arKXX/7wC1XcQ9EtuANkHasi/UhgttBZ3zBfJKqQirq1rPOWaFstn3KbAfjA2xoFUkN4pfTVWrWJlq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA8ICoLX; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63cf0df1abbso6980431d50.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762345614; x=1762950414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVOeN58zyeFjjSDLTxwag0zpnGdW/6CES9AXGiQ47G0=;
        b=cA8ICoLXD5g6uGkujkgcH2gcWCe5qI+QKM2uu+96hO4hH7SeXyLPsBQ0oSW1JTv171
         TbZLVBlDyQF5E5gOEv8057dejt/iRAE+stBUjXzpnxwoKqez9k/6pks3YdRgCkHTSbaZ
         s/9y2rU9AjMiQS2RJgS3ICilBnmnVBluOkD6S2biLI2jT1/tUXDYFjH9CN5r0TQ6iTgy
         MTDV+NbLNba/ymmHiRWKOFPA/0js3g68+0aN5TBXpWgbPgNhkZDjeHe86oX9OZNapG74
         T1EKRGGdIYFBEsUzhHToc5Yh75I8Y6ax6iNuEXaIewQriD8ssWVLU3AQiIRjaPBWv0Ea
         MJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762345614; x=1762950414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVOeN58zyeFjjSDLTxwag0zpnGdW/6CES9AXGiQ47G0=;
        b=UWeLDd5PEaEh0ivXesIOyN2adYWJhls02x7T3lMt0f+GNRQIPjRSMC7QBmR+xs8mrX
         QU8tqg4vnLrI5JNFyAK4ebBgiVCrye8CBvs5DbyJMzETXlWIC1a+1XYbXWLGhEwTTaND
         L+nQC6eSv5MODhvaGgHOu0JPm8P2q6m/ZLSjLmZCoK3i6I0KHwqVXkB2ivMKddIR5Mge
         nddTqPE+6H8cYb0Q/pMd7+LRbSxXs99hNvwmIbvRlsvcIt31+D2uIYwhQCW6iOyvEjiY
         eDa4kT01yv4iSZEA63HMvFNgbAuiF/Oi0+8886VFBaxBEUFeldTZezuC2gtj/93qitnm
         1Ncw==
X-Gm-Message-State: AOJu0YyEi0dujT3evm2tR71Kse7F+sZUuEAIPJqPWJaubDYvRtSqAqzp
	EOAY/NcQV6MVI8laviiEWd1pGEO+A6Dv/ENcV2ITwaLb5B/FMYlx8eRB
X-Gm-Gg: ASbGncssRJmZTuxrHCEjcmG/ZffbDTb5KNH4ah7J5s9LcQDXCzncvXQioGBSOMiuijs
	7FclYNzb2T5rxsiPz5Hl31IUykRW6oihUH0HYCJcqe027kiXdBMXXgqXjVEHyQz+GcHjC9Z226L
	23QdZeG2xcp6oK/ZRT1r6DLEJtJrrEgb2Ki35vL25S72+nTQaxLXTiwrdKDKoVgKTefbxvfpGqJ
	Z7C8qd1Mx6kHWQBlsUjODMv8w/Bn8wrk84suUDj+6bDobiY4lD0XbH3NjFcBFeyvSOv8XYdpK6b
	vbbC1rUvjOOgxAz9WbZn/Mbr+LZ38U6ONK5Sq2wltE+TY5KvfReK4T0/Jbrq+EyW+8pQKFqwmEv
	bLiUGO1PevnkrniW2b8xSzdCQ6cc8FOd2VJU7b69Ca7iBYuIo2SVLMb9IuGuiPsiY/yCK8PUa6v
	AOARgu/gwmV2nVIfh4W78v4HKLtsuevQ==
X-Google-Smtp-Source: AGHT+IEFlvx4JyuDk5g+CiYUHaEWVZiY2cIIua5bWi3AU8zL57bRa1V38yrfBU1JtU0MOAk5bZ8jnA==
X-Received: by 2002:a05:690e:d45:b0:63f:bc75:6ead with SMTP id 956f58d0204a3-63fd34b5560mr2320123d50.9.1762345614071;
        Wed, 05 Nov 2025 04:26:54 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7869202ed97sm18637177b3.57.2025.11.05.04.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:26:53 -0800 (PST)
Date: Wed, 5 Nov 2025 04:26:50 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Tim Hostetler <thostet@google.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
Message-ID: <aQtCis59KXvcQSqO@hoboy.vegasvil.org>
References: <20251104225915.2040080-1-thostet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104225915.2040080-1-thostet@google.com>

On Tue, Nov 04, 2025 at 02:59:15PM -0800, Tim Hostetler wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> For consistency, n_alarm validation is also folded into the
> WARN_ON_ONCE.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Tim Hostetler <thostet@google.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

