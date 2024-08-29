Return-Path: <netdev+bounces-123192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A957F964039
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5331F2276A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904B18A6D3;
	Thu, 29 Aug 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9AZTnIK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96B189F31
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924048; cv=none; b=RRJNNTH3X6J+1JbTIuC3Yj4TTTdtWqmd6ESjXb52a0HdmrBOXAwzGaVVT2TvzV71lKK4TRzCf+F5hIGflZ6QZyAOstM7NrRgTxQLxJKmx+CFdPAFHNFSpM1Q9zvbGphmTh7cQV4z4U1681jXRgNo5S5AoTlsLHi4KuQPURIVVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924048; c=relaxed/simple;
	bh=JysCSfHgK24yWzdWo/5Cx73f7aPyPjUA4tMgZAwRv3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PR352a7F/vGX1NE8KIX/SD+3M1QQrwm5cix9bgIGCwTIulVGZahgctZNqIJI2BUA+gyqyCJTCxIMseaW8TV6FBcVKMahG9EW53F9G6zY6mCukHYkDRpzQmi8a+VOlWC4n/rDDTLqTInVstpGAXiSpfSWc+NW07GFSd9lIEpR8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9AZTnIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724924046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
	b=K9AZTnIKMyJdt1Snx6CdhaR1xfHr/rcmysDvFUJLdu5BFmwM7rX22pd/MFNKyCdtUxx1dc
	mRs7N5TrCmlInAaRp5SrBns7UhjmwwtGZ/vEr7iY87wFufUQCJO5r/ULgje8K1GX4hJEFm
	eYB2X6gLdF76rOiSdOv2th/wqN3XPt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Nt9WCC1xNim5xOr-CLZbyw-1; Thu, 29 Aug 2024 05:34:03 -0400
X-MC-Unique: Nt9WCC1xNim5xOr-CLZbyw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so5533085e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 02:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924042; x=1725528842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRhf0ft13sdsULrJq6iL+gwjruDGQCG9graD1/4XUWs=;
        b=jQIDHv0BK84V322D+Ih6NA5JSesPaz76cKn62CAqYk4iLxn05IHY4ElCCG83JFrZ+8
         euZq1qSOuxrwQv7HQvACifnjTwHKyWb5Fbw33r4YCnm3qOk28OevHWYsVZHYo/7uSb1N
         ZnweOsINdKnMy/s+RhCPHAj66bObjq9CUFWt467M0iKFj1cGrkUy4oa7eLU3JcpatC3i
         O4+Fnvs6YGazvpRWsRQRT/JmAMc5c5nOosYjVQNIWFNHaFjyGiy6xyILRUqO84ml3kh6
         rXnpQAYDnrTVVdEx6ekbwxpqSGrW/BXDZHlDFl9cnsSg7mOEP1fI72V359puWQe/XT9U
         ROWQ==
X-Gm-Message-State: AOJu0Ywa7TPXk2R7+HRFzTjtN89uHDnH6bhimijGGmyvFv9pBsjf3hGz
	u+m4p4qqtHF44vmkrZZVXvHKpfWd8cw9zSDkJgIJ6hrx7NfdxXsOqmPPYxFdxh5yTNiSZo+BZda
	BGVBKMFWMJ0yRWh5kn1MGnH4TnL3qKBNlkW5VcGG4kEZAd8IjthwpoA==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42bb01c1b92mr23828055e9.18.1724924042418;
        Thu, 29 Aug 2024 02:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp3x3sJmbQoDYIBd/6sKnodDuko7n08nPVFtSHanDsq4XaBJ2ce0s2y16TQdY5AiDJ9Js95g==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42bb01c1b92mr23827825e9.18.1724924041875;
        Thu, 29 Aug 2024 02:34:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273bcsm11348575e9.31.2024.08.29.02.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:34:01 -0700 (PDT)
Message-ID: <a337ae5e-1333-443d-8374-67420823a590@redhat.com>
Date: Thu, 29 Aug 2024 11:34:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfc: pn533: Add poll mod list filling check
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Aleksandr Mishin <amishin@t-argos.ru>, Samuel Ortiz <sameo@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240827084822.18785-1-amishin@t-argos.ru>
 <26d3f7cf-1fd8-48b6-97be-ba6819a2ff85@redhat.com>
 <b1088e86-a88e-4e20-9923-940dfba5dea8@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b1088e86-a88e-4e20-9923-940dfba5dea8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 11:06, Krzysztof Kozlowski wrote:
> On 29/08/2024 10:26, Paolo Abeni wrote:
>>
>>
>> On 8/27/24 10:48, Aleksandr Mishin wrote:
>>> In case of im_protocols value is 1 and tm_protocols value is 0 this
>>> combination successfully passes the check
>>> 'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
>>> But then after pn533_poll_create_mod_list() call in pn533_start_poll()
>>> poll mod list will remain empty and dev->poll_mod_count will remain 0
>>> which lead to division by zero.
>>>
>>> Normally no im protocol has value 1 in the mask, so this combination is
>>> not expected by driver. But these protocol values actually come from
>>> userspace via Netlink interface (NFC_CMD_START_POLL operation). So a
>>> broken or malicious program may pass a message containing a "bad"
>>> combination of protocol parameter values so that dev->poll_mod_count
>>> is not incremented inside pn533_poll_create_mod_list(), thus leading
>>> to division by zero.
>>> Call trace looks like:
>>> nfc_genl_start_poll()
>>>     nfc_start_poll()
>>>       ->start_poll()
>>>       pn533_start_poll()
>>>
>>> Add poll mod list filling check.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>
>> The issue looks real to me and the proposed fix the correct one, but
>> waiting a little more for Krzysztof feedback, as he expressed concerns
>> on v1.
> 
> There was one month delay between my reply and clarifications from
> Fedor, so original patch is neither in my mailbox nor in my brain.
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> However different problem is: shouldn't as well or instead
> nfc_genl_start_poll() validate the attributes received by netlink?
> 
> We just pass them directly to the drivers and several other drivers
> might not expect random stuff there.

FTR, I had a similar thought and skimmed over other nfc drivers. I did 
not see similar issues there.

Additionally I fear that existing user-space could feed to the kernel 
such random stuff and work happily because the kernel is currently 
ignoring it - on other drivers. Such cases will suddenly stop working.

I think we could/should merge the patch as-is, please LMK your thought.

Thanks,

Paolo


