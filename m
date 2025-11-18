Return-Path: <netdev+bounces-239388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA82C67BFA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A88D929C68
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979A62EA743;
	Tue, 18 Nov 2025 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc/ODZev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296B2EA16C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447847; cv=none; b=frKuZFRHq5Wc95dqYXpXztljEEheMhUUZ4te9Zc4ihdEizxNkad+C4zmPiEvF7/hfNOaZO+vlkXADFIAZNhG1AOfDpPPAPGi5HP/mbTITrhrybMXcXA6sWm46NgZuFBW1ertDhtSY9A5n3gwF25PGQ20xvq2tJbBF/oqaNWoymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447847; c=relaxed/simple;
	bh=RY1GxG6MBqh6NCveOLSrf90a2ONzNoxjMM6LXqGyRiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuWT8jjEOr3b2pryemrBHu9M99M879wJk7tVUza1yZ8j7/jHkZsey/kGGdUvwt2CGxqbSWM1MZueWRZedjnmsVgCRcAWDCb4gKfiRmFaPsbdwv7tTbsKEJbSlJ0moLUdz0mKrrLeD3MgyCfch8zgU4UAmkszv4KToRU5thHcod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc/ODZev; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so5756884b3a.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 22:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763447845; x=1764052645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rKXeu+SiVQVquAoWhSPWf0RcZCWL+HzPZuMMI7btDH4=;
        b=Mc/ODZeveQVtJhS+j7s+6Dkxi3/KBiwE1B3HKZii02X+XfUCpUZqcwzspsnzgbv8x/
         st1F21oraNhSAnB+XmH3F07a/c/5McEGpce5+dIQ5EcajwiS5KJ3fMT0riZg0I7rLZAi
         tiMNurTSGAqeVdsqzCtPk4EBB8CtB5hzp6BJdoWrNyXLnX9Jxmqs+OKVPrGWzF2PHcQT
         3G9LYlnC8AL1kYvryAR4tkY0xarlGsCGrO6z+zOQJdI/1cO3myXytD93xB57xUnCyNsA
         0ZZz+f62NK7Mf+3G2Ds6APEAn8u05qH5+mPmpWe1aRyJ/5OriCMoYQpdS54iPVU4csyy
         AI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447845; x=1764052645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKXeu+SiVQVquAoWhSPWf0RcZCWL+HzPZuMMI7btDH4=;
        b=Ui6x9gB30ILWSsLit2UOnCXywdf6XWx0fGtMc8+fZLVpFBs2KGdjyP/2zLI1oTI+la
         hcXXEXML+aYl/oj/PQq5EWrd9cCJkO9mfn6KtzVUpOC6sAWKox4YrYkgZrPEt/5wLFh/
         K98srcuq2s/UXm1dkJfDbsT+UFdRsYTt9olMofyGgMkRIfqmHsG1lhgOsRKF+RFI7tHn
         gBCN5KHDEJooyhTLzVw1r3M4TA6PEOKt5PZ3HXMDSo/7Vb+PPTGHy9kXlwKAvNXoVaGi
         6t4gAJVspONtKObF6EhEtp5K/y1gt1xUjEdzjvenxFj/5s4wh4mLAnDQu5i0K5dO1toz
         6UOw==
X-Gm-Message-State: AOJu0Yx5/rqheRwyFnQIwNKPsKGRP5ZqfuMeg7qBL5ePxjAZchebadFl
	YEHIS3ne9RdwEYCE2yTo3GSzAnpWALWkZu4gZMwLDJqlgRaRjSkQJVgt
X-Gm-Gg: ASbGncuoPTCVWLpQfemLWHkUjD1x/Yuojk0RqMLaC1Qk8vG0RE+GX5TRPxR7bDu+0RQ
	UxpXHO53QdpdOIfagwhe0M7hin6fiyiSDJ9RA8QYfGLSoBQ+WUlBwFlacVjtQcs91r85OFy+LEY
	TkxoiqgDRdJiVDMeSFabeswyNkX36V+HBDBuWuGqe457D2tzQGyLBXp50rqkS86RELwFtN70rFU
	EUmQ+8Dm6u3JcLiiqdEkFlkV7xuiRbXNkmMmimPPS1q6bzO0TY7NlgIbLqrzFKVYiXYAEnu8Pxg
	UCvafevKQIcJJiHp7jCcCe1WsHuUWrcBhiYk6w/zXCIPJ9deo7fITuMINsovUYmqtpno2YmHBIp
	kxks4p5kTuGJJFu00tO296e8xaFOYZ4JSLo1ByGSr0SP3ZcQ2VtzHZzvWk2O8ixCEHeTMlB+pST
	R/yt4WBewk8BgHbE/3zpogakjqKrxXUSCOeM8+qiu0h6Yu1Ed7
X-Google-Smtp-Source: AGHT+IHXALiriWwJLx7SmcMxCfVQY5rBvQyEVgIoRqwO0R8z37/xvVCwrwjnmjxza5ZezAx2KyQwnw==
X-Received: by 2002:a05:6a00:2405:b0:7a2:8d06:fa0e with SMTP id d2e1a72fcca58-7ba3bb8ed5bmr18001534b3a.26.1763447845354;
        Mon, 17 Nov 2025 22:37:25 -0800 (PST)
Received: from lima-default ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251c99aasm15364262b3a.28.2025.11.17.22.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 22:37:24 -0800 (PST)
Date: Tue, 18 Nov 2025 17:37:14 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aRwUGnyFBxrkjGl7@lima-default>
References: <20251113082438.54154-1-alessandro.d@gmail.com>
 <20251113082438.54154-2-alessandro.d@gmail.com>
 <aRcoGvqbT9V/HtoD@boxer>
 <aRgysZAaRwNSsMY3@lima-default>
 <aRtPXS8haLNHu8H1@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRtPXS8haLNHu8H1@boxer>

On Mon, Nov 17, 2025 at 05:37:49PM +0100, Maciej Fijalkowski wrote:
> This revision is much more clear to me. Only thing that might be bothering
> someone is doubled i40e_rx_bi() call in i40e_get_rx_buffer(). Not sure if
> we can do about it though as we need to use ntp from before potential
> increment.
> 
> ...maybe pass rx_buffer to i40e_get_rx_buffer() ?

Surely the compiler isn't going to actually reload here, but yeah not
great code wise. How about I pass it the buffer and rename to
i40e_prepare_rx_buffer to better match what's happening now?

