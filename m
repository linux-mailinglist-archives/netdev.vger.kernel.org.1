Return-Path: <netdev+bounces-163358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792F1A29FBB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5658A18826F4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F24156C5E;
	Thu,  6 Feb 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arf/i6/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D95B211
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738817043; cv=none; b=ePtkelpUjvWjyI00TWUq0gTcxAI+ZeGDM71aP5Zv8dorN/Ofp8IpB5uhQZuoNN7RTTXl8FFjvVpMqQPgldizeN8OAaAZfnizL6T60kp15NcgTc/nehZuc/ysgcg7Q1JoQNf5JjmXrRybTqfJzMTveZ4ZYjdHQzfIqy1dKggkZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738817043; c=relaxed/simple;
	bh=XajYIlq4+0ks+mg4p+aIPvD6U9mjVlXfFcjc+tEoIRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/eca61FSMQyp7t+wd/L2rpkgggNjXiZoaXyQQDtpk/Sn1pOOmVB5uud6qRRj/7Mzya1S5Az1DEou7c3OB9FF8KWv2pWQk9vsemanjMTFzlSezNlmjANKTd5vUxHkSfWJ7h5LX0cXbX+a8O8thhM9g28jY6F9TBX+BZ4ufB1jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arf/i6/t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361d5730caso13035e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 20:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738817040; x=1739421840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XajYIlq4+0ks+mg4p+aIPvD6U9mjVlXfFcjc+tEoIRg=;
        b=arf/i6/tfyLA8pYxDdJ5kMVZPbJWdzpszo6686x6lX3Df6mM9kVyc0BbhI6rWr7vnu
         qtl64rLb1jnMgxJypp0mvknqd6VUiAVlg8nhBV/5n78NiETKTBWMbaF5Um4s10Wleeqb
         3LzLJcSKii86SOPe+YcRc5SMx2KmbqPGUdqGDe1jxGEBF435vP1Z07RmiWamC2WBrCDa
         F+ckCEowhMPexnsRYDuU9TPpuuw5+4LLUN8qT0lUiz+d9fE6Vpgr0hLL/UJG6u4yZ5wD
         A1DfOvHoEXfZ9a/pbXiypN967T0cPz6GAVBuY8sFvHPFMIGyWKuJ7jXjgV4tOBFINQY8
         J87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738817040; x=1739421840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XajYIlq4+0ks+mg4p+aIPvD6U9mjVlXfFcjc+tEoIRg=;
        b=FU41SO8nmZcglTS8NxbPNZUpOiUj/4Io0dIbGeZIhxU1+TCnF2FYDfC9X64aiQQR4t
         OcLNjiaoY6yFvi1xLNJ6JwhXEY/dKHBZApNxtd8stnEkts9XgOIggCQERjjwyFR4iiGN
         9I1hxYRX+tR5rHq4Ej+ETbQHwrTn+hGsSnTcCPy1ZpXoIhvrk5GzNDSl0F/W5aj4HYX5
         JU1dhyw765b5dqRDerzBl4x1jNaF21WH5e8kh+RvefCjYUqPULJskwlgIa802iqWDnCz
         r8LVsrwFYR6lWtG0OBvLxjWziAQ9sf8LcPlqXajqmVTMhtcqGxa+NsL6ONjphP5yVuyB
         Ac7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXYhzegkna7LJ0UxEiOOqGdmu3zTN94MRIHFHNYrhwKMOWraIZFqXpfYtg4UU0yL5hulsTO70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsurxErSpEg7+BgKF+bSBbDB1BEmnyIaNKXKX9+mL0k8nJqTj
	vF4BiU5skl6M6nhABHkK7iqCJKUYOgv6Xw6eOcPCP65QTJIpPaVO/V7BUj++fnBnZxoEhhd5lWv
	EN7FS/vkbgeEUo1oC6L73sjOubAt8NHeyqbJI
X-Gm-Gg: ASbGncuxnlFyZlhL6071tzqTNaw2SnY7uNIHXeAlKH0Dk+K3m/aDFeUTTCSGS+6n3Li
	dDqcOsH1kqvzZ9syn6RjClBidHfchlMwntU4mqBaCW8HdzMZNkG8rIUB56B6MVkB7mvP+wWFwFK
	Jg/LwrZoEP517T9H4lMUInfir5znGHtQ==
X-Google-Smtp-Source: AGHT+IG2HIUnj/yy5PRmLtzyvKmIbb1xtWCvCZkjyStYNB4TY/LcxF+FzLEMunWkvzajMsXpBmoE6vfoJ099bBdp7Vw=
X-Received: by 2002:a05:600c:1d14:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4391a84fb20mr351235e9.5.1738817040102; Wed, 05 Feb 2025
 20:44:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2> <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
In-Reply-To: <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 5 Feb 2025 20:43:48 -0800
X-Gm-Features: AWEUYZlq4EJ_siL6Tp4e9YYEoif0RsZTsfT5Flt7RJ4SpGLFgIb-zRC_IiczLDQ
Message-ID: <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:15=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.c=
a> wrote:
>
> On 2025-02-05 17:06, Joe Damato wrote:
> > On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> >> On Tue, Feb 4, 2025 at 5:32=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>>
> >>> On 2025-02-04 19:10, Samiullah Khawaja wrote:
>
> [snip]
>
> >>> Note that I don't dismiss the approach out of hand. I just think it's
> >>> important to properly understand the purported performance improvemen=
ts.
> >> I think the performance improvements are apparent with the data I
> >> provided, I purposefully used more sockets to show the real
> >> differences in tail latency with this revision.
> >
> > Respectfully, I don't agree that the improvements are "apparent." I
> > think my comments and Martin's comments both suggest that the cover
> > letter does not make the improvements apparent.
> >
> >> Also one thing that you are probably missing here is that the change
> >> here also has an API aspect, that is it allows a user to drive napi
> >> independent of the user API or protocol being used.
> >
> > I'm not missing that part; I'll let Martin speak for himself but I
> > suspect he also follows that part.
>
> Yes, the API aspect is quite interesting. In fact, Joe has given you
> pointers how to split this patch into multiple incremental steps, the
> first of which should be uncontroversial.
>
> I also just read your subsequent response to Joe. He has captured the
> relevant concerns very well and I don't understand why you refuse to
> document your complete experiment setup for transparency and
> reproducibility. This shouldn't be hard.
I think I have provided all the setup details and pointers to
components. I appreciate that you want to reproduce the results and If
you really really want to set it up then start by setting up onload on
your platform. I cannot provide a generic installer script for onload
that _claims_ to set it up on an arbitrary platform (with arbitrary
NIC and environment). If it works on your platform (on top of AF_XDP)
then from that point you can certainly build neper and run it using
the command I shared.
>
> To be clear: I would like to reproduce the experiments and then engage
> in a meaningful discussion about the pros and cons of this mechanism,
> but right now I need to speculate and there's no point in arguing
> speculation vs. assertions.
>
> Thanks,
> Martin
>

