Return-Path: <netdev+bounces-147883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4899DEBAB
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA2C161275
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052B915539A;
	Fri, 29 Nov 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Eqfhjs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409314A624
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900899; cv=none; b=bJeHeNDFcFAoE8/UIcyjgXKdrMyUJiX/s6/BSLVVQ9yeIaeGt+AOafe2M5/uesPWnCypp7XUrQ/d5aUhS6DmmRNAhAEz65cdUWkp+75FMnmdcmz1grQVazU+zLO+yl5vDmEs72wUf8yttfAFYOIrrYBY16AVCt753D/O69lEBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900899; c=relaxed/simple;
	bh=uY5KpwfKoJ/X3wizYw2e/iIYnaOnGj1imWmMTkeUO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtPApi2lNTlmaAEGFLamtbztaTI3M8D0St4DTpea5hydgyBNqxePf57n+TJWJs2aGUWr39JL4JceNCAXdrlzl0fCF07dO5agjQ4y8oQuifAfz3/HGylEHPFJEF652SQrxgh7HrpjkKiOr8T4Uoyzw5kkZjr9+AzK0XM2uygt96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0Eqfhjs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea6d689d22so1545590a91.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732900898; x=1733505698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNFLbgJsZuOdBqg9sW66ykIk1Hf6LqJEVVRlnWuERAM=;
        b=W0EqfhjszCe0BQx00jI5hltJ/HCeNCCyX77XPR5dZSFKL8XymNpPYcnjDp0QSTofvU
         /nDMC8TWKKaWLcMXvZFnEd/h3OGJIDdwqlxT2EStk4feDnVeR9/MIlTubzj773EXbtPa
         M6VH2E8OkN3KDsX8FOTMF9Er8MXX3gBTQjw112uEc6Gd/NDgGiuwWp7V4SiZccDq598v
         sVWCEcIcYrnnkQPr1CfDndCvG4eo/ITlUTL5lZ/i73n3v1ZcbvjBtjICjp8U1ek/hgz3
         JQhNB1UFSKmMaA9liG9Ko+LTc86R39DrDp7AZZZYDio4mGK081tO9LZrEQbC9Yhmne4g
         q1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900898; x=1733505698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNFLbgJsZuOdBqg9sW66ykIk1Hf6LqJEVVRlnWuERAM=;
        b=LCG1t4XuXYxBhm0NrEskTz7a+DznDPls04hRT3dxQ5T0dADuFNmbTgM/nLouVMXetH
         IGWVqEX83CRR0YnnqNuJgaLVtk0fgeEY5RYFy6I9zyYw0Oom0GQOyAJ9vbnY/piGXEhE
         BfSeWlC/XmQWza6bwVItRRO/r2Z7gtHXdePJw2Gdm6MT9/mUWIipybw0Tbt3/gh4J6+3
         JjEp5Kv8DL9QlFhdBpDmCZIfQo3lAKfR0K1IbjXRtKxfG8FJ30HTjIzG5pclMqYyTBbH
         8pPwlxr8gNbVejMJvTMup08U/gmNqE2V1vNciVAxpUgM5OwwBOUUvDnSc3Xf42i50LN4
         b7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKOXVJ/gIK3Y7LJntrKq48fCpR03JWQ2fYAMYde7cMq9ySXAXCac6QFk22qx2t3DfLznWy1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvs7Sq6x8RKNGWJfIuXqFfeWo2w6B+eoGR2qL3K2AubjEQXYH+
	9psplBTSorKh9vDjRK6WCgk5MpPCeGaAw7sGryf/yK0mNxu1A834
X-Gm-Gg: ASbGncszBnNYl/ybxcAXfXyzJU7edmaEuJBjlPLWjVR+VMu5ymwV7rBEI+kvq0bR9NE
	a3I6b1f/WpMJN7/2K/6lk58zDDMtpg+m/oi6AlsOtOJS60wqOAWolrvJ+VQrlKeMH9pNAdiMB8I
	IruCRyY240hWxecS6eWCKGjXcLpvrA6cTkFy0BjzZD6uM80ApDRHCM8eQonsZZyR7oZJ+zTC7LA
	N8fgCk8pdOLvLkdVPcphnAQ9OpJp+Ze43MHtLd4bgBXFOssFAzTg38=
X-Google-Smtp-Source: AGHT+IHBzJXLLj2dWXR3YYrbMX4bq/vX4P4peW4VCCa19Hi/eGQRLLo/YydDJBZAZqtxPRKin7BxVQ==
X-Received: by 2002:a17:90b:4a4e:b0:2ea:752c:3c2 with SMTP id 98e67ed59e1d1-2ee08eb2f0fmr14229959a91.13.1732900897539;
        Fri, 29 Nov 2024 09:21:37 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:c80:4656:59a9:187f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6e5a72c1sm710826a91.13.2024.11.29.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:21:37 -0800 (PST)
Date: Fri, 29 Nov 2024 09:21:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, netdev@vger.kernel.org,
	syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
Subject: Re: [Patch net] rtnetlink: catch error pointer for
 rtnl_link_get_net()
Message-ID: <Z0n4IGetFk+Y5wMz@pop-os.localdomain>
References: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
 <20241129073609.30713-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129073609.30713-1-kuniyu@amazon.com>

On Fri, Nov 29, 2024 at 04:36:09PM +0900, Kuniyuki Iwashima wrote:
> From: Cong Wang <xiyou.wangcong@gmail.com>
> Date: Thu, 28 Nov 2024 22:31:12 -0800
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > Currently all callers of rtnl_link_get_net() assume that it always
> > returns a valid netns pointer,
> 
> because I assume it's always tested in rtnl_add_peer_net()...

Why is this assumption?

I seriouly doubt you can assume that, because for example in veth_newlink()
'peer_tb' is parsed within the same function and it is right before
rtnl_link_get_net().

> 
> 
> > when rtnl_link_get_net_ifla() fails,
> > it uses 'src_net' as a fallback.
> > 
> > This is not true,
> 
> because rtnl_link_get_net_ifla() isn't called if (!data ||
> !data[ops->peer_type]),
> 
> so the correct fix is:

It is not.

> 
> ---8<---
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index dd142f444659..c1f4aaa40823 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3815,6 +3815,10 @@ static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
>  	struct net *net;
>  	int err;
>  
> +	net = rtnl_link_get_net_ifla(tb);
> +	if (IS_ERR(net))
> +		return PTR_ERR(net);
> +
>  	if (!data || !data[ops->peer_type])

'tb' is not yet parsed at this point and you still want to pass it to
rtnl_link_get_net_ifla()? In fact, it is even uninitialized.

Thanks.

