Return-Path: <netdev+bounces-271332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLyXFhQXw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E696931D8DD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A2C305FDAD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2573C7DEC;
	Tue, 24 Mar 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DuKC49Ix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="28SHVRXe"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65FD3C73F6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393099; cv=none; b=ISdPOmgOf++wyT/uezkHh23dcpRz00/l0tkokO6IHMjrYI4P/dTSfRiGLofWHpfvp70P3u4bWqC1bSqj5BVOQD3OqDcTbIfD2BxGMA347QpheKtQOhnpbOV/lsSHzlMBXOAVhBEaLMlL+3j9h1ugCsN3QSTn4dhAwnoq6pxO4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393099; c=relaxed/simple;
	bh=A5pbLTNu1th7ZGwjBecBuxi24geLCz4/pSCvawYIxUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXRVtbzh17Bq2U1AngpCWbIWBvQrw3Er7Ybpcr7pGbRNnSlKSte+GfHU0e3or2wZIr/jMqe20yEEdTC/TartAuvNUBRIwPKQafkWSvJ5ZO0VXBE7HJOKhr3Z2SF0G3o4hNj02jQzX4jIHR7lthtCUVSeGM6n+wysq1PF+Y36zXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DuKC49Ix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=28SHVRXe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E2F3EC00F8;
	Tue, 24 Mar 2026 18:58:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 24 Mar 2026 18:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774393096; x=
	1774479496; bh=fhx7Xvc2fx6ggVMbgxLAfyHtquy0LbzAcTimeH8BbXU=; b=D
	uKC49IxHw9ocM2XBTiy/3dvHqYj46Q2yNBvnjzwbxH02fUl2eeO896LCCsyoB5bd
	6JqaMgDMzBGAonERkW7BiRNK27PR+/sPFGK/rDB8OyduWagdCVNCUwdjAaFaaYAm
	dqzbviL+Onlr3IdeB+DKg19SCtXL0LT//IC/6SaY1PVklMqxTwu9XwFa5/0MgF2I
	QspPNzoAwbnqnAgb+9GJLb3gP6lSjR8G0vQwWIF7/IPKhwqv04OASg38foPFUorF
	AvbHi1mfaB24jhMMT83dFjYkOJOmQ4B2cgp7MQFJkz05KySTCaILyYvtIZU+CB0w
	x2jJcIMB9Yjfn/uOCb6lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774393096; x=1774479496; bh=fhx7Xvc2fx6ggVMbgxLAfyHtquy0LbzAcTi
	meH8BbXU=; b=28SHVRXeXNhyGNCbEU0q4XGNQiN7a/JAa79YltvZ8DK8mlWI0JK
	WCAKXiF0JPymQT3z8V3AoYnMN1uOOLptOP3YJC/MzLJ98iVAOqsfPKfyVzDwm6Pw
	tyXql9Uz/En5ewVKmZVHk4D5jebyyj5LRBeQUeHzlFlqV1eJW5vBXLG1t/Fh4QoD
	FTYeNVonBUSXQiF7AP/hTTtOEoFGAciaDt7JRE8/hBria20QB/LR5D2C2A75HaH9
	MZX/7k/7Kc3fPghYGC9qbwc8ydbL6e9iCZCQHSo8zmYVA6sTGE7NQnWB+4q/QFKx
	LhcW8DVQxt2KJuYMg9pp5m9ZZQh506EGEYQ==
X-ME-Sender: <xms:BxfDaZIyI1P3Fhq1W0FpoF53Juq8xlykQb884-_n4gyZg6wHxot5eg>
    <xme:BxfDaV0is85bfcTGt3j5c_h3wUh3hvI7DBbXFjGsMusOCgP6QlbD-x5TnIFFR98X0
    ZDoAiQjwDOK4VUPaqGz87cn_8gP6VhoYrpP22WHXdhxg8iuHWg5Mdk>
X-ME-Received: <xmr:BxfDaf4Dlo60sq-KwBAPt-Lcs8exbsAHC5ZtY2g28Ahinb8VLLQjeMZdDJ5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughs
    hhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlh
    gvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggv
X-ME-Proxy: <xmx:BxfDae9G68HJvgNj31LFo9H0l3p6Wkdl0mIhwpi0BW3OyEWiGlJu5w>
    <xmx:BxfDaWVJFg3qwMS8idVBj_mR-wRCgyoBgQK2le3mGcVv4XB84HoYdA>
    <xmx:BxfDaRr58mWO_QyNZ_IAda670ld4HO_sNwAH358NLij-HW6J2GJFUg>
    <xmx:BxfDaQkqxndXu41cQ8Ofr9XvMDvODdYJ-HlHxxJGCFGo7Am-dnQEig>
    <xmx:CBfDaeiNse5IHg_EWzT7rtlz0SibHx39y0gIQb8P9nF9fZhTz5L6PirY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 18:58:15 -0400 (EDT)
Date: Tue, 24 Mar 2026 23:58:13 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH PATCH net-next v4 8/8] tls: Enable batch async decryption
 in read_sock
Message-ID: <acMXBSfCznV58emu@krikkit>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
 <20260317-tls-read-sock-v4-8-ab1086ec600f@oracle.com>
 <acFK4DWAD5h_Oc0f@krikkit>
 <5190a4bf-cc66-424e-9c67-ffb3ddb58030@app.fastmail.com>
 <acHH6NVykWZo5Q3Q@krikkit>
 <b48d4311-51f2-4e71-8324-303af224bac6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b48d4311-51f2-4e71-8324-303af224bac6@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E696931D8DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-24, 09:17:57 -0400, Chuck Lever wrote:
> On 3/23/26 7:08 PM, Sabrina Dubroca wrote:
> > 2026-03-23, 11:04:16 -0400, Chuck Lever wrote:
> >>
> >> On Mon, Mar 23, 2026, at 10:14 AM, Sabrina Dubroca wrote:
> >>> 2026-03-17, 11:04:21 -0400, Chuck Lever wrote:
> >>>> +/* Bound on concurrent async AEAD submissions per read_sock
> >>>> + * call.  Chosen to fill typical hardware crypto pipelines
> >>>> + * without excessive memory consumption (each in-flight record
> >>>> + * holds one cleartext skb plus its AEAD request context).
> >>>> + */
> >>>> +#define TLS_READ_SOCK_BATCH	16
> >>>
> >>> I suspect that at some point, we'll have a request to make this
> >>> configurable (maybe system-wide, maybe by socket?).
> >>
> >> I appreciate your careful and close review. The series has
> >> improved significantly.
> >>
> >> I will admit that the current value (16) is arbitrary. I agree
> >> that someone might want to modify this value. At this point,
> >> however, the constant is straightforward and it is still quite
> >> easy to promote to a tunable later if that proves to be needed.
> > 
> > Agreed.
> > 
> >> The right interface for this depends on kTLS consumer needs
> >> that aren't clear (to me) yet.
> > 
> > In this case (read_sock), the kTLS consumer is NVMe/TCP etc, and
> > specifically users of those features with crypto acceleration
> > cards. I'm not familiar with either.
> > 
> >> But let me know if you have a
> >> preferred API mechanism or a specific use case in mind, or if
> >> there is a netdev policy that should guide the introduction
> >> of a suitable API for this purpose.
> > 
> > Nothing specific, I just thought I'd mention it since I was replying
> > to the patch anyway. I think at this stage "it seems easy to promote
> > to a tunable later" is enough consideration (just to avoid getting
> > trapped in some API (or lack thereof) and unable to change it, but I
> > agree that it shouldn't be a problem here).
> 
> I looked into this a little more yesterday before noticing that
> async crypto was disabled for TLS 1.3.
> 
> The hardware crypto engines do not surface a concurrency limit to
> their consumers, but their ring sizes are typically much larger than
> the batch limit of 16 I've chosen here. We can't rely on them to
> tell kTLS where to set that limit.
> 
> However, the loop was structured to continue until the batch limit
> was hit or reading gets -EBUSY. Either way 16 seems to be a safe
> but fairly conservative setting. For the larger rings it might cause
> a decrypt pipeline bubble.
> 
> So the true purpose of the low limit is to constrain the amount of
> memory tls_read_sock sets aside for decryption in progress. That's
> going to be about 256KB per socket. Yes, that could be made larger
> or contingent upon TCP socket buffer sizes, for example.

If you end up resending those changes in the future (after/together
with async support for 1.3), it would be nice to record some of this
in the commit message, to justify the limit you've chosen.


About async for 1.3: I think it would be quite some work to implement,
since we don't know the record type until after we decrypt the record.
If we get a rekey, we'll have already submitted a bunch of other
records that will fail decryption, so we'll need to roll back and
resubmit everything after the rekey, once userspace gave us the new
key. I'm not sure if other non-DATA records would also be that
problematic (or maybe worse?)

Also, async for 1.2 has been a pain (see the many fixes in the past
years). 1.3 looks complex.
I don't have access to HW that would benefit from it, do you
have benchmarks on with-async vs without-async? (obviously for
non-NVMe/non-NFS use-cases, if you test that at all)

-- 
Sabrina

