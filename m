Return-Path: <netdev+bounces-238434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F2C58C65
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8139358F8D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865313590CE;
	Thu, 13 Nov 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Hxzr9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBB355038
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050736; cv=none; b=lZ9JRyzv+H4BhDtEjcAxpu1bap1LeFYRCv3x+vpEDlG0OSZ2ht49k8PLqabqMYT4HdoN/KwlxY68AYuibVSZwW8TUzZWL1hBo3Mc+wwAhtLVu+/hm7Q5VMHVC6Zdu2kAoFsvOLb4CwcdCXBXepCexKTXLc2hhBkBixkZiuzg+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050736; c=relaxed/simple;
	bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoQWzbDOW7Ah3MKlaMYLWNJOb+aghApQzJeOwISkmHx1Hh01x9QIK0uDqUlYqVmUUTgSBFTbFoyYvPqExEWz4UXk6qQxxOzUYdcgyBVR2r6WBtn59OqSffe6IlZRN9U1KO9iIKfK/u6dXgVoH3SrQuLaJsXGWOFnIneI3WqWMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Hxzr9d; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-559836d04f6so674133e0c.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050734; x=1763655534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
        b=g2Hxzr9d1+BSv+THQ6Mf2zWVTLYFPfNC0n+CgAzWx4ljQRadWCZssG7VITcPJ/hdwb
         SfhWo508HygUpzjAoiUc3a1ooLqcasT5utH2z3Dp6muTbYmHa9N6WFd7rZJovYMtDlQu
         g6xMxN/o7TBprchv4nFV6515aowPDnqKV9QFHMDiwZwssURu7zQzhqAPPjRV8+HA0q2B
         B/frdEHcLxNCM5LYGwqqzLXv4qBD+dwRoFvmsfrE5HdrL4VKtDUlW/YETWvG1Dc+Obai
         WE+WCgAAGHYKbBbzsFnRh70tvOoQymvEr181iJFSPQCmhdcV8fYObR/3RdxhIB/A3ogg
         FhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050734; x=1763655534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+jglSuIcAqBj4r2Yvzejgtem7Zuj3d3HuPiUn8D4x4=;
        b=Zddb/yYER9KElV18tCnbAzH1C+wWlJEH4Q+r7FMzg8ST3GNJ6P02cJGWlZTqeVnYgZ
         nEYGhSF4iVrsd8a09K8MyzWCmwlLCPCQPO0wQz5lwl+BauBRFdRupUlPNfjT9PBWVPwR
         dIN2pCf2ljAhiJqjDlFC8YEMRDYASLq9wgdHL9jZ4dTy8NI58Fo6s2qWPq0g0e0gZbL/
         5WNT1JRQxG0pxoJA3T2QtsFTbzTUbPd0o7hs1irpx8J79XD2zFsVTAEknt+yQQe3SC9k
         8UUFxHeZpIzU5EtNzlwf8X21enkYKmRPBQqrYsFUaJ/Kw600sP6XEq0ZiHdD+RC0FXR8
         gg6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrwkCnobzBqfF8o+cMXnCFuwabfV1E+Xc3ZN0lj8ks18X1c4p3fbN5DIAgJeqcyoqtPSek7ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUWySOdeYQhgDYwxcbPwbbZtPz4ITz3LLZhIK8Bps8zPvq8fF
	nbGw2vhzzrE6E6ft0LdL+wX5+9ebngeodC3IOD0bC4XdU0BsO9Ha3FNHSJG8sp/wjpEeuLpNZmC
	DCJQpvmEHZdqttQlbtpkcPxvRg/yE5YI=
X-Gm-Gg: ASbGncu+1S9uFiFyx41vyE/CXpwZURspUH8LC6mSH8bH54uozV0nkLBfnkh4MGjTKPM
	6Y45aiIsCxfxAg9UfFP56V2Ee2I1eXNm5Qs/AxtvkDyWFHQsVm/9poIV4Uc0yApOFRZkvnnG9Gh
	UrsIZyrVk1oDQD4PXS5PSOm2QXPt3rFGRgB2fdFrLRxvyylxFqV0bjfw4rnDH/Sq21Y8TIgWU9Z
	GTetC/MZbnapwaYeSDKtA98vt30CtvXTiAuHhaQZEmrvqLh/EuL6WKAbHmsL2g=
X-Google-Smtp-Source: AGHT+IHQlvloEzjKkY5BkMvD2gAnBdnRNb1amCMLvHF1Utj0ORHdSRDHFy5DC5NLvgH60/r/vrHA1AW5hpH3I+XpRwc=
X-Received: by 2002:a05:6102:4487:b0:5dd:c3ec:b5b with SMTP id
 ada2fe7eead31-5dfc5b72883mr124216137.31.1763050733707; Thu, 13 Nov 2025
 08:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154605.23370-1-scott_mitchell@apple.com> <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
In-Reply-To: <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 08:18:42 -0800
X-Gm-Features: AWmQ_bnF1bGJN_bDR1NS8Ie2R0lRRCVzMsqRXHPobd7cBDwaINkzoduMtW9VB0s
Message-ID: <CAFn2buA+uHsRLU-TG9Xy42-pATex9Hh7kD4uCtcVRHAKVCgZow@mail.gmail.com>
Subject: Re: [PATCH v4] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 13, 2025 at 7:46=E2=80=AFAM Scott Mitchell <scott.k.mitch1@gm=
ail.com> wrote:
> >
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > The current implementation uses a linear list to find queued packets by
> > ID when processing verdicts from userspace. With large queue depths and
> > out-of-order verdicting, this O(n) lookup becomes a significant
> > bottleneck, causing userspace verdict processing to dominate CPU time.
> >
> > Replace the linear search with a hash table for O(1) average-case
> > packet lookup by ID. The hash table size is configurable via the new
> > NFQA_CFG_HASH_SIZE netlink attribute (default 1024 buckets, matching
> > NFQNL_QMAX_DEFAULT; max 131072). The size is normalized to a power of
> > two to enable efficient bitwise masking instead of modulo operations.
> > Unpatched kernels silently ignore the new attribute, maintaining
> > backward compatibility.
> >
> > The existing list data structure is retained for operations requiring
> > linear iteration (e.g. flush, device down events). Hot fields
> > (queue_hash_mask, queue_hash pointer) are placed in the same cache line
> > as the spinlock and packet counters for optimal memory access patterns.
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> Please wait ~24 hours between each version.
>
> Documentation/process/maintainer-netdev.rst
>
> Thank you.

ack. I will wait 24 hours to address Florian's comments on v3 (unless
instructed otherwise).

