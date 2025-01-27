Return-Path: <netdev+bounces-161088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29EA1D442
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51CA18879C5
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BA1FC7D3;
	Mon, 27 Jan 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVuioqUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36582282EE
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973087; cv=none; b=Pk0275XLQ2wh1WN3cJMrAibsGnq1+eTjqSBER7kKNLtwIVLnFRrFwi5aCpFrStu/bRAVE4vKl2FzyBysDNh/KKcU78spIFKKoB7MViSZdtvJZTPXuv/5XDyUBH7nO/SXCDk7P4oL4v6t343gQKA+Wce6NXekESyVD1ye5uPBXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973087; c=relaxed/simple;
	bh=ScMySoQ8cuSfvLpm98ugThtBOB731KiMF2Q0mAb3iI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIm/KzyHWYYniSCHQZT0raJZL1P0nFJ4B+gApFp4bKVUaXAkAAsoxDrRr7wglWF67ZLMNjigAP4Up4QaaQwEMoLUfHocurnaXvT240FOSVOFeECGiGzLYxW7ZvEysNCT+NW3Wkr6p34yI2AacJBngNn5OjMPkhj8W6OhDLUveqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVuioqUu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso9595735ab.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737973085; x=1738577885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f83p5LEi6LREo/dGN0fkA5HAxyKgSt/xyMs2Ty5texg=;
        b=JVuioqUuJVctRPy/F9n+Zn1YCtbF9WPHxiqzckIMXXZ2Z8uQS9++0SU+3en/wqCryI
         7pFOCJ3hDqz8h4KzLtxIvX+8VCdmlJCHgyDNlU0DwtbYM1/tCcQNiPP/s88YdsVoZ3B/
         QVPStilOton07FMWY5rG2xogm1gM8R/rif4cMnoubQh+ER1oCO+fBZmdX1BzZOPnhqL8
         pEWT4KEEFGUAbgFyFYj/dWgiLNs/yGs68kb87hv3WfHssMhwXB143rsoLP5VvLSWo+1b
         47CVMkLyOOO2JYCNphbL+5xdm8o/7pomF7JgZ0zLC1bf0oTBLubcQ5VcC96vjP7cnFIN
         X7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973085; x=1738577885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f83p5LEi6LREo/dGN0fkA5HAxyKgSt/xyMs2Ty5texg=;
        b=YjnmfwGj6GivsK9mMrkR2rVCLCh6KR9ijzp0qJK/8BFKrut+cDYjN8P1PEqRP0b+q/
         +84DYvd8TnL7B5OJ+YelgcUvwtdmvRFvj3DU1BchlSmIpzpLdgXjuU6IwGOFf0tIN2AZ
         sRie7PQ5Jlo7zEVt2u425ZvSDDSgyojYyOBjJHV6pQa4JzKHUBtzvqQPerD77V9ew5J+
         0R4OxFFEMPy8GAYD9FKPfSWgOa7PsozggdcySo0VLTHN42ocFysLx8tyAI1QCg+5chqa
         ewCG3CCtXtIQDStgKT3fDElbI7GDq+8mZ/o/ONdR/mBbel4+cbsvhmRpLhpzMB82UbW9
         gF6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbn7famOcP4QHAgF7WY7boFps3kj589GQHUCrNsH5j0DbOsOYFVnOaSsUhPI9WDRGKT6F4Cdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6VETW8cJlVpkV/35Iw+94B607vPa4xh3GVE5LTqn3/F/U4+Q
	uP9a5xJS36+fVlpzp0Sx5Y4x1NDxaKNVX/p4n8416GkoCaBU4aosWLzPxKqeW0I6BfKgRmG5Kon
	DAELAN8CtfqfQWtxUWvVdbXFURi8=
X-Gm-Gg: ASbGncvkebM+Gx4Gl3v3+jSNMj8Vhn5WqgIjzHhoJ+9Fyqe9fzLz+MFHIRqIBumgrgz
	DU0zc9lJfw28vaVHdnXz2RjUfHGxtgqWI8U386MxqjgP19Udf9XuwImtHFn+MdA==
X-Google-Smtp-Source: AGHT+IFseuO1vkGe/S2I2g1JMJFHXZwOmgMhhMF3UaPW1yv1KC5g0gWY1dK7MYuoTshFS3lQlSUs1ObXFUGwuS1pO80=
X-Received: by 2002:a92:c248:0:b0:3cf:cbac:3ba6 with SMTP id
 e9e14a558f8ab-3cfcbac3c55mr84793075ab.5.1737973085242; Mon, 27 Jan 2025
 02:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
 <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com> <20250127110121.1f53b27d@elisabeth>
In-Reply-To: <20250127110121.1f53b27d@elisabeth>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 Jan 2025 18:17:28 +0800
X-Gm-Features: AWEUYZkVcPpH3BIgYw77883RR7hoXgzNe1BSS0KLljI3aSPPtvfryiB02dicy7U
Message-ID: <CAL+tcoBwEG_oVn3WL_gXxSkZLs92qeMgEvgwhGM0g0maA=xJ=g@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com, 
	eric.dumazet@gmail.com, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 6:01=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
>
> On Fri, 24 Jan 2025 12:40:16 -0500
> Jon Maloy <jmaloy@redhat.com> wrote:
>
> > I can certainly clear tp->pred_flags and post it again, maybe with
> > an improved and shortened log. Would that be acceptable?
>
> Talking about an improved log, what strikes me the most of the whole
> problem is:
>
> $ tshark -r iperf3_jon_zero_window.pcap -td -Y 'frame.number in { 1064 ..=
 1068 }'
>  1064   0.004416 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611679466 Ack=3D1 Win=3D36864 Len=3D65480
>  1065   0.007334 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611744946 Ack=3D1 Win=3D36864 Len=3D65480
>  1066   0.005104 192.168.122.1 =E2=86=92 192.168.122.198 TCP 56382 [TCP W=
indow Full] 34482 =E2=86=92 5201 [ACK] Seq=3D1611810426 Ack=3D1 Win=3D36864=
 Len=3D56328
>  1067   0.015226 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 [TCP Zero=
Window] 5201 =E2=86=92 34482 [ACK] Seq=3D1 Ack=3D1611090146 Win=3D0 Len=3D0
>  1068   6.298138 fe80::44b3:f5ff:fe86:c529 =E2=86=92 ff02::2      ICMPv6 =
70 Router Solicitation from 46:b3:f5:86:c5:29
>
> ...and then the silence, 192.168.122.198 never announces that its
> window is not zero, so the peer gives up 15 seconds later:
>
> $ tshark -r iperf3_jon_zero_window_cut.pcap -td -Y 'frame.number in { 106=
9 .. 1070 }'
>  1069   8.709313 192.168.122.1 =E2=86=92 192.168.122.198 TCP 55 34466 =E2=
=86=92 5201 [ACK] Seq=3D166 Ack=3D5 Win=3D36864 Len=3D1
>  1070   0.008943 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 5201 =E2=
=86=92 34482 [FIN, ACK] Seq=3D1 Ack=3D1611090146 Win=3D778240 Len=3D0
>
> Data in frame #1069 is iperf3 ending the test.
>
> This didn't happen before e2142825c120 ("net: tcp: send zero-window
> ACK when no memory") so it's a relatively recent (17 months) regression.
>
> It actually looks pretty simple (and rather serious) to me.

I remembered last time it really also took me some time to totally
follow. Packetdrill should be helpful :)

As to the patch itself, I agreed with this fix last time while now I
have to re-read that long analysis to recall as much as possible. I'm
not that sure if it's a bug belonging to the Linux kernel. The other
side not sending a window probe causes this issue...? The other part
of me says we cannot break the user's behaviour.

One way or another, I will also take a look at it again.

Thanks,
Jason

