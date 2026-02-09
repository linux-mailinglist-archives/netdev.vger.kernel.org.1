Return-Path: <netdev+bounces-257978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF19HI0oimmYHwAAu9opvQ
	(envelope-from <netdev+bounces-257978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:33:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D15661138E3
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5858F301053C
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376032E9730;
	Mon,  9 Feb 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="SXqRFLLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nmx2FdNo"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0D3BB44;
	Mon,  9 Feb 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662025; cv=none; b=hkwSHsfwI+F7/qy6xDN7OyOiqDdmWLEoe6fYNSfLcLh4If7wuZqYFlAvLutZFeUVHWPdjmfZtz2HpGr0fAVXjINxfMS24VriQ6wIhsj8/VNn3391z+QUlEVJNfJ3W1z975S4Ie6ivx5aZrk8Zjg0bd2sNxs4vvbiizSjMtpqqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662025; c=relaxed/simple;
	bh=1SKXC3SpCmN5SFkLZ3ju800LlC8ftXP1Wj0P44kmph4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ynf2IMCwAo81mV/3vMzApT3dQmFOws4oRRd6Fvckr6jP6bouYU77dTVb9PgIiLuY+StlcTNfcKiY2/O5XpLjTVLzXl1CKdGuivKn1WBz+EQ+JyKPeEc3SBrPh6hko+cFn0OHBO4XpuHyOYtwNGiIHGh3x4erElxhGWrMEGGOPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=SXqRFLLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nmx2FdNo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFF581400174;
	Mon,  9 Feb 2026 13:33:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 09 Feb 2026 13:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770662023;
	 x=1770748423; bh=5ASijHKGzYq9NnVCtWnVvP2oBLo0akaUBesdncgOr1Q=; b=
	SXqRFLLzF/CMWNVqSzPERA3XHnNpefKoHanPOLtEcMsy06N1zv4oIi8HvaYcoATX
	5ChBvPfI+0TznIF9mFwQc+5LooTQ5XdM6kledf0FWS07dSoZ4U84yIkdEKTOIIiZ
	w/v/OlHFURQf3imeNYpalY1t91tVYV051CflEWTOEoUeN5ptJfuK9VgDUBnWmcFQ
	KpBYnoELEHOa4M0jpQj5jvEUNtkU+QZSx9F8BKlValOCtrNEvI63GYKg1R6mwqnM
	lUGcLTxhX9dlrpjzqccwdArds/gZzGPAFO8EFc5sTtlhT5ZyJXjdyoFYy7LlsIUl
	fQH5yLCf1L46wxqdRYyuoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770662023; x=
	1770748423; bh=5ASijHKGzYq9NnVCtWnVvP2oBLo0akaUBesdncgOr1Q=; b=N
	mx2FdNoZF1SB30Tjnv5RZMiqczfI1eVryGo/k9qSJ7m8oU7/NFXsNf5sjgoyJc6Q
	Un6oSiiGx+Yf+hEIp+BV4NF0nZilbNON3oV2Er3eDLRJn96/Kp7i4gA06HG8zIjI
	QMJ7Pn90ewKDT7GzBpwEtPPnsFDsDyYFYq8MAqKX3F9+fpLrxW7kPVl7u99/g3nY
	Q/FLAScLblFR58xLioXVpwuHhVGAhA/O+zsFxvxDskxnQAjNesiq1OtCGQOAiK6O
	idkknEZrCJW9uqI8yD7He76890mUx2oJkQ7eSJzNeEvrspo3G5b/X1GyaZxDyFRJ
	+cczj7kRgbJ9rKJRNQffQ==
X-ME-Sender: <xms:hSiKaY7UnLbV5qz8J5ogWmlUeas0czKKQ3QKjNS5iqbFOZlMoliQ9w>
    <xme:hSiKaVxjqZr9DPHVPowokr69uQTMhCGcKVhjLLot7geeZbWItPoKmDwrJY9W2lgvV
    Jjb_plmmIrcwlKtgdFzXtt1DD2HlIrq4oYT_l_sbVzUkACU98ZO9_s>
X-ME-Received: <xmr:hSiKaS_dR3Pm160L97wg6jYiZ65rVku0_6NU0GXjJ5oFrVx8prFnjSxsXOfxVu1XYao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    ekvefhgeevvdevieehvddvgefhgeelgfdugeeftedvkeeigfeltdehgeeghffgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehuthhilhhithihvg
    hmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghkfedttddtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnrdhjohhhrghnshgvnhestggrnhhonh
    hitggrlhdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhm
    pdhrtghpthhtohepjhhmohhrrhhishesnhgrmhgvihdrohhrghdprhgtphhtthhopehsvg
    hrghgvsehhrghllhihnhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihht
    hidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmh
    grshhthhdrnhhorhifrgihrdgrnhgrnhgurgesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:hSiKaRFRGKNmGXY91hDQDA1_yvhX6ngnsPFU_gWqizo4pAjCFOFOgA>
    <xmx:hSiKaUCDRz_4T5herk0tWDTpE9d3ldHh2-f4PreTJe7eMQBviHzP1g>
    <xmx:hSiKadn4uXCZcseenm-O1hjuvzbiKcYJry5wjO0K69xNuOuIzXb4GA>
    <xmx:hSiKafQLmLR61vE_GnuDk2Kyu2HKTPlfQoQg1E-uv-Hqozdir3FF-w>
    <xmx:hyiKaZTPb93JYyVPxdbcg-ARDAp9q_RA6YI06qVVqcLNhBHge-Up7iQC>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 13:33:39 -0500 (EST)
Message-ID: <a0ae82d6-8c9f-4b6d-9f7b-a6d38efbf80f@maowtm.org>
Date: Mon, 9 Feb 2026 18:33:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260208231017.114343-1-gnoack3000@gmail.com>
 <20260208231017.114343-2-gnoack3000@gmail.com>
 <20260209.yeeh3ieDuz9u@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260209.yeeh3ieDuz9u@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[maowtm.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[maowtm.org:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257978-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[digikod.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,gmail.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@maowtm.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[maowtm.org:+,messagingengine.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maowtm.org:mid,maowtm.org:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D15661138E3
X-Rspamd-Action: no action

On 2/9/26 17:51, Mickaël Salaün wrote:
> On Mon, Feb 09, 2026 at 12:10:11AM +0100, Günther Noack wrote:
>> [...]
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index d0511225799b..db9d279b3883 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1226,10 +1226,19 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>>  	if (!S_ISSOCK(inode->i_mode))
>>  		goto path_put;
>>  
>> +	err = -ECONNREFUSED;
> 
> We don't see it in this patch but err is already set to -ECONNREFUSED.
> This line might be confusing, and unrelated to the goal of this patch,
> so we should remove it.

I will confess that in a side conversation with Justin previously I
suggested that for blocks like these it might be better to always assign
to err, and let the compiler optimize it away, so that when this block is
moved there is less chances of mistake.  (This was relevant in the
previous context where a move of this hook caused err to be reset,
resulting in a NULL deference from syzbot)

But of course if the convention in this file is to not do it, or if I have
missed some reason against doing this, then that's also fine (even though,
IMHO, personally I think this is better).

