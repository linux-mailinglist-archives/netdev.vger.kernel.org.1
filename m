Return-Path: <netdev+bounces-57477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D469681324F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D23B1F21279
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A005789E;
	Thu, 14 Dec 2023 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chRmS2GI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E686A7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702562298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJb/JZ5DIeJAEZiRa30hG/dhyz0C7/rbH/xtFkoJWDc=;
	b=chRmS2GItxois/SqUXyTneXL5c8kZfuOp0lkbaDGVtmminEdUZzcYqWanCO7NkAgJSZTwv
	rAb8Eo9US2NJnF54DyOIGNyDX4evFVoE+RjDZ+T57Yp2xHyn5EqayD8OfhX9Pa6vuOOJIi
	cFKiispO7WJJ5WyOBEKSMvSwgsaRSEI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-N5VKs-CWOFOW6d-BXFYRaw-1; Thu, 14 Dec 2023 08:58:17 -0500
X-MC-Unique: N5VKs-CWOFOW6d-BXFYRaw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5e3a77ad1a6so5677847b3.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562297; x=1703167097;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJb/JZ5DIeJAEZiRa30hG/dhyz0C7/rbH/xtFkoJWDc=;
        b=p610++W0KRySjEbyXA/1yk2G4nYx5xDkoaAiwt/x0bR3yIXHLGFqIXIfbEshHYZwVQ
         hC3dEV8w4UfbXzsyZ0ZTtuBcdLNnjeShg0ae4pXPJ9bNfMTl7Ijgpwq1MQ8+7dZi6vyq
         NkVD97t9x55xxZGcdlW46jXJxFYk/kDyPLlAd8Kwd211BWPzUjQhN7G9MX0bOz8+JE4s
         5W0cnNsXPJjAn7XAcwRZnDgqHiPo4V3S/HerV/UV2rLKBR4LdspTv1bkgHVs5CCKkd18
         lFI1RSPnmplIWF4u9aolA13nNXWhduqheYZjeNWnQi/M4reAu0PYFzSRaMEJmaAXQ4dt
         lrKA==
X-Gm-Message-State: AOJu0Yy7UXieGPTKCS0mYdufhXATX5IktmsVFEQsprc75iAAMR9I1DUH
	ZsACwrMR7lpW4KgPekX3ThkQ4jHPIDB+Fus41YNULmsNSLcZCWpr3fs3DVzP5szR0MEfGCuq9gK
	ek0tAL1ib1KhHv1tN
X-Received: by 2002:a0d:d845:0:b0:5e3:ca00:9967 with SMTP id a66-20020a0dd845000000b005e3ca009967mr446795ywe.51.1702562297074;
        Thu, 14 Dec 2023 05:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS7kdvyTqXPlUr1rZsJgktdjWBr/8U3nDefOdKeX0+UOYgJ1x+/oj6T1jy3NVpQiwvjdBVdQ==
X-Received: by 2002:a0d:d845:0:b0:5e3:ca00:9967 with SMTP id a66-20020a0dd845000000b005e3ca009967mr446787ywe.51.1702562296787;
        Thu, 14 Dec 2023 05:58:16 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id w3-20020a0cf703000000b0067f11d1829asm99352qvn.20.2023.12.14.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:58:16 -0800 (PST)
Date: Thu, 14 Dec 2023 22:58:12 +0900 (JST)
Message-Id: <20231214.225812.609786828308701015.syoshida@redhat.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com, nogikh@google.com,
 syzkaller@googlegroups.com
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if
 sk_wait_event() fails
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231214134615.55389-1-kuniyu@amazon.com>
References: <20231214.223106.2284573595890480656.syoshida@redhat.com>
	<20231214134615.55389-1-kuniyu@amazon.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 22:46:14 +0900, Kuniyuki Iwashima wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Thu, 14 Dec 2023 22:31:06 +0900 (JST)
>> On Thu, 14 Dec 2023 17:46:22 +0900, Kuniyuki Iwashima wrote:
>> > From: Shigeru Yoshida <syoshida@redhat.com>
>> > Date: Thu, 14 Dec 2023 14:09:22 +0900
>> >> The following NULL pointer dereference issue occurred:
>> >> 
>> >> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> >> <...>
>> >> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
>> >> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
>> >> <...>
>> >> Call Trace:
>> >>  <TASK>
>> >>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>> >>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
>> >>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
>> >>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>> >>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>> >>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>> >>  __do_sys_sendmsg net/socket.c:2650 [inline]
>> >>  __se_sys_sendmsg net/socket.c:2648 [inline]
>> >>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>> >>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>> >>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>> >>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> >> 
>> >> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
>> >> socket waiting for the event. However, sk_stream_wait_connect() returns
>> >> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
>> >> that waits for a connection with sk_stream_wait_connect() may misbehave.
>> >> 
>> >> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
>> >> connection. If disconnect() is called in concurrently, the above issue
>> >> occurs.
>> >> 
>> >> This patch fixes the issue by returning error from sk_stream_wait_connect()
>> >> if sk_wait_event() fails.
>> >> 
>> >> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
>> >> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> > 
>> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> > 
>> > I guess you picked this issue from syzbot's report.
>> > https://lore.kernel.org/netdev/0000000000009e122006088a2b8d@google.com/
>> > 
>> > If so, let's give a proper credit to syzbot and its authors:
>> > 
>> > Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
>> 
>> Hi Kuniyuki-san,
>> 
>> Thank you very much for your review. I didn't notice the syzbot's
>> report. Actually, I found this issue by running syzkaller on my
>> machine.
> 
> Thanks for clarifying.
> 
> I'm also running syzkaller locally and used to add
> 
>   Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> But, it was confusing for syzbot's owners, and I got a mail from one of
> the authors, Aleksandr Nogikh.  Since then, if syzkaller found an issue
> that was not on the syzbot dashboard, I have used
> 
>   Reported-by: syzkaller <syzkaller@googlegroups.com>

Thanks for your information. This tag looks great, so I will use this
next time I send a fix found by local syzkaller :)

Thanks,
Shigeru

> 
> .  FWIW, here's Aleksandr's words from the mail.
> 
> ---8<---
> Maybe it would be just a little more clear if instead of
> Reported-by: syzbot <syzkaller@googlegroups.com>
> you'd write
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> if the bug was found only by a local syzkaller instance, because
> otherwise it implies that the bug was found by syzbot, which is not
> really the case here :)
> ---8<---
> 
> 
>> 
>> Now, I tested this patch with syzbot, and it looks good.
>> 
>> Reported-and-tested-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> 
> This time, this tag is best.
> 
> Thanks!
> 
> 


