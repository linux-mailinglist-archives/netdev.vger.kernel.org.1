Return-Path: <netdev+bounces-117053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA094C892
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4545C1F22608
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9A175A1;
	Fri,  9 Aug 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF8Ge7QD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D017557
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170679; cv=none; b=MJnDokQ6VWd2eFncwUo2ZE5qm1jP8C0wcaHK8pl4yphGVYVbdl2yMhmndsh+oWjhpCId9F1sXwaEDawpI2/vrTiQVgYJltB2hyfd1+VjCwPByInTV00I88Q+coH/qrjEnO1uGzngB4yqu4iRNWDshGnkJeInuCCSa1O64dgIUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170679; c=relaxed/simple;
	bh=Fvoq0Hzc8tDQ1UkYcOg8Nsf6+yE3VEFzB7vf+ne+fsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruBzw3vj9BJWZoRv7glK0ZDhJBF1xVY3RUuvSDKmQvGpSGJE/cSxbBUYomvYxT2IpepVC2EXlWl6ZXRT/NQ7FHiEqbjYvGUi94CZMssOLIWbsfxj4zGrwdXogwDAFvN6Kt5dk53ser5sZn563qTycaeKOUmJsvyDeCbzj+ffn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF8Ge7QD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fdd6d81812so16749235ad.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723170678; x=1723775478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KkqFCuMJpxnSlr/LT5nHX7pkRQEunW8MBFErzToSuIE=;
        b=XF8Ge7QD/fIrAbcLQbScQRuVcZM2qDz0EDpWDQZMCevRZLfx7enP/noy1xuViBKdou
         f1PH2q0qhaVh4TxtoKUSUld4o1kzbWfLHL/VrF1pdcs/20/DVnkTrWkQh47HUAHm5NUR
         Uz46zZ4IeuRmED7Fo/qMD/zbbDaMJpe2HXhxd4bnKdQyUfFoXIIIdOYE8247A5aLH+6w
         VaK3ztp+LkB0WNN/0lkaSnCRRc1P2zGH8pTd0+O8OViE3lwNhTI7BmAUHnHIf5tiiN1E
         B6PIYK5iqfDh1B6oqmW2fa0ovKRhxa2/fha5fZHlW+C0SMiWp/W7dvyXElqQps3nPriN
         hSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723170678; x=1723775478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkqFCuMJpxnSlr/LT5nHX7pkRQEunW8MBFErzToSuIE=;
        b=Pw4ALMKtdi7+PkAzuNF5Eu2y8Eg5v78kCuXNlbfxF8yPC+Hwv3BOhxwUuGqJ/J5ZDL
         L635KvUCruOogCWq/OKpbcBd1Z7H5xdK1R7vYu/VmTbDpF9frjenTSUmsXkkUtd4MOZj
         +JHaO8X61h02+59h8EBI3OLPCvVGA645wTIXQHp6t2S3gws2uDt81xLzQdf1e0UpseJA
         IDBFqcsNhxzRTiHtsw4bIDdhMAQ9vMcz9fPw//0ibg288o0a8L1nzmSLdGmnHBV21Ny9
         qdZaiR1Xvkob1EmvQFkRSejJ5ro7DlHqDuptJWfCIZreGvhjmqHr/OgcOWboHqslnlpz
         47Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXjaG5yDaknTc8M0q7J6KvorXeQcRto9yHhYXSYnqhzJJyLW4dDDu69HWiVQtBI4frjgfcCz//EnPhzAqfv9qqSi3MRlQVf
X-Gm-Message-State: AOJu0YywmMqYPhBPldjWiJZRqs7TT4BeSWXlhXUbOnDHC/Ck0exrKjy/
	Iuq/zdnHt3Eh1e60Rj9XfkLguY6RPuRkDx+3RlwctdaKFiTUTg4o
X-Google-Smtp-Source: AGHT+IFe2kDNOyVpTqsw5nL4E35JzuAWxidSKlNXkVjFPrcyPoIEzUl/1p03EP2ZpgIjO14tEj1nsA==
X-Received: by 2002:a17:902:f68a:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-200ae59ba60mr403885ad.41.1723170677450;
        Thu, 08 Aug 2024 19:31:17 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5a473sm132489345ad.106.2024.08.08.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 19:31:17 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:31:11 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Leon Romanovsky <leonro@nvidia.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	Gal Pressman <gal@nvidia.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net V3 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Message-ID: <ZrV_b9IfYXwSm3pm@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-4-tariqt@nvidia.com>
 <ZrSRKR-KK5l56XUd@Laptop-X1>
 <0ed0935e51c244086529a43aa6ccf599e5b3bc52.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ed0935e51c244086529a43aa6ccf599e5b3bc52.camel@nvidia.com>

On Thu, Aug 08, 2024 at 10:05:26AM +0000, Jianbo Liu wrote:
> On Thu, 2024-08-08 at 17:34 +0800, Hangbin Liu wrote:
> > On Mon, Aug 05, 2024 at 08:03:57AM +0300, Tariq Toukan wrote:
> > >  drivers/net/bonding/bond_main.c | 75 +++++++++++++++++------------
> > > ----
> > >  include/net/bonding.h           |  2 +-
> > >  2 files changed, 40 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/net/bonding/bond_main.c
> > > b/drivers/net/bonding/bond_main.c
> > > index e550b1c08fdb..56764f1c39b8 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -481,35 +476,43 @@ static void bond_ipsec_add_sa_all(struct
> > > bonding *bond)
> > >         struct bond_ipsec *ipsec;
> > >         struct slave *slave;
> > >  
> > > -       rcu_read_lock();
> > > -       slave = rcu_dereference(bond->curr_active_slave);
> > > -       if (!slave)
> > > -               goto out;
> > > +       slave = rtnl_dereference(bond->curr_active_slave);
> > > +       real_dev = slave ? slave->dev : NULL;
> > > +       if (!real_dev)
> > > +               return;
> > >  
> > > -       real_dev = slave->dev;
> > > +       mutex_lock(&bond->ipsec_lock);
> > >         if (!real_dev->xfrmdev_ops ||
> > >             !real_dev->xfrmdev_ops->xdo_dev_state_add ||
> > >             netif_is_bond_master(real_dev)) {
> > > -               spin_lock_bh(&bond->ipsec_lock);
> > >                 if (!list_empty(&bond->ipsec_list))
> > >                         slave_warn(bond_dev, real_dev,
> > >                                    "%s: no slave
> > > xdo_dev_state_add\n",
> > >                                    __func__);
> > > -               spin_unlock_bh(&bond->ipsec_lock);
> > >                 goto out;
> > >         }
> > >  
> > > -       spin_lock_bh(&bond->ipsec_lock);
> > >         list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> > > +               struct net_device *dev = ipsec->xs->xso.real_dev;
> > > +
> > > +               /* If new state is added before ipsec_lock acquired
> > > */
> > > +               if (dev) {
> > > +                       if (dev == real_dev)
> > > +                               continue;
> > Hi Jianbo,
> > 
> > Why we skip the deleting here if dev == real_dev? What if the state
> 
> Here the bond active slave is updated. If dev == real_dev, the state
> (should be newly added) is offloaded to new active, so no need to
> delete and add back again.  
> 
> > is added again on the same slave? From the previous logic it looks we
> 
> Why is it added to the same slave? It's not the active one.

OK, I got what you mean now. Thanks for the explaination.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

