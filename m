Return-Path: <netdev+bounces-229319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2CBBDA96C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E391B1884EE0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E50626E143;
	Tue, 14 Oct 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udkqaOU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38002877F1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458599; cv=none; b=PQFR0D8I8PabEKNMLbSzsNV+FKfskYOqeqND6ewVvlpAwXJIPMyh1qkJj9azsSHpdrWhgOhalbn4oz/RIPx5MJL1IG7F8OOw/Tc2ahd+H+V969wdovg47vbX3LYmo1KplC/b4qLlxnWpbKV7m7DKBj3NYGmkhPuCPANqtcD+NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458599; c=relaxed/simple;
	bh=s3pkH6zfccN31ijVKrMcARbJFkyIgh/mXbPMKJ2bShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLvH3IvofHKL0G6iw2P3YnbVhxVqSuSrvQ7iEqUoknHo07U4G1dNwX7f98aCrhnpzsWr7/eEmViub+4iv3n/vbwjgJom8bNvPWQrhdj2sP4sefEQCdmrcrWZlarnqWohyH1zYU9EfOwikLnTOOOtw8ibCIr573BVqU3zljzqlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udkqaOU+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87a092251eeso614826d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760458596; x=1761063396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeoOV3TUNHsNEMdu6DJVB0VFGfN/c7XOb6wGuPiBzP4=;
        b=udkqaOU+Ff6/waOf9oWrX75ViMh7Tz6ERI9omlbBnjqKpcf03LTKbLNePMCpAJVVGT
         zcGLr+zYmdXb3LSwIlDn0hQPvVcuNL+qMW1R7qqVUbjfdrtV7f37UwxOWNec9ENMfKP4
         On6t/yiO4lEVmp+3k2fOa8nfiDSKrvdDKOP4DkR7teHnwwKsXc6uDx8aBhobR8BJuHG7
         oQgdnnyn7sa3+QlOV8SP6L3Hpoc9Ej5SykmcCVa83fB9PFSSSti9mO4e013XLJI4NV+w
         6k/szrzyT8yA1OvGOZqfnx3xowzzg6obOezCoG5GgNKncbhVY102BMAHsdExD+K7weRE
         fgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458596; x=1761063396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeoOV3TUNHsNEMdu6DJVB0VFGfN/c7XOb6wGuPiBzP4=;
        b=OlL9tTABmzrMcqwdJSl3hMpq109VnuUB3/ayaVPIjrDzeT6/arH4Idphk8sFlzum8L
         ZTFSaNNzacFbVXTriTouS+6oVjfBAvUWzw1bZMzxDHeKTwn8iS+6jWNWZdGHew78zpZ/
         xD3fqlZp8qf9XuVsSQSYWVHnV1cLCeB5cseFxkaBMNKcNEI7ekyah/YNe55YzIJO+EM9
         DW5qOw7clm+MXRG7y/ChKwi+wC1IRt9NgnGGJQYPUDZMatHSZhvinWJh6y2n3vWKPrFU
         ubH2gHweT9BADeYSIZjCRz4X2qA00OnvbuqTp27wG2KQeYr+MJmSNMy9n+ueSqLEyGCU
         UHUg==
X-Forwarded-Encrypted: i=1; AJvYcCUw3ssjn3GgSOZWa94hj058lnDFTrOhTp84neiD7BXFu7xL+vGxBXjuJDJ31xg8H9q04/IzdSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItSDTvahsaNnnQ64+ZYeKYTLWebcKAxqvAOkiUXooW7H9E+Ja
	7iqqCHoBKzrVfxTB6o+QbZXwR1O+PxtfF/ZxkTpqZLh4JAPIVYeYqD6YtXMy0hz/Wy27T6aApK0
	wcZVMx2AstCPo0FngGaUR9URX8oozcVDMuXIj0m2U
X-Gm-Gg: ASbGncuH70ksmyMRI6s3HRirQVG5AgvUAswgEjZjY3reP5swwkpfizbPJbA5f4loTqJ
	r5js8S6HasLFrACeaAyuBEdJcZa0h/CyYBIbb1OQdoga++qf7btRW5sjOzGGKPXSiGPc4V7EmSo
	wC+0OyeHZd2/3ATjG6UsX3VUuKNWIkK9+BYuXQnlT/Jky4GR/X36tx2fKY4053/3Y/KB22CFpLc
	85t0DEGq7kQwOtTKTwM5prpTSdKc0Z7
X-Google-Smtp-Source: AGHT+IHGWTSeHM422l64IMo7RDEu11btjjbwf1KlYQJ9k1NVqCiVqC58+gaL+ud8B+2tWIT5iD76p9krTK0IDNDZBJc=
X-Received: by 2002:ac8:5990:0:b0:4b6:18ff:3630 with SMTP id
 d75a77b69052e-4e6de868742mr398903741cf.24.1760458596029; Tue, 14 Oct 2025
 09:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
 <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
 <CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
 <ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com> <CANn89iLyO66z_r0hfY62dFBuhA-WmYcW+YhuAkDHaShmhUMZwQ@mail.gmail.com>
 <20251014090629.7373baa7@kernel.org>
In-Reply-To: <20251014090629.7373baa7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 09:16:23 -0700
X-Gm-Features: AS18NWA8nvcF9VdX1ftWKrfuYZnSi5C2AH_6bdfahqV3wgP-wZem1Grjb9XuH-k
Message-ID: <CANn89iL0ZjuH-YiuBbm2+s_2adQzVUVOi4VYDvwGBXjTBYHb=A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 14 Oct 2025 02:40:39 -0700 Eric Dumazet wrote:
> > > What about using a nf rule to drop all the 'tun0' egress packet, inst=
ead
> > > of a qdisc?
> > >
> > > In any case I think the pending patches should be ok.
> >
> > Or add a best effort, so that TCP can have some clue, vast majority of
> > cases is that the batch is 1 skb :)
>
> FWIW I don't see an official submission and CI is quite behind
> so I'll set the test to ignored for now.

You mean this TCP_TX_DELAY patch ? Or the series ?

I will send V2 of the series soon.  (I added the test unflake in it)

