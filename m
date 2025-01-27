Return-Path: <netdev+bounces-161084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9765A1D3FF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCBB3A1F67
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AFA1FC7F3;
	Mon, 27 Jan 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgNxrYUU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9981632C8
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972089; cv=none; b=qtIAtleVVH6gsvIovhDcv0kCkVYcoYctkswMlzP6cwcPGcepS+QFnOenUwqbo0nPG+AS2HiQ7E5RtqBmZF509b0SIRckkEbU7sDW1AqnZ3YCrJ8pYtXk4rLbESZygDNbryJG0zXIg1UhfYTue3SAWeAf6kNjvvfh5lcLEctlDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972089; c=relaxed/simple;
	bh=bl44L/hsbc/bfew0ntn3l7wFPd8y03aznKGG0VbsJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K++54TPkY0UQmXS0dkqQkOccZGMb8dk+poJhlgvpnqaBbsrUGAsk+n3khSDXZH7kTonTHfX+2Tsq7PgU4/Q4nIWqSSXxq0CuR0u9Qr/AfoPvYigwq+S9z1ZF4I4a99RonPnkswFJp9OipWtUDn/pXBnVfgKL7yRZJdeqI0ViX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgNxrYUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737972087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rq8pbYHQyCtCKmvNznuWUqZxLibrhcyPAMFJSYXwA7w=;
	b=HgNxrYUUkUT6ltx1wcr51zhdX+U4qqN5ojtNjYViKCY1Tv9AajSZfQUqLhFYdXUzQeduKP
	QQmY5X7RP5lptzE7b7SwpiAbDkFSzsv/lYhPAT/rpcTXHDZcY8KJPUjJ/fWvK2iQSD50EE
	l1M1QROI/OQpIB9U0k4dJs6QaTRd5ss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-RJEI5Hh7P0WfREgwXLXULQ-1; Mon, 27 Jan 2025 05:01:25 -0500
X-MC-Unique: RJEI5Hh7P0WfREgwXLXULQ-1
X-Mimecast-MFC-AGG-ID: RJEI5Hh7P0WfREgwXLXULQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e03f54d0so1625948f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737972084; x=1738576884;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq8pbYHQyCtCKmvNznuWUqZxLibrhcyPAMFJSYXwA7w=;
        b=D46bnJVu6uoP9bDHHzfgNLxf35klUVH5eIuw7R69fKVk914m58hTgiE1XNjlUFqCx+
         +e6MtPvIQmxyMYfmOxz9WxC+v5omsA4RwWRfCH3UuBcXzzxEodmI2OJ6HBU87N7gSWdv
         CoI1WWZAC7exNC0YROFxL5huq3NF0X553G7vH9tMmGxjnWpnSoEHNdFugYIlPYFAyRSd
         nBSwJAmC1gSaVw8zuIx1MbYF3WSPV2cSIlpGWgHIe39Ztwe1R9+NYkVVxj4sSgJlVTgu
         EksltaEr6NSM9YOhN3KCBIXSiWBDRV56Ep/+3qbEdw7bK9OjFl4eIknByzb65W/EJbcF
         c73w==
X-Forwarded-Encrypted: i=1; AJvYcCXY2bmntGby3IphiqDryeUhCI3O3ouTBgW5y8VRKa/SvEGM/q7OztnXxvO2iNQ8IS7ekt604TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBWfvrSzNsSG2j72b1lV7npAyFcoiSNxUveI5RVDb2lgD8Sgi
	EiISxp5I2KHkbKpYy6DLx0QVlielmbZSDfQgGR9yflA3yLIC4c4PCSbkHEywJKh1S/SKSVY6Gyj
	3AtrfmJGcdBYnLjR596B9dzUy6e7AW4c20GIEmgFrxzmuEymwhVWUSQ==
X-Gm-Gg: ASbGnctZ8JWOQwMGXm3z6cddKFluYGiR0vnUfo0uXCDBA7eZM5QtUon6i2DcdEpyokL
	wJgLcQab0kWP3UCknQwerpfSR99/uf4rnlTo+oDNwIpUb501oGss0bso6i5GC3/pbY/hM1PJAcu
	mQsOqEwaQNzjKEIgvoBxGvurDWFFX3UNinxv5n0M6CN/lnxdDPxchrn6reEk8HdV4Hbp0qz02kW
	QT4F5os3Q5OtkwaYOzO2Owkj8mLlJsRdIkr05fJ0iKaTKjYoVDWP/KnfXawt8mGuECQaeHTfqcq
	lkqXCSZFGkIomr/e3q1IcWK80JKL5CXOgw==
X-Received: by 2002:adf:f811:0:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-38bf56785f2mr31482979f8f.31.1737972084274;
        Mon, 27 Jan 2025 02:01:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERgycqNpISQ7GKlK506OJK+4JFwgnw9zCW59eh5kM4ir5Mcdj703dGfSe/yNBreLyftA9QeA==
X-Received: by 2002:adf:f811:0:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-38bf56785f2mr31482944f8f.31.1737972083936;
        Mon, 27 Jan 2025 02:01:23 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c3ec83e20sm3893371f8f.23.2025.01.27.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:01:23 -0800 (PST)
Date: Mon, 27 Jan 2025 11:01:21 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, Menglong
 Dong <menglong8.dong@gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
Message-ID: <20250127110121.1f53b27d@elisabeth>
In-Reply-To: <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
 <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
 <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
 <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 12:40:16 -0500
Jon Maloy <jmaloy@redhat.com> wrote:

> I can certainly clear tp->pred_flags and post it again, maybe with
> an improved and shortened log. Would that be acceptable? =20

Talking about an improved log, what strikes me the most of the whole
problem is:

$ tshark -r iperf3_jon_zero_window.pcap -td -Y 'frame.number in { 1064 .. 1=
068 }'
 1064   0.004416 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611679466 Ack=3D1 Win=3D36864 Len=3D65480
 1065   0.007334 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611744946 Ack=3D1 Win=3D36864 Len=3D65480
 1066   0.005104 192.168.122.1 =E2=86=92 192.168.122.198 TCP 56382 [TCP Win=
dow Full] 34482 =E2=86=92 5201 [ACK] Seq=3D1611810426 Ack=3D1 Win=3D36864 L=
en=3D56328
 1067   0.015226 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 [TCP ZeroWi=
ndow] 5201 =E2=86=92 34482 [ACK] Seq=3D1 Ack=3D1611090146 Win=3D0 Len=3D0
 1068   6.298138 fe80::44b3:f5ff:fe86:c529 =E2=86=92 ff02::2      ICMPv6 70=
 Router Solicitation from 46:b3:f5:86:c5:29

...and then the silence, 192.168.122.198 never announces that its
window is not zero, so the peer gives up 15 seconds later:

$ tshark -r iperf3_jon_zero_window_cut.pcap -td -Y 'frame.number in { 1069 =
.. 1070 }'
 1069   8.709313 192.168.122.1 =E2=86=92 192.168.122.198 TCP 55 34466 =E2=
=86=92 5201 [ACK] Seq=3D166 Ack=3D5 Win=3D36864 Len=3D1
 1070   0.008943 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 5201 =E2=86=
=92 34482 [FIN, ACK] Seq=3D1 Ack=3D1611090146 Win=3D778240 Len=3D0

Data in frame #1069 is iperf3 ending the test.

This didn't happen before e2142825c120 ("net: tcp: send zero-window
ACK when no memory") so it's a relatively recent (17 months) regression.

It actually looks pretty simple (and rather serious) to me.

--=20
Stefano


