Return-Path: <netdev+bounces-201187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3BAE85A3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A3B7B56E9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7272641EE;
	Wed, 25 Jun 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b="kVr09qow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbkZ2iNf"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33108263F27;
	Wed, 25 Jun 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860422; cv=none; b=rwy5c89e90rSKjPHX4Ms2JdAi9vEy4TCam1Hf3xjexGzkKJbaQNdWUo2SZ75K1NjrP9aLat1LFzcGmQuRx0hi0T1hnL3RnAGbM3D2e84VyTqLjkr7+TVONO7AS6KnKEhXJpfCoUlHZBuZ73Wpm551s9ZonkfQDDhEmEtG4eQTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860422; c=relaxed/simple;
	bh=whbq69tm45xQENPR8UNGOy2JUhKz3h1lSYmaOuA8oHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ6UDenKHnLY3r5FU87J/dX8mnUizAtGDyCaXTeZbxWa1GDpyx9C3AeF+tLRFgWGCag9oVwqKRRyBbRonymxD/BpKIsblUwh5MGibNpNC3QfjHYRzHeSx55W2sdlNCmTMofjgSdVyJgSekXBYwYfJCM43enJlBXu/Scp/AeQzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me; spf=pass smtp.mailfrom=ursu.me; dkim=pass (2048-bit key) header.d=ursu.me header.i=@ursu.me header.b=kVr09qow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbkZ2iNf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursu.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursu.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 401B81400073;
	Wed, 25 Jun 2025 10:06:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 10:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ursu.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750860419;
	 x=1750946819; bh=WPZdbXHxbn4kKW18nfEwKIWKWSen/JBn8Chb6xSN5cc=; b=
	kVr09qow2ZXe98BVTGdIRPz/KL5eoOuN5iA98vxfZzg+W+aEEHBpepFFYmU9Qb2l
	2jdF7BFLw/bqwWIODxhe+fgi5bzkeWYzzbvJ/a1sUCQE3uDwug2cTuJ9jrMlm0UF
	kdQLuCd0bDFrjrkEM8wb827B2PTsT1e6xOGSgHxxODc1rigJD2ACAuPyg8Vp8n6y
	bScnE887Tpwk6614/87ejA/3F4vlpofYIWS29IJeuBlUPizZmcpy6CcDF7SlediM
	RV627fb3n1z07dXzLCgu7XVcQuMUS8qk0UW0uuyuZPjBPQ2qEyRmVnqZ3PD8geyX
	eAqf86rhKeKO7PnetQe92Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750860419; x=
	1750946819; bh=WPZdbXHxbn4kKW18nfEwKIWKWSen/JBn8Chb6xSN5cc=; b=C
	bkZ2iNfeSFl+56KTg+lZab8+hkz14VHKNZaLXQM/JEveQ1inBfNGugrRjRaGMS2K
	c2u/ZWV5fZmp/Wnfv8z0axuEuA+wZxru4jzBSUTLnJQH/pyyvRc3BL37b8GrHab3
	ulmAaql5jmL2nEl2YRZZ2acBDK1RQnU2n2bsNPyVtdVp9HBZadQbG30INHEAQcnl
	ZLDVm5/1YylwnLa+IOvv50xmP5ObLbfyVB2Zel4ONhEDdEJLIe0KfNhF6XlG7qfQ
	qaNca2xc/IPE1UwrLIOoJVfw6jeVUKFcWyh9GlJitN8POmHfmpKf/IneTPz5gh96
	w7xABc8lNyZ7qc6EgcpVg==
X-ME-Sender: <xms:gQJcaB6xf0CHDkF80P2QWckvogV-iOmhBqWOvr4GVncUtZ_9PwyVmQ>
    <xme:gQJcaO55HcOAODhdGZzDlDpEsRc_HH14FJxdzUXvvuMMYGW6m200WsTZT12FPle8J
    gZ9uOurMymZ2OBnjhU>
X-ME-Received: <xmr:gQJcaIcW4VH1ZvxRCvXsuzstrbqKhKGXXzEXtizf0mDqE0zNW0s-ABqPJ4aE46qozvIm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghlrgguucgf
    tffufgcuoehvlhgrugesuhhrshhurdhmvgeqnecuggftrfgrthhtvghrnhepueegkeetle
    efueffieevudffvdekhffhfffhhfdtgeekudetvdeghefhteeiffeknecuffhomhgrihhn
    pehinhhtvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepvhhlrggusehurhhsuhdrmhgvpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtggvkhesjhgrtggvkhhkrdhinhhfoh
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhht
    hhhonhihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivg
    hmhihslhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgu
    rhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:gQJcaKJNazL9AgkZZQr-bGQdOG1eZT1wjher2-l2F57PxNBIRB2ovA>
    <xmx:gQJcaFJeCymlECjZP5KOMk-7ZY7_xK6BR2xyGLDCakAgwQ-aobP9cw>
    <xmx:gQJcaDxxE0HJDM_YuGc84vj-7Y6sx8lL6Bmf_GQlpd_5hi4sJYyzyA>
    <xmx:gQJcaBKw8Apuu_3atUuVeP8Z2kBlqtH6hB0DX6j9ReE02kWZJ3uPdQ>
    <xmx:gwJcaPDYUNcXZ3KePhJI9uqrkwCXgb85Rn7ZaDPK5pEtLOVVrrsQMnrS>
Feedback-ID: i9ff147ff:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 10:06:55 -0400 (EDT)
Message-ID: <eb418aae-c0d4-438f-9b3b-fcb870387b1a@ursu.me>
Date: Wed, 25 Jun 2025 17:06:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Jacek Kowalski <jacek@jacekk.info>, Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
 <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
 <20250624194237.GI1562@horms.kernel.org>
 <0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>
 <20250625094411.GM1562@horms.kernel.org>
 <613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
Content-Language: en-US
From: Vlad URSU <vlad@ursu.me>
In-Reply-To: <613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.2025 16:05, Jacek Kowalski wrote:
>>>>> +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF
>>>>
>>>> Perhaps it is too long, but I liked Vlad's suggestion of naming this
>>>> NVM_CHECKSUM_WORD_FACTORY_DEFAULT.
> 
> So the proposals are:
> 
> 1. NVM_CHECKSUM_WORD_FACTORY_DEFAULT
> 2. NVM_CHECKSUM_FACTORY_DEFAULT
> 3. NVM_CHECKSUM_INVALID
> 4. NVM_CHECKSUM_MISSING
> 5. NVM_CHECKSUM_EMPTY
> 6. NVM_NO_CHECKSUM
> 
> Any other contenders?
> 

For reference, I called it "CHECKSUM_WORD" in my proposal because that's 
what it's refered to as in the intel documentation (section 10.3.2.2 - 
http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/ethernet-connection-i219-datasheet.pdf)

