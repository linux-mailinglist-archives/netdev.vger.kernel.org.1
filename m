Return-Path: <netdev+bounces-218029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39625B3AD89
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827DA1C24CA8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB02367B3;
	Thu, 28 Aug 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz5mGPLD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0008DF72;
	Thu, 28 Aug 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420320; cv=none; b=OnMTpBKv+Rxl45+U4QeRBSgnb1GSnx5gKiAitYqLtZMOo8nTP3T14x0rQFyfzY5x7PeoH+hHZgegAINB988X6/WuR00Mu98xZ6ASuJDzEIlEhegq/hi++0zvfSHdksNJGcd9wZrCAqUEe35qupcKtyeybSucc4dBKQBKUySpIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420320; c=relaxed/simple;
	bh=F7A4MWxQSm9GPTsYP+rlxbmrqst3/1nPKdk9hDiLWoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mw56NyEQ/ZjY9Tlk6otNWrrlHK5itU+h7f595CbfWxQqT9Su9am7QcKpgsVSKs7sqiZH8xCKRgEDuzOXaNuxZ8+cAnvjzu1gumdYrBrI8SPyTodl4I53R356MxAqn7qIo42vOvAjiYdVgI+9ZaCg+LUP9N13Mxs/0x3wQnuQz1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz5mGPLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D434C4CEEB;
	Thu, 28 Aug 2025 22:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756420319;
	bh=F7A4MWxQSm9GPTsYP+rlxbmrqst3/1nPKdk9hDiLWoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iz5mGPLDyIKw7fx78+4jQfZNlCjP1o5tE3md2oI9fCqwF56X3EysRLl5OvQkgZoTZ
	 +cn0reXW1RT5d8/WuA5If4GYV1mp71pfk28yGuP9xnK+9sHPiahpUk5gSU5A8Gd6A8
	 Go14I9p8K9mZj8qoQZTiZhuCfJoFx52172m/ebUSQehESE2DIwPX51AzOvrkZict9G
	 X5TzaH2mBAtkARBVGyR1EVEOSq5orCsQSbfufb8N2xkDxyjZFe6wFDtkAcIYVtGfVw
	 64mY3NKGJqJ4NZKdlR5+zwCZSYlF6Of8QfLIQ0wQa3gIm/4Gs5mVqSoPDpRyVTaSnP
	 7UFJLoZ83TYLw==
Date: Thu, 28 Aug 2025 15:31:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 almasrymina@google.com, asml.silence@gmail.com, leitao@debian.org,
 kuniyu@google.com, jiri@resnulli.us, aleksandr.loktionov@intel.com,
 ivecera@redhat.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <20250828153157.6b0a975f@kernel.org>
In-Reply-To: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 18:43:45 +0200 Arkadiusz Kubalewski wrote:
> Add support for user-space control over network device transmit clock
> sources through a new extended netdevice netlink interface.
> A network device may support multiple TX clock sources (OCXO, SyncE
> reference, external reference clocks) which are critical for
> time-sensitive networking applications and synchronization protocols.

how does this relate to the dpll pin in rtnetlink then?

