Return-Path: <netdev+bounces-163611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0EA2AF0D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BB93A56FC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68B199252;
	Thu,  6 Feb 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZitxJeXT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC318BC26
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863477; cv=none; b=PvKOi1KzXXdshGVwyynfQQorRilkK+X6Yws3ArHVwnEfZgpUVPOUBAeM7qui42u8DQrs2RKKykNFWLXajBlJr9E5BBb7TpUDUqLEzQDMb1K4tPOdLu4chBsE2WcHV9WZKDRN64pUp2A/3be0UBj880o+cse2l/dSlz5tGtC/FnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863477; c=relaxed/simple;
	bh=xKZfhPlSg6K6PaZJgd7b//JvE4AUlomuh+62OJWWX7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbTKmKY0DtWW0nA0vd6dFWlnt02ibB1vo7yBnAZg3bvgJhsfYExdO0IJaUinCfoyn215YDpe3zRL23++fcn9lhhxf/0QVLfVQzS8VdzvXEyqeTuLaHTM5GGxeuKr+9vi1O7hrwytbvHrx5mV2/kbeCCoHaec549vl0aa8QLWfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZitxJeXT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166f1e589cso30392515ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738863475; x=1739468275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJU1PosKE1Z0m4XlGCoQ554t26JOH32XViqhzUlq2Is=;
        b=ZitxJeXTicpyI08rG5FR8t1RecliJ1lTH5N1DjXDwJvD6Sh4QR44vNrsuJABbGp/yn
         i9hNW6lb6l3QnNx9+asAS7u5hn6si5k9DUNJehMyXdMS2shR3FwZREoasdDsTL5at/H6
         x5+otOR/TvDnbWMJQsDp6seczNwVMjt5ZnNfWCp01GJQYgJ867vh7XYDyx6yZfTChTKo
         B13DwAcruErb/bXd7b9Y8P/iyG6iDnd+hMror+u/4pUmJFqvJ2XNRX5FV0Yh5nwh9RHR
         Zzrcwd870Kz7vV0mQ/NfNIHuEG9H9K3qNzle6A9kWYjRM8DfD87WxiRVpEabTD636pvj
         HCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863475; x=1739468275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJU1PosKE1Z0m4XlGCoQ554t26JOH32XViqhzUlq2Is=;
        b=YSolP4fPE00lKdkA72Yy+9vsqrXhW6BjiIuJN4mE7bHwC6qlIN1egedJyW3rO5aqgQ
         dxo+sj8dFLRzDLv1r0cB0zE1mFdynI7OOlDzLuzE1dkYD/v71wE/Idf8dWTTGUQlRq9K
         v+scd4LEUyXFO0WbfHE7Wtwo/Go9c8FFYW6EMscsiIt/rwBJQay72CMdi6rtvIVjwSE/
         4uVwYB8uzeUN0A9r7Qznx/dYsDESLzpa+wSGe6Eet1yHRYY3MgkUMoxa8Ioet1OgaYks
         2yzUw0b6YSxEwaxxfAeCOzgGUiLcTAzBNh+5u7bFRGiUu/9ghZuwvfbt3rhjPIAzYJKr
         DI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBgv2N5yPiCSTb4GX4IkqYQB1Hfk7Jb4iU8ji2JHyu3r1pNeKK17Dp3t8ONOd6Tf4cYG83kMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOobK7mQwQ/8sSfIjtAZJYZt2HDaRMLiYpHhkCyC6iL+F/MdYA
	VVqv3K63gNDYVV4BSExLioGqchvv4FDLz6CHIX/p5+yERV55Fv98
X-Gm-Gg: ASbGnctsv4EfyBQmGO7FbCxXwnzxIvFS3u9POKRDAZ3m8EZf0T0sdad6z7tGTV3PNnl
	X7I5aqxvG3eSVTQeaPZ9cLgXc+iKVCJNn4yFjJ8RWxntuvFGHEhTDY4w0vShQNGXf3shjyCF3QN
	Y1TPXHgqv2iu8x0tLi+grKp3oJC9GTXjK9P0oY4uYyvJKIxdynV6jF9MK3wEzurYyWmT0d0uRBO
	Ksr2TwVGejsdGBH+mldjTZVcwC6J9zsnOXuMT1uOGtPnlvYKXDuy3yJcQpt7eoawdMqe6c+mqmI
	whXiyOAT0x9OH0IAmA==
X-Google-Smtp-Source: AGHT+IF2xPYBUCVtSs4FJs+vq0cgNrk7bHlfxHB4pEs62h88hF/hxbYRV3pygnQZ/pCCMrKmcYueGg==
X-Received: by 2002:a05:6a20:d49a:b0:1e1:a0b6:9872 with SMTP id adf61e73a8af0-1ee03a45e2dmr447497637.11.1738863475606;
        Thu, 06 Feb 2025 09:37:55 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:901:e6b7:65:386b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af7815csm1559174a12.70.2025.02.06.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:37:55 -0800 (PST)
Date: Thu, 6 Feb 2025 09:37:54 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, mincho@theori.io,
	quanglex97@gmail.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <Z6TzcgXOyuf3dsLV@pop-os.localdomain>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-3-xiyou.wangcong@gmail.com>
 <20250204113703.GV234677@kernel.org>
 <20250204084646.59b5fdb6@kernel.org>
 <b06cc0bb-167d-4cac-b5df-83884b274613@mojatatu.com>
 <20250204183851.55ec662e@kernel.org>
 <20250205172021.GI554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205172021.GI554665@kernel.org>

On Wed, Feb 05, 2025 at 05:20:21PM +0000, Simon Horman wrote:
> On Tue, Feb 04, 2025 at 06:38:51PM -0800, Jakub Kicinski wrote:
> > On Tue, 4 Feb 2025 23:21:07 -0300 Pedro Tammela wrote:
> > > > This is starting to feel too much like a setup issue.
> > > > Pedro, would you be able to take this series and investigate
> > > > why it fails on the TDC runner?  
> > > 
> > > It should be OK now
> > 
> > Thank you!
> > 
> > Revived in PW, should get into the run 22 min from now.
> 
> TDC and all other tests appear to be passing now :)

Great. Thanks to everyone here for the help!

