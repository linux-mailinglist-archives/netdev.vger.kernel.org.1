Return-Path: <netdev+bounces-159578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2FA15EB0
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700393A36BE
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB921A2545;
	Sat, 18 Jan 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ec8W/Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBC14A627
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737230679; cv=none; b=VL1xiHEoPOrNnn+75IvNdoV+o13BRza51J9J6QQCP/Du9j4jNH+onz2XaUxnX4e4kF8rK83//NSrY/jsgmz+TWv0iTRqGmXnNBOiNVad29r8C4t55ZoQzQFfsnWWzYIcYy3IslZ2CJ17nKiBp8Dw1IhHbp25nquiag9/UvK4EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737230679; c=relaxed/simple;
	bh=+7MVwsZqe7y1G9BENcZvDheP/DCXejydns5pdAHd+rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxlS2rCTA3LOALXsA9/e9BOK8767rVuu/NACpsn9pHCMh7xAL1Z8oVu/KcsA7X4b8bmen93AFfMhd6euSQrOaOro1rNCa16Fa1dF/hChwL00HR0OnMBX/qmki8x+HDNSR4DI/zRocGdzhyYLKJYVnHxEWEbq3NMKRNV5cMwSTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ec8W/Ht; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679b5c66d0so139121cf.1
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737230676; x=1737835476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STXfgPiayLqn25zN02uTnfMUHqs2yaHTiFK25eshW5g=;
        b=1ec8W/Htyw7G2rv+OFStOjWeaeOV8hEyL8uVlOm8JA39r+d9YXFmm8GqivZVnWG62/
         78SxTrQ15XRxv1OzyOZjegKfc7u/2/9hVeuWlFDhvWT383AZ++P+nspWOIVNsRLbyehl
         9+FotZfGiJucaJ7sbQyVIxnZCSZvtD+EwOPrxXl4gTRZJv9MUtSstCwtpql7AUJTJ4fe
         rEXdJJckf9VnuBnLB5zeBbZHsIhGn5TFrB8yKtgS2LFXR4/kAbFWDpvi5DGTIqB22l0w
         b2NMfmUVfGayO5rCg+heEGawMCFijr3uzz1NjfZGKBeb/4diTcIpf5QhxjTOmGG1RsVD
         HI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737230676; x=1737835476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STXfgPiayLqn25zN02uTnfMUHqs2yaHTiFK25eshW5g=;
        b=InnTEMSNEx3k5IEc3LW0n3LBFEQ0jDH57keiYQr9AbzWAhrk/UMqfk0NEmzzZtvKmp
         45ZbwLW0mbUinnDVcXuXICezlA1YY3o3N1Pd8PH9ZbcpGBMV/4eR7m6ptYaqxfEfnJqb
         MMbMp4nNcUQsmMYRxs5Xcl+NQzg+N8U1amqDstq9lLizIpnGFCmsORKYHaE8Gq9T4u+y
         usoMz7fk4CGGWS0fXxD7e8bA5Bm2G3WjcXbgbu6u1xduS0vlSBAAOUz8mBWS/l37Zg3i
         eexAVgIz2S2xrs6rLq1uX+mhmq0rKPBmCGekdrlxQWPTaMsX/x5wtCmxXxK2lwELcVcV
         csOg==
X-Gm-Message-State: AOJu0YxV26LsalrQwnHGRSu3uPMChg/RO30ORuld1PY3+r8kbwXtnE4k
	syVxGkDwtI900iKoQG2jbp+7V8fPv8YFGxPIgp3hQ38/NvkR4/N56lzgIdJ+qbKSyK7U+QkVyuz
	Pd2dPMJW+HDozV53hL0YT+3tr+lmB2fEDx+Ni
X-Gm-Gg: ASbGncuxlxBgri3zTiLaE7J6bNytgNuOQj9bBXrzGUUubW0ahfeALmiufj/UduS49sC
	ufwewmXUGcXxaV0xG20X2UIik5bWaYpR9BjGtTSLnNS3crhvDYfI=
X-Google-Smtp-Source: AGHT+IFWQJE7pXeRaChKLIYEcIGi92C7DmJOzWa7YjstL92TQP1zvq9u1T0Rt0UJuba4KZsRgV7jkMjar809dzFmmIg=
X-Received: by 2002:a05:622a:120f:b0:466:8c23:823a with SMTP id
 d75a77b69052e-46e210e3591mr2215571cf.17.1737230676051; Sat, 18 Jan 2025
 12:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com>
In-Reply-To: <20250117214035.2414668-1-jmaloy@redhat.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 18 Jan 2025 15:04:20 -0500
X-Gm-Features: AbW1kvbFTFCjCPPn488IbheQSTDMU3SRvxzi917z3eRmyZCoqIE9EtyrlD34hsI
Message-ID: <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, imagedong@tencent.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:41=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> Testing with iperf3 using the "pasta" protocol splicer has revealed
> a bug in the way tcp handles window advertising in extreme memory
> squeeze situations.
>
> Under memory pressure, a socket endpoint may temporarily advertise
> a zero-sized window, but this is not stored as part of the socket data.
> The reasoning behind this is that it is considered a temporary setting
> which shouldn't influence any further calculations.
>
> However, if we happen to stall at an unfortunate value of the current
> window size, the algorithm selecting a new value will consistently fail
> to advertise a non-zero window once we have freed up enough memory.

The "if we happen to stall at an unfortunate value of the current
window size" phrase is a little vague... :-) Do you have a sense of
what might count as "unfortunate" here? That might help in crafting a
packetdrill test to reproduce this and have an automated regression
test.

> This means that this side's notion of the current window size is
> different from the one last advertised to the peer, causing the latter
> to not send any data to resolve the sitution.

Since the peer last saw a zero receive window at the time of the
memory-pressure drop, shouldn't the peer be sending repeated zero
window probes, and shouldn't the local host respond to a ZWP with an
ACK with the correct non-zero window?

Do you happen to have a tcpdump .pcap of one of these cases that you can sh=
are?

> The problem occurs on the iperf3 server side, and the socket in question
> is a completely regular socket with the default settings for the
> fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
>
> The following excerpt of a logging session, with own comments added,
> shows more in detail what is happening:
>
> //              tcp_v4_rcv(->)
> //                tcp_rcv_established(->)
> [5201<->39222]:     =3D=3D=3D=3D Activating log @ net/ipv4/tcp_input.c/tc=
p_data_queue()/5257 =3D=3D=3D=3D
> [5201<->39222]:     tcp_data_queue(->)
> [5201<->39222]:        DROPPING skb [265600160..265665640], reason: SKB_D=
ROP_REASON_PROTO_MEM
>                        [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469=
200, win_now 131184]

What is "win_now"? That doesn't seem to correspond to any variable
name in the Linux source tree.  Can this be renamed to the
tcp_select_window() variable it is printing, like "cur_win" or
"effective_win" or "new_win", etc?

Or perhaps you can attach your debugging patch in some email thread? I
agree with Eric that these debug dumps are a little hard to parse
without seeing the patch that allows us to understand what some of
these fields are...

I agree with Eric that probably tp->pred_flags should be cleared, and
a packetdrill test for this would be super-helpful.

thanks,
neal

