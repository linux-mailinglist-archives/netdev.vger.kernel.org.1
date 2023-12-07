Return-Path: <netdev+bounces-54948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA07B808FC2
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661B82815A5
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A14D596;
	Thu,  7 Dec 2023 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7aKpjOv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD81400F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312DFC433C8;
	Thu,  7 Dec 2023 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701973335;
	bh=cxp+MgknMCpa+DtgGp2WSh3TeALdfpCsqbGB3zKzAlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7aKpjOv3GgkoeJ0xz3pABgmJ+THEaEOsExy3OJ2qPgllBSM5JF2+tAVBqGruAzjq
	 b1f6zfJTc4rdnKR+CwCV5jZx5zeMcaPfcGULmeunl+HoSgNBZtTBluvcAlQVSVZkcb
	 94lPF7k6uhr4gF7LZ18oei5ejt8/sHgLDuczyRH5FSbwZwJPXUxehCAepOBGgQSbRy
	 BUWpLU4OUNTuMfvIY1/Ffe83ELe4RCCFjBTMbdjENZ1YWx3zjJ8xYCehagW1efPiyr
	 wTzXrENFFvJlra7ZGcc14QllbsZ1SGUyI55v5EMuvI+kVm+PIqx804eY27qXyDHBea
	 Zb8ge1x/aPvjw==
Date: Thu, 7 Dec 2023 10:22:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>
Subject: Re: [PATCH net v2 2/4] bnxt_en: Fix skb recycling logic in
 bnxt_deliver_skb()
Message-ID: <20231207102214.4aa23d14@kernel.org>
In-Reply-To: <20231207102144.6634a108@kernel.org>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
	<20231207000551.138584-3-michael.chan@broadcom.com>
	<20231207102144.6634a108@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 10:21:44 -0800 Jakub Kicinski wrote:
> On Wed,  6 Dec 2023 16:05:49 -0800 Michael Chan wrote:
> > Receive SKBs can go through the VF-rep path or the normal path.
> > skb_mark_for_recycle() is only called for the normal path.  Fix it
> > to do it for both paths to fix possible stalled page pool shutdown
> > errors.  
> 
> This patch is probably fine, but since I'm complaining -
> IMHO it may be better to mark the skbs right after they
> are allocated. Catching all "exit points" seems very error
> prone...

To be 100% clear - I mean that as a suggestion for a potential 
net-next cleanup.

