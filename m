Return-Path: <netdev+bounces-229456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE2BDC974
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3553E4E55CC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28330214D;
	Wed, 15 Oct 2025 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZlJosagQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FF2D3EC7
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505469; cv=none; b=TV1lXys19Brk9iejwTIh7pndTMGVoSzui/H6qtbgno0EY8Cke+Z8wtkQNttMQ/R9gvdgMCz3uAhAJ9loS+ammsKwAsqHcn5ad6vah2kVgdEiwQIcU+/KfRXbQo3tWkDq9Jukc4uG1qpx0SK5iBND9iwPb7mxIkKIdUPvlQAL/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505469; c=relaxed/simple;
	bh=sW2EkWYty4TqIIIozFdnB9LR/4D4aFQ/vJdp1EEpNmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQDG+5bPdo4IJSdH/b+ZN2/jnpXeyXthqX0I9/8kiieUFfY3pvcKZt3Pv1XrHzeRzGdTeILx/Y3e7yA5fJYUshCMzkKSDfNNDyscWUBu12T9sDP3aTfpY0ESl93RvCNTw/HK9tLsmMiJjKOGWmNblGpcZa8xPEu968H7en5PEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZlJosagQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88e68c0a7bfso34206085a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760505466; x=1761110266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLBmb50auxeEeQdpqgB8+uBnKMw+hlM1UtdT7FG+Uvw=;
        b=ZlJosagQX9OeyOhpUm+yOV5HwIQAgu1hsi1aSbugOPPlF2UEC0K72uzJ4ksOvs45uj
         sq2knOOVVjFULBHC0oHn1RoCZGa4bOOFrI5V36YeuGL78TEpUuw8pVOr8FGYn0OmqsnN
         KYssb5qAbIwNo5uzIprDJh2f93iuJDhXvkY7ytN3pwCcHyZhniGPKsBUdYK+zcpV1dPj
         eCON3WtdohTSu0NIfKbndIaouc65oEGwDQwj/dBWwbCTBDeMS8eJcrU3qwVUhO9qLItk
         Syq5YHEibmf4dtrw9Jie4G/yezA03sttKN1deluz+bPcyn+U/vT545XA2OpWP1xVXEr5
         HtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505466; x=1761110266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLBmb50auxeEeQdpqgB8+uBnKMw+hlM1UtdT7FG+Uvw=;
        b=Jy3WWoW2nG9FlC5kvJVSfa6goCmQPV5LERKFCdYrXqHI9XOXIoOPXzf83m232vqMEy
         bjFZ59IyOIDTzgMd8/KIxoqYG2lEWs5AzpHx47DQYePXfYkj7V1aEylNrKGDbQ8zlKtF
         JEzM2N6j3LH8Kkt6DsS3NS9vhEqUKdmN4yQK4xu20enYYNf0y1QARjzoBMSZ0xlEt1dy
         jzUfmkXkgiEHCisId+28XxnxpnvzleJCoOCTbffPelGboe2KmJzXJ73MKEr8fxl+vifa
         grTqe9ngbojPrnL7RUJGWQjxLww9m5H11W4oqv4IxaNBahvbzv4xqZvbqtY9jSHss1+P
         CSbA==
X-Forwarded-Encrypted: i=1; AJvYcCUGvJgcWnGBhZB2B4mthmISKX0ZlYUdsyGHtEL1EUNerATQI5SY5xmBhqeFUb3Lac02gJQzzUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMWFP2QoD6xsV7HvxTkiODbHtSrqrTyI7050YynuazF0T4sM+
	OJuiOFdLB+cF4HaH96wnWzFJOPzd5+Vxcb+Pfw6NLSMSJC/sheimZngYZGvHKXjj/WJoxlbm8bD
	89fKSUAdRiF3Pz+12jX+TEfMLSWSnhC6pr+IlbYGO
X-Gm-Gg: ASbGncs8lgoWjNWnjjHqN/o0PRYUEdjGE2rw7Jjhbb8RukGRbjMTM4I2+w5dTOWepd3
	+zDMXVKsfhTjWVCMXR2vvQVbD42pbcfOICGbsarI3qrZ4ksyM2OlbBQ6ZYm/Dc1R6zeT8BQgiUQ
	zAoW4zqCGZNZb57Bq0rhftIvNHI++NfLzgHSFc68jwDXEJZwo6ng4t9crKJl/5+Gi4kSJiVnvAx
	G9NO8ATrKdkKJ5/mpud+lt2aneOpOFJjwICWzZI0ERc
X-Google-Smtp-Source: AGHT+IGDWniU89pgwjBHrC1ZpYMkSVaDZQOxI+Hp+JEl63Ox+QCyC+kX0TcT/qZSYVF4F1CTAtcsRNpumu2WkATMqwc=
X-Received: by 2002:a05:622a:5914:b0:4e5:3418:3db0 with SMTP id
 d75a77b69052e-4e6ead4c550mr376365421cf.50.1760505466124; Tue, 14 Oct 2025
 22:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <20251014193431.534653d5@kernel.org>
In-Reply-To: <20251014193431.534653d5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 22:17:35 -0700
X-Gm-Features: AS18NWBw_uAmkdCStJ7FdABggvzIsXAOKtcgM3AoF-bO7np2Iu7t6ttBoNlnycc
Message-ID: <CANn89i+-N2Z1ASuUhFM8nC0AfJg=Lg4sQ8OccucuO7BEDvitUw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 Oct 2025 14:59:26 +0000 Eric Dumazet wrote:
> > +             if (val < 0 || val >=3D (1U << (31 - 3)) ) {
>
> Is the space between the ))) brackets intentional?
> Sorry for asking late.. we can fix when applying.

This was not intentional, sorry for this.

