Return-Path: <netdev+bounces-162620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C210CA2765A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542CD163EF3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64163215175;
	Tue,  4 Feb 2025 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyw8077I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CA21507F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684009; cv=none; b=K5JA6/gAj55PnRqVl9gd6PG7Oju5WB4HCvn0Ie7K671cyJkBE2h2lSxF2fg0mrtw/UPRD6ofMLmqkRrFre94WaGujR4nT+aJPwwr/yw4Pi4J7HhNVHxUtrOXnlT1kjWynQ2/4CC4EhYhho8WsSREHompHgqgU3G2uzsIqo0/RTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684009; c=relaxed/simple;
	bh=nqEa8osaLWkh1DMpIcJVwzd8GoEpQFsMuDLO7B4jjoM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CCPd0vAHwhywJUf9qAcv4hyhvOJC94islEk1BFwGbL6FE6j4vou/BgNQN1lzJJc1koIe3Afl6fKwFoJv8NHeusn5Zv3URmSbay9K/oTLTuQOqfDGRawCGTvK+eMB1rSQ4mMA7jHT7dNq5/igmHM3SSiwnyBI3m8YajADFpdLLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyw8077I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738684006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqEa8osaLWkh1DMpIcJVwzd8GoEpQFsMuDLO7B4jjoM=;
	b=iyw8077ILjgRy7y/OnE8Rdn3HtT3ylxaxjw/O1xsI0jWFtmAbrXksaHM45QqmAHuYKZBh5
	Q6pj6vX6GMyWHPP4pzZTmIQ8ow5m2hqdgGSsMkVLeWTTGFtLPawtRBOn484DG8Lmc/ZYpB
	KRwRMWa2q/Ufcbb1ms83mqIs/Rq2w0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-HL0SllHwMDKy3yEHRKsyQA-1; Tue,
 04 Feb 2025 10:46:43 -0500
X-MC-Unique: HL0SllHwMDKy3yEHRKsyQA-1
X-Mimecast-MFC-AGG-ID: HL0SllHwMDKy3yEHRKsyQA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ACFC18333F0;
	Tue,  4 Feb 2025 15:46:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 987F2180035E;
	Tue,  4 Feb 2025 15:46:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aa464cc9-7259-4745-bc9a-45b34cf66a60@redhat.com>
References: <aa464cc9-7259-4745-bc9a-45b34cf66a60@redhat.com> <716751b5-6907-4fbb-bb07-0223f5761299@redhat.com> <20250203110307.7265-1-dhowells@redhat.com> <20250203110307.7265-3-dhowells@redhat.com> <549953.1738678165@warthog.procyon.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/2] rxrpc: Fix the rxrpc_connection attend queue handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <562628.1738683993.1@warthog.procyon.org.uk>
Date: Tue, 04 Feb 2025 15:46:33 +0000
Message-ID: <562629.1738683993@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Paolo Abeni <pabeni@redhat.com> wrote:

> I guess we are all better off without the need for a repost. I'm
> applying it as-is.

Thanks :-)

I think that patch 1 (that I dropped) is probably correct, but that it brings
a further bug to the fore, so I'll track that down before resubmitting.

David


