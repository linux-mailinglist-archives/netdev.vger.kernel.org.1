Return-Path: <netdev+bounces-214237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888EAB2898D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 03:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9191B61EE7
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D191548C;
	Sat, 16 Aug 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Q+34tCh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843623AD
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306301; cv=none; b=NBBPRZAAExFW40qdhbQHr6gCFP5agHL3v+Lxn7h9e5nRA/oRDh9qwXNlRP2DTHXE/BWftr+YLJ8rqCM8h94LnCVP18jEvNjB3XaO73Bi0Lee1XS0Rinrs1REL+A7ju2BVUgiZkNSi0NUPMGsFOrPHqN+hgHGRxZ/6wpwQ4+x1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306301; c=relaxed/simple;
	bh=AmC7aK+TWojYLMuv2X8zTyKYSCw4V0Yu0YOf7G4RhBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfDF8wPyC4vp8VoQ2z0b2SaimP4eXlyLoQNmKu2i6jcay8syVLT8ZYpfxsK4Q2LJG3e/95C1Y2CDUefJrI0kPHurUHB2jnNbhDqMs0v7Uc2GkcFswOWDO3EqclKf6Gs1KgHNvCjzJrSuvVHE5W/dnzTyRF69QN2+p0mkxRRXd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Q+34tCh7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24458298aedso22513035ad.3
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755306299; x=1755911099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJUQ38MWzTlYEkjbKnTHPpD6HEhNxZ9Aq1YWaqmqts0=;
        b=Q+34tCh7xgCvWggZuHEkRpp2GVQ6W6c/kQGwxcLDCZgNwXo+bScqtNHIGHPqaUh0kZ
         l8sr63D6JotSo4KAGZtHJwR5rslO4lqdOO8mS/h454/qSmx9AbR0SWlGFtlYpHYSvr3f
         7tlgqBCzuW39yRtpueAfsUdgdcvBtgiMY5/sXQqjo4zHZWQazPS/+qnzL2U+rNS3BFab
         pZK1gXqtnfK5jMhF4UHlQAfqskCOr33i84k8xHgmDKpE+3KED2MtQpNeYN4QhHK1a8jS
         0i+EwDDfei4v5prJmNUW4kMifxcmP11To5vmbHQzU5uqdwNAflDfjBLmzWI+HepLWsjz
         qkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755306299; x=1755911099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJUQ38MWzTlYEkjbKnTHPpD6HEhNxZ9Aq1YWaqmqts0=;
        b=FirdhrF4c4Z8wvBcP0ecjc99jGPYVQkiKaThYhc7qskFXljm2YBa+L8cs0+P9SEu5n
         wDxTsJez42SEmrz21DmYXC514vTqRlO6hGp3y99eU8TysbT0YV6NYPQ3cbI2qhoWvioG
         Kj5vUQUhzDB87WkDF5KfzDo6Z5PVJott7xF3wLE1YWEkPXzgkRIAJ/oKzNxU2D9lU7H1
         QUaU7+bDlW78ozA1Dp4pqzGnOLqU1HK4KkHbujRkg8oOD4FXfONF2HibPxar63VeuI5Z
         gMPUoZ+o2nSC8rct33Rs1Gmu58a+HmHF3yDoajvFLpCxt1vCr2VuKCWxhlPHZufgeemQ
         pOHw==
X-Forwarded-Encrypted: i=1; AJvYcCWamWIXBcLmd8XzZRgCZ5OAv/X2cjywQvateK+3bTn9999k69OTg4BzM7p8PllN6Zg5lsCVCeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY32rBwivSWPElTnN3EfKAc+QvheI+vDO1K6tzZ/wd1Kjj54du
	75gnZiP+PSp7BPGrsTkTBPXGN1WwgO5/WNOY61L1ptClQ7JH0EXni0QJCmxxV/F9qU8=
X-Gm-Gg: ASbGnctUlHcR7xJmMpQenwyp4z+c7+tDo/07rjJtdzi0+Uv9v+/FMLo/WLdaItTLvYk
	HvYdfnbH6+fxcLlawE9tGER1jbT2bOWSlfzX++7vhzYTkWo2fFVvn3knd9GH30WHptOst+DmNKJ
	B3Wdz9y8jhFK3VvbF1Pv5ruEeFVmm5D48Ah6KPMIJoj3WNQ2pejxLSVle23jkHKnMvJR1o7B/UH
	YrdgDSplx8kGUELH9Ql1Ix9A9+xwLdqCS1L0Asc7kUJDrOYhOeqLgyrNuLC3avbHcwlKU6Bc9zY
	HrHqni6Gykv2v1TI/MspUg/FzwoYjmBpTeRPLCk5BMlx9n7//KIxjXjlR9zJbZFWiARG3My/SSu
	BM8kfi/6oAIefo8QZ5GuOfvhpDzlprXO7iD80lLHvki07povHmTdGe6iI/FDXTXL70oyH9+AUgn
	8SRXBQR6g=
X-Google-Smtp-Source: AGHT+IG5UkC0QGFsgQC6zols2w14yKAcFn7CwlpLEfwDMw/WDj2jHgyd9t+DzcFoZnMMrYVZj4rXrQ==
X-Received: by 2002:a17:902:e741:b0:240:7753:3bec with SMTP id d9443c01a7336-24479096669mr14932305ad.51.1755306298880;
        Fri, 15 Aug 2025 18:04:58 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb09ff8sm23934795ad.50.2025.08.15.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:04:58 -0700 (PDT)
Date: Fri, 15 Aug 2025 18:04:56 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: test the napi init state
Message-ID: <aJ_ZOBnknmewrxNE@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250815013314.2237512-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013314.2237512-1-kuba@kernel.org>

On Thu, Aug 14, 2025 at 06:33:14PM -0700, Jakub Kicinski wrote:
> Test that threaded state (in the persistent NAPI config) gets updated
> even when NAPI with given ID is not allocated at the time.
> 
> This test is validating commit ccba9f6baa90 ("net: update NAPI threaded
> config even for disabled NAPIs").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Somehow I missed sending this out with the fix series.
> 
> CC: joe@dama.to
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/napi_threaded.py    | 31 ++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

