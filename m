Return-Path: <netdev+bounces-170596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B790FA4930C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5347AB459
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444461E0B73;
	Fri, 28 Feb 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="e4zPF7fE"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779741D6193;
	Fri, 28 Feb 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730131; cv=none; b=ZZoFYtV4gRYftxqS2hf2ZzNGQj7tT1RnsKXeYEWM+MD/e2pGREHZjHfUJNrPae/ZVuzbNlDB7VDklFFh+lr7tk8vDv1ad0kUICBAlTPC2GTHZdT/PD/99FL4JwibA6Y4KQ4xCqc9YmMshrt5T6QcWB6mEYqLZ6RHSKt1iYOmkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730131; c=relaxed/simple;
	bh=kNUkmfWCLaMSkrC9V6J9XgiSwUmUjbBx6cXilSJv014=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEeU0q2CLTN0ocHZ+pobAAd1Y8up6zzanbW5rs97431NX1S3+cSoUcNDmI60juqvR6og/GQJmgNF5XFu1SVPKx5XAjfag717jyKGHqLjBy51HoXLabhERiQL0sWPozXbwb+s4maAYoHJpfGhUHdWaEJ1t8LysbVLdW3hgM3QuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=e4zPF7fE; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RHdi/8WZcnPqLCFpmzRLzJjDTVIhzP53KvbQDrz39Gg=; b=e4zPF7fEsYnBz0dHrVeKHx6VFs
	g7dLWq+lzJAL9riUIXALF1Lor/sZHhiDFVq6HptsrC0z2KXu6q9maQxUC3r23mvokgx8ZbM5iTZ+N
	JTz882PLWsqpaQmREmBhsXvBb5xe7YM38J5pXf9Lk0Z8d9gZAhHYdF4OhEpaNORClIw3vOlrzfE5i
	IVBdjTHs62c3hW+88sUtlDsU6kczkPGHTiwQSdBvOObWMb+t8uCT5Va3FxgMjwVggcSrcAYr8xGd3
	pPqci8u062X1EJqeO3NxNMOUui4D7MAjJ9kQz6UlzsLeNo1nmCMx0af0hLvgnvCzZy77AUpFJ55kA
	KVJmksuw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tnvPq-002VXh-10;
	Fri, 28 Feb 2025 16:08:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Feb 2025 16:08:14 +0800
Date: Fri, 28 Feb 2025 16:08:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Which tree to push afs + crypto + rxrpc spanning patches through?
Message-ID: <Z8Fu7mi0UOS8xk80@gondor.apana.org.au>
References: <da1d5d1a-b0ae-4a40-907d-386bd035954c@redhat.com>
 <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
 <20250224234154.2014840-1-dhowells@redhat.com>
 <3151401.1740661831@warthog.procyon.org.uk>
 <3158046.1740670591@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3158046.1740670591@warthog.procyon.org.uk>

On Thu, Feb 27, 2025 at 03:36:31PM +0000, David Howells wrote:
>
> If you're okay with the rxrpc bits not going through the networking tree and
> if Herbert is okay with the krb5 library not going through the crypto tree, I
> can try pushing the whole lot through the filesystem tree.

Sure I have no objections.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

