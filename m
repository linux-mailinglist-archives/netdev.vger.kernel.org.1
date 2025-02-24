Return-Path: <netdev+bounces-169186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C01A42DB6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844E174455
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47431242938;
	Mon, 24 Feb 2025 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="tdBhm15A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C0C20AF64
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428771; cv=none; b=BR3YXPg2z6a1OHbKZwCEPTbBsDlDkmugTf1Fb8OBxYisSrbDozIPmAV6FiJpPC6l/0Pa9OxXHAW55yhBcmInq//AJSkEu6iKV0uybmfPjFbJ1+jztGRws1q5Hz/yaituvWPyld4xYSmjj+/BOXsotn3ovg3Ggk/mzQHvfW4oPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428771; c=relaxed/simple;
	bh=0g8bOe2b4OTQkeJ052KeDSJT2dXxuO/qqUdLpXkAQV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bev26mpaWNbgh1UbQ6uLF6w4nSNcIR8b4VEtHLEKXxQxvpamKJ9pf1kSXx3QZLVqUkk/kVMqOiEPx0bhiRZmqNAUnlgiiRqv1UMetvjDonTe0kdAw0JndQhU2S6ZMoK4j3QR+IaqqQ1WQVtsnSGhmo9Xd0EnHiVVHfQX1C3/zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=tdBhm15A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22113560c57so13515645ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1740428769; x=1741033569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgBgqyu4tKatdMND7+/18VtL/05cP3jlzOPJySx+wMI=;
        b=tdBhm15AOftP8IVR72XzZqd1A/tZ8f/3GkRKKqAPoykdplnQpbpL1SpeL87xAS8kLu
         bP1g8PJrqlNqA2mIn7cijbtgudBkKt1kSkVmJBxQtM+7udODmKMHibvHgbdrzi3VHpnB
         /4NaXP6wYRwGUra7HsSt2RnYm+nWU+ZRTWKxPStUoXU6xWbr7yXUnmxlgiuoV5/hUqM0
         lxOniuyZ9puBM3uRzUJUdXy8OI1bhdiFtDZCoC9dD43EDIUrOAorp4FpTmM7DtQiL2+5
         P0FahL9X1oCoqivruD9wC58viU/gzmhc1SuympBPBXYPcURFcq56yO6ya/4YWkkTlNT0
         1Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428769; x=1741033569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgBgqyu4tKatdMND7+/18VtL/05cP3jlzOPJySx+wMI=;
        b=tpkocPHAB7waTEO++8yNjnFdqmzGmrVV6Lo22nSxLmaoSrXdJ72OQ+DHJdEjMNmc7p
         tX8vo/RIPCsmEWMK9eIlDt0qTtkfpmz/osJYfPo7gLol4cn0T73JqD5+x9BSIp3yOaqy
         CsJRW5S6TdoX0qnQIK5zXflDsTzqhkXD5ndk4JzdKo/3l8gJeIqviHtlcY7MBicMokNk
         aiEIoLVy8Yor2ZtBC6YS3gx6BjxLkbHYrHmVWhI8A4HnWM11ajRWJzKSUPcOJdW8+EMg
         ++ZwNqC510vL/NOXA5gRaQxNUr1JdKUg0fw99CZuyXlEUuzf2dfPS8WhBxcf26XZYvd/
         VaAw==
X-Forwarded-Encrypted: i=1; AJvYcCVLDeBpVB33hFG8EOIWkf2aLZHkfB/o+txphoYH+Sf6ZS/7stwH8tGGS/lt1aNhCXBO4F7l910=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85oRsJKQb1ENsboAsI9xsI42zRjnkhZjC/kic2EOD0ihOWs2c
	T4GmRNTjaBxhtEIArgRtwDRaSHJpbj86OS+l76RenYMNJC2jRwu037JcOacveh8=
X-Gm-Gg: ASbGnctKF6KPFgzj7PtN3nIeyqOmQzZIeBMuuvzApGCn47fCHP0OeM/KMS0jKcTgBHu
	5YQyqxN2YhQhFjr1Zv6a0/hYz1zscRZQDa4ByOQjD6P5Xp5lXF+rCsMX3xKikJSYQhIQn7Kbw+W
	gV6oc7nQUrWvAjyWFl8ken6tMI9t+0HXgdapZl2RTQJmXHyjyBL2Mt48+/5NsmEw8OZFA8Fj+zV
	9YqwaC0cB9K4gXN/lB3oHsWQxEiPe1zMbjeAYYCWm2UnRAgUgKFODjsAQ72YgLdWVthGYGTClu5
	pGjZtmI=
X-Google-Smtp-Source: AGHT+IGji8X4JW99D82J1gNUv4VGOe8Di1Z0iUYkFrnt5DobfIi0K1SZsszK6YCNFA/kxOX0YVJuVQ==
X-Received: by 2002:a17:902:e80d:b0:220:f069:eab4 with SMTP id d9443c01a7336-221a0ed87cdmr259370375ad.22.1740428768763;
        Mon, 24 Feb 2025 12:26:08 -0800 (PST)
Received: from x1 ([97.115.231.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb12e4casm7009510a91.48.2025.02.24.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:26:08 -0800 (PST)
Date: Mon, 24 Feb 2025 12:26:05 -0800
From: Drew Fustini <drew@pdp7.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/2] net: stmmac: thead: clean up clock rate
 setting
Message-ID: <Z7zV3Z8L6PQCLKnC@x1>
References: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7iKdaCp4hLWWgJ2@shell.armlinux.org.uk>

On Fri, Feb 21, 2025 at 02:15:17PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> This series cleans up the thead clock rate setting to use the
> rgmii_clock() helper function added to phylib.
> 
> The first patch switches over to using the rgmii_clock() helper,
> and the second patch cleans up the verification that the desired
> clock rate is achievable, allowing the private clock rate
> definitions to be removed.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 28 ++++++++---------------
>  1 file changed, 9 insertions(+), 19 deletions(-)

Thanks for improving the dwmac-thead driver. I've applied it on top of
next-20250221 and booted on the LPi4a board. Ethernet networking is
still working correctly.

Tested-by: Drew Fustini <drew@pdp7.com>

