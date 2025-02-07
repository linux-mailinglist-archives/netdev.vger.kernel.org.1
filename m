Return-Path: <netdev+bounces-164062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7CA2C7F6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7597A3D84
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8DE23C8B3;
	Fri,  7 Feb 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HT8TUE/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532423C8A8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943700; cv=none; b=OSVONqvRSsnec3NSk93CwzJAHv5Qeiev0WYtwb2JP5C2RG3uIeLazWfdRXqbkSYKKj0jIc9bYKPPKx9c1nIqj47U1nwbAKK1N28u3n+/Evq8uCZHxNqvaW9PLMzTIGDSpHR6iTJYt7hu0zQlXCMOlgJFF6xguyQOYUel80XA1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943700; c=relaxed/simple;
	bh=I2GuDhxl+08paIRrviBkUYIALNebE4rhANc6ESbwfJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV6Zbl6Bm1TABXeh40tA1RBdRPIUoxkh7AGGZSUFN8JnQmaclMmSCXU5L/QBRvdCBEQ892cC/9pFEERRRtUjo+bFjWF2brpfUHSjk6V3Vm3H9m0LTyckJiDN/tgEZ2/d1AHEnGwg40fU2BGGnYcSB9aSnuaFf6IzugLrKDbGwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HT8TUE/8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e440e64249so18789586d6.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738943698; x=1739548498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wG4kDX3mPsVlAfvrUd487lzsY97VgTkw0/bdTrkhSGs=;
        b=HT8TUE/8/UXvNaK5LmB/835+M8y9p+nozLAhhaRKfPQUnhy28oZ0BpcxKxygPiVK2e
         0UgWSXIhF+xAR3eojV0+7V2VAeCMmmnNy6DICKseoiCyEvtDk8GiZWfDKWts25dDqKKF
         8U3nA/JxGFuPvLioH7pcJO4B2CCVrAAQKFXFs5V2GdsgI7z4NtC396a4v5kWFW8mAv1q
         QZxYjB34hpMKOJiwuhkP5OIZ7sLrmJSe8VsS7LHiogQW0bLMZX0Cn2xwbHKSx/YSbVrZ
         OBXC5YgCBUYUpehBIhozOTD2gFyKVMa4zVgw0tccR9fS67jLAFJY7PmkGa2rQyhrEHHC
         RRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738943698; x=1739548498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG4kDX3mPsVlAfvrUd487lzsY97VgTkw0/bdTrkhSGs=;
        b=R8RjWOFZQU/f1IKjECv7wmDQlv6UmQwbI3/eco2kpXhlC1lEXSk0Xp+YfJd6xAe4Sh
         o+ee4p45C/aGlFPFrL+A0dws4IWe2qgoAcJzjtiNgTi+DWwvh85yImHOQYvTegEjcDIa
         LN/e/5F/8jGkKXzUiOMQvP/N1/9lpXv1bAQNFDpjznZirz0tDwiwlWTsDTNo0XWRbA2D
         s9FD9Hy9GDK1nxjLSzMd7cvMFFum1FCwVno3DjWpfdBIX0XagBeJjIAMCrVQ0fHeaI0M
         +DIwr7++S9PMJgnJ7lPpBBOCVJ7zIgXJW+H/daEcLpww/YSSVUZHJNUWxXbHuGPRV4B+
         J/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUDr2AbIHoq5QS7vDn47T+DHsj2X9IQjikzwIpQ9Hq82jnVl5PIPmbBJuJC3RiyLphJXf6Ju64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwvgPSAmoiRFRvMfVM2Bv9Hl5gYNSZ6JNa1yhSn/LoBpYh50v
	Z13BL66kYHjbsR0DZ7XvGaGrFtmQpi8pCG1qo14lXN+zkwQD0zGFOwoWO9sz4Ds=
X-Gm-Gg: ASbGncslkDL4y0w1Tl0/sSlJKuPJDOu3RUPzGPfSq8cTLwolDywe3A9TbXDQtB2eWyB
	9sy6Mc4r50tZ++P2m4gkkrV+8tpzjktCG+3QYCo28Nz07cG6nYTt44oCTMp17dlHJ7n4tiuCmxb
	vv0KUjZC76bvOTFjG7J+y1B8NCEs1RNTHDW04DXNeaLyu5IthHJn6Vz7iP92gDTLnKQ7r+fOPvr
	AoUt3qLxViDRKFPZujuMMwUg6HQHSb9yxz/LniHcqfHB2JziKjCRiI26OVI4JB7IobACxhAqHSa
	bENh2BeKRqLYreCy8U2FCNI5VIwIaCAMfTDPrtGWRKWQhRVSFP4eGyq7rZAvujVX
X-Google-Smtp-Source: AGHT+IEq6vakQzNYiXzUmxGw05TQjdF65NCz8Qjlk4Szby4FeLGiS8FNdUCgGzZaq1/yR/BAprqyEQ==
X-Received: by 2002:ad4:5f89:0:b0:6d8:8a7b:66a4 with SMTP id 6a1803df08f44-6e4455e8913mr53333496d6.14.1738943697961;
        Fri, 07 Feb 2025 07:54:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43ba2be69sm18281116d6.15.2025.02.07.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:54:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tgQgy-0000000FNdT-38ej;
	Fri, 07 Feb 2025 11:54:56 -0400
Date: Fri, 7 Feb 2025 11:54:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Talat Batheesh <talatb@nvidia.com>,
	Feras Daoud <ferasda@nvidia.com>
Subject: Re: modprobe mlx5_core on OCI bare-metal instance causes
 unrecoverable hang and I/O error
Message-ID: <20250207155456.GA3665725@ziepe.ca>
References: <CAHTA-uaH9w2LqQdxY4b=7q9WQsuA6ntg=QRKrsf=mPfNBmM5pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHTA-uaH9w2LqQdxY4b=7q9WQsuA6ntg=QRKrsf=mPfNBmM5pw@mail.gmail.com>

On Wed, Feb 05, 2025 at 05:09:13PM -0600, Mitchell Augustin wrote:
> Hello,
> 
> I have identified a bug in the mlx5_core module, or some related component.
> 
> Doing the following on a freshly provisioned Oracle Cloud bare metal
> node with this configuration [0] will reliably cause the entire
> instance to become unresponsive:
> 
> rmmod mlx5_ib; rmmod mlx5_core; modprobe mlx5_core
> 
> This also produces the following output:
> 
> [  331.267175] I/O error, dev sda, sector 35602992 op 0x0:(READ) flags
> 0x80700 phys_seg 33 prio class 0

Is it using iscsi/srp/nfs/etc for any filesystems?

Jason

