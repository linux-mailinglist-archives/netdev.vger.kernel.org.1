Return-Path: <netdev+bounces-88463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85C8A7511
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166C71C21645
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9BB1386D9;
	Tue, 16 Apr 2024 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1xxyTWxQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5912E1F0
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296653; cv=none; b=qj+ZfFfo6keMqZ+uu0QNEYxZepAxsBYnLwD/HrZpNdIiycz+qPeP4bL5c7AirFI8uZaFcp7fbTraOM8nU6evwDz1jhzUESsfbuFesZlSpqR+5uN5DeRy5Q+IgOSxFHadV+4QuiEOGONnBtx9sywDBGxsoXjlcqp3Akh8tIt99Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296653; c=relaxed/simple;
	bh=fgOMsfsromnWR7crsvunBcNbNIL7r1FqTV8g43WikSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7eET5r9S/OBMCoNF2U3UsWKdrOpyfyMhUkADi09ztPTLCUdYCTynDMmas2y2YNxxKS/9Vm6n2JOYsY/EwCeHrCJ1aDJANqCuDALo3gbPdpSEIEojVI4lrm3xDSoZMuR43pxEit8pAQkCkv5/FIlMZ7s9ZRXlL4GMSfZswUiU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1xxyTWxQ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4dcc7c1055bso822770e0c.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713296650; x=1713901450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0liEvfgvDJcNB8HN7DG0Qs0xaumItJ8wGdENTGSU0i8=;
        b=1xxyTWxQOPNwjvfWdk2ynAH0GuB7IJ83idyG3pkwVvVDDPjv84ucEb8cbE4Tkjzfzm
         VMhe8INSlHJ3y9Nqnbt7IHi0ZDwOnTb9uO1uXUHIzrKNlR9bIe6DnW7YYZoTYOPYGl6M
         AWYGYkJUUVXGGFbLFEcNIc65MAmRiCkxMP/AVFnISf4WmSH9ZgJ8nFdInC8Huk+r3Z87
         +n6CzSeVb0rO4XZ8UHNXfnHR7ZdDiL2iwBicLI+KQsC+gxD8boRI/dW1PTiEiCoxUEZP
         LkjrouKSnQue3xZmVw2F+oHpncP25MAEMGm95wad3OxaZdl36jkv4lt1seSwtVx4OABw
         aPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713296650; x=1713901450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0liEvfgvDJcNB8HN7DG0Qs0xaumItJ8wGdENTGSU0i8=;
        b=IzfUEPAAqzh+bxcQ8yiH/p6rEE/4eQ5eCimmRyvoxHgzKkkkW/CTYN1J9htTKIgRxZ
         LLVc1+xdzlD+Tm46gLfriMm8iWDOGi5f+ge2Szauh0Mf85bXJbWJov0l9J/kEG3coExx
         rKPO1Uf5X0cTlYhXgyrhuzB5tJ5A660nbjb4wHRyoFtKARMAjb6cZKcqakr80HzDcurW
         trmyiGuKu26Mk/vr+qtEGxircx+NhokzhqyU0nwKeGIG6q07O1xhHEHVq5ePe/keSa5y
         SRVMMex0zZx/1cCayxZT8WZiDBeJvFauEK0rf5P5DYlLYqfPDHZDkI39cBJ4IglmWaBF
         u2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWD07exnzG6+kX/i/UMsRC0dcHwK4eQyMaZbxyCbudeGyrqsB8a1ZsjiOp0IH/kum7PTVRRTHO7dVkdUoMtU3/hiCmUh6IU
X-Gm-Message-State: AOJu0YzCHi3P6MPL3BoJ0k/7CZ/P7a05vsrFnjuaKbrr5JUXaUdSPw1S
	jtZ+/BcAq9nmtezaktOKociWXiYITPwJoT5JrTvSDtzcgXI/4vFHCBdYdnsgngY59DHwwVW976w
	To/GlLb8wFZya0YHhbjMmDKoSMcxYnjd6KjPV
X-Google-Smtp-Source: AGHT+IGAi017fzJCBa1nWjezpdfsvD1Sqm/9JMe39Np4aI1Pv98ApLSskkXTTPfqa58PpaS26f2lG8pnoXJPyYXjmno=
X-Received: by 2002:a05:6122:2209:b0:4c9:a9c9:4b3b with SMTP id
 bb9-20020a056122220900b004c9a9c94b3bmr12243537vkb.9.1713296650485; Tue, 16
 Apr 2024 12:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416095054.703956-1-edumazet@google.com>
In-Reply-To: <20240416095054.703956-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 16 Apr 2024 15:43:50 -0400
Message-ID: <CADVnQy=+5-Hkz9Ud0Vy34wJmdQhUB47QujkQrCbXRKi3yq3STA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: accept bare FIN packets under memory pressure
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Andrew Oates <aoates@google.com>, Christoph Paasch <cpaasch@apple.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Andrew Oates reported that some macOS hosts could repeatedly
> send FIN packets even if the remote peer drops them and
> send back DUP ACK RWIN 0 packets.
>
> <quoting Andrew>
>
>  20:27:16.968254 gif0  In  IP macos > victim: Flags [SEW], seq 1950399762=
, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 501897188 ecr 0,=
sackOK,eol], length 0
>  20:27:16.968339 gif0  Out IP victim > macos: Flags [S.E], seq 2995489058=
, ack 1950399763, win 1448, options [mss 1460,sackOK,TS val 3829877593 ecr =
501897188,nop,wscale 0], length 0
>  20:27:16.968833 gif0  In  IP macos > victim: Flags [.], ack 1, win 2058,=
 options [nop,nop,TS val 501897188 ecr 3829877593], length 0
>  20:27:16.968885 gif0  In  IP macos > victim: Flags [P.], seq 1:1449, ack=
 1, win 2058, options [nop,nop,TS val 501897188 ecr 3829877593], length 144=
8
>  20:27:16.968896 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0,=
 options [nop,nop,TS val 3829877593 ecr 501897188], length 0
>  20:27:19.454593 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1=
, win 2058, options [nop,nop,TS val 501899674 ecr 3829877593], length 0
>  20:27:19.454675 gif0  Out IP victim > macos: Flags [.], ack 1449, win 0,=
 options [nop,nop,TS val 3829880079 ecr 501899674], length 0
>  20:27:19.455116 gif0  In  IP macos > victim: Flags [F.], seq 1449, ack 1=
, win 2058, options [nop,nop,TS val 501899674 ecr 3829880079], length 0
>
>  The retransmits/dup-ACKs then repeat in a tight loop.
>
> </quoting Andrew>
>
> RFC 9293 3.4. Sequence Numbers states :
>
>   Note that when the receive window is zero no segments should be
>   acceptable except ACK segments.  Thus, it is be possible for a TCP to
>   maintain a zero receive window while transmitting data and receiving
>   ACKs.  However, even when the receive window is zero, a TCP must
>   process the RST and URG fields of all incoming segments.
>
> Even if we could consider a bare FIN.ACK packet to be an ACK in RFC terms=
,
> the retransmits should use exponential backoff.
>
> Accepting the FIN in linux does not add extra memory costs,
> because the FIN flag will simply be merged to the tail skb in
> the receive queue, and incoming packet is freed.
>
> Reported-by: Andrew Oates <aoates@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Christoph Paasch <cpaasch@apple.com>
> Cc: Vidhi Goel <vidhi_goel@apple.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

