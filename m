Return-Path: <netdev+bounces-95422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560BA8C235B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74CDB23C1D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A916F829;
	Fri, 10 May 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlI0vmeq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD3165FB6;
	Fri, 10 May 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340424; cv=none; b=BzeWI3rY2/L5f9z5LWchqjKVbG/Pgx6gnBzPiHBrm/+kIA6pdPdq6Pa0K0U1G/Hm763Qfz/Xrmmv2UJ20ccDAGUTyAHrb/On9KRUEa+zJC1XhOynrf4EMR5kE6HQIvXXjpJZTtoPj9m+nVjtVjmGAMujnG+b9EImPEi2XGBdYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340424; c=relaxed/simple;
	bh=pO6nmr5+7VupXvsb41CCKHVwTMMT0X+8Hrcrhi85fBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDveK/pfQJeJdIuKJGlXHHtxjHd1OCzdIhb6oCKl40oTiJyYQ2h/gaq9JgkKJVECtt6y86joQ87lUFlGHP4sITMpMpIIrkS/Z8tXcs66yEDaObYK88pthcJ+lDnhS4ARDu3IKaZ34LEVAGPDywfoHBGPhS9UrMB4CNNeoC/KJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlI0vmeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8AFC2BD11;
	Fri, 10 May 2024 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340423;
	bh=pO6nmr5+7VupXvsb41CCKHVwTMMT0X+8Hrcrhi85fBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlI0vmeqlVks88yTEl0eT9yQOL7AoGDf+gO8osKL4DfB2dFLS5GDT333OKFLakDEd
	 oQvxUClfw1FLrZ7R9uSJC+J9X9dUmXM26aEPXMuQXhuH+UM9Z22CIOidYvqfxUkrMU
	 B0hBuJF6dfeLef+ZSBS2ojd3dKWTv2XLJ854h4lxzwgtjHFX76deEpw0LmqoVDwgyd
	 o451qG1a1cQK5IBkqBrJXF8XO/ycWX2PbLm3Faiwvwm1QdUsBD8SKY8uyLC2l7YiN2
	 t9KZ4doxgxS6e8vSxo1C7QRIypMkrwByZPhVAiNdvJrHNdwe4L0/evpURpU71KBvMi
	 QZsjLNPMePSDQ==
Date: Fri, 10 May 2024 12:26:59 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 02/14] net: qede: use extack in
 qede_set_v6_tuple_to_profile()
Message-ID: <20240510112659.GE2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-3-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:50PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_set_v6_tuple_to_profile() to take extack,
> and drop the edev argument.
> 
> Convert DP_INFO call to use NL_SET_ERR_MSG_MOD instead.
> 
> In calls to qede_set_v6_tuple_to_profile(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


