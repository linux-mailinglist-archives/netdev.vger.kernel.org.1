Return-Path: <netdev+bounces-70747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5509185039B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABECB235B0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E233CE7;
	Sat, 10 Feb 2024 09:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2782259B
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556284; cv=none; b=ujnWAWLbGFy8QiToWhvvQO7mTHx2cAYFSYrz3vo3bQXi1QWxaDVWsCaNMb0y11jVEaVA8BzI1t4WTzP5HxWjh7befBWYHXKoQMXaFjXahLMeIsZeWVZC+a6c1LUYCZKbYHm4vUvsbwGcotDCgXIVyEYZXFEUUKn2zyx7md868nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556284; c=relaxed/simple;
	bh=9qK6ZUaFKwjGCJifeRMuLjR09CGS3F7s+Y8eeA8B5nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G0zoBj/vkY5scj3X5RuChMkJP92TzaLMvW6JA2xnAGCY3mesceVwSCaCxy1dw0x2XIWOb+d9Ac7W+fq5oVsWy8X4QwjX5FPwB/oyuzXWhGJBrJ11zW9N37pIGO69kv/l9YUYvHnHAYoh25gNUdYJdhQ5WMZSpWkCvyFaZZqRZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-peO3jBKhNMS2SkAjrccVoA-1; Sat, 10 Feb 2024 04:11:18 -0500
X-MC-Unique: peO3jBKhNMS2SkAjrccVoA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD1B185A589;
	Sat, 10 Feb 2024 09:11:17 +0000 (UTC)
Received: from hog (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C6D492BF0;
	Sat, 10 Feb 2024 09:11:14 +0000 (UTC)
Date: Sat, 10 Feb 2024 10:11:13 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	valis <sec@valis.email>, borisp@nvidia.com,
	john.fastabend@gmail.com, vinay.yadav@chelsio.com
Subject: Re: [PATCH net 2/7] tls: fix race between async notify and socket
 close
Message-ID: <Zcc9sa35nOAq9pEB@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207011824.2609030-3-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-06, 17:18:19 -0800, Jakub Kicinski wrote:
> The submitting thread (one which called recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete()
> so any code past that point risks touching already freed data.
>=20
> Try to avoid the locking and extra flags altogether.
> Have the main thread hold an extra reference, this way
> we can depend solely on the atomic ref counter for
> synchronization.
>=20
> Don't futz with reiniting the completion, either, we are now
> tightly controlling when completion fires.
>=20
> Reported-by: valis <sec@valis.email>
> Fixes: 0cada33241d9 ("net/tls: fix race condition causing kernel panic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


