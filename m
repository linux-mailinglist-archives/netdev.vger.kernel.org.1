Return-Path: <netdev+bounces-104057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878890B065
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23451F22121
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05B3DABFA;
	Mon, 17 Jun 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0QSnAJT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8B21C193
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630704; cv=none; b=AwBKuxk+2unLRw/PJkcYqUsrm5JKBItA57qW/0zDaER0i1KM77hCgIaCG9FL/Y5/F0YsUEyXN0MqEL9K90JFXDAZpEoJiV4PauG2+1Ov4NSHyu8QSdWy7sKsn1kUHxiM79eSgwej3yAyHPqAf+I3pNS3XAZsyzNrjEbUmGObnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630704; c=relaxed/simple;
	bh=UffNg64kltXiNMQy07YaTpOg7r4pBCC49Y6FPB+maXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jztpg/LZira0cvzIjpw7rg0cuxkWYxrLE6jacNT3Cla3OuLcF8ON4XqcbJW5Q0iLBlXjPYHiWgHxPpYRrkmf2dv05TmGlEiRpszlMQBcHSbiqG55I2HA5xc0HTYoCPN5ir5wjy1M/DDtRAEZWPKJgPmsjjfbIW/g2/PexCNTvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0QSnAJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gNdwNvulKIO4JOfhW5zSdvn5q7O0IrSkNwM4LbWgZA4=;
	b=I0QSnAJT6vYXtZA7AVTv8eToMQce1tWMb0WK/+ORo2+MDsAK6+nAv3mUvAot1aWKmh3jrX
	D3q3dyqcEijx/qFCL3R/otL4Ku2QYzZpW9MlrtvA8jvBUJo+JbNNE+jllS8FKyFIWmBOu6
	tEZIgVrTzj1mQy0mIYh8sCHb/nqF2uk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-12u4oZaUMEKkbfDivnQElQ-1; Mon, 17 Jun 2024 09:25:00 -0400
X-MC-Unique: 12u4oZaUMEKkbfDivnQElQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f2030f868so3158166f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630699; x=1719235499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNdwNvulKIO4JOfhW5zSdvn5q7O0IrSkNwM4LbWgZA4=;
        b=Kcd4XMbRC4i8VMkZVUNq1E0L54t/Zjwdnf0kaDVr92DqcTA5CWiHaOBkTzZNa6ZkKp
         kxiHVguhcuyjyqXyHzVBwBwPHFctGq610/I/4MB5zI4hlAN3wtVAlsE8XZMqKkDR4zzq
         WM3wyN/QKHVWJHVuEkmZ2bJ7MnXRVF6s3TfOjZU9qLjzSZ8MqiVCl+IRa3WP9rErlN6A
         9w0yrv5D9dSx0h8qYLrnCl5DkflEHvsXypFZ2kCaegrJXf5AEXJAJVjKTd9fUa0yrB5C
         GxgTOTpKZ0yR/rlQjjemqwrawVyQ1ncy3j8gH7oCa/6SwuJmZS0TmNZXGVnHl4n2DegH
         R0sg==
X-Forwarded-Encrypted: i=1; AJvYcCXPfD7BjJIO0j4GJ2pM8DlA8TE8PwKDi9bh7xxhOql2epWBcqTUO18zqD18/CJ+jitw5q8xN6Vn2wt/FBjEC2wcIHeIqLEx
X-Gm-Message-State: AOJu0Yypy28XD1xbLGRVUamqFgeZwQ94J9IdncYfiC3SHLKpYXtC7I/r
	4kW3QkEQk0ZSN6vucHaAt86TiKoyCvepmYEjNz1nzNIaYCmel9sjniFkHrMe/2G07chomh2gs1f
	lnJbbJ9ab1FWX0atWSymiYOVlaH/fTQVR/3JPlzq1mxRBHlg1RJF6VA==
X-Received: by 2002:a5d:46c6:0:b0:360:9a04:57ba with SMTP id ffacd0b85a97d-3609a04587dmr1509650f8f.31.1718630699514;
        Mon, 17 Jun 2024 06:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRxoRznz4bsF2t8WDRmKhi4N1xEAy+HXiK9JIkYxIFPdtbiwxr4Y2KaDbSLkoIb3poAiSTrQ==
X-Received: by 2002:a5d:46c6:0:b0:360:9a04:57ba with SMTP id ffacd0b85a97d-3609a04587dmr1509626f8f.31.1718630699176;
        Mon, 17 Jun 2024 06:24:59 -0700 (PDT)
Received: from fedora (lmontsouris-659-1-55-176.w193-248.abo.wanadoo.fr. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093499sm12071989f8f.8.2024.06.17.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:24:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:24:56 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: sgarzare@redhat.com, edumazet@google.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, 
	stefanha@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next 2/2] vsock/virtio: avoid enqueue packets when
 work queue is empty
Message-ID: <jjewa7jiltjnoauat3nnaeezhtcwi6k4xf5mkllykcqw4gyfgi@glwzqxp5r76q>
References: <20240614135543.31515-1-luigi.leonardi@outlook.com>
 <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

Hello,

thanks for working on this! I have some minor thoughts.

On Fri, Jun 14, 2024 at 03:55:43PM +0200, Luigi Leonardi wrote:
> From: Marco Pinna <marco.pinn95@gmail.com>
> 
> This introduces an optimization in virtio_transport_send_pkt:
> when the work queue (send_pkt_queue) is empty the packet is
> put directly in the virtqueue reducing latency.
> 
> In the following benchmark (pingpong mode) the host sends
> a payload to the guest and waits for the same payload back.
> 
> Tool: Fio version 3.37-56
> Env: Phys host + L1 Guest
> Payload: 4k
> Runtime-per-test: 50s
> Mode: pingpong (h-g-h)
> Test runs: 50
> Type: SOCK_STREAM
> 
> Before (Linux 6.8.11)
> ------
> mean(1st percentile):     722.45 ns
> mean(overall):           1686.23 ns
> mean(99th percentile):  35379.27 ns
> 
> After
> ------
> mean(1st percentile):     602.62 ns
> mean(overall):           1248.83 ns
> mean(99th percentile):  17557.33 ns
> 

I think It would be interesting to know what exactly the test does, and,
if the test is triggering the improvement, i.e., the better results are
due to enqueuing packets directly to the virtqueue instead of letting
the worker does it. If I understand correctly, this patch focuses on the
case in which the worker queue is empty. I think the test can always
send packets at a frequency so the worker queue is always empty, but
maybe, this is a corner case and most of the time the worker queue is
not empty in a non-testing environment.

Matias


