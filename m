Return-Path: <netdev+bounces-21347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E497635B2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B051C2121C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BDBE56;
	Wed, 26 Jul 2023 11:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E482CA4C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F7AC433CB;
	Wed, 26 Jul 2023 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690372504;
	bh=5bSCzRai7BDolec9wDv9JgFOcpS52Iak09xrBEf8yiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8xqPWPAfRjQd2Uh5S6GLG9JqxvkX7NFJrLHo9O/8oAHt/fPKpr9IL+5oPQejvhJq
	 VEw2VOV0KAn6PFjBSnJxOjQFV6z35kcGq9XjU1pJcXW1a3F4W1dl9aMFDZC+gxpQOA
	 vxnCcB2KHM/6Pl8aMpAB8ObiAWJSlOc9MTwKlU04d5sN3RVhoxHVPzMw9piYVLVnUa
	 Byzbsv+tZSVneo/8xrtLvfEIvitiZxNu+6OdYE4ISCpbr/jsFlcjktg5ilCxlpjfXT
	 8gVFe01Yz5hNO0upNZqIQx9peBzbSR2HEn2Y6QC05E9zLLgEJubLa/MR06Bv6YSAcB
	 0ZGB3H4rZXqeg==
Date: Wed, 26 Jul 2023 14:55:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <20230726115500.GV11388@unreal>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723074110.3705047-1-linma@zju.edu.cn>

On Sun, Jul 23, 2023 at 03:41:10PM +0800, Lin Ma wrote:
> The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
> message to user space") added one additional attribute named
> XFRMA_MTIMER_THRESH and described its type at compat_policy
> (net/xfrm/xfrm_compat.c).
> 
> However, the author forgot to also describe the nla_policy at
> xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
> bytes) value can be faked as empty (0 bytes) by a malicious user, which
> leads to 4 bytes overflow read and heap information leak when parsing
> nlattrs.
> 
> To exploit this, one malicious user can spray the SLUB objects and then
> leverage this 4 bytes OOB read to leak the heap data into
> x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
> userspace via copy_to_user_state_extra(...).
> 
> The above bug is assigned CVE-2023-3773. 

This CVE is a joke, you need to be root to execute this attack.

Anyway change is ok.
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

