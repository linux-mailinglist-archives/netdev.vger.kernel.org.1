Return-Path: <netdev+bounces-86418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C728C89EBE5
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044831C218A6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8413C9A5;
	Wed, 10 Apr 2024 07:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CDB13CFAC
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734039; cv=none; b=rx6AcNLgcOpReV4BbHUCOPK8GGwAOZYD4uJcgvfvCIugSv0c0C0mEVgz8MV67Bdzd0B8pzquTU+amGWbIUUO2+r/B5Po0GgKkhdMKbEWzOPFuHzS+liJBykOVbvWRhu/ygHneD8Hq6dgmE81EIDm9WTw+iHh5EZ7AnjLHeT48nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734039; c=relaxed/simple;
	bh=Axk5w7oiky9Hhs0dRsLltIaPpNCc3SGBAiYSkJ5A8KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QyTkBeNJU/xxUScjwbpfzGh+40y+S3ZIglMiZO4V6qzB7PE+/fr8NKZkyUQJM8bNIvnXVMAMmyc9P6SOMLFZphNwjEfXyLAA8G5CYME+CsWO7Omyy1hg9B91KT+h83UhpzTEPU0FVLpXPzJr+wX8TDAn8pzqZkPWg8BXsDFAqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-7cVesN8YPdi5fwCdLxmTDw-1; Wed,
 10 Apr 2024 03:27:14 -0400
X-MC-Unique: 7cVesN8YPdi5fwCdLxmTDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 218783800096;
	Wed, 10 Apr 2024 07:27:14 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FF0240B4983;
	Wed, 10 Apr 2024 07:27:12 +0000 (UTC)
Date: Wed, 10 Apr 2024 09:26:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Antony Antony <antony@phenome.org>,
	Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the
 SA in or out
Message-ID: <ZhY_O_6w1Yz_R6aS@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
 <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
 <658b4081-bc8a-4958-ae62-7d805fcacdcd@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <658b4081-bc8a-4958-ae62-7d805fcacdcd@6wind.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-10, 08:27:49 +0200, Nicolas Dichtel wrote:
> Le 08/04/2024 =C3=A0 15:02, Sabrina Dubroca a =C3=A9crit=C2=A0:
> [snip]
> > Nicolas, since you were objecting to the informational nature of the
> > attribute in v5: would you still object to the new attribute (and not
> > just limited to offload cases) if it properly restricted attributes
> > that don't match the direction?
> It's a good step, sure. Does this prevent an 'input' SA to be used in the=
 output
> path? This is the case I'm objecting.

Not in the latest version, what we were discussing here was only
checking attributes that don't match the direction of the SA.

Adding checks on the input and output patch to only look up and use
SAs with the correct direction (or no direction set) should be doable,
and probably has a negligible impact on performance. If we do this, we
should maybe add a counter for direction mismatch
(Xfrm{In,Out}StateDirMismatch?) to help admins.

I agree that it would make more sense.

--=20
Sabrina


