Return-Path: <netdev+bounces-104971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902090F54E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2840F283892
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C57153820;
	Wed, 19 Jun 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgRMzQu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C213FD83
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818833; cv=none; b=I9skYPxNlMciC7gICFEODJ4as9B7drdl2fGiIiaJPswFBUazO5uV1L29tGIxIALVbVwfQdJyNIbKkFs1ixwUNdHSNekINvoq+8htAQc4mk/oczvDLn6rZ/miXOaCB8V8pj3rvBOFyvMYvjpnW6nkPJOsphHWoY/QCxDeiOnmL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818833; c=relaxed/simple;
	bh=DU2Cz0qbiwlUSZi6Cou87MSvRyR/yHPd6VHMBsxci4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BONUcPzsfhzbbGjURArNb1XEbYnNgYatInk/Y36Npgt6QprGhW/GLsABWTTmxtHaTOc6yvAgT5h8/69uohUkmu7Obl2qL40ocuKz/rHhQf2D2DrIHOZfc+Nn1V7Zi+R9PrpHpX1AfSqwe/zqTn6et3mIiQxATXZfvFi31jTX/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgRMzQu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6933C2BBFC;
	Wed, 19 Jun 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818831;
	bh=DU2Cz0qbiwlUSZi6Cou87MSvRyR/yHPd6VHMBsxci4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgRMzQu4ARNFnAbb/ieqCyaJvPgtDzHhakXluTPv17IkXDlHUe1rMOWSkA1EuBH/Q
	 f701FGO/a10hHXsF9UyZZAoBJkXgHZNOugozMre5HWvl0wlb5qsiBFR6/mctQ836NN
	 AqxYz5Gsw7xH6SiTNWld7FwRs6uhvaCdUpXRQLmmVQkcS5u5rDley6PaQ4z2fO5b88
	 ryHP/at+EM5yWAKs3k7avpqh9Bjxa5qQd85RKeyat/dO5uIiLXhYbHTxGWhEGRDvZX
	 In6tdZjxNnOIJhxuaP/amIdbqZ84GiKsixUC3FeBs6vsRiXakdk14mAzQQCsrWw7hL
	 fNN6URN24RIgQ==
Date: Wed, 19 Jun 2024 18:40:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, dumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/3] net: txgbe: add FDIR ATR support
Message-ID: <20240619174027.GN690967@kernel.org>
References: <20240618101609.3580-1-jiawenwu@trustnetic.com>
 <20240618101609.3580-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618101609.3580-2-jiawenwu@trustnetic.com>

On Tue, Jun 18, 2024 at 06:16:07PM +0800, Jiawen Wu wrote:
> Add flow director ATR filter. ATR mode is enabled by default to filter
> TCP packets.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


