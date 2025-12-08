Return-Path: <netdev+bounces-244021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25117CAD8B6
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D073019B73
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848523B61E;
	Mon,  8 Dec 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQFxLVLd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A561DFF0
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207067; cv=none; b=F9Dod2Nc6JxJVfWxtnM+CNgu2cB5TyxLi6qR2aYqlXb0SHT/MThA+tSHlsia6nZ5GDyVYVRaw+NROeamkuQJbgJuEroIoQgLc+MUQRvHLKihRsXBk0ccyFO14JDk5LSI+UivCMH0h1LFyxOp/38lIm2NP1GVHBN720use4LRv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207067; c=relaxed/simple;
	bh=izizD3VjgpVVdOW3BC8PfHRSOs6E0jjQfdGsV27pIiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD7fVisWh2YI2l7x+nGstcT1GFEuu056hm/ZHykm09GTuVEdu2Ia1QhB7poIWpAMecdzudXaokn8HTQdC4XEH+xlF9ktPDTJPSma+AtGbPT3zNInql7oUHXZH3vJh4IAN5a/kEp6i/DaJ3Y+UapRMYZ4Qyku6nJr0f0CueeBgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQFxLVLd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-880499b2bc7so43836396d6.3
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765207064; x=1765811864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izizD3VjgpVVdOW3BC8PfHRSOs6E0jjQfdGsV27pIiQ=;
        b=IQFxLVLd8SpFLKiPA5qnp4mMOCaKBmHil7Po/taDeabViEDKZrr7t0ouR6SIbPJbaw
         I5kZr6csOAYqcnYEGb5gqQVGcwluqIWkI3QX+SfzjGxG2bkDw4f71VSLw6DUBcI/2XvA
         94lRxA0agyK7ClbwCE/xSoZhQ6VzZcvMMBXmwCheO3HLhKsBinbGK7gBp+bRwlz/Odo7
         ixyVzIt3a66PH/gQXZriEo54Pz6h92Q0XiplxPIpxqKOa/LZ31/8zNkrctCX9HOVEdFx
         PpxhipyUs1A2g33G5ZIYHTz8G7IEGkVbGAWfN14o0XoKxfSjCpEO3jeRaJbNApUG1EWU
         l38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207064; x=1765811864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izizD3VjgpVVdOW3BC8PfHRSOs6E0jjQfdGsV27pIiQ=;
        b=nu9MFIeN2U8RnQDHvjor5r3tvY01Q6Ahcht1Leopur3NAFZUQFD+qkQLdIbzl9Br5a
         myaUfO/fnRgCJ2cW6+mxfR8dJlAs33FERX4LyYvMlE/y1Gn7HpkAf2tAhMr9wCFIHPWt
         CX+uM36Y8RPN2qvuEhOpdMB1RBq3Vs5OF/0AZiXP5obs/S6OMOfkfvf+14Y921OB64W0
         coUHnvnj2nBCXhG6wxKvHAzyceCwTixM0mvCvMxa59YRKjL7ZKdbGiFii9DKoMCpIXyR
         Tpi5D86ryt1dKrB4Bgh74rohN8Ua8uXYAI63uEiIwAwDBqb/nbrnsQq+lOh/PxijaV75
         PLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDkq1eL7KoTYDZnUe9Re7CUKhFUH+XBlmXfQKP5XTAD0bPHCUyjo7dE2K1KR7h2LWjSMKU9rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfnpuXaaD5LSxtKrPTk7eBP+EWsXDb4M3tWiz61mtWkegnXlm
	ckXL8d6eclRXNiRJXYtuK/eIEQMhqeFHWSrzPlQB3k2om2qac0+w+ysz/KNWyW0Hx/D1N3hRmBk
	dnqfdrHsZYP+qa7fN5AOs1jzs2L0glHT3mutH4ujK
X-Gm-Gg: ASbGncuB7HPj32V7Ha613NTW1LvaKl9j2UqbuksTsKnMGIyn7aMeqjBFcwq+iYfVBpm
	q91Xil9sJmErNj9Z4mRyRYGgR3UxgMkdE1LSkTQ4eerk9JXQ35t9RPca0zV/mnGJIVAYJxwnDMN
	8fhSFa1Fo5e0IeQbaJk44ws6SruQjvehFzATRG6ADnAePFN8qIgII8nkzhY9ObYD43kyP1Cm/BA
	PHiL/dtpqrwLET/tdCEuYFyK7Qy/c6D/wPtIG0//3i2cA0bd/xkFI1mfgiZXBMD87EUH+4=
X-Google-Smtp-Source: AGHT+IFS+w6QDxMLDyPgYwa89+TWhIuFIv1sv1yUhL3jFz9Ar5QN3KkcOF8P1l32aGce+lkI52/LTtQ94IwqUUmK3jo=
X-Received: by 2002:a05:622a:58c3:b0:4f0:2258:fe1e with SMTP id
 d75a77b69052e-4f03fde931bmr102885071cf.10.1765207064084; Mon, 08 Dec 2025
 07:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207010942.1672972-1-kuba@kernel.org> <20251207010942.1672972-4-kuba@kernel.org>
In-Reply-To: <20251207010942.1672972-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Dec 2025 07:17:33 -0800
X-Gm-Features: AQt7F2oX_UOv9MW-_6378FuuUImQnAfrJK7Esmwm2N09qzF03GjECuOURZmcBzU
Message-ID: <CANn89iJgoxOjGjhBAHeaCdcd3X9wzRoUg27e3TSY4X+SR0aBdQ@mail.gmail.com>
Subject: Re: [PATCH net 3/4] inet: frags: flush pending skbs in fqdir_pre_exit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 5:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We have been seeing occasional deadlocks on pernet_ops_rwsem since
> September in NIPA. The stuck task was usually modprobe (often loading
> a driver like ipvlan), trying to take the lock as a Writer.
> lockdep does not track readers for rwsems so the read wasn't obvious
> from the reports.
>
> On closer inspection the Reader holding the lock was conntrack looping
> forever in nf_conntrack_cleanup_net_list(). Based on past experience
> with occasional NIPA crashes I looked thru the tests which run before
> the crash and noticed that the crash follows ip_defrag.sh. An immediate
> red flag. Scouring thru (de)fragmentation queues reveals skbs sitting
> around, holding conntrack references.
>
> The problem is that since conntrack depends on nf_defrag_ipv6,
> nf_defrag_ipv6 will load first. Since nf_defrag_ipv6 loads first its
> netns exit hooks run _after_ conntrack's netns exit hook.
>
> Flush all fragment queue SKBs during fqdir_pre_exit() to release
> conntrack references before conntrack cleanup runs. Also flush
> the queues in timer expiry handlers when they discover fqdir->dead
> is set, in case packet sneaks in while we're running the pre_exit
> flush.
>
> The commit under Fixes is not exactly the culprit, but I think
> previously the timer firing would eventually unblock the spinning
> conntrack.
>
> Fixes: d5dd88794a13 ("inet: fix various use-after-free in defrags units")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

