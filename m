Return-Path: <netdev+bounces-85205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A69B899C0F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6F0283E3D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623E16C694;
	Fri,  5 Apr 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+gN5foe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E116C696
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317664; cv=none; b=GQTjIij8gOO+rPivj2fO06cyUrKadF7c/o0H1UsG/u2y1FdqAZdUOlxij08Wf8MbMz2hEvWVPDJ2jcUIPrn+YhfOjRjVf2fHAv67m2dBzDQIK5TVFqxI7UEl9MUmzncdA6mYKKIThVwcOTSYUkrpAJUefH5fzJfpBzh2rw8D8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317664; c=relaxed/simple;
	bh=ITrJiqnWJcBUBsjtreu5uHqVgQg7tNfFt4MfNpjoo2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2cXG5ZG28J3bMVhXktvupOcd50WG0zYbpuVT6yppNELKlORhS9NYrtxCyhacqL2If8QbFyFD/hzeSl7CuSB3Gv7Syp3Dxmc+xQ5311D2aMxknUKSzC8xdPN4pkV9iod1LY6WDh+s8ZWCBVxekov/VucpT9u1z05p722azPFbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+gN5foe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712317661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2q0bq+8rYnfotnKobmYUc58ZUP40tUIQcWN7m/zdHw=;
	b=Z+gN5foex+tNPKo9U0YXi9rwfd5SX/5Q2o1F+UTWiT7v+3iLE2CJNEDMmGZXH+7bUk7C4u
	Dq+XavThe9wqOOm7x8VPZN60Potx7kctvYZskdyKjqCWukIfOuQq+VbWArxljbduUpEQz6
	wWnwCkB6cNyjMIX6NxpYtXyHsq9lHww=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-A7OYY6fTOUu_9sQiuhtoDg-1; Fri,
 05 Apr 2024 07:47:38 -0400
X-MC-Unique: A7OYY6fTOUu_9sQiuhtoDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086F11C01B28;
	Fri,  5 Apr 2024 11:47:38 +0000 (UTC)
Received: from griffin (unknown [10.45.225.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CB1AC01854;
	Fri,  5 Apr 2024 11:47:37 +0000 (UTC)
Date: Fri, 5 Apr 2024 13:47:31 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, Stephen Hemminger
 <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net] ipv6: fix race condition between ipv6_get_ifaddr
 and ipv6_del_addr
Message-ID: <20240405134731.5db239c0@griffin>
In-Reply-To: <3e90336c-6859-474c-aa1e-01ccc665ad49@gmail.com>
References: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
	<3e90336c-6859-474c-aa1e-01ccc665ad49@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Fri, 5 Apr 2024 13:31:52 +0200, Eric Dumazet wrote:
> refcount_t semantic should prevent this double transition to 0=C2=A0 ?

You're right. This was found in an old kernel where it manifested
by a crash. In not so ancient kernels there's a refcount_t WARN:

[  202.500654] refcount_t: addition on 0; use-after-free.
[  202.500665] WARNING: CPU: 0 PID: 1327 at lib/refcount.c:25 refcount_warn=
_saturate+0x74/0x110

I knew about that but I wrote the commit message on the old kernel and
when updating it I missed this spot. Sorry about that.

> Can you include a stack trace in the changelog ?

I don't think I have a stack trace from the latest net kernel; let me
get one.

> Otherwise patch looks good to me, thanks !
>=20
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the review! v2 with the updated commit message coming on
Monday.

 Jiri


