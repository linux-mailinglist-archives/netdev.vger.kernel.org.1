Return-Path: <netdev+bounces-227489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5060BB1037
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507E01651D2
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E326C3B6;
	Wed,  1 Oct 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WpAeDdBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5EB1DD9AD
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331831; cv=none; b=SHpl88MrY43idBZIaBD0TbT7aHv2vdG5B7HvO5iQxZ9d1trMJz5+T2DeOOtWqPkWAuUel/+Lq6imfTlqCgtYGZr6+2MOpXyQPw+otoeNdJRRfoevxMQoY2sFos3VMHJTHOjdikfq4SPl1vIE2hvdjOfW7DzF+X0mp6oh7l9ysFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331831; c=relaxed/simple;
	bh=xsKi9Pi+QT5fVL6eQFIu6l7eEF5T3oEwY+NILjBv18s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUzI0Pyeh8S7o+Jkir6b1oSqDCmFX36L5c4bVcWsLowfTillyRGmfygevowee9/LfrLFft6iWFLx34mYk5HLn7M/7pCMHePPZth7cHdjtEXH4TU9I0iPJuwf4m1jLI3h3o3il2hlrzyfVraNC49305WdPx/kp5ycsAZy4LB3Zhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WpAeDdBx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3b27b50090so22866b.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759331827; x=1759936627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=WpAeDdBxhkDp1c/lo6EM9sXvE3bT5lb61MmbPmMDDpt8xiog2hG9NR5VJte8l2gbmh
         YOx7NoBugKREkodeKJPsLgD0fVe84RqGbCDZ25JRX7pr8g1mUmRF1MR5T7LQU6N4wSBP
         9YT6Rij7kr8aWArLYPFvv/GcBoIHJX2T7NIvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759331827; x=1759936627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2EhHzMOVl/r7mbcD+woryFmIGoIQn5oJw5TlWrUoNg=;
        b=KzTJ7i5WXIqYHaz9MCIljdpOYiGVR6HXU5WxXuOsR20iQt+/BJcUu9E4ViuRFvusE+
         ZtYghIFOkLSPqNZBbesLx8NRffZ3hPheLyjE1pkUSaZpIzIiUh7597N7QH1ZCK34ES1+
         yS1jAhQTCRCB0gD0rB9albCbladwQnTu49tDhoFinwRRVKpkzoFeMGZ4OEif49WXDGhQ
         4UAOOWnw65tKaMgUFt1gfE0+0fW9sYoPEufDpKvZLqVvlMOCkZC650JAvXjQk96RWzOQ
         rwyptTCOed5jvCxOwqIocjdagq/PrfGz9+dCd0+7Px3fZIMxA39VQcE1laJHLSSXyJZO
         UR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVt94J/y74a5TVtebQrRoySABlVn6sUmdqoef4JDnDcQc0kO64XNBeN4zrLbhHXXDfpL7mWEHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYiMbgAudE1zXLR38B/OXzHLi37n2socThKyDZv+eMo+XsoUp
	QH3jmspJGa/Lc0Bu31N7t2sbTpg+BZFpncQUOYASA+t7asSkwnyq4C3dWKYjOlO8XTWF4NN/5J7
	9PtkDEGw=
X-Gm-Gg: ASbGncvegxm5SMw++2vk/98sb/OvtlX8srOYbDSC4tbfgIIbMdyKPr4KQfYfJglo1KO
	fr8jtBaPou3JPUvzDzvkJF4SxwlOy3KlMTaEy64sxE25+UBRxDh3CHXC8pPnn9cquEdDPQ/7p23
	VUZMNqzPXAkz6Mr/7gwFETzugbEGnl3ntVKCb6JgEzboti4ffGcGMzykjz7qLV/WGAgfk+8BM9m
	oubzdfi6VznZmK47yoCpyLfKi5bvDV0CcLO02xlslmZokBV6zUg2nCC8nC/6K4tDXMJhXK1k+cm
	bTH45LfEjmM3NAMa1aWBnVohNA89HzzhS4AnEfyjM6l8G45ecrEkfzbe03XIv73I5x3kVnaILqT
	ycPTFuykTA31LvIhTE7N3QwKNx0xnwZp2iIYSyQGUqeMWZJZUrRqODE3SQNfuNAoKLhR0fknEOB
	D9xKhunmGTcgWy9UoMsE3P
X-Google-Smtp-Source: AGHT+IE+psC8z15GVa3oHi2F+QR2LMkjF5EKHH5KmGlaPqC8d8vhVmOfdZKXN1XQARms7DGsXTBFDw==
X-Received: by 2002:a17:907:944f:b0:b34:985c:a503 with SMTP id a640c23a62f3a-b46e4792647mr400724466b.35.1759331827230;
        Wed, 01 Oct 2025 08:17:07 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm692507366b.77.2025.10.01.08.17.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3b27b50090so11566b.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 08:17:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtshwfE6X3mtwN+ougFTi18AqaoscBzMSkOWJdPy10tbh3RzG1fWvZIcxIxXrk93xTYI70EDg=@vger.kernel.org
X-Received: by 2002:a17:907:a08a:b0:b0c:1701:bf77 with SMTP id
 a640c23a62f3a-b46e1951101mr469679966b.18.1759331824949; Wed, 01 Oct 2025
 08:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com> <aN0JVRynHxqKy4lw@krava>
In-Reply-To: <aN0JVRynHxqKy4lw@krava>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 08:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
X-Gm-Features: AS18NWCVZEu0EKX7iTlguIB8o3ke5c2XEXaIJTu7y5nDPGE83H1_P9z9kj4Br4A
Message-ID: <CAHk-=wj=JCe-4exEH=kJmhf4FfRmbhSqHxMiKiuhL5NWho_4hg@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, peterz@infradead.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 03:58, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> yes, either way will work fine, but perhaps the other way round to
> first optimize and then skip uprobe if needed is less confusing

Yes, thanks, that was how I felt looking at that resolution too.

> I ended up with changes below, should I send formal patches?

Please.

> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
>                 goto cleanup;
>  #endif
>
> -       alled = TRIGGER(1);
> +       called = TRIGGER(1);

Oops. That's me having fat-fingered things. Sorry.

I would have seen that silly mistake had I gotten the tests to build,
but as mentioned, there were multiple small issues that had unhelpful
error messages that I had given up.

              Linus

