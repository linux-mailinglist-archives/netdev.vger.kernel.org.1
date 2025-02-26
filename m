Return-Path: <netdev+bounces-169934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD155A4684E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A130188616E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5232253FC;
	Wed, 26 Feb 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hnfs2sSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7F2253F6
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591756; cv=none; b=g90Kxzt29ImPHAe9NtnGH0pb98xinRFzF/xbaTFGF73j3+xHWwPPUBh0YbTcJBLSjqerabPWCGpOlErC7EGqVcbvegM871WqWBieePdYr8S73BYNKbI4PPPsvud00ICq6wXWifkDWmYjjh7I8V19yDYalPzHFTqEbJNcGcDS7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591756; c=relaxed/simple;
	bh=kBYSUUfKWgAedBFqiUb2p3B9LG89D2NzoFHX3U2MX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shUiy4gHL4gud+HItQnkj9+uoTwZidQblxmbXq3kAPJF5Jwz29KPEzwJeouPQT2sr8+pkCIFxpzoJgcg5ZO5aVCMRQBzRlSFrNtuY35v+RWsstERhuXF+1b3MEusvhG7QyR03txr9X4nT/h7u4pQ9tbNZ0TblZzSm11/jsTh0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hnfs2sSt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd049b5428so1074216d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740591753; x=1741196553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU7dpam59K3dSjMFOXnGTgrP5jzg9G2BzXwta4CbS68=;
        b=Hnfs2sSt+ZvR+0tP7M7LQ0VqFvg6PrBxTjAcAAyze7ryKm1UaYGnTF5TrS9D3xWyYl
         DCvvgxMiWdQLMSWOIRcI7o/C3I/PPkvRiANtGymqC6K8Qxl1j+QCuaESTzGxFUrbS5sD
         JYfZsc8car+Tc1ycitXVCMUe5eKCs91iOZUic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740591753; x=1741196553;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU7dpam59K3dSjMFOXnGTgrP5jzg9G2BzXwta4CbS68=;
        b=atT2VZV8EnmS6gS1e5RDDC3iLtr+BAuAX0WFS+iX0QqecMoS7TEvviqWGszAv1WwP0
         m6ye4uIyVq856mMw91osZE94RP1NOt161nQI3H36D9IFLWv3sUsbGZrAiSwM2B+ohrCf
         29Xyyn/aQ+4cU+oRReGtgngx4Cck05RU15Eq4nuuFd3pBtFCRe2cbAmnoVmk9zXpJozl
         IeiKdLQeU55sm0lbMLAzrYJwTPZs52jC9K27aj4thKSiUzCLiAKyb16KPTTZVxIRUrL6
         efwbSWwynevG7jVx08gzPUQlC8zbRXyh4WUkCaBA1k68GC7Pl7Q90ehH5nlWtRx4nWZ6
         WtTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOe1ZE4SWlUYUI53FD7ZaqfhUmLEQazQLX/318i6aBHp5cLztCzJExBcpepjLdcNJrx+v1wW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFdsviS2OQqfUbsiYdLddHId2cYi5ujuEK+ynbFMQsn6AuHsR
	5jT3LOHq8fB/AxFjLw3Otlkmx577kpA6IPjmyLO3RW0IpzYkZ9sGHWiI4AE786w=
X-Gm-Gg: ASbGnctMprxfF0UF1q1w04gRXZcdQ9l3FMezQAInPTvvs6tJowaMUalwE0MNf24zq18
	mKuDb1RfC8xdU7RyJSYi4iVRZftn/3kXD6E1YkL2dSzCGrHujzmYfe9pfPcM3PjKHCj9HVTUdmM
	XvrSy5dpRfS5tiZA2jqlphvyOl2HCJxDb4nsPgP5/ODl/FZQeh0u3n2eGp5qwDw8nBX6UimRP6M
	N8id9+Acnt25a45/pf5diHgbuYARuDymm/BHAoCiMmtOXi8yBoiBjqEs418wPUbt7AvLMd+TR44
	PvBjuApfa/Yo2z9HcRGmGWVJBlkuo++Nmf1gHwh+PrBHEtBWF+WnXuUVNMjc0YSX
X-Google-Smtp-Source: AGHT+IFFTLyJjs3r8uOBPJibjmVX1i678NyLJOcnFCP6n8KgNvJsA5WPPCR3imeabFVP4B5tek6QGg==
X-Received: by 2002:a05:6214:45:b0:6e8:86d3:be78 with SMTP id 6a1803df08f44-6e886d3bfa7mr50675626d6.37.1740591753671;
        Wed, 26 Feb 2025 09:42:33 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e893a07bfdsm3579686d6.98.2025.02.26.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:42:32 -0800 (PST)
Date: Wed, 26 Feb 2025 12:42:30 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
Message-ID: <Z79Shk7-2HJM_3ec@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225170128.590baea1@kernel.org>

On Tue, Feb 25, 2025 at 05:01:28PM -0800, Jakub Kicinski wrote:
> On Tue, 25 Feb 2025 09:13:48 +0200 Gal Pressman wrote:
> > Context 0 (default context) always exists, there is no need to check
> > whether it exists or not when adding a flow steering rule.
> > 
> > The existing check fails when creating a flow steering rule for context
> > 0 as it is not stored in the rss_ctx xarray.
> 
> But what is the use case for redirecting to context 0?

I think Gal's example is a good one and there could be users who are
already directing flows to context 0 and so, as Gal mentioned, this
might be a breakage? Not sure.

I'll admit that I'd typically create a custom context and then set
ntuple filters to direct traffic for those contexts (letting all the
'other' traffic land in the default context 0), so I can understand
Jakub's argument, as well.

I'm probably wrong because I'm not a python programmer, but IMHO
it'd be a nice for the python RSS tests to be updated to cover this
case (whichever way it goes). It seemed to me from a quick read
(again, likely wrong) that it wasn't covered and could lead to
confusion like this in the future?

