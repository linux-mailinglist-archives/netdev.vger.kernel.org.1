Return-Path: <netdev+bounces-73346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A385C061
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DBB2167D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87F763E8;
	Tue, 20 Feb 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4XFZpdK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5C76052
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444414; cv=none; b=i+Ksf8DAnMa+nEq/U98MCU8noza7p/fPgHRCOA2r/pNpAlJj6lITlBQtxwmzg2JmmFfuRUU9+Qu9p0/1Oq1U3qP7YWI6axaaWDuc3BThb+JCeyBuYEwmgWD7+xHw8uBPULzKgcQmUZPu1oG021UHXpCtdiLebCvmBnJx4HhQiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444414; c=relaxed/simple;
	bh=VldiDdec0SkK8yRWGMvnU3TuvkaGQZv72F6DAsVmHBw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oi1CgODZRGMl2ep5l/+0a3QAJ1ICA7GdF7vZBbAc3DwDN1gYd943sSIdPs6WcvvZbQuI1HMw62+wocV04hednCBHFIP/Djjtigr4tCGT2ObkR2evPxeq2018EMfW4d9X23N/hCtLpXtnfJGMdPe7nH0E6Lm4UJgexENXALmZDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4XFZpdK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42db64efac3so42627481cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708444411; x=1709049211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VldiDdec0SkK8yRWGMvnU3TuvkaGQZv72F6DAsVmHBw=;
        b=Q4XFZpdKtE17MlS4jYlf7aUC2VgqF6v+gxWbiFlAmxaEaT0weIIuEfYjUHDtjOWptc
         0InsJWPdQTS/HmhYPqG9DDjV1AV9WHLuXvxSh2IH8bizPJwvMHsbcKrsHe3LyOHoLYrn
         zBPgznXI3WgzX2JP8aCoa4GHeMvwGIwEKMpvcZdCAeSpeflFpEPbqeJzV2M04nfswG1w
         z6V7QlStIOX9EhNufRd+L1hHmb2BrRi2XdRhtB5VVk6CClEAXZjY+sIb+9+7ahp0m10F
         XJZNSYDa/YpGu+uKe8bGPOXYJ01le3Pcu/DF1ApNB68bzkodakkega+GBcYgE4nqWFmC
         zF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444411; x=1709049211;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VldiDdec0SkK8yRWGMvnU3TuvkaGQZv72F6DAsVmHBw=;
        b=tHCWfnIrqxdlrBAaX2v0DsVQW6t2F6RYPPAclkKdSslD3dO9NtInZTGflkPvI8Mywu
         1RgTwAH5OEQokV5gADv9BIPBY+44+TNhYsvWxdChHKLdiPUFDmQDhJ5Qc436Z5uu7GMj
         9EmvpXtko+m0Dy/hE5B3uKNlMkLSiVDYzQKrY/E4TqKNV1JvkOcObmC/M+GkIU8U6KUc
         F2vKyh3V2+K2752lZHxh7JhE+5pgwaqa21gQnzyS2M9AqJHfOXhpR8vH4hEwUM+UakpL
         TMUZazsxOfgujBmXcV/32HJzRa3aLWlVdUiHMzfLoh3+eenEiq6Oj37BFUIJKkoxy8HL
         AQbw==
X-Gm-Message-State: AOJu0YzPYxrARge9Ufa8znuQ+ciWxW3V61UPfple5Zd2ikrrGKAjkUPX
	lBFT84xvVdHszpE01F2V2A4vQGSqDKLHddeXgNXWgNd9H+Yinlvb
X-Google-Smtp-Source: AGHT+IHZAg5/r5rox3SVQTMITT7Oc6CE0y3vorHlvWG2m6/3SZ9nAaHyMt8a1E/DD5w4/y/9AUOh8w==
X-Received: by 2002:ac8:5f53:0:b0:42d:a99a:dd32 with SMTP id y19-20020ac85f53000000b0042da99add32mr21220962qta.23.1708444411525;
        Tue, 20 Feb 2024 07:53:31 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id c21-20020ac853d5000000b0042e1950d591sm1439751qtq.70.2024.02.20.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:53:31 -0800 (PST)
Date: Tue, 20 Feb 2024 10:53:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <65d4cafaf0839_23483829459@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iLQ1Sz7=sYMr=4r66-ZjHfnG5REi4uvitewfQrC7jrdZQ@mail.gmail.com>
References: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
 <CANn89iLQ1Sz7=sYMr=4r66-ZjHfnG5REi4uvitewfQrC7jrdZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add local "peek offset enabled" flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Feb 20, 2024 at 12:00=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >
> > We want to re-organize the struct sock layout. The sk_peek_off
> > field location is problematic, as most protocols want it in the
> > RX read area, while UDP wants it on a cacheline different from
> > sk_receive_queue.
> >
> > Create a local (inside udp_sock) copy of the 'peek offset is enabled'=

> > flag and place it inside the same cacheline of reader_queue.
> >
> > Check such flag before reading sk_peek_off. This will save potential
> > false sharing and cache misses in the fast-path.
> >
> > Tested under UDP flood with small packets. The struct sock layout
> > update causes a 4% performance drop, and this patch restores complete=
ly
> > the original tput.
> >
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> =

> SGTM, thanks !
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

