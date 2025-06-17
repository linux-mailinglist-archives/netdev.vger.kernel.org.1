Return-Path: <netdev+bounces-198535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF68ADC964
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E07A7146
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFD1EDA3C;
	Tue, 17 Jun 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5XOKB7I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4B1459EA
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159889; cv=none; b=YLpULwrd3WyGqlXlhUz0F1rIc/O99Tr64Ie2IdUtriCFXp3wU+JsgxZgSeajXboXntAHr0aD6p6Lw81rtAHDbGVoETjh+i5vXpLQHzSz7EWMURGgfPEUFzWjp+UxIxs0xWQpuITy7h3bb82UDRhDMDQyU+Dp2jwP7nRgy1HdGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159889; c=relaxed/simple;
	bh=CbtyhyV0vJi/H/XvLk3VNzZ26rtNJzm4aQ047PyL+KQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jF8tFvtV79Eu9HOBu6cc3yHdFl29EWB/zC6bVv3N/blfOFPuwuX3gICOQAagccZRJ/YF3+jvI11C73DUeJ192jQIeeruTcUcXosmGSqibyVVmVaQA7jQYZAUTjK3+ITKeJSVQ3txQ01MQ3Z+wkibIUmlvUillU+xaIPoevh6uQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5XOKB7I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750159887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbtyhyV0vJi/H/XvLk3VNzZ26rtNJzm4aQ047PyL+KQ=;
	b=X5XOKB7Ig921PVhbUR/47raAY/jKj7zpNiY1uS67PJtUXz/iyLYsKVmjJ3G0d5EmlGgjWp
	H3FNyHGvJTjUS3YUdFWXcBo64U47MqolhvXLCLRZRnpc5Dl2abCEKNSUgzfq0BiwbHR99W
	DBYArD9tFCt046qVT3msUb+nNggWYGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-eqNtu5pINqmTtdwGJ5bylQ-1; Tue,
 17 Jun 2025 07:31:25 -0400
X-MC-Unique: eqNtu5pINqmTtdwGJ5bylQ-1
X-Mimecast-MFC-AGG-ID: eqNtu5pINqmTtdwGJ5bylQ_1750159884
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D439C19560B7;
	Tue, 17 Jun 2025 11:31:23 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.166])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4269D19560A3;
	Tue, 17 Jun 2025 11:31:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Gal
 Pressman <gal@nvidia.com>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: Allocate struct
 ovs_pcpu_storage dynamically
In-Reply-To: <20250613123629.-XSoQTCu@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Fri, 13 Jun 2025 14:36:29 +0200")
References: <20250613123629.-XSoQTCu@linutronix.de>
Date: Tue, 17 Jun 2025 07:31:14 -0400
Message-ID: <f7tqzzipptp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> PERCPU_MODULE_RESERVE defines the maximum size that can by used for the
> per-CPU data size used by modules. This is 8KiB.
>
> Commit 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into
> one") restructured the per-CPU memory allocation for the module and
> moved the separate alloc_percpu() invocations at module init time to a
> static per-CPU variable which is allocated by the module loader.
>
> The size of the per-CPU data section for openvswitch is 6488 bytes which
> is ~80% of the available per-CPU memory. Together with a few other
> modules it is easy to exhaust the available 8KiB of memory.
>
> Allocate ovs_pcpu_storage dynamically at module init time.
>
> Reported-by: Gal Pressman <gal@nvidia.com>
> Closes:
> https://lore.kernel.org/all/c401e017-f8db-4f57-a1cd-89beb979a277@nvidia.com
> Fixes: 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into one")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> Gal, would you please be so kind and check if this works for you?
>

I was hoping Gal would have gotten back by now.

Reviewed-by: Aaron Conole <aconole@redhat.com>


