Return-Path: <netdev+bounces-94027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15B8BDFC4
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F72A1C23270
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1514D430;
	Tue,  7 May 2024 10:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F114E2EF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077782; cv=none; b=V3scOYdXNGQyYx2C/iAfmmcxSdSRGlSnF9wI+Wk4kiPbEa1CAawrhbBPQdOOEfze1vTeG+DMDhUXrNcrA8+j4ZD+Tp+XerkXjT2+urZ4qVPVNOZvVP4CzvpQbKRequWkorsRv76Ul2UL5N7VX2RGkNWqnceonxu571fd9jvPHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077782; c=relaxed/simple;
	bh=bvTgZ0se60qgIu1TUcRuXBlqWmcOqGcNPagYDe+4jGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWoUDfSyyRHAWI9EVLqrmoXJ+XZHCNXw/Z/bqrKD1BLoGs2zGjSBcaMcE9hN6/Ohn79XCsujuz839rshQMwaJs0myFMjK612GQiTztTuvhC4nfqx4kZhWCj/OgedCfizjQEj85wpLIkj/So67Flqy4lCA7Yt/mz39hq9+x7kSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 8E5EEA02C2;
	Tue,  7 May 2024 12:29:38 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sa0HAO_MzPKw; Tue,  7 May 2024 12:29:38 +0200 (CEST)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 66603A02A3;
	Tue,  7 May 2024 12:29:38 +0200 (CEST)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1s4I4n-00000008Dhw-43oJ;
	Tue, 07 May 2024 12:29:37 +0200
Date: Tue, 7 May 2024 12:29:37 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: James Chapman <jchapman@katalix.com>
Cc: Tom Parkin <tparkin@katalix.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] l2tp: Support several sockets with same IP/port quadruple
Message-ID: <20240507102937.jntemhljveqmyhwz@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
References: <20240502231418.2933925-1-samuel.thibault@ens-lyon.org>
 <ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>
 <20240506214424.4wddiwjdpdl2gf4w@begin>
 <66998255-7078-8d4b-6efa-fa7b0751176e@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66998255-7078-8d4b-6efa-fa7b0751176e@katalix.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

James Chapman, le mar. 07 mai 2024 09:06:35 +0100, a ecrit:
> otherwise, L2TPv2 socket aliasing will still not work properly if one or
> more L2TPv3 sockets also alias L2TPv2 sockets, even if there is no L2TPv3
> traffic.

Ah, I assumed this would not happen (a given l2tp source would usually
either speak v2 or v3), but we can rework the checks to support it if it
can be useful to somebody, indeed.

Samuel

