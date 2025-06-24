Return-Path: <netdev+bounces-200791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21288AE6E9A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EF67B0700
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5472E7172;
	Tue, 24 Jun 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxPWyPbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A52E62BF
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789701; cv=none; b=PvE4fW6JaXeGfnT0W4DF8UvkmSek7Cs3wi2EAmevMTEWIZiiLgwhKC0zaBiwNmU6uqE/G7BQ12csHE+wgHPeJsl62RIREp//42UNx/5p9YOc+MrT9Q/H87Egol8viFpkL6CT+BXBHR0RJuEiA0WkjxY4jsY81Dxp9a1HH83CMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789701; c=relaxed/simple;
	bh=HnUP0svPZOmim0pIEMKQbuHVRwS2E19LVH1s+PfR0n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOD8bW2aEe5Tn87GIpXoKGYryVpgfx85NC57ABUHjtIQbO2/EuCpgi5nq4DxyYIIMeItB7UOQkweN1BlAOPMGq/MOSm/0k1xg0rrz8GAWmgegMIGVpm+PTIGzmp8cec9MphKvjmxs7wFxm0ZaTewjOdd+kGpT05kRzRVZ3pJ+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxPWyPbI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2363e973db1so1937755ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750789697; x=1751394497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnUP0svPZOmim0pIEMKQbuHVRwS2E19LVH1s+PfR0n8=;
        b=QxPWyPbIKKgJcGVpG9syZ0+qHxDEuK8VolNHvL+koysyi9ezaVb30vm8OA0AG2iuQ4
         7GhdEiL9hb80z7/ZzuerHSAyPlB4g9TetFUl7z+OH1Tt3xRg0vzLSXzeUo2G0Xft9rId
         RQzujuJmMLz/q2ZKvgj1O87A2il8xyvbtytVpaqP7q31NhOeLXB+gJOYroP4v0sJPzPy
         drDvMVwNyAbqv3r/jK060QHrQmI/8b1mqkU71Mw84M3Vle5N05Dqd6wgY90PyPG+xHcz
         i7SIE4D5FCnJ3lhnvd9V9jaDnWhm7Vh5DApA0bzlO5xVKthjc1paZjg6MriMMKAbOS5g
         8azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750789697; x=1751394497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnUP0svPZOmim0pIEMKQbuHVRwS2E19LVH1s+PfR0n8=;
        b=UOn4DKj8Kwv6KdXFbmCcf8DhJ5NMjh2aDaczTjC6Fb+ru+KBGP3o+cwEICg4LcPbPY
         bNdfpF0DGxWeMXAxmh43AVqvvNHTcl1yY3zurPO0ex2QofhbAHw+yQNOu+BURE7kus9k
         0yZjty08IFGj1CY7R8+ZBo1TsEImBIajaxcMsE3n+5x/c2Cpmq6BRL803oxKyg9Rm7vh
         3rF1AMhIzuZH7LmxNye+cA8wh5+94NawHRSZ0+p7n/R6qFkjXR68sv4pzQmkDuGBlvVw
         nLrdiDpqRir5/nCZhj2G90DLB3ZZjDqlXD19vR7sh8ZiWaQmAgtn0WQ0m+Rv/VBy9VYf
         i8ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2ZdbcIfiKN1SbUGuig9BkJ6smqQIoLjgO/hoAn5A30oDryZOGxAwq0D80ShD3w4BUZR2JPIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5n+UszUTlxdADnvh34KkQpHqQ/oTXGob4GW7DTRZ407w9daQ
	DPy44JskhNu2m4l/Si5CHtpCwzNgBsfwFv4NFgun8Ids0gEEm0Mef6bNBiF46RTZeCfDzwJALfO
	GtlY9N2Vp5bPAPYo82M9MFDAINhIQ5qMlThpfVW2B
X-Gm-Gg: ASbGncs49Rwx38I5BEmDtqp/EDt0wxKaykwpQmWjUAs0DOaoApx1sNFuHi7fd7/rMtS
	epiGbc42L3zhy5f/zAqwoxlHw27GBGMdNopLv3EoSLq9/sZ6aflwmm1jQJnOktZyvlvQMjjaEXJ
	9wY8OpEtA+47J71AXVyRSaddeHjo54FqswfJcNqcVlPb3PvAcUMsyFYC4RrOnjnb6f7iPVL/AVo
	A==
X-Google-Smtp-Source: AGHT+IHx/alFKK0amYvW7aHW8ZW7iOwbioo3APJPkKeIuGq+r3shmRf1C0otKcAvioNi46YLNF8O+aohdTGK6qBzDgo=
X-Received: by 2002:a17:903:32cc:b0:233:d3e7:6fd6 with SMTP id
 d9443c01a7336-238024b085dmr75142015ad.19.1750789697149; Tue, 24 Jun 2025
 11:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624140015.3929241-1-yuehaibing@huawei.com>
In-Reply-To: <20250624140015.3929241-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Jun 2025 11:28:05 -0700
X-Gm-Features: AX0GCFvWm2VbQkKo2JfN_Igg6WbcDDUDMo2n3YynUPm5ZWEJa1C6CpeGKmShzJ0
Message-ID: <CAAVpQUD7YsaZRvDzzdnhMJFyfXQHe8jip7r8kNuuw-HpL2JciA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Remove unnecessary NULL check for lwtunnel_fill_encap()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:42=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> lwtunnel_fill_encap() has NULL check and return 0, so no need
> to check before call it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

