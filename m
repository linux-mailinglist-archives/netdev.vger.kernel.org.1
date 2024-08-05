Return-Path: <netdev+bounces-115670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52C947710
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75C1281A60
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242814BF8D;
	Mon,  5 Aug 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2JhqSMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EAA149C45;
	Mon,  5 Aug 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846020; cv=none; b=aT31cBxX6Jks9eMyroFYY5tmCWbNXWqkPI90C/4sVIK/wCYPBRFHstO430Poydz5mHjXHEMooYozlc6CQDkYCQTzIReWQ6Wx+REbR7/+vfS/tXUq4OQzwabGuU6ruxq8gn/gkI9rhA7F36MTxcE7+0xnBMM+ynaZrZt2aKy8B48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846020; c=relaxed/simple;
	bh=wmW9uKSb/2SP16SrvbJjH83JY/E4lBeMVQe2z/6uRjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMVhoUixshh+iKXIGU2jSDHEkoAcVeXFsZ2/seJ9L5g3MwDFirATCOCY0eHtBjKxYwLT9/iFgDZB615FDzQvfbH4o72nnyzxmL7z28Xm2bFH1d/r+GWuOTk2U4H52soRUF7/YZN7g2U24V4mLIrtQBs5S4Mvp+bV6O5dztzxRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2JhqSMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C2FC32782;
	Mon,  5 Aug 2024 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722846019;
	bh=wmW9uKSb/2SP16SrvbJjH83JY/E4lBeMVQe2z/6uRjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K2JhqSMwwZ8/QOqbW2z24A69QE2LKeq77pogtoozix5anJLdQzeonjm2LoPajQfIZ
	 nqylIoAZzEh09TD54hvDIXt1C0v+ACyuPfec/M2c4o8RdA2g0w8SHwpIkjbYN9xMnB
	 er+6CkbjyitB5FnDChNaVg+2wcRPoXlQUDkAib2plzLHjl4STJzIEcZ9D3zIKmRRfS
	 /ztT+v6XTT/RUZsAICzX46uChxYO8yWjOxESCw5FfQ/z8AGVDJkyby36Nr9ZyR+884
	 razxShdh6YS4V/Hq3hEquRjIFvfvGw944WXMlvpnjRIb0pEnCXlWNTu2VbBRVhzCs4
	 nmcqHa9JxDULw==
Message-ID: <d4d60cab-1872-4063-8b2f-a4ca0afd2718@kernel.org>
Date: Mon, 5 Aug 2024 10:20:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: nci: Fix uninit-value in nci_rx_work()
To: Simon Horman <horms@kernel.org>, zhanghao <zhanghao1@kylinos.cn>
Cc: bongsu.jeon@samsung.com,
 syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240803121817.383567-1-zhanghao1@kylinos.cn>
 <20240804105716.GA2581863@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240804105716.GA2581863@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2024 12:57, Simon Horman wrote:
> On Sat, Aug 03, 2024 at 08:18:17PM +0800, zhanghao wrote:
>> Commit e624e6c3e777 ("nfc: Add a virtual nci device driver")
>> calls alloc_skb() with GFP_KERNEL as the argument flags.The
>> allocated heap memory was not initialized.This causes KMSAN
>> to detect an uninitialized value.
>>
>> Reported-by: syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
> 
> Hi,
> 
> I wonder if the problem reported above is caused by accessing packet
> data which is past the end of what is copied in virtual_ncidev_write().
> I.e. count is unusually short and this is not being detected.
> 
>> Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
>> Link: https://lore.kernel.org/all/000000000000747dd6061a974686@google.com/T/
>> Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
>> ---
>>  drivers/nfc/virtual_ncidev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
>> index 6b89d596ba9a..ae1592db131e 100644
>> --- a/drivers/nfc/virtual_ncidev.c
>> +++ b/drivers/nfc/virtual_ncidev.c
>> @@ -117,7 +117,7 @@ static ssize_t virtual_ncidev_write(struct file *file,
>>  	struct virtual_nci_dev *vdev = file->private_data;
>>  	struct sk_buff *skb;
>>  
>> -	skb = alloc_skb(count, GFP_KERNEL);
>> +	skb = alloc_skb(count, GFP_KERNEL|__GFP_ZERO);
>>  	if (!skb)
>>  		return -ENOMEM;
> 
> I'm not sure this helps wrt initialising the memory as immediately below there
> is;
> 
> 	if (copy_from_user(skb_put(skb, count), buf, count)) {
> 		...
> 
> Which I assume will initialise count bytes of skb data.

Yeah, this looks like hiding the real issue.

Best regards,
Krzysztof


