Return-Path: <netdev+bounces-172784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD4A55F3D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 05:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CF71894D51
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8B1917D8;
	Fri,  7 Mar 2025 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsBoASHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41418FDD0
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320631; cv=none; b=pkDdgSDUVXCDFXkHoCCHlyW2OVmm7RRCcQzl3nrUnFFoKp+2GsPoqAxQhEj7pDPKB5rzFPXvZymz04eeMup8Kx4cWU/zqz86/vznwVBMqFJm1wEEYDAIADliMt4/Oxg8VUZjGHfiduKJw2tx2CkqEzdSMVqg/Lp8f5pnWxoO8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320631; c=relaxed/simple;
	bh=Nmd1PS93WZuCYLcukwYp4oImNnTwC3HA5IqmcAXp8Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOuB1NRLji2kmXTd1bl/V/Ajol38vdkOojvfXaW+j1HEBIIV9kyoqLjVFdXQ6SPqo5iLYhdyR78kYwsYD11zMK16Hs9odiDn8A8ppTX5VsPDoi7qMQc2z1F73uNw+hCBkrD9yr8sM2OvOvRn1b/vnfszEGrWkQBsqHiFcYSgRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsBoASHQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22349bb8605so27022705ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741320629; x=1741925429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fXcDFEGSPnMsbgCnYRdEXX844+2MM6qjWtz3d2JzlA=;
        b=jsBoASHQ9/zNKUgmYipxL5EZ/+NqR8ZR4Y2Sf7ulOY6UDK8jZUoqTRKbwe8xx0rwb+
         Nimb/+oLpYDRpKmQj0Xn2L0QiOvBqaSwP87rG4ufzFPmel3eGZB7bpS07/V+HrKNW/tz
         H6t0yNV7wNjUAeQr9DlMo9KK2U7KqOtnoZaI41mt/QsJc35E3saArgAfINhY+W8S+gqk
         XOoAzmo4F5A6Ntr+JhWGIcvPCCwBHXNwcNMSTkEXNMms47qTg4ieWhdusxJ6f85ibaVL
         xz8NNKEie9nhHoPsqev6LXAMW3qSheeS8ZGCh/++cNOR1l4nq6Fph6vMGFL0/DILu/7d
         t8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741320629; x=1741925429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fXcDFEGSPnMsbgCnYRdEXX844+2MM6qjWtz3d2JzlA=;
        b=ZZhA2HxMkdNwPneGTR9L4tr2sJoErKuiaOQEnoa6prcUX3hP0JEypJO9PCesqv6ALD
         SQjM7B4L8A8M8dxuKMrHb16kw992YWKvAdyf9yYBhJYI3FRu35AVyrDTlZEF5/WvYtQ1
         yFvCSKUOg88Q2EaUZCOvFeyvNSXC4TtVRjqZzwzBFOZsqwyeknBt3jjTensQu6VIIU9s
         qZ0hatZtDyhmdU6ngVFv0MC5TJOw993TyPk9ZfjXQUAaya0oJAA2jRGmBO7rczC97YD2
         vvr2/zPXs/4PSCtgEJX+ArZdIsaWPH9jvnX1GhAXZ3lMiv+6W0qxtDpeeMXrC0Kkgbb7
         zq3w==
X-Forwarded-Encrypted: i=1; AJvYcCWabGrDc1NKpWn8h04lBOLtAwoo7sDWuns0NSTYnTQUhqEXd6UalPoESopt+FZu00zFYgIeuhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5TaUuPKHKC9kcuuxpPaHKIuKVMziGyi1UvPmAvdh1TZEgDqV
	CGJ7kQM/wPtfHIc029dqcGOsuM34+Rynilf6MUuM+ggRO6mGyEaL
X-Gm-Gg: ASbGnctg6mBb2Ef2subg9WxMVMtxzcx+4FZyM3IApFSEdWUUhHUA2AcNuBgIfN+fI6X
	+bywsbU84mZx0o5Q5bPYyMEGT/HgXX+V6JYQ/lRKn8gwcLlhhT4UAJh7wQiHJdPvqQsa14AW52a
	vJ6KWh4MdLDmoJvEATozOwkQCvYMI4J80GT7cN0cvi6d2Ff/xVNw6BzUGOrq5s5hEsHihwoEBM+
	rHy/3qPSKMhub0Z7//hXh4rY6YcJYe2ZSF8K+PHnYGBZXuxnD1ES0Zz4lGRyOkATW9CHUBFkdda
	WjYGFr0ijDK7wrtZpuWmN9OtSSmNFTyuZuhmG2x5mgJSo1v8QJqNmSY=
X-Google-Smtp-Source: AGHT+IEac9/1hyaB0ji3C+Hy2szAvG66AgyQlxCE/Menh/lmjNj3wFSjdzzjXnpRsq5zg+0zSijmhg==
X-Received: by 2002:a05:6a21:3a86:b0:1f0:e708:56e2 with SMTP id adf61e73a8af0-1f544b1aa32mr4010115637.22.1741320628766;
        Thu, 06 Mar 2025 20:10:28 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698517c64sm2264304b3a.147.2025.03.06.20.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 20:10:28 -0800 (PST)
Message-ID: <aea2c7f8-995b-45bc-b2fb-d45e3fbe65b1@gmail.com>
Date: Fri, 7 Mar 2025 13:10:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i40e: fix MMIO write access to an invalid page in
 i40e_clear_hw
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <55acc5dc-8d5a-45bc-a59c-9304071e4579@gmail.com>
 <SJ0PR11MB5866435852B88603767EFF15E5CA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: Kyungwook Boo <bookyungwook@gmail.com>
In-Reply-To: <SJ0PR11MB5866435852B88603767EFF15E5CA2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25. 3. 6. 20:13, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Kyungwook Boo <bookyungwook@gmail.com>
>> Sent: Thursday, March 6, 2025 6:26 AM
>> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
>> Subject: [PATCH] i40e: fix MMIO write access to an invalid page in
>> i40e_clear_hw
> Please follow the rules, add v2 to the patch

Hi, Loktionov,

Thank you for reviewing the patch.

Following your guidance, I will update the patch with the correct format and
also include v2.

>>
>> In i40e_clear_hw(), when the device sends a specific input(e.g., 0), an integer
>> underflow in the num_{pf,vf}_int variables can occur, leading to MMIO write
>> access to an invalid page.
>>
>> To fix this, we change the type of the unsigned integer variables
>> num_{pf,vf}_int to signed integers. Additionally, in the for-loop where the
>> integer underflow occurs, we also change the type of the loop variable i to a
>> signed integer.
> Please do follow the linux kernel 

If you are referring to the tone of the patch description, I will rewrite it in
the imperative mood.

>>
>> Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
>> Signed-off-by: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-
>> 8c773f6f7095@gmail.com/T/
>> ---
> Please up here versions history.

I have noted your request and will add the version history in the next update.

>>  drivers/net/ethernet/intel/i40e/i40e_common.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
>> b/drivers/net/ethernet/intel/i40e/i40e_common.c
>> index 370b4bddee44..9a73cb94dc5e 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
>> @@ -817,8 +817,8 @@ int i40e_pf_reset(struct i40e_hw *hw)  void
>> i40e_clear_hw(struct i40e_hw *hw)  {
>>  	u32 num_queues, base_queue;
>> -	u32 num_pf_int;
>> -	u32 num_vf_int;
>> +	s32 num_pf_int;
>> +	s32 num_vf_int;
>>  	u32 num_vfs;
>>  	u32 i, j;
> What about this vars? Are they used?

i, j are both used.
I think the relevant line to be considered is as follows:

if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >= i)
		num_vfs = (j - i) + 1;

After this, j is not used and 
i is used as index of several loops.

My current plan was to change only i to s32 since it is related to the bug.
However, i is also used outside the loop, as in the code above.

Should I proceed with the original plan, or would it be better to separate the
loop variable for clarity? I would appreciate your opinion on this.

>>  	u32 val;
>> @@ -848,18 +848,18 @@ void i40e_clear_hw(struct i40e_hw *hw)
>>  	/* stop all the interrupts */
>>  	wr32(hw, I40E_PFINT_ICR0_ENA, 0);
>>  	val = 0x3 << I40E_PFINT_DYN_CTLN_ITR_INDX_SHIFT;
>> -	for (i = 0; i < num_pf_int - 2; i++)
>> +	for (s32 i = 0; i < num_pf_int - 2; i++)
>>  		wr32(hw, I40E_PFINT_DYN_CTLN(i), val);
>>
>>  	/* Set the FIRSTQ_INDX field to 0x7FF in PFINT_LNKLSTx */
>>  	val = eol << I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
>>  	wr32(hw, I40E_PFINT_LNKLST0, val);
>> -	for (i = 0; i < num_pf_int - 2; i++)
>> +	for (s32 i = 0; i < num_pf_int - 2; i++)
>>  		wr32(hw, I40E_PFINT_LNKLSTN(i), val);
>>  	val = eol << I40E_VPINT_LNKLST0_FIRSTQ_INDX_SHIFT;
>>  	for (i = 0; i < num_vfs; i++)
>>  		wr32(hw, I40E_VPINT_LNKLST0(i), val);
>> -	for (i = 0; i < num_vf_int - 2; i++)
>> +	for (s32 i = 0; i < num_vf_int - 2; i++)
>>  		wr32(hw, I40E_VPINT_LNKLSTN(i), val);
>>
>>  	/* warn the HW of the coming Tx disables */
>> --
>> 2.25.1

Best,
Kyungwook Boo

