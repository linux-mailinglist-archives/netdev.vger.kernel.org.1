Return-Path: <netdev+bounces-189445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9190AB21B0
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 09:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF698087B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0895D1E8338;
	Sat, 10 May 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2qBV7D6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5D2747B
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746862000; cv=none; b=t5o5vfrkrYmRCX94F/NCCmnG8R1pB790vh2HXpGmSvQDwxkgXwQ8tdBOm6+nLo5KyXTWLI048CC/lmnsPsjvQJoYttzFBjWo22SE7FDROqlLCnvhhJV3ojBfjHe1E/6Aw0D4lQuDlE5xVPlFZbK9XABziJrtY0GhvHq7aL/nvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746862000; c=relaxed/simple;
	bh=IsstClPVLUc7visattUsTCDVc2Bga5dlryPcSOhxpEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DA4omCy1lFOZlX9DOadx5jsO12w4xexJVwKLiZ8sXhxfh49ImxpHgKK67EQOIpobKqvdEO1ZdsmbAWnZosFrHfLVp4XMGFzIHYX55zqWd97UMDPUWl+Z9MypOGmT84E7Mff2MlLuwBwlutEhFNxXTw5uA2n5tIyJVzrR1tJwg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2qBV7D6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e732386e4b7so2937246276.1
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746861997; x=1747466797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSts27GOHs7qkbKGSUS9YSDd5Z671TY7T7HU1jkBF1I=;
        b=t2qBV7D6U5I7QMpxQyGcA+2yegxB72ntibEkOjazxjYPeJDNCDRtrn56O8HMNlgcR5
         FpLVgcAi3FUFEJGokHUKxGjqiacgDzIeF5noBS7BoRRg+4ZUTSFKO/tPePeOAvlZQvsk
         MIZNv2ZfYK/ksuSuRimGxfjDryMZFHuTYDR7DRySmA7ngQ1dUsvVQEOAEnjjPIJta9mh
         1g91zNIEWIPD+Tb8GeCDE4F8t2eHWcNNAdecNFEX3Hhqyfwg4Ur9JSnX3vSgPlOGPZD1
         2JFk+hI1itN6gL/aqf2MN36IZ1dCg8S+1RSv67M20AMHEYoSXcMZNLFKrcdD6zi0ZL9N
         xP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746861997; x=1747466797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSts27GOHs7qkbKGSUS9YSDd5Z671TY7T7HU1jkBF1I=;
        b=ULTr15wYZd7FWd8Wlt3JsNeWwQn8mTJTxLVC4Cil4WEcvLODESKosrVJantIaDcFiD
         f6kh75BVBjt7vCrj0hxcisehcVtOJqiN6kL84tuNu9EZpaY5cwsEMz7KT4ISrMGvPqr8
         Ai70RB7dl4ajCdaVWmjge7yGr64LQPXDWQwWWymsPdLRkj5fKumrPAzYSQU2baza4Tev
         qUql428V/KeTRX1WSug+4QKWShi+frk9GGTj1rb4zDfL4RsdEUpgxDst4GQBBc1BdH+A
         pt2UHHPZAFVrIejXzMsrquulbvAdigUsK7c1UreYOlt0qdg1UC+FX5aSGb3FOsjlx9oZ
         6OAw==
X-Forwarded-Encrypted: i=1; AJvYcCWIXoV9qhQ8SYpDP2l/5tS7EvCMAmG9UeDpAind6JWJrMAdQ7U8lun33GcwqR1jspxrI8HdCLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws68oYJRHvnbRKkXnyXDtMwDLOIChIWQbWYDtP4bQlexlmDdt2
	dapwaWeVySXjZc1Dy3B5frUob8DXm3LSbrpEE8FxLfGjS7my0Lt9qAKc3UR0TH1NihtpUOHQuO3
	YIZ1DyGqvtW4edsvCyZaalneEsILNAkbGPokhLQ==
X-Gm-Gg: ASbGncsZPhJfgAlGtnoaNex/yQaXl0raQDZ995rs5GR0bwPhb6gQz447oJBrmlo56fY
	7Io8tDjn7jb1yJAEYMtn3i2vXvttRXNbUh4HSa22tXg9wWsnxLLiUgzC97BcPT4wzcqNpm+tDSY
	pmOjQDqXXSh5STwlWRxKLMIdr8MFJQzDSM
X-Google-Smtp-Source: AGHT+IHgBd4y9JeTiyphse47nrob8CWwmAtJD/GkOKCnuv2yJ5ga46vbAkHETH7rfV5vl6KLnxpaFgEyuxCKBcbzPao=
X-Received: by 2002:a05:6902:1009:b0:e75:bea4:5eab with SMTP id
 3f1490d57ef6-e78fdd612a4mr7925554276.43.1746861997224; Sat, 10 May 2025
 00:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-20-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-20-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 10 May 2025 10:26:00 +0300
X-Gm-Features: AX0GCFvyCLf2YkLqAu7ZNrSMk-Tgd-w0sQTqK105Q5BnOqCAJU2n8_lO-l0LyAE
Message-ID: <CAC_iWj+vweve6V33cqHGZ6tSehs85vXd7VKAGNiEjLoK2pc+PQ@mail.gmail.com>
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct page
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Byungchul

On Fri, 9 May 2025 at 14:51, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that all the users of the page pool members in struct page have been
> gone, the members can be removed from struct page.  However, the space
> in struct page needs to be kept using a place holder with the same size,
> until struct netmem_desc has its own instance, not overlayed onto struct
> page, to avoid conficting with other members within struct page.
>

FWIW similar mirroring was intially proposed [0] a few years ago

> Remove the page pool members in struct page and replace with a place
> holder.  The place holder should be removed once struct netmem_desc has
> its own instance.

instance? To make sure I understand this, the netmem_descs are
expected to be allocated in the future right?

[...]

> -
>  static inline struct net_iov_area *net_iov_owner(const struct netmem_desc *niov)
>  {
>         return niov->owner;
> diff --git a/include/net/netmem_type.h b/include/net/netmem_type.h
> new file mode 100644
> index 0000000000000..6a3ac8e908515
> --- /dev/null
> +++ b/include/net/netmem_type.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + *     Author: Byungchul Park <max.byungchul.park@gmail.com>

Shouldn't Minas authorship be preserved here?

> + */
> +
> +#ifndef _NET_NETMEM_TYPE_H
> +#define _NET_NETMEM_TYPE_H
> +
> +#include <linux/stddef.h>
> +
> +struct netmem_desc {
> +       unsigned long __unused_padding;
> +       struct_group_tagged(__netmem_desc, actual_data,
> +               unsigned long pp_magic;
> +               struct page_pool *pp;
> +               struct net_iov_area *owner;
> +               unsigned long dma_addr;
> +               atomic_long_t pp_ref_count;
> +       );
> +};
> +
> +#endif /* _NET_NETMEM_TYPE_H */
> --
> 2.17.1
>

[0] https://lore.kernel.org/netdev/1549550196-25581-1-git-send-email-ilias.apalodimas@linaro.org/
Thanks
/Ilias

