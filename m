Return-Path: <netdev+bounces-129351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A0D97EFD2
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1311C21303
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8219E99A;
	Mon, 23 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLlcTjwH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6219E980;
	Mon, 23 Sep 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727112481; cv=none; b=Q8DhoS3mVoezrdVwEH7FjwWwNCvFRi5cl+KXk+MODLOsEA8v9bWCokOCqd03dNGKYA7c1OaHKZS82nRYtYpxvMm8x0qWjy79ez5aj4RpSDPemlfkr10UMfOsaymclvTxFy9U+T8A+7Hwy2c0uU+GCJBW944XIU/Y8NwDDDlKhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727112481; c=relaxed/simple;
	bh=Ryxkj3SPdrNgzxNee7XkTczGpikTXKWzjDkJ/5aUBy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qflx8NkNvCsrdfKDWHkUo8HzkPaGDCsP3BXrANgF7IfV0TGUvqpApPTbO9qn1eRo0ep8QihRCH0uaPilmV2ebGaRmo6at/aIqtN+bbOiljr58AGYWWYYppM5AssBV7EBbgPn2ooBabNa5ULdmFtKG5Kuwx4zpfHyStTDjrwBzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLlcTjwH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c5acb785f2so23886636d6.0;
        Mon, 23 Sep 2024 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727112478; x=1727717278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VFPEQFQWbRB+7K1niS5ZtaDZfgMoS6/yhONnzruI0HQ=;
        b=SLlcTjwH3FQPtc1RJ6lZycldSaf1b6xX2EHayIp8RuTs3r+fg8KfLnfJgNbX5x1lc4
         VflhPtx0UeGyBtlUjF8uFq+M90ko2T0UX742dyKcwnmI9NQnaYgpVQ1ztvTKDwtz+DZi
         kRhzG9wqqHaN+AiAbUvwxMejhwoyzz2JA6pqOaRu9tLNV+wVtPQ4Dma2eE+Wer+Fzxzv
         yAGC7ad7mUg8NeXX/iPQ8alsuWRapmdlNPBhln3CFIyb1tROiNwa+G9qQWtPUbfy+Kfd
         JOHIoxLlcVxcDXkJUWTTakH4nZM5otfLzoW8TTYvMC1PTyZJOWSQMZNmE2gveNrWOiUk
         +Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727112478; x=1727717278;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFPEQFQWbRB+7K1niS5ZtaDZfgMoS6/yhONnzruI0HQ=;
        b=fK2YXN2yq5OQnY5qnk88DwoYE6WwX/JsxT8H44OEPCN6MHdfS+Db66WxY4HKKTVShG
         7bQfFb7oTbLRAlCGsMvpc6qcrfQy2UbykD6UVFiTXjqyb4ENVe2h7i305IRXjHdbfEL+
         peN0miNWw66HubiszUwWOfrKm2Hdicp8Wer6PJ3RHxHHRpX6p2Ag3hEqVVPOfHN5NOYH
         /bZUvMnotlGDIDr0BN3vH3jhcvo7cYyW6oeinkq7xxzAeCMpvt78bTeRlS4Ah/J01W3B
         CGOEtlXcEJ35AZnxwCB/LVFvqAEwWLkvWOzBUulmusvjxQdwl6kfwdNHBUmHh79O6GC7
         dtkw==
X-Forwarded-Encrypted: i=1; AJvYcCUr1z7/CZ0SeE91JirudwvRRET0kOAego2RwfqFQkjEGCxs4AC05naq8Ka73TOSDilVv1wJ0Q9T@vger.kernel.org, AJvYcCVCkfTITpCR9EEejUX0SVlHoOlvXkBMxJbPbDajkfAWGRqtpmsaQ6ufhTXTKagHOHxLwuohf9kkQuxiC1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/icGqtTpfl6y85jmywQ8GTqiMEk1pjHS/oG/oaI6f/2u3GyW
	vKTKiqI3jtY6HbGnkrUtxSLkHe3NRYWbvZUXMYCgE1Z2O2hF+xJA
X-Google-Smtp-Source: AGHT+IGzrXiYhi2OfwD6Wfdzl5rRuST5U5lO6BIeJXI9+YNIL6LShINdtNLHJadgXGC8hCJcIEU2/w==
X-Received: by 2002:a05:6214:3912:b0:6c3:5663:81b5 with SMTP id 6a1803df08f44-6c7bd486842mr178984726d6.5.1727112478133;
        Mon, 23 Sep 2024 10:27:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e55e787sm49316266d6.94.2024.09.23.10.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:27:56 -0700 (PDT)
Message-ID: <b55b407e-dc95-4036-9467-0279d6e655d1@gmail.com>
Date: Mon, 23 Sep 2024 10:27:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
To: Dipendra Khadka <kdipendra88@gmail.com>, Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, florian.fainelli@broadcom.com, davem@davemloft.net,
 edumazet@google.com, bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923053900.1310-1-kdipendra88@gmail.com>
 <20240923161942.GK3426578@kernel.org>
 <CAEKBCKPkJ7DSku0w1injh55yd2HJdK0S3KPqWM_dUPQBAQD3pw@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAEKBCKPkJ7DSku0w1injh55yd2HJdK0S3KPqWM_dUPQBAQD3pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 09:39, Dipendra Khadka wrote:
> Hi Simon,
> 
> On Mon, 23 Sept 2024 at 22:04, Simon Horman <horms@kernel.org> wrote:
>>
>> On Mon, Sep 23, 2024 at 05:38:58AM +0000, Dipendra Khadka wrote:
>>> Add error pointer checks in bcm_sysport_map_queues() and
>>> bcm_sysport_unmap_queues() before deferencing 'dp'.
>>
>> nit: dereferencing
>>
>>       Flagged by checkpatch.pl --codespell
>>
>>>
>>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>>
>> This patch does not compile.
>> Please take care to make sure your paches compile.
>>
>> And, moroever, please slow down a bit.  Please take some time to learn the
>> process by getting one patch accepted. Rather going through that process
>> with several patches simultaneously.
>>
>>> ---
>>> v2:
>>>    - Change the subject of the patch to net
>>
>> I'm sorry to say that the subject is still not correct.
>>
>> Looking over the git history for this file, I would go for
>> a prefix of 'net: systemport: '. I would also pass on mentioning
>> the filename in the subject. Maybe:
>>
>>          Subject: [PATCH v3 net] net: systemport: correct error pointer handling
>>
>> Also, I think that it would be better, although more verbose,
>> to update these functions so that the assignment of dp occurs
>> just before it is checked.
>>
>> In the case of bcm_sysport_map_queues(), that would look something like this
>> (completely untested!):
>>
>> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
>> index c9faa8540859..7411f69a8806 100644
>> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
>> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
>> @@ -2331,11 +2331,15 @@ static const struct net_device_ops bcm_sysport_netdev_ops = {
>>   static int bcm_sysport_map_queues(struct net_device *dev,
>>                                    struct net_device *slave_dev)
>>   {
>> -       struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
>>          struct bcm_sysport_priv *priv = netdev_priv(dev);
>>          struct bcm_sysport_tx_ring *ring;
>>          unsigned int num_tx_queues;
>>          unsigned int q, qp, port;
>> +       struct dsa_port *dp;
>> +
>> +       dp = dsa_port_from_netdev(slave_dev);
>> +       if (IS_ERR(dp))
>> +               return PTR_ERR(dp);
>>
>>
>>          /* We can't be setting up queue inspection for non directly attached
>>           * switches
>>
>>
>> This patch is now targeted at 'net'. Which means that you believe
>> it is a bug fix. I'd say that is reasonable, though it does seem to
>> be somewhat theoretical. But in any case, a bug fix should
>> have a Fixes tag, which describes the commit that added the bug.
>>
>> Alternatively, if it is not a bug fix, then it should be targeted at
>> net-next (and not have a Fixes tag). Please note that net-next is currently
>> closed for the v6.12 merge window. It shold re-open after v6.12-rc1 has
>> been released, which I expect to occur about a week for now. You should
>> wait for net-next to re-open before posting non-RFC patches for it.
>>
>> Lastly, when reposting patches, please note the 24h rule.
>> https://docs.kernel.org/process/maintainer-netdev.html
>>
> 
> Thank you so much for the response and the suggestions. I will follow
> everything you have said and whatever I have to.
> I was just hurrying to see my patch accepted.

Also please prefix your patch the same way that previous changes to this 
file have been done, that is, the subject should be:

net: systemport: Add error pointer checks in bcm_sysport_map_queues()

Thank you
-- 
Florian

