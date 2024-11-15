Return-Path: <netdev+bounces-145327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179379CF0DE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FFB2816C2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A611D517F;
	Fri, 15 Nov 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbYkaEHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5451D5148;
	Fri, 15 Nov 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686433; cv=none; b=uP/hrcSNIiKTPbgGMmuMIYSmExlEhJvkjwLJIZNuy2NkjMqHkGz9aLUZX156QlCg0U2Gw7epAe4oXWX6O65UBg8CYNUBvjtoTW9f4iY4evaYqtNkOFm8Xn1DCXVYLlP2ueH3IugIvvoaOpyeEPa1ieu0gIZBzEuBmSR1pA3c2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686433; c=relaxed/simple;
	bh=78dCrQx6kd5r+9pryceZKn++EWKScvXLeCgyjvErcv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfA0gKIZk7amXQLkgs/uJ5EyHUU3AWnGIqZktizRNriFJGL4IUaNi5FdJ7XQ3POWrHaGAwvN1aC2nc57qVZQCjRDWmSp89WKCYWGNyLe0DMvnbHdW6F5OcW8li4CHeA/eEx3JLPI23pZFfddHNSzbzNpNXfokRpK/G83Rry76XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbYkaEHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB0C4CED6;
	Fri, 15 Nov 2024 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731686433;
	bh=78dCrQx6kd5r+9pryceZKn++EWKScvXLeCgyjvErcv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbYkaEHx6FgiSg6rtILpP9uM9y2bEbaB8ymNXg2cbn+OyRoO696DFBhEjA259azwH
	 I2EPHVAzw78SFsi1c0+iEZBxt1JojvurS3EYdNK9HThtHVTmDQAMi1r0jC3pzu06mS
	 EasaGO8vnqLiQssuzSCPQqC/+HvOdkKgtXzAVzNo5QF9OEQbVTmF5iey7I5xndIQqz
	 ENCmC8PAGDHA9QiFgamec7P8yEU7PPwf+WPYFYY89UrDMkoxf3Jn5YMBqDpB3CZeQM
	 LiSSkfzVEoiibaVv23XXMbBx33dQqcQkrYchzvfPBjzKbsleZ6oFjVHrl8ag3OK6+P
	 5e8FwBerA8DwQ==
Date: Fri, 15 Nov 2024 08:00:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: stefan.wiehler@nokia.com, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241115080031.6e6e15ff@kernel.org>
In-Reply-To: <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
	<20241113191023.401fad6b@kernel.org>
	<20241114-ancient-piquant-ibex-28a70b@leitao>
	<20241114070308.79021413@kernel.org>
	<20241115-frisky-mahogany-mouflon-19fc5b@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 01:16:27 -0800 Breno Leitao wrote:
> This one seems to be discussed in the following thread already.
> 
> https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/

That's why it rung a bell..
Stefan, are you planning to continue with the series?

