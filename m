Return-Path: <netdev+bounces-17285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBEB751114
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7611C21176
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B142214F7;
	Wed, 12 Jul 2023 19:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474920FBB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DF6C433C8;
	Wed, 12 Jul 2023 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689189664;
	bh=zFknxIUp58JbD9ix796NYgBWpRiWepb7NddG7MOPTDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESQQ0lon469eKMh9FscSqGLKQpIUW2tnp9ajGsx2piuIE8wLlQ8uckcKlB2J6W62J
	 xtTMO8gUxYynXAbeujx307qrQfVPNJGCXxaqic9FdLomM0qE6uDNhnu++vpAs5O8V4
	 dURYLwPIqHhImbUEg6LgmHV7V+vmb5SVZil89u2Z5PJJj7EBnkcWdLdKFkoPJv8Dld
	 ESWAGmjQMgzSREK5yH7na1UNn/OBSz0QGWZlpPcrpm0E2nnYKGGKaWWFMNvqIes2cI
	 +gXkA85ksyGhBWKxFxeZN8M7ZbM7gv3cTA/QyrKzhmOxXZEq8yGKH5qDhNh/aWBfh9
	 XW/MX+A6zpDWw==
Date: Wed, 12 Jul 2023 12:21:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 moshe@nvidia.com
Subject: Re: [patch net-next] devlink: remove reload failed checks in params
 get/set callbacks
Message-ID: <20230712122103.4263c112@kernel.org>
In-Reply-To: <ZK7EyBcE7sFVvYvh@nanopsycho>
References: <20230712113710.2520129-1-jiri@resnulli.us>
	<ZK6u8UFXjyD+a9R0@shredder>
	<ZK7EyBcE7sFVvYvh@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 17:20:40 +0200 Jiri Pirko wrote:
> >> Back then, it was a possible fix. Alternative way to fix this was to
> >> make sure drivers register/unregister params in the code where it is
> >> ensured that the data accessed by params callbacks are available.
> >> But that was problematic as the list of params wes static durint  
> >
> >s/wes/was/
> >s/durint/during/  
> 
> Maintainers, I will send v2 with these typos fixed tomorrow, if these
> are not any other comments.

Feel free to toss in

pw-bot: changes-requested

so we don't have to update the status manually.

The commit message would benefit from a rewrite, TBH I don't understand
half of it, specially:

  Alternative way to fix this was to make sure drivers
  register/unregister params in the code where it is ensured that 
  the data accessed by params callbacks are available.

Can't parse.

  list of params [was] static [during] devlink instance being
  registered.

You mean that list of params can't change after the instance was
registered?

  register/unregister params alongside with the data it touches

Meaning params for a sub-object are registered when the sub-object 
is registered? An example could help clarify the meaning.

> >> devlink instance being registered.
> >> 
> >> Eventually this limitation was lifted and also the alternative fix
> >> (which also fixed another issue) was done for mlxsw by
> >> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> >> 
> >> The checks are no longer relevant, each driver should make sure to
> >> register/unregister params alongside with the data it touches. Remove
> >> the checks.

