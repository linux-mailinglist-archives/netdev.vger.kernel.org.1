Return-Path: <netdev+bounces-245046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347CCC65FD
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CF730E8A66
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46333ADB3;
	Wed, 17 Dec 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhrFksbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6633AD83;
	Wed, 17 Dec 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956710; cv=none; b=QltgpOxzAhCdOzKxtNTIsS8nDLTTnV8XO7AVt2SqCwyImePV4mu3auXuWoHu5lBc9XRhvsXFtnX45f3bAw705VJwv5wp3Vth3Ies3cwC06KLGjSwQ50K7xV++xsJRdrRBAijb2WUtHEGOATBqbhjJwUNKJKDZArYAT/GbU/4RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956710; c=relaxed/simple;
	bh=Ww8YVr7oabIihRnQ8dUyXwffspSVwC3gqZ+3UO9gL7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIp5JhXa9xpV/eDZCX2JqFU+QYWApETrR2yyBOBiFTb0vzk6xeoQCim6JA0RZFtzFkqU66TKhlXMVWSDRsSFAkx+9T7jPChpTrF7Kuy+2bZP3IJrOH/H0AkShnA7slgbhgCpBbMo3ZAMinROkDQkP9XFUM8t+wyb91g3cYw7YDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhrFksbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8721FC19421;
	Wed, 17 Dec 2025 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765956709;
	bh=Ww8YVr7oabIihRnQ8dUyXwffspSVwC3gqZ+3UO9gL7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EhrFksbpoCgxzJ+0ecpIgXWbFC4oQv1kzDFyqAATXrLgAOpvNrXAUq6d+tnYNmnND
	 NOvZY+zg2O5nyTLHP//YFj3Vk25c8V17+mft7UoLjEjkpYza/+ELDtnse6ji6hHgXO
	 LciGK+MDpcOf13WTcVOmD10unmriLNloMRFCE2o6LCw2uDVbN4Yskt+QkRdozf7G6f
	 +0JVQyKQRo+j7vtUHo/LiDlUZEDOrjlqHXC9MmoStXXKE/2KZRW13IC68kc9QrnD7U
	 APa89rRSbSBL3imk0GeOfCzOKw3PVmOcwquSvUeP63BTC5/3dGG4OGgNE6coL0U43N
	 uBid6R4vKtLAg==
Message-ID: <ea5ae096-fdbd-4c93-98ff-7f5b67860898@kernel.org>
Date: Wed, 17 Dec 2025 08:31:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: nfc: fix deadlock between nfc_unregister_device and
 rfkill_fop_write
To: Deepanshu Kartikey <kartikey406@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
References: <20251217054908.178907-1-kartikey406@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251217054908.178907-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 06:49, Deepanshu Kartikey wrote:
> A deadlock can occur between nfc_unregister_device() and rfkill_fop_write()
> due to lock ordering inversion between device_lock and rfkill_global_mutex.
> 
> The problematic lock order is:
> 
> Thread A (rfkill_fop_write):
>   rfkill_fop_write()
>     mutex_lock(&rfkill_global_mutex)
>       rfkill_set_block()
>         nfc_rfkill_set_block()
>           nfc_dev_down()
>             device_lock(&dev->dev)    <- waits for device_lock
> 
> Thread B (nfc_unregister_device):
>   nfc_unregister_device()
>     device_lock(&dev->dev)
>       rfkill_unregister()
>         mutex_lock(&rfkill_global_mutex)  <- waits for rfkill_global_mutex
> 
> This creates a classic ABBA deadlock scenario.
> 
> Fix this by moving rfkill_unregister() and rfkill_destroy() outside the
> device_lock critical section. To ensure safety, set shutting_down flag
> first and store rfkill pointer in a local variable before releasing the
> lock. The shutting_down flag ensures that nfc_dev_down() and nfc_dev_up()
> will bail out early if called during device unregistration.
> 
> Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2

You need Fixes and CC-stable tags.

So this was introduced by previous fix from Lin Ma... All these random
drive-bys by various people based on syzbot are just patching buggy code
with more buggy code. :/ No one cares too look more than just the syzbot
report.

And you as well. If you fix ABBA here, you should look and fix in other
places as well. There is exactly same order of locks in
nfc_register_device(). That's the register path which should not be a
problem, maybe except false LOCKDEP positives, but you should explain
that in commit msg why leaving ABBA there is safe.




> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  net/nfc/core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/nfc/core.c b/net/nfc/core.c
> index ae1c842f9c64..201d2b95432b 100644
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c
> @@ -1154,7 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
>  void nfc_unregister_device(struct nfc_dev *dev)
>  {
>  	int rc;
> -

Do not remove blank line.

> +	struct rfkill *rfk = NULL;
>  	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
>  
>  	rc = nfc_genl_device_removed(dev);
> @@ -1164,13 +1164,17 @@ void nfc_unregister_device(struct nfc_dev *dev)
>  
>  	device_lock(&dev->dev);
>  	if (dev->rfkill) {
> -		rfkill_unregister(dev->rfkill);
> -		rfkill_destroy(dev->rfkill);
> +		rfk = dev->rfkill;
>  		dev->rfkill = NULL;
>  	}
>  	dev->shutting_down = true;
>  	device_unlock(&dev->dev);

1. So your code allows concurrent thread nfc_rfkill_set_block() to be
called at this spot
2. Original thread of unregistering will shortly later call
device_del(), which goes through lock+kill+unlock,
3. Then the concurrent thread proceeds to device_lock() and all other
things with freed device.

You just replaced one issue with another issue, right?

Best regards,
Krzysztof

