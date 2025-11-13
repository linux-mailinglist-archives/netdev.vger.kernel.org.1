Return-Path: <netdev+bounces-238423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F04C58BD5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA44EE9AD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F72FB993;
	Thu, 13 Nov 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeqJwZrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6102F28F1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049043; cv=none; b=f+tsHP06Y5wE+zYXeifCsWjfNn5vrAz5xE476BW26r6NL9d18ZO/WTcwCKFWq9LPJsofb0dY5He3+Y75+1k0O70XTYBHWMirRWmpZaWYAgAZN/IFLfLQZXsbvLhbx/D3Fx2jh9Q0lGGJ+cEJNF4XSSywTdr+qD0+RWkKO8krXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049043; c=relaxed/simple;
	bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceGMgyVfsinElVvZTK/BIUAVBnw/ncEbPfoqrwvA1pMQJZ70IyMRx7V09ha4xcYaxvvGjqa7tSUThJcgoXDSdzvHtHRrP5VY9h2d2t45j/W1GIlBg9lW/TzV2ESrtg3ZQ55sCiZM7z/IOFxtNl+0NWysYBTXSOgG6fhwARGEYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeqJwZrD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edb166b4e3so7818241cf.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763049041; x=1763653841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
        b=EeqJwZrDX4SeCiOY3OvCZyuKTaIBqhtMvRrhU87xemKUaOPFBVpP4gg787x60VG7Z3
         OC1UjAAnz9CIxey1yHCt2aoqcA3W5Vo6IyfdFdGKtiVfposu9ksUpVeidLb4tutqDoX9
         /l+XkgXSJYHbhqk+N6gc08qBp/1pr+yGhYRDe54bmCdiVC2fsbHKTnyqE85Q2P2EeFix
         kZCUOUYIEnVG5YTxQ8jkTLTNokATba7v4RYR0J4hZy7JmPU/Ksu9eFF1DiT67dvuv1tK
         RhDljY4YMOyXBxE9SyACGcmAMm2tAAJR5U7pN/PQ3FetXRJV6rXXXncZpfmBnbN66HRR
         lZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049041; x=1763653841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pfjqk60b3THr6aC7BPzuk/TyhyVleC13UqlztnSEPLE=;
        b=FocKHKqjJXpmGemds5e4nzUa2sRWrzbE8fVFXJivhEVzucqzTLBX7pUfbg71QPoVAl
         aMjoCdaafu00+YJC/s6oY7Bmq1SErD0XXBXELIE18cKL8eAvTKgMsf572tYDVBum8uvy
         e5cMQwMo0iD4fkekuT4oG99+pQ3Ck09IOQlI8VAqDaNu0Kz60D1WTTrxGX/QzQ4eQ5Z+
         3vmD329430vmZrmyRL94sTtdWsSOneNjAnz8uQIhUXglgOmCKS1dr9wuRGSkhxxxQvWu
         +KXSYE2r+eZcVs2I3WtDXj9ixnLJURYVJIuLNQx/7+QxUN7YPTTUDUxhgKL/YQkHpi8I
         o10Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8meq+7cjQjqCIx5w+vgwInXXWJi0uzWyU7/7tj9VBrf96seXKmCY3NgSu8tzCxdthKQq35Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYfrV25RqjjOomGYns//4vHVb1BVNLcSzHSJLnTRetGrEY4IV
	S8WBH+N5J8kSxW6ThtYc3VDyzQDEs5WNEedtjEsayKxuDBsk3HAD/h8H0c2HaLvOMMdFoXelpiy
	1MFiqzpJd6wnjXlpWxEUDgRWYRfaylFlyUSXyqy86
X-Gm-Gg: ASbGncsdRrRdR/Aj3vc5hWbfv0HZKYBZSzbsy3TAeF0V4McA/DQvc+DFwwsrHITnOcU
	QbRSaPk1pywxrAr5BMM8hI9Ta3/gX+iN+Vddoi2vsrDQGUWWPwR5KKv5Df3FfEL72xARPvsFi4a
	zukionJHTO+eNMzEXQhAQ559Pt7pQLkC79Uu0oeh3xTrsD13W49nK7LbLYTPFGFEoJUJMpcCjlO
	roWgaJE+SoLGKjAt+CCR4HVK6IKOEQEqqJ2a6m58AVOoMl4cDUt8vEmKr+FMQj7Xu8vhJA9k5Ci
	6mqnpdQ=
X-Google-Smtp-Source: AGHT+IGMjRUoY7nRKeINhOpAWlxY1uOyXJ7f2kSGeOU78eFrpNzjxzKtA29ny45jesxZqVrnMlSBnu6gigSBq2AMGhA=
X-Received: by 2002:a05:622a:130a:b0:4eb:a439:5fe8 with SMTP id
 d75a77b69052e-4edf1f39a9fmr2200831cf.0.1763049040701; Thu, 13 Nov 2025
 07:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154605.23370-1-scott_mitchell@apple.com>
In-Reply-To: <20251113154605.23370-1-scott_mitchell@apple.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 07:50:28 -0800
X-Gm-Features: AWmQ_bltsOvb2svPtDoPMFYM_GmVTdMqw3ShE8mYyo_cbuU8uVm_vgFXojpGOdA
Message-ID: <CANn89iJ_b6hfj96Me-8AZN92W+cA52HpGcu81J0MNtzeahpfXg@mail.gmail.com>
Subject: Re: [PATCH v4] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:46=E2=80=AFAM Scott Mitchell <scott.k.mitch1@gmai=
l.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> The current implementation uses a linear list to find queued packets by
> ID when processing verdicts from userspace. With large queue depths and
> out-of-order verdicting, this O(n) lookup becomes a significant
> bottleneck, causing userspace verdict processing to dominate CPU time.
>
> Replace the linear search with a hash table for O(1) average-case
> packet lookup by ID. The hash table size is configurable via the new
> NFQA_CFG_HASH_SIZE netlink attribute (default 1024 buckets, matching
> NFQNL_QMAX_DEFAULT; max 131072). The size is normalized to a power of
> two to enable efficient bitwise masking instead of modulo operations.
> Unpatched kernels silently ignore the new attribute, maintaining
> backward compatibility.
>
> The existing list data structure is retained for operations requiring
> linear iteration (e.g. flush, device down events). Hot fields
> (queue_hash_mask, queue_hash pointer) are placed in the same cache line
> as the spinlock and packet counters for optimal memory access patterns.
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

Please wait ~24 hours between each version.

Documentation/process/maintainer-netdev.rst

Thank you.

