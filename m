Return-Path: <netdev+bounces-124407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E119694E1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C72A1C20E06
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4F1D6C4D;
	Tue,  3 Sep 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnP2T+cS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7C1DAC5D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347457; cv=none; b=Oq3JtVMtbygqy6To2lIDgDSzfBLXjVyH1dwtA1KvmyaTG7/uSUWacQtgZowmBufASfjuQGq1B2xgzFkFV5/ky/sMXQ1nadH1jchIqE1XWggChy29slLmSdqAR/lbhbBVIH9ayaYTlWW+sZYtgMcbkMT8JUChPWkj71OOL94AKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347457; c=relaxed/simple;
	bh=/KelTGcZso6IpwqENb3dNLcObKi8Nuit/MyDzP96YGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzSxUziilroyVWB7KCMdvZyHM/48qDaIa6cWQcLl4iO8lkGlfLnVY8aysNf5j1DGa5MaF7N+JYNm4En0uCNVodqarCAUVotc23OwCpqvjP+eVkS+eUZPXSZcfc8Bi+7FhXaXY0TNR2UuoyZpJoGN+l5+96MpBU8v+kvJnFDY1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnP2T+cS; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dccc6cdc96so3478880eaf.0
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 00:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725347455; x=1725952255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mp/EhshlhrrYJyAYGi/lR8iTuWA66t1q2L2monSZrNQ=;
        b=WnP2T+cSkPcXvKzPCrlk3bvaa6QoK4nWcc0vOnsABBYh7C6qDMS8Ryg+rOkeIFwpWI
         E4/EoNpXWLWvDguR8zn4UTj+qu4u8IVtu8xFiuPEmo0P0LgEqX/Ju8LnqtVMd/Xozt4u
         jCjH9yuTsx1ezLS4VY4jQcMlhTjj+qJRzGG7qFDBxLlN+f3ON9YVR/lT5X4ma5/qFqkT
         QwKRWa2n+LnNZC8uRgAJoZnaLvr3T5jUlx1hhfTO8CF0hIq5dHPrZvdeca9SCk4M8jZV
         hwok3AlKs7oAGxtf0oWtLypx+P/xZ46B5qp9VMnmnBgnRfJngqqtkNCHWq5YDtXgZCyv
         VtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347455; x=1725952255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp/EhshlhrrYJyAYGi/lR8iTuWA66t1q2L2monSZrNQ=;
        b=RC7a0L56XbVQHturGh7nBZlvQd5NezyzS9epoPeMYqz1H9dgUjndzP7aV1tCBBoikA
         E8U0OpITOx32b18vc0pBbo7aak7APk0kK9CItxhFtVI5MJ+e6ZeTFcUSKR+RQfV6hN9u
         JktpzC6/GdS027lkaMaO8mK2ZtaY4RsguU0jvFtkRUGWkozGO8L4h7QeXyoIBT7n0CZn
         TjxCO+ngbbokrCikefYbm/YeUla8mFa9PyX8RlrKZdQ+Y7qwyS7vnO7sM/hocZapGF4h
         H33OyF87nWEpFPk+g50Mb2olLnwkGvKR7cersq3yulGkMH1oZk5rdvBgii3wTbIoPfKc
         CuAg==
X-Forwarded-Encrypted: i=1; AJvYcCWPQ2Tnne9EzzHyODcbSWfCupjjbSIGLXhh63am+aw1HR/gghul3ipgNJOiFaSdbSQyuzl9CBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipxU5K/rg217/HeYd4DgkoHg5CcHVh27K87X9T9jhZBs72aZc
	4tiY55H3+ePQVAxFIym3iEvh1a6B3JphnWL0+ijcRQWAxP1pmris
X-Google-Smtp-Source: AGHT+IFiEzwK02cGNGS6rqgb4N8M3sszMYbKQc/XOWuu0ejHM7VozKLhMohtaFxFYZJ8h5f14L0njw==
X-Received: by 2002:a05:6870:4150:b0:277:ef2f:3dc with SMTP id 586e51a60fabf-277ef2f04bcmr7038252fac.33.1725347455171;
        Tue, 03 Sep 2024 00:10:55 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a9a44sm7875709b3a.68.2024.09.03.00.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:10:54 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:10:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv6 net-next 0/3] Bonding: support new xfrm state offload
 functions
Message-ID: <Zta2eKJAMY-7fZzM@Laptop-X1>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829093133.2596049-1-liuhangbin@gmail.com>

Hi Jakub,

I saw the patchwork status[1] is Not Applicable. Is there anything I need
to update?

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20240829093133.2596049-2-liuhangbin@gmail.com/

Thanks
Hangbin

On Thu, Aug 29, 2024 at 05:31:30PM +0800, Hangbin Liu wrote:
> Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
> xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
> added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
> in future.
> 
> v6: Use "Return: " based on ./scripts/kernel-doc (Simon Horman)
> v5: Rebase to latest net-next, update function doc (Jakub Kicinski)
> v4: Ratelimit pr_warn (Sabrina Dubroca)
> v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
>     Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
>     Fix "real" typo (kernel test robot)
> v2: Add a function to process the common device checking (Nikolay Aleksandrov)
>     Remove unused variable (Simon Horman)
> v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com
> 
> Hangbin Liu (3):
>   bonding: add common function to check ipsec device
>   bonding: Add ESN support to IPSec HW offload
>   bonding: support xfrm state update
> 
>  drivers/net/bonding/bond_main.c | 100 +++++++++++++++++++++++++++-----
>  1 file changed, 87 insertions(+), 13 deletions(-)
> 
> -- 
> 2.45.0
> 

