Return-Path: <netdev+bounces-97007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF378C8A5D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 18:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4492B23455
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2113D8A4;
	Fri, 17 May 2024 16:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1712FB04
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964777; cv=none; b=VMKkQM+1a/l63rEutfq9i8o/yfEZ/CY0nMoNatydHZ8JzR3eHPZyTs0d/gIC7vuBOtfLJ79Ks6uIkvUY5WANm0bKsF6vwLuMwB6p3p+CxbIPhU96uwA8B1tXczENfwqd7aFshlxGu3qzHXMFkB9CdatdeMWrk71yR5zgzG27IFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964777; c=relaxed/simple;
	bh=//J6KdjSBkRMhwZO41kIOhw5NU1oJPNlTI7cxTYqhnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IWWSl0sEuWymQxS4uk3/ajqf70Q8vdBKWBB29rtGiKBI2TPnDDYzQvnLSHytFsIJknVUxOZJhA9S0jNxBYyWy84w0cEC+BxpiiKQk7CI0H2n8Mjv7xdJJLSWuHEh02a2pQ8jGf71zXfK3flMBi53Z+7X3SI+cm/i+7CtEsJI9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-AUAXDtMBNf-A4McoWcuQxg-1; Fri, 17 May 2024 12:52:50 -0400
X-MC-Unique: AUAXDtMBNf-A4McoWcuQxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EA7A81227E;
	Fri, 17 May 2024 16:52:49 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C87E9123CAE0;
	Fri, 17 May 2024 16:52:47 +0000 (UTC)
Date: Fri, 17 May 2024 18:52:46 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCH net] ipv6: sr: fix memleak in seg6_hmac_init_algo
Message-ID: <ZkeLXpcSralGavwL@hog>
References: <20240517005435.2600277-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517005435.2600277-1-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-17, 08:54:35 +0800, Hangbin Liu wrote:
> seg6_hmac_init_algo returns without cleaning up the previous allocations
> if one fails, so it's going to leak all that memory and the crypto tfms.
>=20
> Update seg6_hmac_exit to only free the memory when allocated, so we can
> reuse the code directly.
>=20
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Closes: https://lore.kernel.org/netdev/Zj3bh-gE7eT6V6aH@hog/
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Hangbin.

--=20
Sabrina


