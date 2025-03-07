Return-Path: <netdev+bounces-173114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2359A5765B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C15178B88
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2906213223;
	Fri,  7 Mar 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUAg0o/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D581537A7;
	Fri,  7 Mar 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391430; cv=none; b=MS3//RVhMS4CTkkirUwgERbZMJV5ZXxt1IGMDxSII28wpnfiXP2vGeukedzxXatn7myRzyDAR5eRWtQEYfBz3jvlcyMBy3B130kxRZROac4W+m3xwzeYmZxcY6AzfEljAr0qgkgOWr3LadZa+vS6H1PiSHAD+x+rN8Ng7zAHVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391430; c=relaxed/simple;
	bh=MKoG9BDEne2P9qDxJ+le1YCyCIoqc00XD9PNyqv41tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM/pol9rKpB7cz6d8OY+IJI/pPpK77meqYfC1JC6nYXuk3aAT2z+ZDQvCJy5XjtlsznYBbh8K4Ud40r2bCzluSBK6g6qxQ9rQktVEgPvw+2SzsRmeZ5FZHdMO9KCIgMuoEZjOgus8gN7Btu6QnMG+Nq1JYe5MoQ8+VpsHBoSVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUAg0o/Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22359001f1aso61027435ad.3;
        Fri, 07 Mar 2025 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741391428; x=1741996228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAsWR6sk3fVTY/Vs6HL9NRLHq38ZlYaBZpLhSpVA9HU=;
        b=fUAg0o/ZAytVV+Cscitn5Bkf8SmyOXQl+9UTknvXoUIOy5l673DdLu1WVE5+RdJZsm
         7jty/yvLRP2x8ii3yALj/pfu9KddAGjIJVa4pWC/T6dtQ6mypfp8g6gWxgtz2RHTYiD+
         +gJwjpRkjxJhZ8YESzpXdOevw/SUFcMDXgPgE7otU4UB3IDEuJrUVkmhec4WxVopFdhY
         qRRhZKvx5Po+xXmLs/bJ3wGkosrzaCGue02X/iXMTCY/DVsG/xSGt7XPfG93zsJScns+
         wIkF/geHs4K60ZtX++bhBZaTfRNg7lAtiGnCZemiT3tXqd49Wqu2Ewe4JChm7YFKjp8U
         VDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741391428; x=1741996228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAsWR6sk3fVTY/Vs6HL9NRLHq38ZlYaBZpLhSpVA9HU=;
        b=spem/5P6A5WJE3Z1DzAI3w3L5jW//MkM9n22XWELUGrzVz9KH+GvtGKTwAhJu4St9j
         FlGt7jfDQDHq/cDbBfufxothKQX2VSJiKVbz+FXL3aomfB9b9egUabYkLf3ZOXRCitAi
         fn8J0sHjF7RsPrqdLp86hT+ip2Zqq5MjhCKXWxKuiRaIfJNvXZ3/gPy/gPKhP534wBsA
         WWfPKkv2I69yplebQKnlZ/bb+SpcP1MHE/BJaF7/DOCWzsuW2aNI8Ta1i2DUHpTaYfQW
         MW0V2JsABpGBQg0DAldIAS40YRsej0OKYZxGr2dFwzZvld1jmRuNL5nzXzTmjd3CSghZ
         LEdw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBph510GCKFj8pJMwMHciPWy5EkjxqGnd6Hu43EuhNaObChIperC+otzuQSwee/tvVu20GWQY@vger.kernel.org, AJvYcCV1cD1lZfwuR4Ws2BVPRgqgVZFTiLQvUosPznv5Hks8fDOz/9tXY+NUzjcPv3x5NazNWinub7WRAIIwMaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzf08NkQeUQmqKhG8ptj9xBH1dK1D5+RIzJhbeLZTpjGhK8Q5h
	bgY0HfPqQ6mjtum24qYhmtzrpGbUfX4tbnC/8xne/ickuBOp/qo=
X-Gm-Gg: ASbGncs2pj98z+GGmZ7BzvEScrhXwODGFuG3D8RgwK73SqMfGILxnoGO6kzCgbuZXyC
	III3dFJ+A8zivarlnChTY8mLSZvZDCt6xWjh4lzDr1elYM4XwwIEG62Gl9oSmufvH08MzyguzWi
	vVlgiWCxJzf+OiaGEoDM6lMO+muZwQXWyEInLJZ6Kio0A4yDA9P7kuJw8OmUX8h4UMAg82Vx0Io
	leCW+7RWoejNbmPOxO18mIZrOKXFKkvSEbvGs7SlAl/3M2vW74uqgUvDYiCO3ir+iE1Vy6QJnGE
	r+3/YEX+gNxDKORJvqTRTDxbCeLivJRWJnWeY2BuKJ7g
X-Google-Smtp-Source: AGHT+IGaEzUzXa/cEOFXAJvoAJ2Sr3JzH0/1tDWJDNx9UWIW0uTfx1wta99FIoM5yC1asMMZwnyQDA==
X-Received: by 2002:a05:6a00:cd2:b0:736:4b08:cc0e with SMTP id d2e1a72fcca58-736aaadf56amr6431152b3a.17.1741391428413;
        Fri, 07 Mar 2025 15:50:28 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736a80853d1sm2642685b3a.91.2025.03.07.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:50:27 -0800 (PST)
Date: Fri, 7 Mar 2025 15:50:27 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 4/4] net: drop rtnl_lock for queue_mgmt
 operations
Message-ID: <Z8uGQ33kaodoZykm@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307155725.219009-5-sdf@fomichev.me>
 <20250307153922.18e52263@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307153922.18e52263@kernel.org>

On 03/07, Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 07:57:25 -0800 Stanislav Fomichev wrote:
> > All drivers that use queue API are already converted to use
> > netdev instance lock. Move netdev instance lock management to
> > the netlink layer and drop rtnl_lock.
> 
> > @@ -860,12 +854,11 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >  	}
> >  
> >  	mutex_lock(&priv->lock);
> > -	rtnl_lock();
> >  
> > -	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> > +	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
> >  	if (!netdev || !netif_device_present(netdev)) {
> >  		err = -ENODEV;
> > -		goto err_unlock;
> > +		goto err_unlock_sock;
> >  	}
> >  
> >  	if (dev_xdp_prog_count(netdev)) {
> > @@ -918,14 +911,15 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >  	if (err)
> >  		goto err_unbind;
> >  
> > -	rtnl_unlock();
> > +	netdev_unlock(netdev);
> 
> Ah, here's the unlock :)

mutex_unlock(&priv->lock) is still missing :(

> Looks good for the devmem binding, I think, the other functions will
> need a bit more careful handling. So perhaps drop the queue get changes?
> I'm cooking some patches for the queue get and queue stats.
> AFAIU we need helpers which will go over netdevs and either take rtnl
> lock or instance lock, depending on whether the driver is "ops locked"

Here is what I was tentatively playing with (rtnl_netdev_{,un}lock_ops
abomination):
https://github.com/fomichev/linux/commit/f791a23c358c7db0e798bc4181dc6c243c8ff77d

Which sort of does what you're suggesting in:
https://github.com/fomichev/linux/commit/392ae1f3ca823dc412a2dac2263b6c8355f6925d

Although I'm still unconditionally holding rtnl_lock during
for_each_netdev_dump..

