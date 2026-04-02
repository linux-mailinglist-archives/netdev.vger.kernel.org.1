Return-Path: <netdev+bounces-274505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLgoFLBYzmkxnAYAu9opvQ
	(envelope-from <netdev+bounces-274505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:53:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E397D3889C0
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C578A30819D2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CAB3CBE7D;
	Thu,  2 Apr 2026 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HhKqODwm"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFA3C9459
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130527; cv=none; b=GY+HBnwYT03Tr22qVRPMEx5sxm7A5JbguMvAYLNK6GFbPZ2f98wMW/cFzjzO5CZk4eOv3Wu2jRGmngTuHYbmDquy2s/bFYEoz5L8kat2krox1JB2IZA3V38ZVK6K3ExZ0XlbzCQ63jUh4UFQ6kiYEJyGjdBjhySa1HwjdZrpsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130527; c=relaxed/simple;
	bh=ZC0mFusg8QtnBwKB+xDHtVzUxcGHi5zJsTVo23phRnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sC8aCnWdAOOUf1pDbs34w1yNraXy/lSXZT8rvJVI6srrWt2tSNtI9wrGVVnjvGz9W4Zxawqk2SOwqeSYf4O5vvOPA4OvjrlSwZQQc70fcxtCGSpCSSMPo8A6p9KdolMZGrDqNxxjFbOPgUfYSv63T9dBVXDCO3WPjBSWOzUt4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HhKqODwm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775130510;
	bh=ZC0mFusg8QtnBwKB+xDHtVzUxcGHi5zJsTVo23phRnk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HhKqODwm+kGM+aPRLLSfa9xVjBI/60JnS0jLrIszoMnezZZlJRJBsnCsiFkFSwZ4Z
	 K8BnXNeXqk0w4aTLrt5XFKYDvQM/gILFnVsy3R0lL2scmnXhPWiZSP7KQGEwL4eEko
	 cheSaJsB/ETa/lYmBj1klXGPlXbddFCY7d+BXfoh7G09fe3CvZVWAM1Ca3LhL9frpp
	 j+toIvYXx3M0xIKmbb3U6HnTRqk6SJQVshABQ4hx/kfuneXok5gVfWxKeemZ51yGoS
	 H1/HcY0i5wlUP8+SWwXiYErbLDcjKwD/jJeV5A1lH7fqZLbe5RgCV7bgCUgziQWhES
	 FF01HM/MfxS6Q==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D11060AF7;
	Thu,  2 Apr 2026 19:48:29 +0800 (AWST)
Message-ID: <f3d485e57d89b9939b1930eb7310db78f47d1756.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/3] net: mctp: perform source address lookups
 when we populate our dst
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Thu, 02 Apr 2026 19:48:29 +0800
In-Reply-To: <05c7a9b4-9874-42e6-acae-a5d66d33428f@redhat.com>
References: 
	<20260331-dev-mctp-null-eids-v1-0-b4d047372eaf@codeconstruct.com.au>
	 <20260331-dev-mctp-null-eids-v1-1-b4d047372eaf@codeconstruct.com.au>
	 <05c7a9b4-9874-42e6-acae-a5d66d33428f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	TAGGED_FROM(0.00)[bounces-274505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E397D3889C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pablo,

> > Rather than querying the output device for its address in
> > mctp_local_output, set up the source address when we're populating the
> > dst structure. If no address is assigned, use MCTP_ADDR_NULL.
> >=20
> > This will allow us more flexibility when routing for NULL-source-eid
> > cases. For now though, we still reject a NULL source address in the
> > output path.
> >=20
> > We need to update the tests a little, so that addresses are assigned
> > before we do the dst lookups.
> >=20
> > Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
>=20
> Sashiko pointed to a possible pre-existent issue:
>=20
> https://sashiko.dev/#/patchset/20260331-dev-mctp-null-eids-v1-0-b4d047372=
eaf%40codeconstruct.com.au
>=20
> please have a look and follow-up if needed.

Yes, I've just been checking that out this afternoon. While there's
nothing pressing there (the findings are somewhat valid, but don't
affect any typical behaviour), I think it's worth a fix.

Given the merge to net-next, I assume a patch on top of the series is in
order, but let me know if you'd like something else.

Cheers,


Jeremy

