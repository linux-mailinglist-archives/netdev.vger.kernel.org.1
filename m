Return-Path: <netdev+bounces-70416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFB84EF0B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535C2B2208B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 02:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3615CB;
	Fri,  9 Feb 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ4Q4kKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BC1865
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447170; cv=none; b=Pw8SkKkYR4GK+KbYvT/Q+UkqAJuKQC95Zmbb/4VTAIDP9CUE8+qCQzWvt9SFn1erLWgM7B8DzF8UU71RKnW3WTxLydyI+O19il+EQ6zNZ+YQTRLu5RCW+vypY5ll/hu20dns73Uftisvz0bmkDboeNFxoeG3d1hcNmgz4lTeaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447170; c=relaxed/simple;
	bh=i9XWApDlcW/3hRlJ4UoNydF+rsci4v4WYp4BKplDD5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlskBimIwpFVXhnjvqIHt7Y6edwoW/AERvsYnXCyPayAFVVOpUkp9gOYcuks/GJ7UMYA8UlVVoUv03yydJMi0PItuoRXWR1UyhtCqSYqxOZvDGqcIf6HL1JLdTQXSIaFchBBAkicRHewAngpeOAlwCm6pDkWPNfU2igwMGkhIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ4Q4kKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370FBC433C7;
	Fri,  9 Feb 2024 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447169;
	bh=i9XWApDlcW/3hRlJ4UoNydF+rsci4v4WYp4BKplDD5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZ4Q4kKIvU36O6MsmR62hKmcfh73I+MOs9A4Zth1GueN28R51yfoRlgXlTIbQAwsk
	 Bg6KM5xcSOv4ICxinuu7WcdYRjmqIAZliASSkbQuJLrflm/yN0emq2vijn0B/hyEHn
	 /1zmKIFLLvLT+SPkc97JBzEJ8Syp706PBcYiDn8Ui+ozC5lGqGWYAa9KCc04hsVnaK
	 y6E9jODYhth5n2/wuVTxVANEjOTFD2N6N/oaHcGJuneeEHUK3Cw55aRAZvyWv2qIJ7
	 /Wga71PCuzLNyA/jN+Nc73jJ3aDH8IUeGt65jxojfAq5Zf2lCVrANv5oJ7e8RT1etr
	 Vvs7TDy0OUc1A==
Date: Thu, 8 Feb 2024 18:52:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geoff Levand <geoff@infradead.org>
Cc: sambat goson <sombat3960@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net] ps3/gelic: Fix SKB allocation
Message-ID: <20240208185248.4cbf28e3@kernel.org>
In-Reply-To: <e0c28bda-4b8a-48eb-b2e6-033abc82ff5b@infradead.org>
References: <e0c28bda-4b8a-48eb-b2e6-033abc82ff5b@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 17:49:22 +0900 Geoff Levand wrote:
> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
> 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in a
> kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.  

Please create a targeted fix for this problem, and send the cleanups
and improvements separately.
-- 
pw-bot: cr

