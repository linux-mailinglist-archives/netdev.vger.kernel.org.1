Return-Path: <netdev+bounces-128364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191259792C5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243C41C213C5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35A1D0DF5;
	Sat, 14 Sep 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhMkeycc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B225570;
	Sat, 14 Sep 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726336891; cv=none; b=RdgJo4w7VrKrWTGCzDSkB9mS7Vl6MrlA/dH+361ILs2tUdz+9hiD1qAwuy3Ab4sTw0eexdXl2M97fx23Kf2GppENjcLEkES3ths4WQ3armnn0tYkFLBNY3lnDAauBL4BCdEepZdL6oetRFmhHxcx1LSfkoKlfB74I4iwP+uj4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726336891; c=relaxed/simple;
	bh=EaXTg0fhYhKlMAhnjdqCWjgdbkEkdMiKi1ZpWRKVxaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaTfoq976QUGtKS+BeCA4mYGdrTQKDdMSPVMVsElqC1FX83pUkEVyl4eZZhQ77DjLtWbLXzLLaQBqgjO0v3LnC4jS9EgQOLzGnC6x3Zkh3jGpp3lTZEKb0fUz9fBR6pUQ/G90rE0cHWx5rduRkpf4SlFi2p+5TsV+wXYCaVsq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhMkeycc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso1550163a12.1;
        Sat, 14 Sep 2024 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726336889; x=1726941689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbSIPsNwM+GygjUQiHgIjZSdk5AT/foDOOu2Hhk5z6I=;
        b=OhMkeyccSVN7+VO8S+c1s0m3nknZQKtv0R06RKh5G7BI9gbRh6Xyi0DR9NSyu6DJb+
         KTXSGP735afaXG1AUP3QZv+ufVIe+5fdpPxP/mHMphKzywVNV7q6uL+Tixlrlkb3S9F8
         /AH1lIxlaGUD27LUEtDcEQPUyiYS+6fFc5GaiBgTbmHDDkdNyOvDExSzOu4RAjxawETD
         37pRFhgto25zEcLHVzC163sm857vplBtXfZx3wL+ERM7xX8byAic792agePQ75wo/LvJ
         Sr7gShh1nTWEfQsDRf/7PwBITufyX8+Jva1+YHHe/PIbPwzesoWeqSEafbMJRK55P9MR
         AH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726336889; x=1726941689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbSIPsNwM+GygjUQiHgIjZSdk5AT/foDOOu2Hhk5z6I=;
        b=AbIBprSOnJD/h0dbRxyQhmpRdsZTYEplx290sHdsW7jSshLJCrPzqlSgeB/75ZnkAZ
         qL6OEazZ/swTCRpnTLncXASDBAA//y83fqu2YbMOl24kDeCWZwjPqUxZgB1T9blQLm7E
         hgb1UHqPNbYfaPcYSf++kxkXoBL52So3uYdgxrDNLNTMtka0OADQ6MReDPVgz/4VjsbV
         D9DT1NZaJB/4BgX6MRD8zNlARw6aliHptEArQJVT/KeMcBa4Rkl2bOeIDK4JNvqiAEhf
         sd4iZO7v4zfGr/LmFR62qNhOfrP2xaia4uQaW+YzhFuD1N3lUIKPnnBoCfc6LUS4ADEz
         tGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVZcSsWFCpeq4HZ50mCW27RjlA7cia0Q0SKNHwltP1ldpZd9CHpsJVnJ2WG8amSoKjQhmN1gRW9@vger.kernel.org, AJvYcCWI7msdbLChtM2yeHfqdlbGNlbiAZeLA9+QNqrSwVUQL6WY9G9bo7B+Hb8OnbMECYPOVNKtWPo89FPnvKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47aoqRadXrrxwaiI15/t6msJW9jRjhvrjU+dHnMREhA0/j0hu
	nq+IHhpm6ia7mUmZA8qw+It1Xf1dCpHopa+ASfrdmj1REigQGv0=
X-Google-Smtp-Source: AGHT+IE/XcI7dmdhav37V8UBI2gAzMbDfWaZbfgdeK883ntq5EiqWrStfVgr69CkXWeHsWldkIfB9Q==
X-Received: by 2002:a17:90a:9a7:b0:2d3:c8e5:e548 with SMTP id 98e67ed59e1d1-2dbb9dfbddcmr9271957a91.13.1726336889217;
        Sat, 14 Sep 2024 11:01:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd09a72sm1830978a91.23.2024.09.14.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:01:28 -0700 (PDT)
Date: Sat, 14 Sep 2024 11:01:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuXPd-YlNhgRAhBW@mini-arch>
References: <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
 <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
 <ZuHmPBpPV7BxKrxB@mini-arch>
 <ZuHz9lSFY4dWD/4W@pop-os.localdomain>
 <ZuH4B7STmaY0AI1m@mini-arch>
 <ZuTdhIZtw8Hc7LXP@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuTdhIZtw8Hc7LXP@pop-os.localdomain>

On 09/13, Cong Wang wrote:
> On Wed, Sep 11, 2024 at 01:05:27PM -0700, Stanislav Fomichev wrote:
> > On 09/11, Cong Wang wrote:
> > > On Wed, Sep 11, 2024 at 11:49:32AM -0700, Stanislav Fomichev wrote:
> > > > Can you explain what is not correct?
> > > > 
> > > > Calling BPF_CGROUP_RUN_PROG_GETSOCKOPT with max_optlen=0 should not be
> > > > a problem I think? (the buffer simply won't be accessible to the bpf prog)
> > > 
> > > Sure. Sorry for not providing all the details.
> > > 
> > > If I understand the behavior of copy_from_user() correctly, it may
> > > return partially copied data in case of error, which then leads to a
> > > partially-copied 'max_optlen'.
> > > 
> > > So, do you expect a partially-copied max_optlen to be passed to the
> > > eBPF program meanwhile the user still expects a complete one (since no
> > > -EFAULT)?
> > > 
> > > Thanks.
> > 
> > Partial copy is basically the same as user giving us garbage input, right?
> > That should still be handled correctly I think.
> 
> Not to me.
> 
> For explict garbage input, users (mostly syzbot) already expect it is a
> garbage.
> 
> For partial copy, users expect either an error (like EFAULT) or a success
> with the _original_ value.
> 
> It is all about expectation of the API.
> 
> Thanks.

The best way to move this forward is for you to showcase what is exactly
broken by adding a test case to one of the tools/testing/selftests/bpf/*sockopt*
files.

We can then discuss whether it warrants the copy_from_sockptr check or
some other remediation.

