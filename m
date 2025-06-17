Return-Path: <netdev+bounces-198807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F9ADDE41
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0731E189E544
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AFF291C38;
	Tue, 17 Jun 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJsXlUhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9A255F31
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197153; cv=none; b=X15K8y3SMP3dz06nYarBGA+TiF5TelehG0UYrNTwJihThUA12A97Ho7YpFmMrQOB1AeCWMJYZ7yutqVOkwlv/E9IWAxieTz6EcZMYkNms5z+UILIxsL6N4ddpSq7mBCz4pfB7f5sOh0GsvOx4k2KHBYJabHvoOGzjWa56BYSwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197153; c=relaxed/simple;
	bh=G6aq9UULzQSeWStHfJCFlTRXAe06thPa3pLZymjNKfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCEIp5znZiWFabb4bYoVwZ8EWDqP7cwfs0AYM9uWuNgUGVFH4PSN1Drax1CKUAA5AfeQV8WPa9OJNv9OZXPaD67ugrB+qpliKvF0NYemgMsW/ffa5X1c0+9PDu4GGsbbgzdz7QFLpTrp8BQveTLCn06F/aGiHeOtoKue3ggamOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJsXlUhe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e389599fso62915ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750197150; x=1750801950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk9GnGftZvypb/fve6Tub1/yPh7i0cO/ST2epnsknjQ=;
        b=zJsXlUheUCW2JIG/15+IHtVHkX/mQF9dlkr4jyeK+BLPjAAOHU0m2nmqrga7HVGzC9
         7unkZHSVF8xWoPA+H391ji4FGmtIcWqkgTumss1HQYXdqA8l0mJEhZUkp+R+z7jXGsuk
         iWp462bbNrPjHik0Y9rYmgkSWDgVTo8IyqC6YdJyEYn3lEyTVMb5Un8wRfITR9+9O+AZ
         /A1nKHjlxsxIpEZsqpLaXQWkyN9YO7uY5Ksm+2aBZEWG2JKbv/erbbK7ab+0wVkNAlht
         I1InBMejwQsrOXiIIhJu/L3euzIiI9YnCS8rwt8cBRPY9I7+S1WZHbY758kmCoCtojUr
         S94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750197150; x=1750801950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk9GnGftZvypb/fve6Tub1/yPh7i0cO/ST2epnsknjQ=;
        b=l+w3KeX3GCSohXnzUCqIWOYOrshckKPSn7kqpDtGfonIZ5O5/iDccmmoKHf0015ufG
         uLR2AzGpBxQ+EUIMJrqCkdlpvz2/DO07WoHQ2Y2LcGSWHbCgkH2fNjVT6vkorF/Xsyi3
         Ik9aXOV3mC+VVQNqsFbvmb93pxW48bVgOVgKwFAR8fnrxQfXS9zlOEObL5McIL60wnAN
         zq0Z0vIn1IGu4pGusPOYWriIyEugSptZ1I1RdJ6veG/geHFqyNZcJvcNCQ3ebg/KVDJu
         X80yUTI/yo09vC5/KRCqqAZ01tqwOMKNaxPh351Qe+iqqw4s1A3J5wg5BG85QsGfSEsO
         otiQ==
X-Gm-Message-State: AOJu0YylZWqmnkRZTG5uAFV7Ox2lBkc+OOZYTxNiVFU5dkbCm5bhhWA9
	fV++Y6W/udJ11U159i30dvpMmfLVvYRQLbWINKW5dsQqTqDZm8uM4jXpLGv/7dcEMbvGtyxXfTT
	H+l78tWHShmE3H4uT8N8VJgAO8sO0C6dC7Bk+/0rX
X-Gm-Gg: ASbGnctCpyd1UEgBJSXdymwSIl1CLMGIm6lZvf5UolkPDcMYlaLTT19nmymDR5oYbQP
	tpC4f4c2i7/GV09J7iQtqP7Ake3X0q3vJrE1U+M4/N459yqiNx308HtBnyRabSh2UpsZrGa4UUI
	EDXWI4rmHNtlxErzAM1l99HU9fErM/HSbvqwBmZsvYOesxVDlcfjZxI8u3gVDqhIIy6UkXteYXv
	w==
X-Google-Smtp-Source: AGHT+IEjic+DQ+x5I1iXBb3/VZNJM4D7edP1sy7P3+y0WzbFzyD+lgXbWJrCNXbJ7hLkiIre4KJPn7EyvpHv7CZV3kw=
X-Received: by 2002:a17:902:f78e:b0:235:e1d6:5339 with SMTP id
 d9443c01a7336-2366c8140dfmr9959955ad.26.1750197150134; Tue, 17 Jun 2025
 14:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617210950.1338107-1-almasrymina@google.com>
 <CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com> <aFHeYuMf_LCv6Yng@mini-arch>
In-Reply-To: <aFHeYuMf_LCv6Yng@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Jun 2025 14:52:17 -0700
X-Gm-Features: AX0GCFvx4bn0aOYkN3CSqdpJSpRaKHHjptdW4cwpAa8d5lG6VPslMmhVC6iQfF0
Message-ID: <CAHS8izOMfmj6R8OReNqvoasb_b0M=gsnrCOv3budBRXrYjO67g@mail.gmail.com>
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with unreadable skbs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/17, Mina Almasry wrote:
> > On Tue, Jun 17, 2025 at 2:09=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > skb_frag_address_safe() needs a check that the
> > > skb_frag_page exists check similar to skb_frag_address().
> > >
> > > Cc: ap420073@gmail.com
> > >
> >
> > Sorry, I realized right after hitting send, I'm missing:
> >
> > Fixes: 9f6b619edf2e ("net: support non paged skb frags")
> >
> > I can respin after the 24hr cooldown.
>
> The function is used in five drivers, none of which support devmem tx,
> does not look like there is a reason to route it via net.
>
> The change it self looks good, but not really sure it's needed.
> skb_frag_address_safe is used in some pass-data-via-descriptor-ring mode,
> I don't see 'modern' drivers (besides bnxt which added this support in 20=
15)
> use it.

Meh, a judgement call could be made here.  I've generally tried to
make sure skb helpers are (unreadable) netmem compatible without a
thorough analysis of all the callers to make sure they do or will one
day use (unreadable) netmem. Seems better to me to fix this before
some code path that plumbs unreadable memory to the helper is actually
merged and that code starts crashing.

Similarly I put this in net because it's a fix and not a feature. I
can send to net-next if preferred.

