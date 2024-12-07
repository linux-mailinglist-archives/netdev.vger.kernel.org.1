Return-Path: <netdev+bounces-149894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1F9E7F90
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED4718844F6
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FB13BC18;
	Sat,  7 Dec 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1mOrsa1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294BECF;
	Sat,  7 Dec 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733567965; cv=none; b=H6iAw7il+18/zesW4R3SVcXGweg5BQEP09FvKMhtjsGBqOxPDzwPcfxO54vx3yyLvF7wFYmofEixh3x4ASPs2tPtLcOZkkqdAuwmCh2sKzAm8fSpDlAEBq6IUAwGofdAP8S1phBim2xsEl7D1ebikYie6vKxTXE1Nie5wsxB2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733567965; c=relaxed/simple;
	bh=D3RbkaaG4xxy1vTILjREoQ2m9eq68oEOEee/fpnu8pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSD0Kcu5JDhpNBnwyG50YwjdmsY2LUFyG9tLLg+jEaRbiZ8z+g0VyScjVfdts/sjCtbLsUORQ2NF0thecQrD4Oy7oLwRAgd3YWEoUIegogUozwVZGHFqk/yZfxzl2abdBklL3ai0giBryX/vLGEL44znTCkORsRrCSx6ej4Awms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1mOrsa1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725c86bbae7so873937b3a.3;
        Sat, 07 Dec 2024 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733567963; x=1734172763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFscs7fH90hM8XMoELo7T9NbLyoZ3UXoG7rlMcZyHVo=;
        b=a1mOrsa1UV69bRa3Sv90f6qE40w9oZ8BTpUH0cKIrDHgoWJMHDu3LTfT96ryqtJjF+
         0c1psjfOrircXVFQNd2AC+4A+yDITaBllf2gkNjxGl4m01EzqUvc9K7LgtQl2QvOxMTU
         DbaV+hF6ssTX0xvscmE40fHprPobYtIPhoiFQBygnpvNBys4u5855Fi4BzB9fS3wjJEy
         bn9ZPl5kOvILsOg4L1WBWyQ7lYCHXjoC5wFEFGZg4+KmUHsDVmt+GxC6CJK27Z4IFdC+
         O+yKHLAbw3htXEbFwyz6cc1Wo0/IM6YbyrvXD3GC5GwJDDH5Gcc4deXE5aBRSqvp834I
         Ibeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733567963; x=1734172763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFscs7fH90hM8XMoELo7T9NbLyoZ3UXoG7rlMcZyHVo=;
        b=G/n6HS2DmPnYZAsW+7LX26tqTlL90oRSmS/rL4W4cmRVQ6lf8mU+wqtvv3GYFBB+e3
         hE5VCdclicDZ9NPuS2vuf1KmRye6CJHjdCLAtNXWbJAUpU+wu0jlwNzqNwa08GrqdIWR
         6XSNS8RmwM8sM3nNnNA/GNNOV09D9klEoAREOetA2ZW/4JvmdQPjGdXPdBLRRvabMa+A
         /U+7sX9scs4gneYZJp/frfOBxgQ7Xo1ZK7BjNocdrrOQagrdMAgnhUoyBS/d78oPkiHf
         dXcoqV9aYCs/8yv2IskFG2tYWCdrfQ+ex+lXXLiMeqMhxI3IxwKQdzO/aKZEE66fcagI
         9i8A==
X-Forwarded-Encrypted: i=1; AJvYcCX4QSYkd0KpuTcwMvEwt/U4LeDQ9+38SjY21V4EGepeIc3PaR9OnQ/zDUO4mJmp4IHss150+sWg4Ae7nnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL17ZLXyDndUpWoGlV4kxu0DVN6bR8rGgckcRHSNkkKn+GX7Nb
	qqItHxjI8Dq9PigSfOctFKD8aAwZjYqfOjmrqL6rZ64Yw2fFE0BY
X-Gm-Gg: ASbGncveSr1KJsiV4h5FrC4YbRohPKRyaaOJXp3PTkV69Ty0F97aVcsy2NBWD14LGuj
	80DUrsVbIJ2aUONZyWU5fTQDD4wS6+2xKCqQ8bF6RVbEG2MJitwJWQx+bSLWJeC0DF1dbQunjuR
	LKhTwrpoQ8Z0GX9/qSCwYioOPnCxjbpw3tGKKeqfcf1hGv6OkT7VBAm/D4bSH4w61e7N2kZF9R2
	ziY8purLQnpV0HCBeKHgeyEF/XJMByw7M52Jdgf1oTw974=
X-Google-Smtp-Source: AGHT+IEysiOlJ9ETZ/Xxh9z0hjLaghuXzoMd9yG4NbBjqLdyrzHc4t//d+YwIv8aZJjTQdnU3t7pmg==
X-Received: by 2002:a05:6a00:4c84:b0:725:d1d5:6d80 with SMTP id d2e1a72fcca58-725d1d577e8mr1656122b3a.7.1733567963483;
        Sat, 07 Dec 2024 02:39:23 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a1598asm4278372b3a.81.2024.12.07.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 02:39:23 -0800 (PST)
Date: Sat, 7 Dec 2024 18:39:00 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: Move extern declarations from
 common.h to hwif.h
Message-ID: <20241207183900.00001fad@gmail.com>
In-Reply-To: <Z1QfupFfg07jTMUc@shell.armlinux.org.uk>
References: <20241207070248.4049877-1-0x1207@gmail.com>
	<Z1QfupFfg07jTMUc@shell.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Dec 2024 10:13:14 +0000, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> 
> So I think rather than bulk moving these to hwif.h, where some of them
> remain out of place, maybe placing some in a more appropriate header
> would be better.
> 

Totally agree.
I am going to rework this patch into a bigger one.

pw-bot: changes-requested

