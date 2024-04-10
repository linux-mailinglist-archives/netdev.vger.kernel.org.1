Return-Path: <netdev+bounces-86463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82489EE1B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB0E283F1A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB221552E1;
	Wed, 10 Apr 2024 08:57:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16A1494D6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739454; cv=none; b=paf+1Yy7f/7PLewLLthA9ERyC5+S0mLnSiRddRvBr8OUUg83rRRgeD/jDeZ3ddePYF5re3N2+REYBdkFJyZJtepRp5ZdlHqFyF7H9pfojvIIbkFQOxCf0Kzi4AHFItxJTl32I0uoCj4sS5aOZqP2p5lDmVLbwbgOOZn9O+UDP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739454; c=relaxed/simple;
	bh=Sd8f7urAkw7xqQP85+v4T0QKyI//U91+qVTla7IRcVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CltCj2BgOj/E7b894b2dA4ZUNvPEG8zURdYmYlAoYg+dvAgY+VbQbDFQqIqg+4WidId4mIoTYTrzdUreCa27Nx1LUEylFALEtsupfYVCBkOx56qge3NJfbyX+GXzQes2J3A8j8V9nDvGX94YyVIklTQYnqGemVcvSNm+JOPpfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-UcMvgYtuPyCIZwm081RWoA-1; Wed, 10 Apr 2024 04:57:27 -0400
X-MC-Unique: UcMvgYtuPyCIZwm081RWoA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D550E104456D;
	Wed, 10 Apr 2024 08:57:26 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B9944867A4;
	Wed, 10 Apr 2024 08:57:25 +0000 (UTC)
Date: Wed, 10 Apr 2024 10:57:20 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
Message-ID: <ZhZUcNKD8viY6Y3W@hog>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
 <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 10:37:27 +0200, Nicolas Dichtel wrote:
> Le 10/04/2024 =C3=A0 10:17, Sabrina Dubroca a =C3=A9crit=C2=A0:
> [snip]
> >> Why isn't it possible to restrict the use of an input SA to the input =
path and
> >> output SA to xmit path?
> >=20
> > Because nobody has written a patch for it yet :)
> >=20
> For me, it should be done in this patch/series ;-)

Sounds good to me.

--=20
Sabrina


