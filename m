Return-Path: <netdev+bounces-119272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39395507C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965251C21768
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933411C378A;
	Fri, 16 Aug 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrQibVGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115641AC8BE
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831581; cv=none; b=dTaOe92lm8uweXJDlTvi9DC73McXuWCRIfoSKVhA1nsc9ynTBFpUsikXUWjNwMCkDYD1y1NrUY/PyJkUHRaSWshZpbgZN5zm/lToFy2ryaSXSSZRThzzOkEPBXV2CEIDWyiAAVEzTirACHwZQFLJKthNNrthOkGQztZiHAu+mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831581; c=relaxed/simple;
	bh=BAkGv4BTL2i9YIh3NwpQqsz/OZhP2ZV84NiG/9N+zJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXAzDTOC90XhwigQGas92ha3cTdZVrREvoJmdPbWNGryBvg0btLPhG+zvzkeEkS++AYEEP7fidlm/nZFGOG3ArsSjWpH5kqilbKXAjLUNFP6P851KVdjvq+6+ewygSe9OxsMYzbCRGQZiDSFICpQREjwtLDr0ObYBQn7u11EynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrQibVGr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e11703f1368so2986295276.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723831579; x=1724436379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQMMCc0Ov2Snf2l0Tj49um7esv/76zOwTy43mPOxM=;
        b=IrQibVGrECI5KXTNARaWVbBgoZrwDRznggZoBLxxyB62bnuo4nPuLa8sDxUTmv9rIW
         z8jcQAitpCZP/lFsNAL4u5saJPxpNHiCxCjmjMG8aItkqDKLDrP/bKWzUL8W02zc/aIt
         uu8C5m5rEbYGN/dMih2Mib5pV7bh0BvTMhRzYmHrL1fw+z7dfY7D3shjspvqsyF6XiBw
         GdtP0cIKTZuMj0XJQ8eJSY+QKwZ8HZYKar0yepYkRX3G6qk0Lv2YvHT7hwJZmEZv5LGe
         ZT2/u5iNyB+VXnaVZs53momkLN94iSZfzBbTz6pvtyYk0M8B3PZ6Zz+k5W0h1nvG4P3n
         XFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831579; x=1724436379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQMMCc0Ov2Snf2l0Tj49um7esv/76zOwTy43mPOxM=;
        b=b8nTx2EVoBs0PXFTUXCLOE2265aUiGkEXLNeuRutuoGhVQN4wxRzZWNUBhcjjT3fR8
         4Tdx4nLkVyJM74qHJXdsWzI8wWIQ2/RUWlGuIvoitGrOkPpR42s3Wmh0+ncymlqrNQ/F
         ibaqT/u8bdg1aTEqx32jRMteo4mVhXati+0f692GjxcirmqRJ3Okv9w7LZ6bjNOZV5yU
         rRHM8yZJdI5ZZq2i4+BJh6Rv7GsHfPNmMwlHDmbTNz58HVAMobIt8CfFw4W4iR/QgSCU
         ZA2EfLdVAtzXcuNuFiP+bf4a1CKJI1GXr0qnWPW6vNkSpsvZvaReUZdjo4fuu259JnS1
         xQAg==
X-Forwarded-Encrypted: i=1; AJvYcCVkAEQS0N0TParulMiSzOgPHGMmHDA+OguyuEBN9keq8FdLoDne0mUOuegPGGRJvwkOG9BR00yJA21dqqedf80CKMEBW8pB
X-Gm-Message-State: AOJu0Yy7aPtDKu9NIgwBUfJtu4ZYIMteVBEfvBIFF41MC9qyxS3OyMTB
	5e2FGJyEoSP6koA02LBPXGNf7e0cDZeGCMAzt9CxNuf8gJ1wLb1CVXWKZzGAGjuqbsIKjGxGpBv
	pcg==
X-Google-Smtp-Source: AGHT+IEdNFeoKk4+WTl7rW1Wn4ZVfgiEMGusR3d/zsIkeQp8Z52WLAOPOy/a12Umw36tOHJ8DGZr9uL/nNE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ef4b:0:b0:e11:5a4a:b1a2 with SMTP id
 3f1490d57ef6-e1180e9eb93mr6271276.5.1723831579081; Fri, 16 Aug 2024 11:06:19
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:06:17 -0700
In-Reply-To: <00000000000074ff7b06199efd7b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <00000000000074ff7b06199efd7b@google.com>
Message-ID: <Zr-VGSRrn0PDafoF@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com

#syz unset kvm

