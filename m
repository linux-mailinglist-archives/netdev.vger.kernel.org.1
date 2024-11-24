Return-Path: <netdev+bounces-147114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C79D791B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D104162649
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAA17C7B6;
	Sun, 24 Nov 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="DRNmvODH"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592517BB24
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732490259; cv=none; b=oWBX7u4ABwnaMsMLhtFgksgFd6eqMpf/2xQjAwlqR4YCg/QBV/GfB76+gzxQyK5hgjNdVDzc2JtarWBQzIsvKZbTiocn3Doq2Wk7Z3dVK6ESQEfR4+QW7CS7DrxGxR3JhlerMkLG/IgcYj7DxLz5Dbl4cvzI1rqUUKxPiQRRxjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732490259; c=relaxed/simple;
	bh=pVm7ODTix2PiYSlcg9WrHywV616qNnvMuGX5wfGxe2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEcvvtYcqnLHQ6liIPZU5J0o7RW07iB7Sc9q2k3hzYhZ1+g+2pXIbVZ2O3NZqid+rvYQ1h7hNGJU0AhM7vfFXXywSY5eZAYZ5HgfT2/7Rea+EvYv72tpkp2zevVLO8HVA7UbVu6v1Nj4/w/oI9QtAIHt594qZTaQNFEnFjFJ4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=DRNmvODH; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KNriHr/B/0rjs+5nhFmzzRU+Qhuv+/1POvri3Y8TrxU=; b=DRNmvODHHyqDpEOipSjS+ORwzt
	KoZlWMhjdXljEN2wtovp+BgT5YRUfrZaabd89tMFiPR+DtO2v5iNzbTUDVuOF5m5KY+Zu2jSFNfF8
	ZmZoODYBcxKWAhS8wQgaLlPqVMo/7n3lKnCDx7bHi95SxmA1QGVMJjzBcB6Cx9lmJC672dR9Yyjju
	6Vn75PicpafE/qS013NG26V2BP4M7eGvaRybDtcU1osYyhtihGJI6B88hazn6Pijn+PLIxnY+0MEU
	mSu6DcRLnSEZ4YM99ZhYJUhCqhpgwXN8yzg9JLPe7DxbATvBJWnmhgYYhJn9M3wpNnXqzoqT8vuRi
	9AB0jQ0g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFLr3-001QR6-28;
	Mon, 25 Nov 2024 07:17:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Nov 2024 07:17:25 +0800
Date: Mon, 25 Nov 2024 07:17:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0O0BV6v4x3mq-Uw@gondor.apana.org.au>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
 <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>

On Sun, Nov 24, 2024 at 05:35:56PM -0500, Kent Overstreet wrote:
>
> That's what I've been describing, but you keep insisting that this must
> be misuse, even though I'm telling you I've got the error code that
> shows what is going on.

Well, please do as I suggested and dump the chain with over 16
entries when this happens.  If you can prove to me that you've
got 16 entries with non-identical keys that hashed to the same
bucket then I will fix this.  Please also dump the table size
and the total number of entries currently hashed.

As I said, every single report in the past has turned out to be
because people were adding multiple entries with identical keys
to the same hash table, which will obviously breach the limit of
16.

But I think there is one thing that I will do, the rehash check
is a bit too loose.  It should only fail if the outstanding rehash
was caused by insertion failure, and not if it was a growth or
shrink operation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

