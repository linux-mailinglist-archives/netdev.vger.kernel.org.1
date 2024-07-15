Return-Path: <netdev+bounces-111458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6A931251
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757C01C21873
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8A188CAD;
	Mon, 15 Jul 2024 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJwaXL/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B548188CDE
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039580; cv=none; b=Ha73gQkOZIxCViFYsaBBlqIQLy3ZmUdfjyyHcTtkqNza6JT2b200KqDb0G0BcSTlIfZIVOP+WphoRr6vuop2z39iwxR1ZR6l3VTQEj+tynx/uIuVQ6MqjaRkxa+J2XCRpVRyUmsPI5p+J1gZhl07di3MiK0lF88Pc8+TAvJyhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039580; c=relaxed/simple;
	bh=ILbbHw0N7WOLv7YjgqJqyIIx4VczfMZx7oM3lrWH23c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RGCS4V1C+hw1YYsv9FEmZQxBJhfJudIw+C5eeHdJSPrxOnQ7XHmQ90Sk0F6mQNSOK2A0cTMg7gPvsi8sGMulRfEKIu2VHjrQ4NsVCGug/fw1sM/KCsDpvPayrHV17KlR5dNHcyOdbSOZVsspf06EbF4Tl3PV4b2ITUrs9TAXhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJwaXL/m; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso283417666b.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039576; x=1721644376; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jf64aPZhHBCfzxguGinN47tMpRaeVC/SX3MinobhBc=;
        b=GJwaXL/mimt2X1X0g2gFnJ5fFJcHF+RYSgDvz8JQgOCb7+WEIh+mVKHZ4cJSH3gD+f
         6Dpn2Jh0XWbcZpIvIrobct3wA7JdbbUOUo3wnIVp75QLCrs+35xEylfjJRAbLPft/6LT
         kBpJvYRBaOCRrYRhlFDIm0cUUmJ+a8uJL8mD0CFGWHtfrvnNjw5FELqbFfE9dOYKDFbO
         iD+Vly+9jum7MtLwwoVFnLaiCPEUlttOPEKFyML0N8BzFw49fO8hiE1G4jT6fbyEs7qY
         qbNOcU0rOLgtRxjRi2hst1uDIuyYaelsIqFGshgRFPlIORjnOmVd6yu3JU9m8iHJFtD1
         sJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039576; x=1721644376;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jf64aPZhHBCfzxguGinN47tMpRaeVC/SX3MinobhBc=;
        b=NpXbyEqxFRoBZpmFSDMFLE33UiNJrGNhjJhbGNA9FRCvw9MxmSofA/MpxKj+4ImaAv
         pYbz5++X89/omehmLsAHXrLIOS1BidCGHFhiu2fJdQvnhZIrLjswFPzGS0rjccTlnjbF
         Ul2G4HCETplCOQtPJmv1z/+B5UzY75Rf2uP0pkLUly2JScPwQKWjPZ27Q65zeVZwbczg
         RZ+8qyG/Jky5SO23/OFzLVF2bc42/DKzhcDF2qfj5v6vQxNaUnHXR5iK7uxFsxNqlS2m
         jVJM+HkpFwwH5oeGCuAdZ0yzf8Cl+E6UN6e2O+fwlpH8ZIdUUAW6a0pqnwy34nwJZOQ2
         x+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX6qrZPYp4Oz6geO0kCt90AaaeYf4C0P7rtRun+oTY2WB6tHze458MnkpIR03e8ScVIBAiMxDJySrraylrKhEtj23LjM97k
X-Gm-Message-State: AOJu0YxkU08nY2ep4Tyi+0B1wXcfqLY2BonOfvWHGOrUP5l0UHUFHoKJ
	BSZzToeMAJUIGEONLP1MFz0YvhuUZZfLpE9OsnDaJ9m2VvuMkZ4W+9jZ1w==
X-Google-Smtp-Source: AGHT+IEJwWPfRsMIp/9R3FPnfmV2xcnq6f6TPtvO2Ur9X8ksFFQwUhJdb/osHSy+V3wslbhYXpEm4A==
X-Received: by 2002:a17:907:94d1:b0:a77:b726:4fc with SMTP id a640c23a62f3a-a780b6883ffmr1580814566b.1.1721039575844;
        Mon, 15 Jul 2024 03:32:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:15dd:7ae3:751a:cc11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db034efsm5956494f8f.91.2024.07.15.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:32:55 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Adam Nielsen <a.nielsen@shikadi.net>,  netdev@vger.kernel.org
Subject: Re: Is the manpage wrong for "ip address delete"?
In-Reply-To: <20240713223112.4d5db4b6@hermes.local> (Stephen Hemminger's
	message of "Sat, 13 Jul 2024 22:31:12 -0700")
Date: Mon, 15 Jul 2024 11:32:05 +0100
Message-ID: <m2jzhnymhm.fsf@gmail.com>
References: <20240712005252.5408c0a9@gnosticus.teln.shikadi.net>
	<m2sewezypi.fsf@gmail.com> <20240713223112.4d5db4b6@hermes.local>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Hemminger <stephen@networkplumber.org> writes:

> On Fri, 12 Jul 2024 11:33:45 +0100
> Donald Hunter <donald.hunter@gmail.com> wrote:
>
>> Adam Nielsen <a.nielsen@shikadi.net> writes:
>> 
>> > Hi all,
>> >
>> > I'm trying to remove an IP address from an interface, without having to
>> > specify it, but the behaviour doesn't seem to match the manpage.
>> >
>> > In the manpage for ip-address it states:
>> >
>> >     ip address delete - delete protocol address
>> >        Arguments: coincide with the arguments of ip addr add.  The
>> >        device name is a required  argument. The rest are optional.  If no
>> >        arguments are given, the first address is deleted.
>> >
>> > I can't work out how to trigger the "if no arguments are given" part:
>> >
>> >   $ ip address delete dev eth0
>> >   RTNETLINK answers: Operation not supported
>> >
>> >   $ ip address delete "" dev eth0
>> >   Error: any valid prefix is expected rather than "".
>> >
>> >   $ ip address dev eth0 delete
>> >   Command "dev" is unknown, try "ip address help".
>> >
>> > In the end I worked out that "ip address flush dev eth0" did what I
>> > wanted, but I'm just wondering whether the manpage needs to be updated
>> > to reflect the current behaviour?  
>> 
>> Yes, that paragraph of the manpage appears to be wrong. It does not
>> match the manpage synopsis, nor the usage from "ip address help" which
>> both say:
>> 
>>   ip address del IFADDR dev IFNAME [ mngtmpaddr ]
>> 
>> The description does match the kernel behaviour for a given address
>> family, which you can see by using ynl:
>> 
>> $ ip a show dev veth0
>> 2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>     link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
>>     inet 6.6.6.6/24 scope global fred
>>        valid_lft forever preferred_lft forever
>>     inet 2.2.2.2/24 scope global veth0
>>        valid_lft forever preferred_lft forever
>>     inet 4.4.4.4/24 scope global veth0
>>        valid_lft forever preferred_lft forever
>> 
>> $ sudo ./tools/net/ynl/cli.py \
>>   --spec Documentation/netlink/specs/rt_addr.yaml \
>>   --do deladdr --json '{"ifa-family": 2, "ifa-index": 2}'
>> None
>> 
>> $ ip a show dev veth0
>> 2: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
>>     link/ether 6a:66:c7:67:bc:81 brd ff:ff:ff:ff:ff:ff
>>     inet 2.2.2.2/24 scope global veth0
>>        valid_lft forever preferred_lft forever
>>     inet 4.4.4.4/24 scope global veth0
>>        valid_lft forever preferred_lft forever
>> 
>> I guess it makes sense for "ip address del" to be stricter since 'first
>> address' is quite arbitrary behaviour.
>
> I wonder if it used to work long ago in some early version (like 2.4) and
> got broken and no one ever noticed

It does work as described if you specify the family:

ip -family inet addr del dev veth0

It is documented well enough in the ip(8) manpage:

  -f, -family <FAMILY>
    Specifies the protocol family to use. The protocol family identifier
    can be one of inet, inet6, bridge, mpls or link. If this option is
    not present, the protocol family is guessed from other arguments. If
    the rest of the command line does not give enough information to
    guess the family, ip falls back to the default one, usually inet or
    any. link is a special family identifier meaning that no networking
    protocol is involved.

