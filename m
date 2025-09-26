Return-Path: <netdev+bounces-226628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3ABA3275
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283C41C01DC9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575D26CE1A;
	Fri, 26 Sep 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nZ1fV2E2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EfONZrTv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nZ1fV2E2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EfONZrTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325A19FA8D
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879204; cv=none; b=ZK2uUGhLjx1vRn0IeEjDr4GGMaQY2mcLuocn7dgl8n19PptPPuzM68+JfWEvwkB3YmWxNQsHGuSxK85CEpvsW/8AtASQ7ebrkg8+boLDwDH7Ii5ST2tTkj7VgeePeUIrXke4flS3T/Otwm+MotC3Shft8uPEqhSHLq/HArr1R/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879204; c=relaxed/simple;
	bh=TMTQ7Z9t7o1+Q0EfMTLRm3oubpFIbGUUFt3GS8HbWYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBgdqSsaQ6ZnYeFmuQtaemrR9HZDPrWLEn2YIks8riiybQnSbLkKXfOQ/q+FNfAUejrpVJfsItXe5hq+SkvVw3CVTK8dwcWdy1clMbS4H+M1/UdX0IGJijoUTeqCgmOHBMLSNBL4KzLZ3Pk/A4ppd6KWTdca/twd36+5S43XytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nZ1fV2E2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EfONZrTv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nZ1fV2E2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EfONZrTv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9A1926884;
	Fri, 26 Sep 2025 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758879200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRWOgU8RkNPZY+bGmbwmSuayO560FHt4po00ioHjtSQ=;
	b=nZ1fV2E2qj9VyVLq7sPJXoFfeehQ6d3iB/giQeWxBcR94O2Gp4gmLpqDHFd8pGAuZeRnnc
	mBiiIluRKm3yBFGtuxngTgquOw6rj9iarFDE+FKg3xd4EV/zMD53/HVD6569TQP706wwbR
	7Dfv5kGQR8CdnO+tTaaeA/Bsm6LQIhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758879200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRWOgU8RkNPZY+bGmbwmSuayO560FHt4po00ioHjtSQ=;
	b=EfONZrTvWNlItVlkSsbvIZbDnAdGmxyDFwUFLbXbI0MZywZ4WyIFGfGaabd+owUvtuCCSF
	ISFdGWsCmsjJTIDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nZ1fV2E2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EfONZrTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758879200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRWOgU8RkNPZY+bGmbwmSuayO560FHt4po00ioHjtSQ=;
	b=nZ1fV2E2qj9VyVLq7sPJXoFfeehQ6d3iB/giQeWxBcR94O2Gp4gmLpqDHFd8pGAuZeRnnc
	mBiiIluRKm3yBFGtuxngTgquOw6rj9iarFDE+FKg3xd4EV/zMD53/HVD6569TQP706wwbR
	7Dfv5kGQR8CdnO+tTaaeA/Bsm6LQIhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758879200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRWOgU8RkNPZY+bGmbwmSuayO560FHt4po00ioHjtSQ=;
	b=EfONZrTvWNlItVlkSsbvIZbDnAdGmxyDFwUFLbXbI0MZywZ4WyIFGfGaabd+owUvtuCCSF
	ISFdGWsCmsjJTIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 417701373E;
	Fri, 26 Sep 2025 09:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRjKDOBd1mjYCwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 26 Sep 2025 09:33:20 +0000
Message-ID: <9289aa3e-86d3-4300-8213-4edb112943f2@suse.de>
Date: Fri, 26 Sep 2025 11:33:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?SsOhbiBWw6FjbGF2?= <jvaclav@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250922093743.1347351-3-jvaclav@redhat.com>
 <20250923170604.6c629d90@kernel.org>
 <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
 <20250924164041.3f938cab@kernel.org>
 <c39e6626-02db-4a83-9f77-3d661f63ac0e@suse.de>
 <20250925190012.58e1b3b1@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20250925190012.58e1b3b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A9A1926884
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51



On 9/26/25 4:00 AM, Jakub Kicinski wrote:
> On Thu, 25 Sep 2025 10:37:38 +0200 Fernando Fernandez Mancera wrote:
>>> I'm not very familiar with HSR or PRP. But The PRP_V1 which has value
>>> of 3 looks like a kernel-internal hack. Or does the protocol actually
>>> specify value 3 to mean PRP?
>>>
>>> I don't think there's anything particularly wrong with the code.
>>> The version is for HSR because PRP only has one version, there's no
>>> ambiguity.
>>>
>>> But again, I'm just glancing at the code I could be wrong..
>>>    
>>
>> No you are right, this is a hack made to integrate PRP with HSR driver.
>> PRP does not have a version other than PRP_V1 therefore it does not make
>> much sense to configure it. Having said that, I think it's weird to
>> report HSR_VERSION 3 but fail when configuring it.
>>
>> IMHO HSR_VERSION should be hidden for PRP or it should be possible to
>> configure it to "3" (which now that you say it, it looks weird).
> 
> I think we're in agreement then? i was suggesting:
> 
> --- a/net/hsr/hsr_netlink.c
> +++ b/net/hsr/hsr_netlink.c
> @@ -166,6 +166,8 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   		goto nla_put_failure;
>   	if (hsr->prot_version == PRP_V1)
>   		proto = HSR_PROTOCOL_PRP;
> +	else if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
> +		goto nla_put_failure;
>   	if (nla_put_u8(skb, IFLA_HSR_PROTOCOL, proto))
>   		goto nla_put_failure;
> 
> This will not report the HSR version if prot is PRP

Looks good to me. Jan could you send a v3? Thanks!

