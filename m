Return-Path: <netdev+bounces-117806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C794F637
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399C31C2123C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C12186E5B;
	Mon, 12 Aug 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMwCygGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5D17967F
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485607; cv=none; b=l7ka6xkoffFJqxHDlx81EOpyLwewmS+gLw4My8fKpaV+DSnhd3y/L6XRHJPrGCgXjy6zf8gqZGyP3j7bZKhxZKi1tYsNkQbXJY98zIMuVsZe/i+E8UK6hCv2EzQot8E4EVpg1jfXGJa3aA5SQQpvkaPMIqJHY5qhUUtbivFbzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485607; c=relaxed/simple;
	bh=JCLX+2HqprCl83qA8NqSiTIpdIcgxmWdP9iI4/RjSbY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PYuWwNVhajsLe5r9ac0lNbjhEcek5YnCKmL9y7Rg34pMy6+wKRHReK/lK0pxFwJrf+bGN7BjJ3akmu0e1wKr9avzRcNb8TrwdDjv3/W22SL7fLfwJh4SI/W4W/EnqRKEpTMaJkVQafzzRAEebxXZdF7tPbqIWOq2PT3NKKroVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMwCygGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3AFC32782;
	Mon, 12 Aug 2024 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723485606;
	bh=JCLX+2HqprCl83qA8NqSiTIpdIcgxmWdP9iI4/RjSbY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RMwCygGgwKyFY0dBwk62rHnicvEBUbhAE8jgKK8UynokIRoJHDtUTVUbs3svZfQ8a
	 1lseAvHpyQ7+6ZhvJnT+efkXauh1o3ZoPLTZ0uRbpaXNCybI0AglgcHJg62f+aNYOH
	 qmp0K3pEqGEmolMb9jnJDcc4XtdH5r8g8h9pv4+HZusk8eUJa5Wl4y3/j+sYK/SRsv
	 9dOILJO3S3V2Yl2lbMJqdDi/E9QaQuB8MEGUBnkiLoo6Z0m7JQgLx1NSaptRC8ij+y
	 5oZmF8wNOB873T0TDOpoa9xWpDIm3wRSYRhiSmJb7BAquMuDzrPG7OKjV5oGLIkLP2
	 MUumMVuq4Wgwg==
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7EE0B120006B;
	Mon, 12 Aug 2024 14:00:05 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Mon, 12 Aug 2024 14:00:05 -0400
X-ME-Sender: <xms:pU26ZveTsBfaxY1kCK4PYzBlvaFHVPrGu95XyJ7JEcBEZo13KMyeMA>
    <xme:pU26ZlMGyZzuOPkuOiEwIQsxS52VxsGHASFvWU_X8r8vwT0S6hEtS4Wyh4tSkFNvC
    SUAnXeuBQeVgv-iBPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrh
    hnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeejvefflefgledvgfevvdetleehhfdv
    ffehgeffkeevleeiveefjeetieelueeuvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonheppehkvghrnh
    gvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrd
    horhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pU26ZoibKiMHA4K14U5zmxeO1XKn6IUqz5g3hyiK3vU5O-i00nn8IA>
    <xmx:pU26Zg_VI9fUqh9iXlpvYbsGlUL5WGG9IJNxubWwLl2gPXXTQ19-Cw>
    <xmx:pU26Zrv1xHPVeYskNlK9sq8DKHhHA7ijgF6_EZeQf8SPg4ZQ-sRKug>
    <xmx:pU26ZvE-7XKHWASALINHuvOVxxO0vwg0397T_KzeOJrkYFtz9wi9CQ>
    <xmx:pU26ZiPkWYxrO8bfJmGz8BcF-h7wWZJDqnL3ML0gsqN_eQyIexWdKWWE>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 389CE19C008E; Mon, 12 Aug 2024 14:00:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Aug 2024 20:59:47 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Message-Id: <1a9a1995-f49d-4b1f-93e6-0ba750228464@app.fastmail.com>
In-Reply-To: <20240812075910.180a1f4e@hermes.local>
References: <20240811164455.5984-1-stephen@networkplumber.org>
 <20240812073320.GA12060@unreal> <20240812075910.180a1f4e@hermes.local>
Subject: Re: [PATCH iproute] man/ip-xfrm: fix dangling quote
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Aug 12, 2024, at 17:59, Stephen Hemminger wrote:
> On Mon, 12 Aug 2024 10:33:20 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
>
>> On Sun, Aug 11, 2024 at 09:44:46AM -0700, Stephen Hemminger wrote:
>> > The man page had a dangling quote character in the usage.  
>> 
>> I run "man -l man/man8/ip-xfrm.8" before and after that patch and I
>> don't see any difference. Can you please provide more details?
>> 
>> Thanks
>
> It is more because Emacs auto-colorizing of man page
> gets confused by the single quote character.

Ok, thanks 

