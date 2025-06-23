Return-Path: <netdev+bounces-200429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A502AE57EE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D49116953A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8787A22A807;
	Mon, 23 Jun 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQiEjvmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F61ADFFE
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720919; cv=none; b=MWjCPXmiF3N448vwHXSOZ9J+nyRKK+epihugmwpdQzmg0htkhAX5OusHXnLT3Bi0z0MxcaON1vtXePt3ys+uCQSdv1vwxqFBJgHp+KO+pG+p53hQCiTXPHoog9+t7hKZLUHgWJLGV1/d+dnUOtC80gCnBdPCYogeUpzKABEPBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720919; c=relaxed/simple;
	bh=Srra45dA6ECddvbeegSnG/X6WiPpZvRXkfHrxR+2X88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaImG/ZxSu6XiLeCBvOGVHCwn7QOVOabVyPVlhMjiaUgjMCTooniyFke73pMorWj0gdOxRXpvT3Lf4a8Zlg+T0PPWFWe/tw+LWl1hCZ2e/oa9D+J+NZwH8EHHQxS8lCndBBIF7dK+ixaEA8MYpT+yj3koAnJiP/nkFFyBOC5LFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQiEjvmD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3714082b3a.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720916; x=1751325716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3uqBbdRrVWz2Odmq1K0DlIvBMrPosaFEpDuudoRcPk=;
        b=dQiEjvmDBQvTvZx9iNGSy6NSRZn/dnxEk5ujw4bDIwIWTg4iVwG4VrD5hNDa23PmhV
         gUNOG3ieO3dU0oaHLAztelMt0QmQ8xb208ZD2DbaiXwwvYU8nnOdqWBXOqwogiokbTtV
         cTKqYLoiZXg8u9xSZhjNaCFaXIUFr9n1r3/h1sNaY0mI05ZCQWAjj+KWk0kb9uxMz4ir
         nos2W7iPZTO+eUy06wyxP6td/JroeTnhEARlO8YUCKfYy8RQlN62fT8rS+ajQqGj7ZeF
         1tzma4KYshXUV5FtlVmT1c/8kEdJCCsF0B/Suc/QNlI/z71rCoFJBUACS3vGB4MBCHDm
         0h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720916; x=1751325716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3uqBbdRrVWz2Odmq1K0DlIvBMrPosaFEpDuudoRcPk=;
        b=ueNl95WBrxUuO8A9vQHXK4ihWga8PbZA5/xnwVkr24vzqUKMZ5cIaVEaYrwe6HwgLl
         9tA3O/ckJhmCxZp7BOsqafFoaCoROFWXb6mJBjA5bfGrQZTmg8/xHZGBJXc0VjVjfDrh
         DARJdfY0gDgAZs/sytU6grHXvIGz183RUt/hX2jPdsNWO9sXiuP6MYRnme9b1zCUc7Gd
         lrte9H67myOxUdWArTR7c0GV5Coumb8blZTLjuuNPy3m+AM9NLWjpJDCPNc97/0vjj+n
         mgvFfTIgsZ46GM/CeNdXMbl+gMvdWNxRaOV6SWNltkOAaNMFDDphI9B+tN5j7jlcR0RM
         pCzg==
X-Gm-Message-State: AOJu0Yxxs8RU5CTDxZJLeTRjub0DiRIygTOFmB6f2tcKRlVBob+ENOTJ
	4GKSQOyYwTdIEAeFu5tGxhiVxdtbiiEHndOh+XgZrT7AS8Cp872jOXE=
X-Gm-Gg: ASbGnctcifiCWWTSqc9YkDnXrmRV40dTJOBMSmiJzqcayIaIFJOKzc1mf8sUd2OUOQq
	xCPf/U6xZtkBMK4Z81/4h69wR+5FoUf4NwvMkQBFylZdai4VDcgn4P+KlF6bSpSvbEdGaR0oNkB
	hMUUkiI0Gi+ZPrUG4E7thqVVjwC8VoClfNGG9jot5wuJ9mM9kjP7oTcXwe7z29Zfa/7TQ3p6czo
	wkzJa7cWTuiAK5adNrYxJy9a334hQ0KkSh1zemvmqBWN0MONogYVRXByqzvEdxs7vOLz+s5xn7Z
	ELep6dy+l88//sPftFYZ973R8HYOdnyHTUXonUxIW57WdoqUsJoO2CuoUIR4XN5Dm5P9mNknwcT
	7IjCNYsmvKbRPuYJLvjEmp9k=
X-Google-Smtp-Source: AGHT+IE4gfbJZuDSWxyu2sgv5XRXQI2lz5rQto+UJZwEL7pzz8GV24vHGu/0PZjcmvcGW73TaZve5w==
X-Received: by 2002:a05:6a20:2446:b0:1f5:8678:1820 with SMTP id adf61e73a8af0-22026cf33c6mr19530237637.12.1750720916246;
        Mon, 23 Jun 2025 16:21:56 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b31f119e820sm8768511a12.23.2025.06.23.16.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:21:55 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:21:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 6/8] net: s/dev_get_flags/netif_get_flags/
Message-ID: <aFnhkk50Q0YBYXWs@mini-arch>
References: <20250623150814.3149231-1-sdf@fomichev.me>
 <20250623150814.3149231-7-sdf@fomichev.me>
 <aFnWcGnwkg38q2p1@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFnWcGnwkg38q2p1@mini-arch>

On 06/23, Stanislav Fomichev wrote:
> On 06/23, Stanislav Fomichev wrote:
> > Maintain netif vs dev semantics.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
> >  fs/smb/server/smb2pdu.c               |  2 +-
> >  include/linux/netdevice.h             |  2 +-
> >  net/8021q/vlan.c                      |  2 +-
> >  net/bridge/br_netlink.c               |  2 +-
> >  net/core/dev.c                        | 10 +++++-----
> >  net/core/dev_ioctl.c                  |  2 +-
> >  net/core/rtnetlink.c                  |  4 ++--
> >  net/ipv4/fib_frontend.c               |  2 +-
> >  net/ipv4/fib_semantics.c              |  2 +-
> >  net/ipv4/nexthop.c                    |  2 +-
> >  net/ipv6/addrconf.c                   |  2 +-
> >  net/mpls/af_mpls.c                    |  6 +++---
> >  net/wireless/wext-core.c              |  2 +-
> >  14 files changed, 21 insertions(+), 21 deletions(-)
> 
> Looks like I missed something in vlan_device_event:
> 
> net/8021q/vlan.c: In function ‘vlan_device_event’:
> net/8021q/vlan.c:507:24: error: implicit declaration of function ‘dev_get_flags’; did you mean ‘dev_get_alias’? [-Werror=implicit-function-declaration]
>   507 |                 flgs = dev_get_flags(dev);
>       |                        ^~~~~~~~~~~~~
>       |                        dev_get_alias
> 
> ---
> pw-bot: cr

I actually got a conflict with https://lore.kernel.org/netdev/20250623113008.695446-1-dongchenchen2@huawei.com/
so will wait a bit for this to be sorted out before reposting..

