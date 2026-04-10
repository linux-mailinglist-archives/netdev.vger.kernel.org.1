Return-Path: <netdev+bounces-277467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOsuJS0e2WnVmQgAu9opvQ
	(envelope-from <netdev+bounces-277467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:58:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E533D9F01
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A28C302E4EF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF003D333C;
	Fri, 10 Apr 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eastlink.ca header.i=@eastlink.ca header.b="v25u0Dct"
X-Original-To: netdev@vger.kernel.org
Received: from mta02.eastlink.ca (mta02.eastlink.ca [24.224.136.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FD35DD1C
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.224.136.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835874; cv=none; b=MMqClH2bcLSjQC7WYyzLUS+qY9/+50LBvi34jg5JovBPXD21wqMR6ZBzGUSLjyww3md7Jsi9S11G7kQv98o3ShdRhYtbuvFCOp6SVSnKZoAkKjuQIjTUU/lP2rqiLrBYUSG89yURpbWdln9nh4mgKyertMk8yVQi6hd0wWTOheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835874; c=relaxed/simple;
	bh=ys2qIIDim0m/Ax57bmDxe1wwI+RnRcMDUobY+/LAZUI=;
	h=Message-id:Date:MIME-version:Subject:To:Cc:References:From:
	 In-reply-to:Content-type; b=ejYjcpIplJbVAzYk7zrGX0Lxws0ZjDtYIZzKjSo/fMVtkV6zTmoh1uP223apMOd5Ep/GUXQ/FyleWUdaIJ9s5qka7WBKARNk8KF9fz4mWk2qzif7F3bbuOGnBmD4Wz9prvu5pUdihinzKsq+A2qBLIn240Ci9RNUCL/xvjLX1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eastlink.ca; spf=pass smtp.mailfrom=eastlink.ca; dkim=pass (2048-bit key) header.d=eastlink.ca header.i=@eastlink.ca header.b=v25u0Dct; arc=none smtp.client-ip=24.224.136.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eastlink.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eastlink.ca
Received: from mail-cms03.eastlink.ca ([71.7.199.167])
 by mta02.eastlink.ca ([24.224.136.13])
 with ESMTPS id <0TDA0EJL7A8HEAE0@mta02.eastlink.ca> for
 netdev@vger.kernel.org; Fri, 10 Apr 2026 12:12:17 -0300 (ADT)
Sun-Java-System-SMTP-Warning: Lines longer than SMTP allows found and wrapped.
Received: from [192.168.1.239] ([24.222.238.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate) by mail-cms03.eastlink.ca
 ([71.7.199.167]) with ESMTPSA id BDWpw66Glkg7aBDWpwNj31; Fri,
 10 Apr 2026 12:12:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eastlink.ca;
	s=elelff16; t=1775833936;	bh=I61OpNNSxa7QfezN65BTggmQKaC1Ej3sLTFHrfX+cUw=;
	h=Date:Subject:To:From:From:To:Subject:Date:Sender:Reply-to;
	b=v25u0DctURMmtCg5wwJ3G0L8bhfCZeIkhepPK6zNTOhef52hNMloTvu+sy+C8Z2rO
 RzmaDBR59RcpSde58d4nxxt0r3BJHkH40ZK5rQPZDcpUD6pITkEZ1YLkuEYx5w9GUf
 eM59M/EgIh0+cZk5oO5Tn4c0L54Y7A39NRpHEbSeQhVGr+bYEf4fjHwPxlE0j5e48L
 mxuYdRpLfpMdmbWTwmK5m9LN8jga/4/NBaq5jVh4qJbIrdvZHcXoKljt+blRJR0JFA
 rbbmdp585VXLEMekdNO5ddDvUSoaSYESA76wwM1pTgF8NIao+0aVOoRQXwz4GOFm/0
 qZMby6wU97w4Q==
X-Authority-Analysis: v=2.4 cv=e6xUSrp/ c=1 sm=1 tr=0 ts=69d91350 cx=c_est
 a=ien09DawV0SQ461Yvz+7bQ==:117 a=ien09DawV0SQ461Yvz+7bQ==:17 a=IkcTkHD0fZMA:10
 a=21JHI6EMHx3ttOpXyVYA:9 a=QEXdDO2ut3YA:10
X-Vade-Cause:
 gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfgtefuvffnkffpmfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpehjjhcuoehvvgdujhhothesvggrshhtlhhinhhkrdgtrgeqnecuggftrfgrthhtvghrnhepheduffejhfehkedvfeeikeegvefhjefgffdvffdtudekteehiefggefhieeuvdeinecukfhppedvgedrvddvvddrvdefkedrgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdegrddvvddvrddvfeekrdegkedphhgvlhhopegludelvddrudeikedruddrvdeflegnpdhmrghilhhfrhhomhepvhgvudhjohhtsegvrghsthhlihhnkhdrtggrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopeerredprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtp
 hhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-Vade-Score: -100
X-Vade-State: 0
X-EL-AUTH: ve1jot@eastlink.ca
Message-id: <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
Date: Fri, 10 Apr 2026 12:12:16 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
 stable <stable@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
 <20260409190328.GS469338@kernel.org> <20260409203235.6b9329f0@kernel.org>
 <2026041026-excuse-slashing-c4ee@gregkh> <20260410102827.GT469338@kernel.org>
Content-language: en-US
From: jj <ve1jot@eastlink.ca>
In-reply-to: <20260410102827.GT469338@kernel.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[eastlink.ca,none];
	R_DKIM_ALLOW(-0.20)[eastlink.ca:s=elelff16];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[eastlink.ca:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ve1jot@eastlink.ca,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eastlink.ca:dkim,eastlink.ca:mid]
X-Rspamd-Queue-Id: 65E533D9F01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is NOT an obsolete protocol..this is in use by amateur radio 
operators world-wide...we use it for RF comms usually, because what 
happens if the internet goes "down", we can still provide comms over 
slower RF links....(plus it's a fun mode)please PLEASE do not drop...and 
sorry for the noise...

de John VE1JOT

On 2026-04-10 07:28, Simon Horman wrote:
> On Fri, Apr 10, 2026 at 07:24:36AM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
>>> On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
>>>> I expect that checking skb->len isn't sufficient here
>>>> and pskb_may_pull needs to be used to ensure that
>>>> the data is also available in the linear section of the skb.
>>> Or for simplicity we could also be testing against skb_headlen()
>>> since we don't expect any legit non-linear frames here? Dunno.
> Sure, that's find by me if it leads to simpler code than
> using pskb_may_pull(). Else I'd lean towards pskb_may_pull()
> as it is a more general approach that feels worth proliferating.
>
>> I'll be glad to change this either way, your call.  Given that this is
>> an obsolete protocol that seems to only be a target for drive-by fuzzers
>> to attack, whatever the simplest thing to do to quiet them up I'll be
>> glad to implement.
>>
>> Or can we just delete this stuff entirely?  :)
> Deleting sounds good to me.
> But we likely need a deprecation process.
> In which case fixing these bugs still makes sense for the short term.
>

