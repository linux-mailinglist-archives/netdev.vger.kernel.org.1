Return-Path: <netdev+bounces-287881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ar8IfSZBWqJYwIAu9opvQ
	(envelope-from <netdev+bounces-287881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:46:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06653FF7E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DD53074CD9
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165783A8735;
	Thu, 14 May 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ExRn6EgI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+dTUbWm/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TjDqPVEN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KK3iACzX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93939A046
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751745; cv=none; b=kbDqGtkijKP6wAYTxZDVwxJ1Lbw0WcPeul3ah6aInoWJeMqKMymrZhlEJUek2lq3Y0NPsz17yRQq5Epfp4YL+8T0KsnzCC6qzLlaYaLp8OMU5yvsNS31fv6X1f1wdZqeSmCbaYz4EPwuM2/re9fiAJaA3adMXX7Oh1vQFklODDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751745; c=relaxed/simple;
	bh=FNeIr7biuLX4Gtz7844rYXeEcYYjnAnIOdIvSk0oHP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st8M9VXHuLsAQX4KsluGoRSzy1tahpdKbrWSy2X1yIjklzvjsBuvz7qS8Dca3zqSjqLx3xZLJw32BVwZ47yM93IBMDz/JRvTetQHE+dSRPcBnTrTbmm8KgvsEZuXiPn5xDKAZNorOh8Jy6PvLnqDxR1O4ZVVxQ96LcRPhS+OzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ExRn6EgI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+dTUbWm/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TjDqPVEN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KK3iACzX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCD6A66EEA;
	Thu, 14 May 2026 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778751742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivEGuKjzKlrg+0xmmfYP4OWuyXFW2VC/+5VWuA2Yewg=;
	b=ExRn6EgIWK4Ca0TZ4WyDqGYOcTkbxGH/QXV4Wja4Y4LeaMOsTjyiYNBu4Gpm5qHXqnqT5/
	NauL/LGEjiYknxa0/Xjwujb4cRDNDFQixqpCTxLqoPPL01sOpkA+zXqT9XmUJS6xHrCXz1
	Ty4otakDax0FJVyLz4Zbx4+/M6NpLF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778751742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivEGuKjzKlrg+0xmmfYP4OWuyXFW2VC/+5VWuA2Yewg=;
	b=+dTUbWm/Vjui7tVPUcLJ1jIerVK/EelhUqlP3WltoFVBA/aGaV3EVGVcF3DN2zf6hhDfQy
	txZhl0T9S5cYFTBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TjDqPVEN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KK3iACzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778751741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivEGuKjzKlrg+0xmmfYP4OWuyXFW2VC/+5VWuA2Yewg=;
	b=TjDqPVENI6Cg2X9UFLGyvkQyGGdePxsyGtJXkOb2pvTtZvI0TB9st0zF8t4BzrtdNAhifw
	V4ozxWRz5GVY0WWY5zUNT6EhA+J+yIppU30zD5cBJOyfNb+RShntdJocK/NJeCsW2F3dDt
	v1/oJ3f5SXTcQDbdRkuGS8EXVk4p5Mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778751741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivEGuKjzKlrg+0xmmfYP4OWuyXFW2VC/+5VWuA2Yewg=;
	b=KK3iACzXZJRpQniHvfO0Df3Gc0xrPojcOx5xLhYg2y/2M43wdeMcWPzjBFJDnaAz8fJHDj
	NB0bkhErGpHJnNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F4C2593A9;
	Thu, 14 May 2026 09:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Vt0FP2YBWrWEgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 14 May 2026 09:42:21 +0000
Message-ID: <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
Date: Thu, 14 May 2026 11:42:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260513193544.47970cb8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 1A06653FF7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287881-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/14/26 4:35 AM, Jakub Kicinski wrote:
> On Sun, 10 May 2026 10:15:28 +0200 Fernando Fernandez Mancera wrote:
>> Introduce a new test, `ipv4_devconf_notify`, to verify that the kernel
>> sends the appropriate netlink notifications when IPv4 devconf parameters
>> are modified.
>>
>> Since YNL currently has a bug where it declares an array of u32 values
>> instead of the nested attributes expected by the kernel for devconf set
>> operations, a temporary hack (`patched_add_attr`) is included to
>> pack the netlink attributes correctly.
> 
> Right, YNL doesn't really support the level or weirdness that netconf
> requires. Why use YNL? Can't we test this with iproute2?
> 

No, AFAIU, iproute2 does not expose devconf settings. The main user of 
IFLA_INET_CONF are netlink libraries and other userspace tools that 
heavily rely on netlink operations like NetworkManager, nmstate, nispor, 
rust-netlink..

FWIW, I plan to fix the YNL side of things so we have this fixed 
properly. But I would prefer if this isn't blocked. Another patchset 
introducing IFLA_INET6_CONF support is also coming.. being able to avoid 
sysctl usage is quite useful for these userspace tools.

> nit: sashiko found a typo in "notificiation"

Should I repost for this?

Thanks for the feedback Jakub, I know everyone is quite busy recently. 
So I really appreciate you took the time to look at it.

Thanks,
Fernando.

