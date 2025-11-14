Return-Path: <netdev+bounces-238787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBDC5F631
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D64184E11D8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736E2F0690;
	Fri, 14 Nov 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0w1qzZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788D2D190C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156293; cv=none; b=fu18e5QGNMZT0+7KP+u7x3lt3duUdHhDYo+kdg4KujGiJ4kK3HQOHr0uQhQ3KxZ7+2hQ63Pg/beyfzzwBPgoLviQaVw7sawH18en/bYv31vFq6Ne3+V5H6QIZIqDXG6N/uMAzras2tff/XBKjcnPAOZJ7p2o1XBhjvIw2BydWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156293; c=relaxed/simple;
	bh=NdC5qsF+daIwhv+jfvY4zcENzV+hiW0SWRKdXrzUDDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZKEQeiCXLRol8LvozH15hfvygsuByg00T3ITozYx8uBsJ8RcT5uDTIMtlo9odpeTzQF9Pn7YAAKtTJolXVaj1UbvyG81aLtI+uiXgS2jojAgVel6AoqMEOYg6Ifd6zOpuuVtx1KzTO9TFsf3glDTACP/UedhPThnS6QzpDw05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0w1qzZ6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1248402f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763156290; x=1763761090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AdOzp3Vu6NN0uDZN6wbKPsm+e3bm/G64aFJ2Czz/Dc=;
        b=Y0w1qzZ6IlxQlawgOU5uPcNW+qSEYGq/KcYSZKgMdHYozWsNQQ2Re6dTx9V67bURxh
         l0bPakAcvxyuyaLUfh6TsPF4D8f2yZ0EXSUprukx1c6oI0cOuWrOsgRltQuNpLAs7vkn
         UJfAOS7/pjceW7qpq+NEKsHAEPzAK7qyEIX/XpeFuBF2XGAhYoFweYfGrV8Yh02opHuJ
         h09ANC+HPQ8JRNVu9MHlYYYzanOQqUq6yQSppXWSXD8snwSnFEkZujJgqCpMJePplX+5
         zBso7EkKxyibBvPbIVPGVmni37f1hf93bh2duHi9MoKTlG+Z+NLk2xnetafht8MZUo99
         B6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763156290; x=1763761090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AdOzp3Vu6NN0uDZN6wbKPsm+e3bm/G64aFJ2Czz/Dc=;
        b=lIoqvVzdTrwVtxsR22yblJHDn+EG5imf3EPDtw5LkESS8ttAtuYj2AlGaKXwVBPCyn
         3MULfBmfmr5XApXYWv7udJjB98fB3UTiTBVxMKCcjYbS9gx5MVEyM7NYk3NNYMj0t3Aa
         E3UtsmxKcgdSZv9KGHn8VHeoTngJ90ZiEf2xWrJ3MbBeLprBRthoc6Vv6aGnjhc/TR0T
         rpN8BzITFjX6lSM9RIEYOqS4Rx69OxHYyp04KR7H50VlKLUvmBj+TMysOj3/udM5ybZS
         NhuDMOhr1Ro18S2cteQ5hzmsX0uX/F7botNTMdyNTFDQkjc4JmyavYc5ZurxjHOnvkKi
         jaAg==
X-Forwarded-Encrypted: i=1; AJvYcCWp0FZu7cd4nXeyZePA03JcNupcTl8aOBIV7+Z1ekl5T5K/FaOLmzE29OJ6pr0d4N6O20zG3KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJn5d5auxYHwzOSIMtet37UbbeNfNSnQqFPUSBOGUi/3CbwJOy
	AoFYdsF8hIvyhAM9EOoVw8nRgpkwwjVEHacoOmeLyg13u6FQ+7RQ+ar5
X-Gm-Gg: ASbGnctrShi4eXQUR1AtBF+5jsuket83kw2yyheFgbk0/HX8D88qc+7m8p+ERRXHOTH
	a8hZCQDf1/v8QvQZfoQr7HDqBRI156qX+p1piyc9mVeZvHIC7P8EvaLUv3oZI0Gb1zB/hh1Ph9S
	rq2Fxg78zbxOvQCmtff5/CICogPz4pyj7DW/qdkMGl9zPXCfUxNrWlXFSCMmEZ+9ep+Kp8TSxys
	j4eq4d7onDOv211u2eqONQq5hK1A/UzKbTbLh1iWixI94dNsC2rvcQfqjHLBERN5QpYKzBBA7UF
	NrDhPXJhA0aFRFbiu9t/EZbQ14EKhRL0MpgJnn1F781S9H5O5Svsc4OtFHp+vt+PU7iq7VltpM2
	tdzcRJol9EHjQvLmhd/jpnlAkB6JrbajjVW0nobYEY0mV43UIkH3sodSEab4tGNdZasVN4CTian
	Z372Z4AzeFKAdt8h3zsKGDHx+WQSw1aykXxTBI8r1Busb1lpzsml1PctRfRsjSQxc=
X-Google-Smtp-Source: AGHT+IF4RUaKrhCIq/a+CQuzQOczqQ1I8RVr8VKrQgygddIe/fx8JxhllhOhRwXR1khsOJv2FxFapw==
X-Received: by 2002:a5d:584a:0:b0:429:cfa3:5fde with SMTP id ffacd0b85a97d-42b527be676mr8873626f8f.11.1763156290271;
        Fri, 14 Nov 2025 13:38:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm12158736f8f.41.2025.11.14.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 13:38:10 -0800 (PST)
Date: Fri, 14 Nov 2025 21:38:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav
 Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114213808.252fc8eb@pumpkin>
In-Reply-To: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
	<CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
	<E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
	<CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
	<20251114190856.7e438d9d@pumpkin>
	<CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 12:48:52 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 14 Nov 2025 at 11:09, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > I think that is currently only x86-64?
> > There are patches in the pipeline for ppc.
> > I don't think I've seen anything for arm32 or arm64.  
> 
> Honestly, the fact that it's mainly true on x86-64 is simply because
> that's the only architecture that has cared enough.
> 
> Pretty much everybody else is affected by the exact same speculation
> bugs. Sometimes the speculation window might be so small that it
> doesn't matter, but in most cases it's just that the architecture is
> so irrelevant that it doesn't matter.
> 
> So no, this is not a "x86 only" issue. It might be a "only a couple of
> architectures have cared enough for it to have any practical impact".
> 
> End result: if some other architecture still has a __get_user() that
> is noticeably faster than get_user(), it's not an argument for keeping
> __get_user() - it's an argument that that architecture likely isn't
> very important.

I was really thinking it was a justification to get the 'address masking'
implemented for other architectures.

It wouldn't surprise me if some of the justifications for the 'guard page'
at the top of x86-64 userspace (like speculative execution across the
user-kernel boundary) aren't a more general problem.

So adding support to arm32, arm64, riscV and 32bit x86 might be reasonable.
What does that really leave? sparc, m68k?

At that point requiring a guard page for all architectures starts looking
reasonable, and the non 'address masking' user access checks can all be
thrown away.
That isn't going to happen quickly, but seems a reasonable aim.

Architectures without speculation issues (old ones) can use a C compare.
I think this works for 32bit x86 (without cmov):
	mov $-guard_page, %guard_off
	add %user_addr, %guard_off
	sbb %mask, %mask
	and %mask, %guard_off
	sub %guard_off, %user_addr
mips-like architectures (no flags) probably require a 'cmp' and 'dec'
to generate the mask value.
(I'm not sure how that compares to any of the ppc asm blocks.)

	David

> 
>            Linus


