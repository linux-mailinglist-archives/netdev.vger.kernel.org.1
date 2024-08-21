Return-Path: <netdev+bounces-120417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DE79593C8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025491F2319F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9E15FD08;
	Wed, 21 Aug 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfRKsRtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DC1607BB;
	Wed, 21 Aug 2024 04:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216327; cv=none; b=ciaqrO7jle0ZsA27I76KdC7dqmLezIELwCsXd3p7FXHQ6rHuxAGc1Xg5vIfyMrvvool+ELlcMCAbUoG0s1kpQXCnC1U5GZaSj6SsmbqbIoPcsnxlYvw5xUjJNOiLrIOgXnHGzkzK1ilFL8CcUTDUfQo5tk7Qr+xDj+WJfvAAaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216327; c=relaxed/simple;
	bh=oZeErjtg5mSYatGQ2jlMkzCznZDB6MCMxTUqJbOCdfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzZdKASsrnaIlAyDNeJIpKKPQyA7lVf14a7Yc95eSxyslwE3NtDhBAYIiZTEU1y7gcsM2FCglPtNOclQcxT2GzafolfUky8HjQFPZAU4klU1AlJ/dmftuOzbysK/9VvpqSLtSq+WHqpjlVxRYb4EibHa5uJcWJmk2nrQZEejuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfRKsRtM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45006bcb482so32180441cf.3;
        Tue, 20 Aug 2024 21:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724216324; x=1724821124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1wedJG/Bg4x+50/X/HHJc+xQbgaNB+dhizweD19x0U=;
        b=mfRKsRtMXc/7XTgw/ZCG1QhD7z1J/tQPr31ZFfug3Rvo7mqhhERteAlra+Zm2iDWx7
         3iJeRdrB/dHisF9JTPme5F5xKnFY5MIG3H84c+Q/9qf/c/xsW1Z3n/vmTu4OnSVHTtck
         EybxT3V2hjX6dGnveWm+VCnECMXyF8mSUQ5vj+ACEPumuCa46Rky6S3K1zY4h5ABGy7I
         Ih/B1p4p9/NrOmqt1FJ/Dhz3hjkLFnhKbM02Ll07vCRea20euQ14f40/ckcE5G2wu8Kg
         fnow461dXLiy3Bau5hoqbVgoZrpl6Mh5ULKdjSuaq4lUODXqQ56wpUYUAma8TKstdUq0
         9WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724216324; x=1724821124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1wedJG/Bg4x+50/X/HHJc+xQbgaNB+dhizweD19x0U=;
        b=IEEo+uA/yTvVD0Mk/pW7iZo1tUZKwq2tsYYQX36XK8oPrLA+pWzNx6biyk3mGdPhU9
         yxaSvDjg0X9mO8jhR3scbKnw2GJfnugoOJGETNvrKhpy2wxmwlSs9ttdOIK3cPzc8+yH
         LOvx29+B0qoOFVPPBHiuTFX1fCbvNpb7rGv9eJTust2uue+Heu46lcg8PPiwXT9Sn4pO
         IXyK5Z0IpS6LyjKVev74dUySdp1efYeDxD0FoXQ1c1/jDudxoIqbcYTwS8oKKsHrjn9g
         dANz0Lkjuphta7k8B8uAIRPp0BHBjK0ixeripU9h4dVnvFcYSL9JmKD4I6IHPj5P+GVT
         C66A==
X-Forwarded-Encrypted: i=1; AJvYcCVdOuQXzJjPTe0aqWpXYzqeryh1ofpnreTd7Zk0Q3b0l2lrW155S23j25OEtnYiiel8y2xrdborJv1C6Zc=@vger.kernel.org, AJvYcCWGUveC5rvdXwQQV1pZ23Wqm3X6gBd6UMFn4tOlASNjWcVdWRZFKSQ12HB81QyZrWcB2fgEY0JL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZXEJaTpAwhJJyCs+WL/iTTDNc7itzqBtsvX0LTKnEONjMc1Q
	MogxbatpXhkTpPTEbLUXCFvYKcy0C3Aa8+ihq6ZNq/ci2lvEbdO0
X-Google-Smtp-Source: AGHT+IGBo/S81CZz7j4bai9R3gFPYkz5tE2gxC9VhQUqFp/OT85vnumLFVbQZK7aG2h8zR+dajr5uA==
X-Received: by 2002:a05:622a:4a13:b0:446:5a63:d68f with SMTP id d75a77b69052e-454f21ed913mr12368381cf.18.1724216324316;
        Tue, 20 Aug 2024 21:58:44 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0035c6sm56215401cf.42.2024.08.20.21.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 21:58:44 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:58:33 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com
Subject: Re: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification
 process
Message-ID: <20240821125833.000010f7@gmail.com>
In-Reply-To: <20240820123456.qbt4emjdjg5pouym@skbuf>
References: <cover.1724145786.git.0x1207@gmail.com>
	<bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
	<20240820123456.qbt4emjdjg5pouym@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Vladimir

On Tue, 20 Aug 2024 15:34:56 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:
> I took the liberty of rewriting the fpe_task to a timer, and delete the
> workqueue. Here is a completely untested patch, which at least is less
> complex, has less code and is easier to understand. What do you think?
> 

Your patch is much better than my ugly implementation ;)

Some small fixes are required to make kselftest-ethtool_mm pass.

Would you mind if I rebase you patch, fix some small issues, make sure all
test cases pass, split it into two patches and include them in my patchset,
then send to review as a Co-developer and a tester?

Thanks.

