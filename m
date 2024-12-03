Return-Path: <netdev+bounces-148504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43EA9E1E90
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2749BB29543
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4131EF08A;
	Tue,  3 Dec 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8lhHuqO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F41E4B0
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234417; cv=none; b=BNESRh6yz6bJdyeGuCK3FVEkxCN2AumCy31H8HyW6AgLnmnrZow+opvUcKoBZ+MIszemXHyaDZPUXc5veAB0L0uSvXVZjvjYHtFFgA34PkSFhJTld2sAzSSoP/xDPnKkHnIkkAl7cl82eGsv19Kq9OLdyDIICNHfl47X/61QcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234417; c=relaxed/simple;
	bh=dJjfJif9+NlZQkMt5icrEVoK39zkPJdf3OM+1DJQHmg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QTZyte7SsOv73z9n84ht3qa0eiuneFFM7dRJsfkZ6Trb1vR5M10k8eY1cE7a1yrN/5Oemab7dHw0YQ5/pgQ7i35a3QqQdh3HPy2qiKeyuEg39dFPwWgBxVgDve0PwpgsfnHHqrOtZhR+cCG+P6H7peqfMf8pmijBRIi+jM2xjt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8lhHuqO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733234415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl1kU/L6n+zaZv63NSCNUSgE6RK0H5Lz0VGKZARdJxc=;
	b=c8lhHuqO2dirkupX6TBvHplS9ON5Ix5VoyKiqUuNt9MQ8wOKCPveCmoFQJgnVpXF1jq875
	e/8CMYMTHOoJgSuWUqCPFeHYUD/NU22C2hIvZ61Q3cq4PnuYzHxsd4tlo2jYBkgyxdfP+P
	Fv4gIjVXitrd6KXYBVvg+utk7bHFTb4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-QmmnLEnVMsOL9QpNqkm1RQ-1; Tue, 03 Dec 2024 09:00:13 -0500
X-MC-Unique: QmmnLEnVMsOL9QpNqkm1RQ-1
X-Mimecast-MFC-AGG-ID: QmmnLEnVMsOL9QpNqkm1RQ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-215936689e4so23981245ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234413; x=1733839213;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fl1kU/L6n+zaZv63NSCNUSgE6RK0H5Lz0VGKZARdJxc=;
        b=ETjmL4uc0QRsSEu0knFkR8xLvSjug2GPqMB0wbAqnK5jvt5ca5jfj4jLLC6qGimIcj
         sDwdyzjXtHAFazzo9iZQ5VaLQLCLZiS5s0s4S0A7whW2FM8hI4MnCLGbYXDNPleHAtsN
         G/hvp1PuObQWalbE+qCMj5amoijP7TYWkAGvGAAHVztbc3zMlH+C1JfuxPTxdtNyfvhS
         e10NA5xpS9yMS82OkwzS0laUe6Rpeueso0sQwgrsfHS4XwiIDloNvI0fxY/YHkO61ImL
         HtugpF54Vy2FrmJnODWuD5iCCCG2DHZaD5mKdOG31KAEDy78oo5pKqyDEs3w5iPrlmae
         On/w==
X-Forwarded-Encrypted: i=1; AJvYcCUEaKRpS96/fEGFYfkXgOMALwsTwtXtJPjJGdJMxH1Cz+5+4D++0V4FxAf5nXd4rg++aY+LPnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1x8RiIfK0HOiQ2GKLY2bDvcKMKC659lctQhPSiQGme0E+wUOh
	Jz8nXaJp0G8t/Uf78QwtY7jLXuKGIsP7JnE5+5ns70SYNBtZvEUfg8CXXSSoNPh+9TiJnFVAH5w
	votlLQ6nYXddxASI/O+Z59hVSzBV6he96BJIbt/0k4e4e0yTrldkHCw==
X-Gm-Gg: ASbGncvryjoYnqVM5YCkSB29GmZGJanDxNcK+Je72HvU/gygBE+1strxZSa+wCVaBly
	Y8dEmV6qsPmBrwcCoWyrfOEwtzm80xreTjTpVIzjNNsp/tfVHb0jKHOcfHFhx6yHT314QhPO8HV
	S/rVYYKgwmomg5cJQbv3ZY3959e5qPJURcz1FuB50KT14kqwAZf8ccK+J4lTLqBpN54SbvNZoY8
	C8c6DdSUdBWLtC+dcVq1lURCG+PfivBDQm5KIwKxqPVDaE=
X-Received: by 2002:a17:902:e742:b0:215:a039:738 with SMTP id d9443c01a7336-215bcea13a8mr32180485ad.5.1733234409471;
        Tue, 03 Dec 2024 06:00:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYiuXZetHC7zsjaCgaDZyegMyjpvT6rLdlGDyG4NPwbra0JvrrlkQFkV9cOrYMzAmHqqmD5Q==
X-Received: by 2002:a17:902:e742:b0:215:a039:738 with SMTP id d9443c01a7336-215bcea13a8mr32172915ad.5.1733234404092;
        Tue, 03 Dec 2024 06:00:04 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2154c2b9bdcsm71167585ad.258.2024.12.03.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:00:03 -0800 (PST)
Date: Tue, 03 Dec 2024 22:59:56 +0900 (JST)
Message-Id: <20241203.225956.138899513616764420.syoshida@redhat.com>
To: stfomichev@gmail.com, martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [PATCH bpf] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <Z05Ln1XgniGiSuKu@mini-arch>
References: <Z03dL0zxEnmzZUN7@mini-arch>
	<80d8c4cf-2897-4385-b849-2dbac863ee39@linux.dev>
	<Z05Ln1XgniGiSuKu@mini-arch>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 16:06:55 -0800, Stanislav Fomichev wrote:
> On 12/02, Martin KaFai Lau wrote:
>> On 12/2/24 8:15 AM, Stanislav Fomichev wrote:
>> > On 12/02, Shigeru Yoshida wrote:
>> > > KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
>> > > cause of the issue was that eth_skb_pkt_type() accessed skb's data
>> > > that didn't contain an Ethernet header. This occurs when
>> > > bpf_prog_test_run_xdp() passes an invalid value as the user_data
>> > > argument to bpf_test_init().
>> > > 
>> > > Fix this by returning an error when user_data is less than ETH_HLEN in
>> > > bpf_test_init().
>> > > 
>> > > [1]
>> > > BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> > > BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>> > >   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>> > >   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>> > >   __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
>> > >   xdp_recv_frames net/bpf/test_run.c:272 [inline]
>> > >   xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>> > >   bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
>> > >   bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
>> > >   bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
>> > >   __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
>> > >   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>> > >   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>> > >   __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
>> > >   x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
>> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> > >   do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
>> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> > > 
>> > > Uninit was created at:
>> > >   free_pages_prepare mm/page_alloc.c:1056 [inline]
>> > >   free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
>> > >   __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
>> > >   bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
>> > >   ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
>> > >   bpf_map_free kernel/bpf/syscall.c:838 [inline]
>> > >   bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
>> > >   process_one_work kernel/workqueue.c:3229 [inline]
>> > >   process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
>> > >   worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
>> > >   kthread+0x535/0x6b0 kernel/kthread.c:389
>> > >   ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>> > >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>> > > 
>> > > CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
>> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
>> > > 
>> > > Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
>> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
>> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> > > ---
>> > >   net/bpf/test_run.c | 2 +-
>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > > 
>> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> > > index 501ec4249fed..756250aa890f 100644
>> > > --- a/net/bpf/test_run.c
>> > > +++ b/net/bpf/test_run.c
>> > > @@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>> > >   	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>> > >   		return ERR_PTR(-EINVAL);
>> > > -	if (user_size > size)
>> > > +	if (user_size < ETH_HLEN || user_size > size)
>> > >   		return ERR_PTR(-EMSGSIZE);
>> > >   	size = SKB_DATA_ALIGN(size);
>> > > -- 
>> > > 2.47.0
>> > > 
>> > 
>> > I wonder whether 'size < ETH_HLEN' above is needed after your patch.
>> > Feels like 'user_size < ETH_HLEN' supersedes it.
>> 
>> May be fixing it by replacing the existing "size" check with "user_size"
>> check? Seems more intuitive that checking is needed on the "user_"size
>> instead of the "size". The "if (user_size > size)" check looks useless also.
>> Something like this?
>> 
>> -	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
>> +	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
>> 		return ERR_PTR(-EINVAL);
>> 
>> -	if (user_size > size)
>> -		return ERR_PTR(-EMSGSIZE);
>> -
>> 
> 
> Agreed, that should do it. IIUC, 'user_size > size' only makes sense
> for the bpf_prog_test_run_xdp case and the caller handles this case
> anyway (size > max_data_sz).

Thank you for your comment.  I'll take your suggestion and test it
with the reproducer.

Thanks,
Shigeru


