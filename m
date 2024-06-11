Return-Path: <netdev+bounces-102674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC290436D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6971F2384E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D7605BA;
	Tue, 11 Jun 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkPk3DU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C543376E9
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130189; cv=none; b=EVx15rzLtdX2w35KimZjbEyeSHoQXoNQJedbRE8+S4cSZUt1WGZloq7iR+jbzywAzlMHwF4ltdTBoI58DfcyTY3iFoPw6jGR45Y+nDIgQHshwGpMB0gvR1+atGJoM5NeBo79HxveFed1cBLkPTeXyXlJ77gpMY15BT4tnO6IFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130189; c=relaxed/simple;
	bh=A7Nm+1F0+48A+levDGZsn00RG1ioZ5rSOVboMoFMjzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxYoCwM8Vv46W/VtLxjCeQTc0PJXUA7tX9nu++go2CzOhkDuRkfQP7uLUpAzA7e4sUcK5W+8FrzYxHKLWtTTY1qJUSgB4wWxHTebnGouQ7pibz3CU1S6JC6ReA0l/JQXh0N8zaQx7h8uAGtwEmOCnZU72ZueZH70DWwc966UAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkPk3DU/; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48c4c5c0614so440147137.1
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130186; x=1718734986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFrtGaJ1RPlvnFEFH/qA4XKH8DlyBFYemFy9U2rrcZ8=;
        b=HkPk3DU/UZrLwIPxd3vNhdW5y4nbXxeLIThEi62bni41RNOIHb/jn9mU/P+xZbOqrT
         FbG1zoTVxxnXT/UXNCNf3CX6Kf3TdwIXCLqIqqU5dug+kKKFBgBuXBJqMKQsTnz9pH5m
         IkrUH7KEUcTpv4c0wztIz8c/EsoWZI6XKWQ5wHGgeSV6CxHAHFgRVFpLlR+z0+Q9939B
         6Z78mLVokFRC34L4g+H9uJ8KbBax5PgvTiPy03QHbhFzvHVN7UITUhqUiXsJ9wfZkLc6
         fZp1OA3qS3648hZuDSRRz929KCp5KYtxnVQtEmuzsem9lTiEE/pGOXThT3n/ZujlCC54
         T0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130186; x=1718734986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFrtGaJ1RPlvnFEFH/qA4XKH8DlyBFYemFy9U2rrcZ8=;
        b=cByPXGi0qskZrFLQMwrxryND2tuZhrQW//O6j+sVRh+HQ7zDC2UDV2K6u6WhRZ2Vep
         2D8VIlP71mOepbFJ5mer5ESUiI3yAWTuH4hy7enhfkeonmasElrltpEJlBowC5oRweCO
         w9RgdhOxiflS5BHUj4ch3nKe20Nsq5q4CG0d8dRPrrT3XvHAlEkb6bZGVzMIdA1woUY4
         Xd4v3CPmOrk+w2q+t2Uef5i/fSC3vQw2suFfRfkvYW0rzkjqc3uNAQmNtyVY+CxGjro8
         STE3ps5OkWPQyNny6CMEdX3AtFxwWE5dEo02xrNqoMOSRX1rpps/+vqnhbGDh+74TV2V
         1P7w==
X-Forwarded-Encrypted: i=1; AJvYcCWGRf/0TolG7Zew91DLn7BnB+v7bU+cdUg4YO1p9jmHRdTjtft441X513uLOeqZmbXXyQKUqvI4QRYBS5qapfnSiGjP3MEP
X-Gm-Message-State: AOJu0YwhiHGLRSh19iFQTaVSmxT75Q0r3E3azmqN2V6jV8xWAYfZ1AEc
	wJ9/5imXcupCXvtc2qe2nArzMPCV4WubWk03ZAJX1Ct6HcxbBTt2X8mZBRJsTC/SRAi1q403Hto
	QpB606VqHGam0z8zPENyLaJWRMS8=
X-Google-Smtp-Source: AGHT+IE54m3WtvZhJVVP/oGpuyL3XcW0m8dW8SCvVXCR59sHTCsjFpJ6yZP5q0VDovj98uahtXHF/aykkR5fvqVAFhs=
X-Received: by 2002:a05:6102:510b:b0:48c:4ec8:ac42 with SMTP id
 ada2fe7eead31-48c4ec8afd9mr9362316137.2.1718130184945; Tue, 11 Jun 2024
 11:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528032914.2551267-1-eyal.birger@gmail.com>
 <ZmfkZLBpWmv20hGE@Antony2201.local> <CAHsH6GtXWmOUGycPU4xJoSVDEGXPb+ziKb88YJvZXchsAm2fWA@mail.gmail.com>
 <CAGL5yWb8Npve9wyB2WrKxAQANAa53ritU4JLzhTHV_eXppkCHg@mail.gmail.com>
In-Reply-To: <CAGL5yWb8Npve9wyB2WrKxAQANAa53ritU4JLzhTHV_eXppkCHg@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 11 Jun 2024 11:22:53 -0700
Message-ID: <CAHsH6Gu6WwKJsN2f4fvLsTE81cpDaVg_ELXTHWATRhmcsk+EoA@mail.gmail.com>
Subject: Re: [PATCH ipsec-next,v4] xfrm: support sending NAT keepalives in ESP
 in UDP states
To: Paul Wouters <paul.wouters@aiven.io>
Cc: Antony Antony <antony@phenome.org>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	pablo@netfilter.org, nharold@google.com, mcr@sandelman.ca, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:58=E2=80=AFAM Paul Wouters <paul.wouters@aiven.i=
o> wrote:
>
>
> On Tue, Jun 11, 2024 at 1:08=E2=80=AFPM Eyal Birger <eyal.birger@gmail.co=
m> wrote:
>
>>
>> > One curious question: What happens if the NAT gateway in between retur=
ns an
>> > ICMP unreachable error as a response? If the IKE daemon was sending it=
,
>> > IKEd would notice the ICMP errors and possibly take action. This is
>> > something to consider. For example, this might be important to handle =
when
>> > offloading on an Android phone use case. Somehow, the IKE daemon shoul=
d be
>> > woken up to handle these errors; otherwise, you risk unnecessary batte=
ry
>> > drain. Or if you are server, flodding lot of nat-keep-alive.
>> >
>> > 07:33:30.839377 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto=
 UDP (17), length 29)
>> >     192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-aliv=
e
>> > 07:33:30.840014 IP (tos 0xc0, ttl 63, id 17350, offset 0, flags [none]=
, proto ICMP (1), length 57)
>> >     192.1.2.23 > 192.1.3.33: ICMP 192.1.2.23 udp port 4500 unreachable=
, length 37
>> >         IP (tos 0x0, ttl 63, id 0, offset 0, flags [DF], proto UDP (17=
), length 29)
>> >     192.1.3.33.4500 > 192.1.2.23.4500: [no cksum] isakmp-nat-keep-aliv=
e
>>
>> That's an interesting observation. Do IKE daemons currently handle this
>> situation?
>
>
> libreswan logs these messages but since the ICMPs are not encrypted, it c=
annot act on it by itself.
>
>>
>> If the route between hosts isn't available, any traffic related to the x=
frm
>> state would fail in a similar way, which the IKE daemon could observe as=
 well.
>> Is there such handling done today?
>
>
> I would let the regular IKE liveness/DPD handle this. Unless the keepaliv=
es could cause the kernel
> to suppress further messages as some sort of rate limit protection? If wh=
ich case it should just ignore
> these kepalives and not dp icmp for them?

I also feel this handling should be done based on IKE and not as part of th=
is
feature.

>
> Note that it is perfectly valid to send these keepalives with a TTL=3D2 i=
n which case these don't traverse the
> whole internet but only pass your NAT gateway so it knows to keep the map=
ping open. The other end just
> silently eats these anyway without any other side effects.

Personally I feel TTL=3D2 is a bit too aggressive as we do have setups with
multipli NATted VMs and CGNs. Currently the patch uses ip_select_ttl() unde=
r
the hood which relies on the system defaults and routing configuration.
If needed, we can later add support for tuning the TTL for our socket based=
 on
a sysctl.

Eyal.

