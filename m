Return-Path: <netdev+bounces-203218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1EAF0CD8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879DC164D3C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90422E406;
	Wed,  2 Jul 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANPLHTW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6222D795
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442280; cv=none; b=t+WzsMIvTrffRvTWeOHC9F9O+nYhfF6M8S0G+9guKXda0NovRwoMVcJBxLzWXb/qVPpWwT3pparkqFmChrCg3whJqomeHCQ927ppcYSJZuhf+39UWmLqCmIpPrfK8lSiqD1zCUTYOsr0u9VT8WsiqsOBTukiHiEARNWDJ+CBmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442280; c=relaxed/simple;
	bh=riBJz3plGVIwLSaG4wg6e7ZzHdAUxAyWO6PGZj6vw0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8SpwUieyClQ4SX/Wt1wWrref0f6Eha50kc+cpZGMlExCoaBH3tt/eueJAa7DGVR0stpRd31UjXHXmDsjSdw/i5lW97BL/BOnn9c11vWoZJha6zJAuChpHMhaIY/K6fdJhLkxhCNefuqFEhyQZHfj7Jmzyw3gz3XROfEdQAU8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANPLHTW5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b27c1481bso2057904b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751442277; x=1752047077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSJfJKkWWfEPsUWeJfXbT8qOagNPq8YBJyquc0i0RKY=;
        b=ANPLHTW5zTDV+v/8f05O8kOfcme/QC9H+d0ipUmVzXxgL7QTkOKwmi7g2V3RnMB1Lt
         ON5tvl+yQHrMCVTpesitcGm0GfjCUOpZPsT2NJEqSEYj7vMCgnrPmnQUYr769Jlm7VwE
         Blz9aj22vae5IDrJy8smYcbstjNLZRNy51TyeP8QzGJvOo025mb7bqkQ/EQw6oB7m1Dp
         488hvNPk9ggKQ7fr8cim9fVez9x3qUlTgGAnyfgc5F9anPhe6S9fH3mknOsQm8wyUq5l
         t6xUYQbaRILm1fjRmlnMEczqlnz6HGljWkJP5XURLIGbMqtfeOh+4yjLE0urKbNTlsRc
         IP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442277; x=1752047077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSJfJKkWWfEPsUWeJfXbT8qOagNPq8YBJyquc0i0RKY=;
        b=xM3/Havitzi24W1qEpqbGA7ql+MkuLBOH+LmDsQuH+pNMoCew/mfho5C+Zn80Bwaw5
         OWrTmDyJKNkuJTIhA7sfB2NO7WC64qdv3BSV4U9TLxkTvsOthOmPEW6dk1isoplYcw2k
         7OSOjW98Lhd7qVwOFpYx+ZhAbv7JPgQ5vDUSCey/GBtVGy9+4YT3P8Ec+f0Tp15Weaa4
         dIxO8CeCczppZM7Hz6Ch9ANaIr1lYJO6HnEB4XqyUq0+sb8yoPp88cEaoElgk+4lA6Um
         aV5+tC643v0DDE0o0lhP45rnlCOPSy4WnJPyZm9yr3xHk+QNMwwrkPs2S1WuE877SMCJ
         C40A==
X-Forwarded-Encrypted: i=1; AJvYcCXypQ621dl9xjkvu7FZWlRzlt0XQep5/xCzrPmttN/IxQ1hCYP2sWbu6kvhkr9bO/qXbj7eF0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvELXHaURjeoB9ApPkKSP9ZhsP7CZrKJEcHjGwKXwX6SdlQrO
	uMUHdKgr9CbSsZMbYn9I+RRVAk/rhD/k1lzyHU0ie4WeCtCnZXDcWLVm
X-Gm-Gg: ASbGncucnOW84YU0i8G0129/H9QUvsVF2EYbu4CEDmz0YSeevtT3JVq1h6x45Scl1Ht
	4J1GxlwQZ8ozJTITq7a/gFnKmRx0LG472F76KomBU4O+lO6DnZEUT8gZUC15oGSf4V7mCz7zXS8
	cYVWX/sFLLAHkvtyQ8zrGsLtQzwYWK1Ex0eZ1PNbfX4p5c4fJVK+CA1SAJcwqbSDXfx8PHOjaNg
	3cNBYId51nijZ6lXHqg4r3K0Z+D20G6QZjCUu5AiNGdpguQxLAr8jJt0BzcPly95dmkGcmzIluY
	gsjrPqUyT14xoud9jkS3Xn7AKrYgnNC5cnmRhDzNsCnrpZK3cmUuMSgdfyfQoevnJuA=
X-Google-Smtp-Source: AGHT+IERHVCv5jOMLyA0wJqX08+s8tGnN0KA1fpkJH+rCtvpk2rF7I669rnjtm0VQecyib44v16lBg==
X-Received: by 2002:a05:6a00:2309:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-74b50f539a9mr2391429b3a.19.1751442277456;
        Wed, 02 Jul 2025 00:44:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5580faasm13292099b3a.76.2025.07.02.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:44:36 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:44:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [Bonding Draft Proposal] Add lacp_prio Support for ad_select?
Message-ID: <aGTjXpYYXIMfl9N6@fedora>
References: <aFpLXdT4_zbqvUTd@fedora>
 <2627546.1750980515@famine>
 <aF4fEGySN8Pwpnab@fedora>
 <2946319.1751389736@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2946319.1751389736@famine>

Hi Jay,
On Tue, Jul 01, 2025 at 10:08:56AM -0700, Jay Vosburgh wrote:
> 	It looks like lacp_find_new_agg_lead() runs though all of the
> ports in all of the aggregators and chooses the aggregator with the
> "best" port of all.

Yes, based on the ad_select policy.

> 
> 	One downside if we were to adapt this logic or something similar
> to bonding is that there's currently no way to set the Port Priority of
> interfaces in the bond.  There is a "prio" that can be set via ip set
> ... type bond_slave prio X, which is IFLA_BOND_SLAVE_PRIO, but that's a
> failover priority, not the LACP Port Priority.

How about adding a similar parameter, e.g., ad_actor_port_prio?
Currently, the actor port priority is initialized directly as 0xFF.
We could introduce a per-port ad_actor_port_prio to be used in the
ad_select policy.

I understand that, according to the IEEE standard, port priority is used to
select the best port among multiple ports within a single aggregator.
However, since the IEEE standard doesn't define how to select between two
aggregators, we could repurpose this value similarly to how the bandwidth
and count options work in the current ad_select policy.

> 
> 	So right now, if the above logic were put into bonding, the
> local selection criteria would end up based entirely on the port number,
> which isn't configurable, and so doesn't seem especially better than
> what we have now.

[...]
> 
> 	From the above, I suspect we'll have to add some additional
> configuration parameters somewhere.  It would be nice if the System
> Priority were configurable on a per-aggregator basis, but that seems
> complicated from a UI perspective (other than something like a mapping
> of agg ID to system prio).

Thanks
Hangbin

