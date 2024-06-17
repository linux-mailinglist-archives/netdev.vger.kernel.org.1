Return-Path: <netdev+bounces-104278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CC90BD69
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 00:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF891F21CCD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA9919885D;
	Mon, 17 Jun 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NHAiLoOM"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBE15F41B;
	Mon, 17 Jun 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662516; cv=none; b=BIRkph4KYCEs9LTE/Wp5XIylv2Z/aPipZ3XXN2m8MYLvOS5K8gJmTWRFWYYlJPlK+AjIjJ8Pzj70HHEvvv9jXoFcAUdRDk6cdeU70QKbDWB0585d4KbCJZwPxYFEuQG9MsuUT24ghbqVTgegQIUq0sTemcwxorgF88RC1/O7AEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662516; c=relaxed/simple;
	bh=QawBxSmaG1rW+JoAn4YURT5IletD2lkYLL7l9l6JIaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M3f1zlYR4js8ck2TgFmWOEnIDWn72Lq/XRozwH62RGujdz+72kr93dQ7v4CxhYogWp/rc2xyRVq/rcqdBxc6lbalagxQ0JiIjAchA9NN18Bn3sPkDkuamJAkc3elG/iB3BBNKRGZGtxiZos7I8iL8KIZ6WiDzjEvk3+gDPBC25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NHAiLoOM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7FDDC45E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718662513; bh=QHqGjvAN4suq+rrm6phkxSHCLhE+gyp1yobzWI4P77E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NHAiLoOMLUrqHtPiZX+ZoFTIAyE6Vx7JdmuAh2bvoKQIoO+0dGMXtzGKY5t9+SIKX
	 +c8t8yTs0BtHoNKtXtHim3l9EW9sDUXS3sY7l4+iifFasyK0kAOyKdeRBljLU+CdVe
	 /eRHJKZINTLxU3pfw/Yt5a3bzqklQgzROiz9Z0054lXIbK3QgmyVz3SF6o3bXxYST6
	 fZrH0ODe9Mr1YA67O4eFpljr1gqGxTtql53GW28iNO+jA/UpZva6ENZ9UkgDFIVBqq
	 qSPvZLuj7sER0rt6M+By/EX7BXeicFVPUY0nhB6LV9TCuX1Z0gZp7/u8KyGSP+ohP1
	 hNNNrCjGc4QrA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7FDDC45E08;
	Mon, 17 Jun 2024 22:15:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas Huth <thuth@redhat.com>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Remove "ltpc=" from the
 kernel-parameters.txt
In-Reply-To: <20240614084633.560069-1-thuth@redhat.com>
References: <20240614084633.560069-1-thuth@redhat.com>
Date: Mon, 17 Jun 2024 16:15:12 -0600
Message-ID: <877ceni5cf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Huth <thuth@redhat.com> writes:

> The string "ltpc" cannot be found in the source code anymore. This
> kernel parameter likely belonged to the LocalTalk PC card module
> which has been removed in commit 03dcb90dbf62 ("net: appletalk:
> remove Apple/Farallon LocalTalk PC support"), so we should remove
> it from kernel-parameters.txt now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 423427bf6e49..a9b905bbc8ca 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3184,9 +3184,6 @@
>  			unlikely, in the extreme case this might damage your
>  			hardware.
>  
> -	ltpc=		[NET]
> -			Format: <io>,<irq>,<dma>
> -

Applied, thanks.

jon

