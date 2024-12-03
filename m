Return-Path: <netdev+bounces-148591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D49E279F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B3D167072
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C362BD1D;
	Tue,  3 Dec 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tpqNiy4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442031F4707
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243758; cv=none; b=K3P6/MkpDsjmRWGJrd6UoHKIcpR6YB+Vu3AYGomyvGzZeO9GnRnyzOFGm9o1lwERDLDfV+tRc1oz92ViI05tHYxkijYmEdfemPrOQvy3cUabMDEhn0/gbbnmy2saP98S58efzuHqtZZ7EpzHP69AiwcbXL4tax5h701glf6I6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243758; c=relaxed/simple;
	bh=dFp98OfpMWvwW3ghj5pq33xsKpu2POJ7V9Uyc2h8Ccs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btrYpqYLXjMxMuW0Rsqqp+XHcNtmj8ZAzVxNfQniPNJ5U7nAzlDjDIkXZPkF6r9mcRZNerPx/UwP/DPoJQ8Jbxcus+fyVIdmXT8WhFq0WEkZ/BMwSizuNf22LOQmpTmCfjVsmaLy95tB5O+n63FPhA5ifxUGngvyuL9Eu87uMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tpqNiy4n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso4133714a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733243756; x=1733848556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eMCO3hjmaxXEHEZCxPuR/pj5UkTYrp53NHnVS+id1qE=;
        b=tpqNiy4n1N83HIzfzrwhGvz7EHfRKidzO+353+iAZX+6ctCLzZpTQuEcYVsBKU7lFp
         8gj6YD5Vhw4Pl7MhHjpsXl9LYzm5vw29ggsJXuP3B1dY7MTa4k8ltUjfw6l+naaetFlU
         /OE5h0JLPzPM6AS30/iPhxGsO0EGtmgbQaQbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243756; x=1733848556;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMCO3hjmaxXEHEZCxPuR/pj5UkTYrp53NHnVS+id1qE=;
        b=HD2KsPdIuNn1KM4eMq63LnQpMl+pyBbIckeV4l8BuVATpM2IVC4q+xQ54Snexwz8CJ
         Y0ZWehR7eBW1ILFm3dAHE5rg+wF5Z0xKOcH9yxOcUfNXWkdWpfswipgSVoWW2oyjXZmt
         ESotFarhvBQ4OQqVtApl3UZFH8SVsW216pN5vzPXxSIQYyFNmvAi7E4SC0k2rm5Er7un
         vfNKbjWFj+dZAQyY1s1o7qnwDRcGJB6ENmzO6rRbJDliJz9ZbLzfSkymh/YXNBSX0Lu0
         SzbhzLoo8MLFae5gi1OTEz/dGFniMjWcocIXNWk8mGNrpLi7kN6GHid1VvHfVui2JFrJ
         IfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVroMtrgnh/+kFTDspfZKlzfzIMyq5bkng2bazmlzZpXlCMXuzR1WtRfmiIUUTyNGSOOzpoOsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PcmdCP5nK4LOBFDZ57PgUwGQueehVJCHD/Ib7TwtazEViTp9
	jgkF6ezUX98jFEQjCaqtdLOTaeQr6c6D2XXyGdMoj0fK3E6XsqtBExJFV2TU78wUYxg2pCX820m
	F
X-Gm-Gg: ASbGnctEQ+4y5U/epXdYlgtq708cu0s19f1zuAWXiHqSKieV3K7Ak3u7w236fXaWOZv
	sIp61PYwLXpR5A91/lRo/Pby8T8vlIW8UzsTHN2Hv1FnJQJ41UJzIeOjegc2eEJN3k1sK/Vkuxu
	1mx0hXxL0P5gpOV06MstmaGZCOR0ECfadr9FtbxdyNM9xVG1oakK/EJWPIVDof6N02K0YK1x+vx
	h6NhloMLYE8EtWX6D8SnpHxZwruseLGwTfp20cLMhHJTk38sY7BpfFS9rVkjc3u7kFpDbKZ6lVy
	g41JQXp4jmFxPRYW
X-Google-Smtp-Source: AGHT+IFVZBDfisb7ERSwPZ6gx3N4o5KaG91v/EEN/NxN3XFwgoF7+a4ZZdAGwJeFgfqV/IJSPkMgPA==
X-Received: by 2002:a05:6a21:3398:b0:1e0:c751:2723 with SMTP id adf61e73a8af0-1e1653f23cbmr4665291637.30.1733243756361;
        Tue, 03 Dec 2024 08:35:56 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a2cb9sm9893644a12.74.2024.12.03.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:35:55 -0800 (PST)
Date: Tue, 3 Dec 2024 08:35:53 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <Z08zacl_IhADP0FZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241203012838.182522-1-jdamato@fastly.com>
 <Z06T0uZ6422arNue@mini-arch>
 <Z08xIyc7OcRoEE-C@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08xIyc7OcRoEE-C@LQ3V64L9R2>

On Tue, Dec 03, 2024 at 08:26:11AM -0800, Joe Damato wrote:
> On Mon, Dec 02, 2024 at 09:14:58PM -0800, Stanislav Fomichev wrote:
> > On 12/03, Joe Damato wrote:
> > > Fix various integer type conversions by using strtoull and a temporary
> > > variable which is bounds checked before being casted into the
> > > appropriate cfg_* variable for use by the test program.
> > > 
> > > While here, free the strdup'd cfg string for overall hygenie.
> > 
> > Thank you for fixing this! I also saw them this morning after a net-next
> > pull and was about to post... I also see the following (LLVM=1):
> > 
> > busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >   237 |         if (napi_list->obj._present.id)
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > busy_poller.c:243:38: note: uninitialized use occurs here
> >   243 |         netdev_napi_set_req_set_id(set_req, napi_id);
> >       |                                             ^~~~~~~
> > busy_poller.c:237:2: note: remove the 'if' if its condition is always true
> >   237 |         if (napi_list->obj._present.id)
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   238 |                 napi_id = napi_list->obj.id;
> >       |                                            ~
> >   239 |         else
> >       |         ~~~~
> >   240 |                 error(1, 0, "napi ID not present?");
> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
> >   226 |         uint32_t napi_id;
> >       |                         ^
> >       |                          = 0
> > 1 warning generated.
> > 
> > Presumably the compiler can't connect that fact that (!preset.id) ->
> > error. So maybe initialize napi_id to 0 to suppress it as well?
> 
> Thanks for the report! Can I ask what compiler and version you are
> using so that I can test before reposting?

Err, sorry. Haven't had coffee yet. I see you mentioned LLVM=1
above. When I use that I also get the same error.

FWIW: I'm using clang version 10.0.0-4ubuntu1 (which as far as I
can tell is pretty old). I'll see if I can get a newer version just
to make sure no other warnings appear.

