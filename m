Return-Path: <netdev+bounces-215547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF96FB2F2C0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BA0188125B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793652D9499;
	Thu, 21 Aug 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="SN3Vly0B"
X-Original-To: netdev@vger.kernel.org
Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174F2D7809
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765935; cv=none; b=tdJC2twn6ycmyxmiZ2iEDY6EZAKqP0vATR0hkcbkAf2nSfygS88q+FoLWMbHLaMFAFbxCgfE0UNy0FMyy9i6dUHMzBz8L/zYh755Kgl5JTFL6JtFsb/+jWB4tvOFRfj81Rt2puP61B8isCAF8qM1xCf750LPGZw4hDTk++JzirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765935; c=relaxed/simple;
	bh=bYhu+EaqpGwbWGE7KwLH0uEIuOTOreJsPzJjXF/uUPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQiJdGCQkEQ8HnBEZLbheGSGjH4auEwI79M9zEEC03rwAgMgUWpiXhMi61Qf2TwZBQ9mAHCztj+pOWWUIlL3C2IXPBRmwFeTp5WbXaWV2/839YIb6Nv7O3oCjjafgAHVwuNiXk56umBnkUd7FapnmoM8pOIeXcYeOAiQM9X42ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=SN3Vly0B; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755765931; x=1755773131;
 h=Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: From: From: In-Reply-To: References: MIME-Version: Sender: Sender;
 bh=msCpBQuhCsYe0DLREgBEhe037zGE4EqylmEpUhtFCws=;
 b=SN3Vly0BED1eMOXt2/9rqYliW6fgyVy3Q2thHSqy5yBmV5OOzdycKQAVgZukkzBa66jMOkPX9C7bC4bLCJB8e4m+ai+S6H7SEyYFqM5qdWcAgu65YhE62pf0nxbD2PISqROiwwc6+LFsvpeXUDKC5PNxgGk2rlyADJIcMsh9oMuxv66wTXRgqmYZWQF407A5lvNHR7SLVnt2xcC4Q0Fnrl9sss0+PTwtNvLn09WFNX/7S5PmwRm0yn/gD4giYqvi9P/hpUWEYzkjZMB66MLfrKooXKI/5UKA7OeT108h3DIcRCcEYZ0J3+HsQccGfhAaoNYELmD63q3IfQXB6qF3Ug==
X-Mailgun-Sid: WyI2ZTA5MCIsIm5ldGRldkB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170]) by
 6daba92ea63ccfff060124925e5e264487e90b9321cf65b2c1448e79f35e349c with SMTP id
 68a6dcab03c0e2ff1b55fc2a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 21 Aug 2025 08:45:31 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e94e3c3621fso705778276.0;
        Thu, 21 Aug 2025 01:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4K2uos5dPyRlVDDurmESZTxVNll96z2hWCdjMC2X7ZOPm7kgRXf9jl76NDq6vOMRrLfhfFKHr@vger.kernel.org, AJvYcCVJYsSNteAjwy0mzQuzcj2ApvLvBGnvfsnz9o1b/sNV/jjxzQmWns4vQpFWFqqDZ7dr12nBMGpWpevvG4aames=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5yfS+Mg0xWqUSlIyjyh6UoXdHH+vjts8dvAmyVkedWKNjpHw
	s+hGqCjW8cDkku2ZJGFUVrg//ynIMr26Z0JUdHwfP/ZJA9H08FjS8INVxyXz04TUMVyCB6GQfmt
	P6v+dlbZj9TX9IswxxqZJVneoYelBfe4=
X-Google-Smtp-Source: AGHT+IGsJcqMRG4yd4cvOtt5skBISj3uXRZWX0nol9HqMOYR6esa1KPfaIztVwhO0z6oj8rOkDyMltT6s5I/XOlZZeM=
X-Received: by 2002:a05:6902:c11:b0:e93:1d56:df4b with SMTP id
 3f1490d57ef6-e9508917cb1mr1834622276.18.1755765930435; Thu, 21 Aug 2025
 01:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821074552.682731-1-alessandro@0x65c.net> <20250821074552.682731-2-alessandro@0x65c.net>
 <aKbX_CzxSi7T9Bcp@fedora>
In-Reply-To: <aKbX_CzxSi7T9Bcp@fedora>
From: Alessandro <alessandro@0x65c.net>
Date: Thu, 21 Aug 2025 10:45:19 +0200
X-Gmail-Original-Message-ID: <CAKiXHKcLsEWbEz1EkzE942PbsMEpfj=wO7uYDb+Nxy8nGCEx1Q@mail.gmail.com>
X-Gm-Features: Ac12FXygZEeAbzB1YfK8tFEi6oY-JpXBvuzzKU8MqJf9IYpjcrpTliTW74aQ1Lw
Message-ID: <CAKiXHKcLsEWbEz1EkzE942PbsMEpfj=wO7uYDb+Nxy8nGCEx1Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: rtnetlink: add checks for ifconfig and iproute2
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 10:25, Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 09:43:11AM +0200, Alessandro Ratti wrote:
> > On systems where `ifconfig` is not available (e.g., modern Debian), the
> > `kci_test_promote_secondaries` test fails. Wrap the call in a check.
> >
> > Additionally, `do_test_address_proto` fails on iproute2 versions that
> > lack support for `proto` in `ip address` commands. Add a minimal feature
> > check and skip the test with a proper message if unsupported.
> >
> > These changes allow the tests to run and report SKIP instead of FAIL on
> > platforms with older tools.
> >
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> > ---
> >  tools/testing/selftests/net/rtnetlink.sh | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > index d6c00efeb664..9bff620ef595 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -330,7 +330,9 @@ kci_test_promote_secondaries()
> >       for i in $(seq 2 254);do
> >               IP="10.23.11.$i"
> >               ip -f inet addr add $IP/16 brd + dev "$devdummy"
> > -             ifconfig "$devdummy" $IP netmask 255.255.0.0
> > +             if command -v ifconfig >/dev/null 2>&1; then
> > +                     ifconfig "$devdummy" $IP netmask 255.255.0.0
> > +             fi
>
> Maybe just skip the promote_secondaries test if ifconfig is not available?
>

Thank you for your review and comment.

My takeaway here is that the test works because the IP addresses are set on the
$devdummy by the previous ip(8) command, and ifconfig seems a bit redundant.

Also, considering we are testing netlink, I was baffled to see ifconfig there
that, if I'm not mistaken, uses ioctl(); but I might be missing
something obvious
here, considering I'm looking at these tests for the first time, so bear with
me :)

If it's better to skip the test altogether when ifconfig is missing, I'll
submit another patch to do so.

Thank you

Best regards,
Alessandro

