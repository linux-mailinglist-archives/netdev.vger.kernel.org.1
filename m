Return-Path: <netdev+bounces-74855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEE866F4E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD271C238AD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFE31CA9C;
	Mon, 26 Feb 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K1Gu6rce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16F1CAA5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939210; cv=none; b=nReNDzAjHhrQZ26qs4Rvu/T6mk39H4I6ys2rPCmjgWsJarDRKTM8kZK6BXqRijDcIb/bM06IGEGmU6/Mv62fXzHemngLbNxN7xBgngmxK4eH0ImKoxmsbbkVUEtTwTY7IXelT0jZ474/ctLaaqDlsWAQshWygd9ioiHYUcF5QNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939210; c=relaxed/simple;
	bh=XYuPnl0tVoWvd5A57gWVExPFU3+3OM9E/d/+hUTDOqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSFq5s/FIMdh/cUFiLEyqSiexAXBfUhmK64ateyj8sBUmBmhOM5GZ98+W+l1XWBN3+FtWmUhbilHQGpJNQG1kXs8l5Ryb2Z2zXKrrvoogud7yTr0Fh5mL2ZIUexuHK8i77zghR7jsJdX2CsH1oW4N2laJtRHQagHcXEDXuAh1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=K1Gu6rce; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512bd533be0so3243552e87.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708939206; x=1709544006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYuPnl0tVoWvd5A57gWVExPFU3+3OM9E/d/+hUTDOqI=;
        b=K1Gu6rceE8DX2b7Ul9NSDFT8ib4y64SWi9zm0pQ00eWCPt3p0OaW/YqT01d8jkVNo1
         Crodc1NlNitFTJLTo8tLyurs0y1tyYGT+52Gq7bpH/jTZZ5wIA+Zd0y43s7a02/UUKIt
         5VfcZMnIN3lhlqpYZrFo0tnJ5X7Ds97n2N8NWadhmwYqby/PUgd7HjRDxEOoz2fEn2D3
         jjHaFnmOs/Bm9oKiPxD76p7/Xtodyq4CQO8aTx86DFH+QyGs56FTFxxrxD+vmd/qocYQ
         Y233/3K1TnGZKKlG4drhwZ7h54jkjPOyRlVQ6f1FTsbocczOHfuKfsb1Wx90i+KVJ2Hz
         ZKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939206; x=1709544006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYuPnl0tVoWvd5A57gWVExPFU3+3OM9E/d/+hUTDOqI=;
        b=dClwhycs1KOahzHOhFf49opxxwkZD9eCao+dYGZvznBY68KAMVOfcDT5R+EltGSq2Z
         hTGaX/CzU9Lu03QrGYVXjRkDqXSjv52fKGN/jzkK3PfAMVQNTlnTgJl+0j6Lu3dXf5wT
         Py+agr5u0KUmGmeIPXsSXRJ7ERs+/n4bWeZ2r2Mppz70cp1eCeB5VpKlMmxOquztz4EL
         uUzqfGnoJF9SEoNbMG7xPebjK5lNMuFzxnXGh84y7xGl20vw18ev2U3Ud1v274l7qVNB
         ioDvKq9uOjbHr1OeuWRaPD7iL31RtnkkztKh3Pt1U9PrFuAmxs35A/G2rXeZx3GE+RFE
         rm6w==
X-Forwarded-Encrypted: i=1; AJvYcCVduiFnlmuN6nRrOf//48/H0ykGjW5orRaz2owcSyrvmHKYsSzNUNgGu41h1AR9NThriLFLpvDMZgzOMIj9yBmE0nrEnoY1
X-Gm-Message-State: AOJu0YwA4Wziqj9RxbPgUwUeE1wVojqdT92vCXlxZcpFhaedwL+Iz4c/
	GHMQpxg1gEUEZILkJfuNIPK+HLpKQhbZHX7Xp1vKCQhY5BwvqUiom8Pc+58l7JA=
X-Google-Smtp-Source: AGHT+IGcmAA0eId5lxCCuQhbYaeRYl0nqRl2rUqYSj5Y1x7+WwMcg5RFeE2+qR5CvOAZDf3ZxAwk2w==
X-Received: by 2002:a05:6512:201b:b0:512:a6cd:b37c with SMTP id a27-20020a056512201b00b00512a6cdb37cmr3395111lfb.47.1708939206015;
        Mon, 26 Feb 2024 01:20:06 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id jg7-20020a05600ca00700b004129a858a7esm7671977wmb.9.2024.02.26.01.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:20:05 -0800 (PST)
Date: Mon, 26 Feb 2024 10:20:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] ipv6: anycast: complete RCU handling of struct
 ifacaddr6
Message-ID: <ZdxXxLOfYjeQwy_R@nanopsycho>
References: <20240223201054.220534-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223201054.220534-1-edumazet@google.com>

Fri, Feb 23, 2024 at 09:10:54PM CET, edumazet@google.com wrote:
>struct ifacaddr6 are already freed after RCU grace period.
>
>Add __rcu qualifier to aca_next pointer, and idev->ac_list
>
>Add relevant rcu_assign_pointer() and dereference accessors.
>
>ipv6_chk_acast_dev() no longer needs to acquire idev->lock.
>
>/proc/net/anycast6 is now purely RCU protected, it no
>longer acquires idev->lock.
>
>Similarly in6_dump_addrs() can use RCU protection to iterate
>through anycast addresses. It was relying on a mixture of RCU
>and RTNL but next patches will get rid of RTNL there.
>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

