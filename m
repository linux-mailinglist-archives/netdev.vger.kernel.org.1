Return-Path: <netdev+bounces-174005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC592A5D04E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997DF18995EE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4295F2512D1;
	Tue, 11 Mar 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6V/0LO5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE71EDA20;
	Tue, 11 Mar 2025 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723408; cv=none; b=gXe/6LbN17GJzGe+JPyc25NbNDk4R5ekiig9KIDamqkc+xaVpwTB97Css86zqb6gU7rM1vKC7evHEC4sDBoCHXDxLxy9PbkE5ChfrfHL2VYn1tpgtD9iHMOInwW0v7bwHvNYFfoHtLk5vEkIiVcEwCCtyGNZq17tJub/NiSN9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723408; c=relaxed/simple;
	bh=DazzTJjUvICAz5WuwmaUGkDLCwMSypZsjO2sz2VA/TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyVLOycWHGJByXr5PBMyted2A1K0KupS+gLHyylnNBgllX3JIGV9E1vAg5SlAckyUb/Cd9spQSPrQpwccnrTkdB7nszcbo1z9XxrCRm74Z8C3JeDkeVKYCPL9m6+YGzCEVY2hPGQ7Shz9KAfWZSIk2FKUR4OkJjT4nMPX9QrQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6V/0LO5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22337bc9ac3so114255265ad.1;
        Tue, 11 Mar 2025 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723405; x=1742328205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uhyx+ltpmDyiYsWozRzuwZLHrw4eKDZY65wSemvBkBA=;
        b=L6V/0LO5mYo9SxYa6dUg12tN0GPP4Aq1VyrqwCwW6AQptn6oK6/uehG4/8YI3uOGsk
         89QaLffbe04lpdHjAFt0wa0wkyNCjIxzTAeib9Mek9VxS4eRIiYpZeVL4n2ZJsgh43l0
         TnjsFqDCVuVEgIrpd79+LzcOt6Qjqa/7eof/2mVqsG2txdENfkpGmQX4utlCSxsrCfM1
         9EUSiUF3Rfe19Y6tTZ82XaKhzp18qYIMTmOnTLHTMUIJYyaPEoqM6rz82eJn6WYHzalg
         4gNQ8At051mahFEay/gUDZPw/hsU8shxI2wH/AbL5FOhafkCzP6NcIGO/zAmsZDBie7g
         LIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723405; x=1742328205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhyx+ltpmDyiYsWozRzuwZLHrw4eKDZY65wSemvBkBA=;
        b=Pn6/ih28T1+nAo1r0kCM6jDD3sOwe8/640AefZwlA2IFVmyHoYflSBlDg74YTBDYC1
         RMN5i5jfy5osbEujB20ZM7Tqig3Fbgr5/61/XCJiApwL1zfpMJb6rHQpcK9NfRnOZ+q7
         E8miETbaygAkwpK/Hi//wn+lxfVQ4LbwYGMHxUvrstaXzCVXwqmihPKU/s3gpsDXXibc
         V2cwjhEuSCYTGpYxXK4MahKPPRqjtL5I7HOw6JnNT76D9Z3Q7chdhn/+qqBrPeljX5Yc
         YSB0lyKi4g5hkSrks2y81LGYOsFvxHR5lOv7RxYnvLJQ9UyTTFBU0uAg+fwJ/p66VAbO
         5TqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUboAfVI6pe6ruub6qwdlytirGtZNzk2cjrELrkXuNyDQR9bUUpWM2Zax8L/pgryEyy8OmPpRMR@vger.kernel.org, AJvYcCVIEbPr/izy14JzRyAt8LJQv1jW0IpUEubNXLV8FG2aOhPTk6QnqTyeoPMvgTaVYz3JnkOahnjeKTFE2eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzfK28whqCWG4XlJAs0B3dAdLCvQruCY9rEZLc8WlM+zm/Vgr
	wqo4rO90fcbWrUr3ArCUjZl8HouzxoHlVfPW6Bh2tpkOWesQjD4=
X-Gm-Gg: ASbGnctbqRGBCcGBdRmHifH6orYaSrfcYbe3cUxn7aejSNljdiSYupDH3D5ub22/6HS
	3AyWe9i4hLNZ70Xizu5k2SNTj81G+s+DaE3ZVmOpTNqLcdNiohrhgKMknMlhcBPW9dBvwScPRVu
	K0+wX3+Y7sapp9mqq5/Bcb8STCj9eEdCIqvNrkMHOtI3Af7OhaLVBeIjMtOYSHuQgisqFbtrzAC
	FlmlOZlIw0jLl7f4nOKdWeWDMTd3iYZG+oN91IOvbd5N9ulK9Fz/azutDA69ewXyL0xhL0Pyk31
	yxt44kZbGTJzaqrR3h69J5i+vErhZqXL7fPTS+4GJNo9
X-Google-Smtp-Source: AGHT+IGUx2QQWAc7kIhaj5mfYBdyIReDilwsimkaa88Ci5UkrlWngIFZVxm9VPzlZ6J/y5lC2Pj1wg==
X-Received: by 2002:a17:902:f54f:b0:223:58ff:c722 with SMTP id d9443c01a7336-22592e44a1fmr83727885ad.28.1741723405542;
        Tue, 11 Mar 2025 13:03:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e816csm102053775ad.54.2025.03.11.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:03:25 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:03:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch, jdamato@fastly.com,
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v2 2/3] net: add granular lock for the netdev
 netlink socket
Message-ID: <Z9CXDDrruPmTjdW5@mini-arch>
References: <20250311144026.4154277-1-sdf@fomichev.me>
 <20250311144026.4154277-3-sdf@fomichev.me>
 <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com>

On 03/11, Mina Almasry wrote:
> On Tue, Mar 11, 2025 at 7:40 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > As we move away from rtnl_lock for queue ops, introduce
> > per-netdev_nl_sock lock.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  include/net/netdev_netlink.h | 1 +
> >  net/core/netdev-genl.c       | 6 ++++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
> > index 1599573d35c9..075962dbe743 100644
> > --- a/include/net/netdev_netlink.h
> > +++ b/include/net/netdev_netlink.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/list.h>
> >
> >  struct netdev_nl_sock {
> > +       struct mutex lock;
> >         struct list_head bindings;
> >  };
> >
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index a219be90c739..63e10717efc5 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >                 goto err_genlmsg_free;
> >         }
> >
> > +       mutex_lock(&priv->lock);
> 
> You do not need to acquire this lock so early, no? AFAICT you only
> need to lock around:
> 
> list_add(&binding->list, sock_binding_list);
> 
> Or is this to establish a locking order (sock_binding_list lock before
> the netdev lock)?

Right, if I acquire it later, I'd have to do the same order
in netdev_nl_sock_priv_destroy and it seems to be a bit more complicated
to do (since we go over the list of bindings over there).

