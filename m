Return-Path: <netdev+bounces-170178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D419A4799D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4162E3A92AD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F42288CC;
	Thu, 27 Feb 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QJyrWn3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAF227EBF
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650039; cv=none; b=sPMJnNiPc2hbw+1tzdl3l39zZ7cIJBg9C6Hv0Y/wh7MhxB775Os6wP4Pj07MWH8xGOxAzhoeLhSXTzcmTM+4ye93bP7QGy6LOyY0ihKnpJEH9l1WYcLlHKxGhchgyNE/tdYx5j5tl/vZymPJkx4ZTVbR7g8IK77ta+kPf2B4rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650039; c=relaxed/simple;
	bh=cqlRr5ojGAieyydCsb1/xug57pPEpHK4ZXmBIZ1KQgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuuVQOlkJ7Lkw8PVAu1VrrNAPtU8PEpdej9GUXAZ9/2KLR/rNs3zQgBEzpOJCob7LNR/27HZ68pyDk9fKh1abero2iv6I5xHX41B1LmLiolZClGNe/XBMHNidRgMiux1ewesiSCcYIllcSmDR2t3+7NFYKC1MO7w/Dai3s4N/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QJyrWn3X; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso1200891a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1740650036; x=1741254836; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8To84FkdGIxaZ8ja4fPLSV1vzDgsMI1kjx5dHp2GFYU=;
        b=QJyrWn3XtSIMdwL2IeZvBdhfOM4m4phOqLPriHEPsBjYyXupwJjTrx7OSzZo6bJZmk
         rmJIqtImGfqV7kfki37zeDLL1XzzQot0bV9GvPVeC6UlBHuulfzQwuxwhtU3hbx66C6Y
         kzv2m99Z0kl0g/57G2ymKz1jCgSA0b/0LHUUFQvrSeZ/8Ak/NkhcT6m2k3nL+vnbfv6H
         PwmEXozwrzrr63fN8E+TKoS96ITK/eCDqjNZxv0684ZVDQf7JkDeoeBVr7bUb1GEXPl5
         o4okjzESrQpNEK/66LO6BI7dIiG1eQ28fUNkf08rkBe+KR/1OyTCaK2pRbhg1aX9wo1l
         z1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650036; x=1741254836;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8To84FkdGIxaZ8ja4fPLSV1vzDgsMI1kjx5dHp2GFYU=;
        b=PQSGWSAUK5yNm7CTfgjOb8rrpGmCggJP152tk5+INnTDC3DX5ZAlLW/m2dsUEeqQ/9
         59b6j+kUeNG5PARZTJCi832Wk0wQ4kEDRHbbw3yGSteTGdavZNfteucBngoTo1dxOO1C
         Q+8Fe3TfYWe4SOldWgn54/+03XSFVkSQugnx3oN9rPV/yof5l5EXse8hXI3H2XmwhXx/
         Avt0XVSbWgr42kbuyr3NP62qrpb3q68tYLovnjRCjytX9uSmFAQ3qZOA0UCXxrlReg3C
         cT2l7v02qXoAy/7vV+GPaiWqhKqH8dJPbpFiaPsoOHZZhDKO6rHkL+qS5lA23xO6TUfb
         ymrw==
X-Gm-Message-State: AOJu0YwdK+yS9uRMUbPab5yloCcfDMySsIbvwqSAMqUDWoPBOnV3+iXZ
	rY+miuhOCAnWiHwaMF9c9P1udk4eleFHrLLUMUI8PsBBzRr/YyfSvEkgcQJUiRo=
X-Gm-Gg: ASbGncsxJYKZqvP0brKWNxrlzxfbix0M3Q7kzVpnGtYyq6iHYCr1EEFD17lPH3ty3O2
	s+N5Z0eOEnhp1Yppo4mJI5IY8lUE8ZIzv6RsT2zcNiShXkjc1ncowiTtbbrwyzXlAZoSOZdI5Vn
	bekpha6vcMY7m8E/SSQp+GopJd3Yzgr73NYfux27zBHZbnRa8xA/jDxFRv3uCbp5xpnZRtXzoVd
	ra6iA52ajDWnS3VqBQbCoM6Q01WI/6u9+AG5iYmorPC0SiYRTen9LmBp/bGMJA2uPQ+WhQBumhY
	SQug65eFaSg9M7T1
X-Google-Smtp-Source: AGHT+IEvb+pBrV9uVzJjDkG4ZS9tPPbvylZOXC8K+43fLUECBRm2cHWiyPLaTwE9nAUdw6WM/yVelA==
X-Received: by 2002:a05:6402:27cc:b0:5dc:1289:7f1c with SMTP id 4fb4d7f45d1cf-5e0b72546e9mr26148993a12.29.1740650035690;
        Thu, 27 Feb 2025 01:53:55 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:df])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb58f7sm826692a12.57.2025.02.27.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:53:54 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  zijianzhang@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
In-Reply-To: <Z7+UAA83/n9XgIdU@pop-os.localdomain> (Cong Wang's message of
	"Wed, 26 Feb 2025 14:21:52 -0800")
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
	<20250222183057.800800-4-xiyou.wangcong@gmail.com>
	<87ldtsu882.fsf@cloudflare.com> <Z7+UAA83/n9XgIdU@pop-os.localdomain>
Date: Thu, 27 Feb 2025 10:53:53 +0100
Message-ID: <87eczju30u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 26, 2025 at 02:21 PM -08, Cong Wang wrote:
> On Wed, Feb 26, 2025 at 02:49:17PM +0100, Jakub Sitnicki wrote:
>> On Sat, Feb 22, 2025 at 10:30 AM -08, Cong Wang wrote:
>> > From: Cong Wang <cong.wang@bytedance.com>
>> >
>> > psock->eval can only have 4 possible values, make it 8-bit is
>> > sufficient.
>> >
>> > psock->redir_ingress is just a boolean, using 1 bit is enough.
>> >
>> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>> > ---
>> >  include/linux/skmsg.h | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> > index bf28ce9b5fdb..beaf79b2b68b 100644
>> > --- a/include/linux/skmsg.h
>> > +++ b/include/linux/skmsg.h
>> > @@ -85,8 +85,8 @@ struct sk_psock {
>> >  	struct sock			*sk_redir;
>> >  	u32				apply_bytes;
>> >  	u32				cork_bytes;
>> > -	u32				eval;
>> > -	bool				redir_ingress; /* undefined if sk_redir is null */
>> > +	unsigned int			eval : 8;
>> > +	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
>> >  	struct sk_msg			*cork;
>> >  	struct sk_psock_progs		progs;
>> >  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> 
>> Are you doing this bit packing to create a hole big enough to fit
>> another u32 introduced in the next patch?
>
> Kinda, or at least trying to save some space for the next patch. I am
> not yet trying to reorder them to make it more packed, because it can
> be a separate patch.

OK. Asking because the intention is not expressed in the description.

Nit: Why the switch to an implicitly sized integer type?
It feels a bit silly when you can just declare an `u8 eval`.


