Return-Path: <netdev+bounces-198791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132FFADDD6C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37BD1940492
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA125BF0E;
	Tue, 17 Jun 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyAlTCo1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3D1E9B3A
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193313; cv=none; b=P1o4b22c/DQBuwNTiacPfvTqAzAcyb2QNkMUSFovFognXOQ7zgamVQ6M9T6zT3EP7gk5eSfjCxKbWT1OjxSmWYZg0A9lktSHdLnIHGg808EFvbYLkSWhoN+GAhxHCcGKmp0SFlM8TNsjM0PqA2FelHdLy2PSz8LCHvcHKBKDJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193313; c=relaxed/simple;
	bh=8MxM/95d4Zu+bOkwvDVSIt/Xpgzoe2upkLxO2yO8pkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5yLyT1BOLT/crQx3S7Pt4PksF4xdqOILmsjPtEyg0aFLRamC4CuV4mJ2NcGlCu7ea/uH7tfpuiBDJ6NhGJtQs1THnew8IjBBB+sz5tmmR2z5oRpPCKk5IjduVdAXVGyQWmOKpxoBnuUIqSXt7MTKBc5TbUfB2ICZ+xChdoj7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyAlTCo1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2350fc2591dso730035ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750193311; x=1750798111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcLgq5IYVZSqWgmQGedXTxIC/Ctky8ZRY8rOy5+AczA=;
        b=SyAlTCo1nnlRVtVdloMjGAHvfs6sYroL2aMSmY1B3EJEyDQmB8FjWTtfm/3cLXiw+I
         Dq4/7bmlKSe2ujdD7mD2cZjIkI9TA7wDAVSGf2rAi8I68uGZ3VZ0/g3xpL4ZFnawfCNV
         3FFxC3J9E95XHBvj5P+2kLmq3Yd8OQzXEKCeVSwheSR16gLbcH4AR6hVTf1Ok564ufLm
         inTkLc3hioQwG3KbNOGpZO/9i1Auq66536PjM4e5civJ7KZusITqq70uYl1VvQWzUVFA
         vad6son6JFMZG6QjxqQR+FVaJeJdH67E18DMoCZyfUdgBFWEdPe4iAViUx3mI4IF+fUh
         ryuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193311; x=1750798111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcLgq5IYVZSqWgmQGedXTxIC/Ctky8ZRY8rOy5+AczA=;
        b=dZC9HqNLV8RqDkKzRMN7MXOfGi1vcn/txTYifqObJSx4X9KYrVJDLXuy/4V3umMZH1
         0Gw1OMctROwkx7JTk4STUXGDPxjN2/iDOs7Gu59UbM6CWB99/m2ff7+R/lvlWTFbpsfI
         pGi734cyLItnLvwq1Lpw14Zivg2uBL9c/Wappbwkuv5+tl47GSc6hI+3KeYFNR8ufM59
         H7rl/GUaKpQBx1IhOgfn8KdfWbQ1VPOV8WaXnHclKK8GAoJhZgXp42OSyoKbknlYbi9D
         S34RCehkBwHSf9sJSg+HolMUsU5jmiJ8c0qGckRP900yXTI9NOnzQ4J784T+wVH8iCJi
         rZvg==
X-Forwarded-Encrypted: i=1; AJvYcCXJSH0opB5KsEIKTY75aw4s/4jhEsapQebuZhi0EUAb8JkW/tm7O23VBbtxrzxHA0DlUwi3O+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAoJaZjxutFuKgc5OJmYgz5ZQn46tvC83vlj1c4MeoTDaogrXL
	KhxEpF7id7YEWjjmh9rz4hoLvwSYsBr+yscwhqlRnmUNz21BL0Hr5gY=
X-Gm-Gg: ASbGncvLbg8nSdKuyyhNdjDjEcGH0LLrzIuLvCT49MhRrlEeX9UQY1/da9LCUwE9i1c
	yBO8C8Y2r7UA3C5V0bwMut2/1iwSuu/nBUbeWbZVPWV5dN/444szgcKMAlb948znh3ulQ8zWC/8
	O49WoBdqmCfx4tvaQ0NOrl+gf1Z4NzYZFEXoW9tBKZ+CROjdI/9nEMsx3RLn5zbFRPeHvfx66dr
	ACtR8q4hoAXyCzxoQyhjRd8n9gfRm5avIWmbPrCKLXXHxS+VF+cI2f2gd3S3K2TFogUyw25I9x9
	/jW3poNky5VmqGQW19lvS9X3gBH7qtBU5LWyMmoRie6C3JhvwSvsGeK0tWW33G4KSs/nlP1BJwj
	cW2Dj/Rp//Uka8nHhdxVOEiw=
X-Google-Smtp-Source: AGHT+IHHAiTRBR47B/RRHf1p5uhBxqJh2X8ueaDnoI0NvL8ED2OBi+z90pDepAazln7jB/KguNUIKw==
X-Received: by 2002:a17:903:fa7:b0:234:9ef7:a189 with SMTP id d9443c01a7336-237c20c253emr172715ad.13.1750193310792;
        Tue, 17 Jun 2025 13:48:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2369eb1fc31sm5992035ad.200.2025.06.17.13.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 13:48:30 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:48:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	andrew@lunn.ch, donald.hunter@gmail.com, kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: Re: [PATCH net] net: ethtool: remove duplicate defines for family
 info
Message-ID: <aFHUnZlqSHShA2sN@mini-arch>
References: <20250617202240.811179-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617202240.811179-1-kuba@kernel.org>

On 06/17, Jakub Kicinski wrote:
> Commit under fixes switched to uAPI generation from the YAML
> spec. A number of custom defines were left behind, mostly
> for commands very hard to express in YAML spec.
> 
> Among what was left behind was the name and version of
> the generic netlink family. Problem is that the codegen
> always outputs those values so we ended up with a duplicated,
> differently named set of defines.
> 
> Provide naming info in YAML and remove the incorrect defines.
> 
> Fixes: 8d0580c6ebdd ("ethtool: regenerate uapi header from the spec")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

