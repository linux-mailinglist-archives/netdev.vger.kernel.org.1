Return-Path: <netdev+bounces-98881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A598D2DBD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115AE284D85
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B116132F;
	Wed, 29 May 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H30wK+U1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246515B14B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966024; cv=none; b=dRPIUKNe//jV3aaZ+jEB8d2NJeID9JhOGkqWcsWFDkNYno2j36199HhSn4u9/AP+XXCreIoI4cFCX5dfh2n20BPqyoS6QEDjhrd/uBDpV1QAi1BMta+0UuGV+dbsXEXmVAN6/aQ/JRjpD9nqYtJI1zVIqcS93z24Q/40T5GKryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966024; c=relaxed/simple;
	bh=kNzGTfsB3mWhz1/3YBpknN1wH+6Q//PB3/3M/oDyDcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXdU6ZcOEkUsu/0MexhYgPB4uiF0WGUBGUQoTwoTk+bOneNguJCL9jCbv37vtHnbhdERHrj3lTqi0VJZYnK/1BEd58EK0UoOL7vnBY8bbYuSzJfy7r0828VR/ok1rfIk4MzwtW6d/pPfgQyn0aawS5JMTtwlOvDv2QJE0YEojF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H30wK+U1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a62ef52e837so182210266b.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966022; x=1717570822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXRpLcfynCTw0uGJaKR3sCTPaXEArIBCK7zv03cgS94=;
        b=H30wK+U1yfVE+DfDTJ4xgkj0iEEo8Od2LCBRZ+R4tYEPT4rQN2sbKW7eN7dL6BgKS0
         +znOVLUvRQt2EN062ezdcovE+plUzNnQZ5EaKkvIBslHCVQDtcToeu+/yTIJKFsY9Skg
         L/OvMiyv/UvCyNpvxC0kkoajjmnrSvQsOHWot4ukkEH/oVKrSzI0RxI2++ozqeXqHj71
         ouMm5SuXC+LwVIE0zokOKad1xw8z308yonSx0WcL/zbHUz3bDCzNvfLp3alMKY+Hq+DM
         ZwTO8lOTrTjVOYpobHYkNNV4bVTnqCMCF4VZJrLqcqK/oD2yOPyxDMyaRMWJIy4ZgY6C
         ZJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966022; x=1717570822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXRpLcfynCTw0uGJaKR3sCTPaXEArIBCK7zv03cgS94=;
        b=TDauzjuIQRtiPBmPyAZA/78D+MKE2hMvnYthz9T93lESh1QguaW3Q21mnzp4NYMbD8
         BBR13+J76zWHNXwghdeueS4C7Y+Lb3zWz/qzmXlIReEC7oT6Dq7FBCjQJebviMTdDdvq
         R/wVvZyBGfk+I0THCAvFpG8cbsltE9JD7RuFEF0Bsr94PoXWnNGHqqsHzRzf3w3QfpZu
         9Ne09f4n43lGfdFBvPEVLrzABGF4fzjmzxf60KqoY/65ZiT76f7+lnxRbGb82Hb4f4AW
         84DCM4897G7ZXLHQsFSCt5TQLUmePOump0jXkZWdL26t0Em+4W1KsvkJRGVD8/5TJZXY
         CnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBRbAa//KNUQaAhJQ/JCR3KrRtVhVZItmWxr4pEPX/qvyAD/wdobLhAQIFMeqxQNbuwNyy904dWbr+2I+tCYKi6oYTm20m
X-Gm-Message-State: AOJu0YzFoqqhO6vbeLtI7Fh6XHBr6f6O7XWimREuYn9LeO2ooD0F7NDM
	Fi/hdJfJW0GNlYPksdm/1fKvOBjvzHtuPpDkMyhC3FbV5vzMrdbe6FWdZtIBGe40nWsUzsRYdMd
	FF0s2HUXmEnICuIdFSxGI5VJZk5g=
X-Google-Smtp-Source: AGHT+IHVcNd5SSW/dpHZcNFYmogdHCkmnJf98LRpy0E+S5JzeulE7TeFgJzEDGxJFAIqRGjmEnkT4y2/J+CS2avbA6s=
X-Received: by 2002:a17:906:40c5:b0:a64:255d:6e9b with SMTP id
 a640c23a62f3a-a64255d6ee4mr86484766b.34.1716966021459; Wed, 29 May 2024
 00:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
In-Reply-To: <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 14:59:44 +0800
Message-ID: <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Kevin Yang <yyd@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Kevin,
>
> On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.com> wrote=
:
> >
> > Adding a sysctl knob to allow user to specify a default
> > rto_min at socket init time.
>
> I wonder what the advantage of this new sysctl knob is since we have
> had BPF or something like that to tweak the rto min already?
>
> There are so many places/parameters of the TCP stack that can be
> exposed to the user side and adjusted by new sysctls...
>
> Thanks,
> Jason
>
> >
> > After this patch series, the rto_min will has multiple sources:
> > route option has the highest precedence, followed by the
> > TCP_BPF_RTO_MIN socket option, followed by this new
> > tcp_rto_min_us sysctl.
> >
> > Kevin Yang (2):
> >   tcp: derive delack_max with tcp_rto_min helper
> >   tcp: add sysctl_tcp_rto_min_us
> >
> >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> >  include/net/netns/ipv4.h               |  1 +
> >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> >  net/ipv4/tcp.c                         |  3 ++-
> >  net/ipv4/tcp_ipv4.c                    |  1 +
> >  net/ipv4/tcp_output.c                  | 11 ++---------
> >  6 files changed, 27 insertions(+), 10 deletions(-)
> >
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
> >

Oh, I think you should have added Paolo as well.

+Paolo Abeni

