Return-Path: <netdev+bounces-104788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866D90E63B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373C52838FA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3177113;
	Wed, 19 Jun 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP6DlWBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0002139B1
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786872; cv=none; b=dSNBwiX/2rzFvNi5DMlGlpRBWaQ4TNozil4rXo6hVnYdfF/Dh8eb9wFvzHZ+FmDjBtfHOZ2IMtJ5TzhxmCw8cEZtJKPqtWIpdLYtQroq05oNZgc0Sh+ZCmGk8utV7fqWG4NearZyho2ULBu7WeeTRWLa8XH8oZvG8KL0nj8ygrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786872; c=relaxed/simple;
	bh=gpAPP7Ae7Q26Ab2KPQ052rsRCOHoLSXC+n432g9Cfro=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rMMu+Bd4Tlfs4jpr9VqfCJkhzJHZlopGEwbWGieSzlCUFQ1mQc+a/52H+nYip7lu0TrWGcrT90iXbQNpfms255iBOAY8EAL/LJdtO5BT6858G5mPRm5EYrIAucv+EvGY0hlBBtbN4D8IToXINBo1iUP55c9lOQHgl1URytf66PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP6DlWBA; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d2472450d6so3371844b6e.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718786870; x=1719391670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj871OUKshSy/JnM7JEAIxc+O2BKOPQ5glvy5CkbSnk=;
        b=cP6DlWBA8wBw9xJAg7piRXmPfaAuCJHKWqMub+BAHkZcp1G97pCcC5FRuRaxqx7Q6A
         HyLrKMefZoezx4FWgPY9+BR8M41BDU6H9wGRpFz9hRcY8Q/uvNlGmV7W8/tOBKT4qAao
         LVLwH0wFmKcIwShkKwjxkMlhjvFIUHWMogJJ1h64vd5jIH2md4xMMDxbCdYteZSSoUKG
         6AJksybE1L0i9O/8HPzWBMnv77SoOt3lSK16VuExUtphItU4khWlK8K8QER5ezPgmgPZ
         6Z0vh5UhF21qoSRu8CgYyLm0/uUp0IWOkmU1+smaKvnbTRPBCTX+ET9GTxGpcTriyJ2j
         6ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718786870; x=1719391670;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xj871OUKshSy/JnM7JEAIxc+O2BKOPQ5glvy5CkbSnk=;
        b=VKgeMEf0tjIcQ0dYceyWSRdozdGxi8BewwzKb1YwwmGXwhTm3FsuXYzzulvwVDxT0i
         ig7xIQCF/2cBgevNwS2yhcgBiWcyJ3oBao9FUuykyde1/ICbL17zKOhe3/IyRNjogaOq
         zw9HZB28NQjODgVn1Av4AIc/JcYPdxJSvf7jZKVwVjMmpbyNwG5QdDVhOOej0PXFohls
         eDG6FBpTO2mZjIrJtLOIKgoTKJnER1zedkKaT8pRQ15hYvZ1FzJ/+3etQtgI1ghzChVw
         2Tp3UBhYWDAEoRZlM+OXa0PWiMJzVOUxOKamTcv+X7AZdF29zwfZ8cdDaE21vcrPqp2/
         +/jA==
X-Forwarded-Encrypted: i=1; AJvYcCXzBNq13Ai6urAoGOnN2E7pg3iFHi8qAu49c1DaquVpOQdn/CxUsxXrSRlB4hoif9JcSxyWrhfv/AHli2dHuqZ1HbmLOKRj
X-Gm-Message-State: AOJu0YzFEeQ5j58hPeGxmyqdir3vyjXsz9wzp5LhXb+4uR+jEET8e8CR
	z6SwL2PYdNajth8LLtfe3PH6A5BaVuxekcf9Enhx3op4Y6p2Tpt7
X-Google-Smtp-Source: AGHT+IFF3iMx//x7Zv6JBwWAXY2bHeR4TCCyf6zNY4dfbTxUjLK7IsrVDX9U+6NL0gzsG46lb3J2nA==
X-Received: by 2002:a05:6808:1290:b0:3d2:1523:8d85 with SMTP id 5614622812f47-3d51bb0aaf6mr2579218b6e.59.1718786867554;
        Wed, 19 Jun 2024 01:47:47 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79a4da247fbsm322814085a.8.2024.06.19.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:47:47 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:47:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "Singhai, Anjali" <anjali.singhai@intel.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 "gal@nvidia.com" <gal@nvidia.com>, 
 "cratiu@nvidia.com" <cratiu@nvidia.com>, 
 "rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "tariqt@nvidia.com" <tariqt@nvidia.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 "Acharya, Arun Kumar" <arun.kumar.acharya@intel.com>
Message-ID: <66729b32d6391_276353294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > 3. About the PSP and UDP header addition, why is the driver doing it? I guess it's because the SW equivalent for PSP support in the kernel does not exist and just an offload for the device. Again in this case the assumption is either the driver does it or the device will do it.
> > Hope that is irrelevant for the stack. In our case most likely it will be the device doing it.
> > 
> > 4. Why is the driver adding the PSP trailer? Hoping this is between the driver and the device, in our case it's the device that will add the trailer.
> 
> This does not adhere to the spec:
> 
> "An option must be provided that enables upper-level software to send packets that are
> pre-formatted to include the headers required for PSP encapsulation. In this case, the
> NIC will modify the contents of the headers appropriately, apply
> encryption/authentication, and add the PSP trailer to the packet."
> 
> https://raw.githubusercontent.com/google/psp/main/doc/PSP_Arch_Spec.pdf

I responded to the wrong statement. This is in response to point 3.

In general, PSP can work in tunnel and transport mode. In transport
mode, it is here assumed to be not transparent, but under control of
the operating system. That inserts the outer encapsulation headers and
prepares all fields as it sees fit. E.g., using the inner 4-tuple as
entropy for the outer UDP source port, and selecting the right SPI.

