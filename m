Return-Path: <netdev+bounces-272171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBZABC5vxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:38:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A133945B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9EE330BE6B7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B6425CF4;
	Thu, 26 Mar 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ejBmPAYA";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="jOXsAgpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BE41C30D;
	Thu, 26 Mar 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546272; cv=none; b=BnrEdWXXKnlptbBoi9324wC8kyRNFTOOJrRsaF2rb9JnIMFsra7CJWnJ9XphOtubhRwJAdSr+Z7gHbFy4PMztF73OJxxPDEIOISIKS2AaTgeyceTFduoEKy88Hi8qC7vAJB0RIdnVikHqeCTRKIo1l9URt87EdgDy7Q4mLaa1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546272; c=relaxed/simple;
	bh=JIOc5GnB72K4q/HRE0zTqYJt05e5jkm8u7Q880pzdBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTYKcsEg17MJlm5Ug7EtE8GbxqxzhPDqrqlYSOJaX5KDMxzXWEa2TXE/FSEDWF33qgjnaDkqJuxXvp44zsN1IWOPbblHWXmn3HGuGufFIYyrRWhuhzgsddDqg0td2dyNaBdtfDyHS75Z3vUH3ySwDuKvxpS8e7AQcR//X885slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ejBmPAYA; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=jOXsAgpP; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62QHUbbp011755;
	Thu, 26 Mar 2026 18:30:43 +0100
Received: from [10.62.247.239] (93-33-118-253.ip44.fastwebnet.it [93.33.118.253])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id D32A0120596;
	Thu, 26 Mar 2026 18:30:42 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774546244; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKQp0iMzqepU2z7oj1+7CMIhVFuegfGwrdKsraVp8KY=;
	b=ejBmPAYA7FjPQ+gBRxqyAoCBSEleA8Wy/XLoqJEJoJn4j1Jp5czTvGOMQcnS82qOyEVLDI
	MQ/oOxyZNCeMGoDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774546244; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKQp0iMzqepU2z7oj1+7CMIhVFuegfGwrdKsraVp8KY=;
	b=jOXsAgpPYTPNb/wjJmNf4jEl1vQmkd3ReeuXPP/hD7LJJ5HzDlNNMe11k9QRvoB34Dzu6k
	IiQM0PpJVBOwXUjRhrvRho26slfjWrLJ3HJzlb2rL7K03NU38zeW4ymbOK+eveE78ltZ53
	N7GMTTCZ73KcIhkUuLcQS898xXPDy57oktMvncNSCxEYUsHnkGylX4TXJE5WXFRLPNuAAB
	Fp4ENIc7VHpEDfYE85j0SmuPmzz2PE7TecSfHDW6AjvRt33afNQ11pd6kIusF3FjHSKVyu
	zN89z0knQNJepcWufZukAdiKwQNhJMDosvnhjAA3fUrTf9I40e/4prv0pDc2CQ==
Message-ID: <4d512ba5-a6fd-4d26-876b-5ea7a145d0cd@uniroma2.it>
Date: Thu, 26 Mar 2026 18:30:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
Content-Language: it-IT
To: nicolas.dichtel@6wind.com, Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
 <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
 <dfc4fb29-7f27-4e9f-b6c9-bd37cbddbf1e@6wind.com>
From: Stefano Salsano <stefano.salsano@uniroma2.it>
In-Reply-To: <dfc4fb29-7f27-4e9f-b6c9-bd37cbddbf1e@6wind.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	TAGGED_FROM(0.00)[bounces-272171-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefano.salsano@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:mid,uniroma2.it:email,uniroma2.it:url]
X-Rspamd-Queue-Id: 7B0A133945B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il 26/03/2026 17:30, Nicolas Dichtel ha scritto:
> 
> 
> Le 25/03/2026 à 08:10, Stefano Salsano a écrit :
>> Il 24/03/2026 17:00, Justin Iurman ha scritto:
>>> On Sun, Mar 22, 2026 at 12:06 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> this RFC series adds support for the SRv6 End.DT2U behavior and
>>>> introduces the srl2 Ethernet pseudowire device, together with
>>>> corresponding selftests.
>>>
>>> Hi Andrea,
>>>
>>> Thanks for the work you (and Stefano) put into this series! As
>>> discussed offline, there is interest in such a solution.
>>
>> Hi Justin,
>>
>> thx for your interest!
>>
>>> A general comment: I'm not sure about the name "srl2", as we're
>>> talking about SRv6 specifically here.
>>
>> fair point
>>
>>> I would personally love to have
>>> "l2srv6", although I suspect we may end up with "l2seg6" to remain
>>> consistent.
>>
>> I'd like to keep it as short as possible, our initial idea was seg6l2, very
>> close to your last suggestion, then we opted for srl2 losing the "6" concept
>>
>> now it comes to my mind that l2 is somehow redudant in an interface type name,
>> as an interface is an l2 concept per se, so my preferred option becomes:
>>
>> sr6
> Note that the interface name is defined to kind + a number when the IFLA_IFNAME
> attribute is not specified:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/rtnetlink.c?h=v7.0-rc5*n3823__;Iw!!O5Bi4QcV!Bw3h__JfgzAoQlG3DyfQsdX5VEQi5Zx9dXbROUeKuwomkISAWgGMwNxjv059RhKI5xV9MpHHknEXDTb9diS16akPWyJi_dCP7aE$
> 
> Here, the default name will be 'sr60' :)

+1

> 'vti6' is already in this case, so it's probably ok. I vote for 'sr6' too ;-)
> 
> My two cents,
> Nicolas


-- 
*******************************************************************
Prof. Stefano Salsano
Dipartimento Ingegneria Elettronica
Universita' di Roma Tor Vergata
Viale Politecnico, 1 - 00133 Roma - ITALY

http://netgroup.uniroma2.it/Stefano_Salsano/

E-mail  : stefano.salsano@uniroma2.it
Office  : (Tel.) +39 06 72597770 (Fax.) +39 06 72597435
*******************************************************************


