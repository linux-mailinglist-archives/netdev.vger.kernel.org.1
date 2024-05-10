Return-Path: <netdev+bounces-95425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4458C236D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AF91F256F0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B017799B;
	Fri, 10 May 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok1Si8i+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122E177981;
	Fri, 10 May 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340461; cv=none; b=QlJ3aMDZqRWVyY/gIEvIy6mgpL+G/tmug7MNwUCkWDD5LNkVS557Hl3kcBIZsuRfgrUD3UeEbsboH/wMeIkrLTSvIrCkac6RcGVzh906Y0gT+QAqWgzyGwIKVCmaKrLn7PiDwIgKzpryJfUCPB6mTMvVQ+oR6YvLPw6N3+u7Prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340461; c=relaxed/simple;
	bh=lHYyDyyde3hzvB6pFGFpqjjKEshxwGmtSfVnmsibBSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPlGvwm3dKYGCmfm4DjITceq7opU0WTE0R3uYLtltlbXhGFh/VMiCsGrHnd9ettPZwrCFTVdh57SruqudGtgEXkYj0P9w7tNLqW5ugW19t2D7zdqOLF9O5I5eaKlxs4/v3l86d5KMLU9GUEOl7ZD64+hDst8QKeZOkJ7GeKnwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok1Si8i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A6EC32783;
	Fri, 10 May 2024 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340460;
	bh=lHYyDyyde3hzvB6pFGFpqjjKEshxwGmtSfVnmsibBSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok1Si8i+1nGJ9d2xgtc4yzqZImVlEEWziui0cMR1/7jTRnyn1rR0wI39+RKLwYPH/
	 PrviSN4rEUdtOK/W3THCLbOuslKelp6IvJIYLXEqdDOl+VdULF2VDOsFv9cJ49ga1r
	 8SilqqUnQrIDDCtXBUAcDSfTv/4c7+LeCiBlRMkie9JifueFJPQ7sowtQJvwGOsD8E
	 ibYU7x1LLEuNTzZTOZMxh781Uix5BRyGuYwf99lKgKsLJUOkWJSosY+x6JeXWymxfm
	 wX3/LWmLskWjtLHQYx+RRPINK9U2RBH4rVH2A/XpxH1LrbXs7GvOIs522z1v67wZS2
	 sbVqxQA1LOTZQ==
Date: Fri, 10 May 2024 12:27:35 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 04/14] net: qede: use extack in
 qede_flow_parse_v6_common()
Message-ID: <20240510112735.GG2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-5-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:52PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_v6_common() to take extack,
> and drop the edev argument.
> 
> Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.
> 
> Pass extack in calls to qede_flow_parse_ports() and
> qede_set_v6_tuple_to_profile().
> 
> In calls to qede_flow_parse_v6_common(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


