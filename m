Return-Path: <netdev+bounces-179501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F379A7D23C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 04:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D0C168C76
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D1212B10;
	Mon,  7 Apr 2025 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3ljwfo7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32704211A2A
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743994474; cv=none; b=Qf9lmgRphDimsNSjCk4KcJU9pkUY/auVIuY4yxvck9zkZEE+UYieuWWbypULHtNSH937VBfZJE9l6aHEQuRhJ2D+AJ7qD1HtvA1aMK7KcJaof3D+YLO8mfBsLOtwsY6aS+VAYSn8KRihecEEcbYVgtsDblPuwNcoyBjJTQ56ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743994474; c=relaxed/simple;
	bh=78VYBtVNDDMVcqLfVurU2jzF/nks381crfP8S6661CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnrSJ5rrv5m8UyxRTLXREw5rbsPY8SPt/oEYJBwUi45/ZJMCUYk61R9B5ncywFa/tYbJ4o/NgbWHPyVZ0TeCKuDpvYGvgjYhmpGX4QwcByYe7jPa49WkvWBa1uBhL+YDHv1w1b1Udv+Z/nM9a4y6AhV3Th8VQFgeYiM4NSJMcxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3ljwfo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743994470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRYTVXsNSGpfzKQctOT6faNFmutksfxmob0Nbhsev3k=;
	b=P3ljwfo7LjuHp1h1RUFkopyEtytYnsgatc+6SyKMmyahnO1fQ9LUAFjGh+TwCpzsZSXfjl
	lZcwushdumSo0Wwy5t2JEXeMZz4fSvbjryfomEGCtv4nLyzCyTnvnjREKx4bxIoGy6eeLu
	lCKnU7remxPLFdf4XPFELEg1v2sBLVU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-BY8yi40sP3OM-qRlZI5kbA-1; Sun, 06 Apr 2025 22:54:29 -0400
X-MC-Unique: BY8yi40sP3OM-qRlZI5kbA-1
X-Mimecast-MFC-AGG-ID: BY8yi40sP3OM-qRlZI5kbA_1743994468
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af5a8c67707so2027800a12.1
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 19:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743994468; x=1744599268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRYTVXsNSGpfzKQctOT6faNFmutksfxmob0Nbhsev3k=;
        b=qqDKBN66W9H4tE79ZqiZi9f8c/bCosJRBvKS3pkQxtVJiVkL7EQOZCFx9zXhMKxdiC
         y6z1PPI5ZhwsfvXqJjYdnjIyY2teVvrvDiUnjlKN7g0RzzCg7zRofPhH0DF14j4eoPTp
         DRQgImHowmdJc/8OrxlrHF0utCjpgesrvqKWQgIffHfYaXtJQ76WR57aDo6ASixu66BV
         5yHn0dpGupinCadjhkqAqFPTRDPZC5y3HBZXNYukbTK+fqlMDkkJiQ/MUtbEpqKhqYMt
         L4V16YMM/OxyX8r2aBAW2pnckoJYJ7wqy6oHRazxyOP4iu2qnH/BA7iXUYrv+hS5f45P
         CRpg==
X-Forwarded-Encrypted: i=1; AJvYcCXIi05divbLaCwbE3U2Ct+3840yvq0B0SDrsiqiqJhZKjGVNCxELXn71n2PeAcWJ5aEd//LYk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+q8e0FPx0mcQY9J1e0NWRdGn2lZLsaAdQBDqVzbAb8qQQ4I6
	p7nANbOuh0+3bL22rjvVQW0mbo0XIl0J7nSntrIFRatwjF7itNuocYzebsXuLCAXmBaxGK9I1fV
	7Fw7qX+Z6KdVV0s7IQa4PhZ5kwApDVxydCIUJIBMXQBvvJryEoXTyg1fSZM5qxGSDMYOR22LmaI
	AzKHUUwP5s0PY4/lIdA7NdqZLnCC7N
X-Gm-Gg: ASbGncuM+0zl2d/8TONHC42KNJYETjCefGzXafv82l1bd9yxT/UDiyuyZqMCCe70Ub8
	UjV12LyKASYJbdtgqCmJOmEFAuVTQrA1ZyLajmKZosRciitT/MJE4QxxloedXmVuOGBoFUw==
X-Received: by 2002:a17:90a:fc4d:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-306a612a138mr15338043a91.9.1743994468416;
        Sun, 06 Apr 2025 19:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXA7LEkfeKj+UJM3EgBo9JimsT+EXs1f53vLTWxMaMpQ0p3dYoCeDfB1sKILY75A1/XhDlE0eb1/3ARXiXCQg=
X-Received: by 2002:a17:90a:fc4d:b0:2fe:80cb:ac05 with SMTP id
 98e67ed59e1d1-306a612a138mr15338003a91.9.1743994468043; Sun, 06 Apr 2025
 19:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401043230.790419-1-jon@nutanix.com>
In-Reply-To: <20250401043230.790419-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:54:16 +0800
X-Gm-Features: ATxdqUFts7q2N1G290I9w5fzC7i8BKP_qVhbpym_CyiIkKmnXdbijEE_7p0Hj9Y
Message-ID: <CACGkMEty2SC--kiq64yfgWQ-q6Fg8b0+Le-dUGMaJgcOFhosRw@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Defer TX queue re-enable until after sendmsg
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 12:04=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> batches up to 64 messages before calling sock->sendmsg.
>
> Currently, when there are no more messages on the ring to dequeue,
> handle_tx_copy re-enables kicks on the ring *before* firing off the
> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> especially if it needs to wake up a thread (e.g., another vhost worker).
>
> If the guest submits additional messages immediately after the last ring
> check and disablement, it triggers an EPT_MISCONFIG vmexit to attempt to
> kick the vhost worker. This may happen while the worker is still
> processing the sendmsg, leading to wasteful exit(s).
>
> This is particularly problematic for single-threaded guest submission
> threads, as they must exit, wait for the exit to be processed
> (potentially involving a TTWU), and then resume.
>
> In scenarios like a constant stream of UDP messages, this results in a
> sawtooth pattern where the submitter frequently vmexits, and the
> vhost-net worker alternates between sleeping and waking.
>
> A common solution is to configure vhost-net busy polling via userspace
> (e.g., qemu poll-us). However, treating the sendmsg as the "busy"
> period by keeping kicks disabled during the final sendmsg and
> performing one additional ring check afterward provides a significant
> performance improvement without any excess busy poll cycles.
>
> If messages are found in the ring after the final sendmsg, requeue the
> TX handler. This ensures fairness for the RX handler and allows
> vhost_run_work_list to cond_resched() as needed.
>
> Test Case
>     TX VM: taskset -c 2 iperf3  -c rx-ip-here -t 60 -p 5200 -b 0 -u -i 5
>     RX VM: taskset -c 2 iperf3 -s -p 5200 -D
>     6.12.0, each worker backed by tun interface with IFF_NAPI setup.
>     Note: TCP side is largely unchanged as that was copy bound
>
> 6.12.0 unpatched
>     EPT_MISCONFIG/second: 5411
>     Datagrams/second: ~382k
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  15.5 GBytes  4.43 Gbits/sec  0/11481630 (0%)  sender
>
> 6.12.0 patched
>     EPT_MISCONFIG/second: 58 (~93x reduction)
>     Datagrams/second: ~650k  (~1.7x increase)
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  26.4 GBytes  7.55 Gbits/sec  0/19554720 (0%)  sender
>
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


