Return-Path: <netdev+bounces-106985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1157A9185BD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB128A638
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642D18E77C;
	Wed, 26 Jun 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rS86kXR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE6B18C32C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415656; cv=none; b=JrLHF1HMfUmxYuLpLUyef8xOGERQSKe8A08dZ5T0y71Ik8qlhAVJVwOZZ0dFmDCrgKrU3gD/DnbUglOIvgCJdLzRiet4je8964nWFNHKZLGwMe0b5ZEv/h1kgq5rmC2KqzThJvXCzdgZV68bwWBMdl4gTaSq1eX11Al8QLZ89ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415656; c=relaxed/simple;
	bh=Exk5++CZNMPli7eU5lH8+FvFjnJaWOuCKi7bnaDtpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1niENapGIv7gMikB5Ck5wIFwQWjEP2JcEhFRsYoZ52pp3AeXcM2u8e5iwHqUAjr8E+r86wezkp/qmdGdQr6h2jeosFQYeCf5hKdm+hZSn19om+0nW/q8IbNTRYw55/stx95521hvuNnVrXJE9KPZDPAClKBu0zj1Kx0HXjU/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rS86kXR6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066a4a611dso3165160b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719415654; x=1720020454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLghjMN/gR4JZrzecBmwd+1p/A6o6fyDtq3yVGbRnR0=;
        b=rS86kXR6garl+StCdbWxU9EHEGWv+Dsn8UZNOU+Cx1E0QYvrZBs8LEPe01gW45lIdo
         8EPH09nrOgfs1cZYgVmAGXJJox4THlNgT2TAm7obEUuing35YSDQprNkYMSNuGntMGly
         839CM+3xdaHPUXtYSpGNeDCXf49d1f4OOMFEwiCbDn8WNVtsGQERrEUq0LCK3Ew4xNwy
         H7GNaWE0c4AyulYsG1i4RCqWSPITuxIcNxkQ92TVx41TWsLN4zxXT2vzOyOyWIxI9J/8
         yiTJlkK9c8ghuk803gJmTgLWllRMlyGg5lz9/NQXG/TwHCgy30785z1zMk/EY7uYarMj
         kzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415654; x=1720020454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLghjMN/gR4JZrzecBmwd+1p/A6o6fyDtq3yVGbRnR0=;
        b=a2I+QY1nmvGWi0ODdLz2VdfZjutfgeIIj6OPEMFMko5w7RhlYvq8JwYPtFJliCJm8I
         pqDygNmODFyKgXqHKphSgSXKeye5VdGpDGcUxCddCM4Mame7PP4lzhNe4Q5zBrfFG6Vi
         1o0Qu1dob9GGLW9/b7U4cdQnKSOVCNTZ2IalWPTeaoELiedOGmzrhfbB4UKU3ax6W3x+
         6F1sam3bcZC4sui0TeNovhHjBQemjS6iWXawSkVI0/N52IC42wBuENtu0HJ8OlR0fPK7
         wqX5x1e++gZRur2oiVG2yhcKYp8DMVCJBkdCRWUk1qXGB+ebuAWSoIB3hpjr07mfLbjL
         aRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUe1lh30ZyLap/drzdrI7t5AkpKul4ZhYoptIYLuW2RHTzdoo+75r6YkONCjVXNXV7N5eekKxdMMF5AodBCOwLAizE4MQ+Y
X-Gm-Message-State: AOJu0YydCaR3JOGXvz6AUqIZpHJATg9mfczp07SyDyCwOIo4c0IeRlnJ
	QlWygFjnIjeTvAQNM3QfDeVMm3B/9aDKNKyFwFh6R/qPBzhGTunveodUrhgb+Hk=
X-Google-Smtp-Source: AGHT+IGqvjX9OglQ0q2V2X6Kgtz0VA1qEqYB42wpjPwFNXbzjBtmyF1FDgIXed1B6bwRzxY8C0AWbg==
X-Received: by 2002:a05:6a21:339b:b0:1b6:dffa:d6f8 with SMTP id adf61e73a8af0-1bcf7e6b981mr12103380637.3.1719415653914;
        Wed, 26 Jun 2024 08:27:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067d11a437sm6404270b3a.118.2024.06.26.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:27:33 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:27:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
 <kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
 <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626082731.70d064bb@hermes.local>
In-Reply-To: <20240626121118.GP29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 15:11:18 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov wrote:
> > > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > > When mana is used in netvsc, the stored net devices in mana are slaves
> > > > and GIDs should be taken from their master devices.
> > > > In the baremetal case, the mc->ports devices will not be slaves.  
> > > 
> > > I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a first
> > > place? Isn't IFF_SLAVE is supposed to be set by bond driver?
> > >   
> > 
> > I guess it is just a valid use of the IFF_SLAVE bit. In the bond case it is also set
> > as a BOND netdev. The IFF_SLAVE helps to show users that another master
> > netdev should be used for networking. But I am not an expert in netvsc.  
> 
> The thing is that netvsc is virtual device like many others, but it is
> the only one who uses IFF_SLAVE bit. The comment around that bit says
> "slave of a load balancer.", which is not the case according to the
> Hyper-V documentation.
> https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
> 
> You will need to get Ack from netdev maintainers to rely on IFF_SLAVE
> bit in the way you are relying on it now.

This is used to tell userspace tools to not interact directly with the device.
For example, it is used when VF is connected to netvsc device.
It prevents things like IPv6 local address, and Network Manager won't modify device.

