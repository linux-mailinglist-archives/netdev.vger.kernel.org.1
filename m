Return-Path: <netdev+bounces-25027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B422772B1D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CE2814D3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF871094D;
	Mon,  7 Aug 2023 16:37:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28642C9C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62CFC433C8;
	Mon,  7 Aug 2023 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691426249;
	bh=kbR6aj7kA3a7cg6V1v3m4G4EXk5m/YqvQ/TjuNc6zMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=df8RW7KAq8T9W0DcXonq+k1G0ctjiNzY7qo5gIssck/dkQ/ZCOq8HrL6MP7gyAxDO
	 xII3nFOUVxfJfx6yOMVyuyMLlfSp4NOyZlvLRDDSHNj7SrIO2K6dI6aS/nTtraBcw9
	 hu6y2RGd7htd5QcOYE5YWd129UFltG2/ulafQRcuzaZLfhD1+Y7BffGZsvikZf0fNa
	 XpqG80NDxc5JPameLByWC4RPYINdSAW+KcAS5OURx0wiU2Ej9W2Xu+x5E1xeCHVM3U
	 gxNAMR9P+TkIZZYI+b/VvCr9ciWidcDRCsn0irqKo4Rn0phLfCo4fL23BWYuC/0afI
	 WwVnuk53rqdmg==
Date: Mon, 7 Aug 2023 09:37:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hayes Wang <hayeswang@realtek.com>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>, "edumazet@google.com"
 <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Paul
 Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Message-ID: <20230807093727.5249f517@kernel.org>
In-Reply-To: <8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
	<20230731111330.5211e637@kernel.org>
	<673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
	<8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 09:57:15 +0000 Hayes Wang wrote:
> > Perhaps Hayes Wang can comment on this (as the author of 195aae321c82).  
> 
> I test our devices on an Embedded system.
> We find the throughput is low.
> And it is caused by the weight.
> Our NAPI function often uses the whole budget.
> Finally, we increase the weight, and the throughput is good.

Could it possibly be related to handling of aggregation?
Problem must lay somewhere in USB specifics, since as I said
there are 100Gbps devices running fine with budget of 64.

