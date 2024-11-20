Return-Path: <netdev+bounces-146521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A49D3E9B
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69019281DEC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE5F1D95B3;
	Wed, 20 Nov 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ/BllcH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3441D9329;
	Wed, 20 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114685; cv=none; b=C1o7HYcqIGA8ccQU9uU0zjjCtRIvtZMU36lpUVJvV6TACIrfGQQyGaYmKKFNSS1/AJ19HalLTKx1k6otZoVY1R51tbssL30kbtqUxRkahwjabNFPzKf1kBjtlC9ZbGxI5JIB5Jc2yoL51cInnatPpU4VLjZbmENklEzP1+hWHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114685; c=relaxed/simple;
	bh=8CMRHB2cxqTmamBsqg9uudH9g9ASPeTH0X8IvXsphJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpTjNv9JJTfh9A8bsAIhBb6irl7F327iU1zgRdT9eNoeV3ghDJO0Uvg8wlLHzQ+1zTa2r6SywsAU7pFEksa7phrjYFCzfQxJ/Evz781z++c5h8cc0GYhWF9CkGvTvInsUrKock/g0nyn/dBggPy80hdOuaDZQEiuOkXIMJd9Kr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ/BllcH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so1900267a91.3;
        Wed, 20 Nov 2024 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732114683; x=1732719483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5tRs5SDxCA6uVSrjq3npJTWFM0ZTaUuFsUk1yMWVPU=;
        b=QJ/BllcH641o7SQSu5OaHg+rFWIXm5INxRqB+4chvijzOgMh2AKP7MCG6fcN4aUU63
         eyKo4cbv8dKwfk+GEMtG5zIrHd3QpfiDz1omwc6HeTYp5d20k0wn6ofouoAFQWvoMBEG
         c2B6YZACUIFjh/iclEbqmWqHkao6cFgZkH0P9R/P/p7oFVTW1BMkT3K/CvR/XGIAZFFZ
         mSqMt1F3mtpO0oZ2fuI/PL2ipl9RrfFxnynpGbusX+4rCfMXvtKo3AxiOoeI3+OTS5B0
         M43PiLURO33MprfaHfnjHZc+Y/AWHoCr20hWDtZh//7EU5smD8VZBDVKQmregbBcgeTK
         np0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114683; x=1732719483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5tRs5SDxCA6uVSrjq3npJTWFM0ZTaUuFsUk1yMWVPU=;
        b=VDzi/U5hBDPxOa632rOU6iK0W7TvYZ+13ClFKqjbGRaeUCOZnOujEeWg8rYfljyTBj
         D1T1+Kr5tpZUncFs64e0opKIkDXHwsMRrBuv8u2jJwE3PDAHz41kk1rL6p1NZHFhwAse
         oFunpMHwR/EzBh57oOA5REFzCnWjpq+JNqXocr620UjN7dj2mIW2yyYjUIsnDftstnSs
         GuH8uJUQZAkPZs7UshUwXtQWOyfqVADEQ3M8LAQZKwpnijgHAJhUtYdmVg+8HXjF7KCD
         YVxJdMINXIhpx/ce6HqmdABVJmQz0T9Tf2s6fnmblS78bKiJjxXZly9jMXELtWKSqI5g
         LR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWp4Q5BAn5M3KbfF82uvzo9irM9FX5fKIr2ZbnPFWd3CLEf9xyFHcZQTCaCGA13m9kOOT+mf3Gm@vger.kernel.org, AJvYcCXG+me+UZP6YlDT4K5pPDS1yMiRy5o1oujCwou2krF+JXhYMy40orMW75WxRx4uceSa0NKUTASq+fUQDnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVAcHLrIGTbFC2HIBNh4HlBn7T5eoJnkHFUhV1DPTXKOd2+7a
	F6XAJw/p4nzDyZU6UCqWQCeu6peRtlENsPATbdmxtce4Ti4qceHZ
X-Google-Smtp-Source: AGHT+IFV7iRAEgSa8oH8+7AoTvx0uOegkgCNlN1vBcrbCPN/pmNqJi3DO6BRx8wXmhFSKq6G9fmCIQ==
X-Received: by 2002:a17:90b:4d0a:b0:2ea:94a1:f653 with SMTP id 98e67ed59e1d1-2eaca7ddfd1mr3149652a91.31.1732114682861;
        Wed, 20 Nov 2024 06:58:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea238sm1404275a91.10.2024.11.20.06.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:58:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Nov 2024 06:58:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table
 terminators in kunit tests
Message-ID: <24a5975e-a022-4bf4-a2ec-76012f977806@roeck-us.net>
References: <20241119213202.2884639-1-linux@roeck-us.net>
 <20241120105202.cvmhyfzvaz6bdkfd@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105202.cvmhyfzvaz6bdkfd@DEN-DL-M70577>

On Wed, Nov 20, 2024 at 10:52:02AM +0000, Daniel Machon wrote:
> Hi Guenter,
> 
> > Comments in the code state that "A typegroup table ends with an all-zero
> > terminator". Add the missing terminators.
> > 
> > Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
> > .value = 0,". Replace those terminators with "{ }" (no trailing ',') for
> > consistency and to excplicitly state "this is a terminator".
> > 
> > Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
> > Cc: Steen Hegelund <steen.hegelund@microchip.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > resend: forgot to copy netdev@.
> 
> You are missing the target tree in the subject - in this case it should be
> 'net'

Sorry, I seem to be missing something. The subject starts with
"net: microchip: vcap: Add ...". How should it look like instead ?

Thanks,
Guenter

