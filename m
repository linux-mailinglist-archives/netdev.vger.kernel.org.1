Return-Path: <netdev+bounces-95922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462248C3D7F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717191C21258
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588CC147C7F;
	Mon, 13 May 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZyl9YrV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C81474C8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590005; cv=none; b=VCH5C+2ItXt0/m9cdGrTZBBTOgRVLt5G7J9Zol0OqNkpNrPA2Tg4J9FvGTMCnGzubmYo5Iphz8nZVHWYPAhBqQaCi2RX4TRltrAdZe/EfSzt3J/LOuDxiEPq49bD6JGaciFn4aIkIOyrNXVa6vBjnKZ8oVruNgaKX0ARJawPOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590005; c=relaxed/simple;
	bh=llMwm1BKII5UXiY/o5N362Dkysqg12XYpo/sRjuvWxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VlgxaCERqZlgeQ5H/dcx0hjdTb/a7xEtQ0uQLUhxycQO1+38upD5ppnPcCnqq9x0Oq6vQZ2aVfd5pgkNJaUZX7+2R9rvGV1O417k/+xRscwM+OCcOlIlxva+pKqzaMaGRNO7px34aKUogMtetVY24Uzm3cXopXH6FqKl8GxOsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZyl9YrV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a64db066so1017381666b.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715590002; x=1716194802; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=llMwm1BKII5UXiY/o5N362Dkysqg12XYpo/sRjuvWxM=;
        b=GZyl9YrVjNNHlwzeKVi4CeR2PsgaMBk8BpuDZNW4D4DslJo0xe/24BrLMB2Um4ww2x
         QfkYwRpn5QU5esZAs5ctg5qdZKLKl8brfmx3f/uwSubmNJ4OAyYN6NMs/2LQhdvA8Rpy
         G8pLplbwklmWmPpC21Tbkfaep3E3/JIlvmDoiHnuNcwukYxeeq2tQSATuriGMvSN4dfa
         VO0cwXzFbSVQt456T2jkKYDSp5LLJfc5iCtY+HwXJpiECJWqiq0uHs8ZJ+yMdlSymsgf
         vatRd9qgyPHLRAvDvNSuIf5R+NVmR9UKPBDJFAXPxFsJPyLzK+FfuYiePi+dv02ak9L6
         lqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715590002; x=1716194802;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llMwm1BKII5UXiY/o5N362Dkysqg12XYpo/sRjuvWxM=;
        b=jH3DvgMbL4goM3t1oDr1Z2CTKjtBFF2HgKpKrEsbLLUd5Qd4J10/TLH/5MDnXc6Up6
         1EGYYQy3Wlz34DaNRE1wMbH8y37mY4QKIcAxWQqc/vmBA1Fu3M/pOpCeI84P33dfaB/N
         8u55stoAWPDl98YvSAcMar4BwNhjFg5GeZZ2ES7r6imhinhruv4zg0XfQYYOduSKCUDr
         Bbf29F8bPC3S+qyPb9G+bJ4+ombgUtja2GNZ5as6XjDY0Hx6/RJYmY6O4tjbPKcF7nQI
         hOEmZYceqWpkI3P4GUUY/jzFtDLjkBUrGGUyU1NyAZGu+65qBOzjfyFckcmS7ma/qvGf
         SDUw==
X-Gm-Message-State: AOJu0Yz56KtMtiU135XXLsXWrlDYpHRIltrGm/QebAkp+3BV1ObiArF8
	1RZvWckXi4sHhSt3IfEkHsplvYjod5iCNrYbTThkOCj4RWfjAlubFGKoNqbbt6SwZ38OCGR2fKK
	xOPday1XtFGxud3YgGYFZgMdRB6mecHiZe9z7Lw==
X-Google-Smtp-Source: AGHT+IGw4UeaEF1A2A8SIdOzsKRDhgmp35ANu/NeoOBUvSCQC6Muqom+dHlIuY0oc3PVomnwn6kqv2PkPtl/jsgNIpc=
X-Received: by 2002:a50:9e64:0:b0:56e:2daf:1ee6 with SMTP id
 4fb4d7f45d1cf-5734d5c156bmr5350777a12.16.1715590001814; Mon, 13 May 2024
 01:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antaryo Prospero <jansaley@gmail.com>
Date: Mon, 13 May 2024 11:46:30 +0300
Message-ID: <CACFj3Te-_zda_VKa-So3NMkpDn6Tijj=u+S6GSejB8FALSexEQ@mail.gmail.com>
Subject: [BUG] IPv6 GRE does not work in multipoint mode
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I tried to use GRE in multipoint mode, without specifying the remote
address in GRE config.

I use the following configurations for tests:
Host1 - Router - Host2

#Host1 GRE

auto mgre0
iface mgre0 inet6 static
address 2024:10::21/112
pre-up ip tunnel add mgre0 mode ip6gre key 1 tos inherit ttl 64 local
7d:168::2001
pre-up ip link set mgre0 mtu 1400
pre-up ip link set mgre0 multicast on
post-up ethtool -K mgre0 tx-checksumming off > /dev/null
post-down ip link del mgre0

#Host2 GRE

auto mgre0
iface mgre0 inet6 static
address 2024:10::22/112
pre-up ip tunnel add mgre0 mode ip6gre key 1 tos inherit ttl 64 local
7d:168::2002
pre-up ip link set mgre0 mtu 1400
pre-up ip link set mgre0 multicast on
post-up ethtool -K mgre0 tx-checksumming off > /dev/null
post-down ip link del mgre0

where 7d:168::2001 and 7d:168::2002 are the local network addresses of
Host1 and Host2 respectively.

Because iproute2 takes IPv6 addresses as invalid MAC addresses, I have
to use my own tool based on iproute2 to create neighbour records.

But, as the result, the packets are dropped. At the same time, GRE in
IPv4 multipoint mode works and allows to connect two or more nodes.

E.g. this IPv4 GRE config, which differs only by IP address family, works:

#Host1
auto mgre0
iface mgre0 inet static
address 10.10.10.3/24
pre-up ip tunnel add mgre0 mode gre key 1 tos inherit ttl 64 local 172.168.10.3
pre-up ip link set mgre0 mtu 1400
pre-up ip link set mgre0 multicast on
post-up ethtool -K mgre0 tx-checksumming off > /dev/null
post-down ip link del mgre0

#Host2
auto mgre0
iface mgre0 inet static
address 10.10.10.4/24
pre-up ip tunnel add mgre0 mode gre key 1 tos inherit ttl 64 local 172.168.10.4
pre-up ip link set mgre0 mtu 1400
pre-up ip link set mgre0 multicast on
post-up ethtool -K mgre0 tx-checksumming off > /dev/null
post-down ip link del mgre0

