Return-Path: <netdev+bounces-94239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A978BEB68
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DB21C204FA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460216D30B;
	Tue,  7 May 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3CODpBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B516C870
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105893; cv=none; b=T8a0PpW8RHmyMCszi+oO/mh/qZDiKpj8fWPtyRG9PLse5JXSdQJhnCMWGhw+VYBMLQKDXUOsYQCpY0iNZNRLF2PKPQNv5/OXCMGn/vnsLaWGNsBRTWoXt0t/Hs3jlWJOZ1JHiX3fqp/VD7e2B3F8nSVMwSbvrF95Fj4MpYsV6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105893; c=relaxed/simple;
	bh=UAD+USFELbp8ul+Ht1vR+uQKssV6QsZHA8kGTKhPpFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSv5LHfady7H95I8Y1YD+PF4DK8eFAf3ynGe0OpuWtcJuxnwx1xi07cVaspJkGaxtby/3hFw3IphPsz35GoVx0V2jVLun5EFvVZzF5tHL+TGKKez/W+jhBB498i4IhPIgWrptfd42BPuOwHDrX5N4fMpSkpRz5Fp6QhvSqyxjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3CODpBV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so57841a12.0
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715105890; x=1715710690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAD+USFELbp8ul+Ht1vR+uQKssV6QsZHA8kGTKhPpFo=;
        b=U3CODpBVVdEQM0EAdEYEa7byTsenAMsvGQMNgMWE5smpjOLVtYB7FOstpRx80vjsAY
         saM58lFf9Xm6wAa2sL6CM8nBwxh42jCyH7bHKDc5Pnlc9RSFvAOVxqeDfVJnHNcxcsE6
         O3qGoQ1zGTTQK6EZz/Y0TM1yE8mkJMa2AybNRLyWh3M5LUghD0TZfeg7zkvvQeTXsfqA
         lCooYpPMVGx7KBQNpDtiLxm0Jw9H34RKHpxYE6OD5OO56LHBr7LWk3Owr5RfcdW/Y5Yb
         gFGVUb7F+NrLVwPMCdW5Mjx9WO05VwZbKcsoUupLTew++baREvTBJqhlDhQ7gGZdSYq7
         I8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105890; x=1715710690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAD+USFELbp8ul+Ht1vR+uQKssV6QsZHA8kGTKhPpFo=;
        b=faQSN2FjOpvW4X5g90CRKOFznPwAtnY8nNpWCh1p2e0YbaJyZZyxbVa0D9jTqZqSuJ
         jnr8p1jk4hXP40m+EPy4cZdbqJtqXTTEwQ1WSCkB1I/lQ4ZyX01iRUMVLR1H9elboRh5
         /p99fkrFGgZaj8wDmmEExFkWB0a3oG/dsVlTs5NgtVcisy+hm+H6VKZ16rqErF8gt3oY
         a+GUE93m4hbOarnoq60Vxb0n5Zu7eyG3khJ5TGCh/Hh2KFDbhlvqBeGGALPuiARL+gSv
         IcZAgr2hG8unxNa40m40+0BGhUJIWca+K5JhCXRFRkkFZ/zUzDGrJwgJ50I0BVh4IW8e
         g7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVC4eP7XjPKdB9/Q8OxuYEzmoXYD3reBrxKFIF3NIf6rpTWpSJ42453/Maej81cHoQZ5dWTYqUFmmNrqRqKrVNV/TFpowR
X-Gm-Message-State: AOJu0YzzKS3FnloQ9faTWqXgh7wuP6+LAo1SjwTE2H80Mt7GSkuS3g0U
	mBFAMG4fE40/lwDxISC5W6qvWREPu+5BZpcsVCp/b+aM3DzGPTwC4ZpYnu6VUqmNGXZIzQp3eOa
	+0dZ2Tm9ZbP6K8EFY3uyExX+K3NVxfskGhXfu
X-Google-Smtp-Source: AGHT+IEyJbNJ212YZFLiysY7ZB2yvq8Sb/inANzZg6JwVfC2GCwQMNxHohhpneOcMG4HvnvOTiZXlyhBK91mXHpHyjI=
X-Received: by 2002:a17:906:a453:b0:a59:b87d:f81d with SMTP id
 a640c23a62f3a-a59fa8899a8mr46327566b.10.1715105889736; Tue, 07 May 2024
 11:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org> <20240506180632.2bfdc996@kernel.org>
In-Reply-To: <20240506180632.2bfdc996@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 May 2024 11:17:57 -0700
Message-ID: <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>, 
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 6:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:
> > Suggested topics based on recent netdev threads include
> > - devlink - extensions, shortcomings, ...
> > - extension to memory pools
> > - new APIs for managing queues
> > - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
> > - fwctl - a proposal for direct firmware access
>
> Memory pools and queue API are more of stack features.
> Please leave them out of your fwctl session.
>
> Aren't people who are actually working on those things submitting
> talks or hosting better scoped discussions? It appears you haven't
> CCed any of them..
>

Me/Willem/Pavel/David/Shailend (I know, list is long xD), submitted a
Devem TCP + Io_uring joint talk. We don't know if we'll get accepted.
So far we plan to cover netmem + memory pools out of that list. We
didn't plan to cover queue-API yet because we didn't have it accepted
at talk submission time, but we just got it accepted so I was gonna
reach out anyway to see if folks would be OK to have it in our talk.

Any objection to having queue-API discussed as part of our talk? Or
add some of us to yours? I'm fine with whatever. Just thought it fits
well as part of this Devmem TCP + io_uring talk.

--=20
Thanks,
Mina

