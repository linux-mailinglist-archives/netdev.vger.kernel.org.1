Return-Path: <netdev+bounces-162616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A834A2763D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC93A1D4B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F53214217;
	Tue,  4 Feb 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkUINHil"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870C25A659
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683723; cv=none; b=C+SyzdMcmrhpnv0RyEohX0Bov5g1pEaGURHiz+53+529PEWUZVJp1JQMHGOxNVVTAVrAi+9v25wmIVYSIDPbcGIpYpWlaZcqDZ3WZnLwS6QeAiaG4AA5mNh4b5ToZG88ptlZs5zo6ezJncjpqikIMJMA2M2cnDikHH09FduVwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683723; c=relaxed/simple;
	bh=pznf7y+6TBfYJKYfjaZEPMGCIaASsTIg8FeHb/sUrUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiATk0NMqMsBSlu5BxC41757FRi/aXTEdE54w8jWz8Jp1ND3S95P1XfiRvgksOGrcl6pIXAcKpsRgTKKDnrRmoEYkW8InKwhb+lBqjLw3JsaWNJRK88JDd4PeWZ9dHEsM7LZWXdvF1D9QlaMjx6Cj4lbM0HaNwmOhVpTjDzLDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkUINHil; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7107712a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738683720; x=1739288520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pznf7y+6TBfYJKYfjaZEPMGCIaASsTIg8FeHb/sUrUo=;
        b=WkUINHil+5QIJs0GE18+A/pWaxCyWo9pP9m1TfRfm8RZof0ViVFHTrbUr+30yQ/Ne+
         oyrB5/DpYvGRpoov/Huj3Zl5s1F6r5BMG9HNHWPNmJNzHui4qhUiJPQYT52XijeSW0vJ
         PA8XGINPHPf8rFEIKH/RddpzMQzFdWTUhKFqF2zxTO6fYJY/HF7q9glLGTznffxJf1mU
         szIiJQxs/Y8tCcnrswD54AYL5f1RCsMJ5nh2Rm9prhq0jBUqo3IaMnrgoOOFeZM8b8R+
         QtMRxrY3EqnDwaHEz26J7hz/XRSj/gxJZSlzu1JrQ9dGAxhAa8/PBo56WKdoZnAOskah
         EmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683720; x=1739288520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pznf7y+6TBfYJKYfjaZEPMGCIaASsTIg8FeHb/sUrUo=;
        b=su1W0ce3LVWhOKlovKQFr1ow+HkrcDrg5bR7moq2eYi50vGIxl081HhhPsvUles8pb
         H1YTUQj5JIAoABwXPqiNfZEiWG3OYkaYfVNIYzPS/aRlJYVIYuJi+0EG7/BMBs629kLz
         YzLdAvumxObvaOM2pZF5jYNojI8uCfUWAdf4QV1L8p2VZeEHM8ZSdzT2MSnpEyM85zuI
         C154ewTf4Kn85HNx0zJ3EmMAvVtcFLWXD0mST5NXV5F6JOjPz2Asq/kD4tWhBLSttoFe
         qNAkensOc/wLqHGa4q/RCVOwLoZs7WaTAjFQv0BnDnAO6hNifn0iaMSj2pNnlJg7SXKL
         H0ug==
X-Gm-Message-State: AOJu0YwjmBnBe8ShNusDT3cEYAEnI0lWulZhim2PDT7VcbZjg3aSMaL1
	UoRXDJnlrMhXaBPD62foV/73unNUDZwTbPj2lxMh+9oAyj6ar545SpCaYpwRmwvyt8XXwnIyM3Z
	YCz7yTa/wpSldd9yval2gzExyeysxIK3Oj2C5
X-Gm-Gg: ASbGncvLebrOJXI7IiTNv9CuoowdzPpf0qYkzH4ChIEXj/VGH7yFte70Dzg8Vw1JI5d
	nCWPW8Vw7CO2ZM5YThIYqR3IyMJsWSv7oYwgY6wCfnhDfr4JyHJJFRF3tzzhFDzkG85t9Cgk=
X-Google-Smtp-Source: AGHT+IGBYYosawA+JL9Y08qex6Gus99Y2FRU7BSzVPGVY240m2TatGr5loJvkzpu/vgwMg+o8hBvR0BN4OhXoWmVl/c=
X-Received: by 2002:a05:6402:51d4:b0:5dc:cf9b:b043 with SMTP id
 4fb4d7f45d1cf-5dccf9bb32cmr1704740a12.11.1738683720015; Tue, 04 Feb 2025
 07:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204145549.1216254-1-idosch@nvidia.com> <20250204145549.1216254-2-idosch@nvidia.com>
In-Reply-To: <20250204145549.1216254-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Feb 2025 16:41:48 +0100
X-Gm-Features: AWEUYZltbg0fgww7OKcOLyQZXKvlEW833D9Ht2NfdSXEwT3bgaQHYPIMyLNLoPQ
Message-ID: <CANn89iJfdyUAmuDPoR8B5Bobb3bj_Fs=Jdnh79ewQ=cbVVDAZQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] vxlan: Annotate FDB data races
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:56=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> The 'used' and 'updated' fields in the FDB entry structure can be
> accessed concurrently by multiple threads, leading to reports such as
> [1]. Can be reproduced using [2].
>
> Suppress these reports by annotating these accesses using
> READ_ONCE() / WRITE_ONCE().
>
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

