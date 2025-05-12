Return-Path: <netdev+bounces-189913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AF9AB4811
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E6B868202
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A02686B7;
	Mon, 12 May 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1rgwwm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3483D76;
	Mon, 12 May 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094271; cv=none; b=Z5vwYCpJnHjzHkZiJtAKv8yJNl8piQFc2CAo1FXZufDgjB/ChyZw+opbWwfLt0C/0l7AxPmi+2B6xQM4Hb31hFm1tGX7skusAwBOSJjZxpxDz+SypBXYk/dYyAPeXNmfgAJIpzx0xXdjKMpyVt1F2+3TUx6M1GKLAN7NAQjrolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094271; c=relaxed/simple;
	bh=35g67iEooYIQQ3on2DYITx0wpR++21sZnlvuGeM8Kgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQO9F0NgVsP6rWJhiVJEBh2TsADs6Ung8PRkuO4de5K06/hc0qO/kapNX0PQjBO3eN21tNcdsILvGamTLjN0Jbl5gFzoQw0pfFcgTlJ87Hq53dnjA/JOVSUG6lAj+GilUA2N/kt3UvfbXxQKo4PL5R51SqPvMYoRTVaBBSvqqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1rgwwm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAFDC4CEE7;
	Mon, 12 May 2025 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747094270;
	bh=35g67iEooYIQQ3on2DYITx0wpR++21sZnlvuGeM8Kgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1rgwwm/7rXkLwQACa+JE3ARTsp95uzcY/XkRp+S/XH+eXFzBh4oLvQdduXGz98XL
	 ObP4oLx4i3S+TC5k0v6SsfETJYRQZSNKWZ9ZB250p+MIYJ9QlRjES7FC/4UGtl8XqI
	 pBDbLyiZ3xL05sagoHm0gnVn1b2ZX+3guEMJeyShswi9mjEPA7vrd+SA0kS+OOZvDa
	 jmc5jb8VfDIlyjBksIlWe6JERefeBRisfAZjFIddnuohNBWbScatogdI0vD+CRQoSf
	 5nejlYFNlH/0gAmO0jvMxu+lfKdfsM/eH8iJd7CXQnuXSQsh2X6MKbvoblvXP21VgB
	 3BQRMZe5PrbuA==
Date: Mon, 12 May 2025 16:57:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250512165749.375bcbbd@kernel.org>
In-Reply-To: <20250512101942.4a5b80a1@kmaincent-XPS-13-7390>
References: <20250506-feature_ptp_source-v2-1-dec1c3181a7e@bootlin.com>
	<20250508193645.78e1e4d9@kernel.org>
	<20250512101942.4a5b80a1@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 10:19:42 +0200 Kory Maincent wrote:
> > -    name: ts-hwtstamp-source
> > -    enum-name: hwtstamp-source
> > -    header: linux/ethtool.h
> > +    name: hwtstamp-source
> > +    name-prefix: hwtstamp-source-
> >      type: enum
> > -    name-prefix: hwtstamp-source  
> 
> Should we keep the enum-name property as is is already use, or do you prefer to
> rename all its use to ethtool-hwtstamp-source?

Looks like we already have a number of such cases - attribute name 
and enum name are the same. I'd keep them the same, I don't think
there's much room for confusion either in C or Python.

