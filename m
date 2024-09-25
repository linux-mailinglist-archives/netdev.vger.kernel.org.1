Return-Path: <netdev+bounces-129826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE0C98669C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AD21F24BED
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689AA75809;
	Wed, 25 Sep 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkTCsvrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F917BB4
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290898; cv=none; b=cwd919kJGAt5BePvd0KD4lWzUmZ/812ODzZMG8O2e4BmfvY8Lw7h2aW0SSs/f0NL2QhFw5M65hjnPsXqQBLhE8Fb+SOI7kwoHfKwD6psRZ+At2Jr9VVCBdDyaRveaGplexW9MX4Ry3AdidB26LzJ8Vilm5iD6WgRkTgTkg3WgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290898; c=relaxed/simple;
	bh=JPIOQVpYy6D78QuQ0NLIim5i6ssYR0dlPTVeaiEwuGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BhWH3pXfNvTJ+OCllhXqoiXsSu6oRnXZgwXYYrIk0LzC0N/AYBpAzpoVVrpiOV9hMr+zQlAxLPZVz9WR+uCIotvPv6RT4gk8OWEnqXdrAzmQqLGKKKRm50/jTNi2b6UDeXOLkeGrpY45VrDM9COIspq0kAOWzlUCULpuNl69rbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkTCsvrf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so1047135e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727290895; x=1727895695; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPIOQVpYy6D78QuQ0NLIim5i6ssYR0dlPTVeaiEwuGc=;
        b=ZkTCsvrfTM8HU8F62alqUM9tVyFqRbao0Jzvll9BmCr0YGaVjYqTxn8oB1pQZxvps2
         46F2IDGT6yHBtFwKZgHhlJztVkEXcT1vP3NM1rDZjNZLCft/jJMtip3us9WN/9i4doER
         ysGQdlFh7LOcg4zWJAg+cR1xCGpFvpOMEgp6lRC+evUJa0A01UFyyp5EJPdyRwx5iTyd
         uC1K42IYNkWlczeDMMxQTf91ygeSF74JPT/4ODSOI8YvjfWad+DtyPt4FgiESnaCPIFu
         2e+OptwUO/sV2uKw8CdYk+ljHsFMzgWQ/3ZPBLZGFwhdKgImVyBqAkHgSynaxWYhOaSQ
         +jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290895; x=1727895695;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPIOQVpYy6D78QuQ0NLIim5i6ssYR0dlPTVeaiEwuGc=;
        b=pGMlON4M+VSoYfQHlxl0xdJeLkWZ6mw2U1YNZYxDCpy4DWZzGo5fMKmPNf4PEbzGxy
         oO7z96B+dBCySsyTd7Rf5awAXrPI/leftEsvqy1VA/CRapk9S0fHD6bhUNlXY2dbXUrh
         6ZumDB1PioYCMBMmWetSrXT5/zgJEqpU5HFTN1AT9l3xOerCR2GMoSD3z03ai/MZCLDu
         NAq5SwTLxlSWdS6wN9cAisQnhnFGXKBzgCQZthLh/6zFjvxR7VGRmpAr3SY3DbeYjva9
         4Ph0H7qNLimEvPujl3mQqSA0LyXliF1rGt9Jrv0O6GMVcUSAng4sn6REg8Nrbmx9m61R
         4hEA==
X-Forwarded-Encrypted: i=1; AJvYcCXfS7e4c5oUmik31XgR+lyA+QVpRwUV53AhCgV61Yud9t3rSesWVvlSnAkS+a1zRPuXu3sL69U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGg1pdRN+mrbFAPtH6I2R54+6ONlX2o3CGOqlrRfX0gzhDerNq
	fPFKWihXOQi/SPehzzpQmEB9KEJRSOlPKR9nQRnBtqVVd4qrYOqzOLHy5lwsz/2EZN/v1c6bJpH
	imZQcyRs6FJMOMAVs7xNqinpU5ZAjmk9uNbzR
X-Google-Smtp-Source: AGHT+IEVbShi28LsUkyR6AYEqVzLUNMO1efjMBGVMfpijd7cUcq8i0bcfTdcizaJkgjNZQ3fsqvom+8inf2v8L26YBg=
X-Received: by 2002:a5d:4a87:0:b0:37c:ccb5:4eff with SMTP id
 ffacd0b85a97d-37cccb54ff8mr1132768f8f.12.1727290894723; Wed, 25 Sep 2024
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com> <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2> <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
 <ZvRVRL6xCTIbfnAe@LQ3V64L9R2> <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
In-Reply-To: <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 21:01:23 +0200
Message-ID: <CANn89iLkpP42EFRGmFUsSQv+ufNA=4VmSp6-1NJBBpm0kTjw7w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 25, 2024 at 8:24=E2=80=AFPM Joe Damato <jdamato@fastly.com> w=
rote:
> >
>
> >
> > > git log --oneline --grep "sanity check" | wc -l
> > > 3397
> >
> > I don't know what this means. We've done it in the past and so
> > should continue to do it in the future? OK.
>
> This means that if they are in the changelogs, they can not be removed.
> This is immutable stuff.
> Should we zap git history because of some 'bad words' that most
> authors/committers/reviewers were not even aware of?
>
> I would understand for stuff visible in the code (comments, error message=
s),
> but the changelogs are there and can not be changed.
>
> Who knows, maybe in 10 years 'Malicious packet.' will be very offensive,
> then we can remove/change the _comment_ I added in this patch.

BTW, I looked at https://en.wikipedia.org/wiki/Sanity_check
and the non inclusive part is at the very end of it.

I would suggest moving it at the beginning of the article to clearly
educate all potential users.

