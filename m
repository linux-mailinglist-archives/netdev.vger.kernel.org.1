Return-Path: <netdev+bounces-95364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1F8C1FC5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CB28505C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCCB15FCE8;
	Fri, 10 May 2024 08:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8A14BFA8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329940; cv=none; b=fmv76m/PEYVK3tInmu+fnAIUQtnnV2WFzp8QVrlxvZjYzLKP7UQz3AguAiODVB1OTpNjPbvV0inS4cyBSnbGypP0h8UDECfWcNXdv3awSlEGh53iTdgREyaqvd1oJ4L9cDw+cTb5ZC/ELHsl+AtEU2EqfQSieO+v1U7txhIKfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329940; c=relaxed/simple;
	bh=J9q2pVpfpj1c03FoCvmKH9LB8aVSugiXrIZyJ3Kh4AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D7oCQD1eqI5x+/ZU5L5/qs8n26siH2PSdNU8QTHZCuvYy2YGFb42aJdIe5D0fEd0hFpPaTL9+xtkXY8fF9O8hn1jRZ86qgpExlC40awu49kD0yA1khx9X183usyeC9IaerEC2K41iRpt5BjG41vMSLseR0i0g9vgTDN+aHPzsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-lwyx7EDSOuWfjvk0ySmylg-1; Fri, 10 May 2024 04:32:11 -0400
X-MC-Unique: lwyx7EDSOuWfjvk0ySmylg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98183185A78E;
	Fri, 10 May 2024 08:32:10 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD7D049B523;
	Fri, 10 May 2024 08:32:08 +0000 (UTC)
Date: Fri, 10 May 2024 10:32:07 +0200
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
Subject: Re: [PATCHv3 net 3/3] ipv6: sr: fix invalid unregister error path
Message-ID: <Zj3bh-gE7eT6V6aH@hog>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240509131812.1662197-4-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 21:18:12 +0800, Hangbin Liu wrote:
> The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> is not defined. In that case if seg6_hmac_init() fails, the
> genl_unregister_family() isn't called.
>=20
> This issue exist since commit 46738b1317e1 ("ipv6: sr: add option to cont=
rol
> lwtunnel support"), and commit 5559cea2d5aa ("ipv6: sr: fix possible
> use-after-free and null-ptr-deref") replaced unregister_pernet_subsys()
> with genl_unregister_family() in this error path.
>=20
> Fixes: 46738b1317e1 ("ipv6: sr: add option to control lwtunnel support")
> Reported-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

seg6_hmac_init_algo also returns without cleaning up the previous
allocations if one fails, so it's going to leak all that memory and
the crypto tfms.

--=20
Sabrina


