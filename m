Return-Path: <netdev+bounces-231598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E1BFB274
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE2EA505198
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D523148B5;
	Wed, 22 Oct 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3Squv42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD3313272
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125189; cv=none; b=ZzalQgzfzXqT+CR1ogp+U4eJCKQXRyE9SQREMBWSNCcqXS5NqeqQGO5wY/b6lQHsnLb33JtPJHtlA01g3pshZDvYqND+gW9fZxpIihy+5CpiqnEiPJys9ZUlbSIOxrjUDBAYMUxHjxW/PoiQrUzArgJ8FCCCQi8HJUMu0DkqLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125189; c=relaxed/simple;
	bh=fbLS6NRaqRZXt4IRUEO+unR+6g1lk+XTzy3wHnWXedU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPYQjvlKEs+fpOEj1Y7lXOkI1qRXeJ3Lk9BfxE9yOOW2mDKwX6WFdA/D7f7RqTN4LtyOJL38DMObwwC2ivmNxAqdyttuyI0pnGti1QF5xuuoAIKb8KzLI/ykbzrYz/Oi8VRdaA1RVMRE+2Ic3xzgXAskd1EAVa3CHEZAOdSB6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3Squv42; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4285512f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761125186; x=1761729986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//C0wLViLyax0tzgYYWAuav1OQzS5yBkCfcAMr1bfAU=;
        b=j3Squv42Ne6AF4NRGlqQBVf5IhyStAbHMElZfA9MiZ6qcUatHcB8W4Qo1EUrq6beu+
         XmUWJMEMOtHw6wCHhjWurNLGOlgR5dF/Ey1TCxpllcZW0Oq57Uc3ZITpFGLO7+Yn9p0q
         h5yiUR+CEbpPYSMQEoAbs3Os+nYcga8BXXFQVz+A23AEOMFqKwnlgJ9tNlvAcuXv1umt
         NPWL8p9pWHfiERXwV/cBUb1qreZCBrk4BIIPLemsNfpr7jsihoyFhEluKPSbUPNW8R/8
         VHJmJxCyMKldiGJG8fztp5Baw5fJNQhWuiwVnCIwhcPBBr8QGOfZF0TEeLPoyB2xF1eZ
         /D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125186; x=1761729986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//C0wLViLyax0tzgYYWAuav1OQzS5yBkCfcAMr1bfAU=;
        b=BFOdQg9NgatyMJkk8jsCahY9EBttWf+J6UnmhLX7foSzk5wTUngu6hqrtWxqdqaAne
         L2n9xEK974jviBW/sar8Q+zUPhhtOyBbZQYunH1ERLKAoWj94Ch+wpCM/Rsmtgr0ENX1
         LgxQ3E1YKZrHhKGTfUSn+jfSueTCPhYJIG68QmEBo4gmBc/MzzyQSWC8AcwtABe8HNTV
         48p1hunxGCCppoUsX3hrzfoO08oSaF5t+VtCv2x/Lm6Zc927MJOJ/u8+sfn2yMYuVuQJ
         l32y2CZIK6UfH/PBLlHZbo4eF2yPtTlgHgwgYm1tiiXFb+tkAEpRvWbDm6X1wbfC/FY+
         tYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC/BisGBh2DA0wTshwFfAByBs8pPG0TcCulFO6kXqtMJ7N6SIBWPYXSzCL81y3vcrSFP43+MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vnLOqhztQJxXLIo7AKp4Qhi5tLuhyt+SlBWbZL3Q4hcX3WOS
	/eOKuq5srL/21rZSCz6btufo9PgG/hNTMwIAOji3a1T9ovXaAy6i92bG
X-Gm-Gg: ASbGncuZgFWDoYqsbi5gmR+mrI24VLAQDzUqu56hHHcGMKx4HGRYDPjBb0eJJmnP8J6
	H9IGOf368cSRR9WYkS5ryeYIAW33nSy2L/vBm4Fw0maQNdkkN7S8dPi/X+KO2aiZ6QEoTZ9fkbf
	B1FHMpMR4C+J4Ate9e1Cyv2wNiwDOx3UEIVVIxN+4OaHity61Gt2wPBBx2cckLrsnuwAoKGJdoi
	0Wbfm0R2Ktaz6AMQdDwfUxJOcJKBDn4oIg0GGbQ72Ie7UTz/x95k9BMjmEWBPkb/QrrTri1zy3l
	PvmfWw0JrWhog3JrlPlwvmD/+Ef8Vyugrv7b/YlkrDo106VSeachLp0gHcQX8gy7Gr7dxtxVvoi
	cXlXJ1kC2DMJNLg3iFY5FZYCp18eY5Rwyd9LkzFYvr9yW0floO5Z0U2NuF8gt4PQdcg4iqR0msH
	b+HuHPzuEc3zegz204fq9g22YKNiupqyY2b0ys5fUoCzrCfdaiXjKP
X-Google-Smtp-Source: AGHT+IHrGA5T0AgWx+Lb6J0FhMN0AQHzVB5XwfYTdFFca9HjP/vMr81DyX12YfBDWtMAdWtJX6IJPg==
X-Received: by 2002:a5d:5f49:0:b0:3ec:dd16:fc16 with SMTP id ffacd0b85a97d-42704e02995mr13060765f8f.43.1761125186340;
        Wed, 22 Oct 2025 02:26:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm24749957f8f.35.2025.10.22.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:26:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:26:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251022102624.18d2c6f7@pumpkin>
In-Reply-To: <202510211232.77A0F8A@keescook>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
	<20251021102600.2838d216@pumpkin>
	<202510211232.77A0F8A@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 12:42:10 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Oct 21, 2025 at 10:26:00AM +0100, David Laight wrote:
> > On Mon, 20 Oct 2025 14:26:30 -0700
> > Kees Cook <kees@kernel.org> wrote:
> >   
> > > Add flexible sockaddr structure to support addresses longer than the
> > > traditional 14-byte struct sockaddr::sa_data limitation without
> > > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > > allows the network APIs to pass around a pointer to an object that
> > > isn't lying to the compiler about how big it is, but must be accompanied
> > > by its actual size as an additional parameter.
> > > 
> > > It's possible we may way to migrate to including the size with the
> > > struct in the future, e.g.:
> > > 
> > > struct sockaddr_unspec {
> > > 	u16 sa_data_len;
> > > 	u16 sa_family;
> > > 	u8  sa_data[] __counted_by(sa_data_len);
> > > };  
> > 
> > One on the historic Unix implementations split the 'sa_family'
> > field into two single byte fields - the second one containing the length.
> > That might work - although care would be needed not to pass a length
> > back to userspace.  
> 
> I think this is just asking for trouble -- leaving that inline could
> be hard to track down places that needed filtering out.
> 
> It might be easier to move to a separate struct like I suggest above,
> though maybe as:
> 
> struct sockaddr_sized {
>     u16 sa_data_len;
>     struct {
>         u16 sa_family;
>         u8  sa_data[] __counted_by(sa_data_len);
>     } sa_unspec;
> };
> 
> (So it's easier to cast between implementation-specific sockaddr and the
> "sa_unspec" member.)
> 
> And then pass that around. But I think that'll require a LOT of
> refactoring. But that could happen separately from this change, which is
> to just get us back to the existing state of passing around an unknown
> sized object but now we're not lying to the compiler about its size.

The problem with that is it misaligns things later on.
And you really want to be using the length from the user,
which includes sa_family.

I'm not sure it even works if the extra sa_data_len is u32 (or even u64).

I did wonder if 'union casts' would help.
They would require a union of pointers to all possible sockaddr formats.
Annoyingly I don't think you can avoid the need for the cast on the
call sites for a lot of the functions - unless they are renamed to have
unique names (so a #define can add the cast).

If you do add a #define, it can generate the size from that of the
supplied address structure (and error things that are stupidly short).

	David



