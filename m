Return-Path: <netdev+bounces-115624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4A947457
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790EF1C2083A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 04:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0355887;
	Mon,  5 Aug 2024 04:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49C182B9
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722831811; cv=none; b=S+Ck5IfySFJ8tqqtN4R9xYruxLILC9FapulavZyLlbNPugaf4aOXC8O58NQKeEizAy6VtFcYF/Um/v7X4ebWF94veMKHoxhpch8c7fKj2VOWG0QA8jo+ADevkqvhj+G43ycHSY9b2v70tstCprCzaoMiUXkhjMrYZBwIFN60fTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722831811; c=relaxed/simple;
	bh=L4N7Za8LAVjLIALEdhfAr4yY/JISwzdm6eIfuemVCJA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=tcs05AV3HFh37E9tnK07Ttt+8EHU/gPqsXESKddHJnItMpy4pC02dz39B/VTKHkNHHA4cxc3yttO9hm+INm1fLuzohH8vwr4m1XwvERkszh6PaSe+AA8G0r2SV207jj5Ly5skMZEtdehVI2jCZOMICM1EBDj7spIthYmhIqw8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0907C7D06C;
	Mon,  5 Aug 2024 04:23:28 +0000 (UTC)
References: <20240804203346.3654426-1-chopps@chopps.org>
 <20240804203346.3654426-11-chopps@chopps.org> <Zq__9Z4ckXNdR-Ec@hog>
 <m2a5hr7iek.fsf@ja-home.int.chopps.org>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
  Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 Christian  Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v8 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Date: Mon, 05 Aug 2024 00:19:02 -0400
In-reply-to: <m2a5hr7iek.fsf@ja-home.int.chopps.org>
Message-ID: <m2cymnpphe.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Christian Hopps <chopps@chopps.org> writes:

> Sabrina Dubroca <sd@queasysnail.net> writes:

>>> +	/* The opportunity for HW offload has ended */
>>> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>>> +		err = skb_checksum_help(skb);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>> +	/* We've split these up before queuing */
>>> +	BUG_ON(skb_is_gso(skb));
>>
>> As I've said previously, I don't think that's a valid reason to
>> crash. BUG_ON should be used very rarely:
>>
>> https://elixir.bootlin.com/linux/v6.10/source/Documentation/process/coding-style.rst#L1230
>>
>> Dropping a bogus packet is an easy way to recover from this situation,
>> so we should not crash here (and probably in all of IPTFS).
>
> This is basically following a style of coding that aims to simplify overall code
> by eliminating multiple checks for the same condition over and over in code. It
> does this by arranging for a single variant at the beginning of an operation and
> then counting on that from then on in the code. Asserts are the way to document
> this, if no assert then nothing b/c using a conditional is exactly against the
> design principle.
>
> An existing example of this in the kernel is `assert_spin_locked()`.
>
> Anyway, I will just remove it if this is going to block adoption of the patch.

Actually, I'll just convert all BUG_ON() to WARN_ON().

Thanks,
Chris.

> Thanks,
> Chris.


