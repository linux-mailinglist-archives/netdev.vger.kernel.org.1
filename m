Return-Path: <netdev+bounces-78056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08A873E3D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A71C2092E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207F141997;
	Wed,  6 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="levKoCIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FA14198E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748215; cv=none; b=NE7c4UmYMNzK+HNEeDApGezLpzcEunBs6nZdJDdAn3lUIqq1b74/59cKXiv3c6CCKum961ranoG7H6nrJ6fdsYwPNw/Do9KEuMCfL6K60hMFccDnpmguNzLXjhJg7+UeC9yo9X+GaN26vLw/uibmnsL0QJkZXSDbXbLowOvqD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748215; c=relaxed/simple;
	bh=PHJUVwqfiNgw5vNIMKxIICyg1+WyBLjZ2Dq3h66vRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZx7f/VedTNq3Oc2EDvNqeew8sShpG6x9bZBaFzCAHaqcbfpXwx0bZSdQQpsBb884H8p72Cu3577IBeFdUdo5iy4CiviDZ4D9unllHY3oQf8p92kLL+jAQrpWZrFVa0p+7ga1fpPgzSdb85gpba2o96yZpk5PAFNejyQNmC5k60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=levKoCIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F74FC433C7;
	Wed,  6 Mar 2024 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748214;
	bh=PHJUVwqfiNgw5vNIMKxIICyg1+WyBLjZ2Dq3h66vRdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=levKoCIEBYD1YDSAIQ1VncM3YwSQkjuwKvSCZzxqM6gHLNwGHvUQHDXlRvz47RKJM
	 1PS6dXKtgZvvXGgSTxZFGjuwKy1VhpRpm0SpHrF3DG/29zJgliX0L5RHtYGnGHsx0/
	 UcxqeEhOLZUq3EBryca88unusJKGw7og0DWAZwht9Mn3sRcHr67j4vs0xW1bDNR/yf
	 ZFJNN6BRqTl6EXCop2Y7n83knyHna5a46cQTL7tG6hzXn0LNJHwzXr2vCMR4xrOoJY
	 YFaT0ueLCvhE55NoAh/15AaZ6QQ87wpzWl7YCzvmJpCXa2lJgc1XriBG7/doUi5sFZ
	 31QSHwz9v2aOA==
Date: Wed, 6 Mar 2024 10:03:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 3/5] tools/net/ynl: Fix c codegen for
 array-nest
Message-ID: <20240306100333.502fa911@kernel.org>
In-Reply-To: <20240306125704.63934-4-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-4-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:57:02 +0000 Donald Hunter wrote:
> ynl-gen-c generates e.g. 'calloc(mcast_groups, sizeof(*dst->mcast_groups))'
> for array-nest attrs when it should be 'n_mcast_groups'.
> 
> Add a 'n_' prefix in the generated code for array-nests.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

