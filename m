Return-Path: <netdev+bounces-248847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07508D0FA0C
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 509AB301580C
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D03352C48;
	Sun, 11 Jan 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkrNUyoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11781DED49
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159143; cv=pass; b=Ff0PvPDsdizln7Hxt/fCbkfAkppRqCRMgdKFfO+2uiQXgWvSaQ+RDvKb5M2JFYQeqpvBgPzwvbs3V330oQ/Klod3ULdbj+MCpD39Md8O+tN1VZYHWkAlVG6uD2Ba8sm8E+BBbbQ90Bbtt+r8sSPyhjA8X1nV69NC+ldQsn712N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159143; c=relaxed/simple;
	bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V83gXd5mTQlgRMVr4m7VAk2qbKvEt4IRARrok3QW/Uaa++yoOXZIgC/i64dRRYnfCYO7hGx7KaNOeAsnBiIuiURkC8bcRM8GbFTOw/v15hD0fvakZvEgbwnXiQsv7VYpWV0cz9YQlWEzvtIA0vavzwou22UMtc//eHTGDuJoFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkrNUyoh; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b78649941so4157e87.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 11:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159140; cv=none;
        d=google.com; s=arc-20240605;
        b=k1Dp80Spk84MJuQI9Ivz2pDdQYtBo74ALfdsSjvD+/c4Gu2YZ35epwDpVSppoa8EhW
         g7U4McwI5RLtMoquQs2YCPDxgF3jiDu6P6Veqp3OgDQWjvQrDCtY+krJyB7TskzAWPqb
         YUSqA9goGfrBlcFpDkaEeQP9YxAEEtueyNqoMGp+iPz76NMh9n4KZqh6S20dKpVmS+D6
         uO3DVdlvkVhZmBSO4UplfPVj7hXF65FK19acqvpxIuXfVnlpNvYZWf0QuLAUcvqTRQad
         joyyJs7F3OXo1TVy4yCxce89THhGVV5OYRKYfWPPAp2neXNdOPu0t8V3C/S8LvBhrMmL
         YkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        fh=oxR1lQPMMg59gbbA+THuLrG/Pegd28Zc971Ji/AyLos=;
        b=PxGo87DTJFMZ1SgIv1WLsUyNBsHgoxKqnoqO1rIcUoxTKKEje/xAMZEckJL5DBBvlW
         H8q8Cc/UQb1D0+CguqaAP5C8WHawXF1EmQ7X6EKbDw5DeEkgw+Mm6eHxV7ebsSnOjsc2
         BDaL6IjmiCyQjN51ZwBJRDY18syRAcl45EL2jJY2BQcvVCEtSkMhgn+r4zxAJHfPPQA2
         zdQmDOnrydgm+P+NFNZM/TOrxpTlFj2A7RKJFGO1yQ/I9AJYef+sYjK+sgJd7cfqbWk/
         ODIf5a1DQd0uFxXCz0oS2TXs8/g2mSF7ZN7no82EedfXgsF9xs4hirpefjnMp7HJGLpW
         WIcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159140; x=1768763940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        b=qkrNUyohZvSHSSQfb1dbFsufEMZV0ZlZClceMW5DVsjpagf5Pvf5wsNdkEjj/UmiQJ
         5W436NtjCigmWPdV0nyuBxBeuyI0DqtjbJpPp1i6wbUM1wT20lyauk2JDBKyC1bjkxBj
         7iAy4DXJ6gjA3XWhygNWWeUK5t6/hkzgRzy9fBqppiHqrXpHwQfdIyIl2uqweFHbLIn5
         lob4ANNeFpvtDsvkEnkXN3ghjRBFX3bEtpdSK1vN68m2OdjSEqTyFIMe4lZiFUy0mdVa
         r66A6h+9FrdJ8xkCHEldeX7mD0NF7BY4S6nc1aUhxiKYDf0eCZeFdbPHYefxgH760T+J
         3JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159140; x=1768763940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3N2ccNOiCXPwAFzm5HRCPw881IHfs+lbmruDzyx/rw=;
        b=dV8kfyIAyTcSxpldXnBNzN7ZTqlgcPDthCC9190twWJ24MiuLKClaKArD+gYc6OrFK
         k97wws/JRCS0puIJjD187AQ5FxgBBC5WX2y2tet6R+QgLp3w1bVqrRHlc80d8+W/xTnk
         4n/yzBx54rjCvo0R+r1KvtM9qOuv9jSleMNYi3Sc6Y6QaqPkciolXhVbSWfU5CFnyQAu
         0Mk/gqqi0UIVPULQu+8k+Yk28i91XtVF0LNUpvzW/op/k10EKEkSD9f0EBghFr1lOBFD
         hh14YWe7JJ6SdbAq/3bBt3BP29DacebQtKs93bbutkgGTsOHxzY+CMNY3ceg+shW8fnf
         HaWQ==
X-Gm-Message-State: AOJu0Yw9D5GToA+Fu+thXGp8BhL8fmx7Djz3tLgLQZoGsgfOc+OwhzT2
	XIM+9OO3dPd4Dj3iyYDcHIySsUTsIFsE+50z5fMeeKWr4E+ADTpueVfazrpvQJdkpCS/Av8s91E
	wIXso3wAOv4ozSD7vJ+KMr5mljsqyD+NuSRQ8poRS
X-Gm-Gg: AY/fxX53qnygSeKL6nzfik+usNmZX+PEn1J6Bpq5yQcXA1jxAXEJtmQI+FbN77Z06sl
	1aXhh49KS0JzetE9T7hrg3FzUx+lniBdjv/to8JazeEM4SmoloEx/ipQnKfs9++V0ekrZAyqZ45
	vlPj28xahuzjsXdx/d2vcAPjziE0Q9ri8kmUwENVTkgVW0ni2l0f97/gTloE2zgDkvehIMETPJI
	4JerjgRbChZbE1zC5jp7/EJ/SMSpaWDBk3m3oopbB3fRepjjoFZzkbMYe2ox4mK4ReS07s=
X-Received: by 2002:a05:6512:639b:20b0:59b:57ed:3622 with SMTP id
 2adb3069b0e04-59b87c43391mr83611e87.1.1768159139730; Sun, 11 Jan 2026
 11:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223194649.3050648-1-almasrymina@google.com> <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
In-Reply-To: <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:18:45 -0800
X-Gm-Features: AZwV_QjQhMoevwA58NGfYpT2i-RPV2KkpfFJ2IlmuJKbZfsyf_TMKOH2OuGi6DA
Message-ID: <CAHS8izO2fjT3DuqHzQQiF2LUvcAPuR4Spav5Ap9wG=VgsAtDbQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] idpf: export RX hardware
 timestamping information to XDP
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 12:36=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Mina,
>
>
> Thank you for your patch. Some minor comments, should you resend.
>

Thanks, looks like I have reviews and this is on its way, but should I
resend I will fix the minor comments.

> Am 23.12.25 um 20:46 schrieb Mina Almasry via Intel-wired-lan:
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > The logic is similar to idpf_rx_hwtstamp, but the data is exported
> > as a BPF kfunc instead of appended to an skb to support grabbing
> > timestamps in xsk packets.
> >
> > A idpf_queue_has(PTP, rxq) condition is added to check the queue
> > supports PTP similar to idpf_rx_process_skb_fields.
> >
> > Tested using an xsk connection and checking xdp timestamps are
> > retreivable in received packets.
>
> retr*ie*vable
>
> It=E2=80=99d be great if you could share the commands.
>

I don't have easy repro to share in the commit message. The test
involves hacking up the xsk_rr Sami used for his busypolling patch to
enable xdp metadata and retrieve timestamps, or (what I did) actually
set up openonload with this patch and test onload can get the
timestamps. Let me see what I can do, but it's likely too much context
for someone unfamiliar to piece together.

--=20
Thanks,
Mina

