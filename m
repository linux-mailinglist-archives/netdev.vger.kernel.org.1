Return-Path: <netdev+bounces-162659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04FA27859
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30F31886FA1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3C215170;
	Tue,  4 Feb 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OftOmaUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B71215F7E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690076; cv=none; b=Lllhnu002uRVyLfg53ZzFZP2w+2akaYAfV2mekGsYD8LSBvucOxXSHrnJ6VVSkornzV5L55ylWMX9rtfOTq3JcX1gkQRyiny+ynUv8vovmXnuv3khRkGO28TxN9QscTvRyUuSn+lll/nxjR04TO540ugfZwPIu+Ea181pwl607M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690076; c=relaxed/simple;
	bh=V4uv66MK680ClXu6f6Ker2AP5D+vs5LU4+W5Eqq9fDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CehyNp+pqDF4ZoPlV9hezi3fXqbXU3pXVZeTv+2Lken4VsnJUtt2gKlyBpjxIYiBUzwpstkK/zEDYwHbCVwJE131rxKUll++AF4C2/lBK4cgNKpARq4TmpPqUzT3W1tDgpIq97Y79wYnVUmE2UL0TZyix8axOdnRCfB+ccQKAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OftOmaUJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163affd184so138545ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738690074; x=1739294874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfuayBjlRpeNZsUXyFm5cOwCbpbAk9szfdT3xIhInHw=;
        b=OftOmaUJrSf6tTIWxvgCdnZPkkJuuhxPCe5Lf/UTIRn9nq3TTaVAmc4uVZTNqLTW4n
         VcwpswN4g8JyfIyqWObrF4TpF4tLPo0hC3Bz89YaDcdwa/LcUrAigg016lMxWrB0t8nR
         AXYpDuLlXq2QCnKuj4X8wICSmZPbIwnlf9aKllME7CWIMCXvi4/P28iMEbDsGGAQ1nSN
         L5qnKeUCWe2i4WHHfXWqiw/AA+bQwv2Iud4UEiuMVo6Ab2Efo+JTHmHTaL27XogA/BmW
         X1xXst6mDWUXaCAYHNXCVUNjfW/girinU2noXsXSMNAUf4/xjn5i+gZ2JCMc2EqVYEcn
         8I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690074; x=1739294874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfuayBjlRpeNZsUXyFm5cOwCbpbAk9szfdT3xIhInHw=;
        b=pKszZIYHQRKaq+zC9onj9h8azJtI+TmPs7MkdRJ4JrsiIyP86yiTn1zsXm9qwt1tNA
         PQ90YD1cUvhhBhTrAoVXvud9cvWISlegflPhe/M88Ra1ypzwioYZKgzjGOBT1OtFno7G
         zvF1jSu+c7pMlawhPDG6mBYeIXKfYYaigEeHvy5CMwFN59XNeqeQus0O+sa3GJ96wXi3
         SWf8EkBdF8tt2Yen10rZSZ+RWRuSE2phkXOxHNUaziviEPM+S+I9Qu+blcV/6tLvVxTT
         pXPw5bNARKypkprmUrocYCEGB4qBvU99OGmUj1jXO9tKC6/jkaWT10ueTTj7NTKOFAmE
         5x5A==
X-Gm-Message-State: AOJu0Yx2P/QHbHg5A9110Y5abWGTRin00nDVjH6vKeHz1Ny8BM5JZTyB
	+WGsEwS4D2t82+ccV5FWGqKzLcNMQlXwxMyUY9bP9I0rF4U2ToHw3neLbpnLKXgkjKj/9iQTp7+
	uIVPRb8z3rhHS9qTENAh1SNUxrSt1esAl+5tV
X-Gm-Gg: ASbGncvcRqHwieKmuq+QWNzA+ghyXtwZElI3WnU7nfsmTcGVQMmXUQ07ci9TMUcA0ld
	/eewtgN/egpqkN5ARELQZLdkzuZRc320ipLWCe3flrpMe06gK3NYQqUkUeu53ZRB776LVsYT8
X-Google-Smtp-Source: AGHT+IE6dDHOUbSqrO0D169k4b7qsYEqIapGMMKqj/OrRCHutVQk4Tk9SbBciNiSXSLiP161vvVY/cJhza5i3Kply9Y=
X-Received: by 2002:a17:903:1a2f:b0:216:2839:145 with SMTP id
 d9443c01a7336-21f03afd716mr2749705ad.1.1738690073656; Tue, 04 Feb 2025
 09:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com> <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
In-Reply-To: <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 09:27:40 -0800
X-Gm-Features: AWEUYZmyHp3Gf6q5ty9WsLiNHfSw5QJWVWhu7wvqA18o91D3NGgPmvSyJ9NXuus
Message-ID: <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/3/25 11:39 PM, Mina Almasry wrote:
> > The TX path had been dropped from the Device Memory TCP patch series
> > post RFCv1 [1], to make that series slightly easier to review. This
> > series rebases the implementation of the TX path on top of the
> > net_iov/netmem framework agreed upon and merged. The motivation for
> > the feature is thoroughly described in the docs & cover letter of the
> > original proposal, so I don't repeat the lengthy descriptions here, but
> > they are available in [1].
> >
> > Sending this series as RFC as the winder closure is immenient. I plan o=
n
> > reposting as non-RFC once the tree re-opens, addressing any feedback
> > I receive in the meantime.
>
> I guess you should drop this paragraph.
>
> > Full outline on usage of the TX path is detailed in the documentation
> > added in the first patch.
> >
> > Test example is available via the kselftest included in the series as w=
ell.
> >
> > The series is relatively small, as the TX path for this feature largely
> > piggybacks on the existing MSG_ZEROCOPY implementation.
>
> It looks like no additional device level support is required. That is
> IMHO so good up to suspicious level :)
>

It is correct no additional device level support is required. I don't
have any local changes to my driver to make this work. I think Stan
on-list was able to run the TX path (he commented on fixes to the test
but didn't say it doesn't work :D) and one other person was able to
run it offlist.

> > Patch Overview:
> > ---------------
> >
> > 1. Documentation & tests to give high level overview of the feature
> >    being added.
> >
> > 2. Add netmem refcounting needed for the TX path.
> >
> > 3. Devmem TX netlink API.
> >
> > 4. Devmem TX net stack implementation.
>
> It looks like even the above section needs some update.
>

Ah, I usually keep the original cover letter untouched and put the
updates under the version labels. Looks like you expect the full cover
letter to be updated. Will do. Thanks for looking.


--=20
Thanks,
Mina

