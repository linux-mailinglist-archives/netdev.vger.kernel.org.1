Return-Path: <netdev+bounces-230250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433CBE5C6A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27C34E3AEE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE4A28BA81;
	Thu, 16 Oct 2025 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vt6INOQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASe/JBjf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vt6INOQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASe/JBjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB071CEAD6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656674; cv=none; b=sIdLa5ZM5jmrnc+3kg8IRdGkSXd33A3Veb/qeWuPd/QsEmQC59kN5TOMUoHh5VbyhYSQYfDVdiB4zhEadZOqojGw0sjVgdrVzlg67P4u2rUWaRUVQTrhX8oxTp4aLoUNAUS73jhHTkkhZaytk6zZE/h5LAlHUS1bbrMYbgwTcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656674; c=relaxed/simple;
	bh=EZI3njGxXbbPAbO1uI7EtI/kJ8bnuhlOofcSXo4Lzj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnTgW19n4voFhgqBuE8fSN+Z/SyVXCy6WGJnBIRCKKHuCwser9gSm3TexnmY1V1qEQZ1rbNm267U+3PG0b36CvQ7+7x2XhxMONohNACOHUkjRYFwwGncufOa6LEY/ikQCLuJqdRxySayXE0Ox4+Vdm2TuJgW4kS7fd+bgJkHFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vt6INOQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASe/JBjf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vt6INOQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASe/JBjf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94B0B21B4F;
	Thu, 16 Oct 2025 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760656669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y8ecXVBKjnutAqaCSzRp5pFnNF0vqCxP+J0P/gIIuQ=;
	b=Vt6INOQdFLfRzTG9SGa/jH6GFg/EDZjFrNsQKz5SZrcDlCrYeRDnVaqVIOYhwAomxx/zGH
	NncGjWNIK7qNBYGTESuEjpy37v47g9Qd8SksPjQ3r0zi8k1nzMZ9L+BHFnxvCiU+ZK7nWw
	Szjr/u4xLiWzpeecpxwrMKtVAkIXl1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760656669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y8ecXVBKjnutAqaCSzRp5pFnNF0vqCxP+J0P/gIIuQ=;
	b=ASe/JBjf+ZARCofyuEsZ1WJOWL6Xa0Jr6EluSYcFvAc+fAdlHVB5rj1KFTQb4XeUAHZETe
	FPGCkx9+Xs6Ik+Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760656669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y8ecXVBKjnutAqaCSzRp5pFnNF0vqCxP+J0P/gIIuQ=;
	b=Vt6INOQdFLfRzTG9SGa/jH6GFg/EDZjFrNsQKz5SZrcDlCrYeRDnVaqVIOYhwAomxx/zGH
	NncGjWNIK7qNBYGTESuEjpy37v47g9Qd8SksPjQ3r0zi8k1nzMZ9L+BHFnxvCiU+ZK7nWw
	Szjr/u4xLiWzpeecpxwrMKtVAkIXl1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760656669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y8ecXVBKjnutAqaCSzRp5pFnNF0vqCxP+J0P/gIIuQ=;
	b=ASe/JBjf+ZARCofyuEsZ1WJOWL6Xa0Jr6EluSYcFvAc+fAdlHVB5rj1KFTQb4XeUAHZETe
	FPGCkx9+Xs6Ik+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDC6A1340C;
	Thu, 16 Oct 2025 23:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DXPUMhx98Wg4dQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Oct 2025 23:17:48 +0000
Message-ID: <44c3937c-bf63-4e5f-a821-6c9adb4faf48@suse.de>
Date: Fri, 17 Oct 2025 01:17:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs: check visibility before changing group attribute
 ownership
To: Cynthia <cynthia@kosmx.dev>, Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 rafael@kernel.org, dakr@kernel.org, christian.brauner@ubuntu.com,
 edumazet@google.com, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org
References: <20251016101456.4087-1-fmancera@suse.de>
 <2025101604-filing-plenty-ec86@gregkh>
 <01070199eda55d65-1e43d600-4eb4-4caf-98f0-4414b449cb07-000000@eu-central-1.amazonses.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <01070199eda55d65-1e43d600-4eb4-4caf-98f0-4414b449cb07-000000@eu-central-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,amazonses.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30



On 10/16/25 5:31 PM, Cynthia wrote:
> [...]
>>>    ? psi_task_switch+0x113/0x2a0
>>>    ? __pfx_rtnl_newlink+0x10/0x10
>>>    rtnetlink_rcv_msg+0x346/0x3e0
>>>    ? sched_clock+0x10/0x30
>>>    ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>>>    netlink_rcv_skb+0x59/0x110
>>>    netlink_unicast+0x285/0x3c0
>>>    ? __alloc_skb+0xdb/0x1a0
>>>    netlink_sendmsg+0x20d/0x430
>>>    ____sys_sendmsg+0x39f/0x3d0
>>>    ? import_iovec+0x2f/0x40
>>>    ___sys_sendmsg+0x99/0xe0
>>>    __sys_sendmsg+0x8a/0xf0
>>>    do_syscall_64+0x81/0x970
>>>    ? __sys_bind+0xe3/0x110
>>>    ? syscall_exit_work+0x143/0x1b0
>>>    ? do_syscall_64+0x244/0x970
>>>    ? sock_alloc_file+0x63/0xc0
>>>    ? syscall_exit_work+0x143/0x1b0
>>>    ? do_syscall_64+0x244/0x970
>>>    ? alloc_fd+0x12e/0x190
>>>    ? put_unused_fd+0x2a/0x70
>>>    ? do_sys_openat2+0xa2/0xe0
>>>    ? syscall_exit_work+0x143/0x1b0
>>>    ? do_syscall_64+0x244/0x970
>>>    ? exc_page_fault+0x7e/0x1a0
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   [...]
>>>    </TASK>
>>>
>>> Fix this by checking is_visible() before trying to touch the attribute.
>>>
>>> Fixes: 303a42769c4c ("sysfs: add sysfs_group{s}_change_owner()")
>>> Reported-by: Cynthia <cynthia@kosmx.dev>
>>> Closes: https://lore.kernel.org/netdev/01070199e22de7f8-28f711ab- 
>>> d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com/
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>> ---
>>>   fs/sysfs/group.c | 26 +++++++++++++++++++++-----
>>>   1 file changed, 21 insertions(+), 5 deletions(-)
>> Nice, thanks!  This has been tested, right?
>>
>> thanks,
>>
>> greg k-h
> 
> I did a quick test just now, it works in the VM (no warn and the 
> container is running).
> 

Same here, I tested it while doing the patch using the reproducer 
provided on the report.

Thanks,
Fernando.



