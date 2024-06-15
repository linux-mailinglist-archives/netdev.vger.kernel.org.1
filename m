Return-Path: <netdev+bounces-103768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24F90965D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 08:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E262CB2226C
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0613FEE;
	Sat, 15 Jun 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzL6tVAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A05156CF
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718433688; cv=none; b=d9w5PgdylRD6bHC+KzL0tgJiihnyenVT28Y9GIrMoqcJJF/39eh+35kWGxaTVmI/hweIHB/gtkJuNKBXR0DqekuccoJK7IYg0dtBUDP9cn+XAN37BcajgK9hfYpuHVU8WYoI+NICdvgET/A75gYpDqbxaA/hwKzBvc8rkbuV+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718433688; c=relaxed/simple;
	bh=R3qo9vT/3Ny/L2SMBNiEQkPVIaLA11lP8GBmG952+F0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZglvNaNlxwO55hr9rgl1ZkH11eMKt3A6FrK0p+EFt6MJjuLfP9GJV3OO+yT7FnJf2dBtpWzcUJEXTxrHXMyJDiFolvrnwpAznihwD7vdYqmh4qKKG69XRATZFgrgzBAwiij5sb9XR64ZoiLrdTyXULGr2boQ4w0z16cY0WZ3gMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzL6tVAK; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d2275b045cso69564b6e.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718433686; x=1719038486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VASFZnizAeezOFSH2Eo8hHg2edA+OgRyZ9HyybhSL4=;
        b=WzL6tVAK2/7yBHSoBXQ7oxYwAJcjd5SS9AFhcD3C38CQ5GqfAvfUyi0l2Io2i/deMw
         ZKRigtcnYDi5GQ4i588qCyFlf4YFctuea32Us4nyYArEy50itIW2qiykyVohEp2E9RPe
         GK+mPQM6wyMt2I3L6zt+WFkCJhk4PqdPikMSG9mj7cTzFypI1tsjSehgOA4P2vYbo5Ec
         PMlSq4cSjdUBJvYP/XidgIRmr9/q4S6tyr28heVNLiUH7dXh5n04gfZfELyhHZMRr4oA
         o/HuMRKEfx58MeUADRRSTlxg5DLCUe/2OY7HJBbLXlQdDmebzq4viQatu48f7UGfyiAV
         6JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718433686; x=1719038486;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VASFZnizAeezOFSH2Eo8hHg2edA+OgRyZ9HyybhSL4=;
        b=LWMojwzNO7m/j8wKunkmtakQEpNkLST8Tj0Vd4M6OxrTflTEnZyg3IOApudqvtxvdT
         HO5ucVtbzpmNnbPbyUtcwzjKlGKmyZwEmUK63f1CEqhkRZ+NcQ5H3UIrOoHUpUEiaj0t
         VlxllG7sMk+3W2vNG0skNhRGjSgbG+SBPan+HHylant3VYVj0g87L3GszSsVOEUIHQmM
         LSPJtztU+F8ZnwHJrOmtX+okgOtjhJxm7Be8TP56Sv2Fz/V3Cawo7+KPbg8UCERBTckz
         IH/mForPvt1q71o1feJPYFGp1i1WMJNRl7FMQ7ynWBHC/jMoQ9Qr9cLixmvzd/I3YGHW
         c9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD9tWWPg2sZhzZYVbGMeRvr3+ySPE/rR3R5jg6t72qjHIfZ41LmE+568rDuR3qESgr02ybDGS7TcUU7nIoE6AxFWE8xDHW
X-Gm-Message-State: AOJu0YyUaNHmLMKHmA2KwyJ07UNot1wndd/cN9l+yZPi+T5NVucDaCGh
	ZGj8KKxuj8f5HZfTcxvfJ5Az609PPezYKzrfU+hdAy6Ck9f9J/YK
X-Google-Smtp-Source: AGHT+IEKe5Rb7tozm3aDswm3CqCxuN5cx+d0xk/2nBPX35d8qtqHTIsnwSFW/1zMoTq1iqMemLkiHA==
X-Received: by 2002:a05:6808:2116:b0:3d2:30ce:3263 with SMTP id 5614622812f47-3d24e8bbc22mr5048367b6e.1.1718433686223;
        Fri, 14 Jun 2024 23:41:26 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dc5csm4200480b3a.10.2024.06.14.23.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 23:41:25 -0700 (PDT)
Date: Sat, 15 Jun 2024 15:41:20 +0900 (JST)
Message-Id: <20240615.154120.1592275076225685842.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240614082351.7fc8d66c@kernel.org>
References: <20240613174808.67eb994c@kernel.org>
	<20240614.114152.1787364292761357690.fujita.tomonori@gmail.com>
	<20240614082351.7fc8d66c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 08:23:51 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

>> Currently, net_device_stats struct is in tn40_priv struct. You meant
>> the driver shouldn't use net_device_stats struct?
> 
> Oh, I misread, I just saw netdev_stats_to_stats64( and didn't read
> further. Doesn't look like you're using any of the magic properties
> of struct net_device_stats, so yes, just replace it with struct
> rtnl_link_stats64 in the priv, and with minor adjustments that should be it.

I see. I'll replace the net_device_stats struct in the priv with
rtnl_link_stats64 struct. The minor adjustments include
u64_stats_sync, I suppose.

