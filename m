Return-Path: <netdev+bounces-214734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D9FB2B1E8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF05E2F25
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5842749F1;
	Mon, 18 Aug 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrbS9FyQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED2274676
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546837; cv=none; b=nfvRRcelSmE3JPOsu8lj71UbslYu7/ymX5OuL2gQ2DTuQ+Dsy/BVUxZHaMGUV+olstDd3k7xwdTUDkVL0VmOHNxhEgU3gBxzXhpV8gRMuj2VlJ05EPJvJYLmroMSWxgZLig3+Paek2oSAjjRawIEPDUX9PmcRDRsV7QnY/vBRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546837; c=relaxed/simple;
	bh=FGXskxNyPi+kSWldZTuknSS/UbFBTGJPtmONfgnDfyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0QW/IyW4ZbcJOH6yjRUmZuT3JrukxndV8Fo6Se8Tr41RXJe3uXD3OjVuS3RRqkKLeg5l4tvVeuF5/3zeUv87c0+v1Ozi8csUSU2YxUXA4eGMjs2PgqETLakwzTgPLZWXv3BvZ7Nhr7AGepbA5AWGxlL9sySAl2+N1orvGe9PlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrbS9FyQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55cdfd57585so388e87.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755546833; x=1756151633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ktUFIX7oYRVV6r3VBowe+e8y/dA77n0Sl2buDMTago=;
        b=ZrbS9FyQvI1VOMvGxKXb721auWGqb++14i5Y5ghJKcoVAzM3iKsdNX4O7HWLtbbIRT
         OZGt+PEqPY0sqMfPumLooelndWLQ/eRa78XfPTDOIc6V3jdiQGzVAFTNzq/J4ng8MGKk
         tF7qF9JaOa8qtssGJ6y5QF8rxI+wUNqTURiuf1iwqDc4DjuodPyy4XrWp2mD3dgc4AM1
         QSlXMVHc+QtdP9coLU+1QOFj48AmNr6MXAjKZvm9PwJAYW+Jsk9QeaiHh3vYh7Gx8EXq
         /AqIcaOFzsNqVL9Ty3urbZHPNPqQiSZUivTkFARhQSIW05yh9Uz7xeoeORlorOjHP7in
         3ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755546833; x=1756151633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ktUFIX7oYRVV6r3VBowe+e8y/dA77n0Sl2buDMTago=;
        b=T4VJh7pz55re/qY2whuJyQJMB4rdDQM89xnxMvFBpxL0epRad0WHFIwA7SkxbK6fBb
         ZIK7g4FAXVrW6McmA1IDYboU/Bsaeg43GA3zcO/Qd38YXlPE/Nf9jBUr0dddjKCpNHQR
         UL/wNgKq7lpNZrBTPMi/kMZkWb5b3mb6ibzSnilCgJTuLt79r75OkLZiQODDH4Mg6b4D
         8bOalOR88MvUInCipd/moR+KXqIFMsM+RL0RnU++F6qQxh6LyWUJUdgw5oH03dv4v+T/
         cU0BE9fVBG4xdpTQrYejfVIlX2jaQ7pbY2e/koU9qqvxgRw6lyCZu5+H8ywySTtmk0WX
         Ju1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6GeWKEt274BaxVntZkQuGxdFiQh4PTrBmFsFK+jT8VX6cacFHTIHEiGFJEiNCEE9H+YtTto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7/8vfZfO8NbhB7Cn342Ex/zRDbxQhGcmo0OYGTMAyl8PWkVh
	uGGR/soja9TJ4uPvci6MdCtIlgpbxi+dc+HVtPv73Wj2iyT0HnOYt80+kPRl1Tb4LIVEIKp+gzr
	MYOgajaOFEeqSwkevhVpRTNAdBtn5VLfmx3cTmMc0
X-Gm-Gg: ASbGncuAYZvJ6Svk2iBAoqNbG0YyT0UBH7YU2xeEzrTTeMMlWiTRH29u4eZB1QXaxxZ
	4QkTQcg+XQdmb6RAXZDf2bSuXfj2x3oebBSwKbxh+gknGNyIhlsAhNjgBcl5T4PVKlFbQ+V+X8h
	6Ck89HF4RFhFzaEe+kkFZ5riozUbrMmuQB/Co/KENxW8FtvlbW9awvfhmReKfLrN8grfOIgmJeQ
	hjaB4ZeaguIeAd8uar/0z9t7jG0xmnA6a2GK0CFwJ9XTikEjrr+ug2AsWrsiq4Phw==
X-Google-Smtp-Source: AGHT+IGAE0Ofc8PX8nXcHcZR3qsDCQCOVXp10z80sSZ1JuUmeHOv+0TcOt8kWreETfSTqUqrHmJGBVsvzBnZnmXWA8Y=
X-Received: by 2002:ac2:568d:0:b0:55b:99e4:2584 with SMTP id
 2adb3069b0e04-55e00965f92mr4105e87.2.1755546833191; Mon, 18 Aug 2025 12:53:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815231513.381652-1-kuba@kernel.org>
In-Reply-To: <20250815231513.381652-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 12:53:40 -0700
X-Gm-Features: Ac12FXyS1Q2NODm60eYKB3--zRgbzyZ3ktDzxZ4Bi8tGADJKFprlw8vjHfq1Pag
Message-ID: <CAHS8izPa8=2=u6AcrUKEOecuQSOAmwcsXKXAXtdE9tdAJhVGoA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: ncdevmem: make
 configure_channels() support combined channels
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, joe@dama.to, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> ncdevmem tests that the kernel correctly rejects attempts
> to deactivate queues with MPs bound.
>
> Make the configure_channels() test support combined channels.
> Currently it tries to set the queue counts to rx N tx N-1,
> which only makes sense for devices which have IRQs per ring
> type. Most modern devices used combined IRQs/channels with
> both Rx and Tx queues. Since the math is total Rx =3D=3D combined+Rx
> setting Rx when combined is non-zero will be increasing the total
> queue count, not decreasing as the test intends.
>
> Note that the test would previously also try to set the Tx
> ring count to Rx - 1, for some reason. Which would be 0
> if the device has only 2 queues configured.
>

Yes, I think that was a mistake. I can't think of any reason we'd
really want to do that.

> With this change (device with 2 queues):
>   setting channel count rx:1 tx:1
>   YNL set channels: Kernel error: 'requested channel counts are too low f=
or existing memory provider setting (2)'
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--
Thanks,
Mina

