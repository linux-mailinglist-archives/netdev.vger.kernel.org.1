Return-Path: <netdev+bounces-174232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4408A5DEA4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BEC173775
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587524E011;
	Wed, 12 Mar 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="aeIlm9wm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC424DFE4;
	Wed, 12 Mar 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788524; cv=none; b=DW99JnYlGTOMjnlOc1WkECSgjJE0fSYb20FdAEDUyRRxdA+zMhYgKh2Y8l8EwxSxvLr77S04rqoYbW4N0mCX076thO1hmc1Wu2pVW8gPffZc0/pAqYU4B2gHAPANb8SOPqhAMpCPNCVSl6OfJ7kJ42HElh7HTzjsURpfX/oURXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788524; c=relaxed/simple;
	bh=O6bM2eem7AGIfBisuhXRcLUaOy3zZfCmx3rZpZbEe+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1aeuJkLeWkmwZWCx5BR4188DB6uZWnseh+Ac40LMU+8VA9kMQAfAeUt4SSkR3E+8aiKyLBxTr1Rk7NtGDu0BOlWryDobFzi5ED6tzD3477aENc+5HXvAmtnk6S3TxvxPVhMDLRqe0USebQptRQqM5PTa7I4ErmOAbnAs7gucsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=aeIlm9wm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741788519; x=1742393319; i=deller@gmx.de;
	bh=zMSsYCXR3SKAiDJrig5u3NuKsJKbnwtNZRgFxkaWUTo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aeIlm9wm5JMAnLvHHK/q012vqVrC3RlRCpYDUTnhWjTOHqyE6C0rPeuZ1dsuNblm
	 DWSwo+sCkuszlTGOzzLETOvxkrAoTcUJaiLcxeIeBRJuK2lvoJMUquVDVQTNaWIcd
	 vA8fORiDNeUndRecMgKuKBPX7rAdwWlWZWZoijwHAPAj1bBiSD7PtaUe94Vjku40B
	 VNOCICjdJZ/mKNEdWqD7xj6inkTNcmNZdHqmgDXiToeODh1WTOQZHKThSkQ021rGj
	 /LuSDo4lL1OiT4jQPX1hG5nqvVzNvNuWEQW7NJ7lWOkmG6XUvAsewyEUSkgwm1GTc
	 do+oh4nOzosPHwIPnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1tJqp008UX-00npPU; Wed, 12
 Mar 2025 15:08:39 +0100
Message-ID: <d863db0a-1740-45d5-b8de-746fa9d44fcb@gmx.de>
Date: Wed, 12 Mar 2025 15:08:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tulip: avoid unused variable warning
To: Simon Horman <horms@kernel.org>, deller@kernel.org
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250309214238.66155-1-deller@kernel.org>
 <20250312131433.GS4159220@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250312131433.GS4159220@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OvGY8pZP9NflkWETYTBy4u509AqaOYbePbb/t3X0sNntzBwG36Y
 A+C1eNElCIo1HRqazFC7u2lMUyUQzlo/RwG9hYWW4rAjAKh/4/+7Z+g4TAy752bXTEWEWA1
 xyd4pCK7kjFbkYq/ba+5xQ1RIT8QsPLB2Lwo9/z4Rq9JJbpOg5vUZObrfoHSGvvSkAF1IbW
 YIqQ1ImTTjebJ3z+DnG9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8z92gIkOpdI=;TimYwGgVXpCVeX7674IsT3qfpHz
 4vX5pwQIaEkSrjXd5cGs+SgER6iB5sTHZXRscA+SdQOJzkSBXWsYjJu5XXozM/9qZhQnR6AdZ
 g41Cd7I1BbZDErZUDWQs5brjTNfYNoI1SsQja7fBQ8MAcB8/4QLfFNMQDfpXQdYLpsgQmPNCw
 7N5X8pocJzHe51bqtYJZqcfGxBbXAnQ4vz+AZn500K0QjQQDaCSletcNBSfGd9TkNAA6hOZab
 Uzjsacc2LEIhfI5D5xg63SdlahmLQdaCn2McpVHKxVnSoTFs3o8un9/rBg3g2BEkCrghhoWfg
 AEOmPZoJLiH/ZDxFuhxwji4ptWMOKnXrzQe0+8DCzZU9SS0Kw8wss/7l/t7GYNQkdZ/YXNi0b
 CpPr17c55v5T4gJugYJ8vHDvxGwVOIbBXkz2NCa1CtJQT8j14Us1IP1+ycL2ksrgZusMuYHNj
 6hJ/AccjLJGKs0DRVWZIttl1xE2ENMMBsZ420aXFKJXPE+unN0ihOtANKHGnCGRS/oK686XI2
 CZo60r83cD3F6x1xsPiEeW3la9Zqvn8WzGInPWq9zW1BOxF7bdtJ0kCDmr+OVxhMQpzPrft/7
 nreD0j8iDtm2noXPMkydBoIhWVZhaWPe6eUHtSfEjsXKZfeLUS848LOadqMhmAjME1MKgSbno
 XcKiBL7Iz7Zf0XRwGd/ljwPhuZ6aniLRCYvkLAqYP3qhvfSvsLbY5rqHACm53xvkiun4fiFiV
 kzEsTBL7hN2TSaRtUjcPwqd1DFmhOGIowU364828TCV1JTGySxatNnZBa7Ozh1zK1dpza76wm
 75GGIWTIHrxPiXyptZ24YtAQp2rlQwuUwbsFnPvi6PSVOGK4z9U5oA+E/4btp+O7CO4KM8O/g
 rkCe807xoUq+hWusppC2lkGVf3dlOZfuiPkH847wsGODZfXXUmGdB54LjKzFLISHElDYum3UY
 pzUqe7dRxvAEgo9S3JS19LX9Hl0Xx1iUvFMFtgGZRHlaiaEMHn6kfMKiIOJuZYAgPB3T88Gxx
 P2ba167tBehAV0nIh2Hp0dZL4dwjk3NWTGejq1OoRvMtwMdqds/SOB3NVY27MylIW8v+/HwPn
 Jju5hRd3DInsE6q0V28RfrRM7LB496XmPyuevpFwXDGrdRoCIxM2S70AATtTvadRhaGJZCt2z
 Av841GQzNHALbNTAVczujJAUX1yKSphBzDTQEr2jd9D4JK7eszgsrEqVyRvAA0hM/A70k3pUI
 hWNdtZ1z3yfWktX7L7wDOpyLAEmVJxnwkClDUhiqFlsPMFaV93zNE72WCqZocCf/aRlsRvkcM
 IF0u0IqOmjAHDbOFLtoMaA6zhVlUTMx+QAr6iob6a3ZH5WqdOkXvwRotVCqXRsKafQ9CUhtjb
 Qw6C7bBeUSW6zVzXXu1KqfMHsH2ktlF1k9RZCKcdA57mRvg4WYo3FphTZdRmQpwjAxb8GQV84
 bZpGOGg==

On 3/12/25 14:14, Simon Horman wrote:
> On Sun, Mar 09, 2025 at 10:42:38PM +0100, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> When compiling with W=3D1 and CONFIG_TULIP_MWI=3Dn one gets this warnin=
g:
>>   drivers/net/ethernet/dec/tulip/tulip_core.c: In function =E2=80=98tul=
ip_init_one=E2=80=99:
>>   drivers/net/ethernet/dec/tulip/tulip_core.c:1309:22: warning: variabl=
e =E2=80=98force_csr0=E2=80=99 set but not used
>>
>> Avoid it by annotating the variable __maybe_unused, which seems to be
>> the easiest solution.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Hi Helge,
>
> A few thoughts on this:

Hi Simon,

Thanks for following up on this!

> Firstly, thanks for your patch, which I agree addresses the problem you
> have described.
>
> However, AFAIK, this is a rather old driver and I'm not sure that
> addressing somewhat cosmetic problems are worth the churn they cause:
> maybe it's best to leave it be.

Well, the only reason why I sent this patch is, because some people
are interested to get a Linux kernel build without any warnings when "W=3D=
1"
option is enabled.
This code in the tulip driver is one of the last 10 places in the kernel w=
here
I see a warning at all, so I think it's worth fixing it, although it's jus=
t
cosmetic.


> But if we do want to fix this problem, I do wonder if the following
> solution, which leverages IS_ENABLED, is somehow nicer as
> it slightly reduces the amount of conditionally compiled code,
> thus increasing compile test coverage.

Full Ack from my side!
I wanted to keep my patch small, but your proposed patch is the better one=
.

I did not compile-test it, but if it builds you may add my:
Acked-by: Helge Deller <deller@gmx.de>

Helge

> diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/e=
thernet/dec/tulip/tulip_core.c
> index 27e01d780cd0..75eac18ff246 100644
> --- a/drivers/net/ethernet/dec/tulip/tulip_core.c
> +++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
> @@ -1177,7 +1177,6 @@ static void set_rx_mode(struct net_device *dev)
>   	iowrite32(csr6, ioaddr + CSR6);
>   }
>
> -#ifdef CONFIG_TULIP_MWI
>   static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *=
dev)
>   {
>   	struct tulip_private *tp =3D netdev_priv(dev);
> @@ -1251,7 +1250,6 @@ static void tulip_mwi_config(struct pci_dev *pdev,=
 struct net_device *dev)
>   		netdev_dbg(dev, "MWI config cacheline=3D%d, csr0=3D%08x\n",
>   			   cache, csr0);
>   }
> -#endif
>
>   /*
>    *	Chips that have the MRM/reserved bit quirk and the burst quirk. Tha=
t
> @@ -1463,10 +1461,9 @@ static int tulip_init_one(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
>
>   	INIT_WORK(&tp->media_work, tulip_tbl[tp->chip_id].media_task);
>
> -#ifdef CONFIG_TULIP_MWI
> -	if (!force_csr0 && (tp->flags & HAS_PCI_MWI))
> +	if (IS_ENABLED(CONFIG_TULIP_MWI) && !force_csr0 &&
> +	    (tp->flags & HAS_PCI_MWI))
>   		tulip_mwi_config (pdev, dev);
> -#endif
>
>   	/* Stop the chip's Tx and Rx processes. */
>   	tulip_stop_rxtx(tp);
>


