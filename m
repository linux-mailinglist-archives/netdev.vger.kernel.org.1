Return-Path: <netdev+bounces-190713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85EAB859E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D07D3AEC62
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD817BB21;
	Thu, 15 May 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCjPgj+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DC4B1E70
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310699; cv=none; b=BcZuaw9TQjJ/ZgByrp3IxZVxzQXIH+n6/N5xZDS+R3NuWah2enuCY0xMcnVy1/L/D2Nt6fUTq2zOlnJQT3REgGuKo7a19L54C75+6N/kqauE9Jtc+gaKIzN88coZVS05yCkG6931qGsnYHsjRXQXf9evwoTzqiiVoXFyIg5mFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310699; c=relaxed/simple;
	bh=WpiUlejC7a9sr/eBVtWBvwV6YolLIp6nwvJO6M2Q7gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV/oN8b+0NML/T1gvPrC27WFci9crQlqwNPHhuYIThXTzo8W6ehAeZhHyKAFVSSRFnH8m0KEUzpBvwlf74f3vKdo9LNY8E5iSVVZba+oNLkxBypgYWVXU0IQswHFDTFDCNt+vhiItc1Fvbo9rzplT0hLb/aT9Ds9uW39UwUiMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCjPgj+h; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-48b7747f881so260271cf.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747310695; x=1747915495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpiUlejC7a9sr/eBVtWBvwV6YolLIp6nwvJO6M2Q7gI=;
        b=zCjPgj+hAlc4bY2AF/Y8IKvqPysDnyiFG/ePPyTPSwnJwzpDyH4JSF6o/1HwdY+UrZ
         Em0zK4Ieg5IelHYt6eG0pOKUi5LbRtqswy6F4RGXZZRdHptX4vohrDHoGu6Uu1k2VPJ8
         vNOLrWN/YLv/c2ylyjHeQDPniMueyHx7kj8vgS5lapRRh5X09IuDyJchalCxBgpJRa/i
         QQj738YY7VTrk5CHJpme3CBDKH4KECY0/1xDBayroXxlly6Sdk4VKC8DnckgbEKQblqC
         6vPCaBXIaZ1dOOkNYYvZN5vApUO00LPTWrEb8RacZrvbOPxiCYu4WvQBlzOFva4hOtFJ
         upCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747310695; x=1747915495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpiUlejC7a9sr/eBVtWBvwV6YolLIp6nwvJO6M2Q7gI=;
        b=TnJkW1K7Liv5aKiNfACaUNjibBjZhr+up7RMs+FM1+1Q8S3lcMtCy37nYky/4KMRPX
         SuI+zFH/HSRDVuuPaEFYFsyYmei03xuCantYd6Uw/6gHTer8HcxttYvxo9+ClkIn8cqH
         xUqA5ILnrQ7LMT7lFZtA66FNGyNXzqF2dBhHPy6KQ3tGb4Lxuv9+/7GazE9xM8m2eJdR
         oEpZ6bo6dpV9ETfB+w2HKhJ7ywuhpzYY5KyE9Gd+BdcosM7f0KexxPOpXZWfG0c4BW4d
         pp9jlR0P5xoo2F5/PEjNthh/GL9SOmx5MjMZyL+EKrCF7e6mFvk5ub5uUYE6xm0OUwwQ
         d2PA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WjA7brodAMqXfDwHZceiKDrkbmZx1DLXKE9c0GIswTDtd7fXp8iaHirGJ8UqUIdlPFR7sQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeyec+Xx6AsUQ1eeQPvVa7mtZQ+6B3FIdwTU+rXG/oOQKZqge
	L6aNmF0VZbr8MhZpkCY+a6zJ88ZIJG7nj5bGzAUxdmZ3drBzUwuvkTcWqL0fJE5T5fjgVjwh3Dl
	0LS2s6o6T7YLb6euZCqvdI6sj9xJd7zELq+6tdIR+
X-Gm-Gg: ASbGncs22eGs1R/KpgJSMTvMJ86SCQgoOyeSH1AbLyYu/WSUk7LVm3rBvap/a8u+x1V
	U6ruJERsf4/X5DGM0eYb51ksOZIXC55HrKo5yc6lSWusH0/W6gz/sAFKP9RX+FGCDYFXk7Zx2mn
	qUrjKNLa3z4s8yeRN0GjGKBrhyxuDCDYKr8tX9XMQ+6xo6apkzybB9z2dZOyvPvFCkdw==
X-Google-Smtp-Source: AGHT+IGkGSmzWaqzdcacUg1rh73ITkWfIi3UFIcuI50sB1Xh1R+hqsyy+JTTr3L5SQdC8TIRIuQ1l6xFRIqxN4fe7+8=
X-Received: by 2002:a05:622a:15cf:b0:48a:5b89:473b with SMTP id
 d75a77b69052e-494a3377caemr2823271cf.7.1747310695164; Thu, 15 May 2025
 05:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515100354.3339920-1-edumazet@google.com>
In-Reply-To: <20250515100354.3339920-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 May 2025 08:04:38 -0400
X-Gm-Features: AX0GCFtyI34RNd9GhGuI05YWT8By9j6fL7Cn74VOUX3djmct_hBdqaEr-Rg5sE0
Message-ID: <CADVnQykngURxudFtaH+vYs1k7P+udzhhnQiG9Wjbd8pfu6cMbA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: rfs: add sock_rps_delete_flow() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 6:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> RFS can exhibit lower performance for workloads using short-lived
> flows and a small set of 4-tuple.
>
> This is often the case for load-testers, using a pair of hosts,
> if the server has a single listener port.
>
> Typical use case :
>
> Server : tcp_crr -T128 -F1000 -6 -U -l30 -R 14250
> Client : tcp_crr -T128 -F1000 -6 -U -l30 -c -H server | grep local_throug=
hput
>
> This is because RFS global hash table contains stale information,
> when the same RSS key is recycled for another socket and another cpu.
>
> Make sure to undo the changes and go back to initial state when
> a flow is disconnected.
>
> Performance of the above test is increased by 22 %,
> going from 372604 transactions per second to 457773.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Octavian Purdila <tavip@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

