Return-Path: <netdev+bounces-83618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F3893334
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E51C2276F
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01835154C02;
	Sun, 31 Mar 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMHcBIpi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65284153BCE;
	Sun, 31 Mar 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902516; cv=pass; b=uxBR8plI9SIT4blI7ZGQEdVaBad+rQd1FyHfJonCY/30QjlnFr1/YuF1efiW+XJJMrZ9DTuhOHK9qag2oJ4aiT3YqhduD/hIj01Ij8UitR2HhWTD6JvdJHD7dgsTutv/FoDnRqBTIhz7sE0hBhfFGUVxPWBzTcEEudCm8U10oFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902516; c=relaxed/simple;
	bh=50M3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOd/8OBu0fcPh9rxr0CtBduQ5rzcvCpDYD++jopXZt9lyduk39nxqi8hnjscb5gcGf+gLva6+wvjA3KBt2CecToNRVqH6TsskJBH2ho+yauERQ+1RuPuHMYwZAGvzDX6NkdYpyOMBWGx+GH2sdRp0BjTUid1V9QJ7JTyU6LqIms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=fail smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMHcBIpi; arc=none smtp.client-ip=209.85.128.179; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=paul-moore.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EF4EB208E4;
	Sun, 31 Mar 2024 18:28:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57j9JQEUMWjX; Sun, 31 Mar 2024 18:28:31 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 360FA208D8;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 360FA208D8
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 29B0C800057;
	Sun, 31 Mar 2024 18:28:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:32 +0000
X-sender: <netdev+bounces-83465-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAtpHp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgCEAAAAi4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 17024
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83465-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 31136200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YMHcBIpi"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748061; cv=none; b=IhAuqo04ElD606skfooNLm/UZkBKnID82OjkuXK7r/qpuGoXe9BUrYa0DaxnsXRxRTHV6y2x+rArTkYpXvwH7PctJDyt6j2TYdJFf7bsvlDm8TxCcCyxjvrDG7C9kZ0j3tsxirEUCzERxNCB9HqeseliUTavW6oXHxxWHoi7Cp0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748061; c=relaxed/simple;
	bh=50M3LT8mnuywmJNlkQScxlgjVAIlHyjJG8qloVonzuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as2K8qmVZqwXtgmr0LI9fUb3Kl8RDqp13AQJ3SEeNG+70ERX+4biYHe1KDkKdbuAWhhgyGdjekI+m/mSUxuyAn3ELn1IZnSUYIlliBepO387THtDsmUygDx4n6Btf5wYOCkqu6pX47jf7TB/8xMPeG4Vo137SLT8XlIecbRVp0k=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YMHcBIpi; arc=none smtp.client-ip=209.85.128.179
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
        b=uoHVUfDLC4DWFIfru8+fov/6KGTsW1MmR6xqdgJa0ZwDokwzs6YFo2knHPLWB/ROAL
         qsi5imkejJmFqKZqJ6sr/wejwOAtVNoVNeSGSmqsmSF8Xrcj5HCn1cLMX1Ljqz8qdCGC
         7jG/1seL592tiUukU30+RKaglfpuJ6gYA8jpZGIC0C8HHwJjXEVEti1fT/wY/HS7IMUg
         3kXZN26ymG8e2S0+hqypPJMjEp/QfsQj63frMD5FYcGwyuLOZPrjcyodcvuL5zF4V7/K
         OcG75BYen5EpcUMrXZ8pDrSk6dF5BQZATfBgQXoh3IFejhB6HDgL0jMkSoipydMJOlGV
         /siA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kKpT1OpsihgTQBlnZylDfTVURRuey4C3HaPv5f5hq0Zk/siPgKCK0ojrUTVaJOOO5yorgBfam6m0wmFQHmfmYXE7iJk6
X-Gm-Message-State: AOJu0YxT4zf6tHhtWM22Kipq7yJ4KbKpQZvdlkAfVQzMIKjgtF1mDEEx
	5kqE6IP9tkZ+/fMDytVoa+erAIUMtN04yXP9N/idtKFzHKFA41775RFtBSrWX6SNVps8rnbPJiL
	YBzrEo71kAusiSQxFArGWWPC3n1HpwyZ1jTZx
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


