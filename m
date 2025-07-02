Return-Path: <netdev+bounces-203223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A9AF0D32
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60221C23272
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87322DFAA;
	Wed,  2 Jul 2025 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxzHjiAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C7225A47
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442810; cv=none; b=GGfGKPl5SZTcmcKAh9A8/EHqP4UZIBTo8Av9fHuWpHMyBI6hAhkIbv8xG/S0scrJeb20lvzBPhoh58dvINtxbf4dLCkRWVPefhP5OyEXVG8MDt/jypg0sI+SSI3p0eKqC8jJfR9tZKRpDdT3v6RtumQZXooeAAK7Pc2jVZq9Ptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442810; c=relaxed/simple;
	bh=zHhssj1BscwSCnFo8k5K8w92P0g4snuNMGaUFcK6yiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKkO8j8IjsXBGxdmDP5V6xGWmlwTIwLTGv1hNEYofaJN77j2aUnKm6sdrRJdb6Sd1MenP5HRmXV3yV8k8mJIy58XCQd3r47z3+flp+ZK63XhKgkjPNx+W0nfCq8BgcPl/9leKFwPEsmkmPtcx/T2NYmuL+0RiJ+jetvcfseAfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxzHjiAl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234fcadde3eso54139035ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751442808; x=1752047608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AX4HjizhyCl6AUaOnZaLwNRLSmCn9508YystEK6mmK4=;
        b=OxzHjiAljGOrOStItt3vHQKjYBJcKfa6sFepRS57wf15kGcHtt5G0tY90gQ4vhGgU4
         Mp785fktoUbtzZM1hur0drcFv2VZHLPnjF86FD57LWaZD8CBi+dGpdJRY0uvPGOqWmoz
         F7uKoswrWB9lvVF9N/inow7ymhx524AAsQnksfKcl3ZzqNOM47YNbMoZPNU4Kd5taTX/
         NYzuWMshp3MOUzUPn86fJebRAzm31VbW1aeKxMmTSbN7S8WrjXY6hOd9JWGzqNR0SVLc
         Zaw+VfAw8VUFR/dt/p+DFGEqDEj9zF9ZuOen/S9rllZsEDVjD6bK4sDmDRycHlFVF6/I
         sStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442808; x=1752047608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AX4HjizhyCl6AUaOnZaLwNRLSmCn9508YystEK6mmK4=;
        b=Pj8MOiVdMWFucK+PtFGjz6BdL72MsDUANdOE0WXbY8/Pya0c/fdxJV1C8bNrvaHEIj
         19GODsqMBn8WYTx656o8lc0uWe7R/qX0IdSLQVW1mnz5baGcpDJI0lj/DQI73XITTv8P
         g+CVGfWuQsL2Vw4xya2UnOO3dJLB3JxbMCIbUSAuFqBVFXzaK4sJPL0eh2i0hq0w/aZE
         fnMFrggdAtwJkMO92RS/OhAfaNK8YNMSoUuBQxxAvS9TrTq2tdE6CBRcmuV4LbAdV+Gz
         z/Kh18U60ZXNsjtf4XwzWXjcTpLn8fu5OJ1gP78zxG/iGQl77+JoykVDc5QOQ83swFST
         FKRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwil0fltvQGkPo6CRjzcEeTn7rdUyMyc5xgdNqrc1UBNozRv/vmWuIJS910qQ/IhWqVK+f6ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw258+s/Da1TPLsEq4l1TXaCo3A/mwZcLQDYRKeYADfIon68LTY
	FI73HHw5OF0HEwwdSxKzYVIZW0aNBGkqCCc2YQw2+O3RsEjl72+gy7Vf
X-Gm-Gg: ASbGncvZyRmrC9QZKlK4+kzm20Imm5zviIcoyJvGAkzzPxruVt/aeMaoLFffshrBMvL
	hYO7ZIBWCT4YRr/Cz9BbeRvSoJ1tIhgXb00YybD3IMqC9vwrAaEdYi6l4wM6VAlt/Kmz6EWwNQv
	ePrQm/FSp0MzoE9826IAK3wXIkScn0vDb0ZWMe0u2HY+0fLlmYyOFapXi6hiLyFUnjnkf+6qxpZ
	I5ZSg3Ueg2/E3YU1Vh++qa+IM6TUdyau8Ko1wTjNCuil+XLoLkzoeMf+L4kZ5gqD4c9geoh0Y/n
	RMfRHjPaUkvQucbDvM+Q7q0XFvGNunw26NIvec6we36qNSXs50NsIB5obYeCBlubpbWyjSMgiyV
	+HA==
X-Google-Smtp-Source: AGHT+IHAgA48M+8PH74Rm3Kz2xORYKVs0osmoGBeg+PaiJHh+3Q1nvmyof668u//iarnTCn0u7v3dg==
X-Received: by 2002:a17:903:1c5:b0:234:bca7:2921 with SMTP id d9443c01a7336-23c6e589771mr26784485ad.33.1751442807793;
        Wed, 02 Jul 2025 00:53:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d7406sm132042965ad.259.2025.07.02.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:53:27 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:53:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Erwan Dufour <erwan.dufour@withings.com>
Cc: Erwan Dufour <mrarmonius@gmail.com>, netdev@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, jv@jvosburgh.net, saeedm@nvidia.com,
	tariqt@nvidia.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Message-ID: <aGTlcAOa6_ItYemu@fedora>
References: <20250629210623.43497-1-mramonius@gmail.com>
 <aGJiZrvRKXm74wd2@fedora>
 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
 <aGN_q_aYSlHf_QRD@fedora>
 <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ1gy2ghhzU0+_QizeFq1JTm12YPtV+24MyJC_Apw11Z4Gnb4g@mail.gmail.com>

Hi Erwan,

On Tue, Jul 01, 2025 at 07:29:48PM +0200, Erwan Dufour wrote:
> Hi Liu,
> Thank you for the link.
> The new patch with the good tab size can be found at the end of this email.
> 
> Hmm, I'm not very familiar with IPsec. I thought we can config xfrm state
> > and
> > policy on the interface at same time. Need others review this part.
> 
> The ip XFRM state and ip XFRM policy that you see when you use iproute with
> 'ip xfrm state' or 'ip xfrm policy' command in cli may be on the same
> interface.
> But in the code here, the struct bond_ipsec is just an element of a list
> used to store all the SAs and SPs linked to this device bond.
> So this structure allows us to remove the SA and SP offloads from the old
> primary slave and add them to the new one during primary current slave
> exchanges. (function bond_change_active_slave() )
> The bond_ipsec struct is an element of a list which stores all the SAs and
> SPs of the device bond.
> So every time we add an SA or SP to our bond, we create a new bond_ipsec
> object and add it to our list. This is why, in our structure, we cannot
> have an SA and an SP in the same bond_ipsec object.

Thanks for your explanation. Unfortunately，the alignment still not works.

e.g.

> 
> -		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> -							     ipsec->xs, NULL)) {

Here the ipsec->xs is aligned with real_dev.

> -			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
> -			continue;
> -		}
> +			if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
> +									ipsec->xs, NULL)) {

But here, ipsec->xs is not aligned with real_dev.
If the code cannot be aligned properly using tabs alone, you can use spaces
to complete the alignment.

Thanks
Hangbin

