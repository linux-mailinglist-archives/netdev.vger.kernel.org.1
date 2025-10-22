Return-Path: <netdev+bounces-231491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D4BF99CF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547F33AB093
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDADE1D88A4;
	Wed, 22 Oct 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmPNbj60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966881A08A3;
	Wed, 22 Oct 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096774; cv=none; b=RLlPRbvIFtgIkKXwX53iNKMjuv3XtGPQTjmSA+qdMgUrwiYJ4DxObuTJvni8dj5uKuDu9Zxj46tjedaHdVOKHLIW4tQGP74f3dmjyFN7dg0K2OKxKV/0/vCIVigR/IqUNBjY4nVaJVC9sWRB3M0QZC91Cg3IvRf8C5EOMBXVrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096774; c=relaxed/simple;
	bh=6coOt8FIoqzl/Uho4X9/XmZXp+oC+jOkvyjgoiD4n6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFT6eCx4GFU0TNaQHvvcWirmOV4159qbJBHgVCSn7heAANkkz9hewMoTFlJleTkXjSn38JGN6y6oZpbl3Zk1N1nZgF+p55kEt23MYNFGBl2SYb2p3BoMk+3XkGZEf94PmkqazwafxMDVqYITaEsyfxtLdCz0AYdtbYNriXuZsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmPNbj60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DF3C4CEF1;
	Wed, 22 Oct 2025 01:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096774;
	bh=6coOt8FIoqzl/Uho4X9/XmZXp+oC+jOkvyjgoiD4n6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SmPNbj60FBOjdLDnoXng9UYkklb2n9TteJbBDQJogsuYY9/cedQyP0oAcBhKJ2kmT
	 GvKZNMn7O2FCgmW5ZjxEXMmGSFFT2KuyysZLyXaX2bkgbxCdAkglt2ys8D584bHlR5
	 tJ4mO0IAKhcv5PXhU0lBjcIN+VvbzhiIwsZf3vXqRkKTvXgPYLWpqdjQkpCW15piOM
	 GStV9gniznbPGvaTtdQseKkMR7sZF6FmjMCdOfNAsJFXM5H8vcJvYSd/YTbtR/eFBP
	 lmOYcIcnw7ShqjnuLA66REItJ7f5QvGWqn/uvi8UqDWJpLxJzmF5+wrx4JYbvPe3O4
	 J9xE74KZ17NLA==
Date: Tue, 21 Oct 2025 18:32:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <samsun1006219@gmail.com>, <ahmed.zaki@intel.com>,
 <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <syzkaller-bugs@googlegroups.com>,
 <syzkaller@googlegroups.com>
Subject: Re: [PATCH V3] usbnet: Prevents free active kevent
Message-ID: <20251021183252.2eb25aac@kernel.org>
In-Reply-To: <20251018144940.583693-1-lizhi.xu@windriver.com>
References: <20251018144940.583693-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 22:49:40 +0800 Lizhi Xu wrote:
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1672,6 +1672,9 @@ void usbnet_disconnect (struct usb_interface *intf)
>  	usb_free_urb(dev->interrupt);
>  	kfree(dev->padding_pkt);
>  
> +	cancel_work_sync(&dev->kevent);
> +	timer_delete_sync(&dev->delay);
> +
>  	free_netdev(net);

Is this the best spot to place the cancel?
I think it may be better right after unregister_netdev().
I haven't analyze this driver too closely but for example since
kevent may call the sub-driver having it running after we already
called dev->driver_info->unbind() seems risky.
-- 
pw-bot: cr

