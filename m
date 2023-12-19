Return-Path: <netdev+bounces-58744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD28817F37
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79620285644
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C517F7;
	Tue, 19 Dec 2023 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEy4X/f5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A115AB
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c236624edso43731605e9.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702948643; x=1703553443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2d8n5veSwDKrjujjZS9oHRQwKzoLqynkBXf88Dby3fc=;
        b=EEy4X/f5X0wsZNCyurB/GSgHNDbneaC9y9bWf3Apg2T7aE1qk9TqHhVqcyLCX9VUqK
         9b/rVF3ARJ6WKoUR8FVkI9jC7BWnbxkJEWa2P+kJZwQFHhIS2vAz5iDr6K3OpQsRZ7r0
         /A2KzkSirrhJO4hPfwtdvnfyAeM4vtLeQ+4QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948643; x=1703553443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d8n5veSwDKrjujjZS9oHRQwKzoLqynkBXf88Dby3fc=;
        b=Sxsv7nVjaEpQyth850zocpfZcW/nMw5asHefVgyQgSD4Pm3BgY90M4ASEyPNsQdItx
         mX08N8hMaQBWrPH3+GU2j3FNH0+G3KsQz/aC8AUZxLBzHcCGGSdNYclMfax+9FC/z6S0
         mbP3LHySFc62Z14uxP/Mx6074GlCyK9FcGuemDGfCVBAdB5laFhSH/wU6xabie9mg6Wm
         4ohdUqA+jqtQqf9KcO0AgkKkl9MGRtk+rLDtSdDLFX4S1FrvRZdg0rbe/jesQw9eJkd1
         Ec9yI/P4FjVH8CI/+0vkHxDSBg6IYx8fw9RWrHwlX0MPRnMvFFl1cKX45J/cIXnbSgeV
         J7RQ==
X-Gm-Message-State: AOJu0YxhyahLj9Fx/wGmcot+ux3Rv3CC6ot6zvf5dwR88XG0SR+x1lhS
	pVYm72k0Ba1h+O0sIWPmMJBwqwDq1wQHv3Lkt2r5Ow==
X-Google-Smtp-Source: AGHT+IE90s94xbfL+/0wAA5MT/aLpZxEtlJf8vSEuM0+SaiG261KWeAmDEcQNASwmijrlXrj2LHWNw==
X-Received: by 2002:a05:600c:2147:b0:409:247b:b0ae with SMTP id v7-20020a05600c214700b00409247bb0aemr9794079wml.36.1702948643455;
        Mon, 18 Dec 2023 17:17:23 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id vi7-20020a170907d40700b00a1dc7e789fbsm14649076ejc.21.2023.12.18.17.17.22
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:17:22 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so2341322a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 17:17:22 -0800 (PST)
X-Received: by 2002:a17:907:7d8c:b0:a19:a19b:55ef with SMTP id
 oz12-20020a1709077d8c00b00a19a19b55efmr9119435ejc.127.1702948641815; Mon, 18
 Dec 2023 17:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com> <20231218165513.24717ec1@kernel.org>
In-Reply-To: <20231218165513.24717ec1@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:17:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBBWGaQy=rtS2Ma6QPqbQ+jEUKUWfF2zS7gDXpim11bA@mail.gmail.com>
Message-ID: <CAHk-=whBBWGaQy=rtS2Ma6QPqbQ+jEUKUWfF2zS7gDXpim11bA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	peterz@infradead.org, brauner@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 16:55, Jakub Kicinski <kuba@kernel.org> wrote:
>
> LGTM, but what do I know about file systems.. Adding LKML to the CC
> list, if anyone has any late comments on the BPF token come forward
> now, petty please?

See my crossed email reply.

The file descriptor handling is FUNDAMENTALLY wrong. The first time
that happened, we chalked it up to a mistake. Now it's something
worse.

Please don't pull until at least that part is fixed.

I tried to review the token patches, but honestly, I got to that part
and I just gave up.

We had this whole discussion more than 6 months ago:

  https://lore.kernel.org/all/20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner/

and I really thought the bpf people had *understood* they their
special use of "fd == 0" was wrong.

But it seems that they never did. Once is a mistake. Twice is a
choice. And the bpf people have chosen insanity.

               Linus

