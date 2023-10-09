Return-Path: <netdev+bounces-39179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D793A7BE45B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148B81C20A8E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6F37140;
	Mon,  9 Oct 2023 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty5U6thA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CA358A5
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA3C433CB;
	Mon,  9 Oct 2023 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864533;
	bh=5PNtQbKt6/hQ97dLb1t7CABxmSlcmevKWuOQ0pim7so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ty5U6thADFvBaD6tadp82vD5wii8QnsaQll0H3y7Hwbuka9jhfpZl/pu6CJSG21jK
	 Abjhej7Xom/EzvY3QZ9niAevNihmzNRQlsTQP5+GVLNcwC+HbYr0oqGtapjKA+w3E+
	 MiaMTMxq7CZdWvlp+BTOaO1XIqRY/A66MkQXO5Wi7gbM1eYE4UVbn9ZrjBtD+W404g
	 3A5N3kHW9oc2XoKP+P7ZRWYERPnqE/CcGQ878/l9nbpusrEd2G95i7I5Zv6KQGTLVx
	 zev72m0BkMWGREk0Gjy2NORVn4o5OsPHUcqxLHALc04OOfW1J1GZi0AhwkhDFHbSp4
	 dpLnyp2A7ciPw==
Date: Mon, 9 Oct 2023 08:15:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231009081532.07e902d4@kernel.org>
In-Reply-To: <ZSEwO+1pLuV6F6K/@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
	<20231005183029.32987349@kernel.org>
	<ZR+1mc/BEDjNQy9A@nanopsycho>
	<20231006074842.4908ead4@kernel.org>
	<ZSA+1qA6gNVOKP67@nanopsycho>
	<20231006151446.491b5965@kernel.org>
	<ZSEwO+1pLuV6F6K/@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Oct 2023 12:17:31 +0200 Jiri Pirko wrote:
>> Isn't the PF driver processing the "FW events"? A is PF here, and B 
>> is SF, are you saying that the PF devlink instance can be completely
>> removed (not just unregistered, freed) before the SF instance is
>> unregistered?  
> 
> Kernel-wise, yes. The FW probably holds necessary resource until SF goes
> away.

I think kernel assuming that this should not happen and requiring 
the PF driver to work around potentially stupid FW designs should
be entirely without our rights.

