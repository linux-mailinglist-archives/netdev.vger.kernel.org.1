Return-Path: <netdev+bounces-185894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C363AA9C01E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C1B5A24A5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACE230D0F;
	Fri, 25 Apr 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALvqB4Yn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6417A314;
	Fri, 25 Apr 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567516; cv=none; b=IcGQBs/zoN8WGvT1ySCGd7asgLGDS9AQV/PUlvMObfUPRS8nhNQwpwoKadCWh483eFLooLnGxDBWlOLKGFutAGpvE7CbX1xsI+/d++q1sj/b8yGPgdxYsRvP3H01MO5MLYGdM9OI+gu/On9+zLb9DJrTrC3Byq84T2jmdiB+7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567516; c=relaxed/simple;
	bh=qoHFf+yoko4A/+XUPmCuZNCG1ChQkHApaZjK13JSRtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyXQQGjZUmDFEb+6w7iV4dbIKwfx8Gp0v0MWT6bz0njlM10HAe3PPfec67P8BM+37xQ4cuW2F5MCPH1BOBwrdyyPbHtuwBR1DeNMK1tzK6niAkzcF7LZy5coLKlpbIe8zPkWuXKDSkJAASLcTqkJ0JOM1cDm4IkcQ4diPILaxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALvqB4Yn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ebf57360b6so283072a12.3;
        Fri, 25 Apr 2025 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745567513; x=1746172313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtlwdttWcrSq5WLrAii4yqH6SPDuiUx6pIip08AE1cY=;
        b=ALvqB4YnNrEASGqcj5UasutBn3oGfcqBoA1CUP+SVaqBI3tA/rL+uyyypWSIyRFPTw
         xV+SaR9SqRGbu9b8NmRO4vvuXSbl7Zo6h9JJTCieZyo6apBnfHe5wjv0YM+h5MqnYpBz
         sl/dVXRCbJeTiVHqudM/gil8S2mJoC22RDWzUwNuBdjHTppI57jQRXRQ6HopIlD3SrBF
         VGTAVoh/QK2sginE3tAbHWquzhMjUxlrwttctgS1fNKTVbtYTExn3pX7K14upzHrjaDm
         WoCiJbclQaaa951jERhScEb3w9Xbk11YLMLpMRiY+6fzpbUJms0uwqF7/HZf7YsN5Gpn
         vQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745567513; x=1746172313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtlwdttWcrSq5WLrAii4yqH6SPDuiUx6pIip08AE1cY=;
        b=OQaH4o76hGfenKGiZqe49g9hFgzdsfulwzR34GAfeBZH1zR1UaFcEfCFYqZuvvj1aP
         OfutvHaf9hh69KzUV3KqCfxHbp31lfPs679DqUdW7+Vn8SUnqgkSnoh9EkMgQuYjr7JW
         u4+sNgqD4ZxZmr87rh1kDf81XFcfiLnP7MEH7QHBG/k9Qf/E5HwHYse0nx43+jvzQYjf
         sZOEiEHUvefxC7KO48H30hs1hIaQXaWeolSZyakJ4wv9I633fbdcrhuu6I1e9+d0CF58
         Zg+JUQCLrFhVeMilNAlPXpu9xKdSVr12D9pfAFMXWbCbH/TQIg/DbmpQ3DiXfTKvaBSg
         14yA==
X-Forwarded-Encrypted: i=1; AJvYcCVslP6DiqB/o1D6EmAS07CEpakLqjxO9ZKVhAlBK8/Jyl3PcxfDk+WIq7/IE+p8/61jMbr29vwB@vger.kernel.org, AJvYcCXJxPZHa4N6pFPoiMIDZNkOmxEZDxw6xyFmXt+dka2sThlpvkSMXibBJvC6w5PD3DKAVdQedVBtcu+bsrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxucfp+Kaxgaj1g320lnC8121KKSaDwGWMNx5tcl0n5NKV1wVTO
	yNeXbuoVKLoZTDuy/M9NkOhXVNBW4Okc0PTfdz60Lozds2igm2k1
X-Gm-Gg: ASbGncsU/+wiPgViU0hU9/NglP5EdGe92Xad/CB5jPwVTEvIQkGW2DOUKtcBtWB0rCA
	+a5Ma8Gli9p4jBQM3T1RltmgTIi76B0HetYsblJT68GDcu+Pjz3cGZzClhHRVh6PTWEwjpKbjNt
	YjkbvAyELIzEQHNJxRDhthm5aJoy7clURthrri+VqFxvClC98eQ1lIOErYhG+viXB9KCRcTY9u0
	l0jFWjai93VCxm32BCIqFEZoW4YAuYgEnntWBGN9UjEjK4ibDLWh4ZtsbtK4f7zv5OeerlO5jCX
	5R1TMbBnMkj7qgHXkbBb7U9Uklqp
X-Google-Smtp-Source: AGHT+IGdpjO2l9Q4ZwWk0hvrRHSKx5oJXCfJGpUsINUsLgfhohWEplcz2aVOrR/qYMxGR0E4RONLHw==
X-Received: by 2002:a17:906:4fca:b0:ac7:25c9:5142 with SMTP id a640c23a62f3a-ace7110713cmr36300866b.7.1745567512466;
        Fri, 25 Apr 2025 00:51:52 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c40bsm93774566b.20.2025.04.25.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:51:51 -0700 (PDT)
Date: Fri, 25 Apr 2025 10:51:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250425075149.esoyz3upzxlnbygw@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com>
 <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
 <CAOiHx=m6Dqo4r9eaSSHDy5Zo8RxBY4DpE-qNeZXTjQRDAZMmaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=m6Dqo4r9eaSSHDy5Zo8RxBY4DpE-qNeZXTjQRDAZMmaA@mail.gmail.com>

On Fri, Apr 25, 2025 at 09:30:17AM +0200, Jonas Gorski wrote:
> After looking into it a bit more, netdev_update_features() does not
> relay any success or failure, so there is no way for DSA to know if it
> succeded or not. And there are places where we temporarily want to
> undo all configured vlans, which makes it hard to do via
> netdev_update_features().
> 
> Not sure anymore if this is a good way forward, especially if it is
> just meant to fix a corner case. @Vladimir, what do you think?
> 
> I'd probably rather go forward with the current fix (+ apply it as
> well for the vlan core code), and do the conversion to
> netdev_update_features() at later time, since I see potential for
> unexpected breakage.
> 
> Best regards,
> Jonas

I see the inconsistency you're trying to fix, but I'm still wondering
whether it is the fix that b53 requires, given the fact that it doesn't
seem to otherwise depend on 8021q to set up or modify VID 0. I would say
I don't yet have a fully developed opinion and I am waiting for you to
provide the result of the modified bridge_vlan_aware selftest,
specifically drop_untagged().

