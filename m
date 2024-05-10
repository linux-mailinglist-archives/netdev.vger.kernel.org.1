Return-Path: <netdev+bounces-95360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F608C1F7A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418692834A1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFA15F330;
	Fri, 10 May 2024 08:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171D16079D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328535; cv=none; b=pG0zeYdm1I9xwVympUHzmzb22uQ54A1YIusKnsUMLbBLLoukOlPIFn6shCka8XfcZPOKyTl+v4HUbHkcG4UvguMFpcHeveeH1aIV2l/2XfXxhmuyicvMyQjox4E7RM814Hrj/wuD5ZZ3rlUbFks1V7MhHeS7AQ9VAXfkLK30hTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328535; c=relaxed/simple;
	bh=z+ksWPlLN107GUkpJIBKHWg2yrNzQw6r659ubj8s86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=spJLXKVd4wv7xt9gJOgURf48/zZEVUY5IiX7KkZuhna3xy7weMPmJJPjWKNeAzh+62Mzkdd0x5Yhc7O3RN2chQ1bY7bcK4pYFE5P534Odg6kQJE9jNy8T3391P78yXL3C1SHJ/QS682pWygu9cHCy7D50w+1feT386mrFcUjdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-KL8vUFcoPNeM7Mo_gr9ZLQ-1; Fri,
 10 May 2024 04:08:51 -0400
X-MC-Unique: KL8vUFcoPNeM7Mo_gr9ZLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F251380671E;
	Fri, 10 May 2024 08:08:50 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D6D51D69471;
	Fri, 10 May 2024 08:08:49 +0000 (UTC)
Date: Fri, 10 May 2024 10:08:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCHv3 net 2/3] ipv6: sr: fix incorrect unregister order
Message-ID: <Zj3WEJAkeTY2fLqK@hog>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240509131812.1662197-3-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 21:18:11 +0800, Hangbin Liu wrote:
> Commit 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and
> null-ptr-deref") changed the register order in seg6_init(). But the
> unregister order in seg6_exit() is not updated.
>=20
> Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-=
deref")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


