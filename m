Return-Path: <netdev+bounces-259110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEMoGUWjlGmHGAIAu9opvQ
	(envelope-from <netdev+bounces-259110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:20:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5F14E8FB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBCE301325A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58D36E46E;
	Tue, 17 Feb 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4P7YXpa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VioEJkzx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f4P7YXpa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VioEJkzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B01C2FF
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348801; cv=none; b=Wg3f6RsSlH1MBtVfDIJHl7o5rWKirWUKMIKrDZNGgcfmjOezK/58nc/xCG0oNDci005mdtn6iFCfH4/+XYxBvQIUhMU9k4SbDWBhrG1XovoiEtD+RjfS7qPDDY7YXOwVmuDAEgoADIuBZ5F3McnDuSbG4fS8KrEKz0bGE7QjgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348801; c=relaxed/simple;
	bh=oUIazI47YynMl3thW+Usc1pvXD6hr/nyYukKCjeFBao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy2WJDdAJNEJ4lMwuP+ZP4zfhhD1JYdWfYcK2skAFLr7G7iYXZPSzIh1Kl24VqW0pgZytc521MNvP+6+AXkFvj5eD0qesjyXg5M5uHx95j18BCoKcFq7jXgfh4gsUx9Ng1K5c2iVI73KZlvwq1jUkN2nPMPYbOYyuQr+Otd/rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4P7YXpa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VioEJkzx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f4P7YXpa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VioEJkzx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EF4A3E6FA;
	Tue, 17 Feb 2026 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771348798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eldfRssZqLZ1ao9AUg4P+mrkdtVWuq2laEJWBGF+mdc=;
	b=f4P7YXpawvzgcn2Umnp/E/Qwq7MC0jjmgp1WpwqpyW2BWMLv6g5KvPS+hbdEIZw9ipD1DX
	49wtxQzitB+ef/uSKMJX2+51lOsvKnVin07EZzcqTpJZwTdLQyQWa8gN48wx3RUMuWJ+Wi
	GML2Ip3I3cJVp1MEmpWy+0Jgs+z6wIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771348798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eldfRssZqLZ1ao9AUg4P+mrkdtVWuq2laEJWBGF+mdc=;
	b=VioEJkzxMjYRw+b9uwUHkJr8iCQluQvfoyH0fdc4WO68CDeqb79HB5IH/gGwj9114p/Lkf
	Z3N5AG//GL9YQnCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771348798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eldfRssZqLZ1ao9AUg4P+mrkdtVWuq2laEJWBGF+mdc=;
	b=f4P7YXpawvzgcn2Umnp/E/Qwq7MC0jjmgp1WpwqpyW2BWMLv6g5KvPS+hbdEIZw9ipD1DX
	49wtxQzitB+ef/uSKMJX2+51lOsvKnVin07EZzcqTpJZwTdLQyQWa8gN48wx3RUMuWJ+Wi
	GML2Ip3I3cJVp1MEmpWy+0Jgs+z6wIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771348798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eldfRssZqLZ1ao9AUg4P+mrkdtVWuq2laEJWBGF+mdc=;
	b=VioEJkzxMjYRw+b9uwUHkJr8iCQluQvfoyH0fdc4WO68CDeqb79HB5IH/gGwj9114p/Lkf
	Z3N5AG//GL9YQnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 900263EA65;
	Tue, 17 Feb 2026 17:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPzXHz2jlGlZEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Feb 2026 17:19:57 +0000
Message-ID: <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
Date: Tue, 17 Feb 2026 18:19:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: Gerd Rausch <gerd.rausch@oracle.com>, Eric Dumazet <edumazet@google.com>,
 syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
 <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
 <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259110-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: BCB5F14E8FB
X-Rspamd-Action: no action

On 2/17/26 6:13 PM, Gerd Rausch wrote:
> Hi,
> 
> On 2026-02-17 09:03, Fernando Fernandez Mancera wrote:
>>> rds_tcp_conn_slots_available() can also be called from 
>>> rds_conn_shutdown(),
>>> where no "rds_tcp.ko" backend specific lock is held.
>>>
>>
>>
>> AFAICS, from rds_conn_shutdown() path rds_tcp_conn_slots_available() 
>> is called with fan-out argument as false. Therefore, no need to get 
>> the peer source port.
>>
>> I think that should be fine.
>>
> 
> True, but IMHO subtle and error-prone.
> 
> If someone were to change the code to pass in "fan_out == true"
> from a context not already holding a socket lock,
> would they remember to change rds_tcp_conn_slots_available()
> to acquire that lock?
>

Usually kernel requires the developer to understand when do they need to 
acquire a lock or not. Anyway, what would you suggest? To check whether 
we have acquired the lock or not and do it conditionally?

Thanks,
Fernando.

> Thanks,
> 
>    Gerd
> 
> 


