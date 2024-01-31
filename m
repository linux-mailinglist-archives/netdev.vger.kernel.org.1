Return-Path: <netdev+bounces-67671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A424844842
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C3E1F2619F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E13E494;
	Wed, 31 Jan 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDcRfQCE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A03AC26
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730631; cv=none; b=Zrpfj+5AQ7IDlQwYshb9ZnDUme7OJYC5Ze6njRgrFRR1ikY2iBny8gAozZyL4dxQqSnq00SOGkwHXR5rE5jxM85+gPH2OOrpjtSTwfaAbY5PVVm6NabA6kowjYwphcVBZ00mU5KO/nWY6ECnnkV+SA5QiLPwzWh2jalEeeoNQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730631; c=relaxed/simple;
	bh=vm1VvPWS8u/0sVVO0sq2qAm/X+8Dw5pmdJyX/qXhvX8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=fE3OiYzCQ5FUQ1cjkaJxnoknMtNDMQiMidiws7iLMQFJ8Fd+kKlL3N5OwI3VyqOYWd+LdTfr23ZS+KvoQfDiJRIgFdPARiKSYCqN07SPV1I6DdsKZUBE+K/CC7MGAMXkMva8zd10axuL97DegiE7d7YOVC7Ckxon4BK+jklb/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDcRfQCE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706730628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rF0QFeVS0b/AoQ7bIaAq+Ck/8ND4nETi8q3EifYpCJ4=;
	b=MDcRfQCEkiOCgU+sS6H86duTIktXp1sgHF8qBybZvN8YbkAMzswL7Nl57AH2mhYC9X22gK
	cAUBys2ml8Y+sSNulPF0ui8SV2j4wQcOTuCTf2qK38tE6K3WxQeKwR31VoyTufK2OS68NR
	rDEo6iw6TQjmAdgPqF/hcDWxHgbGfHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-7D72DHpwNK2O5iHGjDusPg-1; Wed, 31 Jan 2024 14:50:26 -0500
X-MC-Unique: 7D72DHpwNK2O5iHGjDusPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048FD84A291;
	Wed, 31 Jan 2024 19:50:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56130C259DD;
	Wed, 31 Jan 2024 19:50:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240131155220.82641-1-bevan@bi-co.net>
References: <20240131155220.82641-1-bevan@bi-co.net>
To: Michael Lass <bevan@bi-co.net>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    regressions@lists.linux.dev
Subject: Re: [PATCH] net: Fix from address in memcpy_to_iter_csum()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2259906.1706730624.1@warthog.procyon.org.uk>
Date: Wed, 31 Jan 2024 19:50:24 +0000
Message-ID: <2259907.1706730624@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Michael Lass <bevan@bi-co.net> wrote:

> While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
> address passed to csum_partial_copy_nocheck() was accidentally changed.
> This causes a regression in applications using UDP, as for example
> OpenAFS, causing loss of datagrams.
> 
> Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Signed-off-by: Michael Lass <bevan@bi-co.net>

Acked-by: David Howells <dhowells@redhat.com>


