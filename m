Return-Path: <netdev+bounces-96685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D528C724F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8491C2178A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E052F64;
	Thu, 16 May 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4ovsxHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7950A80
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846277; cv=none; b=fdNVo9HJZ2Py7wj8oN2Jk8vwo11oolB4nwlLQPVeTUVSyBBx4Kmd9JXBfCJaG4b4D9KOMwmjmzl/IeiTeBlnfUBcgNFIYR61hCgjFKTyLTpBjQU1zak849O/s7F+Fj3SmIy6kGanBdT/0MQUnVHXvw9ApQ1b9OfPE1/IH8+iujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846277; c=relaxed/simple;
	bh=EgBouWkS1lUrZ4JKXbjXsxiuGM/lqPDFzwZ0dypANqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4AURrvkr7p7kZ75+NibRkhPyDTilfYkdth49xaw9m86OSZbjPHQOcEetv7iuLMuzQ1kyZe2KK+UroVJbO620t8sUSuT3BRIvkhGF/uiTB3UoUV1G8l+FMMUoZVhxtiPpKCyZltniMZts7U2osr/W5BHYrn2BsW0ffGMjaI4Av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4ovsxHe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso51024a12.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715846274; x=1716451074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwCPDgEvz1cHD8BgxkzBvHnQ1zEbnlyRVVrwyIv21c4=;
        b=m4ovsxHebgiW6Dg4Svl34pzL0JJCxXmKhXr6AVmTG2/7yBWUE+S/M+an7CYLU0GGJ+
         pFMakfX9MsWd9/YjJIuO4mvNDmgonXknUZsfKXO9KbYBzXWi6cxH2n5ro5n4i9ioDNuD
         0fc8UwG6HfwNbjpUIBP7+26/xPXtwb6HvtHmuSRwndAq0747ZOHtIHfxMeBgL1uO6BiN
         wMaqEObQd5/Aj5HOIiS2EqNYsV3QsXbcl85IlxWnnVgQG6ELD9z9MAPrPeN7xuY4q+Gx
         JKP/uXPnucQa0Tz/pCA/iut90XNh5zZPY1oSTZNj0Wj/cxWrTuWzFHwWbW76VclSQf9J
         nDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715846274; x=1716451074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwCPDgEvz1cHD8BgxkzBvHnQ1zEbnlyRVVrwyIv21c4=;
        b=r/e2aRBUKU+87wZHVBeMJtUroyAcNRO2zK3wYmCWorjY8BbGDWBUbioHs6T0zmsvAZ
         1bdFF16x7EnBDstukWJnBwoOcn0eUygPSS+odN8AreofgwSOs3BonGnEffZNLRtDSvOy
         cJLHn5Tdx1e54SIaWp+O2nSheMycUyrBqpEkiG46Rmn6oXCSHkIIHXtqfUceJ8Jtz1z7
         4SPOK3u6FoqjtORrfXpVDVjd8ap8eKvC+eL2igseyZ+oKbBp1/UcK/e+8sLJ3DojVyen
         h8w6ZZMKkl6IuDT5azUukL30Vy2SXcLJMneQ8NeSAAoo6ixHPCEHmFeguPKUDO7VrCZy
         sVAw==
X-Forwarded-Encrypted: i=1; AJvYcCXCpbbc2dyFxIqEBjeUzkDHRyYSjYBJSWHUyH1eI68WC8ngVsIbHEHGqWc2OnOT1spxc1cn9+hwBToRDH0ey3O2+QGLSSRY
X-Gm-Message-State: AOJu0YzgdL1UaGEoxrvETYp3zRMLq04+5vmIMuWvxCs2yglYIGw8TLKc
	A4y2b/zxwvEr2TLBXY5yI5lk4hDRygmDX+uTzfAu8GzN7fuyMzZStltkP0kxvcxvR1M+yCR6Hwm
	ODX2cUeiw5TcJBQtJUZqJm2EYTKWLHBfl6XU1
X-Google-Smtp-Source: AGHT+IGtVps28vwJJ/kd/CB5egGBhMT/xkCd1XCgqZF0kyn/71HMYJIBukN9B132dEKdBuEFt3rx/CWzJRt9In4KlhA=
X-Received: by 2002:a50:cb8c:0:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-574ae3c1280mr925656a12.1.1715846274034; Thu, 16 May 2024
 00:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
In-Reply-To: <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 May 2024 09:57:38 +0200
Message-ID: <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 9:16=E2=80=AFAM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:
>
> On 5/15/2024 11:36 PM, Eric Dumazet wrote:
> > On Thu, May 16, 2024 at 4:32=E2=80=AFAM Subash Abhinov Kasiviswanathan =
(KS)
> > <quic_subashab@quicinc.com> wrote:
> >>
> >> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
> >>> On Wed, May 15, 2024 at 6:47=E2=80=AFAM Subash Abhinov Kasiviswanatha=
n (KS)
> >>> <quic_subashab@quicinc.com> wrote:
> >>>>
> >>>> We recently noticed that a device running a 6.6.17 kernel (A) was ha=
ving
> >>>> a slower single stream download speed compared to a device running
> >>>> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 wi=
th
> >>>> window size 4M from a third party server.
> >>>
> >
> > DRS is historically sensitive to initial conditions.
> >
> > tcp_rmem[1] seems too big here for DRS to kick smoothly.
> >
> > I would use 0.5 MB perhaps, this will also also use less memory for
> > local (small rtt) connections
> I tried 0.5MB for the rmem[1] and I see the same behavior where the
> receiver window is not scaling beyond half of what is specified on
> iperf3 and is not matching the download speed of B.


What do you mean by "specified by iperf3" ?

We can not guarantee any stable performance for applications setting SO_RCV=
BUF.

This is because the memory overhead depends from one version to the other.

>
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/=
drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c?h=3Dv6.6.17#n385
> >
> > Hmm... rmnet_map_deaggregate() looks very strange.
> >
> > I also do not understand why this NIC driver uses gro_cells, which was
> > designed for virtual drivers like tunnels.
> >
> > ca32fb034c19e00c changelog is sparse,
> > it does not explain why standard GRO could not be directly used.
> >
> rmnet doesn't directly interface with HW. It is a virtual driver which
> attaches over real hardware drivers like MHI (PCIe), QMI_WWAN (USB), IPA
> to expose networking across different mobile APNs.
>
> As rmnet didn't have it's own NAPI struct, I added support for GRO using
> cells. I tried disabling GRO and I don't see a difference in download
> speeds or the receiver window either.
>
> >>
> >>   From netif_receive_skb_entry tracing, I see that the truesize is aro=
und
> >> ~2.5K for ~1.5K packets.
> >
> > This is a bit strange, this does not match :
> >
> >> ESTAB       4324072 0      192.0.0.2:42278                223.62.236.1=
0:5215
> >>        ino:129232 sk:3218 fwmark:0xc0078 <->
> >>            skmem:(r4511016,
> >
> > -> 4324072 bytes of payload , using 4511016 bytes of memory
> I probably need to dig into this further. If the memory usage here was
> inline with the actual size to truesize ratio, would it cause the
> receiver window to grow.
>
> Only explicitly increasing the window size to 16M in iperf3 matches the
> download speed of B which suggests that sender server is unable to scale
> the throughput for 4M case due to limited receiver window advertised by
> A for the RTT in this specific configuration.

What happens if you let autotuning enabled ?

