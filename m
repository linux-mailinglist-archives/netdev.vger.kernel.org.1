Return-Path: <netdev+bounces-289886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLwsISSRDWpyzgUAu9opvQ
	(envelope-from <netdev+bounces-289886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910258BEBB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 076083045E0C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7833D9DD6;
	Wed, 20 May 2026 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SDqDGbTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F7366563
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273971; cv=none; b=tGPiKOi0dSnq75jNGqR+kW/lUUlPYT0kvXIojGsRuYYYLQeFjAj4xYNkNA0KFZwSIddi9Tz37TtsD53Eujh2QnxxDxM8N5Sm4jtJL6scZkroSgvZNzij8A6d8Xuwkp8r/7wL3+TsATECC3/vMk0kueJptA8oHUILzZgx54y//8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273971; c=relaxed/simple;
	bh=efl3wMr6QGvwQGPJqiCqUYSf4y35y/Amel1hos+JnH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuRaVsS7sh9R0mOvtka0YJ9Lvyt/AN/SbcFaUPUixmIGmeSqa6GaE7a/dCQ8nmS8I9sOJ3HjlYC1BJGxTjcq2L5NL2BPtma73KIrHXYfbm/yNjULMaXFhXewZiB4z96NCybieH0sKy33jc8aYXOF58/WAxl1k/tTLfndQ4vjsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SDqDGbTe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891b0786beso32499025e9.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779273969; x=1779878769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVg7I03MyVJa5h1QRkMOxIFRWS3ADKkxJT8MK8a91I4=;
        b=SDqDGbTeS/uDYUlIMA5Fn9CDUdy+Ng8NRYbtkiZIjT+nmrKFHHuXAFpoyPuVS4DWTu
         rgI6piOs9D5MNA/iY4qJpIIJsD3iSKtRq6vViK1y5NAQh+I5bOasAX8niZJNYC1LaHz7
         gmyMuHd3cWjoNSc8tExJB1aTcSTjTTiI7c/kvZrXvC+yL8mTQG7P+uZbCfDEMQcZiHxu
         LHeQjwPMKXbTqHjJiTgUyipE6gfV6qxYlvyFhnwWJeBE9SUDtpEowtpmxAukQ0f21wSs
         lDqaduWQYljC+FitnawIdZWLMmwsgFlOJIQu7fnh8RkZ9Guj+LdrPOfL7EMXDUNB9cAq
         4Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273969; x=1779878769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVg7I03MyVJa5h1QRkMOxIFRWS3ADKkxJT8MK8a91I4=;
        b=g+Ey27HvpNUk7cvJJUVMU/fKVRZXiyz1/Syfch9TPHyp6jxvBthyzSo1FFTui4ZPuI
         UZLXMwodaH7kfrzzXxi1PMZsEYIrmiS4eVZikreqppPlCbZtWigqthLxRoWbvfoqFcbY
         BXktY2fdO5HIUBcZfqbtkvh48A3OPmXnG2svtHVz1puRGcJlBJdMeqlSJvGI3ayJiBFv
         yhisK0MEKqqgmuIerrQnUa6jCiA24dLrh/2qwQaxkTHVOsOYL/e8+6cIBRKpS3jgzjwH
         B6yXFBHgjIFXD6ocvIZqmGi+0XUKZIdpajJbLD/UFqYR2NOpoJvYlgHpNNr7IwAZELbV
         gSww==
X-Gm-Message-State: AOJu0Yz5ZUuKU3qpIoniImQNAixnT+7BDBrAAm9EakwJZR60+0QJIN+d
	tdwX063rD76g9kb13lceUbcS8aoQ3x+h6+E5bQseZN4tq66ziF2OKv9s0WkVfwbtuB4=
X-Gm-Gg: Acq92OE6eHWrE434dKgDS04OXahWcVitcD7OaMUE3tyI6K0GAZhCaBXdjlkIPhDcf1R
	I2QY6ieEBwG0eauD0Z8XFwh2l8XvyRhHX/tgiZyevEb3/c5FltabznQKwUy7rKglvO9lJCvrzQC
	rgPZ5MaXmXMFn/74BnEiVz3vf805WH+KEiqtmg32EjgBDFhbSC73vylau0ClxQVUVJnMgoOfwHR
	UzrTLK+1u2A6b5K7oWkW+ExMx0h0UiGpWpKPexJG4FPBEbXc5caLLKwIg2uhVjNU104M3rOOW5I
	TOckKeE45ToTx1kIUkMhgzaBKBTNgJVwIV9hHm30GSWqCmtQ6YClFU6Nhm0b3uSAd/hB1gB361r
	7F5uY0Aifo41cJxJBHqfJyH0fiOhFWAaS/23SmPjc89fmB4YjOQMzFrNWTm8DbK0KYmUiN3Muvr
	sq0LBuR4CX6CZY3hZ4DTJScQbcvrQ=
X-Received: by 2002:a05:600c:3e1b:b0:48d:46a:6e5b with SMTP id 5b1f17b1804b1-48fe60de6b2mr358299295e9.7.1779273968672;
        Wed, 20 May 2026 03:46:08 -0700 (PDT)
Received: from localhost ([165.85.72.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48ff43f8799sm274536375e9.2.2026.05.20.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:46:08 -0700 (PDT)
Date: Wed, 20 May 2026 13:46:06 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH iproute2-next 2/2] bridge: vlan: Add support for
 neigh_forward_grat
Message-ID: <ag2Q7oW6EE1vTRhX@penguin>
References: <20260517082501.899009-1-danieller@nvidia.com>
 <20260517082501.899009-3-danieller@nvidia.com>
 <ag2M3moiivqEvfNG@penguin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag2M3moiivqEvfNG@penguin>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-289886-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Queue-Id: 0910258BEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:28:46PM +0300, Nikolay Aleksandrov wrote:
> On Sun, May 17, 2026 at 11:25:01AM +0300, Danielle Ratson wrote:
> > Add support for controlling gratuitous ARP and unsolicited NA
> > forwarding at the per-VLAN level via the neigh_forward_grat option.
> > 
> > This allows configuring the option via:
> > $ bridge vlan set dev <port> vid <vlan> neigh_forward_grat {on|off}
> > 
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> > ---
> >  bridge/vlan.c     | 18 ++++++++++++++++++
> >  man/man8/bridge.8 | 15 ++++++++++++++-
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> > 
>  
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

sorry for the noise, for some reason I saw these marked as
new without any replies in mutt and reviewed them again. :)

