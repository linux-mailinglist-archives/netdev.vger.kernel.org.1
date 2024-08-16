Return-Path: <netdev+bounces-119111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FC95412F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84B71F21BE5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217153307B;
	Fri, 16 Aug 2024 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSFeQWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FB10E6;
	Fri, 16 Aug 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786216; cv=none; b=RRYXIumFhiZcCpyt+E5vhdGY0XkJvHSmmmRm4qrc6hKbJ2Dz81hmbo4kHRDi4GybuGaAGfsfjbszoxVKF9TxUXj7V1slRzVj8+nY9QENJcLdMyAYFKhUxkA2Qu3hFx/vR6dQQWHTcst4y+yc9aQSC+d2VVFBmcMpphzkcjsv6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786216; c=relaxed/simple;
	bh=SyLAUoU9C9P6cw+pghk6HIVDf5PMktIaOLThFtEQwHU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GUcpqPabq6M+OLuwyDILJa/hoOnlJWWTkcwehsaV2Dfm1w0yEbYaDgx+8HYwVoMYDGju9KF3BCJOfMsp91p0woOPfZm8o6UcInvSAFlFfw4XMbZT/n8Hgz9kQC1Xoq2QdKY4BisF6vlS1Ht44ZEzLYiVust0TEONMwSnj4Vk6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKSFeQWB; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5bb451631so163090eaf.2;
        Thu, 15 Aug 2024 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723786213; x=1724391013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5MTPqOOZ40oHbSoMYyF57Fd3nuGSX9c9MurnKDvWnM=;
        b=IKSFeQWBgpPl60ncyco/6dooAw7LDnKUDqNP9lGEXBGub+UoiIKQtpCsZNJR5CuKMZ
         yV5LDBEzWfr+1+jFUb/m0XeAtEbyHmOce9sA7nQ95pGdBm9dYM+UY5u3H8soWI5V7bEV
         rTkwVrfTcaFAdBCfUk/+EmNjj50DHc4V2r5N29Y0CwDQuYshJrz9B/gYdTTTFhgB/53g
         1ZcKT+ZSZcRmCgNXtdOUlUAzFSBFiB5oYlNW2DdgyPvodUIG6XRsQQjN00z0Ydfe0k4Z
         6J5R/RkGbb3DmE9UCPM/IQ7/q0FxSZ/1tW008Jb2qdxB45P6L8l3WoGQEPmKwjxao17/
         Excw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786213; x=1724391013;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5MTPqOOZ40oHbSoMYyF57Fd3nuGSX9c9MurnKDvWnM=;
        b=aNGwn6BGj8qifMoQAmjsAA15aDQnX9cdRs6Na+p9R1frI7WV0rCriR2jAPLzeZ52W0
         xlUDclV6AXhkp8wa6pEq8KXxfrATVLNs0z/Jy/j0KXfZFZDIOhJDDIsFzRj8h45+/HIS
         cR+k9D0zSYkr8UTgKw7q6vDP9MUIwsk1N0/fSlAmEdnrxzyPU7cGVAHa4ysyyDo0K9ap
         MjC0L9VuNorjkFba+rrGJ5sThfQWyThaiDZFWlTVdZSGWEoHhoybVmw5xgArTHl4LEln
         M98hpo3gL4oWt9AeuOxDcewNo+xvLwnfjEZDmS62deaAHD4ZGnqeCmpFDymoYTseJLrT
         SZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmRoliqUVdvHx8GsWzJM4mamMf08nlY0R7ioujdViiz91/MtwxB4mcyv7N6u3gTFV6O/mFK8h0JYutno1LxOuzRhan50N0ppm0M43qWhPGueeCW4o8G7jpLC/PaMeeLTt8WTrJR1I=
X-Gm-Message-State: AOJu0YwgWVsfqKL5DOfj88fTnL+kAsMrk0aCyvZy1Z7DobJWlIFoa9ub
	0OtwDVEMxLB+F5bQxOneKOReadNoEgNdwRYPykJFG7sJ/GZ2ozXJ
X-Google-Smtp-Source: AGHT+IE/sAo5vt4uME2C2L3MvOtP2Djydg7oc7vPiSEYp/z6hRJ+ZX8zZezJdxS79NUVdAwhNxLn/w==
X-Received: by 2002:a05:6870:968e:b0:260:23eb:5669 with SMTP id 586e51a60fabf-2701c35477bmr1141864fac.2.1723786213482;
        Thu, 15 Aug 2024 22:30:13 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af416d4sm1877931b3a.190.2024.08.15.22.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:30:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 05:30:09 +0000 (UTC)
Message-Id: <20240816.053009.1420518753499945384.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 5/6] rust: net::phy unified
 genphy_read_status function for C22 and C45 registers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <b61b5eb4-ee73-405c-aeae-0c26c66445fc@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<20240804233835.223460-6-fujita.tomonori@gmail.com>
	<b61b5eb4-ee73-405c-aeae-0c26c66445fc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 03:19:51 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +///
>> +///     // Checks the link status and updates current link state via C22.
>> +///     dev.genphy_read_status::<phy::C22>();
>> +///     // Checks the link status and updates current link state via C45.
>> +///     dev.genphy_read_status::<phy::C45>();
> 
> Again, the word `via` is wrong here. You are looking at the link state
> as reported by registers in the C22 namespace, or the C45 namespace.

Yeah, how about the followings?

///     // Checks the link status as reported by registers in the C22 namespace
///     // and updates current link state.
///     dev.genphy_read_status::<phy::C22>();
///     // Checks the link status as reported by registers in the C45 namespace
///     // and updates current link state.
///     dev.genphy_read_status::<phy::C45>();

