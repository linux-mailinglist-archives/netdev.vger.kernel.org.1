Return-Path: <netdev+bounces-114763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23239440DB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB19B282B6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B0130A54;
	Thu,  1 Aug 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGdx3keZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17684208A0;
	Thu,  1 Aug 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474238; cv=none; b=OLTcKjiVpOognXD4577v8wk7FxojCcSUbAzuqLTwcLzRRyC2sd5lzidn5wi4lnmSOzS85flqGVEqJ06f4/wZFQbYpfhD9izQZpnmmwBjLkwTi45wJuHO29h/W5vH/Wzz/aw4U6B/C4qLyYuilPTrYLxD1BFNlDu2tt7Oyosycp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474238; c=relaxed/simple;
	bh=+0D9izMov2fVjggCqOiId4Eyo/YCtxQRrNJ1CrxscBg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q+Y47d730qjBizKRuOP/FF2EywC1N72+211naqfiYSP1l5KVlkMl/r2zlpbpTDUp+FgHz+Os8v9Sn0a6D3oQnlQynwZNK9HgZw5SrRvc3T2uVUQ1DjN/Ja9bSMMvjWhV2krekXWNt+1/Q26s/TEaaKF807Eqi/j4hC7iiubrCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGdx3keZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb67992a5cso1147920a91.1;
        Wed, 31 Jul 2024 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722474236; x=1723079036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GjmuONFUv2485xz0hzBb/3WjCu0sZQyc5Cvo3OSjjM=;
        b=UGdx3keZHfxRRTXkI2ejwRj942P5TgMLqxqxnS54ytvvGYis5CxMKahG/+4f/ehYnL
         AzqyFH0v8zRceECuety9yDBRwBTMu/4gebkQ/PqKcFW/w2eDKyJS71jnpauQUUMja68A
         jy+zW8aibSMG9EnFqeX6SlGA4vttMZ9Vkf5eJqtGbltj4EwJGtHwi7T+3PDIBW/VfCkq
         pBsRS+ZQSz0Q+G66s/ikz3Ksjxv8kzfhkR9UmjXKf8iz2sDtSpNQHMNgj4I91TDBJ0fQ
         Svn8DGSbIoIseSTM2zxhldW4TAb5bNOdUvdAr5T3nzAMLCyi1vkXxlPIQgppIm1vCuQa
         NT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722474236; x=1723079036;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2GjmuONFUv2485xz0hzBb/3WjCu0sZQyc5Cvo3OSjjM=;
        b=vTer++LYz5KXtp9ByzlSwnBO8QKFeaUddYb6YCgHcNGakxOTCYtVNcD7MDXhvZ6Uil
         LbzKtdMUWU2gIfnPOfZ6qN5txpFyXNaY8IZKVi0LNgQmPhcL0JIZcfli2jpYhqWVCFY8
         XAIpLEmOVgC2Q9DwBRjVH9dCNt7P/s9UHnorg0smHTN5KdrLaxKpIzu3sS7Pj0LaxDqx
         k/lT4XS19MizxZ0ixQqh+dIXZHOWtcSNJWHvOGZObP8kFVy/c6JIRdh5juInW/n/pdki
         xic1kmBXBgaZ+Wv1v2N1dTQcTMjoh0IQhFGx79ZOHYQeghi+zTZEjiA0lVwfd9LAoqyg
         rOBA==
X-Forwarded-Encrypted: i=1; AJvYcCXBFeVOjsxSlvpe+bZQxErUWxlbEaCn+od9Jfz1YjPmCBo3KJKtrkNRrYD0vv5eM0xZdWlW+tgHOs2W036O9yOqjdQLP553rO8rkrvxvcRsVGc5EGcRfO1X8oWUzQfTEcFhplgf7Gw=
X-Gm-Message-State: AOJu0YxjRn31CNOt31ldm9K8QWqyJhmwRy/XCAzIoQAqcuvsGfMyZvaO
	irOF6m0W03RM2JlT2C0NSTik+bZYNX0iuwx7y8o2mfKxIhdJkZ2F
X-Google-Smtp-Source: AGHT+IHntwW5d4kvmhU2rn2k+Rm7Mj6aWY9bHjMZUpKAe7D/fwL9ukBVKd2or10Pkzlv1U6BK8wZ8Q==
X-Received: by 2002:a17:902:d488:b0:1fd:6d4c:24cf with SMTP id d9443c01a7336-1ff4d24464emr7649285ad.5.1722474236297;
        Wed, 31 Jul 2024 18:03:56 -0700 (PDT)
Received: from localhost (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1343sm127111835ad.173.2024.07.31.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:03:56 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:03:42 +0900 (JST)
Message-Id: <20240801.100342.2177122481364088518.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggMWrDU2U81e4Cs5dV82VFdWC8+02sR8RTZisQGnFgNow@mail.gmail.com>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
	<20240731042136.201327-4-fujita.tomonori@gmail.com>
	<CAH5fLggMWrDU2U81e4Cs5dV82VFdWC8+02sR8RTZisQGnFgNow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 10:38:11 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> +impl AsRef<kernel::device::Device> for Device {
>> +    fn as_ref(&self) -> &kernel::device::Device {
>> +        let phydev = self.0.get();
>> +        // SAFETY: The struct invariant ensures that we may access
>> +        // this field without additional synchronization.
>> +        unsafe { kernel::device::Device::as_ref(&mut (*phydev).mdio.dev) }
> 
> This is a case where I would recommend use of the `addr_of_mut!`
> macro. The type of the mutable reference will be `&mut
> bindings::device` without a `Opaque` wrapper around the referent, and
> the lack of `Opaque` raises questions about uniqueness guarantees.
> Using `addr_of_mut!` sidesteps those questions.
> 
> With `addr_of_mut!` and no intermediate mutable reference you may add:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Understood. I will use addr_of_mut! in v3.

Thanks a lot!

