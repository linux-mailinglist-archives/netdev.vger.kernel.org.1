Return-Path: <netdev+bounces-178283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BADA76529
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174B2188B2C3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1C1E260A;
	Mon, 31 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdKnZb6z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB771E231D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421679; cv=none; b=P1EVjAl5Kb0FUR6n9jnbO26BGmDJzBlApyZ3XMoI7PKMkz7XwqSIH+/wy0FPsClsgrd0SZ2B+FVTvbRCbvDId5kGJLcfCwcojS1McNuxhd2PqNDO3fRJMnJomDyQUPw/3Zy5YchMxQ4uVjzy1NrLerAa2gWgVCjNWL/cLSUbSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421679; c=relaxed/simple;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/1kvINIanb6gXU8eYI4aV6YRH538JNDUD9V9M0iOfbZ8/FPqCmz/m2Rs/kdUHqRHB668b/LGqOKFgNmO2pqWoIHLZ3ENJ6ka27MNgYinIuCq4+sCEPNC74+bhrhL3ZiW/uFtPrmf6YhFiH+gpNmrFSVJNraaVDdcnlmNft/9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdKnZb6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743421676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
	b=EdKnZb6zkUKjBIu+rJcTmCga2IeX5wB9MnZM60mRPZJ93+wvEDa2EjeKspOP6qXu+HdMPs
	yVAlmrMZGUSqKJ5p6KW6p/aVqkhL8bp3Ibjb5PMbr0DDhoHr6kwKZDWMIK+o9A0JkB7/Bx
	HhDQAiqkyAmGBvpFf1ue2kxDwnQ5jxY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-IUcF6mXFMXeTlBgIRms6BQ-1; Mon, 31 Mar 2025 07:47:55 -0400
X-MC-Unique: IUcF6mXFMXeTlBgIRms6BQ-1
X-Mimecast-MFC-AGG-ID: IUcF6mXFMXeTlBgIRms6BQ_1743421674
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5c76fd898so3524351a12.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421674; x=1744026474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pArKK9G7xodDbemAOrxPr3k38aDwYAqpgkxAXEAWrXM=;
        b=LfaoqrO1linRsJJii8PDV2dq9DzaT8TqD/CsPEHyZ3rAdFZY6khPhNnTCPsmxMIvDb
         dGRMl/lN7N2Pll58Nlk21pEkdA/jtbL3tBStL44G2mzM97/Mg8Vde6zacZCZo7A1LLfy
         n4k+JUbUoPqHMsVm9/zoSVAdf2jeTLQsBjABb41boxQagjjGIW6wtzmSIOzZdZ2+7UK7
         7/UpNEN12Gii+90E6gU8ovUEEWXinn4kkZ5ulfU1XN2VQYD8m4rT4bRN/uEmnnTuvVt1
         6WuPOfrAEj0ZEVt5zHosZ98Ic+a2NcZD4hqDph/yNeij/IUTpQw/Pjb02xilQbR/PVax
         nHQg==
X-Forwarded-Encrypted: i=1; AJvYcCU1MAq22kNDK6IZUFF2ucHKPigssUYtIUihn2HccOYxI/jmiLtCbZCiLTaI4KT0f4jaoIc6yjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0wbV9cq7J0nbPiPs0Gua9I2RrVJhDicsVZOtz4nvLViEB61A
	zdB9XUcCDD+bPyWCAxvCN8GikH7lD7bTMlMiRBl3HMoWCmTT1iwe/JKHoR6eHEWYTuqXaOt21RU
	SMTd4O588d4Q8Dl0uq0wSgOE/RK64exm+B4mHejchoTLIYoYx/GCxss4/1XGhDvcA70XzgeJtJP
	CmL9S+ph2hx8YxykVo5YaWLy4RN608
X-Gm-Gg: ASbGncv6QwGjo9dreBiKybvKYWLkuwv8QPVzbwybVmhw2zJi77eKPSrNZHf/5uH3mCv
	lnJOYnKaHPzvXO4vMMIncTxX8/sat1qbx6jpqJOzp/iM9g5/e0SgX87SwGXsGUPAj/E5MwcJbJQ
	==
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id a640c23a62f3a-ac738a374efmr776690066b.25.1743421674172;
        Mon, 31 Mar 2025 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRmb2sP6u1Kcqc9voC0cuFc8cG9X4wanJkzT5G0J8qfH5D6leVLiwsM+zFjfRL7h+LKaFEAz4OgYXd5DAAjI4=
X-Received: by 2002:a17:907:7e88:b0:abf:4b6e:e107 with SMTP id
 a640c23a62f3a-ac738a374efmr776685266b.25.1743421673726; Mon, 31 Mar 2025
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327134122.399874-1-jiayuan.chen@linux.dev>
 <67e5be3c65de3_10636329488@willemb.c.googlers.com.notmuch>
 <17a3bc7273fac6a2e647a6864212510b37b96ab2@linux.dev> <20250328043941.085de23b@kernel.org>
In-Reply-To: <20250328043941.085de23b@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 19:47:16 +0800
X-Gm-Features: AQ5f1JpaEdK08-KL1Gf8Ek3oojs8QnopOUqDVrhQ8D9XsTzqJ71WtMtHpHShaOE
Message-ID: <CAPpAL=y2ysE6jJgVYAOOx9DQXOYkR627LF1nusb2-Jwx6gXR8A@mail.gmail.com>
Subject: Re: [PATCH net v1] net: Fix tuntap uninitialized value
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, bpf@vger.kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch with virtio-net regression tests, everything works fin=
e.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Mar 28, 2025 at 7:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 28 Mar 2025 09:15:53 +0000 Jiayuan Chen wrote:
> > I'm wondering if we can directly perform a memset in bpf_xdp_adjust_hea=
d
> > when users execute an expand header (offset < 0).
>
> Same situation happens in bpf_xdp_adjust_meta(), but I'm pretty
> sure this was discussed and considered too high cost for XDP.
> Could you find the old discussions and double check the arguments
> made back then? Opinions may have changed but let's make sure we're
> not missing anything. And performance numbers would be good to have
> since the main reason this isn't done today was perf.
>


