Return-Path: <netdev+bounces-122595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE649961D02
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4C51C231AA
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF28C12EBE9;
	Wed, 28 Aug 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcPbeRfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BC41C6E
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815846; cv=none; b=cXhz7uI77e9WHz7yGAw8WKFOobV/vR3jZZHArHAg9enX4QtLAfZSczDGAP0qo2aXTV3ujiKpJt8CfW0kwNZ8QFPal+C2NUy8D7jUnNP8J9oOOGfhw9euhXNKPfAoDIRnDRSAhEAdoJYbf92zorlPkCB8tSQNCIO1tEqCVW4R7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815846; c=relaxed/simple;
	bh=tLX81o4Co8h//zvbR1OU7dkUBI2Vvyaqmg2y+NJBO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9V4SUb1MyRIgmt0dfZzbyv00uBI9bc76Azo5RDbL0Myw6KfT02ogphKDM7dD6hl1NnJfc+uJbAyHfAXlt9jwju21PQ8hjBZrEFQQ9eFx+pOtkraqKvXRpPaZh/U3YNiZJaCwLTXUqqeWHIWVkcOisPpKDxbC1lyHOVtntTEY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcPbeRfX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so140616a91.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724815845; x=1725420645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlQVdjVbA3QcWBnwedTXTXvSGn8GXkTConjPWcN49Rg=;
        b=DcPbeRfXk84Xx8LiA+SGlqfKhTjqAEQ/Tc8o2scLiT9NdPg+H5Nq4VEVAj11isjbhE
         sdyQqALsUAMaRjB02ouzKIyGIYcy1sUE0/a+Ftw3KMirSoOXqMEt/gKwPUCDfE3OeR9C
         YI0ueY6qlbJcf6g0KPvfz7vRcxWqle/rniCO8Y27ILoSa9/xpXYhmapezLugxuhL+lYg
         B2Zw1bPDNRmoIi0LAJ1EDveenQvj2V8m20npJTQ7C3vWTcFbMv99rXzdAx+9aRNHQavD
         tvciZfkzzghmPdyUHH3WpZHhD/c7BweSm3XxVvatfMxY4XMPe01XkoM3bxYWvN/i4HIn
         M3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815845; x=1725420645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlQVdjVbA3QcWBnwedTXTXvSGn8GXkTConjPWcN49Rg=;
        b=Km1R/bAQVQYQokA+v6VYhGodVoSMJJHPCJtNjCeQ7wHL3XbmtI523/MTcfOYi4PsBt
         dHhbWTipyjQqkpyyjIP6faat4aipZeEzAsoJWdEI7UDMSWS0uukaRiUtzFe6Q44M26cx
         Pj+t3fPohY1EL8TF2OzJumFGLds5WSXkSU4ZCtZJcWK7g7QrxPIrQSZ12OErWYrOzeqC
         Yhiw6j2QHA3V9uywFytNxUrT4AUMfU6dQK8w0aClxdZb+6lu8BU4tFbOh96DlCu1oW/8
         YWRYeLIu5BeVqOxVh0IoRAEkEbzLLzUC/YvRhRdcnZLPUWq7BAaa0GRznSRYWnhgj5s5
         OUQA==
X-Gm-Message-State: AOJu0Yy+ny0zD9EJN+yhojNw9T3289AykXdjHBFzM136gsiMFJ8HDjZl
	Hjwx8cghG+hD6WRiGOMOZ43rKmdYSS+XmVFmZL/lHNo2NIxfPqDb
X-Google-Smtp-Source: AGHT+IENl+VtUTiWrT3reZSer09Ov6JMbcZ/s+bxtMyqwKN2qIjtlseOXQQM63LzOlZP2M8dQLvvJw==
X-Received: by 2002:a17:90a:1783:b0:2cb:5829:a491 with SMTP id 98e67ed59e1d1-2d843dae854mr1220374a91.20.1724815844458;
        Tue, 27 Aug 2024 20:30:44 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d844680e0dsm359302a91.56.2024.08.27.20.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 20:30:44 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:30:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv4 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <Zs6Z3CGh0aTOrXT4@Laptop-X1>
References: <20240821105003.547460-1-liuhangbin@gmail.com>
 <20240821105003.547460-2-liuhangbin@gmail.com>
 <20240827130619.1a1cd34f@kernel.org>
 <Zs55_Yhu-UXkeihX@Laptop-X1>
 <20240827192801.42b91fff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827192801.42b91fff@kernel.org>

On Tue, Aug 27, 2024 at 07:28:01PM -0700, Jakub Kicinski wrote:
> 
> Yes, but still a bit too much info in the "short description"
> how about:
> 
> /**
>  * bond_ipsec_dev - Get active device for IPsec offload
>  * @xs: pointer to transformer state struct
>  *
>  * Context: caller must hold rcu_read_lock.
>  *
>  * Return the device for ipsec offload, or NULL if not exist.
>  **/

OK, thanks for the update :)

> 
> > BTW, The patch now has conflicts with latest net-next, I can do a rebase if
> > you want.
> 
> net or net-next? the patches from nvidia went into net.
> If it conflicts with net-next please rebase.

It conflicts with Nikolay's bond xfrm fixes, which already in net-next.
I will do a rebase.

Thanks
Hangbin

> If it conflicts with net -- could you wait with repost
> until after the net PR to Linus? And then rebase & post?



