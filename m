Return-Path: <netdev+bounces-76500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7486DF6D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BB41F2321C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A46A8CD;
	Fri,  1 Mar 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S7B+XxgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6CE20319
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289724; cv=none; b=COdUOVlkms/1se3G6VJAlibPV33tjqpqCLf33sYul770BYDB1zNI+FRFYzIAGSwRyje6QiAP8mC3PBOm6wzcVJAo5mAI8UsCP1l2sRRlrgmZJ5TqsHz2iOY8X2BavggYhP13wYu2z5wDwXymVGVSLyG/qdVKhCWDNJivhPaGetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289724; c=relaxed/simple;
	bh=MyzEAkBZuIpR892vDJgDwyTBmBXyBAiXWmQvk35TtYY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=RUYMwRU86IyR0Ps4Poy+68f7icwPoMfqlY9Z2uJ+M6jU4ZAp3KdsRjiIt9LiNKuqtYGIkfy9D8wUxq/AdbYbjZ6cMm6SXgU7eV6tCb/8ZBKCUITlw9MtgHLFmTI5gTszm/jr1lDCB5rkePzck0kM8GBOFwcxf33Gw7q6veGxw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S7B+XxgQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so3438240a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709289721; x=1709894521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FUsAED/lmxCoWoKnQG3JtYsXIKOmckCJxzG1hZ6f9c=;
        b=S7B+XxgQr4MJMxukZ+TsmEkO0cEaU26VkSsgs6gy7pfebgwfScrzlT/13uHPYF1W6A
         Jmdgqgc5/1SzAdN20oSUPA2MeaRytnrjezOfODG/orN/dLJ3Q4vHDEC6TlpeXDZECdYu
         BqZArM7R4VVQZhhW4ylSSJqrGseGMImPgO4Ek3XAFTuRWNU8MkiWamVzAyRgFwisRmLy
         U5h5bioHIzjrphuXjX9DjK3yhGQl+z7Uf/hI6gVaRQl3Tk/9o+esnWPmT55OsSrq/28x
         Mm6Ws01btgOOes5LlRE9S17APyLrO04FwB9I0hmjPgWxEq3eeS3Ty5aTLmMQW7j7GnO0
         iYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709289721; x=1709894521;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FUsAED/lmxCoWoKnQG3JtYsXIKOmckCJxzG1hZ6f9c=;
        b=oKM4mfnwOIYCW7tfd/sT3LMd5MkN6bXvfaHvM94pzupVqkAPEi+OhCLYcwoH02AXIH
         y9+FTEhaK0QPsr9QD6gWIPVEcxqxcEqThDgjWw3SWCT0ITckgXVHOFJLQ+SjAmasvCH8
         GE5UnL6mGD5LNKKqPXSGSzj5JwjDHJMPSEmgOzm2Qs+avWlm/M3MRWYfVsl75tfe3ie1
         wgZ+aFxgcoizluUlrbqxt+JIRhOAvh+FZhfsX4lSAS/hzKZ2yVtIiYP1R0SaDwTTVkgl
         mSqKknr9WWuyeS8JUeB4vwmFRFdtqTKYGQYLNH0HA+ApoJH4H5n+HoD0vtPZKV0i/+D4
         e7gw==
X-Forwarded-Encrypted: i=1; AJvYcCXj2EvUvxaIL8t1peIfqcqt6XcRLMb3sW8NrvBsh3CG9ruUQnASs5S2D1G5LKqO6kZzN4HgOTpGQe0mt5J1V4FKIrHtALV+
X-Gm-Message-State: AOJu0Yyo2vh/R4cJ3sVIJ66a9dlsox+9s0h85JeOh19W0FWYqQyCYrKe
	k89ReKvUZmRXgIVtLmnzgUbzJ+qVXFNxjg8Pm6mRjn1QiA0ul962vcBX6B5o9jw=
X-Google-Smtp-Source: AGHT+IFsNGzvNzeIMp+c2vln39bwQZyElm675FddMfJSSFuv8gtyc69SUsSkQMp66ZVqG55y2w4wkw==
X-Received: by 2002:a05:6402:28af:b0:566:6c13:82fd with SMTP id eg47-20020a05640228af00b005666c1382fdmr884994edb.21.1709289720923;
        Fri, 01 Mar 2024 02:42:00 -0800 (PST)
Received: from cloudflare.com (79.184.121.65.ipv4.supernova.orange.pl. [79.184.121.65])
        by smtp.gmail.com with ESMTPSA id w20-20020a50fa94000000b005668c6837ecsm1421669edr.32.2024.03.01.02.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:42:00 -0800 (PST)
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-13-kuba@kernel.org>
 <871q8vm2wj.fsf@cloudflare.com>
 <CADvbK_e+JCeM9cn0Qd7JG5UdSO_-s8w5r0v40E485JevkbH4XQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, mic@digikod.net,
 linux-security-module@vger.kernel.org, keescook@chromium.org, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH v4 12/12] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
Date: Fri, 01 Mar 2024 11:40:45 +0100
In-reply-to: <CADvbK_e+JCeM9cn0Qd7JG5UdSO_-s8w5r0v40E485JevkbH4XQ@mail.gmail.com>
Message-ID: <87wmqmkzd4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 06:25 PM -05, Xin Long wrote:
> On Thu, Feb 29, 2024 at 3:27=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Wed, Feb 28, 2024 at 04:59 PM -08, Jakub Kicinski wrote:
>> > SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
>> > so use XFAIL instead of SKIP.
>> >
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> > ---
>> >  tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools=
/testing/selftests/net/ip_local_port_range.c
>> > index 6ebd58869a63..193b82745fd8 100644
>> > --- a/tools/testing/selftests/net/ip_local_port_range.c
>> > +++ b/tools/testing/selftests/net/ip_local_port_range.c
>> > @@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
>> >       __u32 range;
>> >       __u16 port;
>> >
>> > -     if (variant->so_protocol =3D=3D IPPROTO_SCTP)
>> > -             SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PO=
RT");
>> > -
>> >       fd =3D socket(variant->so_domain, variant->so_type, 0);
>> >       ASSERT_GE(fd, 0) TH_LOG("socket failed");
>> >
>> > @@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
>> >       ASSERT_TRUE(!err) TH_LOG("close failed");
>> >  }
>> >
>> > +XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
>> > +XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
>> > +
>> >  TEST_F(ip_local_port_range, get_port_range)
>> >  {
>> >       __u16 lo, hi;
>>
>> [wrt our earlier discussion off-list]
>>
>> You were right, this test succeeds if I delete SKIP for SCTP.
>> Turns out IP_LOCAL_PORT_RANGE works for SCTP out of the box after all.
>>
>> What I didn't notice earlier is that sctp_setsockopt() delegates to
>> ip_setsockopt() when level !=3D SOL_SCTP.
>>
>> CC'ing Marcelo & Xin, to confirm that this isn't a problem.
> Yes, SCTP supports ip_local_port_range by calling
> inet_sk_get_local_port_range() in sctp_get_port(), similar to TCP/UDP.

Well, that's embarassing.

I see that I've updated sctp stack to use inet_sk_get_local_port_range()
in 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option").

Thanks for confirming, Xin.

It's clearly an overside on my side. That SKIP in tests should have
never been there. I will send a fixup.

