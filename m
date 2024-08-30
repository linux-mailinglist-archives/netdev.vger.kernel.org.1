Return-Path: <netdev+bounces-123565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69C965522
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D7E1F2101C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95D482DB;
	Fri, 30 Aug 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYRmVEbN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C01D131C
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983878; cv=none; b=WthuwqoZ0CMZjyrR3sXHgKEqxFYcZabXAFTbp9TkP1/z/UV5weJLaxPhYsstRYl76uj/9krXr5Lxm/mDPj4CqWtSi2uSbJWTTSoBaHo4qcFBWdU2mLEWyWqg/JFYmGfWD28zfYlTH9vxOWHWB1gAlGH3OIzMRIGGie5skj5JzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983878; c=relaxed/simple;
	bh=CLF8/Dnt1U3GQdOjQN5yCqvSSG1ers65+eLXYDU8VsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX+i3+ehNaFClvYwFnDZQq5uRleDyxZ53iJ4BnhdPNHb8nuEHaqg08b9ZPnsJDGnJVgTeMbq4sEPWwLgYeTCozLm6DwBkNd/ifEp0cGo3rQFOtJLrsfht/tS1/LiIdrtyWkhuel93eW3eEabvLypm//S1bKks9Fi0MpL/H0BRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYRmVEbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B23C4CEC1;
	Fri, 30 Aug 2024 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724983878;
	bh=CLF8/Dnt1U3GQdOjQN5yCqvSSG1ers65+eLXYDU8VsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hYRmVEbNI5jLFjY33pYMvVm4/QmXjzFxjeIs9E9bXEUDWFYXBEKT0vGFxO0w5dZ+N
	 OztTzK4rCPQ0O+j9bVqgs7pyDnivTEUCojaLozM7i22YK8G/Ao6IX4HwHduBEjI2nJ
	 Jzr0/V0/ju7fqIHg+EbXQXhNRVp+ZRhAN5WSYUNgDhXrw5//MewgwphO9eAYYx7Th6
	 v4nhfMu1f0Nz+UjmOBHP5PcDC8meDaLV3opAv5rh0ErMw/FDimYKjZxDf9kg+ws1Mj
	 f4EEO1ZG2k6bMEgx+63eYXpYO8o21U4yAfgSLaDiLW3rKxFENmeS0yjDIQpP96MAbK
	 ck4ltRXarooLw==
Date: Thu, 29 Aug 2024 19:11:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 07/12] net: shaper: implement introspection
 support
Message-ID: <20240829191116.2af4da33@kernel.org>
In-Reply-To: <2ddedcd3f4dd4d9986c3a3bc995a2c410c20440e.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<2ddedcd3f4dd4d9986c3a3bc995a2c410c20440e.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:17:00 +0200 Paolo Abeni wrote:
> The netlink op is a simple wrapper around the device callback.
> 
> Extend the existing fetch_dev() helper adding an attribute argument
> for the requested device. Reuse such helper in the newly implemented
> operation.


It's not just for introspection, it's also for the core to do error
checking. Does something prevent user from installing a PPS shaper 
in iavf right now ?

