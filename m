Return-Path: <netdev+bounces-154016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06D9FACD8
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD06218831E9
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F001A8F64;
	Mon, 23 Dec 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlPIQ+D0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B938199924
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947219; cv=none; b=Fq8VF9XNLd/8GISdaSgxoA9Q2Y/qGmUA7wlNk/QcncDASX4MvUcfKcYtIpT+6A74lwEU8vBvIyDmEDL6QKDRTBzgw/wychI4bmF9Jzu5DsQn2cOQBackC2q8FYuVJ4Io4YTB1UvnB3K5PFr9Aey/DAoszqLgwE70/CD0wGoFYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947219; c=relaxed/simple;
	bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/pyixdkCoNSeevhTWhPT9U5JSPpkFSevFonCQcroR3amzj2Cq5yNwIlGnwrsb/WO3iuhm0Fbucy2Hh+a6a2rvMGUjGZNg591tcQzpxFVrD/uusHnXgQRlsqfX+01p/K2KVub0veUp/7Eq3N6Ab1txlFXpa8sy/pfPrig42U6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlPIQ+D0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so6473894a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734947214; x=1735552014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=wlPIQ+D0y8yd6boNIbkKkvxdpw0gLadrUD0l8zhqGDVdc/z5Vj8cvd5JDIo7sWGdPA
         5j9AzOkwg8Ydg3tWgpnbP3l1kpmscUE9z0+igrRT79FZuXDuNzb+aa2E8TMoIDJyBnrs
         6E2X8rQrNzDSpA6Dv021/QSllnKpw+O+/XQoNgopJ7Ahr5f+sSkdDE6ntES/ZfY4g/Tu
         dsDVPohAbFghalvlWNE9OJ7M1U+NzbDroDSNT3HiVnEHdLDXX1+7wNhEcQG4iPt3dLF/
         sRrltdo/NkWbmLfnahUiDkD6jUjhMOAxmahfVwE5h/+PHbKgnqsBIzMfdOQeWo41zmOX
         jWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947214; x=1735552014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=MT/BTQ5CK0dk1mt2nKDaLpiDSCuYmdEmS1xtsy6Gampr7baV3GISLwlQwNq9Jhh8Ty
         UrqfzpzPifxa+3iPKJMT4gdsHQr3XnIP7VMzqctwx35X+a2S2Kmh94o1mWYoxTOcm4V4
         baEAuyT3y+slAXnHfB9JPs/gHm27MI7okIqPXazbDwOSRfftmqMXhqBKZVB5JKPxsj/Z
         P+Riu/HR0ZIWo/IZr/mhMSH2ZVUsQUg2bOt2frDEpu+SvPGQafeoGTU0SQpeMfYmhX8c
         UYl5makAWIdshI83ffQ6W6z6TRwqvXJddVCqK9KCktDU+5ae4xLTMnVDuJp7ZXvIZbh0
         Qa0w==
X-Forwarded-Encrypted: i=1; AJvYcCXad5QNbEVAmCR73HZObw+hiy/hEaD1i0HHEeGMiSOnCM3L4p4aJZoyHymBNWYsKdrTvJM8y+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7t8GoUqXP71Ptnc+ist1p1irhFJRDGqlYOri6MrGA1fTWxZe
	RVLJvxSPPnq20cI0zvdpwa1T/l+Qsl8nBHJLgV6qyCvSzPagAW3SoNU7V7RqibYD/eDt3jYpIQ2
	mOVHURD4P1T6AHShWbtLm+7s9j7GqIphwo9b5
X-Gm-Gg: ASbGncswUMZBDy5qrf6rTAm9mgULd6pjvZgWaQMy9U7ZsFYDnBHoQMMPCP2/3tHHxx6
	yXzPz3vlhhc4tocKfM06ztqkG1lQkgdXVtIftWQw=
X-Google-Smtp-Source: AGHT+IH3+egfWLTE78YKlmwPqtWef5YTuB2kERtTaCX1dCwBHcNtCa+1pJDYxvd4T1CwOvzn7Bqjqihb96SfUcymHm0=
X-Received: by 2002:a05:6402:270d:b0:5d0:bcdd:ffa8 with SMTP id
 4fb4d7f45d1cf-5d81dd83b92mr9613064a12.1.1734947214306; Mon, 23 Dec 2024
 01:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
 <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
In-Reply-To: <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 10:46:43 +0100
Message-ID: <CANn89iKU8TwoiZHPwdEAy2w=RhmbDci3n6Wux=oM1YzrkfdzpQ@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: fix TCP options overflow.
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 11:28=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Paolo,
>
> On 21/12/2024 09:51, Paolo Abeni wrote:
> > Syzbot reported the following splat:
>
> (...)
>
> > Eric noted a probable shinfo->nr_frags corruption, which indeed
> > occurs.
> >
> > The root cause is a buggy MPTCP option len computation in some
> > circumstances: the ADD_ADDR option should be mutually exclusive
> > with DSS since the blamed commit.
> >
> > Still, mptcp_established_options_add_addr() tries to set the
> > relevant info in mptcp_out_options, if the remaining space is
> > large enough even when DSS is present.
> >
> > Since the ADD_ADDR infos and the DSS share the same union
> > fields, adding first corrupts the latter. In the worst-case
> > scenario, such corruption increases the DSS binary layout,
> > exceeding the computed length and possibly overwriting the
> > skb shared info.
> >
> > Address the issue by enforcing mutual exclusion in
> > mptcp_established_options_add_addr(), too.
>
> Thank you for the investigation and the fix, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> > Reported-by: syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com
>
> If you don't mind, can you please add these two tags when applying the
> patches to help to track the backports?
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/538
> Cc: stable@vger.kernel.org
>

Thanks for the fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

