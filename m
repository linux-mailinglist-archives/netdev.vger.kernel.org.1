Return-Path: <netdev+bounces-248991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313BD12585
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CFFA301470C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB04356A1A;
	Mon, 12 Jan 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfs0uqIo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CC356A2A
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218149; cv=none; b=FR2aKQQZZ9/N3qbVD4nmFMyhO2+lFpgeEdqlF+9tfBxha6gbb6sTFioHlYqgRVQCwDN9qA7PDJ0mla3e4XbrfFZg7zgcRbPmAOtaUuCH7OVswwm+k1d5P+UR2XaJOjY2whvImpowhqHxqUk4TiBNE79MThJcNAa+yP7miQcVjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218149; c=relaxed/simple;
	bh=/cZB6jAScdGWtlTD1wUvgFwqNswsMuCb5T8p3wPVa24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GRwTSwD8+4sOpBl2s/cLDOnbCO5nEyEYObXA+y0N+eUF/gJLOxmuqrw3uf7LOc9+c+aNVBZBG52NQI3gHSMYLB3ShO/+9zhy9jg4uNDue+CRiIwGfJW8X+9h2DWRzNgdzDuF+GAzpZPC+flbhut6tDBi/VhxXd9keex8I0uJjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfs0uqIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768218146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVdsttuN8LG2+FSiw2KfXuXK5R+7mNaRXlQUP1M6CHk=;
	b=cfs0uqIoYLOkpVj4DW2R5iwluTv7BmAoXdnmkxvs3oCJrTFco1bLTp3r9ALRQhcDlHaJjh
	GWS7mebRpm6al6WVUqS/g6GRIj/7ELF9m4q3Mj1tgUbTZOnCYlPmi86AO6qA062qw/oolU
	QW29GdxzndbwjB07YvHS/1lHmgWKKkQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-PR2pgkj8NdqOCA0nOnVW1w-1; Mon,
 12 Jan 2026 06:42:24 -0500
X-MC-Unique: PR2pgkj8NdqOCA0nOnVW1w-1
X-Mimecast-MFC-AGG-ID: PR2pgkj8NdqOCA0nOnVW1w_1768218142
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3FB119560A6;
	Mon, 12 Jan 2026 11:42:22 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76ACA1800577;
	Mon, 12 Jan 2026 11:42:19 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Jakub Kicinski" <kuba@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,  "Eric Dumazet" <edumazet@google.com>,
  "Kuniyuki Iwashima" <kuniyu@google.com>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Willem de Bruijn" <willemb@google.com>,  Netdev
 <netdev@vger.kernel.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
In-Reply-To: <06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com> (Arnd
	Bergmann's message of "Fri, 09 Jan 2026 13:56:38 +0100")
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
	<20260105095713.0b312b26@kernel.org>
	<20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
	<20260106151313.1f8bd508@kernel.org>
	<06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
Date: Mon, 12 Jan 2026 12:42:17 +0100
Message-ID: <lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Arnd Bergmann:

> On Wed, Jan 7, 2026, at 00:13, Jakub Kicinski wrote:
>> On Tue, 6 Jan 2026 11:32:52 +0100 Thomas Wei=C3=9Fschuh wrote:
>>> As for the failure in netdev CI however I am not so sure.
>>> Looking at net-next-2026-01-05--12-00, the only failures triggered by my
>>> change are also the ones from the bpf-ci. Are these the ones you meant,
>>> or am I missing some others?
>>
>> Multiple things broke at once so slightly hard to fish the relevant
>> stuff out from here:
>>
>> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-05-=
-15-00&pass=3D0&pw-n=3D0
>>
>> Here's one:
>>
>> make[1]: Entering directory=20
>> '/home/virtme/testing/wt-3/tools/testing/selftests/net'
>>   CC       busy_poller
>> In file included from [01m[K/usr/include/sys/socket.h:33[m[K,
>>                  from [01m[K/usr/include/netinet/in.h:23[m[K,
>>                  from [01m[K/usr/include/arpa/inet.h:22[m[K,
>>                  from [01m[Kbusy_poller.c:14[m[K:
>> [01m[K/usr/include/bits/socket.h:182:8:[m[K [01;31m[Kerror:=20
>> [m[Kredefinition of '[01m[Kstruct sockaddr[m[K'
>
>>                  from [01m[Kbusy_poller.c:12[m[K:
>> [01m[K/home/virtme/testing/wt-3/usr/include/linux/socket.h:37:8:[m[K=20
>> [01;36m[Knote: [m[Koriginally defined here
>
> Maybe we can change all the instances of 'struct sockaddr' in
> include/uapi/ to reference a new 'struct __kernel_sockaddr',
> and then redirect that one if the libc header got included
> first?
>
> struct __kernel_sockaddr {
>        __kernel_sa_family_t    sa_family;      /* address family, AF_xxx =
      */
>        char sa_data_min[14];           /* Minimum 14 bytes of protocol ad=
dress */
> };
> #ifdef _SYS_SOCKET_H
> #define __kernel_sockaddr sockaddr
> #endif
>
> This will still fail when a user application includes linux/if.h
> before sys/socket.h and then expects the structures in linux/if.h
> to contain the libc version of sockaddr, but hopefully that is
> much rarer. A survey of codesearch.debian.net shows almost all
> users of linux/if.h first including sys/socket.h, and most of
> them not caring about struct sockaddr either.

If you call the data member sa_data just like glibc, it will only fail
in C++, not C.  GCC considers the two definitions sufficiently
equivalent (even though glibc adds a may_alias attribute to meet POSIX
requirements), and duplicate definitions are permitted in C.

C++ with modules will probably support duplicate definitions, too, but I
haven't checked if it's possible to get this work with GCC 16.

Thanks,
Florian


