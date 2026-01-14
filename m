Return-Path: <netdev+bounces-249838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78559D1F038
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783F6305B6DF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515439A7E9;
	Wed, 14 Jan 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXHFx6nR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A5395258
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396307; cv=none; b=IRT5QkP851wvWzRctUTkhtKLjOYNRkXfdREkKZl329dgOLmQsJJPf86d/DVey97ZM7IxRVYr0L9yVCzpRQdqLyize51rHTzj2QyaxEAfNWd72WvfzerwrNDagAtA/fMcc8gJL8dQFo+x6Haz5R20WsCF6GxlCQBaNsDDBCq8uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396307; c=relaxed/simple;
	bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxQemcPjcdlHQeeOtC6gxYo4Xk+Gk4lFXvgPgpFc2Pom21hbYv/F0QuxuvobR+wwG/FtTMpFvLTEovU+L2m0tlrrlb/G/+g0Gpd5DUG3hM9zTDovbDbDp1ESJHv7uRRNfKQMyJdaBd3bEh0GzuNFF/JqZENjdbDVhGETFfyEaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXHFx6nR; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1220154725fso551430c88.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768396303; x=1769001103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
        b=WXHFx6nR9OW4tTgf5X7xeWn6liiukLqrgWKK/xiTunbljcucpob+NM+TD7mgqTQHP4
         5tAxafAARed2fFQYxa3jo6WElVgIsjIBFFv++nbe4yDmrf2/cfGNwFE3h86eAStt/rMo
         gqNlRqTZFuzY7g3GmWxQ0B5tWto1YdhyvevVpLnlMzfd+07w2WZuZ1JFUZoDMlJ6L3BJ
         MkNNA8HdJ1B/MuNgAVEdc6mwgX/VD990qc+ddyAy7CLFV7QUqGghesudeAUJ8YkVdqTW
         QQ8Url4FT5e5YnWJAbAOpg68k5tTXhUb1QfO1JK10m6TXQje5v2skokJWYW8LrTeq9eK
         TuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396303; x=1769001103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aA1fxAgXApBCGTVY6SYoHUghGcN756E/4gulgNAD0jU=;
        b=pMckAq/QSVzoL2eeXHYe5GrkO5AzWfaMOn8A+jZ2VOM+ohT3LBttT4o8tdmEdSbU9I
         QCUMeWyTx9y4oE/Fu0q3plPlSKhF6LSYIF5XkFpIbSSMH+zjFx31uDBJ0oijEdRom0an
         nugLa08p1HKxxM5eNLvNdTsW28QDIqacKuS3Sqg+06JvVLtE9JXE5PKBd1+mRJKCdUy3
         yp1h5eIYTx5lyw68EDxrqORDQk56hx8iDw4iaNUAVmtro/+qvx7Fi7PQ+tUYbvkM7Nn2
         G6iTWwV1JXJXsqLp+hhyRtPkpDmYRhNmK62+hTUgjpMPvgLPSrTh19KTI1s+mKUXW7dN
         rySA==
X-Forwarded-Encrypted: i=1; AJvYcCW2mzcGxvcsHrKcTT5CvMsUlWjYHk+TeGfkO4qKbXAeRD2xbigU0YCsbF3Y1OEPGfb3bKX5wuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtYR8du3Vja4gKcpNeSQYDEuJzEcTVyHcI3wBSn6rF21/ATiN
	X9DiRWP0wFW4bPaHUKGR+VpV8Uj4+m80lGWAusNqDhAvWziZBviK9kkUTwn0fh/tvdejS2qYCgh
	HHUDB27Q8XS35Eca9n5hsr7ITdTOmLGk=
X-Gm-Gg: AY/fxX6WCVKkXuBmn8jkr/qQVdVEovrNPlE2upakyzbEdFuOB9bmlep2a4uApYXCIrL
	qWyfH0jwv32K0hBTSvKtUq+secgjAVuKC4L0bdTxVYR3dYA7ea0S3vLNs6rfKrWjAbIEElY11eo
	PoXhkfUJobxRoD7mohCrGcGd4gAGmbgyu6R5Qr3RiyRGw4VTdo5jAjvQbybEFjjLSWEs19u9a9l
	HVt1FNlmBw4ARzdfhm10WpJ9ITlUMszoX0Rh0fccwjPkqAl3KLzRJ7sgp3aMc4Qb/VaLrDr
X-Received: by 2002:a05:701b:270b:b0:11d:fcc9:f225 with SMTP id
 a92af1059eb24-12336a65e2bmr2402424c88.14.1768396302957; Wed, 14 Jan 2026
 05:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk> <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk> <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
 <87zf6gz83v.fsf@toke.dk>
In-Reply-To: <87zf6gz83v.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 22:11:31 +0900
X-Gm-Features: AZwV_QheH6G9P1GonO5Q9REYqYagJIDa-HYE9AbETr0z5N5bAmfXkid9N1D2HmU
Message-ID: <CAGF5Uf6rsR1swHUs_0eZUAt-cCJVbfTnHMM=OM9JvQCkKUu-rA@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:34=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:


> >
> > Thanks for the pointers. It is really great to see this series. One
> > question: Would adding queue_index to the packet traits KV store be
> > a useful follow-up once the core infrastructure lands?
>
> Possibly? Depends on where things land, I suppose. I'd advise following
> the discussion on the list until it does :)
>
> -Toke
>

Thanks. I will follow the discussion.

