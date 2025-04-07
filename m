Return-Path: <netdev+bounces-179734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A696FA7E5E0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8675C7A15D7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E7520D4E8;
	Mon,  7 Apr 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKlDq8cY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2120CCF8;
	Mon,  7 Apr 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042350; cv=none; b=M9ZbWhae/OJ3WuxbLTrKDBfNXCczmTEYHQfcnBqgrXg5z4b0ls/VyuxoL5iMSuFGDQrYZM1z+BIscg0j9kmXTXYiNMzRtyIsQY7ikvHaO/Mg12HQlrfNLxEZahQpM/x2+OP8N8Joy4ATM4OadPssJPH+AwPGYGyQ5drUtmFB5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042350; c=relaxed/simple;
	bh=ZhcEgSkIjIj3Vo45+CiP4hMyAehrqvrICfatFI2WOa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx96ptlw5QsElCha/P+UKBuauktHfEpc/llXAKS/yJq5tXes2nc8MOC52UiooguN7w2ObkVW6cyy9n+WHJH73kyn2lI+mN3rXeHVqyy+T1X1km34QGvQgrNFNYNQMa/7KbXGUy2K7hyY/XJ760DxPiP29XCVMcmG3gmCdXh/I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKlDq8cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E1C4CEE7;
	Mon,  7 Apr 2025 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042349;
	bh=ZhcEgSkIjIj3Vo45+CiP4hMyAehrqvrICfatFI2WOa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKlDq8cYEKSYp409LSqkqy9s+TvD1c29fcW83SpsYSCkMnDTYgM4XwrQDm3Xew+Is
	 nGOc48qE5UJQ0D4E8JRVMkqBImptAuFHccRNGD6N5OddlFepZFCTu2OEdfNsETo7Om
	 nCmz61wuA9GdDkvofS1gMwr05XXmEy5KCSeJmjbFj6E0BhbQyNL7j0HCOUaKQitv7/
	 raSX2ma9h+kNoKcK+06R+sa58Os3E529klf7qaOfwPasIyg6dcjwYZQaC9sUeMqv9M
	 Vdm3zvR3PYxLR6p+HQ30dJV20x2PdZ86xYMwfpckJlNOESw72O5NmL8Tumix4kA8qz
	 G7SZmL5IBC9HA==
Date: Mon, 7 Apr 2025 17:12:25 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	openafs-devel@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] afs: Use rxgk RESPONSE to pass token for
 callback channel
Message-ID: <20250407161225.GQ395307@horms.kernel.org>
References: <20250407091451.1174056-1-dhowells@redhat.com>
 <20250407091451.1174056-11-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407091451.1174056-11-dhowells@redhat.com>

On Mon, Apr 07, 2025 at 10:14:41AM +0100, David Howells wrote:
> Implement in kafs the hook for adding appdata into a RESPONSE packet
> generated in response to an RxGK CHALLENGE packet, and include the key for
> securing the callback channel so that notifications from the fileserver get
> encrypted.
> 
> This will be necessary when more complex notifications are used that convey
> changed data around.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

...

> diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c

...

> +/*
> + * Create an YFS RxGK GSS token to use as a ticket to the specified fileserver.
> + */
> +static int afs_create_yfs_cm_token(struct sk_buff *challenge,
> +				   struct afs_server *server)
> +{

...

> +	if ((unsigned long)xdr - (unsigned long)appdata != adatasize)
> +		pr_err("Appdata size incorrect %zx != %zx\n",
> +		       (unsigned long)xdr - (unsigned long)appdata, adatasize);

Hi David,

x86_32 allmodconfig W=1 builds complain that:

warning: format ‘%zx’ expects argument of type ‘size_t’, but argument 2 has type ‘long unsigned int’ [-Wformat=]

...

