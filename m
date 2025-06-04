Return-Path: <netdev+bounces-195116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99294ACE1AE
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B291899633
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC371A76D0;
	Wed,  4 Jun 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwLhtC4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7823187332
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051723; cv=none; b=BOrJTnifnG1iSQIHL+gH0bHE6q07PLBqE0VSo8S8OPCBj6eGsC8aAyIo4uRhGsQakc/xW7x9CjASO3iPJ3iLsEo1/0DhmtE0IZIzIoGA6Il+B+AquuoShutHDudiJcwpYCdEqHiswqP0bKrqd730G0MoVOJvPLPAgvhduArqKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051723; c=relaxed/simple;
	bh=skq3WujncEnVc6j4ZtyraSyZ+4zcHP+DjKaup/qpWhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vir/dBIMGNL6/ddSwVK3FZ5aR+qX/XPDRG6k5TdO2A6Z+oR1HePszuPfSRMq7o4leAB4DtrFG7qtSk39DcdzQacWSNcccuSSlhagcZCkpVDBr6y69FBZ9e4Nvex8/CeaL/Fb2bOdeN93+kmlTBk/+40Q9PwjLRcAVk9Pxo0BZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwLhtC4L; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3123eda2a1dso4456565a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749051721; x=1749656521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwm93UGDaBhi06iMBBZxAt2vH52UnptdXJUygpNYUM0=;
        b=QwLhtC4Lf2Ir4pVd03Lg879tOS+IX/FAhXkhk//4Bp4Vu8ziNHnZKytVJSUOyiUrvv
         JxErC0qePjhtNd3xE0mRx5UZah1kto0LunPEU9GT3LFWYWISxfO6hPXLK41PSTHROUx1
         izdMBgKk+qLsSGXbq00lRFHZj3AFd7v+4PpzjkWSzgOM58shk3XYCzDNBU+IAnEHV1EG
         Xgk9/OMt2p35ABBmO2UbgNFb0Tu3HxqGH+6zFH7dFNtfqgBIeQqIFRwvRa9uMw/1e1zt
         blxMTJR9TwAF1/e7N4jrXboUnYdeQv9H+ZmtVaCf75u9/Zabj4B4H3uFqLMbHcOAKtop
         NvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051721; x=1749656521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwm93UGDaBhi06iMBBZxAt2vH52UnptdXJUygpNYUM0=;
        b=UpQdZ6RQXKuMWsibiIyWFWrZCtelUlmGHbqPbO4bbuJhegMWNFiRZv0Sgj/93Yar4d
         VJv6OdQRUhS49edaEAzpeahPAD4v7hXoXZ9UolkbA73DayEXm+NKNQerua5sslyFGQhw
         qcZeHhR8eoNxCEBnJFQaTyVAIC4c+k+HZE7eX7WiK7UManjY40sjqnGdNDQA65FehHiD
         RDf+eBIk7nl2bf5esHj8ZQgqsax1GNjKQzwB1mZ/hOlg9rlB31xq3rc6kQDy4A8k40m8
         Qt7PLh+Ta9pyPesT8NHqET288Y+U+85V5ncbODP7i+Gsi3M2agIeFTsgl41+gt9qTTox
         8R3A==
X-Forwarded-Encrypted: i=1; AJvYcCV8QWcdS8xGH1JMIpzB/uKEC3FXjqPLUAHU/CFACtX4BuJvQV7IHDWwfi8NGiCXV9Xnz104pmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLh1OH64LLjBIPtjkmRc7L7CXhjk4zRgvT+dEwDSvZYDBUIFr
	G3NMXuJWROgfamAJbjaWP3c15DtkSXzaW9VLA8eokGVQHzIhfR6pj7s=
X-Gm-Gg: ASbGncuNklHHjsYssT509Eb6IVCiWAQryaVFeMbYo8vJAZ53MoieapW3byeotSmFIEE
	Rx6WTM17gWIhd1RsScZ4buHmw3JbIeha9POheWV9FxporBeSBIq59FwdEkAt8fxDkl/wWnGqKIr
	CEJ1Sakm3uJDYwL2zTxdI89+ISsC9kgorN0O+sfLqRXCsAZbu4XccS3VVxSN1NTqRF7KY8x40v9
	R+SOJw+0OnuCfGtcrS5FdkfIN59A/JMquTKLVsq2X9+AkuNdts7sTBCQdscwsd+IIA4zwKc7WbI
	p3ps1AGWuQ9F6IgtlBN+71JdIfUc+KvwMqgJDcOwWDDIBs+inJslLuW3qLLMdWP0qKRL8UMUyc1
	97af0LXdXf9Mz
X-Google-Smtp-Source: AGHT+IECUJAsuawxjsxEMBjoyupd7E/7RoV4doJR8VkimsjhM/DCXI0+6atbryeE+Ka5Pyzx+tInBw==
X-Received: by 2002:a17:90a:d2cf:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-3130cd98980mr5714856a91.15.1749051720893;
        Wed, 04 Jun 2025 08:42:00 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e3d4b6dsm9090922a91.45.2025.06.04.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:42:00 -0700 (PDT)
Date: Wed, 4 Jun 2025 08:41:59 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+9fc858ba0312b42b577e@syzkaller.appspotmail.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net] net: prevent a NULL deref in rtnl_create_link()
Message-ID: <aEBpR7eUHIqH0EvE@mini-arch>
References: <20250604105815.1516973-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604105815.1516973-1-edumazet@google.com>

On 06/04, Eric Dumazet wrote:
> At the time rtnl_create_link() is running, dev->netdev_ops is NULL,
> we must not use netdev_lock_ops() or risk a NULL deref if
> CONFIG_NET_SHAPER is defined.
> 
> Use netif_set_group() instead of dev_set_group().
> 
>  RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
>  RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
>  RIP: 0010:dev_set_group+0xc0/0x230 net/core/dev_api.c:82
> Call Trace:
>  <TASK>
>   rtnl_create_link+0x748/0xd10 net/core/rtnetlink.c:3674
>   rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3813
>   __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>   rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>   rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
>   netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>   netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>   netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>   sock_sendmsg_nosec net/socket.c:712 [inline]
> 
> Reported-by: syzbot+9fc858ba0312b42b577e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6840265f.a00a0220.d4325.0009.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Cc: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

