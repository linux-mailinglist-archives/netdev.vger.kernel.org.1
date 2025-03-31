Return-Path: <netdev+bounces-178429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F8A76FED
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867E23AAA15
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19821A435;
	Mon, 31 Mar 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuBdK4Uw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DC2153CE
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455194; cv=none; b=FXk3UvRkL0zpl3nqyQ2LVLjvQPSlrFCWs5rO+AQ6rjc65XkUUhyaUfGSK1XvFiAKP1D8G412xrsyovgKctTRgnGnS1EvzfrJiKDO7Yb3gGBhJmkMI00JdrmduFeKrqAEbLXiw1j+pKjc25ZU8D2lZIPl7kUyEv0aq0tEtfa0j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455194; c=relaxed/simple;
	bh=Dk1VcguMht2nTcwj3uFpQ0ArG2yno2su+1rycgbMevg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7LzCLEJodXybhNHWKsEjCpXM48IS8V00tMCZ3cIcENfm1eS6uGkWvSrAGPWmIewsueNhfQP51j0EQpWZ6Svh/wG/KP3+MIYF5i3IxfGRYY8mPxCJTkVRMTniYC3C6Qfl4KZWrqDtwzRBsleBqlwWQa16jPgYaLBjHxw3FZPOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuBdK4Uw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so132952305ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743455192; x=1744059992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aKsaAcq6agx3Z+fVFt9fX0kjTgnx6HI3CKvH6wQ9aI=;
        b=PuBdK4UwECB3iffgYd0gefOcoI6BY0dpMBxRwX1fq/ld7OmuNko25fLIMxKvY32qAy
         uqw/ORWgmByCfpK8kiEUNSTvGLEzPsQm7CZ/H6ITQeSq0qIQkrHCIgX+uakq15vixsk1
         VfxitMIXIdEsnhm3hKeNNTGmtNAoRvK0BjcxttdL8Zhgyr3GFqxFTnQAPA0GNeOGQ7AD
         jZ2HZj6C3yZGmTgpc1Lpatl1/JYKtNu/781ymVXPHJIRpLzNbL4MkHY/K/eT25HcYr/M
         pQ3/xTIQED8015YzHWpSdIB8xYunsRaK1KaQTG+OdrbCnGKaGE+odm74rGjhBNfo7JRb
         WIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743455192; x=1744059992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aKsaAcq6agx3Z+fVFt9fX0kjTgnx6HI3CKvH6wQ9aI=;
        b=xDs2EOBFtZhV3be/QEq5QTivuvrRnvSk3HofOzGYNwfMUvFnpGgWBp6fSEwS2TYEJq
         ThFR79MPyneMclVl14wuP+pHY85icBuUAAk9GOmkeL8J0UIPWdmDDfl5z6mQXwi+Er28
         wTRrySxZrRNdl4a061Bre9E7e7AuRbSxPGbyXP6Qtk+F4raQWEM74aPm7se+J0B+FZrd
         XbjW+nqps5tyHv78XqkUrvBzam+WwuB8GUqaPjF7T60U6yx5d3PPCITU9BYTpISGvbG5
         q5xzFdwo3/Fk/sNcaucED10uzVqIQFxt6DQx9WFl7zYTf1j8TjYmI7I/V8VlrBQygUsN
         Ba/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVITs3dyQlS0k2F6fvMWYXrkurHYL/ZtkQoqtJ8yCGSLGdWTqUx564e3eHKw/a9XT94mBE+HH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPVpMDY1a5lwiFAB1HErzyGTFOImQDkyY7RyjuF8ee1/t/zZO
	mB+LwXiZd30Al4+qJex8tcRV/TFZqqSSmhvPFIa1gWuWVD7ltpkb8YKq0Xc=
X-Gm-Gg: ASbGncsTN+yUxS8MVOh+RBs3cyVV/hCvfMzfNMW9+5wa5V/1u2J+xXvQIHl7uUfW4pj
	TcqsMRPB3Z38iZjibPbZCl3fDg8AkXPXp1nByHV9zXz4m5fw5mtT70l7DEpfQUksjAuIGzHHDYE
	moEI4eM4auYHNRIHngDrVOGnwvo5ichd+31y0m5iCIDfRrJCHeOuEPS8oMXJEgDaGcUk4eKVBZn
	ssiZ7SEXXQoOzTkWTtgaGyOF62tolSTeghp8bpQ0rnhhexc9/luJBWYbrPkTrr9995RHEr6bP78
	xVIgZnII2tu1uw/1MvM0SwAVOlhH3CNP8A4Rd+8zt5sa
X-Google-Smtp-Source: AGHT+IF3QLI6+qwIO+xtZmgPT3SegsERZzYQ+um7GOqojgXW7d0+1plwojmGyWqrfBGxzitQFNtPwg==
X-Received: by 2002:a17:90b:264e:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-30531fa4e78mr19174154a91.12.1743455192142;
        Mon, 31 Mar 2025 14:06:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305175c99a6sm7770412a91.40.2025.03.31.14.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:06:31 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:06:30 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v4 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <Z-sD1kYBPZlmpPcr@mini-arch>
References: <20250331150603.1906635-1-sdf@fomichev.me>
 <20250331150603.1906635-2-sdf@fomichev.me>
 <20250331134335.009691e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331134335.009691e4@kernel.org>

On 03/31, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 08:05:53 -0700 Stanislav Fomichev wrote:
> > +EXPORT_IPV6_MOD(netif_disable_lro);
> 
> > +++ b/net/ipv4/devinet.c
> 
> >  	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
> > -		dev_disable_lro(dev);
> > +		netif_disable_lro(dev);
> >  	/* Reference in_dev->dev */
> >  	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
> >  	/* Account for reference dev->ip_ptr (below) */
> 
> I still don't see a way for devinet.c to be built into a module.
> The export and moving the defines needs to go to patch 3.

Ah, I missed that, you're right, will do!

