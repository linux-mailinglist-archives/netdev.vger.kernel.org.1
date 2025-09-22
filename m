Return-Path: <netdev+bounces-225409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28560B937BF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B192E0C25
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEEB28D8E8;
	Mon, 22 Sep 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXk+Kjyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C51DE2A7
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580267; cv=none; b=NcH4lAucogIKNw98JPUxVJwdmiXVeodfYOMx+XpxLDwhAuOsaFyil7uDKUEsxk4BtkB0quGeogLRUhe5opFiP9suBVvkZAmwyWPfGCx9/vUsOx8+53fDKvWdzhXygOyCkeypRZ9/TjnJGvZ5c7hk6h07DcouMRsg0rC25Ewlw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580267; c=relaxed/simple;
	bh=f0Pf+/Nz8S8Bgu/9V/G5zu53Iw6Z7pQM1xGQ4Qrv/rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLFf2u/Dv9iR5q5zpBeGbkiJdjPeFFo6FRxEs8uy695J4QLfipglvWtlnKLzGR8hS5ASUCKIhaFywKTpUeXqaFyYVWITZ0hCB5cb012BJgzBX9vm1dvm8Kd/Yx3qMJm0mh6AXsp7zkEJksaeQUxG5uZxYQabwFAubwOvkl5TBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXk+Kjyz; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso4775190276.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580264; x=1759185064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbtiN+WRaWrszvI4A9cJYkitcyxTdDcwVBjMTfPz09w=;
        b=nXk+KjyzxdB7ECI3DSN/XtsU/9bTQodwoFKlf3Hah+7J4pqKWNinspaLgiaV13h29K
         w6PIHpowizatZ3kMBcRq//R/lSfXZ4u/zPsmXUgBlg7VvxpNIUDXZBKkHnxNGf80+Zaw
         5hS345nwQKCSUScfLe+QfSVH1XBEGrCxtwYsmbia/AT8bjbt7UE6mpglPUgrnoBUjOP9
         zQ+lPMcueFsRtx3gLbgA0GogrzyASPRBjLm8EM6TVhqnuL1Vvzn8U4W5YruMfS50l8fU
         EY/Lkq5aPych8U7t2hWlwhDfCMA444Iz1wxh/DMNYr3gm3DK3bv/PF6VcjFxVnxRhEU2
         OPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580264; x=1759185064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbtiN+WRaWrszvI4A9cJYkitcyxTdDcwVBjMTfPz09w=;
        b=j9KPJMvhAasDZw7uQUVOhMVAnVX/vn5ZONK+ra7q0pP7wiQAyaKTghwjI35dUo8VBf
         ra62MbUh3DvRnDcF+z2Hh9EnQuY9ROCgpWfwW02cM+RupZI15bxLkU12gSUGYwhd/dfu
         pNhAZf0zzHhjD65iLPcrCzjR3bAtxuuLlxyJ1NH/ndbY1UsgSn+IKZQZDSatj8ePu1Am
         Qo3zfKA28xKJm4u1GNYqy6nS4no3N+CYUEaD+D5wUJxsrUkUmpSAnibpEdQOIMFELGEx
         apDlzsSKJkWLZPF0NMvYdXCZXHpU8h78mBvWyoMAvBrzHlAh7K8TzWyb4mFxj94glUyA
         n65A==
X-Forwarded-Encrypted: i=1; AJvYcCXHoRcVFrfcm4McAKWF0ZG0958GT7Z4hwUbxJp8y9lwHoyt+mtbckDEfvzzVaw25EZuhVeCzGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL1rPqn7tDcxtJWtOXn/+82cQ7vNeObjbkJFKXjsApF6Ddgou
	WneFkgxursl/TIFKGmwggGWLKVWFS3aqN+/xIH8AWRJIqOJCFhOX0QgvJSCMFrJr5A1APraterW
	d0P6gN6N8Lsoh44jTLBW/1aBUoriZ9sw=
X-Gm-Gg: ASbGnct/SEbnstGEiaYqp8Z4ICvs77UDKnm+NvZ9rPJmiGb2W6Kr9/pb52D9LGKxqjs
	nzt++CU2fuj49tjMoHzJ54fkHp+PWLD5Z9OUt0RKzyRUhM49POvMZMUDzz2K8Vx8591M7JTggiW
	TXr6nTO6lUdjo8vBuYacglIKT6hE0npRXmaPM85VVXQxJG6zctZO+72qLFtpBzO0inWcVR9STGM
	52YYfhlcF+AeMXou9nFLE4=
X-Google-Smtp-Source: AGHT+IFdH1w+ZNyAYLaHh3rhpX284bCYkkpquZUVSDR4yfWiQ2pvfmbptj19EIZR1rn5jw+Ke1XbuMsRmKdrWNNs1DU=
X-Received: by 2002:a05:690c:6108:b0:730:72a:7991 with SMTP id
 00721157ae682-75891e0901dmr3078527b3.4.1758580264279; Mon, 22 Sep 2025
 15:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919230952.3628709-1-ameryhung@gmail.com> <20250919230952.3628709-6-ameryhung@gmail.com>
 <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev> <CAMB2axPU6Aoj6hfJcsS0W7CDL=bvAFLtPm2ZrsJef3w+aNoAXg@mail.gmail.com>
 <f870f375-f9a5-4c36-80df-8062ec3eddd3@linux.dev>
In-Reply-To: <f870f375-f9a5-4c36-80df-8062ec3eddd3@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 15:30:52 -0700
X-Gm-Features: AS18NWBHImg6Ly3imtzQWTz-SmTtiB9vYWNL_EUtmU52MWLBZC06W9_OT3aaWKI
Message-ID: <CAMB2axNNc0p6kXgNQjQs-jsZ-NkKR==hY6OtoU6mxdHy-YqbvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/22/25 12:48 PM, Amery Hung wrote:
> >>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> >>> index 4a862d605386..0cbd3b898c45 100644
> >>> --- a/net/bpf/test_run.c
> >>> +++ b/net/bpf/test_run.c
> >>> @@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *=
kattr, u32 user_size,
> >>>        void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in);
> >>>        void *data;
> >>>
> >>> -     if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - =
tailroom)
> >>> +     if (user_size > PAGE_SIZE - headroom - tailroom)
> >>>                return ERR_PTR(-EINVAL);
> >>>
> >>>        size =3D SKB_DATA_ALIGN(size);
> >>> @@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog=
, const union bpf_attr *kattr,
> >>>            kattr->test.cpu || kattr->test.batch_size)
> >>>                return -EINVAL;
> >>>
> >>> +     if (size < ETH_HLEN)
> >>> +             return -EINVAL;
> >>> +
> >>>        data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> >>>                             size, NET_SKB_PAD + NET_IP_ALIGN,
> >>>                             SKB_DATA_ALIGN(sizeof(struct skb_shared_i=
nfo)));
> >>> @@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *pr=
og, const union bpf_attr *kattr,
> >>
> >> I just noticed it. It still needs a "size < ETH_HLEN" test at the begi=
nning of
> >> test_run_xdp. At least the do_live mode should still needs to have ETH=
_HLEN bytes.
> >
> > Make sense. I will add the check for live mode.
>
> The earlier comment wasn't clear, my bad. no need to limit the ETH_HLEN t=
est to
> live mode only. multi-frags or not, kattr->test.data_size_in should not b=
e <
> ETH_HLEN.
>

Right. It seems the current size check is also off. It allows empty
xdp_buff as long as metadata is larger than ETH_HLEN.

>

