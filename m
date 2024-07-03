Return-Path: <netdev+bounces-109070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EF926C63
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6153228185A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C3188CCF;
	Wed,  3 Jul 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlPr9EN8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA60136643
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048954; cv=none; b=XFxjwxwx2lKPS9+ZRr4YYwRKlHpXDnW3FPPPleWCol58huKM8Tx57I9NveKA0fiFGC2pxuvq/rIyqsAvIrMM7Ys1j0kN5vbkNM3XlSyUEZbKBZHBfnANNVe1MOpIPA+wg86xA7hlBKqb1jjXclKA+BrqQrF3TPbYBJfR7GHE63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048954; c=relaxed/simple;
	bh=PIsdRgXI+fY7rouQEEP+4J4HN9o2IsbYx0bdZM7l2AY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLqKMOhlwQ/eJ6Wdux6vmIYlNPIUmCXQj2dGSoeGC+XqcnINOL3dO5Vr662h1I0THhRUavuVLV9ezot5dPSJMMxM2XFY+54cHuBEYYnrtlFEImT3Anp60i1IU52VwLTYyQrKOZtRgBZKYhiT5sdZRy4PDgITzS9pesnIIv8x/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlPr9EN8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720048951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PIsdRgXI+fY7rouQEEP+4J4HN9o2IsbYx0bdZM7l2AY=;
	b=DlPr9EN89q4CkdH/6D6cJ2I8FiLfXplx2r2DZgxcaLSM3ueQeh04EW8UgGCCnmgopCbgCi
	FfmpF0Fx8oJwVpk9DtY/hsW+T0jdy2hoZDxRHMwKQzvqX/56VXRNi43oa/0WMS5Ax3iaVg
	ZfAZ+Bg1VhS5+g5p+dvTQycYNYNXDm8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-XPj9LPQXOR-4a9IsThxR4Q-1; Wed,
 03 Jul 2024 19:22:25 -0400
X-MC-Unique: XPj9LPQXOR-4a9IsThxR4Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03D541955BC7;
	Wed,  3 Jul 2024 23:22:24 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB621300023D;
	Wed,  3 Jul 2024 23:22:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: dev@openvswitch.org,  netdev@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] openvswitch: prepare for stolen
 verdict coming from conntrack and nat engine
In-Reply-To: <20240703104640.20878-1-fw@strlen.de> (Florian Westphal's message
	of "Wed, 3 Jul 2024 12:46:34 +0200")
References: <20240703104640.20878-1-fw@strlen.de>
Date: Wed, 03 Jul 2024 19:22:19 -0400
Message-ID: <f7tplrunjro.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Florian Westphal <fw@strlen.de> writes:

> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP
> verdict with NF_DROP_REASON() helper,
>
> This helper releases the skb instantly (so drop_monitor can pinpoint
> precise location) and returns NF_STOLEN.
>
> Prepare call sites to deal with this before introducing such changes
> in conntrack and nat core.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.om>


