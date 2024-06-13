Return-Path: <netdev+bounces-103187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44B906BBE
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2775DB24B39
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B0143C57;
	Thu, 13 Jun 2024 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0ClGfHU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6586143739;
	Thu, 13 Jun 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279002; cv=none; b=H9gSS/u9BYpCmhy9mXV1enJByJbgXNeGovTOKab1oaVkOLrmXuSDgjPCc8Qa5TWXCW0xPNJE6v9huhntBtSanikaWJn3XCk3C32kgA2fTuosIjOk/bkc4ehDrjuRrMcTWEc8DlGV0egosMrB07F2s1w0GUhQPVzPM4DamDK19fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279002; c=relaxed/simple;
	bh=mcDgRVbRrAqzkf7QdkeGKeRLT0SPhoINNm+D1NB5bgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEZ6iiKnQFqR3xss5n14M1sLYHlYOPKBS3mQQfpvl18D7Tts6WdpsHzcHxVcwJMyJ/91p93S4j3/kp1GgBwMgwQE6J6Mngq+lZ1R5oaWmENyeAHpbu/U0KYtOjEQfxl5Aw8drKoHX8duKcWhKAn/SKM3MVewqbsApKeeuUe1mA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0ClGfHU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso1120303a12.0;
        Thu, 13 Jun 2024 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278999; x=1718883799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ap6edeidspAUVCx1fQWUKPf2+SgKd686FNENvkCeyJk=;
        b=R0ClGfHUCTYy3sAZCH81Od27vSnY4VYytm227IRXbg6DX4fnvEr6cuRK5vkZnOeuC/
         Y5welOKycMCtok7UyS6f/xhYIDsz+sDVB558Hkxh4B4PR90C8X2eJTJ/21/lRByumLqm
         7Zi/0FdNuWpPZACCdEs1PhPDqSPh5uJ1IYFTkoxrZTej00/Se9vYbf0VkudJIXYOFsVz
         CTfLN8eG7aS116C+QV5XWIftQQKTu86xspHDCAh0r18NZUISa/FlwH17M7cXyeQcjhNh
         vaPd0oAss0uU1zCwmFvjfpnZZ8o7R3dbehP0Y/XJmIhfTjtpmPt6kjX3Hl/fGmWfyWNU
         9rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278999; x=1718883799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap6edeidspAUVCx1fQWUKPf2+SgKd686FNENvkCeyJk=;
        b=XEkqEcHVRklJr3WLIswXuzb1imdu+SK+Hul6ARIRqYhtpJsXzSq1kq7W6PcVbNkEj8
         Juldgh6ge9yGRGxLqU/cO+voO1l3S6btDiN975Q5yj8u2waZfphWYTWC8UY53qI1S5n3
         KUmp+wmGyu7xUOEP84HD76EgCzHb8YJ1A6s9836XXZGBxp2XVh1yK3IGDJ7Z+5hWhQt4
         F12fjt5R4cZPmZb1CwhXCpC71qsPbOVVR/Nb5jFc1gWw8vCjm3Uk0eUeP/0o4Fu5dVAk
         ZSbuKbHMjGZTdd2bkB/LJC4ToHGec8WMnzlHMFeO4Ka+zeUvlazvPEwFYSQ6bpBj1l4X
         h+2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4yRhNBjwcdQw158R/m0nyAWDH7OMd7PUXiPH97PQlJZxcWdNtR8UaD3BJMmaNSJHIrf/Sb28ZwbiM+APes6OGuImiEqlMcC2E6X0dmUs/mOHRe9k/2RpRERvQlpPP8lCir/oIJMy09IVUIITfHvU0Ri62l2UUKqJHqxY2PhZhsw==
X-Gm-Message-State: AOJu0YyCI9MJOLaa+uH733L19104wdCfE3KTdI9I6flOGInUyhrwA6Ds
	KdtmF68GjOQ8NlTuEl5ZU5ch9pGHe4MmFWAieau5/AVbRfHLnt0T
X-Google-Smtp-Source: AGHT+IHYys4W1g0+RpexvZWivwflF+jQm+3VaVBVwgK+dbQoo2xi3SiyvIOQ6QLl2vVuHmSTnCTOgA==
X-Received: by 2002:a17:906:a259:b0:a6e:feae:e1df with SMTP id a640c23a62f3a-a6f47f894a7mr299540966b.21.1718278998542;
        Thu, 13 Jun 2024 04:43:18 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42877sm62794966b.182.2024.06.13.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:43:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:43:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: John Thomson <git@johnthomson.fastmail.com.au>
Cc: daniel@makrotopia.org, andrew@lunn.ch, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] net: dsa: generate port ifname if exists or
 invalid
Message-ID: <20240613114314.jxmjkdbycqqiu5wn@skbuf>
References: <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>
 <20240608014724.2541990-1-git@johnthomson.fastmail.com.au>

On Sat, Jun 08, 2024 at 11:47:24AM +1000, John Thomson wrote:
> RFC:
> Not a full solution.
> 
> Not sure if supported, I cannot see any users in tree DTS,
> but I guess I would need to skip these checks (and should mark as
> NEM_NAME_ENUM) if port->name contains '%'.
> 
> name is also used in alloc_netdev_mqs, and I have not worked out if any
> of the functionality between alloc_netdev_mqs and the register_netdevice
> uses name, so I added these test early, but believe without a rntl lock,
> a colliding name could still be allocated to another device between this
> introduced test, and where this device does lock and register_netdevice
> near the end of this function.
> To deal with this looks to require moving the rntl_lock before
> these tests, which would lock around significantly more.
> 
> As an alternative, could we possibly always register an enumerated name,
> then (if name valid) dev_change_name (not exported), while still within
> the lock after register_netdevice?
> 
> Or could we introduce a parameter or switch-level DTS property that forces
> DSA to ignore port labels, so that all network devices names can be
> managed from userspace (using the existing port DSA label as intended name,
> as this still seems the best place to define device labels, even if the
> driver does not use this label)?

Why not just _not_ use the 'label' device tree property, and bring
a decent udev implementation into OpenWrt which can handle persistent
naming according to the labels on the box? Even within DSA, it is
considered better practice to use udev rather than 'label'. Not to
mention that once available, udev is a uniform solution for all network
interfaces, unlike 'label'.

Full disclosure: I myself tried for about 30 minutes to convert the udev
rules below into an /etc/hotplug.d script that procd would run, before
getting the impression it's never going to work as intended, because by
the time all relevant "add" actions run (built-in drivers), user space
hasn't even loaded, and thus hasn't got a chance to run any hooks.
I haven't actually opened the source code to compare how other uevent
handlers deal with this.

ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p0", NAME="swp0"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p1", NAME="swp1"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p2", NAME="swp2"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p3", NAME="swp3"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p4", NAME="swp4"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="0000:00:00.5", DRIVERS=="mscc_felix", ATTR{phys_port_name}=="p5", NAME="swp5"

