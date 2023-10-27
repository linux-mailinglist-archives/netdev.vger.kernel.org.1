Return-Path: <netdev+bounces-44774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5E7D9AD3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF2F2822D8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF39358BF;
	Fri, 27 Oct 2023 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjeHbdG6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134A358AD
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B7C433C7;
	Fri, 27 Oct 2023 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698415698;
	bh=d6uJ6JTrji6MD4HoMdYyOtXMx21qqh57PKM0hUhObYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VjeHbdG6jLIls/TCE/dRd4bxpUGFSghjMIaTiNCzzRZ91Pkbxma7lQRNnlRRt1i7v
	 ghVH6kGKN6D1CYM9FdkXajLtsasefZVE3Wo2nRwEUZLy30zaR77TMdAv2ZVM1V3eRw
	 Ioups8KP7eOmiXZuTDwo1bJjvB0MjpP4Qa7Ag8BUuly5imomiD6Ml5PTYDJziK+QHx
	 zDr33GHZ1i0dc5qaJQdc7K6ECydIxxygZbIqsOzO1VIE7SpImXS53ZnWaQMJyHz8p/
	 iQxWVe86M171lhxMvG93bfMvyiSnHPcleeqxQM2uUc4GNjy26tp8u/FHzXY3q8DmQa
	 nKDjh5MW7CODg==
Date: Fri, 27 Oct 2023 07:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231027070815.43036c75@kernel.org>
In-Reply-To: <ZTt2o294RMW+MwKs@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
	<20231025175636.2a7858a6@kernel.org>
	<ZTn7v05E2iirB0g2@nanopsycho>
	<20231026074120.6c1b9fb5@kernel.org>
	<ZTqS6hePUFrxuBLM@nanopsycho>
	<20231026123058.140072c7@kernel.org>
	<ZTt2o294RMW+MwKs@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 10:36:51 +0200 Jiri Pirko wrote:
> >Maybe a good compromise is to stick it into the key, instead of the
> >value. Replacing the stringified type id. Then you can keep the
> >value as binary.  
> 
> Okay, that sounds good. But "key": \bvalue is not something to be
> printed out by __repr__() as it outs string. Therefore I don't
> understand how this compiles with your key requirement above.
> I have to be missing something, pardon my ignorance.

FWIW the assignment would then become (pseudo-code):

	if real attr:
		rsp[name] = [decoded]
	else:
		rsp[UnknownNlAttrKey(nla)] = self._decode_unknown(nla)

