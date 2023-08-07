Return-Path: <netdev+bounces-25048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F90772BF5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C528C1C20A67
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB4125B3;
	Mon,  7 Aug 2023 17:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4B10974
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98ACC433C7;
	Mon,  7 Aug 2023 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691427795;
	bh=SdZCkKmNSQPpiLclZqQae7U3U8t2X54ZIv8RBQacP/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjAWxKgj6Sip1LNdit8IE2K7QFOruIpGX/O1hIFqoTDnXKYkC5iKWomI0ee+ohfdE
	 9b+U9C+YhQPPWtUBYPVzMWSwlHxs9MRBRh21U+N+IjV8Awirn4Sh+WE+1gar6iHZJY
	 3c7Y2zUHVTksAJtmK2iXKdNMsNTxpeBPDpv9kopYROo7dy1iIobL/2QKNLPN5PrTvv
	 eFSUYs6kqKaMx3L6XDctMQXxaJFbTbQN+Z1Oq82/Xk7pbQpbZzs3aTaaO6KiD0rbXq
	 ijuQsBOvgoPimwM1JJ/9J6iFgAHracqZJbnrp1UjXzWm4ansWfvjRRkRxWPCfcsrYR
	 tBnwpgOay0nwA==
Date: Mon, 7 Aug 2023 10:03:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple
 cmds
Message-ID: <20230807100313.2f7b043a@kernel.org>
In-Reply-To: <ZM3tOOHifjFQqorV@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
	<20230804125816.11431885@kernel.org>
	<ZM3tOOHifjFQqorV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Aug 2023 08:33:28 +0200 Jiri Pirko wrote:
> >I'm not sure if you'll like it but my first choice would be to skip
> >the selector attribute. Put the attributes directly into the message.
> >There is no functional purpose the wrapping serves, right?  
> 
> Well, the only reason is backward compatibility.
> Currently, there is no attr parsing during dump, which is ensured by
> GENL_DONT_VALIDATE_DUMP flag. That means if user passes any attr, it is
> ignored.
> 
> Now if we allow attrs to select, previously ignored attributes would be
> processed now. User that passed crap with old kernel can gen different
> results with new kernel.
> 
> That is why I decided to add selector attr and put attrs inside, doing
> strict parsing, so if selector attr is not supported by kernel, user
> gets message back.
> 
> So what do you suggest? Do per-dump strict parsing policy of root
> attributes serving to do selection?

Even the selector attr comes with a risk, right? Not only have we
ignored all attributes, previously, we ignored the payload of the
message. So the payload of a devlink dump request could be entirely
uninitialized / random and it would work.

IOW we are operating on a scale of potential breakage here, unless
we do something very heavy handed.

How does the situation look with the known user apps? Is anyone
that we know of putting attributes into dump requests?

