Return-Path: <netdev+bounces-24634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47704770E52
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128661C20FB7
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18290538C;
	Sat,  5 Aug 2023 07:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A01FA5
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCDC433C8;
	Sat,  5 Aug 2023 07:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691219999;
	bh=EK135LUrs122TOsPiJSdoPk9jgWsSoneS6co0zHbUD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgLNltA3rx21h8gq07q6HCNrXoBt5gJoEY+pd1h1XBPijAhIBkS7NSgn7ih0Mi7Ec
	 diNrHrrTecuPw1Alc7x4PbNnLkLkW310jaoZl56UbpeefxeTUjZU3kpIuNrk0+JcGh
	 ppHsWz9RHkX3RpTbrIYK4h/mZOVWjIZzIN/2Us/AqpOoyJeQZdsGnFhonFrWd2wXuy
	 OkWxF0Qo7OyZizE5frXUoJ7CVHgdhFohHG2GW540YajM08L768xC15LKWpXV3mHWDJ
	 1FGR637VlEghrnHJ0+RmbFbiNqNH5HB0rBTqkkh8LquafpTZdU35WBI2zsHsxKOx+A
	 VL1C7QurfTXyg==
Date: Sat, 5 Aug 2023 09:19:56 +0200
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	danymadden@us.ibm.com, tlfalcon@linux.ibm.com,
	bjking1@linux.ibm.com
Subject: Re: [PATCH net 3/5] ibmvnic: Handle DMA unmapping of login buffs in
 release functions
Message-ID: <ZM34HOmVA0ggBJdN@vergenet.net>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
 <20230803202010.37149-3-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803202010.37149-3-nnac123@linux.ibm.com>

On Thu, Aug 03, 2023 at 03:20:08PM -0500, Nick Child wrote:
> Rather than leaving the DMA unmapping of the login buffers to the
> login response handler, move this work into the login release functions.
> Previously, these functions were only used for freeing the allocated
> buffers. This could lead to issues if there are more than one
> outstanding login buffer requests, which is possible if a login request
> times out.
> 
> If a login request times out, then there is another call to send login.
> The send login function makes a call to the login buffer release
> function. In the past, this freed the buffers but did not DMA unmap.
> Therefore, the VIOS could still write to the old login (now freed)
> buffer. It is for this reason that it is a good idea to leave the DMA
> unmap call to the login buffers release function.
> 
> Since the login buffer release functions now handle DMA unmapping,
> remove the duplicate DMA unmapping in handle_login_rsp().
> 
> Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


