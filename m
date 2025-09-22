Return-Path: <netdev+bounces-225348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85333B927B7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F29744478B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08643168F2;
	Mon, 22 Sep 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqsapKxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF43128CD
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563503; cv=none; b=NBh6fI6UkMTNCSBZprwZRLkovACIJvt9IuImzZGo5B0KKgmGF1AKD1yPUY2miHxXjJjlXpdycBOi5boUK48X0YC+l4r8ShzjBToD5s+yUEi0abXTybuC7b7YIAD380VgaH+PU6SaAT8puIA9QDuK1sipI5dNsHCnCtRh4BNMsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563503; c=relaxed/simple;
	bh=SQbJ63UiXKfvQf2cDgzKOD2MadvCiE5SXr0RWoDxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VartnW1abMtCy+HrUHq//dXxpwLMvhgrTn92AhF/M1necfWvG5NYhrYZF6yvvk6LKoS2yRQutHpfpWKg+kdoT2JLKuHBIRz7CwtnfN4Ajh2c6GReeLtySuuGWUkmkO+0GoIfoy3IKPOSobSF8wdBt0q8XEWVkI1datiOmowfo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqsapKxD; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea5bafdfea3so4679824276.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563501; x=1759168301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNhbDqEZemd4OEZbaMDZZJn1QcvJOY3gKIH2LA1yh9Y=;
        b=ZqsapKxDirpEDzg3UkDBzmwVhKHEyOb1M+Kt1VzJ/rjc/FJM4DuvjVeOGnCbMVicCs
         1itxH+e5WhovPe6wdglsiGpHiF+KN7bb3LlJdc09E+7w4OnPLP7Cm8py1FGyNwJ2sTGQ
         28kOObXS2Dy54G5+drOHenO/JPz1DoVpR6kLbIYHsfOXnPD5dTIAC4AcJ/K1V1vR+CLM
         826r57NDolDNZLMycPpxI5JZKfBj0xriOElijmal5oTpq0RirPJE4RuYNj/ZN1OdERDq
         1UETBlzH9aNme0lkBj6TqKjfQ3ozePN53ZCGtP+PRfwbNQFB5kLPH/4hmz0GQXzQKotb
         jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563501; x=1759168301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNhbDqEZemd4OEZbaMDZZJn1QcvJOY3gKIH2LA1yh9Y=;
        b=pa3IhlWz+PPm0M1YcUo6T74R5a4OcEuGQqn38SgvTX7N1ucOR4cJ0rU2WMFyITtNl/
         jFU353fAEZIRhThnpK1qVe5S2rH1nyPUKpL8BZucJxRPXI77c0fK99CLJ6NVBqkAxMKY
         ArbcNDc67zPD6F3iho1W20sKzzvmCKK1qDbZdNtxjxtCVfLTtUe7Zs/85U64fTC/s/t6
         MyR8yF86QhQCIRk84JQs/5e1f6p/oOXySviHwzP/8MJU2zOWLgpknDMaNDYIWd/kVRb8
         GyqF18TdFCHMrrXhFLSdOKKasxxtSia2/onSvzZ2DcIvtj4z3mNk054HcZ80RVxvDW5b
         aDxw==
X-Gm-Message-State: AOJu0YxACptOap+iNt6/LE5sbEo+OsY8goBdDkUSkh68maJ5CU650hmk
	pXCeLoM7kgl6h8xqqSLUDNzRVDBsMD2Rs2Bcje/ueBMDObPBNbkWK+T2H9VXo2kdPTjQycr2sKU
	eEglw2wsachLY5NClIG0bvXh3YG/Wcr4=
X-Gm-Gg: ASbGncuVsidAZa6Z0tUFDczFmRpVXGf+D3pz09araLj0ka6tvd6SK3+5EsQqIA8Q9Cp
	DZcAAZ0QqnKdIAPzXmd1M7Pb0xacribdD0gAqvQJUJXXM5JdRVUizLbPxJEjmRhp7TfQ1MUOZZh
	tcXF6s69VwWVTTXH6Jve2SUTsGB+dIkn948JIwoQsC0mV8V5kJSbnacv4nw37CR9ndnMD5GWcmK
	17A8aQY/Jkvtr5SOA+2Cdc=
X-Google-Smtp-Source: AGHT+IGHOhrpN1lUQpQk5kWDkZH8pO7att2cpJSy4rXbSanAz6B+3hAZpVyAd2nNq/tj/BHBNtrrqT7ew/6hng0N/Ak=
X-Received: by 2002:a05:690e:2416:b0:635:35a0:c5a0 with SMTP id
 956f58d0204a3-63535a0c7f1mr4487259d50.0.1758563500999; Mon, 22 Sep 2025
 10:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915225857.3024997-1-ameryhung@gmail.com> <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
 <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
In-Reply-To: <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 10:51:29 -0700
X-Gm-Features: AS18NWBn9ZM3J7rAcYprmeTu6gzX3lsSh8_IXEZf-X_nUypiwWXdzxCDhVMlKqg
Message-ID: <CAMB2axMCmf9qFp4mRoeQZC2VQQmA4zLQtsBgCpXkXKaAQQNgSw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, 
	martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 4:24=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 16/09/2025 16:52, Tariq Toukan wrote:
> >
> >
> > On 16/09/2025 1:58, Amery Hung wrote:
> >> v1 -> v2
> >>    - Simplify truesize calculation (Tariq)
> >>    - Narrow the scope of local variables (Tariq)
> >>    - Make truesize adjustment conditional (Tariq)
> >>
> >> v1
> >>    - Separate the set from [0] (Dragos)
> >>    - Split legacy RQ and striding RQ fixes (Dragos)
> >>    - Drop conditional truesize and end frag ptr update (Dragos)
> >>    - Fix truesize calculation in striding RQ (Dragos)
> >>    - Fix the always zero headlen passed to __pskb_pull_tail() that
> >>      causes kernel panic (Nimrod)
> >>
> >>    Link: https://lore.kernel.org/bpf/20250910034103.650342-1-
> >> ameryhung@gmail.com/
> >>
> >> ---
> >>
> >> Hi all,
> >>
> >> This patchset, separated from [0], contains fixes to mlx5 when handlin=
g
> >> non-linear xdp_buff. The driver currently generates skb based on
> >> information obtained before the XDP program runs, such as the number o=
f
> >> fragments and the size of the linear data. However, the XDP program ca=
n
> >> actually change them through bpf_adjust_{head,tail}(). Fix the bugs
> >> bygenerating skb according to xdp_buff after the XDP program runs.
> >>
> >> [0] https://lore.kernel.org/bpf/20250905173352.3759457-1-
> >> ameryhung@gmail.com/
> >>
> >> ---
> >>
> >> Amery Hung (2):
> >>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for lega=
cy
> >>      RQ
> >>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
> >>      striding RQ
> >>
> >>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++--=
--
> >>   1 file changed, 38 insertions(+), 9 deletions(-)
> >>
> >
> > Thanks for your patches.
> > They LGTM.
> >
> > As these are touching a sensitive area, I am taking them into internal
> > functional and perf testing.
> > I'll update with results once completed.
> >
>
> Initial testing passed.
> Thanks for your patches.

Thanks for testing and the review!

>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>

