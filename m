Return-Path: <netdev+bounces-222473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C9B54670
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA9018958EF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A089B2765CA;
	Fri, 12 Sep 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VGIVa2gQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6ToNB6E"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579926E16C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667869; cv=none; b=KKfWMwAbStYEA/AKy7ek5PlH7Nj2OZr8gCO47N27z08xf5Kkdaxtu3KOhPJTG2c+NPehApevuPTptH0EFsVmTFl2Ytgkhf4I1PqUwO9pcODN6DQ2MqE2RVTS7h/mv9F+IcvY65HvtxwkLn7wDdRck9XJUzAdcJ0xa4YaVpOyBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667869; c=relaxed/simple;
	bh=Y9EhGSCVNUf+eR07x0M8siC98ghrnoePSoUI/apFSMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ee/pwDk+cjibgUyhoHWq35tstUHcTH8sY28rIDkTed//0MV/j7unA+HBqEWBv9CBbI8YGEl6XrHCkEU/wdsG595DE8z7O1RtSby194+soozCz4Z3+rN6bFeeF3MjAjyXEYRLFK0Iq26JBcvLRmijWjtA2KY4cFkShX2pSIpnMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VGIVa2gQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6ToNB6E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757667865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90syXxZ3hoNyEnxXFNUZkJr/u60hxBRVGIRfqMYso1A=;
	b=VGIVa2gQBaPJitni38eBDuq8p17wXeE2ctQhxYWyldkLpZz3DSCsKkHg26jUuLQvseU683
	jjI1VlafuhsTMz+Iq1SA8EavYY1X7BNpFekMQZHEVCjMT/td+Rqp8AY8ad6nxfPsVNqWFS
	SCuwwPCUG9NI6jmufu6WCOgnRyLUvaY5IX0FQxqOqdudaNrP1yKNyE27D7/D68+uUIlqIp
	88a94168wftahtQzpnI+VLDeJwAXbZDyk/ZXIA76xyxpu6ihM0v92XaCvBPXbS9Tia1DDA
	UrzbnQm/okHoZBv5OeQXiSV2hVzBSiGTBlXESS0OJeajO8EgzcWOn7B5BWVb8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757667865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90syXxZ3hoNyEnxXFNUZkJr/u60hxBRVGIRfqMYso1A=;
	b=A6ToNB6EY4ij/h3wvb31H3s7QpJP1Sangz/E0U99Veb1OKoPNPbRxOeEdC7bY9tQYtYMzi
	/IXjH9nXZ/wCEMCA==
To: Miroslav Lichvar <mlichvar@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
In-Reply-To: <aKV_rEjYD_BDgG1A@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
Date: Fri, 12 Sep 2025 11:04:24 +0200
Message-ID: <87ikhodotj.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Aug 20 2025, Miroslav Lichvar wrote:
> On Tue, Aug 19, 2025 at 04:31:49PM -0700, Jacob Keller wrote:
>> I'm having trouble interpreting what exactly this data shows, as its
>> quite a lot of data and numbers. I guess that it is showing when it
>> switches over to software timestamps.. It would be nice if ntpperf
>> showed number of events which were software vs hardware timestamping, as
>> thats likely the culprit. igb hardare only has a single outstanding Tx
>> timestamp at a time.
>
> The server doesn't have a way to tell the client (ntpperf) which
> timestamps are HW or SW, we can only guess from the measured offset as
> HW timestamps should be more accurate, but on the server side the
> number of SW and HW TX timestamps provided to the client can be
> monitored with the "chronyc serverstats" command. The server requests
> both SW and HW TX timestamps and uses the better one it gets from the
> kernel, if it can actually get one before it receives the next
> request from the same client (ntpperf simulates up to 16384 concurrent
> clients).
>
> When I run ntpperf at a fixed rate of 140000 requests per second
> for 10 seconds (-r 140000 -t 10), I get the following numbers.
>
> Without the patch:
> NTP daemon TX timestamps   : 28056
> NTP kernel TX timestamps   : 1012864
> NTP hardware TX timestamps : 387239
>
> With the patch:
> NTP daemon TX timestamps   : 28047
> NTP kernel TX timestamps   : 707674
> NTP hardware TX timestamps : 692326
>
> The number of HW timestamps is significantly higher with the patch, so
> that looks good.
>
> But when I increase the rate to 200000, I get this:
>
> Without the patch:
> NTP daemon TX timestamps   : 35835
> NTP kernel TX timestamps   : 1410956
> NTP hardware TX timestamps : 581575=20=20=20=20=20=20=20=20=20=20=20=20
>
> With the patch:
> NTP daemon TX timestamps   : 476908
> NTP kernel TX timestamps   : 646146
> NTP hardware TX timestamps : 412095
>

Sebastian found a machine with i350 and gave me access.

I did run the same test as you mentioned here. But, my numbers are
completely different. Especially the number of hardware TX timestamps
are significantly lower overall.

Without the patch:

./ntpperf -i eno8303 -m X -d Y -s Z -I -r 200000 -t 10

NTP daemon RX timestamps   : 0
NTP daemon TX timestamps   : 565057
NTP kernel RX timestamps   : 100208
NTP kernel TX timestamps   : 281215
NTP hardware RX timestamps : 882823
NTP hardware TX timestamps : 136759

With the patch:

NTP daemon RX timestamps   : 0
NTP daemon TX timestamps   : 576561
NTP kernel RX timestamps   : 99232
NTP kernel TX timestamps   : 255634
NTP hardware RX timestamps : 868392
NTP hardware TX timestamps : 135429

What am I doing wrong? Here's my chrony config:

|########## i350 NTP performance regression test ###########
|local stratum 10
|allow X
|allow Y
|allow Z
|
|hwtimestamp eno0
|=20
|clientloglimit 134217728
|log measurements statistics tracking
|logdir /var/log/chrony

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmjD4hgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghJQD/wOlyr68b2d4rXNnVkz9MAXmxjW+Qf1
xqm6H5xo4ezq7+nNCd1HbOVpsghEFimenmYc0PTXlwhN3WAghahQvW2Hn0h9F649
2nS+vrVMTxKMvsY6NprHmku+QMUsuHdZ87pqXBPlvIwRUkK0+xkymYLKcWbutHoH
vnU9ij7jm3+tuWs6ofC3tlEmInOuGhaxiXlqModNsp0utJWDngNq2daFnBvcY1b/
vcVRAzSUizJIlEewj5SiwvpVrR3GWeu1g/7pOWeSGn4rEdJ9H7P0Hwpj4/2ivx/9
Gl5jFl/+R5yPwAPwPqle5tIy2e5fSOCLCDLswI0m5bHXDkOqjQqMB20Qwc+D3G1m
Y54x26hdy2TYLX+85mcCR/wsR2CczAjXrK5SNBh+MTK1T9qY1lA6rI05j75Zl555
xej9MEHpkCbrl2ZGFT7p6+mrCNhyN5XevGqcGxFUeNxD0kwu7FPs2tLXV4qHtHid
sjmcqem363FZg9qwzflkHv4VVDDDE2iVbfEA7Mm5qRTTONJNM7LYT+37HseT4orG
YPeZGZeauOb6Htg6ZHB3XOefKlWwAESDj1rkmD/X0BammaKI44r1QISnXcH4AF7g
jDblw+ACA+jOXSRss3AEl9ikH2ngjHK3245gH9USkfzbPHOQlMjpdPgJwKjBFoRj
HRBPt6CSq1i0Tg==
=6fDY
-----END PGP SIGNATURE-----
--=-=-=--

