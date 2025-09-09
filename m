Return-Path: <netdev+bounces-221356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B1B50438
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912227B956C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30B341651;
	Tue,  9 Sep 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH7rPcrK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA043314D5
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438184; cv=none; b=UmyYoAw+nGkdEqzbqLgIAWbtzHg3+uIvV48rb7ydOlnUXTtnjQhupl1FqVI4vJ5bim016TutRgkCe7B437+Tz/LYH5xzODlUg4OGHcTdebn4gj4SIlcFmv2wo8qYIudhpYsmgkc5TkrX2U/SGnUkoTNFNMEPLAdjGZgn8+mIL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438184; c=relaxed/simple;
	bh=1776x5WNuqGQXUdGA1Vx2rw6TH5/YKvwrIJKYIxvYXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geg2engvjUpxBXcaOvJgG26kIYMDf4rTrAQFv4p+r1/5XUWiEetIPUyqGPU6sEPN2UHeZAdV5V5ZC0nVjJEqpz1pnLckfxQ4z3MpElOJW86c3pJVQFhPEEmKyarha5Cqm/Dxp99ZAiMQcjUqOogbFjjwLQ3SweO7S/26RCh9JMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH7rPcrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757438181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+QDVhIlXWVQYYj2EpRYmCRki550WcQuDpwFnUZzK9w=;
	b=ZH7rPcrKVYRQVCvFA1f3KAEMkgvKd7fhF+55cBDv+eksNAqQPPQ3HYNrCMeMT/RnYGquDn
	+ycrBevoRYg9mlSO33Dgl9ApXpfkUPERnMEoGDDAYlkZ4BhaC//CUuGLP2ba7sgVZEZtSs
	VglA28rKkCtOs/ivH68vhwjAfqSBd3g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-8q5rAUrtNUyreY5zjAp-hg-1; Tue,
 09 Sep 2025 13:16:18 -0400
X-MC-Unique: 8q5rAUrtNUyreY5zjAp-hg-1
X-Mimecast-MFC-AGG-ID: 8q5rAUrtNUyreY5zjAp-hg_1757438177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CF4A195608E;
	Tue,  9 Sep 2025 17:16:16 +0000 (UTC)
Received: from localhost (unknown [10.45.226.196])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2D5A1800447;
	Tue,  9 Sep 2025 17:16:14 +0000 (UTC)
Date: Tue, 9 Sep 2025 18:16:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <20250909171613.GB2390@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909151851.GB1460@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

So I was playing with this (see commands at end if you want to try)
and it turns out that the nbd-client program doesn't support vsock
anyway.  Of course you could still call the kernel APIs directly to
set up the socket, but it wouldn't be straightforward.

nbd-client did support Sockets Direct Protocol (SDP) but support was
removed in 2023.

The userspace tools like nbdinfo (part of libnbd) work fine, but of
course that's not relevant to the kernel NBD client.

Rich.


Commands to test vsock:

  $ virt-builder fedora-42

  $ nbdkit --vsock memory 1G \
           --run '
      qemu-system-x86_64 -machine accel=kvm:tcg \
                         -cpu host -m 4096 \
                         -drive file=fedora-42.img,format=raw,if=virtio \
                         -device vhost-vsock-pci,guest-cid=3
   '

Inside the guest:

  # dnf install nbdinfo
  # nbdinfo nbd+vsock:///
  (details of the 1G RAM disk will be shown here)

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


