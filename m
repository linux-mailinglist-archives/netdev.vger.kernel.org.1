Return-Path: <netdev+bounces-155893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51465A04377
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050AE3A44E0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE41F191A;
	Tue,  7 Jan 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmXNY8ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DA2C190;
	Tue,  7 Jan 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261779; cv=none; b=nTrdXXpZrz6vKWa2YEAAb7bWZ9znu8Pf68RMxezIvqf3TnxJD/p3ywsYmNF+M1f/TpXMqS0XaA+UVNHXgTc9QhmHPMITzSq/2S8sbh8ESeUhTZZrm/RuuFGqAyS9ytnLZfiipA9HVrSyHofn3lPPfTfkTW+lD34yP0D0twIT3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261779; c=relaxed/simple;
	bh=Tb08g295VdLrJ4TqI1vVZ+9DBlbWYG4te86mQu7tK0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPvjXUMO3BBDzWJy81Y03MwHbl7sY2sYGgJVRd52M1E5Nfk60dU6SVAKQb//mT4a0q0zBXvJ4cRHDr5yNol0PECJ97jIf8CdTA0tokmwv6nITmpanGWFXSwGuDib0WhNBJKyAggFFLNslbHIYWsBRKMYWencohnQXbO7ddrxCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmXNY8ko; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so27690654a12.0;
        Tue, 07 Jan 2025 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261776; x=1736866576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP6lcPhq7uA2jdevV7sPC88C18fJe8/9rJWhgSofyNQ=;
        b=JmXNY8koEXdnsuTRDQ1z9zvpAm5tREB4YDqi3DtCv5wjDkARXPamNq1ww/zFCzHVuo
         3zoE70F8ZFrVDhMcv3pwLfm77RO8Ri02LB3xnbiUP87xLH9l3vqwiLkRKChMXFa/8ez/
         tMviETlWwtEfAlQAETSZb+lds+a0yWUwhK/xB9qlqFP5Ox0/NK1cuLkzcb13G7jcJWcd
         DtqY4WmndbAfw9CJowoIHSKhK2SViMUNfd1ao8UxRihRaWL9geCRlpu6vIJQG75dVAkY
         hmET3rWnHWNyDnOJtw9VgMH7ak6myaMgMrVjN4Z53QUnCw3MdKdypEAWH32icFF9EwGl
         2y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261776; x=1736866576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP6lcPhq7uA2jdevV7sPC88C18fJe8/9rJWhgSofyNQ=;
        b=a9tdOeIJcWTOT6danPNpbfuD59j/rgm7QiSCXCIsiVQUt1MUvPjYrYGj2JYmkkpDda
         WiRC79TgW4OXWLlyvBn8a9V6pIqScrtD/4XMt5+pP1yQkwEzgNAr+NIUP2N8b117cyuX
         JHw4jqSZRPGyenNSeBhRrlrjnO/bsT0/TPm7crh57ZsHxEY3K6MhfMGb1pBJdR8gvqMr
         8s9oiIuFryR0Pm3O539E/NYPuFxbJyxF0IImdJY1T/uuolk2e0Xy/+4EksbYvuF3YrXs
         38em96vcJYj6FYUr0Yyz7Eg/Gjqk3MICaS+CZq4sXe4sghnT7FeIFCykxJyPiEUpp6cI
         EVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMPHYYaFpVq9ed/oAdzgJs3VvMj9M/HKRO9r369QheKfIZKTSSVKNSlyblpcj3e7oeBcSMiG/@vger.kernel.org, AJvYcCWIXYvVNkoMyCwq85QC35Ai6Qlmtsyi1lXf7scKcjTAI+hHYW0LoVpRuIJyV6qhTZBROBKbICF4w54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOM+9rXKbUT3c4RrMpTsTu9Qt7iuXsZcKJVCAwwqJxRf964xxB
	W+EV9BS0hDjVUJwjo0GOEv2ZPsO1nIogtfiNTn2lVY2g4u/Kjqcutp00+3cH6uxYfpShJcIJnqq
	g8TGUdz5tbhgzsQuHdQ0FTghobX3bEbfOnkU=
X-Gm-Gg: ASbGncvbevXCZ44WlHSOXZ/efET6cXVf7BSS3toynsE01APHNxT+6VGfdZ4ySL0gC1/
	ir0jSrgKoZ5p4vQ0buP+ytb7ltbfi0hNR4vJphYM=
X-Google-Smtp-Source: AGHT+IGl+7BYq30b/tUNfG36roKW12ay27pmjIA9wMZ18w78UyDB80x6HQup55YurEj0MhXQj9Kt0BJNkT/V0lVd9Y0=
X-Received: by 2002:a05:6402:3221:b0:5d0:bcdd:ff97 with SMTP id
 4fb4d7f45d1cf-5d81dd83edemr52676622a12.5.1736261774613; Tue, 07 Jan 2025
 06:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103150325.926031-1-ap420073@gmail.com> <20250103150325.926031-11-ap420073@gmail.com>
 <20250106190112.6ae27767@kernel.org>
In-Reply-To: <20250106190112.6ae27767@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 7 Jan 2025 23:56:03 +0900
Message-ID: <CAMArcTUzQiJfeH4+EUgUYrJdgUor5qv1wKN9sLd7CtwrNV2Utg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] selftest: net-drv: hds: add test for
 HDS feature
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Fri,  3 Jan 2025 15:03:25 +0000 Taehee Yoo wrote:
> > +    try:
> > +        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-th=
resh': hds_gt})
> > +    except NlError as e:
> > +        if e.error =3D=3D errno.EOPNOTSUPP:
> > +            raise KsftSkipEx("ring-set not supported by the device")
> > +        ksft_eq(e.error, errno.EINVAL)
> > +    else:
> > +        raise KsftFailEx("exceeded hds-thresh should be failed")
>
> Nice work on the tests! FWIW you could use ksft_raises(NlError) here,
> but this works too. You can leave it as is if you prefer.

Thanks for the suggestion, I will change it after tests!

Thanks a lot,
Taehee Yoo

