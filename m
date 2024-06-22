Return-Path: <netdev+bounces-105889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCC9135FC
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 22:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40692825C0
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5D5A0FE;
	Sat, 22 Jun 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B78f7UY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD15103F;
	Sat, 22 Jun 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087234; cv=none; b=Ugv5THk459Q5SGYnWeySF/2aVyjJqwfItR5m5z+qTfgqNGiK3dfgUl2hHQFT6IIiY5umJ/j9HDGryQHh3BLkb3B7aQLRRVa2Win/YvOyGpTRCW1cgYPqmGv92MBF5680lCIuleM0pD4GvltH/UqmiJlNYFi9Uz9A6ZXOtbjw+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087234; c=relaxed/simple;
	bh=UA5oSXmahYbHYVBqtiUErdibO6xfe3AsD2W8aE4UE/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwyA+IxHr3BJIuvmRUP0JnKjrzTzhxSxmDRtV4dqmN8PwqIZb22y9wn6KJ2NnIIajAHOCRlhGvZKuO30ygc4hH6RUJL6EJZ0ndb+wt3ROlLPd71Hf+jAxcPgMLullncMRC62dxOWzdVrd+Q07Gk/nsj5TLnWnYUx3DWyJO6FjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B78f7UY5; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2598ae41389so1658010fac.3;
        Sat, 22 Jun 2024 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719087232; x=1719692032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zn/Wpf9G2VUisiptebA9rcNNy8uBkLEZ47r5g9BcsXU=;
        b=B78f7UY5nrgCxC/JjNmOlaWSetbZcWPMaLs6FAEeoCJzvyqLdQ14k7w5hF3xq4czD8
         jXYIQ2OtMpAeFv4T1Chl3nLnu/fq6MGYoBCJ30jZtSMgCu0v37zqOrAXP1k3tlNh/R2i
         dNTVdqa+dWn/+mWgEj6FU7heQEMukO5KI1dZ2wfblmx/BUSSOQePFb3YugXporSX83+H
         jmwhBklpzm5OSERyWcD0kdmNT9G4EgpMPmVgkgovboE1sl6nO/+x+ZVwWcC/iblgC+ny
         oT6I2erHlHRebIuGxQBQYFTsRTOsDe0fsUs1FpiJYqOEyrf2AdnyMNHKy2oBrT1QsG2d
         kfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719087232; x=1719692032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zn/Wpf9G2VUisiptebA9rcNNy8uBkLEZ47r5g9BcsXU=;
        b=b+O2joRRXho6bz5d9MABQR4XsZeGUb9nFvo5GDpcVjPGrmLINfL22FfLsSnXOKhS2b
         +fX/uh9UxsdDmke1Bk1jPhOxvd0j/lsp0qnjWB+MBZyia6SWhM+unTgGcH8gqMh6wTtK
         85Uw+ArnWAemnCpX0ScL5+nMy0yM26oAywGlgUFVC17HK+Fk7nY0LbippBZPSntaEdrP
         lSVmDuGN9pyUg3pzp2iA0XP+REjdpazmCxnBx40VYCnmULUckKd4j0WAYox7PxTQsatU
         OW8DqyOlxMFHaq1VNf7G/oT61sHR2Q9AEFmBIStKKDmn9kUs8jlXLibeQHEl5JIwiy+J
         emQg==
X-Forwarded-Encrypted: i=1; AJvYcCXgLRtgAeb1+pq20Y+oQZF5pppGYuf2M2AfG54wtHgOIVFaHwc5EQkNvGIAVC+Yc0NKNpMYCytxFwIQvcL/gTDHrHZ94P+7RI/XtbvzXyOeRDfdob1k8DFqjf/q6ALyzJz39fYH4ozL8jFYt7yAAxEFqzCW1iLDjO2xBt4uUlkJ
X-Gm-Message-State: AOJu0YxCZb1xEmLL3RmvsCQcGcwSiBWdJuwEv69IkTqQlXSB6UxfGaU9
	u+sH7hQSgcCEcEgAzLfF6zSZYDRwQ/vH78MZmByBO+rOMS7aNy7b
X-Google-Smtp-Source: AGHT+IGBCgKjNBRhA2BRCjBBWXP9wdDisTR4355ryTFD1XzZRjbL080L/5borOqqmPsLMQjCp0RJ2Q==
X-Received: by 2002:a05:6870:55c9:b0:24c:a8e6:34e7 with SMTP id 586e51a60fabf-25d06cd6cb8mr869723fac.26.1719087232560;
        Sat, 22 Jun 2024 13:13:52 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4bfe0absm1026662fac.47.2024.06.22.13.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 13:13:52 -0700 (PDT)
Message-ID: <d4b03f1b-b0e4-4375-a2d8-3ea87e91c16b@gmail.com>
Date: Sat, 22 Jun 2024 15:13:51 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Documentation: update information for mailing
 lists
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 13:24, Konstantin Ryabitsev wrote:

> There have been some important changes to the mailing lists hosted at
> kernel.org, most importantly that vger.kernel.org was migrated from
> majordomo+zmailer to mlmmj and is now being served from the unified
> mailing list platform called "subspace" [1].
>
> This series updates many links pointing at obsolete locations, but also
> makes the following changes:
>
> - drops the recommendation to use /r/ subpaths in lore.kernel.org links
> (it has been unnecessary for a number of years)
> - adds some detail on how to reference specific Link trailers from
> inside the commit message
>
> Some of these changes are the result of discussions on the ksummit
> mailing list [2].
>
> Link: https://subspace.kernel.org # [1]
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat/ # [2]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Changes in v2:
> - Minor wording changes to text and commit messages based on feedback.
> - Link to v1: https://lore.kernel.org/r/20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org


I prefer 'origin'over 'provenance'as well. My Ack/R-b from version 1
still stands.

>
> ---
> Konstantin Ryabitsev (2):
>       Documentation: fix links to mailing list services
>       Documentation: best practices for using Link trailers
>
>  Documentation/process/2.Process.rst          |  8 ++++----
>  Documentation/process/howto.rst              | 10 +++++-----
>  Documentation/process/kernel-docs.rst        |  5 ++---
>  Documentation/process/maintainer-netdev.rst  |  5 ++---
>  Documentation/process/maintainer-tip.rst     | 30 ++++++++++++++++++++--------
>  Documentation/process/submitting-patches.rst | 15 +++++---------
>  6 files changed, 40 insertions(+), 33 deletions(-)
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240618-docs-patch-msgid-link-6961045516e0
>
> Best regards,


Thanks,
Carlos


