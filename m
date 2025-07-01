Return-Path: <netdev+bounces-202763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973AAEEEB9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009CA442E7A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95310247290;
	Tue,  1 Jul 2025 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdd/wD7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75B25B1E0
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351221; cv=none; b=gw8MMh2nhdSBACrZJkAHFzejhTMRjQp+JFGVMeIAwG1I61CDJi/W4jdpaVzQ82vXABsfhdyJAU+CsONp84kF89HC5kCcrq2TDvdh6jvlOPxNLOIrElSKLDrSOJtqtI63tkxauqUouoO11ocN4c1kzIyaUjDXFaRr2+BzNU1UEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351221; c=relaxed/simple;
	bh=wDIRzQVXewTaEaqXbVPyHWn84WqoNPzmtS6yf9yoZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjPJMcHvEwDRBh0aP3/xUGzW8wXiL0DQa1RX6+wpWcEsZgvGgGnpBOQi0NcsFFEhshnPd1Kjkb20MVUDGzZRsryXl6XlBLO+Q1RE4rSQnLD2yrB3XNUUoTZcea+6U0gH93+IpsojIN7+I7o7DuoGJ2t6xK40CheylciS16lvKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdd/wD7b; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso6236437a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751351219; x=1751956019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI+3Hq1YSdoH55v0UD6nVHksYa+bgFRJCtit+ZFeufk=;
        b=Vdd/wD7bky7bKlbeV7wb4qi0mqR1Bsa2Ct/Leg2/rRoME0Wf2cT7VkLSacyBBxCu0a
         1q6x52zkT7OxsAeuiRVp9pJfNdRv4vrqo2V0qK5FeaW+FwZFbNNQQrCYvm8UMQ4WOfFg
         xHrBqJ8RjDPbGU9dSgv/HhK7H/FdZs2lAimxLCt7g9s0K+i6bYs6dygrGsNn5A/EJjs2
         0B20dv6Rkq7lg7BSA/NDPIUn+pGAMBmjqOWzRgNgTuULiAPCc8/6IHzLWCiA6mmXNpbY
         As9u/XOmdqgz5gtFLftlWR4gZjRdgbEcYqzWYtbYkQ8RPlH7iPAhN3nzdieECU/7hC+S
         oppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751351219; x=1751956019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI+3Hq1YSdoH55v0UD6nVHksYa+bgFRJCtit+ZFeufk=;
        b=adaHj6M2Olls4HUlan8bTtG+18RaxdWiczDcRJqdSgOpkSAPsf7axEawBAuj9Kz0aD
         5MTFIPFTeh0Q3n/nNQnTot8rVGTtxB/SaQLK77WYBxLca8iHY+BykCIhqzVc1YZgFNbg
         87+mB5YeDRJe0TmNM0WFYw+TylAd+qupBwx41nXhzZP9qOZWol2gi2hH4OVyDgVc4Jrx
         2MDbxO30jlYZ0kC2yZ7eTi8Rn+y0EFQKFIgfSmW2Xwhu2gK3ZizGkN5wbVFCIbi/0RIV
         a4gZKdx5vL6XznOhQZnLA+X4WazhsJTXlVKWFrAv0OB5sHtlHx3l0n04XXOthTshqRta
         u0jA==
X-Forwarded-Encrypted: i=1; AJvYcCXGvar7kdipPmFBi/nKd/ViUc3QkHFQx+P3Dedl5qbrH1NmeWzULQz7kmULg+hyPoxjPTrNyW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRO1hEjieZQRXWum9uLIqdLLy4SXueXF8THUNYWlNR8a9dqGs6
	5TRyjSPpAwGIve4W+/zLPKK3AQxDrP1ssEs74KRXU1BXoSFjnpR8YtPn
X-Gm-Gg: ASbGncvcqyjNnA16Rh7RMXjOStYf/z5SpZWwEqC60SyRCqbq5URswVt+Vq98cwtVMxz
	h037RClX3AMkovtl1MEzP5FzbyVJuwkEEEHVulfBPtCUAw/mpWTVsndPK1q7UvAD/3MVD4OOTPx
	YwIimy0OQmQkNmHXvm/Xk16et5YraYBGxEhlMNg4IotlzkRPsGmU8KZW5tqZ1XBupDtcfGfueEP
	ALUmBnpvcN1bQpPfh/TuGYXdjkJALOOrgQiYkLwtgi7H2w+uuay2xojmf9UwsB9O8IsHRL9tiOZ
	yiG/9XeDq4360kaxINMmr/gUMWHZyoX3nNoSlLo54Kf+HYonBnm7WhpI2lRxWSu9Fak=
X-Google-Smtp-Source: AGHT+IF1hisu54GanXzIg2lQePLtu1X9KFQVwa332FtJnX866b6r5VFAE/dPT2nS+VpL/pyMk9iyzQ==
X-Received: by 2002:a17:90b:4d0b:b0:312:db8:dbdc with SMTP id 98e67ed59e1d1-318c92ec0bemr20778817a91.20.1751351219045;
        Mon, 30 Jun 2025 23:26:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a3a26sm11167280a91.19.2025.06.30.23.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:26:58 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:26:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Erwan Dufour <erwan.dufour@withings.com>
Cc: Erwan Dufour <mrarmonius@gmail.com>, netdev@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, jv@jvosburgh.net, saeedm@nvidia.com,
	tariqt@nvidia.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] [PATH xfrm offload] xfrm: bonding: Add xfrm packet
 offload for active-backup mode
Message-ID: <aGN_q_aYSlHf_QRD@fedora>
References: <20250629210623.43497-1-mramonius@gmail.com>
 <aGJiZrvRKXm74wd2@fedora>
 <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1gy2gjapE2a28MVFmrqBxct4xeCDpH1JPLBceWZ9WZAnmokg@mail.gmail.com>

Hi Erwan,
On Mon, Jun 30, 2025 at 03:50:46PM +0200, Erwan Dufour wrote:
> Hi Liu,
> Thank's you for your feedback,
> You can find the new patch at the end if this email.
> 
> Please fix the code alignment. And all others in the code.
> 
> Sorry, I'm not really sure to understand. I use indentation in TAB mode
> which has a size of 4.
> I'm not sure to find alignment problem ?  Maybe I don't know the rules for
> this repository.

Tabs are 8 characters.

More coding styles, please check https://www.kernel.org/doc/html/latest/process/coding-style.html

> 
> In xfrm_add_policy() err out, it calls xfrm_dev_policy_delete() first and
> > then xfrm_dev_policy_free(). So why we free ipsec->list in
> > bond_ipsec_del_sp()
> > but no bond_ipsec_free_sp()?
> 
> Good question. I've taken inspiration from version 6.15 for these two
> functions.
> I've just seen that there's been a commit and now the ipsec is only
> released in the free function.
> On my review patch, only the function bond_ipsec_free_sp release ipsec, not
> bond_ipsec_delete_sp.
> The function bond_ipsec_free_sp is always called after the
> bond_ipsec_delete_sp function.
> This is why we now only release in bond_free_sp().

OK, I see your new patch freed the list in bond_free_sp() now.

> 
> 
> BTW, if (ipsec->xp == xp), should we delete the whole ipsec_list? Is it
> > possible ipsec->xs still exist?
> 
> In our case, the struct bond_ipsec *ipsec can have only one xs or one xp
> but not both.
> In functions bond_add_sp or bond_add_sa, we create the struct bond_ipsec
> and put the value.
> This is the only place we create a bond_ipsec, and we never update it
> either. We only read or delete it.

Hmm, I'm not very familiar with IPsec. I thought we can config xfrm state and
policy on the interface at same time. Need others review this part.

Thanks
Hangbin

