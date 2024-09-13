Return-Path: <netdev+bounces-128098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D22977FD1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CDAB22473
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D571D88B9;
	Fri, 13 Sep 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="UhfkQGJR";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="K2N+lAZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037581C2BF
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230436; cv=pass; b=Rya+lhCJ/wSrPM3ygN4Suk0UzJ4oVoVTED+kP6Lvl4e+2Ak4xtGTeLezl+XYEPNrsgvY8DCUMZUuviBH4g92ijsF93rEcBlfpWpKSJF9sCWeLRUOhOfij5qMWj6cDBB1GLNKbf8sv9fP2dfWIYdOCqJeF/y2LVjKBocX9uti4VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230436; c=relaxed/simple;
	bh=2fDyMQytha2ue3drbGxibSCgkKBWBVF/miUsbdFVdus=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ax/fBZAnI8joKFEwLwAdp+OpLW3ij8soI65rt0V+KJUfHlkuZEkok1nIEMNIVTEae9R4auL9VNJiJIsSW3QTCwAEqwzDbUEOQepdcqdFHhHCpE722oIdxa2UwiURY88BZpVyYIPOmNFFc5cjzH+qoWa4VPWIBg8HRf6sl+TCQzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=UhfkQGJR; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=K2N+lAZ2; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id C4E193AB28E;
	Fri, 13 Sep 2024 11:57:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org C4E193AB28E
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1726228627; cv=none; b=UKDtIBksG3d+13XGeYrTxcb0xeAHbwRrf6pg5ubS+acqT3tB2D2OYeKpijvl9SR/sENByFawgt8gwatdz61aKCcFVVVs8R0n16olE3Qsp2rbRLJbTmiYIoyQCD2Ne2A6VL/R4E2Mnsrgr1l8rboYQvqpDvnFYhL3BMXU5XoMV28=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1726228627;
	c=relaxed/relaxed; bh=2fDyMQytha2ue3drbGxibSCgkKBWBVF/miUsbdFVdus=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:From:
	 Subject:To; b=epsb+yO48FJsRurDc+nWUiM3vhQprkBjbAdhzPdQfIzVy4RqrO8VV0oZPBSEI26+KA9OfpcaRXy4pzfcdBmOVijc2NgFzUWOvdj9atxKogon/q7fHYX3AWc0lviycqB7qA5XPZGUigLH1ZT/o0v6bDB61xfsbL0iw9qYoY6o8WY=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org C4E193AB28E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1726228627; bh=2fDyMQytha2ue3drbGxibSCgkKBWBVF/miUsbdFVdus=;
	h=Date:From:Subject:To:Cc;
	b=UhfkQGJRR0QRTNOyDtgZZ6UrjP9ILow8NXaV4710owK44QiOPRtSkJuyvYUCLEU4N
	 JRmVS1qPZTjscDg9gLfJhjaYI6Rn0g1Xjq6xJo2nDkHHHRtLRIbzFl0IklK+97qq6Q
	 NLXxgrONH71NmQ53jXmLhHxmIms09hABTHfCHZL4=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id C001712E9E07;
	Fri, 13 Sep 2024 11:57:07 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id 97F8912E9E37;
	Fri, 13 Sep 2024 11:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org 97F8912E9E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1726228627;
	bh=2fDyMQytha2ue3drbGxibSCgkKBWBVF/miUsbdFVdus=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=K2N+lAZ2c0+zKIax4uEWm9Ok74XmIB/N5Ogj+qYoCRPoKuieH/bdH5araJUdujWQJ
	 NSMR0JHbA8qQoXo1jdTsAhEvAPY0i8WBjoVy6/emK52OoMpauuhn3M6cyl4KdsOroF
	 4kW7iicXWAdWVs7yxtv2EW+heD8zkR9z+T9yfRqk=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id MPJxRAlbsLIm; Fri, 13 Sep 2024 11:57:07 +0000 (UTC)
Received: from [192.168.0.197] (ip-86-49-238-91.bb.vodafone.cz [86.49.238.91])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 0398712E9E07;
	Fri, 13 Sep 2024 11:57:06 +0000 (UTC)
Message-ID: <accaf70a-be01-4de9-9577-196ef5b06109@isc.org>
Date: Fri, 13 Sep 2024 13:57:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Content-Language: en-US
Subject: [RFC] Socket Pressure Stall Information / ephemeral port range
 depletion info
Autocrypt: addr=pspacek@isc.org; keydata=
 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
To: netdev@vger.kernel.org
Cc: Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

This RFC relates to "LPC 2023: connect() - why you so slow?" [1] by=20
Frederick Lawler <fred@cloudflare.com>.

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
LPC quote
 > 50k egress unicast connections to a single destination=E2=80=A6 Who do=
es that?

Not only web proxies, it happens in large DNS server deployments too.

DNS setup on a single machine often involves multi-process=20
implementation (Knot Resolver) and/or proxies (e.g. BIND + dnsdist).=20
This makes 'keep track of ephemeral port usage inside application'=20
approach not viable.


Problems
=3D=3D=3D=3D=3D=3D=3D=3D
- Userspace has no visibility into port range usage ratio.
- Userspace can be blocked for an unknown amount time on bind() or=20
connect() when the port range has high utilization rate.
Miliseconds long blocking quoted on LPC slide 10 are observed in DNS=20
land as well.

Corollary: Hardcoded level of parallelism does not work well.

Over time it gets worse because port range is fixed size but number of=20
CPUs and processing speeds improve. Today a good userspace DNS=20
implementation can handle 130 k query/answer pairs per CPU core per=20
second. Measured on 64 a core system with no bind() mid-flight [3].


What can we do?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
What netdev masterminds suggest as a most tenable approach?

Couple ideas as a kick start:

A. Socket Pressure Stall Information
------------------------------------
Modeled after PSI present in kernel [2]. Cooperating processes can=20
detect contention and lower their level of (attempted) parallelism when=20
bind() becomes a bottleneck. PSI already has a notification mechanism=20
which is handy to applications.

An obvious problem:
Port range is per (address, protocol). Would one number be good enough?=20
Well, the same applies to I/O which is currently also summarized into a=20
single PSI.


B. Expose state of port range
-----------------------------
Expose number of free ports within net.ipv4.ip_local_port_range for each=20
(address, protocol) tuple.

As an application developer I would like that if access to the counter=20
is damn cheap. But maybe the accuracy is not worth the complexity?


C. Non-blocking bind()
----------------------
My head is about to explode. I doubt it be worth the overhead for=20
typical situation without contention.


D. Your idea here
-----------------
Any other ideas how to tackle this?


Thank you for your time!

[1]=20
https://lpc.events/event/17/contributions/1593/attachments/1208/2472/lpc-=
2023-connect-why-you-so-slow.pdf
[2] https://www.kernel.org/doc/html/latest/accounting/psi.html
[3] https://www.knot-dns.cz/benchmark/

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium

