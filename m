Return-Path: <netdev+bounces-125192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC996C343
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477971C21178
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC41DEFFC;
	Wed,  4 Sep 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqWWLiJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099CFC1D;
	Wed,  4 Sep 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465635; cv=none; b=TdEVE3BnKTTueftwK5uXJlo94nHtnBvj9MqwJTZddC6oafm82JMlMRVZVvM5n6QvHIc33OJAklwoyXZztYjUP7BKVSFlBvjwuFAP3WNfCxpwwjjhsHRbB7lZ58dCtcNRaHx/iMnJGCH6VvLDYBlKEjX/8QjALojNbOgAdh91eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465635; c=relaxed/simple;
	bh=9b2wrt3lJNUPk+3juIe5hKTl7xa8DXIEj5MHktLd0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGtdm4chO5LHJZX7gc0fPaVgVxF7ZE4SPnnYATiQws3twujKL0pj4BCMzeVLNRtyuSnO/J3MjG9KTHBYF4Bogeq2vMrJvHhBzd1zu2tA3Fk4jWZ0efnBPHZlhcrT03ueC9vEEVOuaeOk7LAhYpV43i9MWL9uAsF14JKwM03GRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqWWLiJC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5322so703813a12.3;
        Wed, 04 Sep 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465632; x=1726070432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u562QhIJrAV/3yEwnR0FdisLkB+lO3ntNL3108Pvrss=;
        b=UqWWLiJC57KXFgRDUSipePZssxdRTNc7IeT9B3eOhD1S2BP3pmedW8FDtLcGO8JGtl
         zcO8BDdZlFCw47o/Dqu7U5b8SzEkqv1pNKXZLjP2e0nCqqSJp/ABrQQOm6z0trmaVit+
         Aliz8suK2O0eIktyYmBW+yc2EXuD0zYgQpGNnREWK8f9zsc81qDs7R6X01eSA/QGZNQr
         fjEVvZtKkRbpUGXq1s/LY573XlFzaJ3srsBFrrwREMZBI+sk8veqHk02+I95KrkiESM+
         lJhXETtEKdn1wfFDeMPJRnpRxmcQLqslbqMnsw+AoCJ6WpqfNQrlfdevi/4wDyseTbAq
         OlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465632; x=1726070432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u562QhIJrAV/3yEwnR0FdisLkB+lO3ntNL3108Pvrss=;
        b=xQ92OOlCBXQ5Gi/meuldBg2py2nB+g4GoSPbEHos9HmX3ffKbi1Bw9yoH1WaRivLWq
         zf5enEPlZQVQZOc2YXBxvOroZ63PU19zGsfRnYjoZtK6YffcyCyi7/FpufqeL+g3kO8H
         514rZ5+juL4bcW0KLqgIULmTOF4cpJWfZ+R3I5IErHSpDDV+ZVk8KDa2NxNkUu2XrjEs
         NIbf7fPS7pwE2+UjCDufeB8+2rMdPdDMnUyYk44yiHydicJYhvkHRRJ+Vqzr5xr41VXu
         U8qCeaa3MTxyN0Pe3m+90Gwkh6Bm2TdkJumMccC5N281WT2URp+5Bmml6oJ4fB1nv6ze
         jHxg==
X-Forwarded-Encrypted: i=1; AJvYcCUk1HgYd8PcXicfE5fhOxoybOG8W5JCYz1NcpUrVlZtNvenll8aSb6msa6aUvXwkMbuaklf2XNM@vger.kernel.org, AJvYcCVLfcjQKUiZn2YnRad/1OLmilCCJNYOK4EAGCAy6LVCWKzr085yhjj6ajace/6XFuWYbLFOV5RD7pCx+6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPfEpp8YAKVXOfwlNbKLF5G/yfvjkiOqVwNddU07xo6QQa6mA
	Z0NWEtGgD6QebA8qUPheOaU0f3xpSGcXuQ4MXukNUajI6mi4A1xQ
X-Google-Smtp-Source: AGHT+IEFcd58xREyckVIyq3G5fmmOo1FJAe+mAd3TL6j9pcVBAaX2pHXbBv1SNKS0+RCOnrBGwCzHQ==
X-Received: by 2002:a05:6402:13d1:b0:5c2:5dda:973d with SMTP id 4fb4d7f45d1cf-5c25dda9906mr3890079a12.2.1725465632250;
        Wed, 04 Sep 2024 09:00:32 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc544a3esm76216a12.29.2024.09.04.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:00:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:00:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v7 7/7] net: stmmac: silence FPE kernel logs
Message-ID: <20240904160028.cjmnadqgcwynncmh@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <3cc959e1ab2e6cc7a4b39d22e34c38df70f01125.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cc959e1ab2e6cc7a4b39d22e34c38df70f01125.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:22PM +0800, Furong Xu wrote:
> ethtool --show-mm can get real-time state of FPE.
> Those kernel logs should keep quiet.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

I don't have a stmmac-based setup to judge in person. But to me, these
still look too chatty, for being things that user space can always query
through netlink.

1070 »       netdev_info(priv->dev, "configured EST\n");
1090 »       netdev_info(priv->dev, "disabled FPE\n");

Also, they don't seem to be balanced. We don't have "disabled EST" and
"enabled FPE"?! I wonder if "disabled FPE" is actually a typo and should
have been "disabled EST"?

What do you think, should these also be suppressed / deleted?

