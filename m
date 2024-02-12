Return-Path: <netdev+bounces-71046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24189851CF8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DFBB22F6A
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E745976;
	Mon, 12 Feb 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZnwopuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E645014
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763170; cv=none; b=O12uDU4QfdRcvusrU1cMTEzDH2DQ0FCqgGjTUUgeUzEPdak2ksa/2NkxtNH6KhpJTDcvRAlst5ZSrfim/UB+iQeOSAd6Cc03NV8a/PHKrqb50x3MUGsyo7CLJkqds1FdHD8F0STplRDLNT47RcNvTpRPvw4GId4n1tQGkG0YmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763170; c=relaxed/simple;
	bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUkjR63VZBTG7BaBZKhNZzJtFDs5C3M5LPxUHzLHksBWxQ49kbj1Edx9vaOzmCbfjmV95KLcjWuga5IhLjqigrKZI0bZ9142IxQGGfUqJUxCgvf31P14e/RIqAXhdiswc0fhkb15XZE8FhvaeQ3zC0S97bZj8ILeo7/PRNrHWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZnwopuP; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4c01a5e85e8so27007e0c.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707763166; x=1708367966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=rZnwopuPxaz1NRwgOxXRb3HEErW5l+aank023/5PqrsvlWHjSX4ZRpLumO2bX0B7oj
         AW0BOWxrVJA345klwhGAXEHlyk1JgXLHzfUP16XPhmcDurDzoAxKOjO8eo7S+rc5hJss
         4HsN97plRqzuJXsSBFeFkMADoZuLBfx1Yu090fYV2nRwI1o5Zi6JATngWobKLFK0bBpr
         fXeQT9rUoqn70y0PlgiG91/gK1GbEmtOQqcE1tQaBkHI+iS6q6aycbF+STS/Pzh52Aku
         OFQsvKJjscQxoddZI+HAb2W6u2Fd1KuvLKv+feRIl6C1NPMj8XUzQ9FdWy+H+Ubo9YGA
         6Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763166; x=1708367966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=AOOWesvgwUzliNViZCeomMpMdrP6KaKg4cqOjK7Ncn1QOcjiotfjc/varroIvh8xv6
         pBVeBUizFKg78jtjjC/8OfIFEQVfGsitCAqm+9AP76pODJrcyOe6M0RH7GG5Y9tADaE/
         yEVsrTuATqKIiiJQsr2v45vrUP4+LP5LKUbpZ2vr+Mjqm5vtw+VkCsjazvzUgDGyOTcD
         b6ChT3rdVrBF5hHoYiQIrFFlUZsKC8cDFRCByaEgnM0at01z+0o7jOI9dm6xg4Iq8Gkn
         HUOll6SpA8hzvg4LSGtEKfWHFz9NSTQNllSF3N1xkM2K0ICMaIdTNybqOB+XgBZa4PXE
         nRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVDF2UntkuK/HMgumw489wiLTP/M2LaDj+2kmrZCrorXrglKFtwqiVlbBSUnVG6wJzfjnGFTJhewo4AyVLOR7bvEGHlgn6K
X-Gm-Message-State: AOJu0YzgfP8m8vry/AjNXlzHI2ZcvE/rW7IPEL6mkUZQpq7hfNj7xRoj
	xZM0AkapaBUzbDSIFjQFdvNnHOPnxJI4ulydy1lx6YTf07n8UNvq836ZqDJhQ+v8BDicYS4KCYo
	y4aOec9bVoJ5FUcK2qKsoJCK3KM5nqeMrK60yfA==
X-Google-Smtp-Source: AGHT+IH0eDVCHbyPL9X/VNVKVFp1oXkZRJlvE5Y3OB8AuOpgh8MtouPlypW8yAb8NtGduUZwTTMV+D64YPCooPEabaU=
X-Received: by 2002:a1f:4c46:0:b0:4c0:3b31:34d3 with SMTP id
 z67-20020a1f4c46000000b004c03b3134d3mr3533056vka.12.1707763166289; Mon, 12
 Feb 2024 10:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209132512.254520-1-max@internet.ru> <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
In-Reply-To: <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Feb 2024 00:09:15 +0530
Message-ID: <CA+G9fYsBakUkg11TFrKZtsqZH3K=6_C2YvEmx6NoHVTkUNNf1A@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Maxim Galaganov <max@internet.ru>, Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 19:27, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Maxim, Naresh,
>
> On 09/02/2024 14:25, Maxim Galaganov wrote:
> > Older glibc's netinet/in.h may leave IPPROTO_MPTCP undefined when
> > building ip_local_port_range.c, that leads to "error: use of undeclared
> > identifier 'IPPROTO_MPTCP'".
> >
> > Define IPPROTO_MPTCP in such cases, just like in other MPTCP selftests.
> >
> > Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/netdev/CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com/
> > Signed-off-by: Maxim Galaganov <max@internet.ru>
>
> Thank you both for the fix and the bug report!
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

