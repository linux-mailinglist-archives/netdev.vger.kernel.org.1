Return-Path: <netdev+bounces-105709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FFF91258C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AAB1F24504
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C469C1553B9;
	Fri, 21 Jun 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBdmyQhq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F61553BF
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973324; cv=none; b=F7TgqMkjoFXhYmqJm/fUHoR3fiTvPp9lChh+wKvHmngsh2itsy2zy9w1jJ7Rz3z/KOYAQFIMZBO4uQHiaBsMVdKBsTRd+XdwT8phfQcW53zNpwmWtVHwl2NkoaBYzDMjZfX8kBTExhjb4pwaDytFOVVivXRjnqoS7MVOLD9LcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973324; c=relaxed/simple;
	bh=F1ll4sOIvCBXD+ONg7YMytT6dGxSUcFFkrx7rbA2UqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRJqZnH6pBZzma8ZH8rxohGAnb771xLgpLuQwuTbHfWpoVC1CzoIjOSUt0SNhdEKxF9wew7iTE8J6oG26ef3OpIpC4aCcAclb4hjkHjQAjumT03ILFvTtXkzqxaI+pYTUqrU8xBLwf+ojYQdhjhud+i46fWLbh3DpW7AYJNhE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBdmyQhq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718973322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DUOo6pncrLLfVNELGwFTwFChqLBk3YLyQi1FlWq0WU8=;
	b=JBdmyQhqysWnsm48Y9usOGtgoB5QjhywOuSWqrF6qHrRzuTeNffogSHne1IcH8CvjhX+u/
	nWAeZG7j4wk932QAjAR3HHAzO5/GkmuSV7ZYaBkKuobQ6HeKCa04L9k8r4DcFc+DT8e88j
	eM3dUHTK2igYrUm+LTAihen5sTlbo68=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-FqgoZRxVMmuYt1esVy2mgQ-1; Fri, 21 Jun 2024 08:35:19 -0400
X-MC-Unique: FqgoZRxVMmuYt1esVy2mgQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-63c88ec6b76so33616047b3.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 05:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973318; x=1719578118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUOo6pncrLLfVNELGwFTwFChqLBk3YLyQi1FlWq0WU8=;
        b=mpj4PUrLfGchIbFIlkx2Q7z2SbMwwYhh2/KB1mTWXTIADetbB23zcHyjCHKqyfAfMs
         ylguDV4yJCZBg+oi8+OQm7a9Fd1pxYotQCSYkazGXYWb8xAwzYb2fEMaYEdsZ+/UMZTH
         qPNTmGwf/vhNxDZBytgS/flVeVYd04RXYvvhqIKsoAvq4I7NJa9oVN23GmkWc2EEp7FY
         8jXPwu/z+HfhI4iNMBD9vUiaFMuBWKl05gQ9MLSB+WI3fi6yLrq0k0ZrYtWWulV9C1vv
         bcs4hNBg3dGd8wWBB3LB8IO+g5VLUbClWL8gMjAVA437Y8KqVICqF6F5a69+JirKNs3U
         9/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVbp2j8Ij5d5ZDbDSEoXbhIGPIsgfOkR9604640q+jsAGy5fnVkSDSdHj+ChujBEzBA38QP46TQ8xSHwx30Lj8d4cPnNTF/
X-Gm-Message-State: AOJu0Yx4kkdMCvVsTaHGYJ4gAxuOkd0Z4k2XYamAn0K/kGVqDiSak7SG
	cX5tVRNHvKAUnUfjF15U00x/pGJoJNIBvPhNMaUxBYUucDWiVNUxo6OTVkFnsnpFlb+hXOJf80P
	vRY2qFfEvH96ccKmQwTwRDUtImIIbWehDXjIUfpgecp4Qs+8lM+DxvFzhhFxMs2nM6kSbwy767Q
	xzp6v8CQZ6S7f6TN5JGzrkTha7lMjx
X-Received: by 2002:a81:7282:0:b0:615:8c1:d7ec with SMTP id 00721157ae682-63a8f5243f4mr82320807b3.33.1718973318122;
        Fri, 21 Jun 2024 05:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg4AV3dsomq7cAZlPOVhXZ/8jwkZGHBKMxRoERWq1isJ0a7oog8UYUJOo3PkY6knHJsv8OaMe5ENGVL/P/agU=
X-Received: by 2002:a81:7282:0:b0:615:8c1:d7ec with SMTP id
 00721157ae682-63a8f5243f4mr82320627b3.33.1718973317776; Fri, 21 Jun 2024
 05:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk> <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
In-Reply-To: <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
From: Samuel Dobron <sdobron@redhat.com>
Date: Fri, 21 Jun 2024 14:35:06 +0200
Message-ID: <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Daniel Borkmann <daniel@iogearbox.net>, hawk@kernel.org
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hey all,

Yeah, we do tests for ELN kernels [1] on a regular basis. Since
~January of this year.

As already mentioned, mlx5 is the only driver affected by this regression.
Unfortunately, I think Jesper is actually hitting 2 regressions we noticed,
the one already mentioned by Toke, another one [0] has been reported
in early February.
Btw. issue mentioned by Toke has been moved to Jira, see [5].

Not sure all of you are able to see the content of [0], Jira says it's
RH-confidental.
So, I am not sure how much I can share without being fired :D. Anyway,
affected kernels have been released a while ago, so anyone can find it
on its own.
Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
don't have data for any other XDP mode) in kernel-5.14 compared to
previous builds.

From tests history, I can see (most likely) the same improvement
on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
(partially) fixed?

For earlier 6.10. kernels we don't have data due to [3] (there is regression on
XDP_DROP as well, but I believe it's turbo-boost issue, as I mentioned
in issue).
So if you want to run tests on 6.10. please see [3].

Summary XDP_DROP+mlx5@25G:
kernel       pps
<5.14        20.5M        baseline
>=5.14      19M           [0]
<6.4          19-20M      baseline for ELN kernels
>=6.4        15M           [4 and 5] (mentioned by Toke)
>=6.10      ???            [3]
>=6.10rc2 17M-18M


> It looks like this is known since March, was this ever reported to Nvidia back
> then? :/

Not sure if that's a question for me, I was told, filling an issue in
Bugzilla/Jira is where
our competences end. Who is supposed to report it to them?

> Given XDP is in the critical path for many in production, we should think about
> regular performance reporting for the different vendors for each released kernel,
> similar to here [0].

I think this might be the part of upstream kernel testing with LNST?
Maybe Jesper
knows more about that? Until then, I think, I can let you know about
new regressions we catch.

Thanks,
Sam.

[0] https://issues.redhat.com/browse/RHEL-24054
[1] https://koji.fedoraproject.org/koji/search?terms=kernel-%5Cd.*eln*&type=build&match=regexp
[2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2469107
[3] https://bugzilla.redhat.com/show_bug.cgi?id=2282969
[4] https://bugzilla.redhat.com/show_bug.cgi?id=2270408
[5] https://issues.redhat.com/browse/RHEL-24054


