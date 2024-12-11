Return-Path: <netdev+bounces-150996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C673F9EC4DE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CCA18858EA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788181C2DC8;
	Wed, 11 Dec 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYdDy1FH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3E1B0F01
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898958; cv=none; b=mLaeCSqAy3y0eDr+NHvcjM/8rjMKD2jX4aEnBmi/8EHryUozQ3Ar+y3t2BWSVHjBSVJUiR70m3P/5GeG638gPhcsVxV2MvcbMr86qRsHHfkT6yLyPehysqnrwynrs2RRPwci6gHm2L7w6Zg8dvk/SebgHPP46wAL1wlINPdoIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898958; c=relaxed/simple;
	bh=8MibRA5mPMey5rQjFO1Z2pDCrVDT0dJtpTJK2qcXQfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUImDlDydMszjwWvVqRn/z48KrdOFWVgZLheVK3PXRDOBw+p79EhLT0J9UQfBHciMadw0dbJ5VwJt7ztx2hMhQbxs7JnvBjYBuv6UI1pznCM1b03qfhPp27Dcihrrk/TMOpZtPBgZ4sagomYCSNCSf8jSbw84khqERAmwZVQAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYdDy1FH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so5120029f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898955; x=1734503755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ktZOwVUgnHZSv8ytFxEvZ1hpcMkMOdP7WwYKUVCD+c=;
        b=EYdDy1FHtUrpvorJr6c9orWzsV8wTdRzPpmr7mVwXgnK5nBAmfcBKhMWUxcM65fBI3
         J/U1QOla5CiNL9VQHkoNF5zI1Bs1K5krEz2zsR70olckZvLdiSIY8Xaj0zH5YcEhjx/5
         kDUU82uLN1YXomLLXcN5/Vm7yL8XQD093xw2YkvfHe1FNijIEWJwCFuWG0BzniOqt2oz
         wHgGKee16s6wQr/qw3yIRYy0wHwg0C/LEQb7xj5wxB64+k96AuwXjMKNARwCg02y6GeN
         FV/KD/PNDtN4+jm581AFa121iCO36TzV7VF1Xgp+MONzdYPr9GMcotzUvhyHGHDWEYoS
         9cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898955; x=1734503755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ktZOwVUgnHZSv8ytFxEvZ1hpcMkMOdP7WwYKUVCD+c=;
        b=JoqhkfspLXC4Iabv2ux8ZAH+q0Bbe0TYGWsK4R6AUufnTQcSrVEp9tj1Suh9TIu0ZU
         fCFyTRIUlE9Xeg68YB3cAEg84ecpQpsgRC1lBEcwAGVzREy5HMGVzfoqVFJu4uuFrbWY
         l3zBQNxU8GwhoEBtd5gWSgjyr6la4fH4V6ysG3H5jfLk3jeyyxCTvAh2i56vktpqBpgI
         yP/wXCa9dxOY/lzIZKwsNXRWLT2D+2JSBbIcL2p8s+wyXnuiKz1wmxP4LDooOg8KNTqp
         vaScV5fPlD18lNSmAMuTCl/THGsNOPoAcifyfiYfLTVM6XfKDVvEnK4I7P1pnSBp38uQ
         s6UA==
X-Forwarded-Encrypted: i=1; AJvYcCU0tUhCTMJV2iD3Yxy/u/mgLfAQ9Nd1G6Pdt1JC+y0F7BnwxeT1qsx3SCbgNX+hv0CfF6byshY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8t9ioREHOdyJsSwOv0k3OgranMd0/t+DyhYHd0HpkMfpZnt7p
	1Ppo60dFjypxEzUO1SkRjsXMimkHuizB8Flkf1IDx5wIxlSBuD+fMgCzbtnRnK+NBPW8lcTlMs1
	xi5dgPFxFCXry7hSF+QHwCtMQTSs=
X-Gm-Gg: ASbGncv/rQTTtJBAZ41R8Pw/kFLs6bXtWLM3WKMjQDLCL+bv7HjDUgSIxd+OdjUe8q+
	XYIvWVuLRzxqRpZWiJVLd3z/jALRgwlP8AQ==
X-Google-Smtp-Source: AGHT+IFDzBSDZIyqoK7nc2ioymKrh44JsxqNGA6b0wrbKFSziYJclgaxAfaxoF8WvmoblRTZLTZJyggbdye1rbLaevU=
X-Received: by 2002:a05:6000:4020:b0:385:fe66:9f32 with SMTP id
 ffacd0b85a97d-3864ced385bmr1019170f8f.52.1733898954859; Tue, 10 Dec 2024
 22:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
 <Z1fO0rT9MZs5D61z@pop-os.localdomain> <1373213.1733863522@famine>
In-Reply-To: <1373213.1733863522@famine>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 11 Dec 2024 14:35:16 +0800
Message-ID: <CABAhCORpd+1A6uThBQ_YYx16iLkPZDXs5vwTkYDNAxcN3epWDw@mail.gmail.com>
Subject: Re: tcp_diag for all network namespaces?
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, dave seddon <dave.seddon.ca@gmail.com>, 
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:43=E2=80=AFPM Jay Vosburgh <jv@jvosburgh.net> wro=
te:
>
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> >On Mon, Dec 09, 2024 at 11:24:18AM -0800, dave seddon wrote:
> >> G'day,
> >>
> >> Short
> >> Is there a way to extract tcp_diag socket data for all sockets from
> >> all network name spaces please?
> >>
> >> Background
> >> I've been using tcp_diag to dump out TCP socket performance every
> >> minute and then stream the data via Kafka and then into a Clickhouse
> >> database.  This is awesome for socket performance monitoring.
> >>
> >> Kubernetes
> >> I'd like to adapt this solution to <somehow> allow monitoring of
> >> kubernetes clusters, so that it would be possible to monitor the
> >> socket performance of all pods.  Ideally, a single process could open
> >> a netlink socket into each network namespace, but currently that isn't
> >> possible.
> >>
> >> Would it be crazy to add a new feature to the kernel to allow dumping
> >> all sockets from all name spaces?
> >
> >You are already able to do so in user-space, something like:
> >
> >for ns in $(ip netns list | cut -d' ' -f1); do
> >    ip netns exec $ns ss -tapn
> >done
> >
> >(If you use API, you can find equivalent API's)
>
>         FWIW, if any namespaces weren't created through /sbin/ip, then
> something like the following works as well:
>
> #!/bin/bash
>
> nspidlist=3D`lsns -t net -o pid -n`
>
> for p in ${nspidlist}; do
>         lsns -p ${p} -t net
>         nsenter -n -t ${p} ss -tapn
> done

I think neither iproute2 nor lsns can actually list all net namespaces.
iproute2 uses mounts under /run/netns by default, and lsns iterates
through processes. But there are more ways to hold a reference to
netns: open fds, sockets, and files hidden in mnt namespaces...

Consider if we move an interface to a netns, and some process
creates a socket in that ns and switches back to init ns. Then when
we delete it with "ip netns delete", the interface and ns are lost from
userspace. It's hard to troubleshoot.

I haven't found a way to enumerate net namespaces reliably. Maybe
we can have an API to list namespaces in net_namespace_list, and
allow processes to open an ns file by inum?

>
>         -J
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net
>

