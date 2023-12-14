Return-Path: <netdev+bounces-57452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2398131A0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A40B20E8D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80E56473;
	Thu, 14 Dec 2023 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXPQ9RFD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C0114
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702560673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhDJJg4/pl3h7/mBVAHcUZIMYz0zIwkzbR3me6ootLo=;
	b=dXPQ9RFDqbgpm1kNlzP9im8G7Gf57ftxu3UvhfUTqyp/12gE36fr7e7m7dWPYmaNaLVduI
	xhc6pejFO5574VymcdNI2AIYAttfwJIa19CPw28SV1862dgJRRZSld/g0GzznTYQ+VYzgZ
	I27AX/YCfuz6A/42lmo51xlIek61hQQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688--oHIsoBzO1WpfYQt12tRBw-1; Thu, 14 Dec 2023 08:31:11 -0500
X-MC-Unique: -oHIsoBzO1WpfYQt12tRBw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d379a01995so1219075ad.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560671; x=1703165471;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FhDJJg4/pl3h7/mBVAHcUZIMYz0zIwkzbR3me6ootLo=;
        b=mY+K6cJdGl8yHJgaRCFfDg5zPRy84pog+GAblbZMM3Rw3lZ/eX9q6QgsIsR50hU9sZ
         pKeTM/exnGMLxoR/WAw4z4Xjg0/BBrhiWycB6D8BP9PHgjdXI7w5GPruNqjv0EFNlHh6
         LjHm9uWwz6+57chj+e+mJVs2oO41UMVSSjnH5v7rJ59DIzBZT8rxwxlV6wR0LTtjOuLj
         ugDwvnYUEj+dInZQN6Nw8Oa7xikuMFvsvxOBgAiJZHDcrN/eMR/tQebZ9zpIa34mhlo3
         GfQe6yywIP60Kib1L99TyS2foEvbtXnQggvXMxMfJZ1BaXz0l5CuIaxa86KznUMsCz6n
         XYlw==
X-Gm-Message-State: AOJu0YyhSBsTx6bnZ9INN7tJwfpbzANeybvKIBM0/ZSVJs50Hfi3HWOD
	RN8tocLlOgIO2bJyP59WwQGE9vfxLECoi6G3K6duz1kXsozPyIPMpz7H3bU2oWe0vRGVS57ba+q
	+hSXD0Y3EffXHsDXD
X-Received: by 2002:a17:902:704c:b0:1d0:ba40:b0e1 with SMTP id h12-20020a170902704c00b001d0ba40b0e1mr9807091plt.124.1702560670769;
        Thu, 14 Dec 2023 05:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvzQXchsfgSrtil39BRsvRrN20J5DTpVZDJweM/m8itxlUXPPJj5M/aYG+sgscJd5tcBM09Q==
X-Received: by 2002:a17:902:704c:b0:1d0:ba40:b0e1 with SMTP id h12-20020a170902704c00b001d0ba40b0e1mr9807081plt.124.1702560670453;
        Thu, 14 Dec 2023 05:31:10 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902e88d00b001d087f68ef8sm1365993plg.37.2023.12.14.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:31:09 -0800 (PST)
Date: Thu, 14 Dec 2023 22:31:06 +0900 (JST)
Message-Id: <20231214.223106.2284573595890480656.syoshida@redhat.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if
 sk_wait_event() fails
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231214084622.15054-1-kuniyu@amazon.com>
References: <20231214050922.3480023-1-syoshida@redhat.com>
	<20231214084622.15054-1-kuniyu@amazon.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


On Thu, 14 Dec 2023 17:46:22 +0900, Kuniyuki Iwashima wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Thu, 14 Dec 2023 14:09:22 +0900
>> The following NULL pointer dereference issue occurred:
>> 
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> <...>
>> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
>> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
>> <...>
>> Call Trace:
>>  <TASK>
>>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
>>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>>  __do_sys_sendmsg net/socket.c:2650 [inline]
>>  __se_sys_sendmsg net/socket.c:2648 [inline]
>>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> 
>> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
>> socket waiting for the event. However, sk_stream_wait_connect() returns
>> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
>> that waits for a connection with sk_stream_wait_connect() may misbehave.
>> 
>> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
>> connection. If disconnect() is called in concurrently, the above issue
>> occurs.
>> 
>> This patch fixes the issue by returning error from sk_stream_wait_connect()
>> if sk_wait_event() fails.
>> 
>> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> I guess you picked this issue from syzbot's report.
> https://lore.kernel.org/netdev/0000000000009e122006088a2b8d@google.com/
> 
> If so, let's give a proper credit to syzbot and its authors:
> 
> Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

Hi Kuniyuki-san,

Thank you very much for your review. I didn't notice the syzbot's
report. Actually, I found this issue by running syzkaller on my
machine.

Now, I tested this patch with syzbot, and it looks good.

Reported-and-tested-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com

Thanks,
Shigeru

> 
> Thanks!
> 
>> ---
>>  net/core/stream.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/core/stream.c b/net/core/stream.c
>> index 96fbcb9bbb30..b16dfa568a2d 100644
>> --- a/net/core/stream.c
>> +++ b/net/core/stream.c
>> @@ -79,7 +79,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
>>  		remove_wait_queue(sk_sleep(sk), &wait);
>>  		sk->sk_write_pending--;
>>  	} while (!done);
>> -	return 0;
>> +	return done < 0 ? done : 0;
>>  }
>>  EXPORT_SYMBOL(sk_stream_wait_connect);
>>  
>> -- 
>> 2.41.0
>> 
> 


