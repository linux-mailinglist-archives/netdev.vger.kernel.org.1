Return-Path: <netdev+bounces-24635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0DE770E53
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932D828143C
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD25393;
	Sat,  5 Aug 2023 07:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C51FA5
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F74C433C8;
	Sat,  5 Aug 2023 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691220016;
	bh=qhxeMAXXnCVa8mBW4rbI7ilyk4VK8ZzV2c8uNsDYtOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZUeYq78Tbg4WSzYEPXAxk3HYtXhNYl6C9ZN52bgZBGzkk1pAyvja+a0NkrqeWGf+
	 Ap8zt2cFhiWW6LKlpKdP8Zj01o6hdFrFq8p6BWOrLkqrkQWHVhtlhkQ8xkqPOvdMwO
	 JsYUWEP59/lt+p7YE9tCI8f23mtisrqGV8eTys3ggJxMGK/tGIE05cept+k3OAZ9Bp
	 YDT1JETYVkDaWpdRDwjVlb4iEi36Reqm+joXrYTispw8O9HYoA7hljhQNHkUILsRHj
	 zzH6JbBNflkut03kT3Ep/Uw6Sb7QGImbkT2nZGR8dBnl5tY5kvtlLfhHesUGKqgooy
	 YDa/9DPtaLf+Q==
Date: Sat, 5 Aug 2023 09:20:12 +0200
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	danymadden@us.ibm.com, tlfalcon@linux.ibm.com,
	bjking1@linux.ibm.com
Subject: Re: [PATCH net 4/5] ibmvnic: Do partial reset on login failure
Message-ID: <ZM34LJJMb2VLVllp@vergenet.net>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
 <20230803202010.37149-4-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803202010.37149-4-nnac123@linux.ibm.com>

On Thu, Aug 03, 2023 at 03:20:09PM -0500, Nick Child wrote:
> Perform a partial reset before sending a login request if any of the
> following are true:
>  1. If a previous request times out. This can be dangerous because the
>  	VIOS could still receive the old login request at any point after
>  	the timeout. Therefore, it is best to re-register the CRQ's  and
>  	sub-CRQ's before retrying.
>  2. If the previous request returns an error that is not described in
>  	PAPR. PAPR provides procedures if the login returns with partial
>  	success or aborted return codes (section L.5.1) but other values
> 	do not have a defined procedure. Previously, these conditions
> 	just returned error from the login function rather than trying
> 	to resolve the issue.
>  	This can cause further issues since most callers of the login
>  	function are not prepared to handle an error when logging in. This
>  	improper cleanup can lead to the device being permanently DOWN'd.
>  	For example, if the VIOS believes that the device is already logged
>  	in then it will return INVALID_STATE (-7). If we never re-register
>  	CRQ's then it will always think that the device is already logged
>  	in. This leaves the device inoperable.
> 
> The partial reset involves freeing the sub-CRQs, freeing the CRQ then
> registering and initializing a new CRQ and sub-CRQs. This essentially
> restarts all communication with VIOS to allow for a fresh login attempt
> that will be unhindered by any previous failed attempts.
> 
> Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


