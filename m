Return-Path: <netdev+bounces-86221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A689E0CE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68A2B22493
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C915359E;
	Tue,  9 Apr 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9bihByG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FB4C85
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681527; cv=none; b=j+pZiR5MVJI/m+eQdf57Qyv4j1L0qgd0i0RU2DqQG4yf1mrQA1X93cv4fMgRQGKJDioFdIeHcGvAeAnj/8H+zwQYjyXTJUOmq/i4JTlwrBKis/vrlKJSHy+uzpWGd8tmHxzOPpspTR9d1ifGu2oJ0J6QCRYuv15NHb2jvlnLPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681527; c=relaxed/simple;
	bh=1lr/UM3wjrL0KqAelu/K4ScxRwvATHLQouS9Q/L2Omw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFj5cnjxJpmE4aa24dvHKUHVhuF8VL12WpaUp4ujSTZtSY06Nz8QcVmTW2LcfDcgXfpkYxXdShrh+lx2GbDt9kvqajM9R6uuNz6nobiXO35LG32C78xdLizudwcqoycBsSQqDTDxtwbbQnQYh5k89ETWNCksplTa+PXc/8Q/t5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9bihByG; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4daa69dfc27so1941157e0c.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712681525; x=1713286325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYgP/c9UBjJsZFr/BI00c/Pjj6uDQiAOLQ9P/OZHt8I=;
        b=o9bihByGgfsQkbF97U5mo7omBCkiBZ1f97IvdGOFt5iZ3qfHAlOIbnGN2qm0U43CRP
         rmJLFqFgpcJUj94fWS3Net6sOdFC0dZJqgFTRCPDplIDpAznilMxV1waQGK2wyIfTTpg
         qiw6pCJ5+frQZPTSZz2YR66vycVocPOAbJxAnd7crXB9OX0TKRd5m1Imr1TWOwLU8SVV
         jDNoJv3mUyMf+t8saqSUU0QOX1hfRqpSiriG0bWXsmkot+Ss5IIcpxOGkz9bL9TcQg8Z
         fS+zcrv4G66PZdCXsuKxCgCWdrl+E0AIOvy4Ztp8kHkCSpg9yfTfWdoWik7n3Nxnk1Jx
         73IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681525; x=1713286325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYgP/c9UBjJsZFr/BI00c/Pjj6uDQiAOLQ9P/OZHt8I=;
        b=gP0Iul/tP0O93cqDN+SD0WkOnqbjhQIT/H9ne2yrfpU2QuyMdn3cBn4BaAlpAyVSGj
         XfpYRtLkkkCmD5RkSpgE/9faehGdfu0gzaAPLMRCindyBWMPA8mfaoI8gQhTo5hZweSN
         Hyt1UTbBgBOTDCPMVlG5Xr7cK2O65/vv1qZOr1LqCXryWeU29SI7GIPRsiRywOzbpGDN
         6F94FfmLkmUT673oDGtmJ4MXZHIb5ad9igzRSQqD0j6XgbbGjittwY9m6qN+pvQN+H/1
         3afqsXcB/hE1TgJJ5FVMco5WHZpTzIb1JLfVmuYylBT+JXZUm45yfTsSlN02HJ+uNnpN
         kR2A==
X-Forwarded-Encrypted: i=1; AJvYcCWkUYY+hxxJS2JdyV8HkEWOsnVLcGju4TawFvaiL7RoFiKkknMRAv0uU84BjqgTnDK+As1Ut9MGp3bVyjrj8jycgShFuGFh
X-Gm-Message-State: AOJu0YyT4brcS+kBogxJte2itGjZQ7yepOfMMhiMUb/M6/CKDdwNHBho
	dSi51vuLgirYFS26VgUKtltboDwJiNIj0vx42LTU3aQiJuk0SEbWt2PcHt90CkBMfHgBaTX3sqT
	Nxy3BQdcdBxtOHVghxflHnE5qqTBOHAw4OLMG
X-Google-Smtp-Source: AGHT+IE2f+1NjWK+g4treFiL3amuP/KRs1eNQ20tSVvRRUFOVJI7q5Cv3a0FEamjYxXnqwMFw8Hi/l+QKojf0i5LjUk=
X-Received: by 2002:a05:6122:a0d:b0:4d3:37d1:5a70 with SMTP id
 13-20020a0561220a0d00b004d337d15a70mr397783vkn.7.1712681525018; Tue, 09 Apr
 2024 09:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402215405.432863-1-hli@netflix.com> <CANn89iJOSUa2EvgENS=zc+TKtD6gOgfVn-6me1SNhwFrA2+CXw@mail.gmail.com>
 <CANn89iLyb70E+0NcYUQ7qBJ1N3UH64D4Q8EoigXw287NNQv2sg@mail.gmail.com> <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
In-Reply-To: <b3kspnkcbj2p3c5q6rbujih72n7vouafpreg5mjsrgvf4fpu52@545rpheaixni>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 9 Apr 2024 12:51:46 -0400
Message-ID: <CADVnQykMeQDbUg4H_xbL=7o95N76bKhO3tz=Pa46-H7O-bm-pw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
To: Hechao Li <hli@netflix.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, kernel-developers@netflix.com, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:30=E2=80=AFPM Hechao Li <hli@netflix.com> wrote:
> The application is kafka and it has a default config of 64KB SO_RCVBUF
> (https://docs.confluent.io/platform/current/installation/configuration/co=
nsumer-configs.html#receive-buffer-bytes)
> so in this case it's limitted by SO_RCVBUF and not tcp_rmem. It also has
> a default request timeout 30 seconds
> (https://docs.confluent.io/platform/current/installation/configuration/co=
nsumer-configs.html#request-timeout-ms)
> The combination of these two configs requires the certain amount of app
> data (in our case 10M) to be transfer within 30 seconds. But a 32k
> window size can't achieve this, causing app timeout. Our goal was to
> upgrade the kernel without having to update applications if possible.

Hechao, can you please file a bug against Kafka to get them to stop
using SO_RCVBUF, and allow receive buffer autotuning? This default
value of 64 Kbytes will cripple performance in many scenarios,
especially for WAN traffic.

I guess that would boil down to asking for the default
receive.buffer.bytes to be -1 rather than 64 Kbytes.

Looks like you can file bugs here:
  https://issues.apache.org/jira/browse/KAFKA

thanks,
neal

