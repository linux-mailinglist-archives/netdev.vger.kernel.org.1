Return-Path: <netdev+bounces-74786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177DD862C8A
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 19:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13AEB20EA4
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50916419;
	Sun, 25 Feb 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6qMDxhC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33BE440C
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887550; cv=none; b=u1Dcbp59BNeCYpqu4KUswEMpmzRP9NCHEnBo2HcdbbQkomoPauxbEz/+ZuqAD+R19Lp71LdSq+OEJgJoKq4Bqzrj+OxrFzWv0aRd9m92/dkO2i2BPdInBDf8LvM5PbvBGriS0SrQOmRM8vleZzwUQRZyWVM1ioIomJHDCihz6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887550; c=relaxed/simple;
	bh=JMGQ5eBwDkJAP066Lh71u6eNtvMKp0Gmau0MXdlg/Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpoe5yXvRQ3DLDT3J63NMAaIitUyAqtaWKTRMdXsKpje3l7YOMVwnysua3g3hoJYVo7qw093S1q+3R4ehN3skiGQrWq3vMiJ3olipNoA1p4AqW6iCbwg/xax4JNli4SsWaxOiDidheKpxyBgF+i/9CIQKV+JFOCxrAIpmXIQsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6qMDxhC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a5782a25so414095e9.0
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708887547; x=1709492347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IYMXeRfERUyK7TLw1GegJUUL4xGoDRkeXe55O05cmI=;
        b=O6qMDxhC80UQWUvtou2MigmIGfZfhHfwOJ1s2pkZ5RuTCBzFmxsWl7rx97q5HCqkNy
         vad7w3QgkRyVj+1xacx1VE7eh/dZl+KfNnNF1qqauPkf+EMIfDy/IJKMUMRg4X3USX/7
         je+FZooBhaptXnsqOkupcb2Cz83LStGOzTsVMW5FshxySxAxcn336RtfaurcAzvHniBq
         ulyKjwjsGzztCcCxoeRkNtbyLHo89vENCi0m3d8rfCKM41qK00ZhtWwYBz0Y36fkkO1i
         wr0QqbYDv4elvjvdcxxXaNbj3UtDINldqo2aM+6H3rgtKWlJgZZ8IYyyLeoM2OxhBrdR
         IKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708887547; x=1709492347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IYMXeRfERUyK7TLw1GegJUUL4xGoDRkeXe55O05cmI=;
        b=XcUbiLHcpU8YXn957oAkfWHPNWUg0xLl0ZKOglGz+5SHWaIZfs6QoKpb6ajyGk+WFG
         TJcv2A2081Coo022YHJ51j4i4c/N0FBT7VQl7rF2zTHW7t4LbITxDFZIbPX+IO/H5kJF
         1h8j0u8tjndOdb8Ys/XLLs2MWVrJz/aECno3h+VWWOZWF/RrrfNdAklJwH29LWj38/Pj
         DhotkswNlve2EwVb4MOmzB1C4yC7A0gF/FQZn6SnfIZTH6SjB7UxbHZDZw7MBeO8NTzm
         VB3zGSSibfEFeI6VQO2oLiOJPNge9cC1FuYKUjJdMHHFZHK3eXeY1f1y+EYa7uMEt4h0
         8wEg==
X-Forwarded-Encrypted: i=1; AJvYcCWHcWUYcPwZzAzYCs4eYRJFuub2Nr0IBXH+2zHny3selHD+Wvw5I5NtxMjnCl5SlTNYhX0TfZb4i+zdRNYQH5wFOC7OVddZ
X-Gm-Message-State: AOJu0YxcmtowNtPpztv7OIUUF6AJavsEyPp0HiUdLiMjJ0u2jFq10sAT
	N5D+0ctJ18DlrLnSk5s3uUHjGp5FadDmToHPW75nBlvnfxkBnWZfDRjJ8nakbWh96UqcIcHFtSV
	RzVmoCeB9uPofcJL8nfXSDi6FyV8=
X-Google-Smtp-Source: AGHT+IHwVlSrOKMRchNQaPOqeZ/+geAf0UIBnpuZMMkBCcbPe3x9IgjwcXkCpTxpKTHh92kzLdSt7kpQHJazbftrB/g=
X-Received: by 2002:a05:600c:3ba6:b0:412:9694:71a9 with SMTP id
 n38-20020a05600c3ba600b00412969471a9mr3084338wms.10.1708887546716; Sun, 25
 Feb 2024 10:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708678175.1740165-3-xuanzhuo@linux.alibaba.com>
 <CAA93jw7G5ukKv2fM3D3YQKUcAPs7A8cW46gRt6gJnYLYaRnNWg@mail.gmail.com> <20240225133416-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240225133416-mutt-send-email-mst@kernel.org>
From: Dave Taht <dave.taht@gmail.com>
Date: Sun, 25 Feb 2024 13:58:53 -0500
Message-ID: <CAA93jw4DMnDMzzggDzBczvppgWWwu5tzcA=hOKOobVxJ7Se5xw@mail.gmail.com>
Subject: Re: virtio-net + BQL
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, 
	hengqi@linux.alibaba.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 1:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 23, 2024 at 07:58:34AM -0500, Dave Taht wrote:
> > On Fri, Feb 23, 2024 at 3:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Hi Dave,
> > >
> > > We study the BQL recently.
> > >
> > > For virtio-net, the skb orphan mode is the problem for the BQL. But n=
ow, we have
> > > netdim, maybe it is time for a change. @Heng is working for the netdi=
m.
> > >
> > > But the performance number from https://lwn.net/Articles/469652/ has =
not appeal
> > > to me.
> > >
> > > The below number is good, but that just work when the nic is busy.
> > >
> > >         No BQL, tso on: 3000-3200K bytes in queue: 36 tps
> > >         BQL, tso on: 156-194K bytes in queue, 535 tps
> >
> > That is data from 2011 against a gbit interface. Each of those BQL
> > queues is additive.
> >
> > > Or I miss something.
> >
> > What I see nowadays is 16+Mbytes vanishing into ring buffers and
> > affecting packet pacing, and fair queue and QoS behaviors. Certainly
> > my own efforts with eBPF and LibreQos are helping observability here,
> > but it seems to me that the virtualized stack is not getting enough
> > pushback from the underlying cloudy driver - be it this one, or nitro.
> > Most of the time the packet shaping seems to take place in the cloud
> > network or driver on a per-vm basis.
> >
> > I know that adding BQL to virtio has been tried before, and I keep
> > hoping it gets tried again,
> > measuring latency under load.
> >
> > BQL has sprouted some new latency issues since 2011 given the enormous
> > number of hardware queues exposed which I talked about a bit in my
> > netdevconf talk here:
> >
> > https://www.youtube.com/watch?v=3DrWnb543Sdk8&t=3D2603s
> >
> > I am also interested in how similar AI workloads are to the infamous
> > rrul test in a virtualized environment also.
> >
> > There is also AFAP thinking mis-understood-  with a really
> > mind-bogglingly-wrong application of it documented over here, where
> > 15ms of delay in the stack is considered good.
> >
> > https://github.com/cilium/cilium/issues/29083#issuecomment-1824756141
> >
> > So my overall concern is a bit broader than "just add bql", but in
> > other drivers, it was only 6 lines of code....
> >
> > > Thanks.
> > >
> >
> >
>
> It is less BQL it is more TCP small queues which do not
> seem to work well when your kernel isn't running part of the
> time because hypervisor scheduled it out. wireless has some
> of the same problem with huge variance in latency unrelated
> to load and IIRC worked around that by
> tuning socket queue size slightly differently.

Add that to the problems-with-virtualization list, then. :/ I was
aghast at a fix jakub put in to kick things at 7ms that went by
recently.

Wireless is kind of an overly broad topic. I was (6 years ago) pretty
happy with all the fixes we put in there for WiFi softmac devices, the
mt76 and the new mt79 seem to be performing rather well. Ath9k is
still good, ath10k not horrible, I have no data about ath11k, and
let's not talk about the Broadcom nightmare.

This was still a pretty good day, in my memory:
https://forum.openwrt.org/t/aql-and-the-ath10k-is-lovely/59002

Is something else in wif igoing to hell? There are still, oh, 200
drivers left to fix. ENOFUNDING.

And so far as I know the 3GPP (5g) work is entirely out of tree and
almost entirely dpdk or ebpf?

>
>
> --
> MST
>


--=20
https://blog.cerowrt.org/post/2024_predictions/
Dave T=C3=A4ht CSO, LibreQos

