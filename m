Return-Path: <netdev+bounces-159559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D281A15C9E
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DB73A765F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA018A93C;
	Sat, 18 Jan 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq7cjn39"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D92B9BF;
	Sat, 18 Jan 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202557; cv=none; b=ELelsjKf76iDJPKbiDuM0/7eJeZ6e3GMht6y6XlnuOFPwKFQp/Z9Uzb8YuOcVJMPloyslwG9oZWeRiOnxrG0FzwrdNDUtoIVQbpcCx1rFd+EDOPqRAWk8NzdJcay5E9grfPby1B00en0i17SthXRtHpXBWPdQiRoQgAA1vaV1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202557; c=relaxed/simple;
	bh=L/uDlVVPus/XvdGQLKggwiDHAcHcaAKXmdsLdjg4CdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njGjrPafW8+4sbaO0/QghI4B5QsH2UgR+pyJ1QGSHp8PAepV/edvqTVFY4gRkY/aIkADSfN/+aWg0jefb96Gg/OfyINZgfGe8Jvi6VxS5fVMK3NNHokFF+OvzITojEsdvO33IeBXQD3lbr+BRDMnCI6ILchkQkK4L+qZdg0o5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq7cjn39; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2161a4f86a3so5881305ad.1;
        Sat, 18 Jan 2025 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737202556; x=1737807356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/uDlVVPus/XvdGQLKggwiDHAcHcaAKXmdsLdjg4CdU=;
        b=Vq7cjn39M/ARR7RtqofqK2J0qMw+OguAh56FfeiK6vIGzk6kO3KDmgmLdpV5vVlwYU
         l4a1fCwR2J7wNFgVYrIGu01LPjA5jZQnfBI4D0R/RSndEnb2H0CtggcK6ksSEh5CiK+3
         Djwr47UUCJfY0HOcESYKRyAeT+YbgscArTCVfLsUXKnsab/O0bc3WytSQsjbCWjXOgvS
         QgNtjJTc9jrFKEQCWcG+VIw/U66v0Obnw8LJBLLfAh+FuvKjVDvg7m+DWm3Srtb9pjKy
         g9Qpfs2zl6m17EhkV+KScgaCnzLpPW4FUuQQfQmvezLgJDqhK/bm0g4eXmZ99iRMZnfX
         itVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737202556; x=1737807356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/uDlVVPus/XvdGQLKggwiDHAcHcaAKXmdsLdjg4CdU=;
        b=qVaXL0MLCN4a1uMql51FmIFEG9hDvxqpVd1sLEj7zdkKgDq9SN6QTl5L5TET5Uqy8A
         yL1PWFdke6mKn+0a/nBfTUr6ewfW3Pnag3v+W1uvf8z9obha83L4OuyGN5fk6WMMuizk
         pu9zXwH9W9LtHXAOD2Mpc2aGIK8j8RLSIYF+ugj+rvFWsejNckGmkJiumZjU/FFuna3f
         jPZBTCLVdlcscOMMNWV5ZeQEhL0s5Si4r/5hcfijbXFODaaYGlTUqNcXpo4s6eUXura+
         YxBG6fKl5Cvpm/P6somV7UR2GAcomupMtlLKkXTcyOO5xUwd59rJSVNewbIRtQSeDr7p
         LRog==
X-Forwarded-Encrypted: i=1; AJvYcCUoJMVhAIdcyXXNNq9pSRJiwtlMFmsNyzX5BH77YYHKplaGi5ae1tYeDM0lHZvWg+VNBcBl4FM=@vger.kernel.org, AJvYcCX4TYFMfTTOr/8qYOenEWDX2Ks6+ARylP4k0WHPLKMLBLHoXijjTtvnyoeNCuCOCIZpreknpUt5kNTTPETWo0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwoKXbtHKh6nGS59jUZexb+qLFeDsICijnlPKBuH2CPkWkudO
	pqyI8ffJiP1Yc/uvqSCfsm2sUOgZ4EEN/Oea26Db3bol0rJSjkZDXh4vzNfKMivDawNWQkZitvW
	16LmAV/RnwaIlGvOaXz9ogFE50Rw=
X-Gm-Gg: ASbGncv96tvFZyS7We9+52CSnWG7CQMo3Hm73Vmt2RaoK/qZNA8zzDhuzpqiHs6Zobn
	C0v/4q6+1exN1X53yum9kxGTZr+Y+tpXNM5QPgXBA0UTnVYYCogk=
X-Google-Smtp-Source: AGHT+IEIBIE7nEmrOkxGrbj747pEOGUaOuiklLk8cAo53h+cN5IAgu2rsT4njh2uTs+zUr0VttHGw5WjOgAjwr+kSHo=
X-Received: by 2002:a17:902:da92:b0:215:aa88:e142 with SMTP id
 d9443c01a7336-21c355b551amr32165355ad.7.1737202555675; Sat, 18 Jan 2025
 04:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-4-fujita.tomonori@gmail.com> <CANiq72m++27i+=H0KUaf=6fn=p29iueEV-+g8toctp0O0zEW+A@mail.gmail.com>
 <20250117.083111.1494434582668066369.fujita.tomonori@gmail.com>
In-Reply-To: <20250117.083111.1494434582668066369.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Jan 2025 13:15:42 +0100
X-Gm-Features: AbW1kva0CVLbX7uZvrXCLgGI7Wu5Xf5vMHJnIKa6xEdUaaxzetb6I0T6JBu2m04
Message-ID: <CANiq72=vY3eZdsr12KfTCR6wGwrXyGZBk+1J7fsvg0t41ufYeA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 12:31=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> As I wrote to Tom, that's the kernel's assumption. Do we need to make
> it an invariant too?
>
> Or improving the above "Range from 0 to `KTIME_MAX.`" is enough?
>
> The kernel assumes that the range of the ktime_t type is from 0 to
> KTIME_MAX. The ktime APIs guarantees to give a valid ktime_t.

It depends on what is best for users, i.e. if there are no use cases
where this needs to be negative, then why wouldn't we have the
invariant documented? Or do we want to make it completely opaque?

Generally speaking, I think we should pick whatever makes the most
sense for the future, since we have a chance to "do the right thing",
even if the C side is a bit different (we already use a different
name, anyway).

Thomas et al. probably know what makes the most sense here.

Cheers,
Miguel

