Return-Path: <netdev+bounces-193771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3716AC5DED
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672DD3BB676
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A738218ADE;
	Tue, 27 May 2025 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uni-paderborn.de header.i=@uni-paderborn.de header.b="EhO4lNuz"
X-Original-To: netdev@vger.kernel.org
Received: from collins.uni-paderborn.de (collins.uni-paderborn.de [131.234.189.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4F136347;
	Tue, 27 May 2025 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.234.189.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390233; cv=none; b=PU/M6EMcvRM79YEiU+tHGh+mpywzpq4YgnFBmdUuElfQeCinnjQqO21fvIJ9qQaOcujcaGTdcRIQ9z+7+O2aEJWjP2vkHiNPK29Q8jSMICQkVLsZNpjMtK1lCYMUi4mY31cMFTX9nBforTd12e4rWhQO9UkTsy7C6GNbYdw7tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390233; c=relaxed/simple;
	bh=ZUdQt8YUVALIAqMoPfALlwyKIw3UpPZQqcPVLIa5wOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mdl171EAdi+vPQGuWMY2PNjTm9XUL0SUStOvrPhR8jHuo0jNqzZxYIUeIzwR4lNdqbbOQI1r0E6NVCEDNhz0eln3mTdp3qrsGhbrjH3va0ZJPXcRhuz9Yt9Y9AGgucWjylcd0QyiaHB8/9SQVLr8HCuwTz5Tu8VRyj77xMZV1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.uni-paderborn.de; spf=pass smtp.mailfrom=mail.uni-paderborn.de; dkim=pass (1024-bit key) header.d=uni-paderborn.de header.i=@uni-paderborn.de header.b=EhO4lNuz; arc=none smtp.client-ip=131.234.189.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.uni-paderborn.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pqHwz0Yoroh0bzMAo75DrYnG8a29XVtEnbOq8H9QAYI=; b=EhO4lNuzmzi8wzGx9y2ATGF2lB
	tXJeNOQzAFly1tpAD6moRr08YI5VsBURkfgFreTbzSXn8miTG5gk4tpk5Rt8HMKu01G+Fr1xz83em
	sRJeGY3bjS5E4FKIM1iq7A4531gsfgbCbouGOx/Cnf3PZOxGPod0UVSzKO4l/8pzikfM=;
Message-ID: <7a32cbad-ea81-49a1-970d-faa731a6041e@mail.uni-paderborn.de>
Date: Wed, 28 May 2025 01:40:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with delayed segments despite TCP_NODELAY
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, netfilter@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>
References: <1dbe0f24-1076-4e91-b2c2-765a0e28b017@mail.uni-paderborn.de>
 <CADVnQykQ+NGdONiK6AwL9CN=nj-8C6rwS4dtf-6p1f+JFyVqug@mail.gmail.com>
Content-Language: de-DE, en-GB-large
From: Dennis Baurichter <dennisba@mail.uni-paderborn.de>
In-Reply-To: <CADVnQykQ+NGdONiK6AwL9CN=nj-8C6rwS4dtf-6p1f+JFyVqug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IMT-Source: Extern
X-IMT-rspamd-score: -19
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00), FROM_EQ_ENVFROM(0.00), BAYES_HAM(-1.85), TO_MATCH_ENVRCPT_ALL(0.00), MIME_GOOD(-0.10), NEURAL_HAM(0.00), MID_RHS_MATCH_FROM(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00), RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), TO_DN_SOME(0.00), RCPT_COUNT_THREE(0.00), Message-ID: 7a32cbad-ea81-49a1-970d-faa731a6041e@mail.uni-paderborn.de
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=dennisba,ou=People,o=upb,c=de

Hi neal,

Am 26.05.25 um 15:50 schrieb Neal Cardwell:
>> We would very much appreciate it if someone could help us on the
>> following questions:
>> - Why are the remaining segments not send out immediately, despite
>> TCP_NODELAY?
>> - Is there a way to change this?
>> - If not, do you have better workarounds than injecting a fake ACK
>> pretending to come "from the server" via a raw socket?
>>     Actually, we haven't tried this yet, but probably will soon.
> 
> Sounds like you are probably seeing the effects of TCP Small Queues
> (TSQ) limiting the number of skbs queued in various layers of the
> sending machine. See tcp_small_queue_check() for details.

thank you so much! I compiled v6.15 with a tcp_small_queue_check() that 
I patched to always return false and things just worked (again)! Now I 
wrote a small module using kretprobe and regs_set_return_value() to 
allow us to apply this change a bit more selectively (and without 
recompiling the entire kernel). That's probably not optimal for anything 
that should be widely deployed, but since we are currently just 
experimenting and don't even know what might be actually used later on, 
it seems good enough for now.

> Probably with shorter RTTs the incoming ACKs clear skbs from the rtx
> queue, and thus the tcp_small_queue_check() call to
> tcp_rtx_queue_empty_or_single_skb(sk) returns true and
> tcp_small_queue_check() returns false, enabling transmissions.

Honestly, I still don't quite understand why this works the way it does. 
We intercept all outgoing (initial) payload segments before we NF_ACCEPT 
any of them (i.e., collect all first, then release), so after the 
handshake itself there shouldn't be any skb clearing triggered by new 
ACKs from our server... Oh well. In any case, it does work, and I'm 
happy with that.

Thanks again,
Dennis

