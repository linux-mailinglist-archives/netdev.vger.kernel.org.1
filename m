Return-Path: <netdev+bounces-191981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE976ABE167
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D098D7B25B8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940327AC48;
	Tue, 20 May 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHO0EPdY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F735893
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760254; cv=none; b=ldY33I1kG/78C6RzpwKJKwVpCnyFqmOoIkdjur1DARQNqaEckMDMgrtZ3pEAbQH4ZgnvN0nt22ZyPgjefunuaFViUOcggvwcOX526PbHaR9QWLGV9X+pMI/WcYpiKdOp4ZWxjTizcIxQfU+37KoipNGncgu5kMc/B2uKf6I3BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760254; c=relaxed/simple;
	bh=CFS4HCFwE9kwIY3MWo66mqldIOLKYEdZu7334M+gfwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFoeI+bHBRsT+vBKJv1SUhHgsfo3eLJ7OY4JJNq7qMegHmnVmulb8Ar+2TD/Q25K+bX57Q+vjfur9Rxwk+wc9RqbdhFGQX3LJl57kkbBVsniAAjPmrflDx3pKfzc9/Yhv/I7oE3lqqvOVKvKqXqSjF9AWBcXA/eEBIXcIl+3YvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHO0EPdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6DC4CEE9;
	Tue, 20 May 2025 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760254;
	bh=CFS4HCFwE9kwIY3MWo66mqldIOLKYEdZu7334M+gfwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHO0EPdYvTNbUCW2MyiQBji8MOfUF5XSwRpF14Pz6cqWa8dyiGshv3SHCB+mTUvW/
	 PO899fJk3ZUKpXpur65UqvRV2Ghl5xYKsiZGemgXl9vT76nI8K8Yj9uO9WNHHqsf4o
	 QIcEuqkYoS7TwASpvIPGqC5+FwdxgnIKecVWUBqT8vWo3znykzAuM5/Wdtyzl1FGge
	 xEJ/DazGJc3P7jlp0NZhRfdCkfMLqZBSgxsQarn1clr3Mtuss2x5JExRfmki6r9i1Y
	 zXbYbVjpBX1np9p11i6D6sCoBHYA+rB22U7mgmI+CMwW6IPHyDAV2IY+oqraThwJAH
	 JSltLoLGM5EJA==
Date: Tue, 20 May 2025 17:57:30 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 6/9] net: txgbe: Correct the currect link
 settings
Message-ID: <20250520165730.GL365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <48E2D9072A4EF7A0+20250516093220.6044-7-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48E2D9072A4EF7A0+20250516093220.6044-7-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:17PM +0800, Jiawen Wu wrote:
> For AML 25G devices, some of the information returned from
> phylink_ethtool_ksettings_get() is not correct, since there is a
> fixed-link mode. So add additional corrections.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


