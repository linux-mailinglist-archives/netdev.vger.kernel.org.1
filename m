Return-Path: <netdev+bounces-172372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD1A546BC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC0F16865B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5120A5CF;
	Thu,  6 Mar 2025 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/uF1thv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DF209F24
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254258; cv=none; b=pIzD9L2kop9SItR4ZSCA1jJldMyQB2D72XQwWVQ7q405nN9ye373NlIqbXdF7tD2dEKHj7mpmcHOGOcnlLuq7Aa9lZiqOvkeJ2wXLJS8dbISQWtbfPEorldWxMfpW2sWgneX/yZaV+aEatJVn8OIdt58R77EoX7cLBw3ZaDdxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254258; c=relaxed/simple;
	bh=fvnfRUaIZlTDMzpxO7pjaeHR5Y14Zwabg67Nn6Y6wEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEBlW1uEPeRioF8vFJ5E3p0XjGWztgmzdVgI4wqLhokli4p/k+qdNEWlnzSELKe4eeuyUR6hTV67uQlk8G6YRs0k9RiEUmSReNEnCV4FsmlImg+XabmJ5Jvvq6hWOBiwL0w7nDiIUlmO/Ct4nrkd5IZ/Mot2ry2dsZQpDVefq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/uF1thv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso683540a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741254256; x=1741859056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoDVmzMkKNOHCOAEkEWbxwwYdyhsPDeYQQkLswcEOWg=;
        b=I/uF1thvbwnv0mfRxw+VqIJ4vMOdfL+aJaOeFJ78b0GkfGhz9LJLzuA0wOSS/FwHiU
         5ItjUpueSB97xabJzcsMEPpqOTV1Rq1Yl20UMbzkyNPFmhb8NPez3wv1I25F8fuMtHBy
         dod59xJMurap8XQZ6vQiEV/G489ZTMFn+rWIewpigCkM8/hQ2OnImSa239WjgCBs/QVK
         KiUZNiRS9Q4IUH+Qi3GMdKe3lL/fNFpFDEcCLY2QG9LVf1Byky9LX6VZdaCMP2aSbTiH
         fWHDpAU7dIvAsErm/SfrhqAjL5nn2dm1Rb38EyFxulxY/2XN9i2QGIutrUrgMk3w3ZMk
         MErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254256; x=1741859056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoDVmzMkKNOHCOAEkEWbxwwYdyhsPDeYQQkLswcEOWg=;
        b=MDCVvcbcocTiKJ2l81EKmFHi0z8+7UrYdN6tOzH1S58eQ6ViPsfIHXklvJM0VEDE/R
         WVLv37sMYILxIScOZqoOFCWPV49tDKyrsS7RFeD5p+Rgk1uyOhNcSSlZzDBrEHjY5dTO
         +2HyloxdzCUdYfH9toHnaJnE3Cj1axFnNdFBAL7Tosj8vWYpw716PI2gpy0afRruEqSC
         Nii9ANpx3RDB2cbZVYLGYdnVaWiLEv8/trocsBYHNmhBpDJ+/qB23PHlr49lm1EcS42a
         m/aNT6lfvHcByGqdz3jzSdaE9nGpYpIyg1vhYlSnnaj71rJlBZL7P01sZT8VJuXauPhq
         B2ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhx4qp+PcE0gRmhF4S7Qq2xVhBaQrN6IeHgxFDNeuWuweLPMr+SpgiNEUbi27nuu70HKkT7bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNeSCsWebEB06utRuSKodEZCWNEchA33mMt8cHRAHtxx7aofE
	Qz+8nlTJ3R7WjLBjAU4XSigABzjJU2PS6+eOoDpK0Y1zDre3T/tR
X-Gm-Gg: ASbGncuI+9soRDhSlKaY1AiooT3gucl0oll86p3nCeJWZt3yeQVkitjw6QMnxrLAe/h
	++455VlWC1M3OVgBYkLLik5NN68eM4y5cNpe9MTQHbI3CRczw5x9c/6aOCxLui6IT7GXgfzjQr8
	5MGmMYsKh7vR3O6tL+L+WToM097Zx1W2cO+zput9PcCkifQJztpfrRPWqsvp6ZPrPRmb5I4kTzj
	XP0sTwLt3GPmzhqazU26XMeBcAN79KNqyCx64HitxpCmNu8TynieT1t5KiC6r2jqaKkkPs1JmCG
	i9Sie5QN8Hk+jj8mqRpbjtkFH6AsFBLzA21DRG0GGs2qrGtt6mHLWEI=
X-Google-Smtp-Source: AGHT+IFxv3BtYiIiQ66UvRlNbCoDHRKsWxF4/Se9O6aSCZjDKGGPdqrlNBu9pCNZi9NMXBU/kJkUBg==
X-Received: by 2002:a05:6a20:244c:b0:1f3:3ab7:cf29 with SMTP id adf61e73a8af0-1f34944b65amr13097939637.3.1741254255944;
        Thu, 06 Mar 2025 01:44:15 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281287d78sm802997a12.74.2025.03.06.01.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:44:15 -0800 (PST)
Message-ID: <76a11baf-e3c1-4b83-bc53-73b74fe1b8e9@gmail.com>
Date: Thu, 6 Mar 2025 18:44:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i40e: fix MMIO write access to an invalid page in
 i40e_clear_hw
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
References: <55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com>
 <5cfd4c17-71a8-4bd8-972b-31fc0634f518@intel.com>
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
In-Reply-To: <5cfd4c17-71a8-4bd8-972b-31fc0634f518@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25. 3. 6. 16:59, Przemek Kitszel wrote:
> On 3/6/25 06:25, Kyungwook Boo wrote:
>> In i40e_clear_hw(), when the device sends a specific input(e.g., 0),
>> an integer underflow in the num_{pf,vf}_int variables can occur,
>> leading to MMIO write access to an invalid page.
>>
>> To fix this, we change the type of the unsigned integer variables
>> num_{pf,vf}_int to signed integers. Additionally, in the for-loop where the
>> integer underflow occurs, we also change the type of the loop variable i to
>> a signed integer.
>>
>> Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
>> Signed-off-by: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> 
> when Alex said "make sure I signed too" he meant:
> "make sure the variable @i is signed too", not the Sign-off ;)
> 
> (please wait 24h for the next submission, and also put "iwl-next" after
> the "PATCH" word)
> 
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> I didn't signed that either

Oh.. I totally misunderstood the comment.
I apologize for mistakenly adding the sign.

>> Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_common.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
>> index 370b4bddee44..9a73cb94dc5e 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
>> @@ -817,8 +817,8 @@ int i40e_pf_reset(struct i40e_hw *hw)
>>   void i40e_clear_hw(struct i40e_hw *hw)
>>   {
>>       u32 num_queues, base_queue;
>> -    u32 num_pf_int;
>> -    u32 num_vf_int;
>> +    s32 num_pf_int;
>> +    s32 num_vf_int;
>>       u32 num_vfs;
>>       u32 i, j;
> 
> It's fine to move the declaration of @i into the for loop, but
> you have to remove it here, otherwise it's shadowing, which we
> avoid.
> 
>>       u32 val;
>> @@ -848,18 +848,18 @@ void i40e_clear_hw(struct i40e_hw *hw)
>>       /* stop all the interrupts */
>>       wr32(hw, I40E_PFINT_ICR0_ENA, 0);
>>       val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
>> -    for (i = 0; i < num_pf_int - 2; i++)
>> +    for (s32 i = 0; i < num_pf_int - 2; i++)
>>           wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
>>         /* Set the FIRSTQ_INDX field to 0x7FF in PFINT_LNKLSTx */
>>       val = eol << I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
>>       wr32(hw, I40E_PFINT_LNKLST0, val);
>> -    for (i = 0; i < num_pf_int - 2; i++)
>> +    for (s32 i = 0; i < num_pf_int - 2; i++)
>>           wr32(hw, I40E_PFINT_LNKLSTN(i), val);
>>       val = eol << I40E_VPINT_LNKLST0_FIRSTQ_INDX_SHIFT;
>>       for (i = 0; i < num_vfs; i++)
>>           wr32(hw, I40E_VPINT_LNKLST0(i), val);
>> -    for (i = 0; i < num_vf_int - 2; i++)
>> +    for (s32 i = 0; i < num_vf_int - 2; i++)
>>           wr32(hw, I40E_VPINT_LNKLSTN(i), val);
>>         /* warn the HW of the coming Tx disables */
> 

Thank you for reviewing the patch.
I will correct the patch and resubmit it.

Best,
Kyungwook Boo

