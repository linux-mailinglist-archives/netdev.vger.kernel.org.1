Return-Path: <netdev+bounces-276885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMaTJxRh12keNQgAu9opvQ
	(envelope-from <netdev+bounces-276885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EF23C7A9B
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAFE6303133D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D83A1CEA;
	Thu,  9 Apr 2026 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwhxTdEv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wjhiu818"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CC379EFC
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722522; cv=none; b=ZmbKxKbvicfb4rdYTztSW93YxzdLxt9ICLelbzinszpyLcpZaK8P/hEQtHfYJDbtlD7RZVBLkQgC2yxwctmKuwNiElZDhKyOY0S4jMQ4apdyEiXA5wNqpuOy94uTa8qLl8afZjRUni4jtC/Scx9LOlAIeRA2vGmCaZcAZzx1hWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722522; c=relaxed/simple;
	bh=ViUWTbxzqLiz+bjT6kNpMm3A+rp4vQhIUI3KLLYnKSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFmI6PvUUFKEY6bVBvmrEKuhmIjiTJqY1t3QibhmWvU6jaMy8t/QLtX83NjWg0nUvgkBkT0CWqyg25FSGCVfwjMrmPY+Zgko2w9r5KW6rQNKMuP/WEEtMJPbNM8woGGXZZYWiponQCoZ47uHNYCY3j8XdcZ18l4CS3SM7yYbWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwhxTdEv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wjhiu818; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775722515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBlO5ol4JYeFYnCYmjdYNmrwtgmQD85aVwql8OGMj8E=;
	b=DwhxTdEv5/WKRWyUYG5S16WE/BayrUg2DJv4H2Se4bVXz5JLApgGvsvujptrq3cSfmPUxc
	vQ7aTHAaa2wIyNxV+/G44HJJJ93v8EWPfPYq3UC5YWC9gfqvY9R2gsVGZWaMYxsn5r01Rj
	bGiTWPLKCHw6yvPdR1fXbL1/LeM52zs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-nKhkUHeGNpqmXyz5zgwIQw-1; Thu, 09 Apr 2026 04:15:14 -0400
X-MC-Unique: nKhkUHeGNpqmXyz5zgwIQw-1
X-Mimecast-MFC-AGG-ID: nKhkUHeGNpqmXyz5zgwIQw_1775722513
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cff5ef652so341204f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775722512; x=1776327312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBlO5ol4JYeFYnCYmjdYNmrwtgmQD85aVwql8OGMj8E=;
        b=Wjhiu818fPrBnD3V7FarxyFqzb99r5nRuymLR98p8W10exUJwUwFQodB7L+r284DT5
         +H3CUjm8aqairmcA12JvzGt40cJVGp8crl/EgC4ItomyYsV18iRthys9Q8Yf7AMJs2Uz
         lIqi7yefTOhnrFdr9WFsxCWbw5lz0t/yeANlXCUZ6wyOlIh7uGl27yJha2HQAjzobX07
         prbSjhDd5msJcVLBHFmYqy1pHJCu+fjBECxDMatB50lJ8xjT09yHwWkGDqi/K4t1vgT+
         JaMHBn2WGS6JgLpZoAr1o3qh04eMqqVQuIGQgnVHy8j38/+/VI/OSC3qZ7Lf5adNrhOz
         o8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722512; x=1776327312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBlO5ol4JYeFYnCYmjdYNmrwtgmQD85aVwql8OGMj8E=;
        b=PxPSlX1RziX/sqf4OUy5YaA1lGreybiezOEpS25JmPvgLdgvkjjPMS1Gdp4CmP3EzU
         gTdPNFT94sfqQhpAr8gGKJkDA0suU3DzEfWTsgokhFtAoDfxhjdtmW/8Cib4Ybd475jA
         frd+IMwpz17VHKlakDFCLq3zKYMRVaz7nHzsUzySamJHBDj63hDhajvukglAsDzqOer5
         ooPfuqPqPaO+6lVLqNdhXZ9n//XOQwfWxhbM2DRSWMnSZc0o/UtR+9aMSybkPhGre74B
         GscOqpvk6V5eZ1SL2WFb0d6CCTeJfBpckGd0ldCBteTPJLe9X0PCvpJpu17slWvodTnA
         /AYg==
X-Forwarded-Encrypted: i=1; AJvYcCUTfTfOYfjBA49TM+MtPyGRngOePWji3iz2ElNTnFoo7DxfvNc4MkFFp0SFSz7NTl6QgBKUkZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpV4RChQt7SoEGxzQOHgNop24L3pcZnJcmNWlCfR9/Q9k6sIw
	hsBMBMPLs6oJ/vyxD/Wj95SiFFrWz2TzLcc6nhKhyfibEwxYZVZFX/wTDplJeOtGv4VFUj4Rj3e
	AzywSvL7KhbSuFG9Jd74HPJUMyTqXi3wcvOTagD/aXziqCSV5Ys993ZgnCKQueeoiSQ==
X-Gm-Gg: AeBDiesmOLKnWNP+WesUXX/OYEkeAjORloyIVuV0501DQreg43G6u6ktfwdLx98eAao
	mpSkVQN7znNJFPF4UyhfTuPfYcrb6ZB2XaJY7Z8Padgze2qYezFIGLopUsjqZCpaWCXqgn6Tsw6
	9o/0hcizlzKEQ2incJ9L/tY8AQgzRRmCEV52fJkYbBbqChUOhmwJtr5R5/3WXngmoSeY5ZXxnm1
	WDTE0J5dPnh3sNkLdANdWVm7TJgshL7hOKTJ2aclgCaE+MpghRDToW+weNS9eFkWjuMAuDV52Pk
	zXrj9ZO1rynStfT2LN/7vbRDVaitrhKxJoCcvdztqto76odZv411fUrd2iXbcX/gK9XHa6jJKR9
	oGUsl6lOBXiKiOB2OQcKJYNtMZlhlXXS5wPtcxdb4vTu/v140p1kAG03R
X-Received: by 2002:a05:6000:420c:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-43d292da9fbmr36012404f8f.36.1775722512337;
        Thu, 09 Apr 2026 01:15:12 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-43d292da9fbmr36012318f8f.36.1775722511701;
        Thu, 09 Apr 2026 01:15:11 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm67141591f8f.21.2026.04.09.01.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:15:11 -0700 (PDT)
Message-ID: <27261b68-0f28-42a3-bb5f-5bbf4ac450ec@redhat.com>
Date: Thu, 9 Apr 2026 10:15:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] l2tp: Drop large packets with UDP encap
To: Alice Mikityanska <alice@isovalent.com>, Simon Horman <horms@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, James Chapman <jchapman@katalix.com>,
 netdev@vger.kernel.org, syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
References: <20260403174949.843941-1-alice.kernel@fastmail.im>
 <20260408164825.GH469338@kernel.org>
 <CAD0BsJU8-NBeAGn_rPD-woZARNZ8vb6uJGMDNf70syRkzKiL4A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAD0BsJU8-NBeAGn_rPD-woZARNZ8vb6uJGMDNf70syRkzKiL4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,katalix.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-276885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci3edea60a44225dec];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: D0EF23C7A9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 7:11 PM, Alice Mikityanska wrote:
> On Wed, 8 Apr 2026 at 19:48, Simon Horman <horms@kernel.org> wrote:
>> On Fri, Apr 03, 2026 at 08:49:49PM +0300, Alice Mikityanska wrote:
>>> From: Alice Mikityanska <alice@isovalent.com>
>>>
>>> syzbot reported a WARN on my patch series [1]. The actual issue is an
>>> overflow of 16-bit UDP length field, and it exists in the upstream code.
>>> My series added a debug WARN with an overflow check that exposed the
>>> issue, that's why syzbot tripped on my patches, rather than on upstream
>>> code.
>>>
>>> syzbot's repro:
>>>
>>> # {"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false,"callcomments":true}
>>> r0 = socket$pppl2tp(0x18, 0x1, 0x1)
>>> r1 = socket$inet6_udp(0xa, 0x2, 0x0)
>>> connect$inet6(r1, &(0x7f00000000c0)={0xa, 0x0, 0x0, @loopback, 0xfffffffc}, 0x1c)
>>> connect$pppl2tp(r0, &(0x7f0000000240)=@pppol2tpin6={0x18, 0x1, {0x0, r1, 0x4, 0x0, 0x0, 0x0, {0xa, 0x4e22, 0xffff, @ipv4={'\x00', '\xff\xff', @empty}}}}, 0x32)
>>> writev(r0, &(0x7f0000000080)=[{&(0x7f0000000000)="ee", 0x34000}], 0x1)
>>>
>>> It basically sends an oversized (0x34000 bytes) PPPoL2TP packet with UDP
>>> encapsulation, and l2tp_xmit_core doesn't check for overflows when it
>>> assigns the UDP length field. The value gets trimmed to 16 bites.
>>>
>>> Add an overflow check that drops oversized packets and avoids sending
>>> packets with trimmed UDP length to the wire.
>>>
>>> syzbot's stack trace (with my patch applied):
>>>
>>> len >= 65536u
>>> WARNING: ./include/linux/udp.h:38 at udp_set_len_short include/linux/udp.h:38 [inline], CPU#1: syz.0.17/5957
>>> WARNING: ./include/linux/udp.h:38 at l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline], CPU#1: syz.0.17/5957
>>> WARNING: ./include/linux/udp.h:38 at l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327, CPU#1: syz.0.17/5957
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 5957 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>> RIP: 0010:udp_set_len_short include/linux/udp.h:38 [inline]
>>> RIP: 0010:l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline]
>>> RIP: 0010:l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327
>>> Code: 0f 0b 90 e9 21 f9 ff ff e8 e9 05 ec f6 90 0f 0b 90 e9 8d f9 ff ff e8 db 05 ec f6 90 0f 0b 90 e9 cc f9 ff ff e8 cd 05 ec f6 90 <0f> 0b 90 e9 de fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 4f
>>> RSP: 0018:ffffc90003d67878 EFLAGS: 00010293
>>> RAX: ffffffff8ad985e3 RBX: ffff8881a6400090 RCX: ffff8881697f0000
>>> RDX: 0000000000000000 RSI: 0000000000034010 RDI: 000000000000ffff
>>> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
>>> R10: dffffc0000000000 R11: fffff520007acf00 R12: ffff8881baf20900
>>> R13: 0000000000034010 R14: ffff8881a640008e R15: ffff8881760f7000
>>> FS:  000055557e81f500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000200000033000 CR3: 00000001612f4000 CR4: 00000000000006f0
>>> Call Trace:
>>>  <TASK>
>>>  pppol2tp_sendmsg+0x40a/0x5f0 net/l2tp/l2tp_ppp.c:302
>>>  sock_sendmsg_nosec net/socket.c:727 [inline]
>>>  __sock_sendmsg net/socket.c:742 [inline]
>>>  sock_write_iter+0x503/0x550 net/socket.c:1195
>>>  do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
>>>  vfs_writev+0x33c/0x990 fs/read_write.c:1059
>>>  do_writev+0x154/0x2e0 fs/read_write.c:1105
>>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f636479c629
>>> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffffd4241c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
>>> RAX: ffffffffffffffda RBX: 00007f6364a15fa0 RCX: 00007f636479c629
>>> RDX: 0000000000000001 RSI: 0000200000000080 RDI: 0000000000000003
>>> RBP: 00007f6364832b39 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 00007f6364a15fac R14: 00007f6364a15fa0 R15: 00007f6364a15fa0
>>>  </TASK>
>>>
>>> [1]: https://lore.kernel.org/all/20260226201600.222044-1-alice.kernel@fastmail.im/
>>>
>>> Reported-by: syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
>>
>> Hi Alice,
>>
>> A Fixes tag needs to go here.
>> And if it's fixing code present in net - that is, the bug can manifest
>> there - then it should be targeted at net rather than net-next.
> 
> Thanks for the review! I submitted to net-next, because I wanted to
> piggy-back my net-next series on top of this fix without making a
> merge conflict, and the bug didn't look that critical to go to net
> (sometimes I received feedback that my bugfixes should have been
> submitted to -next). 

The expected workflow in this case is: submit the fix(es) to net, wait
for the following net -> net-next cross merge (happens on Thursday),
submit the dependent net-next patch(es).

> I can resubmit to net, if it's something that
> deserves backporting, or the maintainers can apply it to net instead.
> For the Fixes tag, I can take the closest commit:
> 
> Fixes: 0d76751fad77 ("l2tp: Add L2TPv3 IP encapsulation (no UDP) support")
> 
> It's old enough (2010) to cover all supported LTS kernels. Or I can go
> as deep as:
> 
> Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")

It looks like the correct fix tag is the latter. The patch LGTM and
given the current PW status, I'm applying it to net without a repost.
Thanks,

Paolo


