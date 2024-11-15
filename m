Return-Path: <netdev+bounces-145287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972C9CE0E9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF7928318B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CB1BA86C;
	Fri, 15 Nov 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbnjSR08"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367AD1B2EEB
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679578; cv=none; b=Sfy+G2+5RKQ+wCVeZEjwPtacd8LY7uPizAGSwHAewKVkWE9uN/rY0HQjWsSKljO6iGPCXoHFNneTILNiEyQl7x4SO5MDgVhtZ4SrkWWKCJ6S64ltD/AXswqC/8+EQdiaVnkwiDe/MaNfhSpvnMK73EBvvK0qGHDaoYh/9sPKh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679578; c=relaxed/simple;
	bh=T1dzm+9Gu2aF5U2hX/Q2kNg7z7FQEs1z9YlI7jNRM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL7fRKafKcqx6B3zdtD+CdZA89qI+Jviaryi0+5CBJ0E+DBxR2zROySvodDr+3JUbvZp9hTgLeIDilJKJQPhybwsaSYRM8DvIiYSnEFDTpNgr8xSm1AHBv5U/GoXjbtWncexxKEdN1C2JDRGaebTV1sUvOScTbVtHMXOKAX5uBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbnjSR08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC35C4CED2;
	Fri, 15 Nov 2024 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679578;
	bh=T1dzm+9Gu2aF5U2hX/Q2kNg7z7FQEs1z9YlI7jNRM+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbnjSR08Yj+TZu9iNwsh9V2bUsVHPZL4/Z+PiGgxu0T4AMYOUNYcee+T3BEjPz8c9
	 YS6wq7yFcOe/A+OSfr1VyVF1NwbAQ289RsyVr/jusZhUExrntKB0Wx+L09XiJvwgTL
	 wahB0COmRY0m1oU3ELWbnAJOOmUr2kio7ZJcnOoX5cVlIN8SwrKrVggV/qgwYxfPcc
	 gLHpdHoPi/TXyaPkRUMeO5H45qwGNyr+ShjiRNyN3oEIMjn+aVMjeyJokZIi21xLFO
	 hRHLy+oFYLEZGMGfQbvt8bCwbz3QPlbXCztGCxJimvvKEI5TBvX7mS6crc3JVcytmV
	 fnC1Qjg1Fr8mQ==
Date: Fri, 15 Nov 2024 14:06:14 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, joel.granados@kernel.org
Subject: Re: [PATCH net-next] net/neighbor: clear error in case strict check
 is not set
Message-ID: <20241115140614.GS1062410@kernel.org>
References: <20241115003221.733593-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115003221.733593-1-kuba@kernel.org>

On Thu, Nov 14, 2024 at 04:32:21PM -0800, Jakub Kicinski wrote:
> Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
> data checking") added strict checking. The err variable is not cleared,
> so if we find no table to dump we will return the validation error even
> if user did not want strict checking.
> 
> I think the only way to hit this is to send an buggy request, and ask
> for a table which doesn't exist, so there's no point treating this
> as a real fix. I only noticed it because a syzbot repro depended on it
> to trigger another bug.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: joel.granados@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>

