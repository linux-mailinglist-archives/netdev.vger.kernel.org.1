Return-Path: <netdev+bounces-82844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343488FECE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD432860DC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5817EF02;
	Thu, 28 Mar 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="01mX6vpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jdidoxvs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="01mX6vpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jdidoxvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642646168C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628292; cv=none; b=Q0vkoPpaAQPMO53LW5Hi7pTBnWyRvFFy9mRvNUpJBqpnV3I4jnTK8JK6A0Tz6EKkIKuVmgBDyAqOOWRe8kdtz2ciqu4GuFIshxcwFWuE3MHIc7+r5efQD6wW8pwjVwYEB791ZId7rMeesZikNg251VsONsgaE+ySY98VISQQwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628292; c=relaxed/simple;
	bh=KTjnvdfvriFJlGlllMkuPARbT+Ts9KxcZDjTrHSHbtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXQxD9R2lJYLeAg+L6Tag9qkrhiOz0nZAhZSuKsfEQFhTZtLKNRw1KPf4S5YA3cM4uSEIrz3tP/LkIAzoAXQlC7KahhOV0YwvrF9EGY3/zjiaR/P70/7kpSQqzzrlvtj/A30kOgF7bObPB3MC4nEAfZWMM23wi6+N6WT4CuQYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=01mX6vpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jdidoxvs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=01mX6vpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jdidoxvs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2A020892;
	Thu, 28 Mar 2024 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711628287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsSgyeWlr3WSZ5m1tQV2gWQcJAt/HC1Tm4naNUY6qww=;
	b=01mX6vpgoY8IPgxKBIA56gDescc69fIRDx3GwxVjj3/SulfT9vez7kDJ7q2HJv6kZPtUlx
	mbCb8edQ1whNj8I18n1vs5exaSTU6i1gRXvebAc1fczPaNJLCd1BIdAOINcUKpn+DFFaCT
	/vFCGvvaXRGFd097y4PofnJ70KSUanM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711628287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsSgyeWlr3WSZ5m1tQV2gWQcJAt/HC1Tm4naNUY6qww=;
	b=JdidoxvsSDBVryMacC4QBnMXIC9xDeepzYr/+RcS93Te0hjg4/LLkJvmTLtojgMyA3Cvwh
	pDGxfbE/5ucpq/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711628287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsSgyeWlr3WSZ5m1tQV2gWQcJAt/HC1Tm4naNUY6qww=;
	b=01mX6vpgoY8IPgxKBIA56gDescc69fIRDx3GwxVjj3/SulfT9vez7kDJ7q2HJv6kZPtUlx
	mbCb8edQ1whNj8I18n1vs5exaSTU6i1gRXvebAc1fczPaNJLCd1BIdAOINcUKpn+DFFaCT
	/vFCGvvaXRGFd097y4PofnJ70KSUanM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711628287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsSgyeWlr3WSZ5m1tQV2gWQcJAt/HC1Tm4naNUY6qww=;
	b=JdidoxvsSDBVryMacC4QBnMXIC9xDeepzYr/+RcS93Te0hjg4/LLkJvmTLtojgMyA3Cvwh
	pDGxfbE/5ucpq/DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2E8D13AF7;
	Thu, 28 Mar 2024 12:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3eSNN/5fBWbsJwAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Thu, 28 Mar 2024 12:18:06 +0000
Message-ID: <ba103154-ff05-47e1-98be-5204c26f345f@suse.de>
Date: Thu, 28 Mar 2024 15:18:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
To: Eric Dumazet <edumazet@google.com>, Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
 syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20240328113233.21388-1-dkirjanov@suse.de>
 <CANn89iJ51cc+FrOxst_AJOr38byPFPOSkP7f721V38ZR019oDA@mail.gmail.com>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <CANn89iJ51cc+FrOxst_AJOr38byPFPOSkP7f721V38ZR019oDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.83
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.83 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[google.com,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-1.83)[93.97%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[5fe14f2ff4ccbace9a26];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=01mX6vpg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jdidoxvs
X-Rspamd-Queue-Id: 6F2A020892



On 3/28/24 14:51, Eric Dumazet wrote:
> On Thu, Mar 28, 2024 at 12:32 PM Denis Kirjanov <kirjanov@gmail.com> wrote:
>>
>> A call to ib_device_get_netdev from ib_get_eth_speed
>> may lead to a race condition while accessing a netdevice
>> instance since we don't hold the rtnl lock while checking
>> the registration state:
>>         if (res && res->reg_state != NETREG_REGISTERED) {
>>
>> v2: unlock rtnl on error patch
>>
> 
> What about other callers of ib_device_get_netdev() ?

I'll add ASSERT_RTNL() to ib_device_get_netdev and update the remaining callers.

Thanks!

> 
> It seems they also could be racy.
> 
>> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
>> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
>>  drivers/infiniband/core/verbs.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>> index 94a7f3b0c71c..9c09d8c328b4 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>         if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>>                 return -EINVAL;
>>
>> +       rtnl_lock();
>>         netdev = ib_device_get_netdev(dev, port_num);
>> -       if (!netdev)
>> +       if (!netdev) {
>> +               rtnl_unlock()
>>                 return -ENODEV;
>> +       }
>>
>> -       rtnl_lock();
>>         rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>>         rtnl_unlock();
>>
>> --
>> 2.30.2
>>

