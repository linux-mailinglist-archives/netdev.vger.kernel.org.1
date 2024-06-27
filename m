Return-Path: <netdev+bounces-107482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674491B296
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65AE284412
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76C1A2C27;
	Thu, 27 Jun 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsCXatnJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F01A08CF
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530207; cv=none; b=axuSrPui6IkBThK+BFxrWTeJICV+T/gidyJeqF4CoT+I/nYSga0HtP7wbuEBb5+sLVU5RgGhT2RKdL5UBu1gqhkBXtTjPfdSAPgXu9rTDXOuYwLtFDl11u+37hUCV3l0ZHcUBmF4oZvli7mQ/MiyvWlhrHPFx9lHnH+JN8WIdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530207; c=relaxed/simple;
	bh=8obUfIpLEC41ykPguIqd6xI8BbgEkDcAsPtAgJ2v++w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+JWaVNgIxDezB9hiL4BcaGKTVoy1IYuHpdRCYfqa5k3CELe9RT+OJrEnkr5c4X6aLJCRrt9yyFFb48aOrmlIivFSniQ5H3vyww29I8YGB9Z1QsaNWaAHik5XtedDndxZLncu17ulRK30cpS8WUj4+T/A2/NSVwBA/7HdkWsvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsCXatnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C77C2BBFC;
	Thu, 27 Jun 2024 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719530206;
	bh=8obUfIpLEC41ykPguIqd6xI8BbgEkDcAsPtAgJ2v++w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GsCXatnJrPPfeHfEPILDR3urss+wZfqimDQfnS0ZIziv02XT2ZC34CArODrccBvaJ
	 TgO4OUFj3pLFpU4pggSAbxj9q6gLF+kqMFQ/IiWeTFgiMB/Abn79facpQGkzGHtLN6
	 nWO2CeaNnhmZmbw3eD98EhSECNlfoKqe1RiA1yCDvpHcofKbsjUMtNEwOs9Qtezlal
	 NO6A4OL33QFYZQZZbVstRpYqQVMqhX3DEkG/saIzUhSYdKczV4zTmQ/0A0HJCGwYK8
	 6PQPgyrQiWFDZkAsGRZkDq84pflgBRlAkw+aRJm+OtMg/K37aasNOVQqfHCVY9zoNj
	 fdGgm81YI0UPg==
Date: Thu, 27 Jun 2024 16:16:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 Milena Olech <milena.olech@intel.com>, <richardcochran@gmail.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
 Simon Horman <horms@kernel.org>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 1/4] ice: Fix improper extts handling
Message-ID: <20240627161645.6c92d1ed@kernel.org>
In-Reply-To: <ZnwZQMe1outhbqPG@boxer>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
	<20240625170248.199162-2-anthony.l.nguyen@intel.com>
	<ZnwZQMe1outhbqPG@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 15:36:00 +0200 Maciej Fijalkowski wrote:
> > +
> > +	for (i = 0; i < pf->ptp.info.n_ext_ts; i++) {
> > +		if (pf->ptp.extts_channels[i].ena) {
> > +			ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i],
> > +					  false);
> > +		}
> > +	}  
> 
> nit: you don't need braces for single line statements.
> 
> maybe you could rewrite it as below but i'm not sure if it's more
> readable. up to you.
> 
> 	int i, cnt = pf->ptp.info.n_ext_ts;
> 
> 	for (i = 0; i < cnt && pf->ptp.extts_channels[i].ena; i++)
> 		ice_ptp_cfg_extts(pf, i, &pf->ptp.extts_channels[i], false);

not sure this is functionally equivalent, but agreed on the point about
the braces.

Also, FWIW, the commit message doesn't read super well..

