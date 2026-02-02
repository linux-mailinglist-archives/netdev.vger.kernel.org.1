Return-Path: <netdev+bounces-255898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI8DH9m8gGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:03:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD2CDD2B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD49303DD02
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB51372B51;
	Mon,  2 Feb 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="OOz+3jYz"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2D217F33;
	Mon,  2 Feb 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044553; cv=none; b=U5iEoVsLiUHI45krp7Tef82U+5SNa+kReupraHUl2Nga9+x80DeiXa3vS6sTR2ugNLZUp/SKqxxPt1eIngzhwQHbpTi6LN/S3SxjU6Q8ph0E1utLHZDAU3tP+bKLg1eWQMbvrtoiIfkq96gPDOkGoy+8z1Uu3OysH/IBsAYX/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044553; c=relaxed/simple;
	bh=lMuDdA9WtMDAj2NOr3BIv3YBHPc33/FnHe1Ws8WEHkc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EH+ShNYBwuIAB5cklW9NQHWg7Gxj2xJWcFYvM9gqQsD1PR1xLkTN8RJwmyq61JaRP84WjAyNLMB9sH+HPfYS0TOCGBuvwKX9HSBLSmwGSTCeoQvUZp4jHzvKXrOtEykw2taNFl2Xqp9RWas7Zs/elAZMXM1JJUVMruLmDeVRNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca; spf=pass smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=OOz+3jYz; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4f4V3V5ns7z7cL;
	Mon,  2 Feb 2026 15:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1770043990;
	bh=+T+Mnym1hjDvqV1NGZfP/AXIlJ/jSBI7WCBtr1wCNLs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OOz+3jYzEF6K1wf6h4wmomBU9IY03p+pHNxAgWVHsqzMT3f1msRCALd5MlklkBw5b
	 630dkvb6VTijBrIEA/R672KXlvkTu9JiSMhac9kBrKY2kEA/DyJlWUuum8s2Ui/bLh
	 4Vp16xgSuHynGA3uHJch2O1H6ksT4syz6XJEkFO4=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 1.206
X-Spam-Level: *
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id cvoLV6NHsOcq; Mon,  2 Feb 2026 15:53:10 +0100 (CET)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Mon,  2 Feb 2026 15:53:09 +0100 (CET)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id BC2851820162; Mon, 02 Feb 2026 09:53:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id BAD601820161;
	Mon, 02 Feb 2026 09:53:08 -0500 (EST)
Date: Mon, 2 Feb 2026 09:53:08 -0500 (EST)
From: Paul Wouters <paul@nohats.ca>
To: Antony Antony <antony@phenome.org>
cc: Jakub Kicinski <kuba@kernel.org>, 
    Antony Antony <antony.antony@secunet.com>, 
    Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
    "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>, 
    devel@linux-ipsec.org, Tobias Brunner <tobias@strongswan.org>, 
    Simon Horman <horms@kernel.org>, stable+noautosel@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [devel-ipsec] Re: [PATCH net-next v4 1/2] icmp: fix ICMP error
 source address when xfrm policy matches
In-Reply-To: <aYCTfwblH8wtnF6c@Antony2201.local>
Message-ID: <d54db2a8-d3ab-b8ff-21fc-a26716a21494@nohats.ca>
References: <cover.1769595011.git.antony.antony@secunet.com> <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com> <20260129184510.01319683@kernel.org> <aYCTfwblH8wtnF6c@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nohats.ca,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nohats.ca:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nohats.ca:mid,nohats.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nohats.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@nohats.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DFDD2CDD2B
X-Rspamd-Action: no action

On Mon, 2 Feb 2026, Antony Antony via Devel wrote:

> Hi Jakub,
>
> On Thu, Jan 29, 2026 at 06:45:10PM -0800, Jakub Kicinski via Devel wrote:
>> On Wed, 28 Jan 2026 11:25:14 +0100 Antony Antony wrote:
>>> Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches
>>
>>> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
>>> Cc: stable+noautosel@kernel.org # Avoid false positives in tests
>>
>> I don't understand what you're trying to express with all these tags.
>> We are sending incorrect ICMP packets, seems like a normal net-worthy
>> fix to me?
>
> You're right that we're sending incorrect ICMP packets when IPsec/xfrm is
> enabled and this is a legitimate fix. My concern with backporting is about
> potential disruption rather than the correctness of the fix itself.
> The issue is that some existing test scripts and monitoring tools may have
> hardcoded expectations for the current(incorrect) source address behavior.
> When this one-line fix gets backported to all maintained kernels, those
> tests would start failing, potentially triggering regression reports and
> requests to revert the fix from stable kernels.
>
> Additionally, without the
> commit 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
> being present in older kernels, the behavior change could be viewed
> differently in stable branches.
>
> This is also the sense I got from IPsec users.
> Given these considerations, I opted for the safer path of targeting net-next
> with stable+noautosel, no backporting.

libreswan is unaffected, other than the old code showing a weird
unexplainable log message.  So we are not really affected by whether or
not this get backported. We would slightly prefer the backport just to
get proper icmp messages out there (and we might need to fix a few test
cases but that is okay with us). If someone reaches out with strong
arguments to not backport, we would be fine with not doing it.

Paul

