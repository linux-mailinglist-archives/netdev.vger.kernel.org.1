Return-Path: <netdev+bounces-103915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26090A36A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0665B20B46
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 05:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF44DA1F;
	Mon, 17 Jun 2024 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbBvMhAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CF17F5
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603076; cv=none; b=pQRv4dkfw7B8GT1O2ykYptUkL9lNDraido7/ghR7/pceguGrYao6US/cqpEizW7GBxabIMiA6fqcmDaxf0LvVAMHrC9AxpS2sBH2dtnoWtWoS/YSiiwlYzB/MVHs5buZ9vRd6NHhT/KAT8VWFhnMzVEG2qkav6A+nxd/yUOyEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603076; c=relaxed/simple;
	bh=mdcCVSifYYgQUS6JdyFaEd0VKO6vWT+nz1bccZM1BUA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WPbJt1p282Kr2XaEhJNCEcNtcB8Lp9ch79cRDf0T4ovM9jCV5JrpeNxIvaT0VyeusUkZjI5rCX9EqanB6xg2Ywe/p10XA+Tso3pr1k5EnMe5X0dRxjoAy1Jb3Aqgplh9CtIXRTWF82MERm4l/US6cBzTYrIBnaZj5dV9bjeIdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbBvMhAS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c53be088b1so182563a12.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718603074; x=1719207874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLoQQEHT6nCCzjebgr3bHdbblESpXwiqZOI9IPQBwUQ=;
        b=FbBvMhASLiKjuGz2A4BCbYQyRnFxWPZCNSUHMDY68gBI8hNS6K/n+kEW7qf/MB0R6e
         cGn5QtyA6MhEVVSlPQRVoGVhneoEIxXFfmtNl1e5Tb31nhAQ7VCa1S9otl7w8JJaK0E7
         jApqs72RhY1uP++SCpJ+QCRixV51+TN+1y8HHDIvoRWdRX7IqegaaeD0kBLwTc5LPzgG
         TlzPkiuecy+OkLZSIfEYvaPmky5GH0BMG9jdXN2HyGTwh80fURlm+gErGMI+nYK1AIj4
         RedQnp5Di79PgU583kWfKG8Hl1GE1MbyAetDefYLBmCYXK4tNZNhft7oXDkos04xnsVy
         CR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718603074; x=1719207874;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLoQQEHT6nCCzjebgr3bHdbblESpXwiqZOI9IPQBwUQ=;
        b=mooes4qJk8bqOzvMvUIX7yApU2lCds76yKvl/D7Ytl3AmXL8gDM5B0bRTltwf1I52s
         kRI8MDH5vjkVArnSj6+7SfxrivPyiBFZABbwO51qy3uukIIGxwEm5mwi55Plw+kNGvO5
         lU7T/hWiGgZ55PYA+05OY4OlNt6TBzaV/z/E4VAPqPWsiWwlOR3Z3sqzDd38y4jCqbVG
         601slJoaIGMk02wg+PEt2vp78KOqJDgKuzQOSQ6UyA0t2Q21FRNU3fu/wupNsIBoHRf3
         gN9tLtVfQ8iDjqhzZHgGsFJ5ososGD9XAhNYTW68j6njc6POxptUBfpbrigepOD2jbig
         CJYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfjxqxrjLZFkvnewbhI2sGy/aNyHS+KeBngYRBUHJLi4hOO0rXf0cGAHYfLwWYVt/YyS6CIAJnRzn7fh3XNGdFqCEV7c2T
X-Gm-Message-State: AOJu0Yw3JSyLTXGOtF61UDQDiNzfVK1+mZDPbcNmuIAZwh753/tXtsY3
	vptdBJkmREKOGJmBjht5Di5SPy7Y2s0MGZcjoAYiil3s9/Joft4K
X-Google-Smtp-Source: AGHT+IF5klEhaRo9SxezhXsqUWCfthWR16Eyjs1+x53bMwizyNm6R26d6yMy8bIJXtDCJiGivB3PbA==
X-Received: by 2002:a05:6a20:1584:b0:1af:cefe:dba3 with SMTP id adf61e73a8af0-1bae7b3d2c7mr10821628637.0.1718603073718;
        Sun, 16 Jun 2024 22:44:33 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75cdec7sm10539395a91.3.2024.06.16.22.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 22:44:33 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:44:27 +0900 (JST)
Message-Id: <20240617.144427.323441716293852123.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, hfdevel@gmx.net, kuba@kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8c67377e-888e-4c90-85a6-33983b323029@lunn.ch>
References: <00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
	<20240616.214622.1129224628661848031.fujita.tomonori@gmail.com>
	<8c67377e-888e-4c90-85a6-33983b323029@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 16 Jun 2024 16:59:22 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > I did wounder if calculating the value as needed would be any
>> > slower/faster than doing a table access. Doing arithmetic is very
>> > cheap compared to a cache miss for a table lookup. Something which
>> > could be bench marked and optimised later.
>> 
>> Indeed, that might be faster. I'll drop the table in the next
>> version. I'll put that experiment on my to-do list.
> 
> I would generally recommend getting something merged, and then
> optimise it. This could be in the noise, it makes no real difference.
> By getting code merged, you make it easier for others to contribute to
> this driver, and there does appear to be others who would like to work
> on this code.

Fully agreed. I want to get the driver merged soon.

I thought that calculating the values as needed is the simplest
approach, then others could optimize it with the table.

What needs to be addressed before merged is if the driver uses the
table, it needs to be initialized before the PCI probe. Seems that
there are three options:

1) initializing the table in module_init.

2) embedding the calculated values (as Hans suggested).

3) calculating the values as needed instead of using the table.


Which one were you thinking? I have no preference here.

