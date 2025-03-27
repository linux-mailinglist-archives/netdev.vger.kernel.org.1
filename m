Return-Path: <netdev+bounces-177911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8EA72DD8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1C51895C1F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C920E03B;
	Thu, 27 Mar 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKnm+WBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A481CEAD3;
	Thu, 27 Mar 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071590; cv=none; b=OciRb714Iuq0OjRADSgFYymq1pKmrgqUETIXuI3Z4FSeq8YctMLnAZZUI0Qqx0oAtt1MWJLJwZ6FCbyHs94pJ0nw6pAN2LcwY/nOpYNDNFQklAdkIdqHVo/FB7r+/8rtcAJd2KQnEetBVTMbWfAV46EAXGq0FcTbMgtK7yj+0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071590; c=relaxed/simple;
	bh=cAXQe/W78is3aDWlrpJ6XIY8KxBZ3A/SYiLz2R+p2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d24har0svy2aBvPFj5Sum6Ym1uBdFSD8fsi7oLgp3eNqKRj9WfC4/FV5DHzH+ySvPpciQ3uT8w20ukpSRBCVT8xrpI5UaxYb7Dp4MBMV9H/ENeJfrolIRZLUlCmhRkhoKsikpkvkd9TQ78pMxi4GUzNy5EOZ/PDoIAOGShKtpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKnm+WBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265EBC4CEDD;
	Thu, 27 Mar 2025 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743071590;
	bh=cAXQe/W78is3aDWlrpJ6XIY8KxBZ3A/SYiLz2R+p2sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKnm+WBh0hQs5AumJMr56KcVAOgf/JR+w6DZR46snezg2XBkWaaJo82AoHGRrNLom
	 MsaPcpamNmJZqrjNmPbuiL7qyz0tipbDYcVx7hqMy0B6IJOf8Fqpv7p3N6xwUan5DB
	 X272CzplyaycgXUHUoZIRN5qlx4BAXsa9pq0AicU13vsLi1HMj6HVFCRSmdKz7zZx1
	 /JETc+TA8fq6jQyg6hGvWF66ds1o9Auy8nlqYNtb5uRqZNc7OLuksPTvBox1273mk4
	 cCY1p791KuJJLoxPq06e6h5X1kC7TPwDwprTiFMiCQmk8yuP8SaR2hVuegjhtMIqhX
	 66rKrzNwBGYng==
Date: Thu, 27 Mar 2025 10:33:06 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	tduszynski@marvell.com
Subject: Re: [net PATCH] octeontx2-af: Fix mbox INTR handler when num VFs > 64
Message-ID: <20250327103306.GG892515@horms.kernel.org>
References: <20250327091441.1284-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327091441.1284-1-gakula@marvell.com>

On Thu, Mar 27, 2025 at 02:44:41PM +0530, Geetha sowjanya wrote:
> When number of RVU VFs > 64, the vfs value passed to "rvu_queue_work" 
> function is incorrect. Due to which mbox workqueue entries for
> VFs 0 to 63 never gets added to workqueue.
> 
> Fixes: 9bdc47a6e328 ("octeontx2-af: Mbox communication support btw AF and it's VFs")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I don't think you need to repost because of this,
but I do think this could have been a short series
including this patch and [1].

[1] [net PATCH] octeontx2-af: Free NIX_AF_INT_VEC_GEN irq
    https://lore.kernel.org/all/20250327094054.2312-1-gakula@marvell.com/


