Return-Path: <netdev+bounces-147127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663F9D7987
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6E162728
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D301372;
	Mon, 25 Nov 2024 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="U/O7SBb7"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEE376
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495951; cv=none; b=NjOEO9KQ+cIxoIemUD8/Avbvc0iTYoNPqu+hDkQZLRyd+hwI84uSpyJcSN14mhw/LDSYo30/44KI8Dz97kgzmcfrQBNN8Vma9riTvOty6eE3E9Qr82p1D1+su+TWrPBiTD9/tgETTyOYfphSOMk9HlaTrBIPlAbWW6VmvQ6xhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495951; c=relaxed/simple;
	bh=6uKccdMT6FrBoUW0wq747UFfgg2MY7HOotiCGQAaomI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3NGcQdJPVx6oyepjE/jXALPq167am+W9QlB66bSYEDRolqVrtjxYQa3l2h7YEC6HfjqM9tA1prVJAlKgw5xLpVaUJrL13YpTeSqzGyiJUeGz9rxgoXzbvXMw65pYI7tTbZP1SarNqFgAkGNWVaU94I3gFLVx4lllSOA1QMc4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=U/O7SBb7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cAhTrFyJXRVikfMf41MLKSM9c/Qlejm/bbbwLWlDZmI=; b=U/O7SBb74GFGQZPWttexKqDjEa
	ZextNEW4QHkP+gRhvRDok1glnlQkPebMVywNiAE7IaXluTd73h0jxJF0Ctsb0ckXgSU/L4+BpJRD8
	n3ALejJjvJXT5w1K1zGsrHBJdJHhUhWSrqFm5EUnGRIu4kIUYW/tML8dTdKBLErVwwdWNclsa6Kgu
	HDyrLJHFE+nJAFrlE/pukGoGUVgi3ESjm14VxAwrUR30qpgzT7MmlF3uHerBZQv4kg2N9AAq26Tfy
	ad75yK4unfBlMh+viMNnyoojNRzmM6rj/NdYcuBdZsCHlXhnMSxn1EpkiC2dryWUV8d3SCsmMsWkc
	uv4UQBbQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFNKq-001R5l-0d;
	Mon, 25 Nov 2024 08:52:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Nov 2024 08:52:16 +0800
Date: Mon, 25 Nov 2024 08:52:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0PKQGcuT43tbbT8@gondor.apana.org.au>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
 <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>
 <Z0O0BV6v4x3mq-Uw@gondor.apana.org.au>
 <pq73vur4sgec4hxjugk5abgpqiftpkkdyvmtcq246jv2vuseok@qn2x6xzfqii7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pq73vur4sgec4hxjugk5abgpqiftpkkdyvmtcq246jv2vuseok@qn2x6xzfqii7>

On Sun, Nov 24, 2024 at 06:58:12PM -0500, Kent Overstreet wrote:
>
> Sorry for claiming this was your bug - I do agree with Neal that the
> rhastable code could handle this situation better though, so as to avoid
> crazy bughunts.

Yes it could certainly make this more obvious.  How about a
WARN_ON_ONCE if we detect two identical keys? That should have
made this more obvious.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

