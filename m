Return-Path: <netdev+bounces-148749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307699E30C9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AAB280C72
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A683A2114;
	Wed,  4 Dec 2024 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="GqWyZRS9"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21983BE40;
	Wed,  4 Dec 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276088; cv=none; b=A7mKdtk+6QTlaaGWtTHkNjw0uRIp3TwR0CT1UmSxPWwFEME7qUJdZgwzIl52jwAu3dLXEWWoe+BIcUN6QdqckH9G0n31wTAVnPqudXdM3gF20BBVGZTSS98Y5oWpgTNsLV8peVVGaLTZJZVjT1/aP+JD8jvLYdVgUz/EJ9ToAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276088; c=relaxed/simple;
	bh=HgP8ljaW/B2GsjUTuvx51Mma/qByl7Nh5RVEoX2a/Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2As+Z9SKbEGg+2IKGAPrHgeq9H2iHlsoz9T53BTXznSSuw3mcNzU2rniBMVigs3MlrXC7xyWxTpPKNtzj/m0yV2iLePIu4+16RQbYluA78js7lDPiewDEuXY6gc3FbBVlWvAJ9+6CUDJaQSbapUgaALoAvqyhuAsjWCMVIUWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=GqWyZRS9; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3lBDe3Je67MGD1CRkdSArjnWp7AYYNQKLnw2y2y8IF8=; b=GqWyZRS9XQIKCaIIW1bAZ9SHA/
	+RaWRZaaimDV8wot79MsDF2W/6yNtcIhX9GqADe7WxvpFHqn7hZ3a5XKrScpo9iTuIeuyL2o0AcDP
	S0lG+jFTervYORFhNvioH+9oJOPH+Q7ppAeuOW5pLfI83mCD9Pvlkx0DaOXyL1ls49/QAHFQ5s2I7
	5a8ds9gMJRgXkL93rsD9OQKS66hKgoFpunKuwZnur4/BaUXnsr6/+NFRgLjRT4nQOaisn9TIjb/0U
	ywJ04P9p1PEwGe4EhUZeOxJviAVSZDRKOwGHOMRLF+v2sDuV93wIEQeKvvlXu4lkEQlLpkQCAeBIH
	Em3cmsfQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tIeHa-003LiP-3C;
	Wed, 04 Dec 2024 09:34:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Dec 2024 09:34:26 +0800
Date: Wed, 4 Dec 2024 09:34:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z0-xohE6y_NI5Uc1@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z09nGHvk5YJABZ1d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z09nGHvk5YJABZ1d@slm.duckdns.org>

On Tue, Dec 03, 2024 at 10:16:24AM -1000, Tejun Heo wrote:
>
> This solves a possible deadlock for sched_ext and makes rhashtable more
> useful and I don't see any downsides.
> 
> Andrew, can you please pick up this one?

I will be taking this through my tree once I've reviewed fully.

Thanks for your patience.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

