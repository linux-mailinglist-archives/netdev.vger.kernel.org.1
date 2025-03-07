Return-Path: <netdev+bounces-172932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A3A56897
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA58F188ACE0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB506219A97;
	Fri,  7 Mar 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="N+/gt2Ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094A218E85;
	Fri,  7 Mar 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353229; cv=none; b=Y9C/8Fk9srueWwzq3z/uIfZAxq5Qs1pd2+1i8KvcsiHPAo7WU9OdZJBnNhGR981NZ+2HcQ/c5CpGAkZUKFpWYfv4QzMnGYHgoF9/LrsuDZhsA1+UhN8QRKXZS/INNBJaNrIOwF0aYYGS4EmmvznYNdvevnnZvzYRSf6hdeCHmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353229; c=relaxed/simple;
	bh=GVX/45xtoMq3BlHwGdtCnLfwLJW456/WdNqXEQIstCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwo+UCaSErgv1QJ1IoA2v2MIulHZad34OrBAUEuGe92662nrURcSZDTG/KiRtYtVgJDHRTAt9sqDazN+sGsIPKjemPFGXaSnd94wuGEVcKNcrnNeug1X+FvhfnJHA7tuZvYkjJYVoI5DlGteXOapkB5QeQ8YcyGsffLOnJF5Lt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=N+/gt2Ef; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B1C040E0214;
	Fri,  7 Mar 2025 13:13:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qNpdm8wJqPa1; Fri,  7 Mar 2025 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741353217; bh=/r1xSvLh1EfmzW0LJsVKSKXPjNjN3VjMBRhfKjjEkBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+/gt2Ef6+XmGHCgSvW74E76Y14WGuI5srhiUvzspjp0p2YFjo0ba/ztVgnHLeHCK
	 uSHK6/7ShuXhDMabuGml/Yh6iL2ebfpYQOn15lPH+0BiAuimcqQtTh02uoL11B5e/z
	 mZNYjgDtGkEZyZZJHOu5EH5f5V/Ec7YCG5uA/nHEXkqOqakqY1NUAuaiCAFFLH7tuQ
	 ycBvym/B4eoue1+nuPlhJQO88LSJz+z5xaUpbWo8Uept7iSiFR8M6nQXqE/QBIGZnw
	 hD0du8+6c+F36ONDuHXs7PRg4lc2HfZy34Ga8ZCllfvsj+ozHTucSY/MqM08xY/aIu
	 e3TGqzq//5bdP1hMgCiDZJV+5luabvM26Wd/w9T6TjjBcMyabTcFA/Bt47mgateO5E
	 OEcFgnMYQ2T6rMz/mkRoSc7J3ihvjwOZUcwRYuFoTsRdq/YHmf4PFMY0klnTpdhQHf
	 HLR7TOUiIejSKS9gy7BsNvCMLDiE7jLeIYkwKEVTmbFEWa/9OGeObL/88BU96wV+s9
	 QICEHy67N0xqNJUUeEraS6ZWnD6Umt5uF8Jb7tg6crbEWZbpa5dDswcts79FCxMRub
	 1GkN0aWIW82URj05Sc9pLE3ogOeDnICShm+gZy2mHyTvxLemVJyztpMrYPXRF0FSdx
	 X6NXB7VP8jXBOrCrLHf+xEZA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 830A040E0213;
	Fri,  7 Mar 2025 13:13:25 +0000 (UTC)
Date: Fri, 7 Mar 2025 14:13:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	kuniyu@amazon.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Message-ID: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
References: <20250307115550.GAZ8rexkba5ryV3zk0@fat_crate.local>
 <20250307125851.54493-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307125851.54493-1-ryotkkr98@gmail.com>

On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
> I'm so sorry that the commit caused this problem...
> Please let me know if there is anything that I should do.

It is gone from the tip tree so you can take your time and try to do it right.

Peter and/or I could help you reproduce the issue and try to figure out what
needs to change there.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

