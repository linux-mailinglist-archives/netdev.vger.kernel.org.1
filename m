Return-Path: <netdev+bounces-86793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1C8A0522
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5325281DD5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C679C8C7;
	Thu, 11 Apr 2024 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="Am8pkuFi"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFA13FFC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797122; cv=none; b=sCCBiM5zBrJUVKHosZqvPjL/lRHpyg5OnVPW+0mMFqooBrfHAipTmrpm4n1JxxFmaDmGQqZ7W8BHkg+jjzKZtxr8g/b8hPTndb1stKg793U/uFClg+Tdg+UIzq1VLvcUkX2XlktpyPUpfRPiLzMYvSBDv0Lb9eXqIUXw/sJA1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797122; c=relaxed/simple;
	bh=c/j9B9YLQ3rCMpEfNfKQFRABc7uGlF8/SoausrYlL5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OljEGIx+8rviYWari/OBa7xZQfrf2vO5ARFaJCtcLCPS/8Fr7ybjQgJFsl8KhlOVq7pccdghmfGOfKzTp9zKOZO9YVB/QyUhQ1NToMuO4mjde1xOd2BS6NJCVUCY4Rltux4f9lOYODozpliZzUUDaKnqV5MdmFzVrtSaTmzUCdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca; spf=fail smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=Am8pkuFi; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4VFLt36FMZzCgX;
	Thu, 11 Apr 2024 02:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1712797115;
	bh=c/j9B9YLQ3rCMpEfNfKQFRABc7uGlF8/SoausrYlL5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Am8pkuFiN2+d1IeCWl6jAhQVSOpRNtcb+SZDW2aVb5ymJaoWkbI3PwN7djykGuPfi
	 3yEfSD25LoBpAdwP4rFzmRmpR2E5RR6iuHTzIV6eACoDXAnrtPcs6DkHTR+6QCsb2i
	 FBr9OK+VhRV5t+DU60qRXcIuSCqMlw9Jz0sZMUHs=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 0.566
X-Spam-Level:
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id 36z6iagUoZop; Thu, 11 Apr 2024 02:58:34 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 02:58:34 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id 11AAC11BE300; Wed, 10 Apr 2024 20:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id 0DB1511BE2FF;
	Wed, 10 Apr 2024 20:58:33 -0400 (EDT)
Date: Wed, 10 Apr 2024 20:58:33 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Antony Antony <antony@phenome.org>
cc: Sabrina Dubroca <sd@queasysnail.net>, 
    Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
    Antony Antony <antony.antony@secunet.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
    devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
In-Reply-To: <ZhbFVGc8p9u0xQcv@Antony2201.local>
Message-ID: <81b4f75c-5c43-8357-55ad-0ec28291d399@nohats.ca>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com> <ZhBzcMrpBCNXXVBV@hog> <ZhJX-Rn50RxteJam@Antony2201.local> <ZhPq542VY18zl6z3@hog> <ZhV5eG2pkrsX0uIV@Antony2201.local> <ZhZUQoOuvNz8RVg8@hog>
 <ZhbFVGc8p9u0xQcv@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Apr 2024, Antony Antony via Devel wrote:

>>>>> And for ESN 1?
>>>>
>>>> Why 1 and not 0?
>>>
>>> Current implemenation does not allow 0.
>>
>> So we have to pass a replay window even if we know the SA is for
>> output? That's pretty bad.
>
> we can default to 1 with ESN and when no replay-window is specified.
>
>>> Though supporting 0 is higly desired
>>> feature and probably a hard to implement feature in xfrm code.
>>
>> Why would it be hard for outgoing SAs? The replay window should never
>> be used on those. And xfrm_replay_check_esn and xfrm_replay_check_bmp
>> already have checks for 0-sized replay window.
>
> That information comes from hall way talks with Steffen. I can't explain
> it:) May be he can elaborate why 0 is not allowed with ESN.

With ESN, you use a 64 bit number but only send a 32 bit number over the
wire. So you need to "track" the parts not being sent to do the proper
packet authentication that uses the full 64bit number. The
authentication bit is needed for encrypting and decrypting, so on both
the incoming and outgoing SA.

AFAIK, this 64 bit number tracking is done using the replay-window code.
That is why replay-window cannot be 0 when ESN is enabled in either
direction of the SA.

I have already poked Steffen it would be good to decouple ESN code from
replay-window code, as often people want to benchmark highspeed links
by disabling replay protection completely, but then they are also
unwittingly disabling ESN and causing needing a rekey ever 2 minutes
or so on a modern 100gbps ipsec link.

> strongSwan sets ESN and replay-window 1 on "out" SA.

It has to set a replay-window of non-zero or else ESN won't work.
It is not related to migration AFAIK.

> For instance, there isn't a validation for unused XFRMA_SA_EXTRA_FLAGS in
> DELSA; if set, it's simply ignored. Similarly, if XFRMA_SA_DIR were set in
> DELSA, it would also be disregarded. Attempting to introduce validations for
> DELSA and other methods seems like an extensive cleanup task. Do we consider
> this level of validation within the scope of our current patch? It feels
> like we are going too far.

Is there a way where rate limited logging can be introduced, so that
userlands will clean up their use and after a few years change the API
to not allow setting bogus values?

Paul

