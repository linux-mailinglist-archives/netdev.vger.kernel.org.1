Return-Path: <netdev+bounces-207832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36094B08BA4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E09658576C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4F28D8F8;
	Thu, 17 Jul 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PccVvAbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDD145B27
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751291; cv=none; b=Ngd75SZAfyarx2fvSVR9kdq+TTA3fDKHFrFxzvNmNWNIcycGbT12HjFKRgRrsyC2q7iWy8RIvU9iHUi8tdGKSpDpQ1CIwxD7KPuhsbhzW3v+jz/1tsC/OIvFdDgyQtl2iKtj/oY4ARfEpTnJuLundwZVcCpvf/jFnVnI0p9PdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751291; c=relaxed/simple;
	bh=yce9Tv2qC5Lz8GYW5G1Pkcw/EVDTDGEGs/HV9kXUJv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ak77nsUG3NLtCsdUWlTnf4Z3Io82avIEhZH8kiTEGj2EQmSgpzfOid8uspOl1ZOcb/FLZ2U4jQfYgJBrjA+11byO/0MPI7cBZVPOd/B1iaC+SVr5AgtJV4jFfw8nQDdBHz88Iq2EO34mZVmWnQJA/zy7ImwC6yhX1Urt7p3zqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PccVvAbz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1685483a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752751288; x=1753356088; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZYyI6QiKM293rZOzyhMZk4XJt0FqeuxrWWfI/g5n1I=;
        b=PccVvAbzzsng2f4nve+E3Dxjy+cZ+yvjx28qkc7L5/w79g2XhBOVc9Kb0xIcrmGmW2
         fSSJeXwZl5JhgNSGWnDJqjYhBtMz051BIEaUMEa59VTvw/QehQuzt32g0zxqWlqWxy+x
         YF2BCUCya9X+4sIGNiH9VjHhLpfcQG8yxVayurn1FtJDmqNCRJkOR8pZ0v1QC2T6pLVs
         /wBAKiF53j5MT0X1alRYCP3T1qgG76GMJSCyOMkTkClZTN///CUUK4FC1IYvaNvrph72
         W2Dfzo72WrgHerHSstgNtzfADhdYjPKtG/kRlnyjP+QR3WK7KqGnND5NhxK5yb0s2chn
         90fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751288; x=1753356088;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZYyI6QiKM293rZOzyhMZk4XJt0FqeuxrWWfI/g5n1I=;
        b=FRFklPhbwO9UkiOsqBmjIV0C0uSMXjQhBJifwhDAIrIMPXW6DpKIS3ShMz78ev1iEs
         MMilUoyzatU+ON523QAaQE48CapVyjHQ0U+WdzJX54dtiq6GvTyHg5FZU7f2CSR9GDTY
         zsTXmFJ6KY36q6sZotCLzWcR+pCyvaeBklooPJKsQChbhkSr2BvRe6ukvDefrtoufJLs
         qbE9KqlxK95S5ldZgfg4LLOQ8uSTY7sQAb46JFOd2aMUqtacnQEojp3GB50BlYvca0rU
         sVCtBQdcIb32I/7xl5S97Zw7kSnWjbfqPrns7IcGRknUp2jc7WkBj6Md1omERQf693xn
         xySw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqvzX9U3Dmb8v7XKoLdrO21K27GhVsa/3+JbqUlRrOKAp88rDX2OsEnLNUUmRqMCDqKH/QS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDRXQ/uc480O3z9GVWz08qSTS4to6li/ATK7GslrQ/FVnSihqN
	LCayIAEbcvlrYTBu7+wHKJk2zOtpS/eEIeoXeDFjwt0wrXd1uBIXLpTqqvULpuiAXr8=
X-Gm-Gg: ASbGncuBu0p55+13iZa16WdBzlKG3epnx/cvNNnYobbTTfitiiryu0ZZG5b2CBa6rN1
	Qcy6HDkzOh5vKZdeh9b6mqjdzCqOSAyIvkCoSyYhkF9fT1kqb3OU7XXaFtTkEVrAA1NlInKAE+e
	kDssKJSoV33+rua36Z1WvcFzq2pQ772Y2ah7oJkDyb2XwaMFgonMYdckBNq+BScSUSRiqlGQitm
	k+TZnOdFVrPtsxlnqxF1UgOCWsOq4KGZ0/1jT2OiLIWFhiQYXoN3rJvEQ1AZAt1lEEoEMm1uxSp
	+9dgB/hEc1J1+FSXCDxzSh/tut7z+/kwrCrmkb5lrbH4gWJEe84t1NPtxSzR+3zUgCklvQXIgPt
	cKt0pNWOWZzV6Crk=
X-Google-Smtp-Source: AGHT+IGVnANx8nLfm/8Y12a9myx+ZNBG7W+NCDHR5ll6pD2Ki1nT/qqtObhiE/yuAntTogF0ndLVbw==
X-Received: by 2002:a05:6402:27c9:b0:612:a507:5b23 with SMTP id 4fb4d7f45d1cf-612a5075deemr2294587a12.11.1752751287927;
        Thu, 17 Jul 2025 04:21:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f2c0fsm9893900a12.15.2025.07.17.04.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:21:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Lee Valentine
 <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v3 2/3] tcp: Consider every port when
 connecting with IP_LOCAL_PORT_RANGE
In-Reply-To: <87qzyfdue6.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Thu, 17 Jul 2025 11:44:01 +0200")
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
	<20250714-connect-port-search-harder-v3-2-b1a41f249865@cloudflare.com>
	<00911a84-c4e3-452e-ab51-1275a43ca4b2@redhat.com>
	<87qzyfdue6.fsf@cloudflare.com>
Date: Thu, 17 Jul 2025 13:21:24 +0200
Message-ID: <87ecufdpvv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 11:44 AM +02, Jakub Sitnicki wrote:
> On Thu, Jul 17, 2025 at 11:23 AM +02, Paolo Abeni wrote:
>> On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
>>> Solution
>>> --------
>>> 
>>> If there is no IP address conflict with any socket bound to a given local
>>> port, then from the protocol's perspective, the port can be safely shared.
>>> 
>>> With that in mind, modify the port search during connect(), that is
>>> __inet_hash_connect, to consider all bind buckets (ports) when looking for
>>> a local port for egress.
>>> 
>>> To achieve this, add an extra walk over bhash2 buckets for the port to
>>> check for IP conflicts. The additional walk is not free, so perform it only
>>> once per port - during the second phase of conflict checking, when the
>>> bhash bucket is locked.
>>> 
>>> We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
>>> option is set. The rationale is that users are likely to care about using
>>> every possible local port only when they have deliberately constrained the
>>> ephemeral port range.
>>
>> I'm not a big fan of piggybacking additional semantic on existing
>> socketopt, have you considered a new one?
>
> That's a fair point. Though a dedicated sysctl seems more appropriate in
> this case. Akin to how we have ip_autobind_reuse to enable amore
> aggresive port sharing strategy on bind() side. How does that sound?

Thinking about this some more - if we're considering a dedicated sysctl
guard for this, perhaps this merits giving a shot to the more
comprehensive fix first.

That is to update the inet_bind_bucket state (fastreuse, fastreuseport)
on socket unbind to reflect the change in bucket owners. IOW, pivot to
one of the alternatives that I've highlighted:

| Alternatives
| ------------
| 
| * Update bind bucket state on port release
| 
| A valid solution to the described problem would also be to walk the bind
| bucket owners when releasing the port and recalculate the
| tb->{reuse,reuseport} state.
| 
| However, in comparison to the proposed solution, this alone would not allow
| sharing the local port with other sockets bound to non-conflicting IPs for
| as long as they exist.
| 
| Another downside is that we'd pay the extra cost on each unbind (more
| frequent) rather than only when connecting with IP_LOCAL_PORT_RANGE
| set (less frequent). Due to that we would also likely need to guard it
| behind a sysctl (see below).

Right now the inet_bind_bucket fastreuse{,port} state is being
mismanaged, IMO. This would be the fix for the actual root cause here.

