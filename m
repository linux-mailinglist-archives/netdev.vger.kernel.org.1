Return-Path: <netdev+bounces-181770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DBA866F6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EF0168B23
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955A221D98;
	Fri, 11 Apr 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asciiwolf-com.20230601.gappssmtp.com header.i=@asciiwolf-com.20230601.gappssmtp.com header.b="p3lfWRmI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8D236453
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402731; cv=none; b=jm/aA0LnIRHy3hDrzcuJCWmOFupbc7nnPuEFhifocy94P6R1TFIp5A4YKgikpgUmM+jeNFJr9y08cibeAW2CdnaJdkNh5UkeG3HsFxd7/lRGBSnokRq/bEEAf3RWa+mZFWlYUi7Wlk+BnYxGNCqmwZLMHxeB7xFl432BcRLY064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402731; c=relaxed/simple;
	bh=LMwmw+mwxkaGTvA/SOrtYKwoR7+K+OzMX5llrFCPE/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2pdJOKeK0ShCqy002+MZoigy2Y8w7+bqJLGe75iH3jJ4/gqa0gnYG+ZGX0sxsTotdVLruJjLllt2rfdDdcZ5T0MorQHI0jl/4pOWqvSZgIvXZqx6v79e3X9lXvIqEbWdjY98aBUNILv9Qb5HwiF9A9789iO7S8Oho0lN9QP9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asciiwolf.com; spf=none smtp.mailfrom=asciiwolf.com; dkim=pass (2048-bit key) header.d=asciiwolf-com.20230601.gappssmtp.com header.i=@asciiwolf-com.20230601.gappssmtp.com header.b=p3lfWRmI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asciiwolf.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=asciiwolf.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so393918666b.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asciiwolf-com.20230601.gappssmtp.com; s=20230601; t=1744402728; x=1745007528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sug/o/Z05+bDPu/S3g1RxtrnjkoSl9YAJhgZRvUHNr8=;
        b=p3lfWRmIQSrv6wSbIG2uklzq+tj2OPI48kdKsHXCChXxOrO8BnwLAS3I3iyrTs76Dn
         QHdxA3DtjobrqqxUnMMGNkD578qnVUv3Ob2Z+hggkV/+juZD2wEvpJabiI2TdFJ0aK2c
         ySSeTPLCQp330SM4CMYL/htXHhRZHRiP6/EresiCDAtg8qvDasoUsVAOqjtH9cDfRHbC
         nSfPO4iYiC76xha9dXaF9Ns1fmXaPC17v76bqr6ZtvDmewCgFVmQwg3w3YwY16WP3A5I
         82Rr8gUh4VW949zEIBhg+IcbfPpOslBuHVl3CpVeIaTVRLN/VKA1EPQLlsYe7ifz2s+u
         8zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744402728; x=1745007528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sug/o/Z05+bDPu/S3g1RxtrnjkoSl9YAJhgZRvUHNr8=;
        b=l/AJECu/ScvfQvYX1QdsD/8q/GJnC5QtCTkbiF0lBkkMcDarnz93NY8nhtWHVDFfsO
         nWczZ4g6fGy7dBXL8UAMwQ8Ztd/RseYc7EK3GBQIadyXVraehPj8aww3dWsKZLuuuDcM
         rOkE5kVlVdCUBFoiGqAYziDP1rvJk2l9WVJzeSeDnXO/oiwqmqohVLjz3g1LrVuNIIh3
         yKfH1zBy45N2AK5oFeqMf/an7Fs/pM9btWALnQLaYwplwyU6O2Dx8Jd5F3CI3KbAtmSh
         g3zIGbkfiZOJgMyUZ704vlliWCN4CJJO+EhqOp3+3IvUETkLS2c/WoW70TrJtnNhRcbM
         1v8w==
X-Forwarded-Encrypted: i=1; AJvYcCVAsvGu+CMDy/pMYG3awqIpTqJw18AAS/Z+c966jsfWr1UKxoHPlhmLUNs2eRnLlt3T3Wgah7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzou5T4ZWkP0m7eMIybMVOIOa48fQ5SPGcBZ/7FdHrTEiwvwogJ
	y6f76qSY3TtLExy0VDu5ykuRUfXloF06OzcjZj0GcN/FNw8ZYJf2tmmUyrzoxGy9Wo8zWIBLeM5
	8GNsg3yMzzSc6x25BtaR4QXfOqqE6uvn0WUM=
X-Gm-Gg: ASbGnctXr5Q1G4RFCYvp6A4fhe2+VkRrvvdGgJGm0LTMsi5FZlIqymYAnyOQ2BeSnRe
	FwOIKGP9uJspHc0AyvgpSvKx/IEAhzaqPJiFTsqkyQViYorob0QQhN21h9UHlGnvZ2EqQcJWs7I
	ML3AnnCu+nkXbxD8E3ril70JVcUK6zlYeqnngfUcV+6/9hGoXbKfNLiCA=
X-Google-Smtp-Source: AGHT+IHkd3AljMKmY0VNwj3PKjc7jkp69De1gJa7n6VF4Vl2VTQnZkLmP/Epf+6ZLbqXWZKcvtiZDfW8SrnILWPrNR0=
X-Received: by 2002:a17:907:cd0e:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-acad3439f51mr359557966b.10.1744402727675; Fri, 11 Apr 2025
 13:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu> <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
In-Reply-To: <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
From: AsciiWolf <mail@asciiwolf.com>
Date: Fri, 11 Apr 2025 22:18:36 +0200
X-Gm-Features: ATxdqUEuwa8Zyad6PdXtqVcoPVVel22F3RYas430uBqwBmCwTNOy9DEdwBJhmt4
Message-ID: <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org, 
	Robert Scheck <fedora@robert-scheck.de>
Content-Type: multipart/mixed; boundary="000000000000ee581006328668e7"

--000000000000ee581006328668e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the proposed fix. It is validated using appstreamcli validate
and should work without issues.

--- org.kernel.software.network.ethtool.metainfo.xml_orig
2025-03-31 00:46:03.000000000 +0200
+++ org.kernel.software.network.ethtool.metainfo.xml    2025-04-11
22:14:11.634355310 +0200
@@ -1,5 +1,5 @@
 <?xml version=3D"1.0" encoding=3D"UTF-8"?>
-<component type=3D"desktop">
+<component type=3D"console-application">
   <id>org.kernel.software.network.ethtool</id>
   <metadata_license>MIT</metadata_license>
   <name>ethtool</name>
@@ -11,6 +11,7 @@
   </description>
   <url type=3D"homepage">https://www.kernel.org/pub/software/network/ethto=
ol/</url>
   <provides>
+    <binary>ethtool</binary>
     <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
   </provides>
 </component>

Regards,
Daniel Rusek


p=C3=A1 11. 4. 2025 v 15:50 odes=C3=ADlatel AsciiWolf <mail@asciiwolf.com> =
napsal:
>
> Sure,
>
> I will take a look at this later today.
>
> Regards,
> Daniel
>
> Dne p=C3=A1 11. 4. 2025 15:47 u=C5=BEivatel Michal Kubecek <mkubecek@suse=
.cz> napsal:
>>
>> Hello,
>>
>> I got this report (and one more where you are already in Cc) but I'm not
>> familiar with the AppStream stuff at all. Can you take a look, please?
>>
>> Michal
>>
>> > Date: Fri, 11 Apr 2025 15:16:28 +0200
>> > From: AsciiWolf <mail@asciiwolf.com>
>> > To: Michal Kubecek <mkubecek@suse.cz>
>> > Subject: Re: ethtool: Incorrect component type in AppStream metainfo c=
auses
>> >  issues and possible breakages
>> >
>> > This probably also needs to be fixed:
>> >
>> > https://freedesktop.org/software/appstream/docs/
>> > sect-Metadata-ConsoleApplication.html#tag-consoleapp-provides
>> >
>> > Regards,
>> > Daniel
>> >
>> > p=C3=A1 11. 4. 2025 v 15:06 odes=C3=ADlatel AsciiWolf <mail@asciiwolf.=
com> napsal:
>> >
>> >     Hello Michal,
>> >
>> >     ethtool is user uninstallable via GUI (such as GNOME Software or K=
DE
>> >     Discover) since 6.14. This is not correct since it is a (in many
>> >     configurations pre-installed) system tool, not user app, and unins=
talling
>> >     it can also uninstall other critical system packages.
>> >
>> >     The main problem is the "desktop" component type in AppStream meta=
data:
>> >
>> >     $ head org.kernel.software.network.ethtool.metainfo.xml
>> >     <?xml version=3D"1.0" encoding=3D"UTF-8"?>
>> >     <component type=3D"desktop">
>> >       <id>org.kernel.software.network.ethtool</id>
>> >       <metadata_license>MIT</metadata_license>
>> >       <name>ethtool</name>
>> >       <summary>display or change Ethernet device settings</summary>
>> >       <description>
>> >         <p>ethtool can be used to query and change settings such as sp=
eed,
>> >         auto- negotiation and checksum offload on many network devices=
,
>> >         especially Ethernet devices.</p>
>> >
>> >     The correct component type should be "console-application".[1]
>> >
>> >     Alternative solution would be removing the whole metainfo file.
>> >
>> >     Please see our (Fedora) downstream ticket for more information:
>> >     https://bugzilla.redhat.com/show_bug.cgi?id=3D2359069
>> >
>> >     Regards,
>> >     Daniel Rusek
>> >
>> >     [1] https://freedesktop.org/software/appstream/docs/
>> >     sect-Metadata-ConsoleApplication.html or https://freedesktop.org/s=
oftware/
>> >     appstream/docs/chap-Metadata.html#sect-Metadata-GenericComponent

--000000000000ee581006328668e7
Content-Type: text/xml; charset="US-ASCII"; 
	name="org.kernel.software.network.ethtool.metainfo.xml"
Content-Disposition: attachment; 
	filename="org.kernel.software.network.ethtool.metainfo.xml"
Content-Transfer-Encoding: base64
Content-ID: <f_m9d8bikp0>
X-Attachment-Id: f_m9d8bikp0

PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPGNvbXBvbmVudCB0eXBlPSJj
b25zb2xlLWFwcGxpY2F0aW9uIj4KICA8aWQ+b3JnLmtlcm5lbC5zb2Z0d2FyZS5uZXR3b3JrLmV0
aHRvb2w8L2lkPgogIDxtZXRhZGF0YV9saWNlbnNlPk1JVDwvbWV0YWRhdGFfbGljZW5zZT4KICA8
bmFtZT5ldGh0b29sPC9uYW1lPgogIDxzdW1tYXJ5PmRpc3BsYXkgb3IgY2hhbmdlIEV0aGVybmV0
IGRldmljZSBzZXR0aW5nczwvc3VtbWFyeT4KICA8ZGVzY3JpcHRpb24+CiAgICA8cD5ldGh0b29s
IGNhbiBiZSB1c2VkIHRvIHF1ZXJ5IGFuZCBjaGFuZ2Ugc2V0dGluZ3Mgc3VjaCBhcyBzcGVlZCwK
ICAgIGF1dG8tIG5lZ290aWF0aW9uIGFuZCBjaGVja3N1bSBvZmZsb2FkIG9uIG1hbnkgbmV0d29y
ayBkZXZpY2VzLAogICAgZXNwZWNpYWxseSBFdGhlcm5ldCBkZXZpY2VzLjwvcD4KICA8L2Rlc2Ny
aXB0aW9uPgogIDx1cmwgdHlwZT0iaG9tZXBhZ2UiPmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHVi
L3NvZnR3YXJlL25ldHdvcmsvZXRodG9vbC88L3VybD4KICA8cHJvdmlkZXM+CiAgICA8YmluYXJ5
PmV0aHRvb2w8L2JpbmFyeT4KICAgIDxtb2RhbGlhcz5wY2k6dipkKnN2KnNkKmJjMDJzYzgwaSo8
L21vZGFsaWFzPgogIDwvcHJvdmlkZXM+CjwvY29tcG9uZW50Pgo=
--000000000000ee581006328668e7--

