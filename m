Return-Path: <netdev+bounces-226209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B15B9E13F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C703B3C21
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACF25EF97;
	Thu, 25 Sep 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HhtWRQqo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6xsUzMyJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HhtWRQqo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6xsUzMyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4C21ADA7
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789473; cv=none; b=aeY2yL+oWAzqVTbDlsna23dCVTF7K7qiKYq0JEAAKWjQZJFu8mvZwrR0swm6VHAejyse94dXTNbYBcAGoS+oRH26OsblZcBXDm9tfdndTPNqkVP5CUHx1IzQpyL7iZD5/nrZ2duIVUDpIyF+D1vuiM2sCPO7IZ7JDOo+/UhOBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789473; c=relaxed/simple;
	bh=77psQUD1KnFwasJRTiuYObH4bT1pSDUU/jt2XswaBs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBgcfQPc+tJO82jF7yQdToNfiloogPqe27wpH5Juq3gcNQEkjb3+NvmmfsqMOofMwj21qbRSrZWhiwpwpMtLhpMhWBM2BPIGTtHQ9HBw9z4rhhoQG3M1A0vS4IVAA1UFF2T6vSWguDOZcNm4dwgOuEgPL6qIkKFlAXoyB/C3vek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HhtWRQqo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6xsUzMyJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HhtWRQqo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6xsUzMyJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 224155CED0;
	Thu, 25 Sep 2025 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758789464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1YUPMJxZpYlSuPcCViU3wuERoHp7DApV4SYW2XNkgA=;
	b=HhtWRQqoYJsKU8u0cdqJRXnHlsSieU3mFxTlCzgIK4PW/Fx4CUytCy6IRYPoRKVQzlu4lQ
	Umzl5ditQHxpmUNKLu+aIO2P30NXIMOTqtPSc5nUR+LU/pbaT8CbRPXSQ8YoMvVoK3VkZX
	EVtSlsguFelfEK/j2cxjpyYW2upTBd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758789464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1YUPMJxZpYlSuPcCViU3wuERoHp7DApV4SYW2XNkgA=;
	b=6xsUzMyJqLXExZlBzhuewdbQv1za93DZPOhGPTG7lWk6RKk5sxCS5qALqaB65IyiK1F+s1
	ShVE8xeXUNFca6AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HhtWRQqo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6xsUzMyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758789464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1YUPMJxZpYlSuPcCViU3wuERoHp7DApV4SYW2XNkgA=;
	b=HhtWRQqoYJsKU8u0cdqJRXnHlsSieU3mFxTlCzgIK4PW/Fx4CUytCy6IRYPoRKVQzlu4lQ
	Umzl5ditQHxpmUNKLu+aIO2P30NXIMOTqtPSc5nUR+LU/pbaT8CbRPXSQ8YoMvVoK3VkZX
	EVtSlsguFelfEK/j2cxjpyYW2upTBd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758789464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1YUPMJxZpYlSuPcCViU3wuERoHp7DApV4SYW2XNkgA=;
	b=6xsUzMyJqLXExZlBzhuewdbQv1za93DZPOhGPTG7lWk6RKk5sxCS5qALqaB65IyiK1F+s1
	ShVE8xeXUNFca6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA2B132C9;
	Thu, 25 Sep 2025 08:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xz4RK1f/1GgOSAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 25 Sep 2025 08:37:43 +0000
Message-ID: <c39e6626-02db-4a83-9f77-3d661f63ac0e@suse.de>
Date: Thu, 25 Sep 2025 10:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info
 output
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?SsOhbiBWw6FjbGF2?=
 <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250922093743.1347351-3-jvaclav@redhat.com>
 <20250923170604.6c629d90@kernel.org>
 <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
 <20250924164041.3f938cab@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20250924164041.3f938cab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 224155CED0
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
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51



On 9/25/25 1:40 AM, Jakub Kicinski wrote:
> On Wed, 24 Sep 2025 13:21:32 +0200 Ján Václav wrote:
>> On Wed, Sep 24, 2025 at 2:06 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>> On Mon, 22 Sep 2025 11:37:45 +0200 Jan Vaclav wrote:
>>>>        if (hsr->prot_version == PRP_V1)
>>>>                proto = HSR_PROTOCOL_PRP;
>>>> +     if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
>>>> +             goto nla_put_failure;
>>>
>>> Looks like configuration path does not allow setting version if proto
>>> is PRP. Should we add an else before the if? since previous if is
>>> checking for PRP already
>>>   
>>
>> The way HSR configuration is currently handled seems very confusing to
>> me, because it allows setting the protocol version, but for PRP_V1
>> only as a byproduct of setting the protocol to PRP. If you configure
>> an interface with (proto = PRP, version = PRP_V1), it will fail, which
>> seems wrong to me, considering this is the end result of configuring
>> only with proto = PRP anyways.
> 
> I'm not very familiar with HSR or PRP. But The PRP_V1 which has value
> of 3 looks like a kernel-internal hack. Or does the protocol actually
> specify value 3 to mean PRP?
> 
> I don't think there's anything particularly wrong with the code.
> The version is for HSR because PRP only has one version, there's no
> ambiguity.
> 
> But again, I'm just glancing at the code I could be wrong..
> 

No you are right, this is a hack made to integrate PRP with HSR driver. 
PRP does not have a version other than PRP_V1 therefore it does not make 
much sense to configure it. Having said that, I think it's weird to 
report HSR_VERSION 3 but fail when configuring it.

IMHO HSR_VERSION should be hidden for PRP or it should be possible to 
configure it to "3" (which now that you say it, it looks weird).

