Return-Path: <netdev+bounces-119932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43B9578B9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286D3B20E39
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE31DF66F;
	Mon, 19 Aug 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baGlINiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905515A865
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110755; cv=none; b=EbSTJgz2xGiOels1yx+oI/M5gu8JCWHNvDGwBFSq6sEgaBCu8t8DAolJ0rX/Wuh+csibPaZBu/dGvoIr2jaJf1Q3l5Ef9jFJXKAYL/hjtQUyxeUQ9RhHPM8O3JsNWCWMutNhNO8DjfabyoposilLsOI4qoqItYeMzewChd3dM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110755; c=relaxed/simple;
	bh=lZJol2DFHX/A1hfn6v8hzLcoNFs08ICgDCBu64glJ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E3Uh3Lh6i+XbSYN27YtzMUDhb6RhSCg3vjuscvpCmVj4V8fVXqTiKY2vp7sHnuP1IGOmtDTz2/rtLkEUCWOwseSUPrbJjb7MoygAgPcjwH4jRkHHECV5gGXkeWWC8F/T/keimWYw5XZN4eYgpik3kMKoi4muLJEmtEaX5b5+el0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baGlINiF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c1f480593bso3204683a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724110753; x=1724715553; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZJol2DFHX/A1hfn6v8hzLcoNFs08ICgDCBu64glJ2U=;
        b=baGlINiFgz4U1Sx6Cq28OH5YVTfesSK+2ilmwJoK++axU2zUe4mcTan7m/NhB04xlj
         pClknI4tu4+hopSmf872q0CS6yj9cnrz2HF7TgPbs+eikFSkdfOHIhnsAAJbgXG/ITIo
         X8GEQ9kDGjfjzPv1VfLbnLmeAhe/BNeSmuD7A6h8j/aDid1JbVglAr6iBNLPrX2UtMiB
         ZiIdams3G3182LYodQKJSOt3nUynsvwINkWkiNAiCMeVSimGTYAEwxlA2MhF0nDQ53Hv
         cz342vD6eAQcZBO8DZ26G51Tn+ssVMIXUHLSdLYwDmwF4mR4K3hYrEY0J+HgAAO7mB14
         cfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724110753; x=1724715553;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZJol2DFHX/A1hfn6v8hzLcoNFs08ICgDCBu64glJ2U=;
        b=CdM+G838uFmrJmCs9E4nZGty8JxB33/NRm7wKUBlJup7e9pSBwcBRVePcfEXDF7GrZ
         HXl4pHnoJiQWVx5/nFXeyAOUj3Vj3NR5Rj4RYTZO8+qYHBm1G/sgD/tIeRlfbQYC03Qr
         gtxjPIpBMhIyXN+wVkoZNZvameOihwwtbTr2g5tPkkn8BqVDwd4pValyt5i3oxUuQWfY
         mP3fPzluav0p0UDU2p7+vqm9g21n+XH6nFkUB0OHTj0DtUKSWRFlB45/o15w7pY+FOYO
         EconpcKICn+DQ7MdDEjtkKq1crTegWqSpDaC3oJWqo/yqhq7JpRyoZ+IEZnQerm6yHp2
         JZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVhyIgwZWTYwP3daASaQ3mjNMD/pCJ1KqK8ZaHj08Mnk4P2/mB9P3LMgyByE6YHEJPhLyLbiEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHGiHftFzxDwInDh1xDgg7ETba/AnAaJStol1rOBRbLjUNZJy7
	z3Il/mvQuxJQMjlehK7vlZGOEXus/mTpV6VAC2/ZLK6VZ2hasK1I
X-Google-Smtp-Source: AGHT+IGLTyszEiin1kCnEqKkkqqTsVge4EIf6IoNnCjNavqHHV7QR62mDjfDdVxNNZBMA92IE+KbUg==
X-Received: by 2002:a17:90a:a016:b0:2c9:359c:b0c with SMTP id 98e67ed59e1d1-2d3e00f0c45mr10409656a91.28.1724110753210;
        Mon, 19 Aug 2024 16:39:13 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d99200sm7835297a91.52.2024.08.19.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:39:12 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:39:08 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Subject: [Question] Does CONFIG_XFRM_OFFLOAD depends any other configs?
Message-ID: <ZsPXnKv6t4JjvFD9@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Herbert, Jakub,

Yesterday I tried to build the kernel with CONFIG_XFRM_OFFLOAD=y via `vng`[1],
but the result .config actually doesn't contain CONFIG_XFRM_OFFLOAD=y. I saw
XFRM_OFFLOAD in net/xfrm/Kconfig doesn't has any dependences. Do you know if
I missed something?

Here are my steps:

# cat tools/testing/selftests/drivers/net/bonding/config
CONFIG_BONDING=y
CONFIG_BRIDGE=y
CONFIG_DUMMY=y
CONFIG_IPV6=y
CONFIG_MACVLAN=y
CONFIG_NET_ACT_GACT=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NLMON=y
CONFIG_VETH=y
CONFIG_XFRM_OFFLOAD=y
# vng --build --config tools/testing/selftests/drivers/net/bonding/config

[1] https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Thanks
Hangbin

