Return-Path: <netdev+bounces-95436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624638C23A1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1391D287138
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42807171E69;
	Fri, 10 May 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGhTiI7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FA1708A8;
	Fri, 10 May 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340659; cv=none; b=mNEIClOjuOcNnjBUhE3CzleIRtO8qdW7c4u/Xu0axjVKw61+9GWOGmSyIfBIr0nX/FfHr5ENBzAXhiEyBnCaQQfJI8y8gR3VcwyHGDXEaahTie1SLh/hLnanHbh4MNJbNzg9jV5T0Scehl3ZVmV1fm+ra3De/YYizBSI0hEH8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340659; c=relaxed/simple;
	bh=qPgrusRCytwkpq8xY7D2dOR8Bo2FI7+39OMgf/eU3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljwF9rUlM0tuHO3Yjqwxb0UM2EfUVFcm0mrxvQM7DHWlJZqZl4LBL0QjYzS2F64A4bmim5oE7/L8V4BFTu6dRy48dY+jVaWlieJgaoxhQksEAEUaUFHjINKxlJ8mGCuq0sozKq0s+GG77vZNs8WiQTNiffOnsYPzjwx72EmigMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGhTiI7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F16C113CC;
	Fri, 10 May 2024 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340658;
	bh=qPgrusRCytwkpq8xY7D2dOR8Bo2FI7+39OMgf/eU3v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGhTiI7YGWZ4IF4glq2Jzq/p4Xt6XlzHn7bGwa4SLOVPxJXmr7wjVjt+CQDxNFQ6Y
	 8+PnAVtmh7YMUfiMNB9PRs0dv9r+ujwS7chBFKjXU99wMs5dy1S2ep0TdWHywSEKFT
	 GrnphNIVkjaf3KE4sEfgzBOdkQ132RqJrhMxvYSlIX+wGpUiiiOtOqDzETMyYwYezS
	 1lgqfMMiwgqY5Eqn8ycrXpWXrKPlMwIORJ61U7QA/BX+zW/j2OwXvDkjTqQh5IyH4I
	 gTUxEbrybhZw6a6Fp/PzePBHPdsoQBcuj2xMxkKTH4/7ymJpPoux8wa50wjoyp8XTS
	 72PqXA9eiWEKA==
Date: Fri, 10 May 2024 12:30:53 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 13/14] net: qede: propagate extack through
 qede_flow_spec_validate()
Message-ID: <20240510113053.GP2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-14-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-14-ast@fiberby.net>

On Wed, May 08, 2024 at 02:34:01PM +0000, Asbjørn Sloth Tønnesen wrote:
> Pass extack to qede_flow_spec_validate() when called in
> qede_flow_spec_to_rule().
> 
> Pass extack to qede_parse_actions().
> 
> Not converting qede_flow_spec_validate() to use extack for
> errors, as it's only called from qede_flow_spec_to_rule(),
> where extack is faked into a DP_NOTICE anyway, so opting to
> keep DP_VERBOSE/DP_NOTICE usage.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


