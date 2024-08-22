Return-Path: <netdev+bounces-120765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F173D95A8EB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2951F21EFD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1D1D12E0;
	Thu, 22 Aug 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Guj65bSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1279C8
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286805; cv=none; b=mdgCtvlbgEWrcsm1zgND4Xf8sfYk6+s19EsuWodG6S8skG+wadnHfq5ojQniYWcFvjrhv7+5YWuhwVnfllYu7UANVP11n8Mg9JDYz0KgpSmR+ZgYBHo7m+ToQzkMcIclm5muoKV5bR9Jhk9f3jXbRIEAq1lg3fr83GyFljFnoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286805; c=relaxed/simple;
	bh=83xl5phrWdO8vAsdlN5LGg1RRmn1KisFXHxqD0fFI2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKV/3SjWXUBpkD0XoIGMyxl3BFeqbQ2TXqbAHH6P1a3FDt85f8xuly1TgTet6MxTsBA5D5QT1E7puOUMO4CYBxvS4Kh34fQWai8VMbdxfieFvMkw6HSw2BaX2hX/aPS+96tq71Z6jLXlA/8B9WqxEwq1j1kmi9+kLNVAvSmhtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Guj65bSa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201d5af11a4so2101835ad.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286803; x=1724891603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFGXsJMnVXfHBdzZJZ0tYJvFbmfrS/Ew/bZkNe7iVHs=;
        b=Guj65bSaVvIq1+lkq05zfOpfQ8E/woHjo4lHeOFiJQDxN0Ti5J/qzM1sKcuduXxqv7
         WRuZIfoleOxrttBNDoB17qifHbUDz7Nt6rZD4sLXLCaeDXteLYE4g8+xX5Tig5CTPlUN
         ycutxHpPJkUOAtwPi0zRkOL73G38bOcUXgLsx2ytDHNWVrByaZd7Md0VkAuBLhwNsttn
         OcUMiP40G0ePya8ArzdFkpT8WCywhv783mNLQ9Ilm58w4NcYy9uF3CJTED+lwVkdufdB
         rDp2lRhzCN+E5c2wuXr/ny6FfqQ0NQawuFZvWgKKedgPgQZURRcQBmfygbYq0ukB7NeE
         XMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286803; x=1724891603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFGXsJMnVXfHBdzZJZ0tYJvFbmfrS/Ew/bZkNe7iVHs=;
        b=fmoK4+15uBtf/IR5FuvUaljWuZmIVwSkeslwskilK4hKc/ke5pmxrj0/F7LUwhi7Bq
         00x4UuGUHpn0Ubha6Ev8BfB7wykBnZLDZL6iKXjQMPsFEDIKpkp63QmjLzcbgQj6zISk
         1RBvpUK561zzkFqrR3ExPGoYrFO4tp23/UUhEv3QosGYU6wWQsO3Z+bYhwPZicZv186y
         CURDmqWtDziLcg/HzJn3HgM7vFcrSC6h/pqz8KMMhbc5kLsj09JOX+1iXgzsul4Kjkd4
         yd0BTOO52W6tmmes0W7GkreQo/tXG0jK1i+mTO2uKJjeHsdgpfBiM2Dk0e5jfzhUFdf7
         Rl2w==
X-Forwarded-Encrypted: i=1; AJvYcCWUNx93uzkE0oFupKWezZVs1Q/ntJ20oQB5Ty8l/nXDt7aDgceDP47G2IpbfwVURL6WKoAks8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjX8GYdwQeulgtZIHOkNDsqU1Byf2m2+r8gtFZK5p0/MFJT7XT
	YyZ0WyUBw/uwHW9ffo0fC3mhzrUkjadFb0LTZCrpGoW11r0IKbo8
X-Google-Smtp-Source: AGHT+IFbGGPxkuVSSPH2XyPEku5SPClFi70Iw3p7UPm32BhFm7Q6jdRXqyqG97wzgZodYezX9Q8h+g==
X-Received: by 2002:a17:902:e5cd:b0:202:1b1e:c1d1 with SMTP id d9443c01a7336-203680900aemr49169005ad.48.1724286803183;
        Wed, 21 Aug 2024 17:33:23 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf9asm1723705ad.179.2024.08.21.17.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:33:22 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:33:17 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsaHTbcZPH0O3RBJ@Laptop-X1>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsXuJD4PEnakVA-W@hog>

On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> > > > > +	if (!real_dev->xfrmdev_ops ||
> > > > > +	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > +		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
> > > > 
> > > > xdo_dev_state_advance_esn is called on the receive path for every
> > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > > > be ratelimited.
> > > 
> > > How does xfrm_state offload work on bonding?
> > > Does every slave have its own negotiated SA?
> > 
> > Yes and no. Bonding only supports xfrm offload with active-backup mode. So only
> > current active slave keep the SA. When active slave changes, the sa on
> > previous slave is deleted and re-added on new active slave.
> 
> It's the same SA, there's no DELSA+NEWSA when we change the active
> slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> the driver/HW), and only a single NEWSA to install the offloaded SA on
> the bond device (which calls the active slave's xdo_dev_state_add).

Yes, thanks for the clarification. The SA is not changed, we just delete it
on old active slave

slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);

And add to now one.

ipsec->xs->xso.real_dev = slave->dev;
slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)

Thanks
Hangbin

