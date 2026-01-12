Return-Path: <netdev+bounces-249026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F462D12DB9
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4690A301516E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288A358D00;
	Mon, 12 Jan 2026 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="As7dsUl3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D153587A1
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225045; cv=none; b=BAFWVdcOdd2l2fEla43BYbrKHJg7NTepqKTsS8/hAGrVLZCixuwxcJmp1WINoE1SWtFTrzeBeLCft9LFfk9c/8KyxZ0uMNrFLbzNfH2XIY4AnBVcpBFV+67egBHI37GZi37rlGqZPd9uJcRwWuk880nggJykpS+pWpJMJvjO/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225045; c=relaxed/simple;
	bh=cxa/5Rl6a1TnXAsHeNesfXs4j6wa884AGuYzr6qKe0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0cYLTf2pz+lAoZj7zaP4alRNCO5ZY02N+rLE68Q6Xf9r+rlG/pEyVQUHSvqNp/PAC5Ed4TYfbylcIFuNHnPLv7HlGZHQFhieplBMVC5Jiv7IR2LcE6194ZHIQT4p/hpBBy1XMz1Syl+2P3GUVF/f1SQt2IoFwLbhHNeDIHLOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=As7dsUl3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768225042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STZX6GfdAf+NNNJHFcpfAAJdJSUJl9RVZRSMHHM/8d4=;
	b=As7dsUl3edpxxUXqrpuuxCT+JYcSMqSkNYLSuseU07vOHQCnGprk4PjF48qrXjQJuFC+gR
	d/pMoZb4sm7R6kT+/oSUQYzM623TSdtVQJIdEL0VXFvEhXpe7lsUDt3FnR1HOFPRpk7Vqe
	UgNMAHQ8VeYRZddg89ladZiUbrBSm/4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-Hk15Jl2ZMIqKS-Dr_qmnxA-1; Mon,
 12 Jan 2026 08:37:22 -0500
X-MC-Unique: Hk15Jl2ZMIqKS-Dr_qmnxA-1
X-Mimecast-MFC-AGG-ID: Hk15Jl2ZMIqKS-Dr_qmnxA_1768225040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60FD71956050;
	Mon, 12 Jan 2026 13:37:20 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B6CF30001A2;
	Mon, 12 Jan 2026 13:37:17 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,  Jakub Kicinski <kuba@kernel.org>,  Eric
 Dumazet <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  Netdev <netdev@vger.kernel.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
In-Reply-To: <20260112143158-efc74534-0283-4db1-812f-402794eb8844@linutronix.de>
	("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 12 Jan 2026
 14:33:39 +0100")
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
	<20260105095713.0b312b26@kernel.org>
	<20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
	<20260106151313.1f8bd508@kernel.org>
	<06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
	<lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
	<20260112124604-dbf7f68d-2182-438f-9495-2931cac02a81@linutronix.de>
	<lhutswrj73u.fsf@oldenburg.str.redhat.com>
	<20260112143158-efc74534-0283-4db1-812f-402794eb8844@linutronix.de>
Date: Mon, 12 Jan 2026 14:37:15 +0100
Message-ID: <lhuikd7j6k4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Thomas Wei=C3=9Fschuh:

> On Mon, Jan 12, 2026 at 02:25:25PM +0100, Florian Weimer wrote:
>> * Thomas Wei=C3=9Fschuh:
>>=20
>> >> If you call the data member sa_data just like glibc, it will only fail
>> >> in C++, not C.  GCC considers the two definitions sufficiently
>> >> equivalent (even though glibc adds a may_alias attribute to meet POSIX
>> >> requirements), and duplicate definitions are permitted in C.
>> >
>> > clang is not so lenient and will error out.
>>=20
>> It seems it accepts it if you switch to C23 mode.
>
> The currently supported baseline for UAPI headers is C90.
> We can't really force userspace to switch here.

Including libc and UAPI headers at the same time is still officially
unsupported, right?

We don't test for it, so lots of combinations do not work.

Thanks,
Florian


