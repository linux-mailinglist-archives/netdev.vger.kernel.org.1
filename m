Return-Path: <netdev+bounces-101570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4918FF798
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021941C23D27
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927A7345D;
	Thu,  6 Jun 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFNEEJkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396544361;
	Thu,  6 Jun 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712233; cv=none; b=Lx0L4BQKAa2G6xjxVJD0dv6wCh2tn3KtEtEjdK0+2QRlNlcBjoa3trfxmhL07eoDtMgRtGwlzAl3aJoj5mJcSPAgZAHG9vGESNoV/8KY2Z9cY6oPm3FT1LYLphPNHW+v70emH8VhWfRF/pQEeBodEHBdpIo7LSdyIh1/d808d18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712233; c=relaxed/simple;
	bh=rRNoLnOtuf7gXUiGUWdkytwKEObjq7nGLwrsqwLO2BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTLaaxpJedNrQIORY8r8V6QJOmbHRNiedZ1aKbuExbxeMimEVgOBNDELTA+5i45D+BhnzzDGL8mjq4zVH41GZqpFXiM8SRkgZ1uuD+aXkzmgJLBrnRjrNiWd6qWUit5QOS9OOmDWqXyPNiUe/dlpFTVFtOcD2n9aQw9nfYs00FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFNEEJkA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ead2c6b553so18825021fa.0;
        Thu, 06 Jun 2024 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717712229; x=1718317029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRNoLnOtuf7gXUiGUWdkytwKEObjq7nGLwrsqwLO2BQ=;
        b=nFNEEJkA7JKfytISyNn9EKl07X0RhbEnDWb0pi4raAOezvy0lmvOdj0qheqWpO5srM
         EZDuxs9y7YSS5+FtpnQhzdpqSWtIlSTrPIWI8Hb8Ls7jdq7x/4an5usmq3Q4FB6YFvKl
         UV/Bd1GmDfCI8JxpUYt11AB5SIEdNFZKA7CyVBCEzIQWB05AehaCI4P5g3ke5HiDvziy
         +ZUz/S5Vd2TmVIY9LINnEn6DFSeCfsHdkrVV/IiKEPHA1Un9+PwnczXP05APfbmgiI+M
         5ra0PEq4H2bY8ScJfpYr637rimi1dUMznAzilkAZLXJ9WpVAkYOdc3c4va68ujizTLQ2
         +0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712229; x=1718317029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRNoLnOtuf7gXUiGUWdkytwKEObjq7nGLwrsqwLO2BQ=;
        b=oEV6zgd2D/24d1WX/eL1a3uJnjxF084b63QnugGfy+T2OaTzoQSUZoMDBu5pKXDUdV
         GlVgmVnactiYLEPQc8lIINWIkj99yTp9H9UZCZs+tGqDxZEJHh0mJt81TPZyOZBbFP9s
         cYtlpuF/ifTQsp2FyGSpHAPMf5JIJXsj/CqoxcE4fsQWDhmcp1f/1OPatjF7hM4rQyHR
         eWtbYPQhRj519tx+1wnWB648EL2p8Cprm1d9QIUAt56nqKxECHUjRkEiZY+XdT1ywgVl
         GNFCaPDxo1AaaXKla7fAzNgyyEG8QmQlubGmXhUl0JAPnaoz3IXD7C7C6rlWb3Oi3mOe
         2s/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+sawE0zFSDzEtilBCjk2oU6yNpaEu4w2m8r70551ROKH7NqQylWC4X+pjMMx78Q+G+5UR+qpdF3nI/Nk3dUe2PkqnooUR1o8AxBTC
X-Gm-Message-State: AOJu0Yz9bc4FMw8wjz+8mTSTWHXlZaShx6zcoO4aBeu29XvZX8zZxPNP
	GJmldzcTQ/O7604mv/Y4d9PS2tdISt8TywgJbjVn8UrCSJOEIpfn2LKrnG3H0hpGA1Zhjrihgp/
	64Ez6fqpQS4mEutap0X+K1TvCECA=
X-Google-Smtp-Source: AGHT+IEueW0/KsIz88ae9xQqkVdU8AYBJ3cVnbX/7Tb+QUYwbjsOqq7cLFErTdadWZHr3XnwskwnAfV9G9JZYUyni58=
X-Received: by 2002:a2e:924d:0:b0:2e6:d1fb:4470 with SMTP id
 38308e7fff4ca-2eadce7f992mr6629881fa.42.1717712228499; Thu, 06 Jun 2024
 15:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606192139.1872461-1-joshwash@google.com>
In-Reply-To: <20240606192139.1872461-1-joshwash@google.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 6 Jun 2024 15:16:56 -0700
Message-ID: <CANaxB-wSegSBot-8YCeiw-CsfdubRJMacC6nmRPLyoD4eGSc-w@mail.gmail.com>
Subject: Re: [PATCH net] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
To: joshwash@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	stable@kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Eric Dumazet <edumazet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Rushil Gupta <rushilg@google.com>, Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 12:22=E2=80=AFPM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
>
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.

Here is the bug report where this issue was triggered by gVisor:
https://github.com/google/gvisor/issues/10344

>
> The gso_type and gso_size fields as passed from userspace in
> virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
> |=3D SKB_GSO_DODGY to force the packet to enter the software GSO stack
> for verification.
>
> This issue might similarly come up when the CWR bit is set in the TCP
> header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
> to be set.
>
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei

