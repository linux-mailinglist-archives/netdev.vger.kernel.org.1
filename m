Return-Path: <netdev+bounces-154163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975239FBD0F
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2627F160E1D
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF11B0F09;
	Tue, 24 Dec 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI57d53n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9B1ADFE3
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041656; cv=none; b=MraH7Ebtnux/RjS/i83bwg1NYGN7xeOT8eAUzDJzwBsoSvPKlPMHdoy15z3zccajJLRvax5gnHWkw3a+0Lh8BdXzUwG9Sf3kg7etUNN09A0FZC6l5KxrXuFiU09tQZPrBij9bJHi/eTV7TkGL3T0Gz0WPV0c3YGAphpg1mZEuzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041656; c=relaxed/simple;
	bh=rzUgSci6MLcH5WnpxsrIHb7mTai7P5inXEEpAyg9Mto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2oPLeHoQTN21wX32JW3pwiR/ez4cQgyeohgQzsc1dZ2Eei2tZEONEJf/uWNpZxfS38erF0h/jx4qgV4XnU1NGeKa/SnnIcetADmfmP8/eSOgLjIz7PEc9xQwS3CfKF8gB+/79s9UqA96xl190+7SWo/+iXSxDD/7e5zQwlUxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI57d53n; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa659775dd5so81719966b.0
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 04:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735041653; x=1735646453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kWkPBpZwLiRvjvyWPRonhFcrRz2XRbB4oTeo24ipE1g=;
        b=DI57d53nsDtSj5bCsqNKNTV3lgZAFxNYKxTPDnUvMiAAkTh0rsjL+tPSyeaaMfvX9M
         YQALfegP9fjDjQWvQKkDfZ/3Np41Hl1YSWtU7OKkyOGRHmdEg0rIRV9l+6kO7AhegrDH
         1swqnRjFOH6W4jajFqxWvVzWH5syLZC8bbIo5EHpf2wJTKBp9mGsn6bgtMVsHLrcmhQh
         TOmlj02mfckJg/rHhB+LBNqFOPQPXOUgstXx1qZsckzn9fR+0yf7WrRJqGmvtEhFHLX5
         YWzt+vR5Q6BiIwCBCs5pW49obHJWEEBhatkUx+aPYjuU7fHG3jiLE1pabaQoTnSXsHdh
         FcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041653; x=1735646453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWkPBpZwLiRvjvyWPRonhFcrRz2XRbB4oTeo24ipE1g=;
        b=V2B3IGWgipj6F68rRdVJDrLlGPO1rgi0eJeKqeGn3TSmvEw5V3c/AEfTghaGADpPC+
         g7q/xoyEx3YewYykhnLcPrAtkobxEDdZTQj5S25Cj18z/34IC8l/pD90Gi63R+pnXkME
         ePGJnUq/QEcmmYmJr45xkW/X9w/+SaCUcuVDC9IzWZRcwOb+PBbBCjbPakNHLCjXz/TT
         Cc7FEgYzi6f+pdJZtDk1VUfj0bECHpYL9k5oBkDiOSZCOoIeuHVc42gHH4hR4isZ7+NW
         CiJY41xeozVjIUXr7BmamIqTKCnj0qUbF1PlRvampE2Y+WMi29dYEmrODvadWvnXJI3o
         sycQ==
X-Gm-Message-State: AOJu0Yx+M5xF7uhnhmCrLM0WQMIyXQMdtpwaHdKPzKYtUXKspBN3Sv9d
	1a0AmkmUlPEmkntUzPdTntgxLdNlIHfbw57Ay+0pCjYu/VAtvff2aHSKonHU
X-Gm-Gg: ASbGnctzqozjwCsqFY4N73UE4jFM2H+KWxltnRDqMyzn2fQXzaHqFpKr/DR9fBhjMhT
	wH9JkE9vqrD39MHGafTyucSOuecsubvD0f4Wipy7Brc7MGiOxXINNAgNgHa4+3o/oFk3Nv4bmY4
	gdmIOG7lzg0hDZETOWgEcmXryDb/uu3/Nx1sniJPJ+xcz4OE7LT6rPDN8uM6LW/loxvzlW7HdJo
	ektEp2HkJWQTgqXIUqiklvHUykUVGTB+skqx6MZfIhZ
X-Google-Smtp-Source: AGHT+IEKFl02auZ6AqcCXdOrSennMz1BfHElgRIT32XNyzzzvItgLNgzErpXIvXbeephiAkk/LWXYg==
X-Received: by 2002:a17:907:7d93:b0:aa6:79e6:5b03 with SMTP id a640c23a62f3a-aac2adc60admr596242866b.6.1735041652801;
        Tue, 24 Dec 2024 04:00:52 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f621sm645699566b.40.2024.12.24.04.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 04:00:51 -0800 (PST)
Date: Tue, 24 Dec 2024 14:00:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: sai kumar <skmr537@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
Message-ID: <20241224120049.bjcxfqrwaaxazosw@skbuf>
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>

On Tue, Dec 24, 2024 at 03:00:17PM +0530, sai kumar wrote:
> Hi Team,
> 
> This could be basic question related to DSA, if possible please help
> to share your feedback,. Thanks.
> 
> 
> External CPU eth1 ---RGMII---- Switch Port 0 (cpu port)
> Switch Port 1 (lan1) --- DHCP client
> 
> I am using marvell 88E6390 evaluation board, modified the device tree
> to support MDIO control over USB.
> The switch control plane works, we are unable to dump registers and

unable -> able, right?

> see port status.
> 
> The kernel version on board with external cpu is 6.1
> 
> I have connected a dhcp client to port 1 of the switch and the
> discover packet is not reaching the cpu port (port 0) and external cpu
> interface eth1.
> Using the bridge without vlan to configure, able to see the client
> device mac addr in bridge fdb show
> with vlan id as 4095.
> 
> tcpdump on external cpu port eth1 and bridge br0 to listen for
> incoming packets from the client . No discover packets are being
> received on those interfaces.
> 
> Could you please let us know if any configuration is being missed for
> switch data plane to work ? Thanks.
> 
> 
> The below are the commands used to configure the bridge:

I don't immediately see something obviously wrong. Could you run
ethtool -S on lan1 and on eth0, and try to find a positive correlation
between the DHCP requests and a certain packet counter incrementing in
the switch? We should determine whether there is packet loss in the
switch or whether there is some other reason for the lack of connectivity.

