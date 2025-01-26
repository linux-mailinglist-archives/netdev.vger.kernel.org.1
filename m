Return-Path: <netdev+bounces-160943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8362A1C62D
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 03:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FBB166451
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E3192D76;
	Sun, 26 Jan 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbH3BmLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1C4A08;
	Sun, 26 Jan 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737859211; cv=none; b=osC8VE9fNwlt1tX7O3X4S0NAzACvqnmJJ99OAelmv9nxP0V/TBSeZRgqokReuloh2lWc5V7ln7Dm4XX86lR3Raz0tMwraUCfkYj8QyMIu52+sOboXE0GVSJI6822jwCMAk4iZm/bP49YxgIUt+TIo5BdDSLK/H4IonNuH2Sfnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737859211; c=relaxed/simple;
	bh=BAUDmcJU+JWgNpQSpVG1BXlQ+Ce1zdKV+VBtIaZ4PP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb65X03PZEzKKxjg0akrwz8t7XdSix2LkwfO7i8SZsvfc93/JSdkPuIG39SrUGnq8gpwDCgH9dc1QzuVOxaSruk0Kc1IWdzbxXHbYe5gzLVZC+/BTUo0U5ETlEfWd/mL7nCR2Bf57zKv8yynZnoLm5kVw4fnQ7FWO/hjYRehxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbH3BmLb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso41852685ad.2;
        Sat, 25 Jan 2025 18:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737859209; x=1738464009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zO1ms2VfnDa4Pg68YIbyfHsBiRPVKAqT5H3D+lbdTYM=;
        b=TbH3BmLbzyn5e2bEWWWClTcKnr8cvE2LLmAoxn2vW0HWbxSsuQ0bCkciqlTGPcE7s4
         89mCBbrWrKKF+T9bQLL7So0hmRvBipN0rbZRqX7i84tgPZ6t3qil3WEXepN91ilZbL0h
         XcgjGYo5qZ/tnle0VF9Gguy3oz37zRQxn1QntviS4Sih/j1EOny0hHB1a+89ygoJoaq9
         QK2bAUa1LpTXVaaaTAWRyIaIHA9gLc8x3g/bSWx3/iL7P6zf2XbkNFH/i7TYKJdTkVK/
         TuMTOUOkG0YOgjM/J9yvG/r3wcbqtsLkkNALfKIwKwMM/fmb0tcFNEyYzxMmER0fDY/O
         a6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737859209; x=1738464009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO1ms2VfnDa4Pg68YIbyfHsBiRPVKAqT5H3D+lbdTYM=;
        b=YfuUQHLcMNiGa5Gt0gmy+Ds1AkZyw4ZEOT/9WTjDk/KAOLGgL9MMCTxx2yU8lrMFjC
         r2RWLlGry+8RaCt6tFE1XoZ1WFi2afwdLVVgS7zhFEh1Ny8QzZA3yKkcddCF6gf/YPkr
         69WeE4q3iRzFOaRooakEMnP5oH1mUwGs0JPax+/ewVJUa9JYAwaW1m5nNtHPGyR1KXrj
         LFg3k0Hk3LfHo9RUf/FxmBY5eeT029iB4YggaOCCsmkzGZcHsQxgKqODGDqYmaEMx5nf
         jZF/Oiv1K2z3HnMNpBuCYUccW7oukF8tbpOrOq9OTIbqGsket5uLMmev/iMNysPH47ho
         thbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWlHMqZFQlRiu2TwbU6kltV0eZTiIj3j2YeA2rQvmQyQ9mLR8OADO7fvpZb4+EQBJShUWDoP5@vger.kernel.org, AJvYcCVQ1Sti6Ac8K6TVdJBikXDy4ju5Q9b/WijyeAihqQD3OI8KSDf+0jezMVfw+W0LVQE16yxjCaKTyXqlw5g=@vger.kernel.org, AJvYcCWsPY2tIOlM+OPuGm9W/b4xc669VlKTPZVFUtkdKXZ1n6oIZblFA3Y9MiibocfhHPY61MSixMvc6BTJTfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUQUoYZHwqF3+iOtv/+JFtyfPr5w4DOGmUszeKBrVSJVVfUGN
	a1EkNioqtKomvCBvZsRDAycwMgoy5ZuvrWzqSsBHajoPknHunNs4
X-Gm-Gg: ASbGnctWcXz2AqDuXEQWBZKgKqxa1ULDzj5Li96JfrpU1zVi10R2IJD/YYmQOXqcy2O
	uOIXietvkVynlqjwYjNJjJPI8ehf9AGp5hvlMszJ/mvlY78hZCjtD8Pi5+Q2zo8NWkqJf27aiRf
	0USdZETbTS3/W9gi1E38J5RvWDjK2XsHcpDrx37LVKCEy9D3a+RcOQusFg2TP47knMhWscjeiRf
	bdPZ0fp6kj7Z+mPodouI0Dmn6h1D7GUpLR2BXOnY2/p4NKLAG6ZkKhG19NXLbnEUEr3s1rxcwoh
	Mg==
X-Google-Smtp-Source: AGHT+IFsqUm3b34km4WyrcizVaYpgbqweOU0v8OuV1KGFi0lmdJUkL/Z82B1rVH2F3YAwm0jejyo5Q==
X-Received: by 2002:a05:6a20:a10c:b0:1d9:6c9c:75ea with SMTP id adf61e73a8af0-1eb21470203mr53454209637.5.1737859208701;
        Sat, 25 Jan 2025 18:40:08 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a761193sm4591717b3a.93.2025.01.25.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 18:40:08 -0800 (PST)
Date: Sun, 26 Jan 2025 10:39:52 +0800
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@idosch.org>, Brad Griffis <bgriffis@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250126103952.00005556@gmail.com>
In-Reply-To: <09442385-573c-4756-8c30-296631bc6272@lunn.ch>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
	<20250125230347.0000187b@gmail.com>
	<09442385-573c-4756-8c30-296631bc6272@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jan 2025 20:08:12 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> > It is recommended to disable the "SPH feature" by default unless
> > some certain cases depend on it. Like Ido said, two large buffers
> > being allocated from the same page pool for each packet, this is a
> > huge waste of memory, and brings performance drops for most of
> > general cases.  
> 
> I don't know this driver, but it looks like SPH is required for
> NETIF_F_GRO? Can you add this flag to hw_features, but not
> wanted_features and leave SPH disabled until ethtool is used to enable
> GRO?

SPH has its own ethtool command, stmmac driver does not implement yet.
see:
https://patchwork.kernel.org/project/netdevbpf/cover/20250114142852.3364986-1-ap420073@gmail.com/

> Are there other use cases where SPH is needed?

https://patchwork.kernel.org/project/netdevbpf/cover/20240910171458.219195-1-almasrymina@google.com/
https://patchwork.kernel.org/project/netdevbpf/cover/20250116231704.2402455-1-dw@davidwei.uk/

The stmmac driver does not support both of them, but it will someday :)

