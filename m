Return-Path: <netdev+bounces-69711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A282D84C51E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A841C2199A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE51B95B;
	Wed,  7 Feb 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6sO21/I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37891CD38
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288309; cv=none; b=IoCNmpYVpz1r4Ji/jnu+FCSIz0ShQPNDiB2TSGC4/+NwL63N2z4YGt9Xp/sc4gW2/OdHLbsfGMhIr6gKPYuKRYOHVvb448kE1OSlzGoR4uOBpy9ASI3lZvX99yrRuL+8BGv7IRslRiZmMhHXrEeA/zl3IB0eqtrH5ZYIsa+R1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288309; c=relaxed/simple;
	bh=qeDEPTK4m6VBZwGjwpCHxfCWgFesd/WrAsfsyaMOeJk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R8t3Nf8coo1WghA+PF0CfoEFWmOB+IMF9MwhX9gFxOHvuvYCao2bX3dlUOxzaL/spJbIyA9N/evgBEw8XlEWMGXpFO/aLH2Y9BgCFA7Sqsh8sOBKR9YKKRsw4mvl2fOqNKDt4vzLV+rJrxqJ2pv8MUjRDnpME6CyPgdAswqyLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6sO21/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707288306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhtIBc1C8bQwbqg4JYyqcWdulDcmw0/HXgXvj6B8//o=;
	b=T6sO21/Ihv6qb+ci28DLw/aXiwL+3nvogPFCVIcJ7cjLOEYTs99hOPH6BQTJy7g76ZMwIo
	HZCCSYR5xi7AxTRsHUxmQZoLP+fnoHheA78Aair1c7UxtB1BaIIsHQraBluETjTkSYS/PA
	SJhyx2HZ6Zx0f0yj+ssa6yS6LHB1F6o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-5JCEKhvfOhG1NIIdaYYkiQ-1; Wed,
 07 Feb 2024 01:45:02 -0500
X-MC-Unique: 5JCEKhvfOhG1NIIdaYYkiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64971280AA20;
	Wed,  7 Feb 2024 06:45:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5304A492BC6;
	Wed,  7 Feb 2024 06:45:01 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stephen Gallagher <sgallagh@redhat.com>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] iproute2: fix type incompatibility in ifstat.c
References: <20240206142213.777317-1-sgallagh@redhat.com>
	<20240206191209.3aaf9916@hermes.local>
Date: Wed, 07 Feb 2024 07:44:59 +0100
In-Reply-To: <20240206191209.3aaf9916@hermes.local> (Stephen Hemminger's
	message of "Tue, 6 Feb 2024 19:12:09 -0800")
Message-ID: <877cjg6adw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

* Stephen Hemminger:

> On Tue,  6 Feb 2024 09:22:06 -0500
> Stephen Gallagher <sgallagh@redhat.com> wrote:
>
>> Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
>> type, however it is defined as __u64. This works by coincidence on many
>> systems, however on ppc64le, __u64 is a long unsigned.
>>=20
>> This patch makes the type definition consistent with all of the places
>> where it is accessed.
>>=20
>> Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
>> ---

Patch was:

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..767cedd4 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -58,7 +58,7 @@ struct ifstat_ent {
 	struct ifstat_ent	*next;
 	char			*name;
 	int			ifindex;
-	__u64			val[MAXS];
+	unsigned long long	val[MAXS];
 	double			rate[MAXS];
 	__u32			ival[MAXS];
 };

> Why not fix the use of unsigned long long to be __u64 instead?
> That would make more sense.

You still won't be able to use %llu to print it.  I don't think the UAPI
headers provide anything like the <stdint.h> macros because the
assumption is that %llu is okay for printing __u64 on all architectures.

But we have this in POWER:

/*
 * This is here because we used to use l64 for 64bit powerpc
 * and we don't want to impact user mode with our change to ll64
 * in the kernel.
 *
 * However, some user programs are fine with this.  They can
 * flag __SANE_USERSPACE_TYPES__ to get int-ll64.h here.
 */
#if !defined(__SANE_USERSPACE_TYPES__) && defined(__powerpc64__) && !define=
d(__KERNEL__)
# include <asm-generic/int-l64.h>
#else
# include <asm-generic/int-ll64.h>
#endif

I didn't know some architectures are that =E2=80=A6 different.  Sadly this
wasn't fixed as part of the transition to powerpc64le.

I suppose iproute2 should build with -D__SANE_USERSPACE_TYPES__.

Thanks,
Florian


