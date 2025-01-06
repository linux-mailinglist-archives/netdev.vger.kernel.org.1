Return-Path: <netdev+bounces-155592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4484A031E9
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F618842EB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E881E0B72;
	Mon,  6 Jan 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/ijbblj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE91E04A1
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198137; cv=none; b=inlI2J2rSTvWiRwt2/9mktiqaozgOmuk3C1hDDBtE0CQ2FIjn2f2+68LZy1ZJjVZoNIxW+pf/siy5OV1qNtj56r0ac5Y3qNsk0l5ygfzH0ju8EyDIBRB48BXrtqxJAcZGiCPH4+EDKoT5lhICNh83hYydVgdTzKBQn8D+FfOtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198137; c=relaxed/simple;
	bh=MGHRfNW3QYgm4KGcwcfv6bz6L1OC5FBtO1avcKkwI2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECSZxpU8Vxcp+2AMZe2IBIL/YU0VGqyVmToWhD8rQDcqitnW+2b6Vex432Os0rK8Is/cAOBlYVIdJNDLo6wXCRlnAOmuElOhpVU7QWJQDb+Er0zAX7UIo2WvRUjLgoF9KYp2FslVkZSBkUhsGDINODciQVwQv2Oud8uLOxQN7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/ijbblj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467abce2ef9so58731cf.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736198132; x=1736802932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGHRfNW3QYgm4KGcwcfv6bz6L1OC5FBtO1avcKkwI2o=;
        b=O/ijbblj+NnNHqFWik4iaT85GRLLYqE5jvo5SFTW7AhZYoTXTXvZ73qdh6tHnqVzwt
         NgjB2QKj4+ZV0qHtfyMZnXG1PzOsYd8FfiyCudB2yIzCUZ8SqHovXNmNItbuNAa2G8Te
         XAFbdl1BxxH+vxHao8ijNdMca+nfM3I6PAA26HUFYiial+T+hws53P+WV3C8uUWLm5KN
         sWwDXV3sFSogpWJQf9Wwswt/8BbwUS7NTSZAbMpZ7P7esb9MYhGgTXjFN3z/YPzzVYyQ
         cHOJX1kW2q0Uj9R9KfkNYaQeJsz+2BytO7MhyUnk4L94j7BD7URaujRxXiRD43+Kd4A/
         HZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736198132; x=1736802932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGHRfNW3QYgm4KGcwcfv6bz6L1OC5FBtO1avcKkwI2o=;
        b=TbY9EJjus5I+0+UI6S9WzLc2znxUQib26C24qUnERjDSMgO0yY0FGBPaZmxkVaTaAg
         fj1EeshZdPi1joV4u2AKT+LKB2sqlCznUUj5kRiaPwwzGIPv2fbHwysJXry6P7APV7GQ
         eDlSu2W98+yd8gDD9+RoNOroQGkA1aEHp/GNPt1p1QpUQ3wpb09zKq0yo5NG9UdKapc/
         lbDOGL3Qwdsc5XyDHcoampOEwdQN5MNV2sA3zEKKr9L+5LxOD9Nqv7N4W3OegZ2FPbyO
         iNF6AFHCc5r6uanMTPSlKp3bIweozaGuU/tVvb3KWOfPpCMrRLhEgN4lVIq5n+kvtyPb
         h4+w==
X-Gm-Message-State: AOJu0YyIIUlWqyCrgkJDI/4YJQLfmR8UAx52q1/qQZVmET3XNzOu3T9k
	lxmHC34GoeNQkJtqHfWuzGMmLKp3/7s+PWqRaSFM7yAHblHYkaR3/Qw0xKj8DEEnWGReuR3xMAJ
	ekLChJ5UEPy9scnA3z44qllz8RfbUXx4VHt0t
X-Gm-Gg: ASbGncv3Su8UI0yqzZ46oMEI45Id88K7CdsmGk7BNo8A15FoEErb88jwnKvHm1Y9Fvz
	hEErFy5V/zUgyRZvZZcXMjbNpl8ozpAVgcStLZTH28brnjonPo/8XFSpuDkU9Twz2BjNUt3Y=
X-Google-Smtp-Source: AGHT+IHFbo75Puxjkm64WI3YyLK5CsXwXyzyW8ExVEU09NWAASfSNPbXnzf663rHHNZNtnbRkm6Dnvtug0/wJS995yY=
X-Received: by 2002:ac8:5e12:0:b0:466:975f:b219 with SMTP id
 d75a77b69052e-46b3b759277mr650411cf.8.1736198132062; Mon, 06 Jan 2025
 13:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com> <d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
In-Reply-To: <d1f083ee-9ad2-422c-9278-c50a9fbd8be4@icdsoft.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 6 Jan 2025 16:15:15 -0500
Message-ID: <CADVnQyntg=3ugLxr+tdyb0A+=KDkVGkGPJVvFTOg0XpoyMSQEw@mail.gmail.com>
Subject: Re: Download throttling with kernel 6.6 (in KVM guests)
To: Teodor Milkov <zimage@icdsoft.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 3:15=E2=80=AFPM Teodor Milkov <zimage@icdsoft.com> w=
rote:
>
> Hello,
>
> Following up on my previous email, I=E2=80=99ve found the issue occurs
> specifically with the |virtio-net| driver in KVM guests. Switching to
> the |e1000| driver resolves the slowdown entirely, with no throttling in
> subsequent downloads.
>
> The reproducer and observations remain the same, but this detail might
> help narrow down the issue.

Thanks for narrowing it down! Interesting. So this sounds like
something specific about the way the virtio-net driver is handling
receive buffer memory, and the way that is interacting with Eric's
excellent recent commit to make receive window management more
precise:

dfa2f0483360 tcp: get rid of sysctl_tcp_adv_win_scale

best regards,
neal

