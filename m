Return-Path: <netdev+bounces-280087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDRbG4Bj52l07gEAu9opvQ
	(envelope-from <netdev+bounces-280087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:46:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B143A318
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064043006974
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4630E836;
	Tue, 21 Apr 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3pHZQhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2001273D8D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771883; cv=none; b=NxChag+vBIWLdqKv/0BqAa0hJ1sYpdwSCJLBFgz2YOOzoR5b7eQ4tMbjzpqdgYDqfFL7yKj3qru8nBNznVDjjyi23RwFBT6Na6lkJeW8duV4vJaiBqUQjC5TPQqaWei2GgNUiPbFxKW0ululDEZaF/PF65n//jcFRe9VAA7kwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771883; c=relaxed/simple;
	bh=r90+RDns2ZPzVjbqOJnlJ8juGqdMvz1PjVUieZnHHwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+PdqbUhwdBxJDN+9WRuRbAJ6m+Gx18FBPfjlceBbviZHrKQLSk0PAWA48Qk3EjhiCPqNptniz71ykgSP5KW9vBejIK6C06rOrhLf89LTj7hnH1o3aBmJwSBG7P2av5bm84burq0YovOTiVwvVAhQLEymE5sZhFnnKSQqVI0jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3pHZQhv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2821026f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776771880; x=1777376680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+5uZWhRor1Vy//2ATFuXmZg83EPl8Su74lVjjp+oPE=;
        b=a3pHZQhvhthjQgLDM1SwrQcvQc215usAvgtQkCOxolh/1Cc6mEMtfQ1/rflmYa/p5/
         HAniKZIPC4j5WgGQr5+EyipolkhaS3ni1BFwNEH4Jht9cYvI3PT3KbZtsqA33tlGpeND
         tqoJkXLVZ6+GeG1ziKDWo8vSKP7U0l6x9usoVRvXnN+SIVtDWjbieW//7MYXdgk9Ig5Z
         sFFYWSIsxXNIC/qZuTk+g3oHQDmFdnft7nuUK16I0h89FNJaCGAKujaCUTyEoKrBSxe3
         75GZ0rSNBXBJfASurXn/4T7aQAaZBxSAvux9ZcqRDAf6mSkvHxJEyNYX4JjYkCFZBDzl
         S1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771880; x=1777376680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+5uZWhRor1Vy//2ATFuXmZg83EPl8Su74lVjjp+oPE=;
        b=jRYFNYO1O/XnmINTvlm3guxkXfC7SEL4dpMTDydKIRVH3i5JRyAk8er5PDXKU9Vmht
         io35uaYGmaJkbMhrvmCx82kS1V/dHo7cv+olbLcROqdKPD9ZmgAWYsD9R18U116BkNC7
         x73jvCj2PeEWkaVfdHrWnLEC2rI3rIQbwW3j5zjaXLZymzvUTIhzmUZ2LVA99olWgALw
         LnKfMUn34+zMxMlcvTQsX8UNZ9Z28Lor9VbFO9i0eUhyS3lrzvg0Kjs++ZcJ3w+B9UEg
         1EEQ7fZc5bWH50JOwSf+IvBzC/B+P9M/UKEmr7OovxErw5AOW/sln/c8y3dJnz44SVss
         qa0g==
X-Forwarded-Encrypted: i=1; AFNElJ/c2fLcM8wH+hqi86qSE9HT4F4MFnhrh06+FFSkCmqDNW44cg5y0yef3mSvQiPlaglNY3NLv2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsz3W2p0i/g2H1Q2qIopf22PZLDIXWSPLRMQWAHRxvZLUIlrm
	B1alCWwbOEzGnbMNaADVJBYLxcKU7MtkTXVqgKBFHqwbr9SjTeMzZCxE
X-Gm-Gg: AeBDieu4zPIB4ETY0buDwE8zYUS6F0nJC7tVlbSP8DOqQU30ySOoMvwr8g2hH7w2F1J
	0xQa9qOfi4dAhU0tYUv2GqytiQ618E+gihETX1xMUBCvtkw3XVvWm6+rGzA0C+7/UvyOPuQFnHm
	BgzRClExYCE7pkVO8afcP7mNAgxVXP2fwLWL+hpfaT9NBzmmepanXlvDri4xfEhghhDyIYmQ2+D
	JBZiUucI+SxKNEhBZdK8gGF3yqZbsG3I564J+eG5tzKhxFDEKvmzXW2uc8GOB5d0keG3H+HQkb6
	R19Eyj385cpRa33iQbgz/4QR8Lk/KI1pccQDelay5uJeX9gAH7rCdIoXBRkFIv/58wAZL5vgitz
	dU2vXta01Gq0p5oNe3EK5/Y7UICVmqwjm3IdBr0l952gQbIIZDzSikZz8qpmXvk4+vWhv0aLYq/
	UWH78NtRkzi12x57fR2qbwFiiGgYDFCyAa+jtdyqBvY3+4RfU=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-43fe3ddcc21mr27179412f8f.21.1776771880052;
        Tue, 21 Apr 2026 04:44:40 -0700 (PDT)
Received: from [192.168.1.169] ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4ffa8sm36729294f8f.35.2026.04.21.04.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:44:39 -0700 (PDT)
Message-ID: <be429e88-f10a-4d67-a516-67648aa2ab6e@gmail.com>
Date: Tue, 21 Apr 2026 14:44:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260421073738.22110-1-zlatistiv@gmail.com>
 <aecyEArzjx8KRp8-@gmail.com> <9ce273bd-6912-4442-8672-4c89bebf32ed@gmail.com>
 <aec-UcPm5pRZjcSL@gmail.com>
Content-Language: en-US
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
In-Reply-To: <aec-UcPm5pRZjcSL@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280087-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlatistiv@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD6B143A318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/21/26 12:12 PM, Breno Leitao wrote:
> On Tue, Apr 21, 2026 at 11:54:19AM +0300, Nikola Z. Ivanov wrote:
>> On 4/21/26 11:19 AM, Breno Leitao wrote:
>>> On Tue, Apr 21, 2026 at 10:37:38AM +0300, Nikola Z. Ivanov wrote:
>>>> Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff
>>> How do you check in the report above that the missig un-initialized
>>> fields are "tos" and "id"?
>> I don't think it is visible here, my guess would
>> be because the checksum calculator walks the
>> header in small chunks instead of referencing
>> its fields.
>>
>> The whole "KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt"
>> doesn't really sound quite right.
> That's precisely my question - how does this fix relate to that specific
> report?
The fact that the 2 call traces from the allocation and usage
have a common origin in nsim_dev_trap_skb_build sort of gives it away.
Just to be clear, I saw the syzbot report and started investigating from
there, not the other way around.
> Were you able to reproduce the KMSAN report?
>
> Thanks for the quick answer,
> --breno
Yes, but it is a bit inconsistent.

Just booting the disk from the report and adding a device
is enough to trigger it, but we have to wait for some time:

syzkaller
syzkaller login: root
# echo "1 1" > /sys/bus/netdevsim/new_device
# [  726.477183][ T5462] 8021q: adding VLAN 0 to HW filter on device eth1

# [ 1845.100611][   T80] 
=====================================================
[ 1845.102363][   T80] BUG: KMSAN: uninit-value in 
irqentry_exit_to_kernel_mode_preempt+0x8f/0xa0
[ 1845.104209][   T80] irqentry_exit_to_kernel_mode_preempt+0x8f/0xa0
[ 1845.105594][   T80]  irqentry_exit+0x7c/0x7b0
[ 1845.106629][   T80]  sysvec_apic_timer_interrupt+0x52/0x90
[ 1845.107829][   T80]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 1845.108959][   T80]  srso_alias_safe_ret+0x0/0x7
[ 1845.108959][   T80]  __msan_metadata_ptr_for_load_4+0x24/0x40
[ 1845.108959][   T80]  ip_fast_csum+0x1e6/0x3f0
[ 1845.108959][   T80]  nsim_dev_trap_report_work+0x8c0/0x1430
[ 1845.108959][   T80]  process_scheduled_works+0xbdb/0x1e20
[ 1845.108959][   T80]  worker_thread+0xee5/0x1590
[ 1845.108959][   T80]  kthread+0x540/0x600
[ 1845.108959][   T80]  ret_from_fork+0x210/0x8f0
[ 1845.108959][   T80]  ret_from_fork_asm+0x1a/0x30
[ 1845.108959][   T80]
[ 1845.108959][   T80] Uninit was created at:
[ 1845.108959][   T80] __kmalloc_node_track_caller_noprof+0x4fb/0x1770
[ 1845.108959][   T80]  __alloc_skb+0x90d/0x1190
[ 1845.108959][   T80]  nsim_dev_trap_report_work+0x3f2/0x1430
[ 1845.108959][   T80]  process_scheduled_works+0xbdb/0x1e20
[ 1845.108959][   T80]  worker_thread+0xee5/0x1590
[ 1845.108959][   T80]  kthread+0x540/0x600
[ 1845.108959][   T80]  ret_from_fork+0x210/0x8f0
[ 1845.108959][   T80]  ret_from_fork_asm+0x1a/0x30
[ 1845.108959][   T80]


Thank you,
Nikola

