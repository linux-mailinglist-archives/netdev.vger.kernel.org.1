Return-Path: <netdev+bounces-119352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B49554C7
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8DD1F22C1E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124774A33;
	Sat, 17 Aug 2024 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv/GI7v/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DF79CC;
	Sat, 17 Aug 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860232; cv=none; b=t4aKxkyhrbNQL46DKI3x12P1q35N3W0UE41goAyIj98RZqEU+QPdivHHuRT1rpc3x3MPEnwR3xC+wk7vS3kEVB1+mPvGY3RPxb0c4b5i4P7+MPmcnyQ9WoK740KCdOkiyrCMSxhH3ck0sadB4UWyODy3I7kPtfxqpxHxYBhcw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860232; c=relaxed/simple;
	bh=0HIJq7nONxQu3qfvisVqF4Xt0qq3qZ5wfmxGHAfEtBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A164uRx3L5VGdcJB+a4gh9ynGkh85JUVnQuZPtaaz9bY4eCf/FUEDNU58kjkHfyZPJQgpeDNxPD2LiF8RwlVzVSr9kG0gjY5iyEXRgZVT7B2plRi+SReeblHf65n+J5pgHwHgQ6Y4BaBHLFlt0Y0dgJH8ikUK2rtcTpHLppmm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv/GI7v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD20FC32782;
	Sat, 17 Aug 2024 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723860231;
	bh=0HIJq7nONxQu3qfvisVqF4Xt0qq3qZ5wfmxGHAfEtBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uv/GI7v/Dna7owfKRFbUJ7HPXshW6G7Mt5+Hoj2b5jD6QkZc+ONHIKiXaN0fOkk9g
	 NZj6xrRAOQrClrleJOGZILv8c3eV1vSWtQTkTGtz4NGpfZbzI+ew/9eGuKg5GGEsRN
	 zzuiN8A/juykZljlrSlSMFG2AOmA84z/c38COfwZO7uDYuJTRSfMaANYJr7cySrrAD
	 t+c7DNmApYUrmAC8xwRSt7SQ8LQHP4QvNOBAy+u4ZrRFifnp1u/lFOInYxQw2ihrOF
	 7jwjHiOu1KP2rJdNQKEZQv/jBiekIJLevgGmVsifhE0293FZtO7WAX/fbRtZQ22FB4
	 7C9Ep8Knx3vsQ==
Date: Fri, 16 Aug 2024 19:03:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <ndabilpuram@marvell.com>, <bharatb.linux@gmail.com>
Subject: Re: [net PATCH] octeontx2-af: Fix CPT AF register offset
 calculation
Message-ID: <20240816190349.22632130@kernel.org>
In-Reply-To: <20240816103822.2091922-1-bbhushan2@marvell.com>
References: <20240816103822.2091922-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 16:08:22 +0530 Bharat Bhushan wrote:
> Subject: [net PATCH] octeontx2-af: Fix CPT AF register offset calculation

There should be a v2 or repost marking in the subject tag,
and a link to previous version under the ---

So that everyone can easily check that you ignored my question
and haven't even applied the spelling fixes I suggested.
-- 
pw-bot: cr

