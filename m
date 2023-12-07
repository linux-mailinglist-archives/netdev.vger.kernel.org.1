Return-Path: <netdev+bounces-54958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5480902E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A23A281880
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB74E629;
	Thu,  7 Dec 2023 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1zH+3ET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A84E62D
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC92C433C8;
	Thu,  7 Dec 2023 18:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701974492;
	bh=wxRor5yFlTVi6KtSyaWDNXmygemyFUaI8FUJpnl4HCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J1zH+3ET2KcdFjpkpLqDjdWpTU6g2lpr0QaIwCg0iP+PVH+Hi70pkgLZMmxnurm45
	 6uGBrkCALIP+PPsSaTxOpPYwNS7hz0QcMA89Fmi3pZGLYG7GvWCPK3TxdyotCXlFDt
	 X5S+DsuhPOilnJhj1pPMPrE3XQQCVejX+iyOBcCOFxh7UApRLWIDWwOLGx/Ss16WIF
	 JuJNLsixnQOH7gOA4axTi9XOoIIzH4iYEbTqQIgC0Iq8+wGZHYbxuhiJZQgZ8FwzX+
	 vh34EVeOwq4GR/4j7HmB0ztTSg287wRBhsDFTZBpkkxV5AsnZ+QqGNFxJ4RrmvsjVa
	 SVEWS9pz8GlDw==
Date: Thu, 7 Dec 2023 10:41:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Sreekanth
 Reddy <sreekanth.reddy@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>
Subject: Re: [PATCH net v2 2/4] bnxt_en: Fix skb recycling logic in
 bnxt_deliver_skb()
Message-ID: <20231207104130.3123dba4@kernel.org>
In-Reply-To: <ZXIQ9FCfUV1Fvr_A@C02YVCJELVCG.dhcp.broadcom.net>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-3-michael.chan@broadcom.com>
	<20231207102144.6634a108@kernel.org>
	<ZXIQ9FCfUV1Fvr_A@C02YVCJELVCG.dhcp.broadcom.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 13:37:40 -0500 Andy Gospodarek wrote:
> That's a good suggestion.  To take it a step further...what about a
> third arg (bool) to build_skb that would automatically call
> skb_mark_for_recycle if the new 3rd arg was true?  I don't love the
> extra arg, but that would avoid duplicating the need to call
> skb_mark_for_recycle for all drivers that use the page pool for all
> data.

2x yes, would be great to have a function which just sets as recycling
by default; also don't love the extra arg / I could not come up with 
a nice API quickly :(

