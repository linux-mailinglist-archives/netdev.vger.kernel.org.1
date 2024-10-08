Return-Path: <netdev+bounces-133373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E027995BE1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5781C20F41
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872F216432;
	Tue,  8 Oct 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJb+tbkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461621500E
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431432; cv=none; b=SpSY7DRHBQQO9lAcjxR5ZWgj/bHQdgxqswC2gR8ulpXCQroKDcauYy9HZinezGOa9G0OBItBgJpLLsZ+I5IGtV8pSs1fuvdXMlzLk8HnA6x3RZRcIDWvKRjWXHZGGGzsD/eQftdb8oT5CjbF0YLWHKqo7uN4DzDZVsMBFbpIh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431432; c=relaxed/simple;
	bh=Kwpsba+zGI4pWzNF+c6mzhO6pqfbgMbCn60fKlZE3b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT4M38FkObUauBAXUGR6A1GRlkU+E6YbRgzU7YK8OJQNDnPxkppwrBcdFPIlN6C8zvLRjnkZ7ls6Qpm7l9iieoyvEWzfAPxKHYUe5qbE7EHkN3mawFp8olMBfRAHd9CM8m6cTHRheD9VnIIQ8PNJ3PYMWrFhP0lBeUNlJYpi8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJb+tbkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50AEC4CEC7;
	Tue,  8 Oct 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728431431;
	bh=Kwpsba+zGI4pWzNF+c6mzhO6pqfbgMbCn60fKlZE3b8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OJb+tbkVhQRc/ZUxo3gUVwXVOtYl37cQv3daY1HFz1Agv1znwBJCw1DgaiGIfxTO+
	 +/tROs545gn2hczHHEpnNo7evRex++scpeeRlR6GYDbZmbaU49rjL/KTI7pmmHw2Ow
	 8ilmBvVR3mVx2YFtvZUD/flQ3NkcA5Q97fxilVrXEp4A/Uetd51phhjp6WLSiJCgMx
	 GuzUjjZ/lx7hAuIEvClKI4ocOwSHr2D8L0h/5GonPHr3IXOqmjWWtX+ZdlaeVWI7KS
	 AXpEyBXZZv9Jcs30dYotZGXXkuTZq147XpJTV9jfaWUDQEGDMBXNnK8NqPlWIf1Yj6
	 RJDNh5amtJvtw==
Date: Tue, 8 Oct 2024 16:50:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, Stanislav Fomichev
 <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 08/15] netlink: spec: add shaper
 introspection support
Message-ID: <20241008165029.49b373f8@kernel.org>
In-Reply-To: <10ea3faabfd916e955be09a49ba729835e54a73d.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
	<10ea3faabfd916e955be09a49ba729835e54a73d.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:53:55 +0200 Paolo Abeni wrote:
> Allow the user-space to fine-grain query the shaping features
> supported by the NIC on each domain.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

