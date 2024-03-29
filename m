Return-Path: <netdev+bounces-83670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EE893489
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923A01C2083F
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBE15EFDC;
	Sun, 31 Mar 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMHcBIpi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E415ECF8;
	Sun, 31 Mar 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903428; cv=fail; b=QrvZ7I6zc6aZn7wFjMsAnd9RDxBa9qWCel9i6jhAlifvRISuhHQZ8MJR0T2SCb3AA9J00zXCceu0d3FixEo35J4ojNXxlWpPB5dbZi7P43YbsKvuIrls5fVIdkBq978qCnJnJs8Hj/dKAbkwJlnSmJMdcf2qX+w6pQ+o5g11IdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903428; c=relaxed/simple;
	bh=n9ue4b+CLeSy3xniNZBgvVGoSRklTdku8x0GvEfzXN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYFCMdivAwa0qbAiZBWE4UPjFaxOW2+KRCyqsmmu8pT+STR6j+fggujpUzepv3LdPnXjmi+n8uKluAGop1TW1UGRLGg0H74tkzgA/1hgKh+vi3KRRcMn8IpXYaPMVnDm9XmQKKYcdmxnx5lgpBkTcpWiqUmmgyLDLyG+0jeqQ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com; spf=fail smtp.mailfrom=paul-moore.com; dkim=fail (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMHcBIpi reason="signature verification failed"; arc=none smtp.client-ip=209.85.128.180; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=paul-moore.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1AE74208C7;
	Sun, 31 Mar 2024 18:43:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydTBWqV4i22A; Sun, 31 Mar 2024 18:43:41 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1F9A2208CC;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1F9A2208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 12F29800060;
	Sun, 31 Mar 2024 18:43:40 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:39 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <linux-security-module+bounces-2442-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAfEemlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAH4AAADMigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16793
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-security-module+bounces-2442-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 91EC920892
X-Original-To: linux-security-module@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748060; cv=none; b=mwrYP5Sl5gEo8VwQ9675TUPRhxbdeENC6saBQ1WNpnkFeBDdw73YGHvA3/UnOh3MSw0SCs5o2v08Q3KU8S0YRpixqZ+3UaTMW+zkY58BlFIToOfopijgyhVbKxXCvvTbh03UpjeqGWrl1SMfmcTb43LmnpImoPj+HeXG8l0IZrw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748060; c=relaxed/simple;
	bh=50M3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ruri+lwjMit9Sj+eoFSht9sRrQG89SkT3ngKIGADe6VAScb84GT96+7bzfIvCG9AO/q15J83S73AuogHg9W8qdd8Sh5M/Wrlm1WDAh3WCAvGsFHhxPeC7kG8+wU8XcZvIPrQIZWyAGyWNUFYN6AY5eK71wH8LRq+l2EEIc3lZRw=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMHcBIpi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711748058; x=1712352858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=;
        b=YMHcBIpiXyp5v0KrwBJ0Y1s2XnC6BUh97Rt05RbaPDWnQ5yncJbRRQ4bpQ1DvCfFyb
         c087fMlQmqN7DDpRyLBIQqPdsJEiFsuSm2asxqRw4bTPYZs0UUSY9k3tVxa7RLZWr/+H
         +3mbQyr+4wOT8rytF947HQrMh4gAO/EygFRiXqiZvPUNfFGWYRppJUuzj5s1jPwRtPrs
         TrHnXhs6ZqmpBajfXab81hUulMHZOPuxSG2ThE+5NbKs6wfqPACS1RFY7Sl4Sl2OXji5
         T5XKNj2Hy69Q3VTwHuEer0avbRFYAP+/bZBNhSGfatQjGkwMXjxiw4LESd+IPURiJm6J
         6wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711748058; x=1712352858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=;
        b=wx9+QlV//2b+9jpi6EcXdjf0jLIQL5jRxN6NFmTSKxUp1fVvZC6VytCrZ9cbX7ekTW
         mBfXEuEaQjmRHOhXeIhSUEBx8Z4oNFg+llWsQytwykPt2OZNNfXTF7023S4KofPHvuiY
         Mox6THe7vFFSXT1tiAhjzkTwz94Juue6eaNQF7CagGPRrElnd8A+HRZjtsOLkb5kC2h1
         zX9rob121kIJMhsKud8ZzCffkG98prnuIp+RGBRRYzWiGyULxi1lNxBq4BQnEg/ss6py
         84B59lCvLzmJ5x1OMIgGV/cvmY9YDXYcdw6GQSY28x0t3z8KfrT9f0NtOEZbD2LR+IPj
         F8+Q==
X-Gm-Message-State: AOJu0Yw+IbE95Mgx6mj8MmFjk/sqTlmzbQdHDK+HDX62FOeXsHtM61eT
	6swnDG3np8AA8WYYctWb8Vp1EfcgOMo8oIW5GV+hGx+0pJh6wsGN4oKWZAidv8k8Oe6A3U43bFd
	ssAG2nM7+8tr+ruh3OMzIzuEEphSqpju7yTCL
X-Google-Smtp-Source: AGHT+IH9pj0gJOAEZqutXLhCgImC4M5PTgqiAEIOD8jNv+vPhXBfVScVMRmBh9ONVHsoONfJu6nKmSY/GEubTYGORdE=
X-Received: by 2002:a81:84cd:0:b0:609:3c37:a624 with SMTP id
 u196-20020a8184cd000000b006093c37a624mr3517304ywf.35.1711748058196; Fri, 29
 Mar 2024 14:34:18 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:34:07 -0400
Message-ID: <CAHC9VhR42y0BaUPB_BgW+8oadDc36xPJRzEqh9Mwqa1RaMMZXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Mar 27, 2024 at 8:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.

[Dropping Alexey Kodanev due to email problems]

This isn't something I would want to see backported to the various
stable trees, this is a consolidation and cleanup for future work, not
really a bugfix.  If an individual LSM is currently missing an address
sanity check that should be resolved with a targeted patch that can be
safely backported without affecting other LSMs.

Now, all that doesn't mean I don't think this is a good idea.
Assuming we can't get the network stack to validate addresses before
calling into these LSM hooks, I think this is an improvement over the
current approach.  I would like to see the patchset include individual
patches which do the desired adjustments to the Smack, TOMOYO,
AppArmor, Landlock, and SELinux code now that the sanity checks have
migrated to the LSM layer.  I expect that to be fairly
straightforward, but given all the corner cases I want to make sure
all the individual LSMs are okay with the changes.

> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

--=20
paul-moore.com

X-sender: <netdev+bounces-83465-steffen.klassert=3Dcunet.com@vger.kernel.or=
g>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Dc822;steffen.klassert@se=
cunet.com NOTIFY=3DVER; X-ExtendedProps=3DAVABYAAgAAAAUAFAARAPDFCS25BAlDktI=
I2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSX=
NSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAA=
AUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChG=
WURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwA=
XAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG=
1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHc=
m91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29u=
ZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAw=
AAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC=
5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAAB=
QBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1V=
c2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1J=
lc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb=
3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=0A=
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAfEemlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAIAAAADMigAABQBkAA8AAwAAAEh1Yg=3D=0A=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 16799
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:34:38 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:34:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 44D31208AC
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:34:38 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D.751 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_NONE=3D.0001,
	SPF_HELO_NONE=3D001, SPF_PASS=3D.001]
	autolearn=3Davailable autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmmA5N4cIheh for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:34:34 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=147=
.75.48.161; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83465-=
steffen.klassert=3Dcunet.com@vger.kernel.org; receiver=3Deffen.klassert@sec=
unet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 53A2720892
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 53A2720892
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28737B2130B
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5513BC02;
	Fri, 29 Mar 2024 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com header.i=3Daul-moore.com =
header.b=3DMHcBIpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.1=
28.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF51DFC4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.128.179
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711748061; cv=3Dne; b=3DAuqo04ElD606skfooNLm/UZkBKnID82OjkuXK7r/qpuGoXe=
9BUrYa0DaxnsXRxRTHV6y2x+rArTkYpXvwH7PctJDyt6j2TYdJFf7bsvlDm8TxCcCyxjvrDG7C9=
kZ0j3tsxirEUCzERxNCB9HqeseliUTavW6oXHxxWHoi7Cp0ARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711748061; c=3Dlaxed/simple;
	bhPM3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D2K8qmVZqwXtgmr0LI9fUb3Kl8RDqp13AQJ3SEeNG+70ERX+4b=
iYHe1KDkKdbuAWhhgyGdjekI+m/mSUxuyAn3ELn1IZnSUYIlliBepO387THtDsmUygDx4n6Btf5=
wYOCkqu6pX47jf7TB/8xMPeG4Vo137SLT8XlIecbRVp0kARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dul=
-moore.com; spf=3Dss smtp.mailfrom=3Dul-moore.com; dkim=3Dss (2048-bit key)=
 header.d=3Dul-moore.com header.i=3Daul-moore.com header.b=3DHcBIpi; arc=3D=
ne smtp.client-ip 9.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6147942ae1=
8so58177b3.2
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:34:18 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dul-moore.com; s=3Dogle; t=1711748058; x=1712352858; darn=3Der.k=
ernel.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=3D=0A=
        b=3DHcBIpiXyp5v0KrwBJ0Y1s2XnC6BUh97Rt05RbaPDWnQ5yncJbRRQ4bpQ1DvCfFy=
b
         c087fMlQmqN7DDpRyLBIQqPdsJEiFsuSm2asxqRw4bTPYZs0UUSY9k3tVxa7RLZWr/=
+H
         +3mbQyr+4wOT8rytF947HQrMh4gAO/EygFRiXqiZvPUNfFGWYRppJUuzj5s1jPwRtP=
rs
         TrHnXhs6ZqmpBajfXab81hUulMHZOPuxSG2ThE+5NbKs6wfqPACS1RFY7Sl4Sl2OXj=
i5
         T5XKNj2Hy69Q3VTwHuEer0avbRFYAP+/bZBNhSGfatQjGkwMXjxiw4LESd+IPURiJm=
6J
         6wag=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711748058; x=1712352858;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=3D=0A=
        b=3DHVUfDLC4DWFIfru8+fov/6KGTsW1MmR6xqdgJa0ZwDokwzs6YFo2knHPLWB/ROA=
L
         qsi5imkejJmFqKZqJ6sr/wejwOAtVNoVNeSGSmqsmSF8Xrcj5HCn1cLMX1Ljqz8qdC=
GC
         7jG/1seL592tiUukU30+RKaglfpuJ6gYA8jpZGIC0C8HHwJjXEVEti1fT/wY/HS7IM=
Ug
         3kXZN26ymG8e2S0+hqypPJMjEp/QfsQj63frMD5FYcGwyuLOZPrjcyodcvuL5zF4V7=
/K
         OcG75BYen5EpcUMrXZ8pDrSk6dF5BQZATfBgQXoh3IFejhB6HDgL0jMkSoipydMJOl=
GV
         /siA=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCV2kKpT1OpsihgTQBlnZylDfTVURRuey4C3HaPv5f5=
hq0Zk/siPgKCK0ojrUTVaJOOO5yorgBfam6m0wmFQHmfmYXE7iJk6
X-Gm-Message-State: AOJu0YxT4zf6tHhtWM22Kipq7yJ4KbKpQZvdlkAfVQzMIKjgtF1mDEE=
x
	5kqE6IP9tkZ+/fMDytVoa+erAIUMtN04yXP9N/idtKFzHKFA41775RFtBSrWX6SNVps8rnbPJi=
L
	YBzrEo71kAusiSQxFArGWWPC3n1HpwyZ1jTZx
X-Google-Smtp-Source: AGHT+IH9pj0gJOAEZqutXLhCgImC4M5PTgqiAEIOD8jNv+vPhXBfV=
ScVMRmBh9ONVHsoONfJu6nKmSY/GEubTYGORdEX-Received: by 2002:a81:84cd:0:b0:609=
:3c37:a624 with SMTP id
 u196-20020a8184cd000000b006093c37a624mr3517304ywf.35.1711748058196; Fri, 2=
9
 Mar 2024 14:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:34:07 -0400
Message-ID: <CAHC9VhR42y0BaUPB_BgW+8oadDc36xPJRzEqh9Mwqa1RaMMZXQ@mail.gmail=
.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =3DTF-8?B?TWlja2HDq2wgU2FsYcO8bg=3D=3Dic@digikod.net>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,=20
	Eric Dumazet <edumazet@google.com>, =3DTF-8?Q?G=C3=BCnther_Noack?=3Dnoack@=
google.com>,=20
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,=20
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,=20
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serg=
e@hallyn.com>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83465-steffen.klassert=3Dcunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:34:38.2980
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: eb6197cb-6771-485d-8d89-08dc=
5038093a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dx-esse=
n-02.secunet.de:TOTAL-HUB=3D397|SMR=3D323(SMRDE=3D005|SMRC=3D317(SMRCL=3D11=
0|X-SMRCR=3D316))|CAT=3D073(CATRESL=3D029
 (CATRESLP2R=3D006)|CATORES=3D041(CATRS=3D041(CATRS-Transport Rule
 Agent=3D001(X-ETREX=3D001 )|CATRS-Index Routing
 Agent=3D039)));2024-03-29T21:34:38.710Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 11561
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=CAs-essen-01.secunet.de:TOTA=
L-FE=3D014|SMR=3D006(SMRPI=3D004(SMRPI-FrontendProxyAgent=3D004))|SMS=3D008
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAaYIAAAPAAADH4sIAAAAAAAEAJVW224b=
yRFtSryJkiwvsg
 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
 ibfiCWshafeLOjdlsVnztqTxyuBW1xxQUSyG+vAXj8gB8mrbtW1m3J
 4lNUtDkiYUaglqTGrra4QMLPptquTpZqkfOyu6c+l1IKTsEggAWSGH
 bVIymZWMmxrtqVYwjXUBtiKCY9tS2LDlu1mGe8wbFd9eh+7YCthQW2
 2lx3/GAuUeC5UxZF/FCIOgWsYcW5t0tm2CfMYVXpf2uTt6SaYiKE15
 A4346obr0XhAG8h6s2t2rVdyhZZz1l/FA4xtBieW8/IETEg60e17fm
 FmvpLPHZJnn3ulX5mhXyunxNFlXtE0Vn3jo1jDb3u4iq7mKsJU0ZDs
 1qC0TVIWTRUY9wsqKuJX6oTyv1Vk0Kuh4L21Sahvp52cUQbXejZHsL
 4H7ChZOXMqNw+LNS3t11D7/kElRtRVuAh8kDbf2CFr3aRCoOVy2KWw
 u+jEtio7itqlj0nhkgcmDyuGxnAoNu7bLGhAQhc0vt4fQuN6DAvj+i
 H3d5CjUa2FUbjWcNpYTeTmNrgwd+T/0UGB4JgP8CqGwziGkSAAABCt
 UBPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+
 DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW
 9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI0
 OCI+DQogICAgICA8RW1haWxTdHJpbmc+bWljQGRpZ2lrb2QubmV0PC
 9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4N
 CjwvRW1haWxTZXQ+AQ7PAVJldHJpZXZlck9wZXJhdG9yLDEwLDA7Um
 V0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0RG9jUGFyc2VyT3BlcmF0
 b3IsMTAsMjtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V2
 9yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMjtQb3N0V29y
 ZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3Bvcn
 RXcml0ZXJQcm9kdWNlciwyMCwyMw=3D=0A=
X-MS-Exchange-Forest-IndexAgent: 1 2653
X-MS-Exchange-Forest-EmailMessageHash: 3D17F09A
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Wed, Mar 27, 2024 at 8:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.

[Dropping Alexey Kodanev due to email problems]

This isn't something I would want to see backported to the various
stable trees, this is a consolidation and cleanup for future work, not
really a bugfix.  If an individual LSM is currently missing an address
sanity check that should be resolved with a targeted patch that can be
safely backported without affecting other LSMs.

Now, all that doesn't mean I don't think this is a good idea.
Assuming we can't get the network stack to validate addresses before
calling into these LSM hooks, I think this is an improvement over the
current approach.  I would like to see the patchset include individual
patches which do the desired adjustments to the Smack, TOMOYO,
AppArmor, Landlock, and SELinux code now that the sanity checks have
migrated to the LSM layer.  I expect that to be fairly
straightforward, but given all the corner cases I want to make sure
all the individual LSMs are okay with the changes.

> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

--=20
paul-moore.com

X-sender: <netdev+bounces-83465-peter.schumann=3Dcunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Dc822;peter.schumann@secune=
t.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAqUemlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 12221
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DS1_2, cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 22:34:33 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DS1_2,
 cipher=3DS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 22:34:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 0D78B2032C
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:34:33 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D.051 tagged_above=3D99 required=3D1
	tests=3DAYES_00=3D.9, DKIM_SIGNED=3D1, DKIM_VALID=3D.1,
	DKIM_VALID_AU=3D.1, HEADER_FROM_DIFFERENT_DOMAINS=3D249,
	MAILING_LIST_MULTI=3D, RCVD_IN_DNSWL_MED=3D.3, SPF_HELO_NONE=3D001,
	SPF_PASS=3D.001] autolearn=3Dm autolearn_force=3D
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71kp9MtgPhlG for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 22:34:29 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dilfrom; client-ip=139=
.178.88.99; helo=3D.mirrors.kernel.org; envelope-from=3Dtdev+bounces-83465-=
peter.schumann=3Dcunet.com@vger.kernel.org; receiver=3Dter.schumann@secunet=
.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 31136200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com header.i=3Daul-moore.com =
header.b=3DMHcBIpi"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 31136200BB
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 22:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DB1284FF6
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F813B5AE;
	Fri, 29 Mar 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dss (2048-bit key) header.d=3Dul-moore.com header.i=3Daul-moore.com =
header.b=3DMHcBIpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.1=
28.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF51DFC4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dne smtp.client-ip 9=
.85.128.179
ARC-Seal: i=3D a=3Da-sha256; d=3Dbspace.kernel.org; s=3Dc-20240116;
	t=1711748061; cv=3Dne; b=3DAuqo04ElD606skfooNLm/UZkBKnID82OjkuXK7r/qpuGoXe=
9BUrYa0DaxnsXRxRTHV6y2x+rArTkYpXvwH7PctJDyt6j2TYdJFf7bsvlDm8TxCcCyxjvrDG7C9=
kZ0j3tsxirEUCzERxNCB9HqeseliUTavW6oXHxxWHoi7Cp0ARC-Message-Signature: i=3D =
a=3Da-sha256; d=3Dbspace.kernel.org;
	s=3Dc-20240116; t=1711748061; c=3Dlaxed/simple;
	bhPM3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=3D=0A=
	h=3DME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=3D2K8qmVZqwXtgmr0LI9fUb3Kl8RDqp13AQJ3SEeNG+70ERX+4b=
iYHe1KDkKdbuAWhhgyGdjekI+m/mSUxuyAn3ELn1IZnSUYIlliBepO387THtDsmUygDx4n6Btf5=
wYOCkqu6pX47jf7TB/8xMPeG4Vo137SLT8XlIecbRVp0kARC-Authentication-Results: i=
=3D smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3Dne) header.from=3Dul=
-moore.com; spf=3Dss smtp.mailfrom=3Dul-moore.com; dkim=3Dss (2048-bit key)=
 header.d=3Dul-moore.com header.i=3Daul-moore.com header.b=3DHcBIpi; arc=3D=
ne smtp.client-ip 9.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dss (p=3Dne dis=3D=
ne) header.from=3Dul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dss smtp.mailfrom=3D=
ul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6147942ae1=
8so58177b3.2
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:34:18 -0700 (PDT)
DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=3Dul-moore.com; s=3Dogle; t=1711748058; x=1712352858; darn=3Der.k=
ernel.org;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=3D=0A=
        b=3DHcBIpiXyp5v0KrwBJ0Y1s2XnC6BUh97Rt05RbaPDWnQ5yncJbRRQ4bpQ1DvCfFy=
b
         c087fMlQmqN7DDpRyLBIQqPdsJEiFsuSm2asxqRw4bTPYZs0UUSY9k3tVxa7RLZWr/=
+H
         +3mbQyr+4wOT8rytF947HQrMh4gAO/EygFRiXqiZvPUNfFGWYRppJUuzj5s1jPwRtP=
rs
         TrHnXhs6ZqmpBajfXab81hUulMHZOPuxSG2ThE+5NbKs6wfqPACS1RFY7Sl4Sl2OXj=
i5
         T5XKNj2Hy69Q3VTwHuEer0avbRFYAP+/bZBNhSGfatQjGkwMXjxiw4LESd+IPURiJm=
6J
         6wag=3D=0A=
X-Google-DKIM-Signature: v=3D a=3Da-sha256; c=3Dlaxed/relaxed;
        d=1E100.net; s 230601; t=1711748058; x=1712352858;
        h=3Dntent-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DMHZaDV3wX5X/mP8vILSA3tsnYggDxtMi+vTwU7OY8=3D=0A=
        b=3DHVUfDLC4DWFIfru8+fov/6KGTsW1MmR6xqdgJa0ZwDokwzs6YFo2knHPLWB/ROA=
L
         qsi5imkejJmFqKZqJ6sr/wejwOAtVNoVNeSGSmqsmSF8Xrcj5HCn1cLMX1Ljqz8qdC=
GC
         7jG/1seL592tiUukU30+RKaglfpuJ6gYA8jpZGIC0C8HHwJjXEVEti1fT/wY/HS7IM=
Ug
         3kXZN26ymG8e2S0+hqypPJMjEp/QfsQj63frMD5FYcGwyuLOZPrjcyodcvuL5zF4V7=
/K
         OcG75BYen5EpcUMrXZ8pDrSk6dF5BQZATfBgQXoh3IFejhB6HDgL0jMkSoipydMJOl=
GV
         /siA=3D=0A=
X-Forwarded-Encrypted: i=3D AJvYcCV2kKpT1OpsihgTQBlnZylDfTVURRuey4C3HaPv5f5=
hq0Zk/siPgKCK0ojrUTVaJOOO5yorgBfam6m0wmFQHmfmYXE7iJk6
X-Gm-Message-State: AOJu0YxT4zf6tHhtWM22Kipq7yJ4KbKpQZvdlkAfVQzMIKjgtF1mDEE=
x
	5kqE6IP9tkZ+/fMDytVoa+erAIUMtN04yXP9N/idtKFzHKFA41775RFtBSrWX6SNVps8rnbPJi=
L
	YBzrEo71kAusiSQxFArGWWPC3n1HpwyZ1jTZx
X-Google-Smtp-Source: AGHT+IH9pj0gJOAEZqutXLhCgImC4M5PTgqiAEIOD8jNv+vPhXBfV=
ScVMRmBh9ONVHsoONfJu6nKmSY/GEubTYGORdEX-Received: by 2002:a81:84cd:0:b0:609=
:3c37:a624 with SMTP id
 u196-20020a8184cd000000b006093c37a624mr3517304ywf.35.1711748058196; Fri, 2=
9
 Mar 2024 14:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120036.233641-1-mic@digikod.net>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 17:34:07 -0400
Message-ID: <CAHC9VhR42y0BaUPB_BgW+8oadDc36xPJRzEqh9Mwqa1RaMMZXQ@mail.gmail=
.com>
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =3DTF-8?B?TWlja2HDq2wgU2FsYcO8bg=3D=3Dic@digikod.net>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,=20
	Eric Dumazet <edumazet@google.com>, =3DTF-8?Q?G=C3=BCnther_Noack?=3Dnoack@=
google.com>,=20
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,=20
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,=20
	Muhammad Usama Anjum <usama.anjum@collabora.com>, "Serge E . Hallyn" <serg=
e@hallyn.com>
Content-Type: text/plain; charset=3DTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: netdev+bounces-83465-peter.schumann=3Dcunet.com@vger.kernel.or=
g
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:34:33.0961
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d5cfd638-bc6c-43a4-f38f-08dc=
50380620
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=CAs-esse=
n-02.secunet.de:TOTAL-FE=3D026|SMR=3D025(SMRPI=3D022(SMRPI-FrontendProxyAge=
nt=3D022));2024-03-29T21:34:33.122Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 11672
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3Dw
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On Wed, Mar 27, 2024 at 8:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.

[Dropping Alexey Kodanev due to email problems]

This isn't something I would want to see backported to the various
stable trees, this is a consolidation and cleanup for future work, not
really a bugfix.  If an individual LSM is currently missing an address
sanity check that should be resolved with a targeted patch that can be
safely backported without affecting other LSMs.

Now, all that doesn't mean I don't think this is a good idea.
Assuming we can't get the network stack to validate addresses before
calling into these LSM hooks, I think this is an improvement over the
current approach.  I would like to see the patchset include individual
patches which do the desired adjustments to the Smack, TOMOYO,
AppArmor, Landlock, and SELinux code now that the sanity checks have
migrated to the LSM layer.  I expect that to be fairly
straightforward, but given all the corner cases I want to make sure
all the individual LSMs are okay with the changes.

> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

--=20
paul-moore.com


