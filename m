Return-Path: <netdev+bounces-128428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84373979817
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C155281C6D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2E1C7B83;
	Sun, 15 Sep 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogYcisMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA091CA8D;
	Sun, 15 Sep 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726424355; cv=none; b=cWDh6a4Rqx4jHByQsSuRITnhzYu7xBX5alf8esX0EeFw+RDooFh1YE7MbkUK7ao1nhSqqI3FBFJyka/dCjITaa5a17kVt+rP469RZs25S0OruMMQioaJLv3gV2/7vhLTE4UJenAy7XbJ9MV1Scy2jvE9VrC33Jx9TbJMCts4i98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726424355; c=relaxed/simple;
	bh=RpT1UNnZjn0Y2Aail0+MQdCQgNfhfA8IOCXVhXPeYEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Xrv9JPRnK/+a2lOAD44HTVct6RafyIWz49IZhdNHyhA3rs7PtLxhHA46kLnuUEx1SovVIhNAD1pysR9XEUYADYrufvg1MpuqYOInX8JwvcIk8sfpBEgx740qrM78RjAAFhiWF8STD09YcmK0z0vTTsJ33ffDHelioF6WYLek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogYcisMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3325C4CEC3;
	Sun, 15 Sep 2024 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726424355;
	bh=RpT1UNnZjn0Y2Aail0+MQdCQgNfhfA8IOCXVhXPeYEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogYcisMMDT58z/t0v7UfBrQzEoNfi2a7x6oYVVGs48hdaeplrwJU951F3vfXQD4aA
	 XOdZKaNKjDRur+KRoUDC6+PQSrlWd5pvSRCt/6Iluvjis8DDT/eZsBaXcEyC4YgDZ6
	 WnwMn6V0YSCYNuMsJyzAqSEnQg4x7LHmJiYXu2vQwisov1y2GNQxO8eealTg5J/bbj
	 l5X4pgbIjHUpQwHhPwaqk3wGQsjUbE+kQ4K+RKiPz8FvG43YYEOSQH0mnWC0rk1tD7
	 7cg5cegCq1NIXySDzU9QPC2yaFiTvCSdU2HNn41XNKXU+9XwBLCJZENS19EyUyV/oB
	 EDGJqweI9SsbA==
Date: Sun, 15 Sep 2024 19:19:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, thepacketgeek@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk, vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v3 03/10] net: netconsole: separate fragmented
 message handling in send_ext_msg
Message-ID: <20240915181910.GB167971@kernel.org>
References: <20240910100410.2690012-1-leitao@debian.org>
 <20240910100410.2690012-4-leitao@debian.org>
 <20240915165806.2f6e36a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915165806.2f6e36a8@kernel.org>

On Sun, Sep 15, 2024 at 04:58:06PM +0200, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 03:03:58 -0700 Breno Leitao wrote:
> > +	if (userdata)
> > +		userdata_len = nt->userdata_length;
> 
> I think this will case a transient build failure with
> CONFIG_NETCONSOLE_DYNAMIC=n. kbuild bot probably didn't
> notice because subsequent patch removes this line,
> but we should avoid potentially breaking bisection.

FWIIW, I confirmed that is the case.

