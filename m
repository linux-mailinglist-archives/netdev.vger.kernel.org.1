Return-Path: <netdev+bounces-90070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D88ACA04
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AB2B22064
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF013E3EB;
	Mon, 22 Apr 2024 09:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C913DDCB
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779700; cv=none; b=o4T8UWfv3YFqGEAn2CYLpNrBLZ44LRvJKCwHfkPa7lwZE6G2owP/u9aKpG0Kk6Z4BDDY1FPybUpW8IRVwnsL7Gvo8HT13Xi8j1z3HZ2UkiLmt6FG6W/pqI1fC/bl+GS+eGPUcTGOjnZxf/1C0wGJbrV8L2stEGSaDB1hMSYdowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779700; c=relaxed/simple;
	bh=6q/ZRJ/g/sWksZ+7vdhwG6t29DJyBi+EgE2kDbBD+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ToWmhh/yXFGT4Mj+bufOUughc7Go6p8NqLj+hb+efpFkNdzeLorwmeF4LAAyTQGk1KaqzU665Rk6+OgN8zr0TPZ2m0tyyw2GXH8d+bKR6DS9lBdLYwZo+pu0+SYoa1YIrl3EhmvtvQQj0pENxv4RCf3QLbCe8EBo7nuSXiW4K9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-HQeiAEzjN7u5ly7_y_lhvQ-1; Mon,
 22 Apr 2024 05:54:47 -0400
X-MC-Unique: HQeiAEzjN7u5ly7_y_lhvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61EE03C40B54;
	Mon, 22 Apr 2024 09:54:47 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B80C13FA6;
	Mon, 22 Apr 2024 09:54:45 +0000 (UTC)
Date: Mon, 22 Apr 2024 11:54:44 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v11 2/4] xfrm: Add dir validation to "out"
 data path lookup
Message-ID: <ZiYz5Om5OtivN7cV@hog>
References: <cover.1713737786.git.antony.antony@secunet.com>
 <bae7627414f03223034371142fa870a430cb3c5e.1713737786.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bae7627414f03223034371142fa870a430cb3c5e.1713737786.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-22, 00:27:48 +0200, Antony Antony wrote:
> diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
> index 5f9bf8e5c933..98606f1078f7 100644
> --- a/net/xfrm/xfrm_proc.c
> +++ b/net/xfrm/xfrm_proc.c
> @@ -41,6 +41,7 @@ static const struct snmp_mib xfrm_mib_list[] =3D {
>  =09SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
>  =09SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
>  =09SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
> +=09SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR)=
,

This needs a corresponding entry in Documentation/networking/xfrm_proc.rst

--=20
Sabrina


