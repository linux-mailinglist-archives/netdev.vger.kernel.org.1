Return-Path: <netdev+bounces-249773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BBED1DB7A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4D44300384E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A636BCE4;
	Wed, 14 Jan 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO7Fgpwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9E34EF04
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384345; cv=none; b=HNs+tLHkQFwsPAmQAH4h95C0YOIg03SwAefRU4Xr3Ma/iQH4dVKBOZ8lMLqF1AHbR/1jdlolZtbxY0TwifuWZXajLx9DSwP7tOXSPR8kOqu8vgpDFN1hvWzAsZrP4PsIHofpnIEAOSBW13dzlE7g1d130zPGYdT0WKMQ7rmaDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384345; c=relaxed/simple;
	bh=Dzq6SMAbcHfFRJIMzWCCCgKrfkJdaUPxHNRc/88832c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD1RQUyTT4FA0/ljW+HhQd0rE0+9qZUxiiNV6nZsYt6p1iYVRtiZIXSjhwt8iumZcMT/F/FE8KPJwAjBo4AVuXF2I6Nzn21OMermVfnyYQWZfL7n/LxoNOxR/0Otx9lkFnOGLJCriQ+j4RsUsfFasHBoLsZpSx/PwpVMvxlwh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO7Fgpwv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso67253185e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768384343; x=1768989143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73XmT9Nkz/b8xnW5w5fum9Y/ieYcnHFnxskIolQuydA=;
        b=OO7Fgpwv89ucMu4IpN0KFO6wQCIU3XI775R5MITt3n6BFH/6NPeSzJ4rCyYAqW3xws
         FJ9UoO9VzAlnBRrxctOkjaVvpn9I52GAeEeTMGoo4/KfJ51xYtztBk6G0Nj+7nfdnZKt
         kzWiTiTO1zhVAz2hV6CmqnnO02gzzmFP70hex9vv5I4MUBXhfE8aLaEEGHY7CF/L3ofD
         0RENyVQK9kY/t3mrLuJNcidU6bolkq1wGwVaJCWb+SlT6ScInwfvXTDI/n9GX12oqbOy
         VhRHSq1kVnqVmcO9ZYqKhVulMgJstLoRVc63yyQHMg9tpTk3+/FFL70kfn8UN4tTA8jS
         cjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384343; x=1768989143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73XmT9Nkz/b8xnW5w5fum9Y/ieYcnHFnxskIolQuydA=;
        b=bF0CJqv7MAtHqxwOaWOrqUGQYX/CuykOZ664F+e/A8vDNKG6fIGXIK8A5L/TN0JaOB
         6RmgtiWrPNF/poMZRRo5NFhe+guTTSNXW8tR/lxTfkZaYsrL59Nmp72uzxt/h6OV4jdx
         rLxf+wBZP95pN4DNZcz+ikcAQsuWhc717B0ySHXWwG/oyyhsF46+/1sk11UYNl08z3jw
         63i7lAIbVuRQrKjWGh44V0KDKTmh9KU5zMQFYLW3bxpDFYN7NIeTOxGs6WDfKZxlWKdg
         PXSHh+HtCO+z/P6f+i8cf0EWWdhFVJAzvLzdJxKhIHd/Y17zMIG4OaKjdSENt7taNykJ
         TADw==
X-Forwarded-Encrypted: i=1; AJvYcCUFEJ5Q2gGouRDh8GkqnaYRqKclMXguMOQwSbHamExdduNC+lT0oANls2ySg1tJypYqFqDmlwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4g9sHhUu5xCC1fKTnX7c+y7tsvHIOeJ1/8io/9EsOLydsDs+
	egi8Hm3c719JcF9x5yM+9mf2Ug0/wAVlk5+u56TIhFzdS8ReYtBPLjIb
X-Gm-Gg: AY/fxX5+/E+3nAxiJHgmBPMMmpzhdvUZE/O0J6TfTIj3+6lXtXTkhaIjCmbB4/e5y3e
	eurrHWwRmBL5pp49lbOXQs+tF4/jlZ5wUQzA6Elj8FT/kEnHLyHcDpcUujpYtXl79RxvYstHdLI
	/rCt1gVrw5lNi3J8ZG5I798weK8Jjlw7b/iqFLdhBr+DFpNVhDkpFel9qEbpNCXb/0h5Q11WPgZ
	TPc3HAcJtdneHrFERu7aMPs1pT5If68b3MR1MfEAjl0tYFkv9AiL7MfbDeSvn2M1WIrvGdDH6qO
	zPkQVPKdJR8WACKyRl1z6rozNlSw5sL1oJatqG5926YZ/D0Q/neLXIwAEpaWs0i+7ckrNMzdrrh
	SbeAWY+Peo4S1PjlJMr/2KUNQR9s//mPKYCCjuKwYsr4JptrOKawpz34EwqfjcqO41R1gzuNgSJ
	UibI/qdXONl4MDOy1GkSFFTR/knjdJAnpxY4rKrHVApqCCjJTY/ntn
X-Received: by 2002:a05:600c:34d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47ee47b9e52mr15009465e9.4.1768384342949;
        Wed, 14 Jan 2026 01:52:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27ce2b2sm17140995e9.5.2026.01.14.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:52:22 -0800 (PST)
Date: Wed, 14 Jan 2026 09:52:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args
 in trampoline
Message-ID: <20260114095221.460c059b@pumpkin>
In-Reply-To: <2336927.iZASKD2KPV@7940hx>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
	<20260110141115.537055-3-dongml2@chinatelecom.cn>
	<CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
	<2336927.iZASKD2KPV@7940hx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 10:19:02 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote: =20
> > >
> > > For now, ctx[-1] is used to store the nr_args in the trampoline. Howe=
ver,
> > > 1-byte is enough to store such information. Therefore, we use only the
> > > last byte of ctx[-1] to store the nr_args, and reserve the rest for o=
ther =20
> >=20
> > Looking at the assembly below I think you are extracting the least
> > significant byte, right? I'd definitely not call it "last" byte...
> > Let's be precise and unambiguous here. =20
>=20
> Yeah, the "last 8-bits", "last byte" is ambiguous. So let's describe it as
> "the least significant byte" here instead :)

Or just s/last/low/

	David

>=20
> Thanks!
> Menglong Dong

