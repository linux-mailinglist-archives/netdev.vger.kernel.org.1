Return-Path: <netdev+bounces-190465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E476BAB6DE0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BB41B68136
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E77192D9D;
	Wed, 14 May 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqXRLQPF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E81922FB
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232062; cv=none; b=UjFtYwwVeDtTBGZvr6AzDfRqJGBhdiiJviyFNJf0n/XmAv5onZ5YMZ2p6o63UF53VCn5D7HSTbMggIwg6233ujhHzQXWhFWILom92Q9kqniLwE4CLMI7FHI4L+WBtwEBXRRScbHJCBbVMLz+P5LHLslNgr0EOuFfCmxTXLUpckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232062; c=relaxed/simple;
	bh=RVMNYOs/g4OLLiPjgsqo/uzCnoZJN9AOqqjLaO9mKVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HSYV0nnU+nSfJb/2SmglniDKCXiGKhBcgUCS1MKH7xLUA6ICRpcCSmSC+qCRDOjL/j46x3qvmVmUbATtTFzIOMZRGvkLPDObbpuvjQpfHSecJBZF3BmiRMnvZRZAJHVjkcbjRrLq413StzlbYvysEqTTei2KveGV0doW0tW5QWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqXRLQPF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVMNYOs/g4OLLiPjgsqo/uzCnoZJN9AOqqjLaO9mKVI=;
	b=fqXRLQPFK6Iu7BsyPGD1qxSOhbixjweKR+3qQnShb2NAo2QPSnpoepcBXiJ6WAz0GdLftK
	iVcpxbjqnWjBH5Ae2F2w/JnUAEn1qqsEaFu/AjQejqa51CAIwTImu93RoqDHN4cji4VzdM
	vK9S3iOHgf3+TiecvJX5VQmyZdzDi1o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-WMjgwYhsPe6gYrFWt1tcwA-1; Wed,
 14 May 2025 10:14:16 -0400
X-MC-Unique: WMjgwYhsPe6gYrFWt1tcwA-1
X-Mimecast-MFC-AGG-ID: WMjgwYhsPe6gYrFWt1tcwA_1747232054
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0896B195608C;
	Wed, 14 May 2025 14:14:14 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56CE518001DA;
	Wed, 14 May 2025 14:14:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v4 08/15] openvswitch: Use nested-BH
 locking for ovs_pcpu_storage
In-Reply-To: <20250512092736.229935-9-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Mon, 12 May 2025 11:27:29 +0200")
References: <20250512092736.229935-1-bigeasy@linutronix.de>
	<20250512092736.229935-9-bigeasy@linutronix.de>
Date: Wed, 14 May 2025 10:14:09 -0400
Message-ID: <f7t8qmze0um.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> ovs_pcpu_storage is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> The data structure can be referenced recursive and there is a recursion
> counter to avoid too many recursions.
>
> Add a local_lock_t to the data structure and use
> local_lock_nested_bh() for locking. Add an owner of the struct which is
> the current task and acquire the lock only if the structure is not owned
> by the current task.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


