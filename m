Return-Path: <netdev+bounces-70746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5085039A
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81271C22521
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48136117;
	Sat, 10 Feb 2024 09:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9223DB
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556144; cv=none; b=anFB70SjPRbY8Xzb42WgN1n/9J5I70xfzwtuZq7NbLVaH+B1nsWhpy9hZAPGQa1K2tVp1QBJVsSgXxdyWtQQKCYXeewJtNYQ4wDxub98WBdLE9DMvUSfXbVkcZoQ7LaD9OXdGlzgJr+0dAqqmf9WmMerZt3w/1NNX7B6YlZoScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556144; c=relaxed/simple;
	bh=7PyyzTH9XD86vkFMZ8BKcwz84s/cj9zsdH9oDqkrUNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZPyKvZF9OKJ8Hrlw91edaAWOh+GnahmLR85ecn2aug8MeHwFZwBHzUZypHgTnja68ku3oOvsU5kS3QseB/beyJ02QN1P+WyWA9Qb/4EGFC0mEvIdVKkrtALfdIuaoqJLOx1PHnloDXyBDgcYpHWphvcEc0hAeUQWeaPQhhOEdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-VI09oHxDNyiC8kcScBWfdw-1; Sat, 10 Feb 2024 04:02:26 -0500
X-MC-Unique: VI09oHxDNyiC8kcScBWfdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FC71021F64;
	Sat, 10 Feb 2024 09:02:10 +0000 (UTC)
Received: from hog (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC2A1C14B0C;
	Sat, 10 Feb 2024 09:02:08 +0000 (UTC)
Date: Sat, 10 Feb 2024 10:02:07 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev, borisp@nvidia.com,
	john.fastabend@gmail.com, horms@kernel.org
Subject: Re: [PATCH net 7/7] net: tls: fix returned read length with async
 decrypt
Message-ID: <Zcc7jydL2xIYFrQW@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207011824.2609030-8-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-06, 17:18:24 -0800, Jakub Kicinski wrote:
> We double count async, non-zc rx data. The previous fix was
> lucky because if we fully zc async_copy_bytes is 0 so we add 0.
> Decrypted already has all the bytes we handled, in all cases.
> We don't have to adjust anything, delete the erroneous line.

I had an adjustment there which I thought was necessary, but I can't
remember why, so let's go with this.

Possibly had to do with partial async cases, since I also played with
a hack to only go async for every other request (or every N requests).

--=20
Sabrina


