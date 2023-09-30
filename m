Return-Path: <netdev+bounces-37187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A67B41F1
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 10082283498
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D281774B;
	Sat, 30 Sep 2023 16:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C6EAEC
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 16:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144A7C433C7;
	Sat, 30 Sep 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696089872;
	bh=6RkJeO80Y6I9k6A93GTmjkGFgNpYWb9OU4GsW1LTuYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcJAsXbE9a5DeIf+W8MB19aWP172gjnpP3lwAuggEBDqnEKXAJwmYCG6ImDppINAY
	 f6/q/GRNZ2e5Ma8pmzb2B888SrguU8F5MoxwHIILuAUfIaCRxLOdV9UcROOdH/OyQx
	 Cn+HPqALEhFGILZADjo60ed3ulIpl8eQQ1lRFkVZyN2ATRTSV7LBXZcKSNsUeXTuoU
	 w9Dm0ulg+qEGA6vJUKNqAp6xTPkBY8sPtIslKW+d8xslsUr+zOM7suKtKcH5CTdL8S
	 Rn4qi5uI6q0Y85znGNOjKYdYHYj+9D4+HoHittc7tGLxOdd+/mPl+GIw571L1DCt5t
	 xQ5G1AnDmR7dA==
Date: Sat, 30 Sep 2023 18:04:28 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock and &tx_queue_lock
Message-ID: <20230930160428.GB92317@kernel.org>
References: <20230926104442.8684-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926104442.8684-1-dg573847474@gmail.com>

+ David Woodhouse <dwmw2@infradead.org>

On Tue, Sep 26, 2023 at 10:44:42AM +0000, Chengfeng Ye wrote:
> As &card->cli_queue_lock and &card->tx_queue_lock are acquired under
> softirq context along the following call chain from solos_bh(), other
> acquisition of the same lock inside process context should disable
> at least bh to avoid double lock.
> 
> <deadlock #1>
> console_show()
> --> spin_lock(&card->cli_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> spin_lock(&card->cli_queue_lock)
> 
> <deadlock #2>
> pclose()
> --> spin_lock(&card->tx_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> fpga_tx()
>    --> spin_lock(&card->tx_queue_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on the two locks under process context code consistently to prevent
> the possible deadlock scenario.

Hi Chengfeng Ye,

thanks for your patch.

As this patch seems to fix two, albeit, similar problems,
it should probably be split into two patches.

As fixes for Networking code they should probably be targeted at the
'net' tree. Which should be denoted in the subject.

	Subject: [PATCH net] ...

And as fixes the patch(es) should probably have Fixes tags.
These ones seem appropriate to me, but I could be wrong.

Fixes: 9c54004ea717 ("atm: Driver for Solos PCI ADSL2+ card.")
Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")

> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/atm/solos-pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
> index 94fbc3abe60e..247e9200e312 100644
> --- a/drivers/atm/solos-pci.c
> +++ b/drivers/atm/solos-pci.c
> @@ -447,11 +447,12 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
>  	struct atm_dev *atmdev = container_of(dev, struct atm_dev, class_dev);
>  	struct solos_card *card = atmdev->dev_data;
>  	struct sk_buff *skb;
> +	unsigned long flags;
>  	unsigned int len;
>  
> -	spin_lock(&card->cli_queue_lock);
> +	spin_lock_irqsave(&card->cli_queue_lock, flags);
>  	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
> -	spin_unlock(&card->cli_queue_lock);
> +	spin_unlock_irqrestore(&card->cli_queue_lock, flags);
>  	if(skb == NULL)
>  		return sprintf(buf, "No data.\n");
>  
> @@ -954,16 +955,17 @@ static void pclose(struct atm_vcc *vcc)
>  	unsigned char port = SOLOS_CHAN(vcc->dev);
>  	struct sk_buff *skb, *tmpskb;
>  	struct pkt_hdr *header;
> +	unsigned long flags;
>  
>  	/* Remove any yet-to-be-transmitted packets from the pending queue */
> -	spin_lock(&card->tx_queue_lock);
> +	spin_lock_irqsave(&card->tx_queue_lock, flags);
>  	skb_queue_walk_safe(&card->tx_queue[port], skb, tmpskb) {
>  		if (SKB_CB(skb)->vcc == vcc) {
>  			skb_unlink(skb, &card->tx_queue[port]);
>  			solos_pop(vcc, skb);
>  		}
>  	}
> -	spin_unlock(&card->tx_queue_lock);
> +	spin_unlock_irqrestore(&card->tx_queue_lock, flags);
>  
>  	skb = alloc_skb(sizeof(*header), GFP_KERNEL);
>  	if (!skb) {
> -- 
> 2.17.1
> 
> 

-- 
pw-bot: changes-requested

