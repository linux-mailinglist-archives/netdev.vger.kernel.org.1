Return-Path: <netdev+bounces-112632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B211493A417
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF8282015
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA529156F4D;
	Tue, 23 Jul 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F7lgagtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950413B599
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750549; cv=none; b=N+bWcjh1jFl29kf17LppVp6mjjvqbWpqu0RsKAFdp+5g/7ga6WQuD/OpOHWJTGQsiKy2IepvvNQbWMEUpWnYgWehgZpmw04vNVGC3YT/7gRU7M/Rn+7Ob4qEwrrnUmLWcdBJaKpLqEhwAFAC9CA/dWSXNw5atbFk7USG8je3gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750549; c=relaxed/simple;
	bh=Tq7jHl8AEr1KY/9bgI6jxWZoXDAxE4d+oFKZ7vBVU/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVmmP3H3IT7Ua2hrbpmze0op6PrvuYBfOKVsYxSTEjMjh/cBvBhYHx+7AT9M1Burl19QJ5k53JgyiZsuuiEVh6Ho3ffvHcnhlfB5QxKGH6DTGimSAGhnV0VAIBwFh6mWg/H7n2fUZwU8021bgvqtPj6dZLvx59sL1bUvigNRDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F7lgagtP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso1950764b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721750548; x=1722355348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDRfopKm3Q1ZtQF6eigLE81t2qN4C+I603RwgCc2rgk=;
        b=F7lgagtPGBvIejmQ+2JnctcOi2WDyVmQSnI3e4kquwV+TpcPLvmmjkSzwJk4YRqden
         4u/RYY+ZH/oRQ2Ro6OEUaTIG71e7Xwp96Is/3zlbhHJD9KQOGwo/ewz9wlGj4PKRR4Wl
         GjuO4hIVitdyJLb6IcWLIm3rsJybUwApESBrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750548; x=1722355348;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDRfopKm3Q1ZtQF6eigLE81t2qN4C+I603RwgCc2rgk=;
        b=PeRWiZ2u22JnFDnW8YKvTB93lxonDy4TCkSVEh2qu+PyEfSiRiTJrEKOVL+YvmxNpE
         4Ap80/Vhhp+f4iqoL7E5OIr5aVbxKL3lZ+0HzceQ9jMkQH8xv7ucavsln0liDY8L9+5n
         lbpk5U5Kvonfxn6UpUvcRbyPYAFZGdDJc4MTGMtC6pFS0kHLW2bF4VYhnKQBAHfef1jc
         qbiy0dTOOEaQjZoETgHSE1BMkA3d/Ot1NCiPbaipJvG+s2Xo7kfYZdIN02IDKSmmbiHN
         hQUVipAfhIiWI2Z84omlTnZCMc7ryPejs5Jfo/6qrE6Pm4gCwLvKt0e5RhDgC01Q1v5t
         SFGw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMuIL19ju+beruFcC8+zSanLv22s78pJrsKv5YWUgg5JR7NRZ43XG1gDhw3aTVb0WYn8dhCRx74buVVh0A+OD9HQCk/PP
X-Gm-Message-State: AOJu0YxN4yXRuVQ43L3OrrakvuBdK/1dtvg+aVxv8qskSrJYluWlSpEN
	4edbuNzAUz4bSKhC/GOD0ClcxkGvMZoozsTL/DrfIQvl20mPHCCxeqfUAWrACJA=
X-Google-Smtp-Source: AGHT+IHLxZx7hBYFxosflI65h+aH4tL5rKeE2y/L4/NH7uCdc8x9uV8kSv0ew3z0tkMseDW6bPoMZg==
X-Received: by 2002:a05:6a20:734e:b0:1c2:9659:1ee5 with SMTP id adf61e73a8af0-1c45e631ed5mr369617637.22.1721750547476;
        Tue, 23 Jul 2024 09:02:27 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d277641casm3614744b3a.50.2024.07.23.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 09:02:27 -0700 (PDT)
Date: Tue, 23 Jul 2024 09:02:24 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net] net: wangxun: use net_prefetch to simplify logic
Message-ID: <Zp_UEJzlqJFo-fXN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Duanqiang Wen <duanqiangwen@net-swift.com>
References: <20240722190815.402355-1-jdamato@fastly.com>
 <20240723072618.GA6652@kernel.org>
 <0f2ef152-0fbf-492f-a334-89bb700721a2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2ef152-0fbf-492f-a334-89bb700721a2@redhat.com>

On Tue, Jul 23, 2024 at 01:05:32PM +0200, Paolo Abeni wrote:
> 
> 
> On 7/23/24 09:26, Simon Horman wrote:
> > On Mon, Jul 22, 2024 at 07:08:13PM +0000, Joe Damato wrote:
> > > Use net_prefetch to remove #ifdef and simplify prefetch logic. This
> > > follows the pattern introduced in a previous commit f468f21b7af0 ("net:
> > > Take common prefetch code structure into a function"), which replaced
> > > the same logic in all existing drivers at that time.
> > > 
> > > Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > 
> > Hi Joe,
> > 
> > I would lean more towards this being a clean-up than a fix
> > (for net-next when it reopens, without a Fixes tag).
> 
> Same feeling here, please repost for net-next after the merge window.

Sure will do; sorry for the noise, I was on the fence whether this
was net or net-next. I'll know for next time though!

Thanks,
Joe

