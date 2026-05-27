Return-Path: <netdev+bounces-292464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLOBCVlpF2rcEAgAu9opvQ
	(envelope-from <netdev+bounces-292464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAE5EA813
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B4630475D7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43095391828;
	Wed, 27 May 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ARJ+2sFJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Ul+WZ01";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ARJ+2sFJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Ul+WZ01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09633BB12C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919191; cv=none; b=hjmQvP3csdJPLFc1dhU2lLYPzaXkOe27UxgFkpvGo8Z9MAzP8MqAu1pz6iFO4iSLdbcTQ1IrMgZW/kfzKO+CiEMWvKyQNkpT1o6Hg1M52cj+955OJ07fZyQhdQIsZZlOTL2co8lC1bYLhKMFMjF6XFogTfgdpmxJsuxfTdgzpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919191; c=relaxed/simple;
	bh=ecSmVrDhclSwm98ZZySKbvqSoWbP2dNIrp67vAUJjxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBXTeNqNIsQEKwWSyzhV4tJj2U7sZOpk63Ur2qhGkSWOXMQZUSg2bhEj3tSCEH1cOIwe1liq5Wob0wD132SKlHsJQ98N9MMpdDJoYXy7HM22GbhLaavQMsRC+fK4tOewQzyNWzH1KEqs83hzNS3+6J2D4U8lO6o3tlcGq7oarnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ARJ+2sFJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Ul+WZ01; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ARJ+2sFJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Ul+WZ01; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 035AB66D10;
	Wed, 27 May 2026 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779919188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guc3pYHlDiJY43UZaflDN8nfI6FZFePAvVAZ/9ln4YQ=;
	b=ARJ+2sFJDd4+qq+IHF06mvn4obOwLt6wvY1jcK4SBepzy1+6RCk8zKvFb58t+46CwyHWyf
	Wz2VE3QQmLmDYluyL5+BtsBP94TRLoxMxIR8r2hZ8RsSOpZMDRKHOz38xpDA531NSCuV2n
	CPxmjjndE4n5HmurYiqadQtIUoWK9+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779919188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guc3pYHlDiJY43UZaflDN8nfI6FZFePAvVAZ/9ln4YQ=;
	b=3Ul+WZ01LtyqbaJOQ9O/sIGLjupePEvKqNTPHcp5G+6sEUsI5+tFt0Wju/9FKjOR3H4E7f
	Ywi/IgTET0z5viCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ARJ+2sFJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3Ul+WZ01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779919188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guc3pYHlDiJY43UZaflDN8nfI6FZFePAvVAZ/9ln4YQ=;
	b=ARJ+2sFJDd4+qq+IHF06mvn4obOwLt6wvY1jcK4SBepzy1+6RCk8zKvFb58t+46CwyHWyf
	Wz2VE3QQmLmDYluyL5+BtsBP94TRLoxMxIR8r2hZ8RsSOpZMDRKHOz38xpDA531NSCuV2n
	CPxmjjndE4n5HmurYiqadQtIUoWK9+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779919188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guc3pYHlDiJY43UZaflDN8nfI6FZFePAvVAZ/9ln4YQ=;
	b=3Ul+WZ01LtyqbaJOQ9O/sIGLjupePEvKqNTPHcp5G+6sEUsI5+tFt0Wju/9FKjOR3H4E7f
	Ywi/IgTET0z5viCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B48235AA46;
	Wed, 27 May 2026 21:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JiUaKVNpF2q9JQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 21:59:47 +0000
Message-ID: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
Date: Wed, 27 May 2026 23:59:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org> <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org> <20260527215135.GB16443@cmadams.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260527215135.GB16443@cmadams.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292464-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 96CAE5EA813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 11:51 PM, Chris Adams wrote:
> Once upon a time, Jakub Kicinski <kuba@kernel.org> said:
>> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:
>>>> Hi! Adding more people to CC. Do you know if you upgraded from 6.18
>>>> or 6.19?
>>>
>>> It was 6.19 to 7.0.
>>>
>>>> Would you be able to try testing with some commits reverted?
>>>> On a quick look the candidates would be:
>>>>
>>>> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
>>>
>>> It's this one.
>>
>> Phew, the second one was mine :)
>>
>>> I figured out that it happens after stopping a VM (and I usually
>>> start/stop a VM for a bit in the morning, which is why it happened more
>>> than once).  So I set up a VM with a nested VM, running up-to-date
>>> Fedora 44, and then was able to bisect pretty easily, and it landed on
>>> this commit.
>>>
>>> Fedora is using NetworkManager, and IIRC NM does some part of privacy
>>> address management (right?).  NM didn't change, so maybe this commit is
>>> confusing something in NM?
>>
>> Sounds plausible, pretty sure we knew this commit was risky to begin
>> with, but we had no direct proof that it'd break real life users.
>>
>> Revert is the right course of action here. Would you be willing/able
>> to send the revert with your problem description and a Fixes tag
>> pointing to the reverted commit?
> 
> I did want to add a little more test note:
> 
> It's definitely an interaction with NetworkManager.  If I stop NM and
> run my VM start/stop test, nothing unexpected happens after.  If NM is
> running and I do my VM test, when the next router advertisement is
> received, NM replaces the privacy addresses.
> 

As someone that is experienced in NetworkManager, I can confirm it is 
related. NetworkManager is querying the IPv6 address and when the 
connection is configured with ipv6.ip6-privacy=2 (prefer-temp-addr), 
NetworkManager creates a route to make the system use the temporary 
address for outgoing connections by default.

If the order is messed up, the address picked will likely be too. One 
could argue that this is partially fault of NetworkManager and that it 
should check the timestamps or preferred times rather than order.. but 
well, the rule is "do not break userspace".

I hope this clarifies things.

Thanks,
Fernando.

