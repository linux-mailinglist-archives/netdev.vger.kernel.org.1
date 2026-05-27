Return-Path: <netdev+bounces-292453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGJbBUhfF2qpCggAu9opvQ
	(envelope-from <netdev+bounces-292453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D265EA5FF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7323D305159F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A9B36A352;
	Wed, 27 May 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="te4SlSdi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zM1LMPgf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="te4SlSdi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zM1LMPgf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4238F934
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916613; cv=none; b=V0oSBAHsdnFA04rgHVmE0NfNB5+V/5e7AYmeTNQHKPQyDsHdyN0iId+xHzHDaLXwSA5KKxiGebJrLXe//G/bPR/3nP+Ewr3ngwTu2hHlvDFQxACyiVl19Fbs6RkwOOhWI71AcLsDSoDflZpvk70XoCjpSMHFmB/0Il2GQ0H1ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916613; c=relaxed/simple;
	bh=FgcGQzUljI6PMuWIf0/xXl+mHd0CK9k/wfb314EsfF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J6NOJ3fD965OgwK6jKBW8jbnzlm5ZoPW9p9SMni6dti9dEJR8ZqgzW5BK6WfIMY9ofTwQjLg95XKH3dUPPqUSftqYGJoSOSP7t0AqaugOTeNVyXzbi1NDJmEsiDMoXDq7usoDvgkOq/F+5WbDkEjPeZDFSq7OEyTnSm+SREEZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=te4SlSdi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zM1LMPgf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=te4SlSdi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zM1LMPgf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F66C671B2;
	Wed, 27 May 2026 21:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779916610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE7jC34aSkLj7DxX02O1EQ7RQOEsLWGdIl4vTmhQ7yw=;
	b=te4SlSdiOEiL7L9T8HkKRuRbZ/eimlVojEelgirOEmtyNxmOvM87a090uoWP+OjhFSyMyj
	v/CBaIgKpM48Jj5O3/mLRNsbl0cSqOkflnlHu+ToCWPniw9JL4uzDpX4hiKhZErkVbvKye
	KoVTM7VIIz5kaZdjS1Gbb7BHgOIuJD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779916610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE7jC34aSkLj7DxX02O1EQ7RQOEsLWGdIl4vTmhQ7yw=;
	b=zM1LMPgflN4c926ujbRdxvIro5aM9aBwboBtFtGHs1GmJ0gloHFpDZz6GPGemzU+nbWsjq
	aSJSS4napV7eNvAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779916610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE7jC34aSkLj7DxX02O1EQ7RQOEsLWGdIl4vTmhQ7yw=;
	b=te4SlSdiOEiL7L9T8HkKRuRbZ/eimlVojEelgirOEmtyNxmOvM87a090uoWP+OjhFSyMyj
	v/CBaIgKpM48Jj5O3/mLRNsbl0cSqOkflnlHu+ToCWPniw9JL4uzDpX4hiKhZErkVbvKye
	KoVTM7VIIz5kaZdjS1Gbb7BHgOIuJD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779916610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE7jC34aSkLj7DxX02O1EQ7RQOEsLWGdIl4vTmhQ7yw=;
	b=zM1LMPgflN4c926ujbRdxvIro5aM9aBwboBtFtGHs1GmJ0gloHFpDZz6GPGemzU+nbWsjq
	aSJSS4napV7eNvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F29405AA1B;
	Wed, 27 May 2026 21:16:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r9CCOEFfF2rQeAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 27 May 2026 21:16:49 +0000
Message-ID: <17bea936-9f17-4ae2-b989-59aee826981b@suse.de>
Date: Wed, 27 May 2026 23:16:39 +0200
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
 <20260526183122.348e44e7@kernel.org> <20260527211356.GA16443@cmadams.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260527211356.GA16443@cmadams.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292453-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 81D265EA5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 11:13 PM, Chris Adams wrote:
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
> So... I'm not very git-fluent and haven't submitted a kernel patch in
> many years, so really am not sure of the necessary/proper steps.

I don't mind to handle it. I will CC you, is that fine for you?

Thanks for the report btw!

