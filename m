Return-Path: <netdev+bounces-258714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NA+Gft7kGk5aQEAu9opvQ
	(envelope-from <netdev+bounces-258714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:43:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24D13C239
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 689173014C5B
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038BD22FE11;
	Sat, 14 Feb 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfhRJx+S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BUlzFpfB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pfhRJx+S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BUlzFpfB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45322E3E9
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771076598; cv=none; b=XyojGwPAotJ+tkNBmmTqQXY6uSKG2qe8HTMXxl2EAd50DJoIbYjMR6Gjj76dxMpXrHOCQTzaFrE9W2+de5oHc0Zm+avYnWSSLaLct26etlU0tTmRZ5V50nymRImrTC7levAFE7PTGAj+Zs66e/ZhudQkqZKj+2nvvq/0srR7VVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771076598; c=relaxed/simple;
	bh=AIAz87VmMtn/+PDBDnl4dbT74DTgsNIrHCDXsrZ/f9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7wT2z/tnWZv84Mp2w5FCY5nqzorSdQbqDCyDaK7YnAayZ6D41QglX6EmsZbgeAYXawYl6CLaurelkqk5GjYZAERXlZXogZbUYlUyDHqBWj3LA8N1FkdVHOE5JFvUqhN0PTksJDKxht3zQhYdohMUcJz2n7yq4DIAgWusupvPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfhRJx+S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BUlzFpfB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pfhRJx+S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BUlzFpfB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 841CB5BCE8;
	Sat, 14 Feb 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771076595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DvLAwXSmom5NVn25+HztDqsQaMxgVXQIGQI8kPH+e4=;
	b=pfhRJx+S05fXfiV2GcnqIfrIHrL/Gms59IkZY2hu+dCVemwCauk5ru/tDSaj5+NXF7Z31r
	9eisdTMVTb2l2NM/cAU2TvGS2UKVeuZDTY41EcJ4C+0cAn5jDMFjfQ9HSkuJ7zAbrTRIZV
	IhhulIfLfbEghqzL6/Dyx0LtVYYApCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771076595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DvLAwXSmom5NVn25+HztDqsQaMxgVXQIGQI8kPH+e4=;
	b=BUlzFpfBg1LrkWKGqZIqJHTggrPZ+crtOg1VAEHKRVvLAXZwb5RMOf2bq0vcJEZXGgY1T5
	q2ERRgaiV7bOU1Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pfhRJx+S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BUlzFpfB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771076595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DvLAwXSmom5NVn25+HztDqsQaMxgVXQIGQI8kPH+e4=;
	b=pfhRJx+S05fXfiV2GcnqIfrIHrL/Gms59IkZY2hu+dCVemwCauk5ru/tDSaj5+NXF7Z31r
	9eisdTMVTb2l2NM/cAU2TvGS2UKVeuZDTY41EcJ4C+0cAn5jDMFjfQ9HSkuJ7zAbrTRIZV
	IhhulIfLfbEghqzL6/Dyx0LtVYYApCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771076595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DvLAwXSmom5NVn25+HztDqsQaMxgVXQIGQI8kPH+e4=;
	b=BUlzFpfBg1LrkWKGqZIqJHTggrPZ+crtOg1VAEHKRVvLAXZwb5RMOf2bq0vcJEZXGgY1T5
	q2ERRgaiV7bOU1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E5C3EA62;
	Sat, 14 Feb 2026 13:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mb8SOPJ7kGm7GQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 14 Feb 2026 13:43:14 +0000
Message-ID: <4398e57a-343b-431c-a5cc-0aae65676023@suse.de>
Date: Sat, 14 Feb 2026 14:43:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, Fernando Gont <fgont@si6networks.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net
References: <20260211202003.4550-1-fmancera@suse.de>
 <aY8uYmy1adhPqqbm@horms.kernel.org>
 <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
 <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de>
 <89d03f27-2e08-4619-b556-772da4c38462@suse.de>
 <CANn89i+fNkeMJbNBJjqv15Rih1tUdC8ZwGqxjMZaxovcSt=hgQ@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CANn89i+fNkeMJbNBJjqv15Rih1tUdC8ZwGqxjMZaxovcSt=hgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-258714-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: CB24D13C239
X-Rspamd-Action: no action

On 2/14/26 2:37 PM, Eric Dumazet wrote:
> On Sat, Feb 14, 2026 at 2:28 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
> 
>> I noticed the patch is marked as "Changes Requested", is there some
>> action pending from me?
> 
> Quite confusing. The blamed commit mentioned RFC 4941
> 
> commit 969c54646af0d7d94a5f0f37adbbfe024e85466e
> Author: Fernando Gont <fgont@si6networks.com>
> Date:   Fri May 1 00:51:47 2020 -0300
> 
>      ipv6: Implement draft-ietf-6man-rfc4941bis
> 
> So please add a comment like this one ?
> 
> /* TEMP_VALID_LIFETIME default value as specified in RFC 8981 3.8 */
> 

Sure, I will. FWIW, the blamed commit mentioned the draft revision for 
RFC 4941, but at that time, being a draft, it did not have an 
appropriate RFC number assigned to it.

Thanks Eric.

