Return-Path: <netdev+bounces-163672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571FA2B4C3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F84168139
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172B22FF23;
	Thu,  6 Feb 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbYWxlby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17723C395
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879590; cv=none; b=ELwmdN1efEYw1oIK/otX45tABzydh+xnhjP5cl3v+ZxdlZWJGZtjHZQyUXeDWbObKx00v+z6omvdrL6z+61hbXDV6k4jsGz5CqqjnYLHzzbr+R3dV7n4RpkKc1aaJtMx/J5da2VULUoZFwx399V+7Nnne3j4PFpDYGTbZER3Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879590; c=relaxed/simple;
	bh=X77zs/U3vERwGQtGKjkthBLNZyS+hGgA1zQJ5FfC8TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lIC5g6k4/mK9dfXzcs32HirrJjQT3LFs3OpXMtr/sIHnCCJcVpidHyvHopEKglq2yOq0zOk5PE7rp0DrWN5px32qEo1qd8d/Gu1l0+kbl1ZprwIuUzyJdX9dLHqPFrbnqkdpWoxadiRQjoJdhT9HPD1dgwg9MzhFM1QVUCfbcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbYWxlby; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso7005e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738879587; x=1739484387; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp8iDOYQXltBGNr+rgLCsCyZdt6CZUmdZc8/qGk7FfM=;
        b=gbYWxlbyT3FzaICcqhYMPxRLNvg3nE0ENhSJ+G/S7wOCpE+JDXZUmY8rlR/nCYiEf5
         joZykE6HKnX66m2SgAml7FnNaekwOAuxb6vUjblsC7XQFhsnn96vmmeRBY3A2IpmqGDp
         TG6bkuXU9TrTEMBQq+Qehk/Zktde25q0ZK1gJv6Trhdt1p/3BIQqUB/wm/KTEiRv+5im
         5nh5wpfEzYGI66V4gRlAtvWRG4+G7K7A5BfMnGABsaXHKjCSqLU4CfjLxGcvDoIH3VwK
         d16S9cruZFFkAxB3rBd6GPcX9cqzTaz8EXDBpYbqkW6pZnoyY6vG1JvsDHX6brp3zkys
         251Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879587; x=1739484387;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp8iDOYQXltBGNr+rgLCsCyZdt6CZUmdZc8/qGk7FfM=;
        b=ACukJDhSTRRGW6M2heh0exjIPI3xIZLDIio5a3z5StLf4cmhLKwpaP59X5cBk5i92j
         lGmbUuVEEzcAUvjX4K+Jf5vqGNUE91L27L/iw1Ip3jVupMbktZAOJvnvTVB4mwhNZWxP
         i8/gcbYZfoQ9ZfmdYah4EOFO4kiEXLQttY0p/bSNs9yNFzDcjIV3kafXgqr1iDtvO4F2
         EmRBLdRQfbMqGNqobcgDcQ+vF3rfFyqhyIhudTaiXZ/JMrlVQbW1o4/1qJRdRJ3fPzQJ
         HRYWBwMKKP3mwqTsKBjljUNOKBPPiG8jJLaCpwbiGIqTzkCdN7PIg8J0I4NsAyeltOyl
         iQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAyW4GJdSyQL+mMcMYjA2svTdAbW03z08u4AvU/yxnZYFTTN52rnrfcajaSY0idpWYC2vxYzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfFRvw+I2shA/GWGCTzgA8xqophVHwhIBYA0VxlylaDfLKd9v
	KNdWVYzvwvz7PpajlgFtlEjf7L3mawJloQOM9ktXTutsevE3hqXEhtek0t8LTKIT4BMMRVLc21m
	AnppgPgTHCwyAb9ooRLEvZOIYVx/alxeCDn7y
X-Gm-Gg: ASbGncuTCngYJep5+SpqZLcActsY9/2dZvN9ysZm1HJ3fR442GlqIS+AqK1yQT/Quv9
	9xipomXPx/Sofl/1qGUl6Mv23TFV2+bqsFiQIKYLqyKafZ4mFKmIsZF2NKfC05mVa0hajY4Ip8H
	sAfoYGh761mi6TOAvgUx14k0vW54D3xw==
X-Google-Smtp-Source: AGHT+IEn8Q0gdX5EG+Vag9xOtdq5gtEp5PgQL9pH4d3PNECuT7mA6s4+bZQnRdJEB2otVCuRflFyR1/CNhyNlIQZxE4=
X-Received: by 2002:a05:600c:568f:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-439252682demr288915e9.2.1738879586489; Thu, 06 Feb 2025
 14:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <Z6LYjHJxx0pI45WU@LQ3V64L9R2>
 <Z6UnSe1CGdeNSv2q@LQ3V64L9R2>
In-Reply-To: <Z6UnSe1CGdeNSv2q@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 6 Feb 2025 14:06:14 -0800
X-Gm-Features: AWEUYZn_o3A2V_fnwe31oFFnEF57TiPvEVzeNYNKpT6enkIEn7cWds32EHJrd2s
Message-ID: <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 1:19=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
> > On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> > > Extend the already existing support of threaded napi poll to do conti=
nuous
> > > busy polling.
> >
> > [...]
> >
> > Overall, +1 to everything Martin said in his response. I think I'd
> > like to try to reproduce this myself to better understand the stated
> > numbers below.
> >
> > IMHO: the cover letter needs more details.
> >
> > >
> > > Setup:
> > >
> > > - Running on Google C3 VMs with idpf driver with following configurat=
ions.
> > > - IRQ affinity and coalascing is common for both experiments.
> >
> > As Martin suggested, a lot more detail here would be helpful.
>
> Just to give you a sense of the questions I ran into while trying to
> reproduce this just now:
>
> - What is the base SHA? You should use --base when using git
>   format-patch. I assumed the latest net-next SHA and applied the
>   patches to that.
Yes that is true. I will use --base when I do it next. Thanks for the
suggestion.
>
> - Which C3 instance type? I chose c3-highcpu-192-metal, but I could
>   have chosen c3-standard-192-metal, apparently. No idea what
>   difference this makes on the results, if any.
The tricky part is that the c3 instance variant that I am using for
dev is probably not available publicly. It is a variant of
c3-standard-192-metal but we had to enable AF_XDP on it to make it
stable to be able to run onload. You will have to reproduce this on a
platform available to you with AF_XDP as suggested in the onload
github I shared. This is the problem with providing an
installer/runner script and also system configuration. My
configuration would not be best for your platform, but you should
certainly be able to reproduce the relative improvements in latency
using the different busypolling schemes (busy_read/busy_poll vs
threaded napi busy poll) I mentioned in the cover letter.
>
> - Was "tier 1 networking" enabled? I enabled it. No idea if it
>   matters or not. I assume not, since it would be internal
>   networking within the GCP VPC of my instances and not real egress?
>
> - What version of onload was used? Which SHA or release tag?
v9.0, I agree this should be added to the cover letter.
>
> - I have no idea where to put CPU affinity for the 1 TX/RX queue, I
>   assume CPU 2 based on your other message.
Yes I replied to Martin with this information, but like I said it
certainly depends on your platform and hence didn't include it in the
cover letter. Since I don't know what/where core 2 looks like on your
platform.
>
> - The neper commands provided seem to be the server side since there
>   is no -c mentioned. What is the neper client side command?
Same command with -c
>
> - What do the environment variables set for onload+neper mean?
>
> ...
>
> Do you follow what I'm getting at here? The cover lacks a tremendous
> amount of detail that makes reproducing the setup you are using
> unnecessarily difficult.
>
> Do you agree that I should be able to read the cover letter and, if
> so desired, go off and reproduce the setup and get similar results?
Yes you should be able to that, but there are micro details of your
platform and configuration that I have no way of knowing and suggest
configurations. I have certainly pointed out the relevant environment
and special configurations (netdev queues sizes, sysctls, irq defer,
neper command and onload environment variables) that I did for each
test case in my experiment. Beyond that I have no way of providing you
an internal C3 platform or providing system configuration for your
platform.

