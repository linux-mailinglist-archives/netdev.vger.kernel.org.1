Return-Path: <netdev+bounces-84624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15865897A2F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8168EB25783
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FF156657;
	Wed,  3 Apr 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WorHCMwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CA155A59;
	Wed,  3 Apr 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176779; cv=none; b=DvnR0jCyeSr9C7gOL3NVB32pLrKdXhF69gocubZeAt2Z21N09u7287ZPk2tKCWgI8pajGUQg7ZZQEevAfouiJYH3kBxknEmXfcImNwupwq0BnthxOn11+7Z1LAwAyk8vNGEGY4Xg6e/Rnb3KdRrL/JWZnGNGwnUdtNEBilYjO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176779; c=relaxed/simple;
	bh=i333Dhp8hwrDT8umafLwzG1JBHjU5KHx9vR1MnRS9s4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AUWlB+p+bgA4qZhFp8I+sN9n1jUpr494T217V26z9k5zerENLRywiSvIJC0dnTf/sP1N82zXEDLmzY6f6HGFeI5lUgrlhIEY0A3VTyVNXi5NV3FGERiWDK3Kv2M4Jl4x9JQ9CLerQzkhkWoyUOAExbVZUyI5C3FQNrbH+hW8P30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WorHCMwr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a27ba3b1f3so153064a91.3;
        Wed, 03 Apr 2024 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176777; x=1712781577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i333Dhp8hwrDT8umafLwzG1JBHjU5KHx9vR1MnRS9s4=;
        b=WorHCMwrw1GmIFUAT/2Iboiy1avmgpx/6JdHu4QilNfWiezYMmTOspPRAg3yPB738A
         gfN3Sv4AVBCNLWiT1A5NTnjmrVTGETNjJiu2KDb6dh5s3RazuedAidHlmxQ6xFz1hibG
         cnH24e+wRec2gjcm1x/zbwrZ4tjRVIoy7uRE6Oa16S8/MuL7vgxicyQnyPjlNjKVEX2e
         MZEsF3QVvWSdbMb6118raPdd+yHsvV+WOjwe4h2pQ/pP4ZF1Fwwa871U/TpwrLur5SZD
         t+v7U6VYspPfnb7O6nrE+qcblq+etbEClJB0Hk3dAFIDXMZBYH5zR9XMknlKEg93+OvG
         RXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176777; x=1712781577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i333Dhp8hwrDT8umafLwzG1JBHjU5KHx9vR1MnRS9s4=;
        b=JXF9vHwmU6DhfdaGRpOG9mDjHCIAXCNwY/5JhTHlxCzIKu7WIA+2kak18ps0b/F9Rd
         88dPJaR4Z6jChqRdYMNxL8T1ed3xmyQkzTB23E6xp93PwzRRuLai4arJsLfWhQySdL+2
         lcBKTcSWi7tRc35LlR3AM8NkszEu+S0+DB0n0OKAFnN2DKGDIumdwQN936odZG/1DsF5
         zXq/Hd23svcHhf9v9B+ke1dNDLG/Is2qPZ3qdGDadkeJ9OtYgoTQ9OFJGDGTe4/kGZfX
         e2++vbziGmVZBuTFKGCIMppKxDPuVBrrIdy0dRRI8x7Ax/IuMq93Dhs5ywGmBUbbnhSR
         iV0w==
X-Forwarded-Encrypted: i=1; AJvYcCUWwwjOaKgYZp4CBnjqHIaBClVdGTeeZEsVoAwz10MA1k27yPtGxChlRXF/pSonTrc+530no+9kkVdPINhFOuNqHKl2i8VEDdbZUBxVpKdlBxNGmDmP3n/y9awR
X-Gm-Message-State: AOJu0YzFhaPPwBWjG4aF2Nb7tfdqehVqmkxU4zjMdl2y7/2nNS/fkAFx
	fpp8w3WKtV3Vs7opSDZZoKHpAs6NfFHzNPcJhJnSzAsdCbh3hdLz
X-Google-Smtp-Source: AGHT+IFG3GCAIdaoZ1d2VbXCvFNA9/5zeRvvPYodQX+ZYf7CZ5dXKh/vDbrAlRmZS0OmUCzmo9Cbeg==
X-Received: by 2002:a17:90b:1081:b0:29b:b5a4:c040 with SMTP id gj1-20020a17090b108100b0029bb5a4c040mr582680pjb.46.1712176776993;
        Wed, 03 Apr 2024 13:39:36 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id nk7-20020a17090b194700b002a253b251fasm123836pjb.30.2024.04.03.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:39:36 -0700 (PDT)
Date: Wed, 03 Apr 2024 13:39:35 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <660dbe87d8797_1cf6b2083c@john.notmuch>
In-Reply-To: <2746b1d9-2e1f-4e66-89ed-19949a189a92@intel.com>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
 <2746b1d9-2e1f-4e66-89ed-19949a189a92@intel.com>
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin wrote:
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Tue, 20 Feb 2024 22:03:39 +0100
> =

> > The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
> > each time it is called and uses that to allocate the frames used for =
the
> > XDP run. This works well if the syscall is used with a high repetitio=
ns
> > number, as it allows for efficient page recycling. However, if used w=
ith
> > a small number of repetitions, the overhead of creating and tearing d=
own
> > the page pool is significant, and can even lead to system stalls if t=
he
> > syscall is called in a tight loop.
> > =

> > Now that we have a persistent system page pool instance, it becomes
> > pretty straight forward to change the test_run code to use it. The on=
ly
> > wrinkle is that we can no longer rely on a custom page init callback
> > from page_pool itself; instead, we change the test_run code to write =
a
> > random cookie value to the beginning of the page as an indicator that=

> > the page has been initialised and can be re-used without copying the
> > initial data again.
> > =

> > The cookie is a random 128-bit value, which means the probability tha=
t
> > we will get accidental collisions (which would lead to recycling the
> > wrong page values and reading garbage) is on the order of 2^-128. Thi=
s
> > is in the "won't happen before the heat death of the universe" range,=
 so
> > this marking is safe for the intended usage.
> > =

> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> =

> Hey,
> =

> What's the status of this series, now that the window is open?
> =

> Thanks,
> Olek

Hi Toke,

I read the thread from top to bottom so seems someone else notices the
2^128 is unique numbers not the collision probability. Anywaays I'm still=

a bit confused, whats the use case here? Maybe I need to understand
what this XDP live frame mode is better?

Could another solution be to avoid calling BPF_TEST_RUN multiple times
in a row? Or perhaps have a BPF_SETUP_RUN that does the config and lets
BPF_TEST_RUN skip the page allocation? Another idea just have the first
run of BPF_TEST_RUN init a page pool and not destroy it.

Thanks,
John=

