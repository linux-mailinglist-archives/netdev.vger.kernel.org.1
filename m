Return-Path: <netdev+bounces-97222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051308CA16A
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB9C282439
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A0137C4C;
	Mon, 20 May 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHYFNUJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705991E878
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226111; cv=none; b=TqW7gMVjyk9wE0ooQZX+h/aLv/eOrB4AbwLWDwtDUdrziy+DbBSLvf+VaeXzaf1JtV+eOzjIdd1toPVrzYfPPSejsKTeKlwEu4mOPt5IkLcXrQDzSfI7WzWaKwx+O56MIy5thYBye1v6ZHBPeyHkbH1j7VxkXz1s4pfjFlhPx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226111; c=relaxed/simple;
	bh=ubIj95/H4bFUskejXT3K61KVD3sPhqF6LuwI5MF6bpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=licNqHBVn4bHaI0ltgqBxRsg1Svq3IjvHjo9HVT3j/5xcp6h/AgwK54egY9ibiaJPnqs2ULEMZXEZNo0jK35/BAmQe8AIEapCSGuldbkPacSht9QTItDi0Aeda1vABA7Jh6Fw25AuPfZ+j+R7dzzdftzEVzLoIrWLmShTDDZMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHYFNUJ+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420107286ecso100705e9.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716226108; x=1716830908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0eR1MuWN+Z5kNK21EzI6lbb654wnuPxd5Y/TAP4tYA=;
        b=DHYFNUJ+fTI9pMDAaE62p84wjOHifxi5ioXXFHSmxX7GLJAMDjegzjfP750US5Q1To
         WIs3ufLbZyvunL5gHdD1Z9/g2r6iBFBp+N0bIyWnn/QsKaCZgV0S24VYDtVApyfnbzEt
         FYxCu8O6HwDvwOrJmZBGfF9/4j/shNH9yeo8hi/ez6sHP1xUwp1cbGEL8IDcHgcP4809
         O6DeSR1p2QTayEBh8m1rhlFPUs11CY3cUWkfbMYFPVkoOcK8MPzIC6scxhrpzfR+uql3
         u6QIwkvaj48hzBw2+qoKPo055l6Gobj8BkPuLwSlrcpx4DHA4vIJBV2Q7Pb2VNhFGYsf
         /jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226108; x=1716830908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0eR1MuWN+Z5kNK21EzI6lbb654wnuPxd5Y/TAP4tYA=;
        b=mhCMiXTzCTkp5njgtSCpGY/L8oFDGelZH9ZOzoBkzWBIbe9ooKARyK2zjL2BVj07Qb
         OhH0+tZLnSKcA3wPCXZhJLXoJqcPN5M9YSWCoZsyxFrdEogLQyHUylO+9N3iJlHgGxF2
         A85P5+Pv82MY2e4h5E5rknr5osqR1FJO6pOLu4vjQr1XcTeEBOGGZtu9Y8U5dcWcx6hW
         0iUXfRq8Wsa/MPaPY1UdSYenO+G8LLqCFhiCDv1WR0WPLAeeF2HN5SBYrF+N/wDZyimP
         hX0FH5OAtmSjI2L73cNRyogdUZqTdZQgjYmESdxQUbktGjQrUhmoAJsGh/hFpE/NFJgd
         oZJA==
X-Forwarded-Encrypted: i=1; AJvYcCWVtOF2LZbvT10qhLEbGRgnX/AAePMlemOYlUxC9JC8i88EmnjhGp8r641KlOtiEpL0xp/KO9om5KjZajBMCup5Gn2iaUWg
X-Gm-Message-State: AOJu0YwYJaMhNq1EyLkx8ENv4OFmlcNNA5zkYTC2nrNvSshc8OuwhmZx
	uhyatWZTQHuPe6HArzgZmlLXnhuWC/gWKUMhCxUHo6jE3vIRAAOmbyhsGotOgP3ii0rttZ1bmM3
	Z57OePuHg7sM5qRfmbVG1CKFjrqThXCl0OnBEgAQU8p8I/gzbkQ==
X-Google-Smtp-Source: AGHT+IECqp+//hzw8oZqilmvIQwi1IL8ye6cFHtP/WvEU2OEN9GOlszCQV+bUDLFD5bwgGAHRRYuv5oCLOQS4hWOEb4=
X-Received: by 2002:aa7:d5d5:0:b0:576:b1a9:2960 with SMTP id
 4fb4d7f45d1cf-576b1a93178mr237140a12.5.1716225663517; Mon, 20 May 2024
 10:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com> <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
 <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
 <262f14e5-a6ca-428c-af5c-dbe677e86cb3@quicinc.com> <8ea6486e-bbb3-4b3f-b9fa-187c648019bc@quicinc.com>
 <1f7bae32-76e3-4f63-bcb8-89f6aaabc0e1@quicinc.com> <CANn89i+WsR-bB2_vAQ9t-Vnraq7r-QVt9mOZfTFY5VD7Bj2r5g@mail.gmail.com>
 <89d0b3d3-7c32-4138-8388-eab11369245f@quicinc.com>
In-Reply-To: <89d0b3d3-7c32-4138-8388-eab11369245f@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 May 2024 19:20:49 +0200
Message-ID: <CANn89i+YgEs1Rb4qmftmz9C-f=xKJu8AbkecNK9NCODXNQsjBA@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 7:09=E2=80=AFPM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
> On 5/20/2024 9:12 AM, Eric Dumazet wrote:
> > On Sun, May 19, 2024 at 4:14=E2=80=AFAM Subash Abhinov Kasiviswanathan =
(KS)
> > <quic_subashab@quicinc.com> wrote:
> >>>>>>>>>>> We recently noticed that a device running a 6.6.17 kernel (A)
> >>>>>>>>>>> was having
> >>>>>>>>>>> a slower single stream download speed compared to a device ru=
nning
> >>>>>>>>>>> 6.1.57 kernel (B). The test here is over mobile radio with
> >>>>>>>>>>> iperf3 with
> >>>>>>>>>>> window size 4M from a third party server.
> >>>>>>>>>>
> >>>>>>>>
> >>>>> This is not fixable easily, because tp->window_clamp has been
> >>>>> historically abused.
> >>>>>
> >>>>> TCP_WINDOW_CLAMP socket option should have used a separate tcp sock=
et
> >>>>> field
> >>>>> to remember tp->window_clamp has been set (fixed) to a user value.
> >>>>>
> >>>>> Make sure you have this followup patch, dealing with applications
> >>>>> still needing to make TCP slow.
> >>>>>
> >>>>> commit 697a6c8cec03c2299f850fa50322641a8bf6b915
> >>>>> Author: Hechao Li <hli@netflix.com>
> >>>>> Date:   Tue Apr 9 09:43:55 2024 -0700
> >>>>>
> >>>>>       tcp: increase the default TCP scaling ratio
> >>> With 4M SO_RCVBUF, the receiver window scaled to ~4M. Download speed
> >>> increased significantly but didn't match the download speed of B with=
 4M
> >>> SO_RCVBUF. Per commit description, the commit matches the behavior as=
 if
> >>> tcp_adv_win_scale was set to 1.
> >>>
> >>> Download speed of B is higher than A for 4M SO_RCVBUF as receiver win=
dow
> >>> of B grew to ~6M. This is because B had tcp_adv_win_scale set to 2.
> >> Would the following to change to re-enable the use of sysctl
> >> tcp_adv_win_scale to set the initial scaling ratio be acceptable.
> >> Default value of tcp_adv_win_scale is 1 which corresponds to the
> >> existing 50% ratio.
> >>
> >> I verified with this patch on A that setting SO_RCVBUF 4M in iperf3 wi=
th
> >> tcp_adv_win_scale =3D 1 (default) scales receiver window to ~4M while
> >> tcp_adv_win_scale =3D 2 scales receiver window to ~6M (which matches t=
he
> >> behavior from B).
> >
> > What problem are you trying to solve that commit  697a6c8cec03c229
> > did not ?
> >
> Commit 697a6c8cec03c229 added support to increase initial scaling ratio
> to 50% to match behavior of configurations which were using SO_RCVBUF
> and only tcp_adv_win_scale =3D 1 (prior to commit dfa2f0483360).
>
> My proposed change is adding support for configurations which are using
> SO_RCVBUF and other tcp_adv_win_scale values. In my case, device B was
> using SO_RCVBUF and tcp_adv_win_scale =3D 2.

I do not think we want to bring back a config option that has been
superseded by something
allowing a host to have multiple NIC, with different MTU, and multiple
TCP flows with various MSS.

