Return-Path: <netdev+bounces-238147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F9C54A8F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45CED4E20CA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1AF2D7DE2;
	Wed, 12 Nov 2025 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzl19eoj"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F2E7BDF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984355; cv=none; b=D9K/FekxwFQTxMdmiCcELbQy97hmi712o+ojsXmYa3NSxP4KUb+xumzzGfEQ8SwoylkcA1mVhck0SotO1eNTZjQvkHYrJwO+hyOD1PXhNCKN+dHqUcHEzCSTB9ejFrL3n26wKPqUmtJjJVkPdVMi9MPZu6NB2GeKSY0tn443HAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984355; c=relaxed/simple;
	bh=eJOZTJq2+oQmdJH8pJU2buDGVe5UizvYAN/062DgeDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1Me6f3qfG/LQGCqJrErQzFtFtiTEuNJc23yELu1/vbCiClX+k0XaajvOHExxy9JeKz2303CS8r3XzAWwBABTW7yqxuG3Uby/RNMeK4Vz6USniBqWxozZbR1jJbyCuAgQEvb3/RbNVM5s0CUyE6e84Y0ajl5VW+6cJGYjPo0HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzl19eoj; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e73e0e22-ff06-4e64-a2fd-c930ca1943c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762984336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sA0/GOtiqtvKxJBnC3sdby934G85/g09THmVfQyevd4=;
	b=vzl19eojHa96bSiblkZWGnwDJ1zSohI/RK7glANwck3X1pWD0jcUjsdAQVx7k6dMKyRa7p
	rIiVhmtdT498wsUROuuIom+0BpkWuatjh/4G6tL+NiFOzJXIO9bGYilLKpHup+uBk75SIp
	/acy5uw2BP6154LKSZaHqiXk1zjXUhA=
Date: Wed, 12 Nov 2025 21:52:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/6] dpll: zl3073x: Store raw register values
 instead of parsed state
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251111181243.4570-1-ivecera@redhat.com>
 <20251111181243.4570-2-ivecera@redhat.com>
 <886723c3-ff9e-43cf-a1da-021f1ff088ab@linux.dev>
 <45a93065-eaaa-4b18-90e0-e1d9cceb91b4@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <45a93065-eaaa-4b18-90e0-e1d9cceb91b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2025 19:24, Ivan Vecera wrote:
> On 11/12/25 3:12 PM, Vadim Fedorenko wrote:
>> On 11/11/2025 18:12, Ivan Vecera wrote:
>>> The zl3073x_ref, zl3073x_out and zl3073x_synth structures
>>> previously stored state that was parsed from register reads. This
>>> included values like boolean 'enabled' flags, synthesizer selections,
>>> and pre-calculated frequencies.
>>>
>>> This commit refactors the state management to store the raw register
>>> values directly in these structures. The various inline helper functions
>>> are updated to parse these raw values on-demand using FIELD_GET.
>>>
>>> Reviewed-by: Petr Oros <poros@redhat.com>
>>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> ---
>>>   drivers/dpll/zl3073x/core.c | 81 ++++++++++++-------------------------
>>>   drivers/dpll/zl3073x/core.h | 61 ++++++++++++++++------------
>>>   2 files changed, 60 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>>> index e42e527813cf8..50c1fe59bc7f0 100644
>>> --- a/drivers/dpll/zl3073x/core.c
>>> +++ b/drivers/dpll/zl3073x/core.c
>>> @@ -598,25 +598,22 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev 
>>> *zldev,
>>>    * @zldev: pointer to zl3073x_dev structure
>>>    * @index: input reference index to fetch state for
>>>    *
>>> - * Function fetches information for the given input reference that are
>>> - * invariant and stores them for later use.
>>> + * Function fetches state for the given input reference and stores 
>>> it for
>>> + * later user.
>>>    *
>>>    * Return: 0 on success, <0 on error
>>>    */
>>>   static int
>>>   zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
>>>   {
>>> -    struct zl3073x_ref *input = &zldev->ref[index];
>>> -    u8 ref_config;
>>> +    struct zl3073x_ref *ref = &zldev->ref[index];
>>>       int rc;
>>>       /* If the input is differential then the configuration for N-pin
>>>        * reference is ignored and P-pin config is used for both.
>>>        */
>>> -    if (zl3073x_is_n_pin(index) &&
>>> -        zl3073x_ref_is_diff(zldev, index - 1)) {
>>> -        input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
>>> -        input->diff = true;
>>> +    if (zl3073x_is_n_pin(index) && zl3073x_ref_is_diff(zldev, index 
>>> - 1)) {
>>> +        memcpy(ref, &zldev->ref[index - 1], sizeof(*ref));
>>
>> Oh, it's not obvious from the code that it's actually safe, unless
>> reviewer remembers that N-pins have only even indexes.
> 
> Would it be helpful to add here the comment describing that is safe and
> why?

Yes, comment would be great to have.

> 
>> Have you thought of adding an abstraction for differential pair pins?
> 
> No, zl3073x_ref represents mailbox for HW reference... Here, I’m just
> following the datasheet, which states: "If the P-pin is marked as
> differential then some content of the mailbox for N-pin is ignored and
> is inherited from the P-pin".
> For now, the content of zl3073x_ref is the inherited one, but this may
> change in the future.
> 
> The abstraction for differential pin pairs is actually handled in
> dpll.c, where only a single dpll_pin is registered for each such pair.
> 
> Ivan
> 


