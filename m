Return-Path: <netdev+bounces-245250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2048CC9A8D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 23:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21FDA303C811
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05430F55B;
	Wed, 17 Dec 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p1KgV7ix"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DB30B536;
	Wed, 17 Dec 2025 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766008872; cv=none; b=g7q382Wo1fYV/rKrV1wr2IWhXRABDAfieRhDipcGpk096X96QK4MgR/1WfL6JYvinyO+zAsjBcEC9DTOmZAhKPwqvo7oHESNMTjcv4SO61RMORpddlLMIHLhkzYuHC2RtACcM6fUFh3nkD1tJpBzCvd+oon0prBboKOQkdPTQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766008872; c=relaxed/simple;
	bh=Z5SvjKFDBnCD4Vf3ayWysRqNlkIVzE6xB1jGfAXGSbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmhQgm0WkzIB+YCBKZGHLUXeD+TguVCHXSqi4P7K5nmfM85w+S+lndw0+hCmwUotMupJPw+RAFgJQKeaQqFhx9vWKH7+uxo3cb8oALpHjbAnUOKl0lOMLc3YueBs+/g95Afzsrm/PalWhKwBZ+QB4zthoJXRYec0TgNKT4Qit+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p1KgV7ix; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eyl/cIsMGnlId2jLv+A4EzGEmK0F+uR4cU5CXowcbBE=; b=p1KgV7ix1cmZGOy8G+AY1/bFK/
	aoIM6iSAQkn5TOY4mkoHSCVf9/vm/aJaRf7DQMe4OX8onG/PhMncpsGCWTOPvRdSSelNZhxWgiOlQ
	5H3qHq85sFNQs5KhQT01jd/ACGh8VwTQc02gQ2Z7z7XYUNflMTFhQfG2NkOa7MSDioFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVzZq-00HGJY-Nq; Wed, 17 Dec 2025 23:00:58 +0100
Date: Wed, 17 Dec 2025 23:00:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
Message-ID: <0be6849b-e309-4131-884a-7b352db6c599@lunn.ch>
References: <20251217205756.172123-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217205756.172123-1-jonas.gorski@gmail.com>

On Wed, Dec 17, 2025 at 09:57:56PM +0100, Jonas Gorski wrote:
> port_fdb_dump() is supposed to only add fdb entries, but we iterate over
> the full ARL table, which also inludes multicast entries.

includes.

	Andrew

