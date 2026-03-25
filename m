Return-Path: <netdev+bounces-271631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjICgAHxGnOvQQAu9opvQ
	(envelope-from <netdev+bounces-271631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:02:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F15C3289BC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74839344343A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144B3DCDB0;
	Wed, 25 Mar 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="FABBEw/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBDF35AC01;
	Wed, 25 Mar 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451998; cv=none; b=kAsbjFZcfvCv/YOYA0Q4bT9o13bqjWbnkyT77SkjSG4dqXxdpTtQT+uNNRSkO9Aw0EHc7PKJrauyzs01j/LcTGQugzvLR73IEUzRraw3C++oIMDwQEr547s0Cx75EPzHhD3mGn+Cu56Pr27f3rw33ATGViO0HlCuLcSt0HUSf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451998; c=relaxed/simple;
	bh=qzBa9A4gWyboQX7vb0MR5D6DznmvgfAj3TkduROiahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhxzqJ9VlzGfeqIV20SBv4HWO6wa816qGkQfr1NQFGqtngyAJiL1ImMe9WCAA8Poh2GMFVDqdJ1jzX257D/9dmieTBhZA/wpa5qPhk3YJ7eZV8QfzUlqucUoXwO+PnnJ2dml2atlDADFrLjoZqw+KvEHDtLO9boMsVee2vKKnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=FABBEw/3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [79.139.245.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0A6A4413A4D1;
	Wed, 25 Mar 2026 15:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0A6A4413A4D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1774451987;
	bh=CgGVEdDotrUxFWiSjF8zmnyJCQXPhbkhrROl5zrGJNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FABBEw/37TiAtd+C2rszl59lq2kNQvjmeRtRirvxCr+ARggo14pCI2v/SAGWBj72r
	 3gf3sFpnQ1aM1xs/SBJS9HQH4BZwv753opCIKSbOSgzD6XOJdhW52sVPevE9ow2MDj
	 5/bi8ITcQS68lg1n0mUTy2SGVA86x2GFMcrOqk0Q=
Date: Wed, 25 Mar 2026 18:19:46 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Agalakov Daniil <ade@amicon.ru>, lvc-project@linuxtesting.org, 
	Roman Razov <rrv@amicon.ru>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniil Iskhakov <dish@amicon.ru>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 2/3] e1000: fix endianness conversion of
 uninitialized words
Message-ID: <20260325180127-711d8e8fbff840853081f11e-pchelkin@ispras>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-3-ade@amicon.ru>
 <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271631-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: 9F15C3289BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, 24. Mar 16:26, Tony Nguyen wrote:
> On 3/18/2026 5:05 AM, Agalakov Daniil wrote:
> > [Why]
> > In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> > words. However, only the boundary words (the first and the last) are
> > populated from the EEPROM if the write request is not word-aligned.
> > The words in the middle of the buffer remain uninitialized because they
> > are intended to be completely overwritten by the new data via memcpy().
> > 
> > The previous implementation had a loop that performed le16_to_cpus()
> > on the entire buffer. This resulted in endianness conversion being
> > performed on uninitialized memory for all interior words.
> > 
> > Fix this by converting the endianness only for the boundary words
> > immediately after they are successfully read from the EEPROM.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> While this is definitely better, I'm not sure there's a bug here since it's
> being immediately overwritten. Seems like this patch would be better going
> to *-next as an improvement.

It's worth stating in the commit message that the uninitialized memory is
touched with le16_to_cpus() in the loop only on BE systems.  Little-endian
ones are not affected - le16_to_cpus() is a no-op there.

Anyway, for the BE case, touching and manipulating uninit memory bytes is
still in general considered a bug, even if this memory is overwritten a
few lines after that.  I guess if KMSAN supported big-endian architectures,
it would hit this, and that wouldn't be a false-positive.

I'm not aware of the details on how you treat the bugs in these drivers
for BE-systems: maybe they aren't prioritized and then would occasionnaly
go as -next material.  But, again, this situation looks like a real bug
worth fixing on BE-systems.

