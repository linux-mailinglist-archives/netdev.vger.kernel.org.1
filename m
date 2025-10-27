Return-Path: <netdev+bounces-233258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AF2C0F996
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3AC461192
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0033164CD;
	Mon, 27 Oct 2025 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="Qn68k6sL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835493164BB
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585293; cv=none; b=h1qpJm7iblnerp3TeASPa4hrwQ42z/MBtUreXaSpeIIK0oROroE790pj9VuWwFfs0xpuc4A5Bf9btd8q4Mxpf+f3AcQZ197nNiJ/kion0qvUdoRlRhl+Su85BvdnTQtzZXYBTPMYgof49At1qpIA6TpZ4aikxQR08jtrZ20lhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585293; c=relaxed/simple;
	bh=Px/+m+lGlk/4qwzYi4W+xpw2LPCFvnggAQNLQPbXnBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Icm7j4N+QGolLPxTE0OSzaSoPi8MxpvJ0Q5wlGLRrCeqfGwf+7esWhPasrDNs+coARxnVUv5wtSNMlMmRV2861i8VYfcmI5G2dzp4dWBKVY6O0OKRt6wrDEnrBd5n4yY8n4ItillMJAZSydxEZIabodmsdWGg5vd9ktgvY/Za/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca; spf=pass smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=Qn68k6sL; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4cwKr31Fkkz38B;
	Mon, 27 Oct 2025 18:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1761585283;
	bh=CIzzzY56/bSFvbgnHMd+JRK6/Vmz9ty2l6pc0sHwssU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Qn68k6sLK+55AwCC+Jks+hu+epr1kr6nJ8qmvWvS9633t1obhyqX9fM60dHGpjiSA
	 nKUzAy2ZcjvAvevtoMqf/jwsy2iYDe13vz+1G4HsEtb1Tf/vRwCxWtlr2ISIRrURJq
	 Yc32APR7D+1upiWMNbzoymDOH9U5Fz7B9Fna5Js8=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 1.206
X-Spam-Level: *
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id eB9CGxJQaPRc; Mon, 27 Oct 2025 18:14:42 +0100 (CET)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 18:14:42 +0100 (CET)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 4BE09177FF41; Mon, 27 Oct 2025 13:14:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 4883B177FF40;
	Mon, 27 Oct 2025 13:14:41 -0400 (EDT)
Date: Mon, 27 Oct 2025 13:14:41 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Sabrina Dubroca <sd@queasysnail.net>
cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
    devel@linux-ipsec.org
Subject: Re: [devel-ipsec] Re: [PATCH RFC ipsec-next] esp: Consolidate esp4
 and esp6.
In-Reply-To: <aP-jXvmys9D37Hp6@krikkit>
Message-ID: <6ceb36e2-383b-b30f-bc99-a95dff5e7008@nohats.ca>
References: <aPhzm0lzMXGSpf22@secunet.com> <aP-jXvmys9D37Hp6@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Oct 2025, Sabrina Dubroca via Devel wrote:

>> +		/* XXX: perhaps add an extra
>> +		 * policy check here, to see
>> +		 * if we should allow or
>> +		 * reject a packet from a
>> +		 * different source
>> +		 * address/port.
>>  		 */
>
> Maybe we can get rid of those "XXX" comments? Unless you think the
> suggestion still makes sense. But the comments (here and in
> esp6_input_done2) have been here a long time and it doesn't seem to
> bother users.

The whole NAT-T mapping assumptions / rewriting are not RFC compliant
anyway, and need fixing. Similar to accepting encap/non-encap
with a single state. So I guess yes, this one comment on the whole issue
might as well get removed here.

Paul

