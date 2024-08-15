Return-Path: <netdev+bounces-118703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9E952850
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D0B23E97
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1730F179BD;
	Thu, 15 Aug 2024 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD2H0Ajp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7373BBC1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692874; cv=none; b=sT0JUAJNbLeOU5Rw0gtmS11rUHizdBd6G3iOXbjV3Z4E3ZWoN7wDXKB197bzwwFuqz3iNauaTGXMrcFZSCakLPs8ZKUbe7jyGRRwZLLhzaM+v6TpW0NqIkDNs/Q+kbCj6r3hwNlVvtk0XlZ0uR/gxEw87XMw0ynuJWd32opLe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692874; c=relaxed/simple;
	bh=LskeHLOxUMrtiYMaGkpeCFet1G2vmBnmWwbbwGmBjjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSNziwAWqFc1iCUTHd4darKz9WKfWx35g1G00xSMCbPmP1cThRQARHG2vgURo6qiaWWhfejdDBEq08AeDyiZvnwhj7eQks9tEHMmVetsL8QVKP2dKF+zEKjCrQl/sE4dURs5r80KniHddpt1zvdJVTgTFPOINsa4nDT0jGZDXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD2H0Ajp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c68b71ada4so453713a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723692871; x=1724297671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+4/xunNrVBNIdFeNAHhM8gKhTcXGDAbnZ5oVytXM6c=;
        b=CD2H0AjpaZg3kfzbfAJ70y5tjKATquiX4QslfXRRC3lzyFih/A+ws8i5sZbuNppyP+
         Gjdnv4uLeTk5XrEUB62rayHTvyG9cz7DBjh9d2r5bxh0BIxE1JVSSYp80E8hjYKyo5Ky
         JBV/gJqfodmn99d7LwOuyT8k5cu3gq5oxZf96XhbZFAQipcQ/dRdvNV1KRfrLd1139BF
         KT1u24nTIeeRbNTknfyVF++whH6tej8e9LHRX2rjVHWDjtYbWWuRrQ4gtta7e3U+TA8m
         5STSdl8sQ78eantbW3TgJHC2LKABw7CwrSnyo9dLpZlx4dkfS3CoSf9FbsisCVxPehzJ
         FOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723692871; x=1724297671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+4/xunNrVBNIdFeNAHhM8gKhTcXGDAbnZ5oVytXM6c=;
        b=OrC6sr8mqafKPhfy30FbobLB/0jUe4yI/ma77RxWJWaUaRKuYrIHZZGRfM0P+LFxYB
         JS1c12DpNlpBGjjuNQRyab6pQ55EMp0lBnrR0YXxdcbiNNbamfz9r7dsFwF/IgCCK9dR
         6seSei6Xd9avgnyVoEgEdUxuvXzdH/dQLF0AgEY/G5bPy7qGK4ooo5G+j/Vfvp/NWt1J
         BZC4gR9c4yiqrRFS5ZsU3pYf06im8Ok+sC2OeZDY96rvwkvf2zoDZz8+nHYCXYKfl4XR
         BwgOCfbhGiu64qU2rvpYE0BmqDc9DwVTnJ98m78FwMUf6ykuANgeLbsFY8UoQLcLjZXL
         tImA==
X-Forwarded-Encrypted: i=1; AJvYcCVc3wleZiEYs3sbPmwEWvKRqvS8tCHhdxgaxrbzzP3+70A90+HPkGXqpiVW7p0rHESqnX7QqvUiuLwORaeXPbgw5e4BmJ3B
X-Gm-Message-State: AOJu0YxY0qs0L1dzNyfOt6q1jVN/7CsIeTPq44kkxUvO0bCxQ7gmz4nM
	kXfSvMdlIkgQ/60dd139Kq1qhd8/XYeF3I2AqL6NXlJ45KHmz6Pn
X-Google-Smtp-Source: AGHT+IH1fte05DP8k3ebLpinjySNfojjYbsMIW9vsnGDruTTPWAFUL3hktw9EWAhiBoRE+KZUvSckg==
X-Received: by 2002:a05:6a20:6f08:b0:1c3:b16d:9ebf with SMTP id adf61e73a8af0-1c8eae6f45cmr6129429637.15.1723692870745;
        Wed, 14 Aug 2024 20:34:30 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af416fbsm291379b3a.207.2024.08.14.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 20:34:30 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:34:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	Gal Pressman <gal@nvidia.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Message-ID: <Zr13QBes8L4i1Kvn@Laptop-X1>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
 <20240805050357.2004888-2-tariqt@nvidia.com>
 <20240812174834.4bcba98d@kernel.org>
 <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
 <20240813071445.3e5f1cc9@kernel.org>
 <ad64982c3e12c15e2c8c577473dfcb7095065d77.camel@nvidia.com>
 <ZrwgRaDc1Vo0Jhcj@Laptop-X1>
 <e7ee528b3db5ba94937ca6c933f9060e32f79f3d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ee528b3db5ba94937ca6c933f9060e32f79f3d.camel@nvidia.com>

On Thu, Aug 15, 2024 at 01:23:05AM +0000, Jianbo Liu wrote:
> On Wed, 2024-08-14 at 11:11 +0800, Hangbin Liu wrote:
> > On Wed, Aug 14, 2024 at 02:03:58AM +0000, Jianbo Liu wrote:
> > > On Tue, 2024-08-13 at 07:14 -0700, Jakub Kicinski wrote:
> > > > On Tue, 13 Aug 2024 02:58:12 +0000 Jianbo Liu wrote:
> > > > > > > +       rcu_read_lock();
> > > > > > > +       bond = netdev_priv(bond_dev);
> > > > > > > +       slave = rcu_dereference(bond->curr_active_slave);
> > > > > > > +       real_dev = slave ? slave->dev : NULL;
> > > > > > > +       rcu_read_unlock();  
> > > > > > 
> > > > > > What's holding onto real_dev once you drop the rcu lock
> > > > > > here?  
> > > > > 
> > > > > I think it should be xfrm state (and bond device).
> > > > 
> > > > Please explain it in the commit message in more certain terms.
> > > 
> > > Sorry, I don't understand. The real_dev is saved in xs-
> > > >xso.real_dev,
> > > and also bond's slave. It's straightforward. What else do I need to
> > > explain?
> > 
> > I think Jakub means you need to make sure the real_dev is not freed
> > during
> > xfrmdev_ops. See bond_ipsec_add_sa(). You unlock it too early and
> > later
> > xfrmdev_ops is not protected.
> 
> This RCU lock is to protect the reading of curr_active_slave, which is
> pointing to a big stuct - slave struct, so there is no error to get
> real_dev from slave->dev.

It's not about getting real_dev from slave->dev. As Jakub said, What's holding
on real_dev once you drop the rcu lock?

Thanks
Hangbin

