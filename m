Return-Path: <netdev+bounces-129133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB1597DB9C
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 06:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795171F21B6B
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 04:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542FF9DF;
	Sat, 21 Sep 2024 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQRORDp1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1528F4;
	Sat, 21 Sep 2024 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726892093; cv=none; b=dTi0/CmolJ0AUbcQGw7iEcYuLN+j1z7YkQwFt4jxHUujpyRfNgQURDWoHZ37QszHy9OkfVRv2vf7j80IpZa6e/TnYK55D37URPbkgN0r+1bmoYQ+/HgBtPtmwCusiKca950OE+c1CggwmRFSAgaDm+7qgcc+BUCsFyQJh21+Ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726892093; c=relaxed/simple;
	bh=5mz3J8HgPZdEt8atOj9qdhB4LJ9kcYeI4/c9xCFQRWk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rN0IaxEPWKx7u8di1+TiEHzgzPywwagInz+fHHTvD8BJRaW9V1eQHrjECnztsPI/DiFKZ5RMLHrPUEjlb+CHNx2fjQoXMhH79BZhoWnzi4LAU0xNoplQd9WkQPCoW5oXvCCJUBCZdUOu6Bw0w5soLxj+9nd+VX6vL251kk4a1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQRORDp1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e6299191so1479184b3a.2;
        Fri, 20 Sep 2024 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726892091; x=1727496891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxxOvx1Izrm7TAV/LRYGtGBqjv3Qq70hbPsIrfhRUBg=;
        b=ZQRORDp1F1Z4CMEptv+KpRcNa/sGn2acElQMmmxtwcTqHo28o7Czk/r/4FtuIjrjFq
         kGuoh4lEgSbi2MosfQUULhT3HuNVDqAdnGfC3hrRQahk3psGNuWVFokXr8Vq1y6muSpZ
         iur6DmFOF4fMlUmmuSw+JnWZckQj7l2BRiyzFKrjnu6xrjTz/2YylokgnyH6up/oFBFe
         WZPoWY8/8QWRJXpJXkptBrT2g3jy32jlO9qP386Z8E7+gFLyjQazWhgxjiQgKKTazKi9
         towkMKnPYJkHs8/01t1jnB620H+6VPKnujXmbwmBFD0jUANad1IA+TMLk/t+sVchQEc5
         6KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726892091; x=1727496891;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PxxOvx1Izrm7TAV/LRYGtGBqjv3Qq70hbPsIrfhRUBg=;
        b=f1v04NDLkbMWTe0wgk5DtYjYAynx5x6Plr5SGVLt140c/0tcfQJeS4ESP2gFPYMDVg
         xZUWiQfZrqdtr2TMPk3Qiao/sNGfPKmh7nzIgFNF6Dvi5eOfzAxuk411UH9xPM9SWz5b
         MKixUAHMa/A9rw3QbvyTf3eyn1IPp/SHjgDVbc6AInDQAh8fKv7YVbXEuhpzeRuOq55/
         4b6weCnkLfBc+PvPsnbEwEZP/6McdI5JO257tSn4dmA6FnVpVJuJrywQk55RDiJufdYV
         Yz8BlDZL1bn04P+q6xg6pW6WxcTwWn+mHcKZ26bTphkUT1iZlTq2qLopTFgr0/jSip9u
         Yehw==
X-Forwarded-Encrypted: i=1; AJvYcCUMNHICpcw7rQTIbsiA02kQbLwEEsPnojr5rEApZ7/oUH4Ch3zkKD6HcSQ8sKZ1ZciKGW3lupLi3WtHOQL+PAc=@vger.kernel.org, AJvYcCXMD2DNH8D7C1QGJk4r4GdFpF3F57MJjPbmDBXJzwH2tQLAcM8uHyHGRc/58wmpmCfikLWKE64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUo0+sxIq2HNIuqhTlGdQQINUIk6YLKLsTMBJres25FRmgdYeq
	Fr0v/1m3pbTK8MO8llzBYSOW5YZ2VuCDBKRvqeqwEpYW6gqf2lll
X-Google-Smtp-Source: AGHT+IFCeCAdMQwitdC0D1/dsbY+KJQWOvIXdlUdOHHMYwTuKyU/nVPqR34caAn5DgEC9/GDWic1bg==
X-Received: by 2002:a05:6a20:9f93:b0:1cf:49a6:9933 with SMTP id adf61e73a8af0-1d30c9e89e6mr6081195637.20.1726892091467;
        Fri, 20 Sep 2024 21:14:51 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e5650424a8sm1324221a12.84.2024.09.20.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 21:14:51 -0700 (PDT)
Date: Sat, 21 Sep 2024 04:14:37 +0000 (UTC)
Message-Id: <20240921.041437.1044172886569379842.fujita.tomonori@gmail.com>
To: aliceryhl@google.com, tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, lkp@intel.com
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import
 DeviceId
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggzkjHE+NY_gLzcmwSeQ5MFYXMYU-nqX7=R7RF4WLosug@mail.gmail.com>
References: <CAH5fLgiJyvSztvCDz8KZ4kF0--a0mqi7M4WowB==CCs2FmVk8A@mail.gmail.com>
	<20240920.135339.42277957091918023.fujita.tomonori@gmail.com>
	<CAH5fLggzkjHE+NY_gLzcmwSeQ5MFYXMYU-nqX7=R7RF4WLosug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 18:00:56 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> Put it in a const. That way it doesn't end up in the image if unused.
> 
> const _TABLE_INIT: [::kernel::bindings::mdio_device_id; 2] = [
>     ::kernel::bindings::mdio_device_id {
>         phy_id: 0x00000001,
>         phy_id_mask: 0xffffffff,
>     },
>     ::kernel::bindings::mdio_device_id {
>         phy_id: 0,
>         phy_id_mask: 0,
>     },
> ];
> 
> #[cfg(MODULE)]
> #[no_mangle]
> static __mod_mdio__phydev_device_table:
> [::kernel::bindings::mdio_device_id; 2] = _TABLE_INIT;

Yeah, `const` works!

Thanks a lot guys! I'll send this change for the next merge window.

