Return-Path: <netdev+bounces-128940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CE97C849
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F042B21735
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAB19A28B;
	Thu, 19 Sep 2024 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="PxnIS8JW";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="N5qnfdKo"
X-Original-To: netdev@vger.kernel.org
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F51865C
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726743770; cv=pass; b=g29iyhCgVAHR3UhsAa9KupFr4upUh4vxMFVikot5Iy3Te6ySO0ArKJEH9VKJGGL7sS9eZ8HU/MYzyxKiUruRtf+r8OrUP78qcadU74lduJE5ZbunjiK89HfIrkifuRtmq6Qw771PpB0sj//nIf+a/9HNPdfGm9krroincF34VXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726743770; c=relaxed/simple;
	bh=myeevUN6sy5Ec7afnATymoDP/h6rQMzNqY5asuzknGA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ugySAx1+SUrMCCofmwq+uWOSHAEKWR25oFS4Fm8NzV9MN2+knu8yPUsusciWbEOkCFiP6oN5ejTz6ACg2vJLe8W/ppesGhATajJYnWTH+dkwu+Je5QrYK9HiVTNkSK7vZZ1A8DJ4m4+swmnCg/kcwwTHMZz1EXLUz6i/gIGVPJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=PxnIS8JW; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=N5qnfdKo; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id DEB733AB28C;
	Thu, 19 Sep 2024 11:02:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org DEB733AB28C
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1726743758; cv=none; b=J/Q0S24TUAoRwf6WOWr7mu0PvIjdGKOoH1JWNZ/+CvJY+hqLmzpmNfecF0vn8BkqMSXczgsa1uMoQ7YOjcxpIMWfMnzwrG1YW5WV/BJI7baUcicwpV2cpxwezkMUbbh5TQDqvw/VN5bvO+f6dIqGBLmdVL/OY3aswkuJdIqRwzM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1726743758;
	c=relaxed/relaxed; bh=y2DESCTd1rfiv2vgF7j+831fdfynaIdAcDP7fMxe5RI=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 Subject:From:To; b=lh78Fj7uyjbxEAPQlLTHPT1m/9I6och6Y/T4ORymL3BQfVbot9giM4PDIS4R5LGJJq0A0cqqFPxKHFNfJrVhStxLszkxTPRiT9EktifTt2fZxq/eqeFMa38Wy3MQst894KB5c3LQH60ZJ2w4W/ykTQoGhQ3TFozciX6T9CMzPvE=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org DEB733AB28C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1726743758; bh=myeevUN6sy5Ec7afnATymoDP/h6rQMzNqY5asuzknGA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=PxnIS8JWVEffq8pxk/jr5DZO6W2ra0IkCwI7OpPNh9N6zKQjDpSkmSCtb8uNxQIMr
	 n5cIVMl/SlL0yHIw98aFF6P30otBujeNmM3o1i2ViKhGTdtcKwFNSGzE9L3ibqGEwg
	 wt15Ivaw7ymFqmaF8pVoso35Ux66NkpcxJuL5MhA=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id DA2721300D57;
	Thu, 19 Sep 2024 11:02:38 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id B82251300F43;
	Thu, 19 Sep 2024 11:02:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org B82251300F43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1726743758;
	bh=y2DESCTd1rfiv2vgF7j+831fdfynaIdAcDP7fMxe5RI=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=N5qnfdKoQWSKnQGkNH4+WOCVbO5JhmzqAjJvMDlLh3It9zoPKZoZKkVAfDOVOrgja
	 W0N/r+n9pzPi1S9Hj9ov7yzkV3SIbQFvQ2uub9Fdg/eRDcfuuupBXFx+BhQb+GNAFw
	 x3LXnkujIGBJERV6e2T9sYtn3nUyZ60FMwY7B5FQ=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id zHngrvQJl4f8; Thu, 19 Sep 2024 11:02:38 +0000 (UTC)
Received: from [10.134.2.187] (unknown [83.68.141.146])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 0EDB81300D57;
	Thu, 19 Sep 2024 11:02:37 +0000 (UTC)
Message-ID: <27090b7a-ab98-49b5-b612-f0d8471228f4@isc.org>
Date: Thu, 19 Sep 2024 13:02:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Socket Pressure Stall Information / ephemeral port range
 depletion info
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
To: netdev@vger.kernel.org
Cc: Frederick Lawler <fred@cloudflare.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <accaf70a-be01-4de9-9577-196ef5b06109@isc.org>
Content-Language: en-US
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <accaf70a-be01-4de9-9577-196ef5b06109@isc.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 13. 09. 24 13:57, Petr =C5=A0pa=C4=8Dek wrote:
> This RFC relates to "LPC 2023: connect() - why you so slow?" [1] by=20
> Frederick Lawler <fred@cloudflare.com>.
...

> Problems
> =3D=3D=3D=3D=3D=3D=3D=3D
> - Userspace has no visibility into port range usage ratio.
> - Userspace can be blocked for an unknown amount time on bind() or=20
> connect() when the port range has high utilization rate.
> Miliseconds long blocking quoted on LPC slide 10 are observed in DNS=20
> land as well.
>=20
> Corollary: Hardcoded level of parallelism does not work well.
>=20
> Over time it gets worse because port range is fixed size but number of=20
> CPUs and processing speeds improve. Today a good userspace DNS=20
> implementation can handle 130 k query/answer pairs per CPU core per=20
> second. Measured on 64 a core system with no bind() mid-flight [3].
This is an answer to LPC in-person request to clarify. Here's an DNS=20
example with real numbers rounded:

- Assume DNS query-answer rate ~ 100 k / sec / CPU core
- Assume DNS resolver with cache hit rate ~ 95 %
- Assume DNS cache hit costs nothing to process
- Cache miss requires communication over network on a random port =3D>=20
bind(0) is needed, possibly for UDP followed by TCP connect()
- Cache miss processing must not block event loop / cache hit answers

This gives us CPU time budget of
1 sec / (100 000 requests * 5 % cache miss)
=3D 0.2 ms per single cache miss request.

This works fine on a system which has enough source ports. Trouble=20
starts when port range has high utilization.

"perf trace --summary" from a system suffering port range depletion:

syscall  calls  errors  total     min     avg     max   stddev
                         (msec)  (msec)  (msec)  (msec)    (%)
------- ------  ------ -------- ------- ------- ------- ------
bind      6301      0  6753.553   0.000   1.072   9.031  2.12%


With 1 ms average we are 5x over the CPU time budget and overall system=20
throughput goes down the toilet. bind() blocks the event loop and,=20
depending on resolver architecture, can block processing cache hits as we=
ll.

If the resolver knew that port range is depleted it could refuse to=20
process requests which resulted in cache miss and thus not waste CPU=20
cycles on vain bind() attempts, keeping throughput for cache hits.

In other words, it's about going from constant value for number of=20
requests processed in parallel to a dynamic behavior / auto-tuning=20
depending on workload.


A different DNS use-case, DNS zone transfers between authoritative DNS=20
servers, can suffer from the same problem as well as involves lots of=20
short lived TCP transactions.

I'm happy to supply more details as needed.

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium

