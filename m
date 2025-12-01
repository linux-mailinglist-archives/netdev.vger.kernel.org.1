Return-Path: <netdev+bounces-242901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D0C95FF1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 08:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7FFC4E064A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE742BDC0F;
	Mon,  1 Dec 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUJtqF2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D52147F9
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764573871; cv=none; b=n5OVh1UKk2Uvn9qguB4ktK0Se88GlM1AEWhoIros56/yernSPa04O883bcc6qjju6w00HZa8DDhp0Z0dEXleejoEedGs0M0Wgssvg4WjbZncK0Ep8+3n3AL9nLPQ5By1o87v2dxLGVcHgYr1tunhD6pF4pdY3u5sWbM/GZKFwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764573871; c=relaxed/simple;
	bh=d1Rr6rpRfiPfMkLk7v0eVQ8eSFR47MtqyYj6SIxsHmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCpnBXy0Hskv4GKEcUtNLpK9amLM7qe4/waybs9oM9saBWH8o9pEXJEjmvTOfCgccTWEYjrjWSA0gq0dDJ8xp9naAGJUPEo0KRKDTQjAeIlVsGYwMyPAT7WCf3IFAy+tRo7eyKYgtyg2JDxxegZvwX2EtGprtDnu16s0R8hxtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUJtqF2/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297f35be2ffso57677605ad.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 23:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764573869; x=1765178669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SfyoeKYKAcOT09v8/ooBz59g0ZOPzuMsKnG8dXqXh0=;
        b=mUJtqF2/OB0RbrEhiIjvf1f3psE4WdvAg+71UliWDheQN/E2ODu+lY1EPid37hMcjs
         T5BGeUTweJB48FRb/KMPjs8LWTvWqLTLIBh5wBHzFZ3/HYAeGUlhKLJnRIlrR3KNWkO3
         ylLn3I4lXwlu5AtiOkmzOxwvM554hEQM7ih8LXLGseN5Q7j5SlfzJHM9yq4kn1yIRC14
         pqk/6ooJgle3GWACzQsqm8x8Vfd5uG+gRtYyngKHjS8r9MWPEB50pKwqGzA1VOodfr8p
         JCs5xuBeYE1XCEZVMCxqYfZo1gDOr0eKnBDEkyYXIuZzCzVAoSWd3iLuLTnF+7dFUl94
         SjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764573869; x=1765178669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SfyoeKYKAcOT09v8/ooBz59g0ZOPzuMsKnG8dXqXh0=;
        b=Ucv+Yl8YEmXL6iawp8yqqtfTYmodgRv6D/ZmhNvif64cJjRDpdevQBj6uWC72P2z32
         CqYlInTsqMkD9tH2K96xKqbkiQaLnrmug2Jq5XCVXVLM9krR0WpH6v6PTcUjNTV0ysUX
         8f5CQEziFYOCSypHmvcAlQ/85LdcFpZ1zPltqIWD3+bRVHV3IN7gP86LCRZX25lkqk36
         eXGoSCqClHuj7mb31VigM5zlqgfxACIM85cr8clf1up/QJXRiipdVP8wsNlTeBVkHD7U
         0MOmAYMtSSCad/ApLj9wEfSO8GxlGnEZgRLk3yiAGHhquKNnSnorwzYmQQMeRcsxktt8
         guKA==
X-Gm-Message-State: AOJu0YzweTVBzOcbKDxbMocQ0jm2sAu6v7dvKTDAQF9LuUMg3tQ/eDs6
	ECT3qHAcDGlZRBC8SZjxIBg1GOq9KjDmemOR8B8xSx5WM2WPNA2nCWzV
X-Gm-Gg: ASbGncsttpqw14IEoNsfHMEbwMT/QcrhUIvzuthVtcrtoWQyJJk+apDNHWJs1QdjV2t
	G8VsY9948D2e0scYc34slClz8UTnBwRKKjxRgQBrE1VD+X/BaSyo9gIufYUkQgv3VkOoC28HkPD
	a7kIXlylXwBEEIeFDrfegZrVUkiZELjHIJCrFZ+GO4HGbR4QSlub7bWr+UIhVLO1ASUzJxmE9mX
	QnWrdEtXakz34f+zVAD/thHyHSBSygLj0RF2AG+TwnZU5x7BfDyIIXtyiokQiMTOLcRGJ4QL/X/
	dit6MNpEJaUKjU54BOSiL2SMy7xBI33khqrY3uoOQGfL4mmuQxzd9nfY9oIbXdv08GxF50/5oVh
	Cxn/9SwxxAi0ojYpIC/xB48LKwKUOiXhLlPSSEf3y27LTfEVVRGZDTLaCEI6ginmE98cXwrWMiz
	bf9u7q1bG7F1npoFo=
X-Google-Smtp-Source: AGHT+IFwxnk1Ng9LDlfIXLeZzRw4DKwLeSYFA9+GA43ltIP+7xQ6kBEzvDx+xmG/XPbAsBril018Ew==
X-Received: by 2002:a17:902:e551:b0:295:3eb5:6de1 with SMTP id d9443c01a7336-29b6c684abbmr459677465ad.34.1764573869403;
        Sun, 30 Nov 2025 23:24:29 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce478762sm111553505ad.45.2025.11.30.23.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 23:24:28 -0800 (PST)
Date: Mon, 1 Dec 2025 07:24:21 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 0/4] A series of minor optimizations of the
 bonding module
Message-ID: <aS1Cpe5xZ56ygg2J@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130074846.36787-1-tonghao@bamaicloud.com>

On Sun, Nov 30, 2025 at 03:48:42PM +0800, Tonghao Zhang wrote:
> These patches mainly target the peer notify mechanism of the bonding module.
> Including updates of peer notify, lock races, etc. For more information, please
> refer to the patch.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> 
> v3: drop the 5/5 patch, net: bonding: combine rtnl lock block for arp monitor in activebackup mode 

Hi,

Please add the full change log in the cover letter if there is a new version.

Thanks
Hangbin

