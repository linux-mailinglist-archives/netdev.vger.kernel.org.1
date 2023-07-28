Return-Path: <netdev+bounces-22326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67C767081
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA75428278B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AED14005;
	Fri, 28 Jul 2023 15:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991E6129
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB97C433C7;
	Fri, 28 Jul 2023 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690558066;
	bh=9LkBbOWfi2nD4GJyI2flr4Qveciot93p1s7jpyvwppg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dg6xhrm4iLhHfCsQeZVanDK4N7GzPhvZfv50NWjD5M1L91FXzKJb9Lg1iiJs5Ia/4
	 NpUeS7h8xLDrV1bjVVwJC4fAyF1CCtkSLUFetHG18sTacDY1ujXAvDkkJBgT6V3oTD
	 Dd+0rzBAtU+pn8pGwHxmNngWX9zgIXoFeVIw0kcCI2gGjRsB295njTiee377XMT+We
	 64KGWj75xwcwBaQ3IyBRdS2EhLdxsYGWd00D9EtN8PYTp7E1C+r2MMrWManF5GEhF8
	 BushOxECWbXIrow0hyEAjkAIFDwBWfec9PLLnY2aF7vYHrjOA5aTuIWGHlDe3ti+PR
	 qNgQCYPrMcLKA==
Date: Fri, 28 Jul 2023 08:27:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230728082745.5869bc97@kernel.org>
In-Reply-To: <20230728045304.GC2652767@unreal>
References: <20230726185530.2247698-1-kuba@kernel.org>
	<20230726185530.2247698-2-kuba@kernel.org>
	<20230727130824.GA2652767@unreal>
	<20230727084519.7ec951dd@kernel.org>
	<20230728045304.GC2652767@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 07:53:04 +0300 Leon Romanovsky wrote:
> > I'm feeding xa_alloc_cyclic() xa_limit_31b, which should take care 
> > of that, no?  
> 
> And what about xa_insert() call? Is it safe?

I think so, as in - the previous code doesn't have any checks either,
so it'd insert the negative ifindex into the hash table. Hopefully
nobody assigns negative values to dev->ifindex, that'd be a bug in
itself, I reckon.

