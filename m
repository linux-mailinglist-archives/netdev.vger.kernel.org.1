Return-Path: <netdev+bounces-217087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4430AB37543
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C31BA1C00
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A672FDC5D;
	Tue, 26 Aug 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lbifus4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D02FD7AA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249819; cv=none; b=PtobzqIXSvmkwckRXrVm19kpso5miV7Fzb0l0G/aOnB1uLBMTJGO8tnJqLepyDXZa72UpIZ4EfjNoc+eUqZhOPosTpvdk8e8fEqx2P84a403i0n3AQG14lT6M6RaAXgbGNq6kzr8p6HXgRx06abKjgc2DsaqKlM5h/oufQXlqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249819; c=relaxed/simple;
	bh=HzHR1FIpZ+Ah0OX76qvjupuPRN2VYosMVQ84TKC+cRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO3m31mckmifk9/T96V9OY1mfU17j8J2WUGkBQA3xcivFbSlQDVQC8Iphj+RQHMw/cvWViXc0FdWRiJa/3RMi7ix9sEPcmiWeNPvKtUz5Uo8Xb8pkmIgXDoNF9zKv6R3v9AAnRQlTp90shuIUGiod5isKA1DqYz5kw5mbZmn3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lbifus4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458272c00so73016485ad.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756249817; x=1756854617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFHzS9Vz2qI33T641gBuN81YJ0ykJAgwplIKTWI5uc8=;
        b=3lbifus4lU2TGD3J3ffIv1JhCMwWka8tmJbSaYY3LB98V9I1g3GAlnkgmBoSsE3Rzs
         yFxigLVtvboW8Cq+XPF+HxQaZIQCxOjx00AYTqXAbhmiXTLKGuuy6yQCq6I1wTnnnbc4
         e19rdz5Efof1IZykT8xZFlGFQDuMY42LfG9+ZpC887hMbIZDrpKojJ87boO67zn608WE
         Wd3o/qbOyx12Ro/8oaVrprQHdcnF4rCA1QDEsfW+nviE1lU9Dq5em9/SC3G0mvyA7KkW
         DCC8pUuwoOQN0AKPbe/MUka8zEmuHlVMqJjVbA/bbVrotrw4/Z7wCSh4dr2o1Hpb7hN+
         UUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756249817; x=1756854617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFHzS9Vz2qI33T641gBuN81YJ0ykJAgwplIKTWI5uc8=;
        b=iaKRVsH+6TVugPj5bCQP0+e60ys8IJCsMbs9HTYwdwc3CkCmok2s8HTBIU9XJJ10Oo
         OuWjiOBh9fy/C74Ls77+Ce8Vs5K7PQTm3ZEj2sZQ6APEGMvru/Wq6d/NGgK2WfMQruuS
         54OKPuw3JQG8gfWAUyXVBV3oU6lVhIkjiqonMl4MAZzP/uZ6v8OMD57OKpIo2VmXm1Vb
         KhKRtca/6wuL/pFKezBzHJXcnfj+/xr+HkblxpCdB40wRU2LqlbRznvv5OQR/HvIq2yZ
         pm/l6A+TLWn5FcqHufrnrwKmkKiwUABRpQuplO4plz3AEcylGq1OcRuhlui6IaCMm6FW
         CGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW347Iz731opjOzVZc9Nl5fOfMdZHNC7Ce6zktO77Lg0dUwcjcqBs4Z2tUpOrt3n1lTDsRyIDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAYdUD8uZ2tnjFq/3OAspvoDZYFVxGGlRpCdwMT1GkWSYQzg4
	QAvqkWzz3rLU6XHFiaNOOrhylAmzI2xRLut2dFfmEm62YWTKTOtMEEy+pPQCKZtqt1KIowARM5T
	Jwj7rhPjrU4aD4mSIZY1jMrpfh0FlmBsTI+jVLkIb
X-Gm-Gg: ASbGncsy8p2BdI5alHTtwuKtenzkg7ArRnBXagNyn44rEwoA+C2qicJjvx4y8h4jB+W
	gddxGOZx6+9fIQxJPixfCmtbTg5+mfMrbyxOEZ0BHNC2IER2qTlLtDrMVWq4svS7gNz71HPjqjo
	rmuGJTcw17b0wyw7vMltnoMyMXrhNp+tkVoZiuoIT38cIq8Sw8hO+/1NvsG6BVa7iRRn8TZhN8x
	bEjSSjGCZIv52c+O5jIWkp74kvLf3nd8Rm2di4x3GmPZm/Eyvsp6U3cQQvqqg3eY8XD1QA9Vdo=
X-Google-Smtp-Source: AGHT+IGn57sOU6swdYsx/QCrjhxq0MqZLxuckGMve65sULjrNihbiqrOdTIv5dqJ+0z/cHjZlaY5GmZUPCfXi3CBib8=
X-Received: by 2002:a17:903:19e7:b0:246:688c:7f64 with SMTP id
 d9443c01a7336-246688c832fmr177995805ad.41.1756249816687; Tue, 26 Aug 2025
 16:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
 <20250826002410.2608702-1-kuniyu@google.com> <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
 <CAAVpQUC-5r+nbB=Uhio0WOEDV7dMcuUM-tF=auAV_rvAWH5s0g@mail.gmail.com> <93ddc9c9-e087-4a8d-a76c-8a081cf3f1ac@linux.dev>
In-Reply-To: <93ddc9c9-e087-4a8d-a76c-8a081cf3f1ac@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 16:10:05 -0700
X-Gm-Features: Ac12FXzqS7J_KCoPi7cmkEec0GJrW4e6XliBpPlO8EvOCw7H9usNDhXkpymiyVk
Message-ID: <CAAVpQUB18FOE3iJWt4kAUexEb9ND9An2xn=0Qz=5W6YeWGgi9Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com, 
	kuba@kernel.org, kuni1840@gmail.com, mhocko@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:02=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 2:08 PM, Kuniyuki Iwashima wrote:
> >> ... need a way to disallow this SK_BPF_MEMCG_SOCK_ISOLATED bit being c=
hanged
> >> once the socket fd is visible to the user. The current approach is to =
use the
> >> observation in the owned_by_user and sk->sk_socket in the create and a=
ccept
> >> hook. [ unrelated, I am not sure about the owned_by_user check conside=
ring
> >> sol_socket_sockopt can be called from bh ].
> >
> > [ my expectation was bh checks sock_owned_by_user() before
> >    processing packets and entering where bpf_setsockopt() can
> >    be called ]
>
> hmm... so if a bpf prog is run in bh, owned_by_user should be false and t=
he bh
> bpf prog can continue to do the bpf_setsockopt(SK_BPF_MEMCG_FLAGS). I was
> looking at this comment in v1 and v2, "Don't allow once sk has been publi=
shed to
> userspace.". Regardless, it seems that v3 allows other bpf hooks to do th=
e
> bpf_setsockopt(SK_BPF_MEMCG_FLAGS)?, so not sure if this point is still r=
elevant.

In v3, it's nuanced to limit hooks with sk->sk_memcg
to unlocked hooks, socket(2), but if there is unlocked place
with non-NULL sk_memcg in _bh context, we will sill need to
use setsockopt_proto.

sk_clone_lock() and reuseport_migrate_sock() in inet_csk_listen_stop()
are the only places where we don't check sock_owned_by_user().

sk_clone_lock ()'s path is fine as sk_memcg is NULL until accept(),
and sk_reuseport_func_proto() doesn't allow setsockopt() for now
(error-prone to future changes), but I may be missing something.

