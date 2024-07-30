Return-Path: <netdev+bounces-114188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC3941408
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC865B2830E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D51A0B04;
	Tue, 30 Jul 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHyX8s+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1619F499;
	Tue, 30 Jul 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348736; cv=none; b=YFegskKs9bywdigpnqyd0Z12gLqpr4DTD9oWke8BT2D9t+iUVrf3zAzIPvaj+Q7OXkOqIUsYktKN2SaH5AdOvyek4Cigf7XaYphH1RT+v8h56WYVn/8XBqPJfByTsyyw183b7hGouemUqzqdfz/IPaN2QnfWfP2f1DKulqTAlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348736; c=relaxed/simple;
	bh=1KkLBL9wCIKeg1aBBRz07Z/yaHZZyMpf5JhqDuFLvvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tf/6TYW/zfMTUfdiljkcMOJzFKK/Twz0IKjrDRz/BocswURjgYLx18PH29vhWWxhcHIglF5LwDG9sZUAUJSQMAojzivI+c+09E/tHKlc/uRrnPrUskFNcaKCxsbJVdLtDB8bgpIem6ml5u7k3s78sk3xa7geeDraaWFnJrMUyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHyX8s+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84FBC4AF0C;
	Tue, 30 Jul 2024 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348736;
	bh=1KkLBL9wCIKeg1aBBRz07Z/yaHZZyMpf5JhqDuFLvvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHyX8s+PzMjMoxD0m+uZvjIGYfxY1l1oDkAJoPtdsQwmY2XtjLs6CpUDaeTdMYXzI
	 bEv4+7BG+NBeiN3H2fIVMeaNj6J2o9qmBWGbed5EVM8BAw7Qst3UqcsI4VVay3SO8h
	 +hqorA+lPlt5huG23vM6g9VBkDd3Pv/H7WmVG+VNJDW4GYQ8sOsx1q1gLqAgb2jaZ4
	 nGDWmJ26eD6jpAiZ/IKAkgkI4S06LYM29Jo58bwby04aHdODgmxYxYAmCQgmVslUq9
	 jT7SiKPwkjEmVUztN+lpR7EuKpesvvHVqYE4ome3BiJ5fReeQIhlE0eh+HzIm31R/8
	 Cu978Uf/92rHA==
Date: Tue, 30 Jul 2024 07:12:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v25 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20240730071214.375dc4ff@kernel.org>
In-Reply-To: <f43b61ec5e624ae78dc5d564e8735ef3@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
	<20240729062121.335080-7-justinlai0215@realtek.com>
	<20240729191424.589aff98@kernel.org>
	<f43b61ec5e624ae78dc5d564e8735ef3@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 09:27:27 +0000 Justin Lai wrote:
> > Please fix these issues in the driver you're copying from, too.  
> 
> I will inform the person responsible for the R8169 of the issues we've
> identified and discuss what modifications need to be made.

That sounds quite noncommittal. Please fix r8169 _before_ you post 
the next version of this cop^W driver.

