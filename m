Return-Path: <netdev+bounces-259230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHN2Dyh9lWl8RwIAu9opvQ
	(envelope-from <netdev+bounces-259230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:49:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958C1544B0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6384C3006F08
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477C32693D;
	Wed, 18 Feb 2026 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="iQtdnRfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616532573A
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404580; cv=none; b=RMhLcSKlUnCX03sNPrwRKh2OA6OvxZH13tHP3s8f2ngbn0kY1UYPGm221YM9f5t/z9uOJcovoP0G1rw5wM6ve2wF/BVkbNBG78QKaCHY8oqDwVFmy9U2xDJTUh1uaJZ//rOhwCcZ/G5HFMt0ZVG83iqkUKxoX94FRbcV9T1Zr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404580; c=relaxed/simple;
	bh=NGWeKQDdFOoVXHNlINqzBrYg6MbnlgdVi+2skKjiwHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do4PYok7Xv+SEloafJgd68SG1ocbijmvnDzAbWuK/w68mhkR4h7JuSQnMKUYrfEYGSUAMb2OX+yqAMdPKNOTP5y5NQpU44neC+8azxvzS6GcN0S0SShZdhmtj1ZW0wzJZ+xODn8PfZoszjKbvWYvXJXqR+1YFwMmL8oDBT9TLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=iQtdnRfy; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id 931E05A0002;
	Wed, 18 Feb 2026 09:41:58 +0100 (CET)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgB3R4zQU8wH; Wed, 18 Feb 2026 09:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1771404117;
	bh=NGWeKQDdFOoVXHNlINqzBrYg6MbnlgdVi+2skKjiwHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iQtdnRfy5p+0GZTP1hVsi9qhgPtvIEyRG7y4SIWDDrzELdC6X3jTdmkIAZ99dfaJp
	 QBecTzDAJ2oqXRfkset3fZokV9aS14oer2AHqK9F22diHgwMGzpr3CCTys2voHf225
	 N/R9cnpkddNG8zowgTEsOpqtHaWLnma6Qg2HiV3loJUMfxKHl5l377gkfdje0LrOsL
	 PqQiW14dcD5uIuwkqIEf0SYIG625Wya5OlvBgiTlcB9SWld51KAgBGsoyTxI4ZGTFS
	 ngOLAzbezBw9tTUR4nBrUYIfxj/Th/O26+TTHR3iTOufDvoFWSMUdQCjxXyveocki0
	 F9WENMU1h/D+g==
Received: from [IPV6:2a02:16a:6e13::1f84] (unknown [IPv6:2a02:16a:6e13::1f84])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 5474D5A0001;
	Wed, 18 Feb 2026 09:41:57 +0100 (CET)
Message-ID: <7b4667b9-c4f2-4c56-a0ea-6e9bdc8b5241@strongswan.org>
Date: Wed, 18 Feb 2026 09:41:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: Yan Yan <evitayan@google.com>
Cc: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, paul@nohats.ca, netdev@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
 horms@kernel.org, saakashkumar@marvell.com, akamluddin@marvell.com,
 Nathan Harold <nharold@google.com>, greg@kroah.com
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de>
 <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
 <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org>
 <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: de-CH, en-US
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[strongswan.org,none];
	R_DKIM_ALLOW(-0.20)[strongswan.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[strongswan.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tobias@strongswan.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9958C1544B0
X-Rspamd-Action: no action

Hi Yan,

> For every inbound SA, we allocate SPIs before negotiation. For
> outbound SAs, we allocate SPIs once requested by the peer. We only
> require the (SPI, destination address) combo to be unique. Thus, we
> may have an inbound and outbound SA sharing an SPI with different
> destinations, or multiple outbound SAs to different peers sharing an
> SPI.

That should still be allowed when using the intended APIs (i.e. ALLOCSPI
for the inbound and NEWSA for the outbound SA).  ALLOCSPI might enforce
a unique SPI without considering the address, as that's intended for
local, inbound SAs, where the kernel has full control (looking at the
the patch, it's certainly not ideal, as it goes through all installed
SAs to find a duplicate and it prevents an inbound SPI that matches an
existing outbound SPI - I guess that could be resolved by using separate
tables for in- and outbound SAs).  But that must not prevent installing
outbound SAs with the same SPI to another peer using NEWSA, which still
uses a hash that includes the destination address (that must always be
the case because peers are free to allocate whatever SPI they want).

>> If so, why would you use ALLOCSPI and not just install the outbound SA? Is it to avoid differences for in- and outbound SAs (ALLOCSPI+UPDSA vs. NEWSA)?"
> 
> Exactly—it is primarily for code symmetry. By using ALLOCSPI + UPDSA
> for both directions, we maintain a consistent larval lifecycle and
> make it easier to maintain.

In my opinion, you are using the API incorrectly.  ALLOCSPI is intended
to allocate a free local SPI for an inbound SA.  That is, reserve it
before and while the details of the SA are negotiated with the peer
using IKE.  This step isn't necessary for outbound SAs and forcing such
an allocation, after all the details are known, to the responder's SPI
(which I assume you do via min/max option) doesn't feel right.  I also
don't think there are any benefits in that "consistent larval lifecycle"
(if you found any, please let us know).  And the difference between
UPDSA and NEWSA is the nlmsg_type (there are some attributes that are
different for in- and outbound SAs, especially if you set the direction
in newer kernels, but that's the case regardless of the message type).

By the way, are you using the min/max option for inbound SAs as well,
with an SPI generated in userland?  That would seem like a violation of
the intention of the API as well (i.e. letting the kernel control the
local SPIs).

As the XFRM API basically mirrors PF_KEYv2 here, you can find more about
the two ways to install SAs in RFC 2367 (SADB_GETSPI/UPDATE vs. SADB_ADD).

Regards,
Tobias


