Return-Path: <netdev+bounces-294677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wd3gBvXgH2qxrgAAu9opvQ
	(envelope-from <netdev+bounces-294677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E5F635873
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z8HEmMBD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ikfok4Ji;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z8HEmMBD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ikfok4Ji;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294677-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294677-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A710C301A9B4
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7B408037;
	Wed,  3 Jun 2026 08:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CE3A1E92
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:06:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474010; cv=none; b=dtBHuOqryZJgKC5VeFixK52W/koK4SexYWzhFR1NZcvmDDv+oVa2fB2ZPrLby64xAMQXwsAj6CKNOU1++2Sm7/BPNemviCJiNyemF4W7lSuAHHVOMz2kvVI9mRqM+HVYdT1QerxYAvp/jc7CkK7pyK+UjpP0XqnLAY0IOI64CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474010; c=relaxed/simple;
	bh=uNLmpf/k3Ziojy6QPrnaI3HjQUJYLRWSA+Yhe4miGK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgXJd3qs8Na3h16TbS1y5qTBOvLMli0FUP7UX6jkonxIxVKkokz98Pi+5d8qhMwCH63FrDZORZ2dzEALtccomwEqu8a2aXkstYY9fxx8UX29VMaL5eWWYhqh/YXvK438zyWYi/ZJLUz+I6puMh8Q9tLorTwUKAUyUjO1bPDSbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8HEmMBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ikfok4Ji; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8HEmMBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ikfok4Ji; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B92B6A85D;
	Wed,  3 Jun 2026 08:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780474007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Z8HEmMBDA58cRYv1o67pfeOIMwKfRVZDDrZYPlVOlMxy53Y0kKa9wbR3rMLHhaqfr6sr80
	a3w7fQ1SI1bAfKw5sbws87aJPFXoWNXzjWYp8Dksw6V7hU6GYqmENJsxjkkvoFynjSW0Cy
	msR7/v0t+SollDbWh+IJDVUr+Wdrjo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780474007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Ikfok4JiZCo0053fk6f6XYUJXYzeT3QS1o1aqwQVSeAfgmpcxfs8fhTXXi+fe+GbicCf0G
	JbWsdWgdnWY1fUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780474007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Z8HEmMBDA58cRYv1o67pfeOIMwKfRVZDDrZYPlVOlMxy53Y0kKa9wbR3rMLHhaqfr6sr80
	a3w7fQ1SI1bAfKw5sbws87aJPFXoWNXzjWYp8Dksw6V7hU6GYqmENJsxjkkvoFynjSW0Cy
	msR7/v0t+SollDbWh+IJDVUr+Wdrjo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780474007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PS7RSJTXsuBLhvU6DXs2m5xgrYaSH9R03tpC93168TM=;
	b=Ikfok4JiZCo0053fk6f6XYUJXYzeT3QS1o1aqwQVSeAfgmpcxfs8fhTXXi+fe+GbicCf0G
	JbWsdWgdnWY1fUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0A13593AC;
	Wed,  3 Jun 2026 08:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hGPQN5XgH2plCAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 03 Jun 2026 08:06:45 +0000
Message-ID: <30906ad5-43b8-4192-946a-8c2533f976ff@suse.de>
Date: Wed, 3 Jun 2026 10:06:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Ido Schimmel <idosch@nvidia.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, Chris Adams <linux@cmadams.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
 <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
 <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
 <eba11df5-3ae6-4bc4-bbe7-be358a0d4717@leemhuis.info>
 <ee2b92e5-6d95-4c36-9fa8-6cd2a1572556@suse.de>
 <20260603080023.GA575206@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260603080023.GA575206@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-294677-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:regressions@leemhuis.info,m:ihuguet@redhat.com,m:matttbe@kernel.org,m:sbrivio@redhat.com,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:david@gibson.dropbear.id.au,m:bgalvani@redhat.com,m:andrew@lunn.ch,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[leemhuis.info,redhat.com,kernel.org,vger.kernel.org,gmail.com,google.com,davemloft.net,cmadams.net,gibson.dropbear.id.au,lunn.ch,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:from_mime,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0E5F635873

On 6/3/26 10:00 AM, Ido Schimmel wrote:
> On Wed, Jun 03, 2026 at 09:29:55AM +0200, Fernando Fernandez Mancera wrote:
>> We should document that the order matters, no that it is "random" because it
>> isn't.
> 
> Did you consider writing a kernel selftest for this? Unlikely that the
> order will change again when we are explicitly testing for a certain
> order.
> 

That is a good idea yes, I am adding it to my TO-DO list.

Thanks,
Fernando.

