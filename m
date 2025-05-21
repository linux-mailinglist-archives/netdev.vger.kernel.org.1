Return-Path: <netdev+bounces-192265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC164ABF311
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF3816E519
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541872641E2;
	Wed, 21 May 2025 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2XJI3ZD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858C239E79
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827565; cv=none; b=QVo0c4S72ey9uIzca3XZ2JFKCM/7X3CblwUfnrJAXHo9qGUoF9i1TCpij+LW1DIzKgV7BGrV38a4KDspKzxxhJ/9b2N2Sjgb1DX8I5RmF6EvRdD/sPOzLeVcusssCpALCRvYATq1r09FTH41yoo60c5/R1nGXG0qNPh4914A5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827565; c=relaxed/simple;
	bh=ZCZ2aJ1b5eMSWudl4vKU4ptaYuhCrY9+6o62fv7wrhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv9cmN2zHvGESZ8eVMDkwa12dXcBj9ihcPP3nPFIlHSlSMZZn60qNBhKyOBng1TO2IxmDgtL3cj+EYyNCEOpi7ZlIol7lq1EtbiFFLZ+L4DIEd3L6j3dNaMsssuxAjawXQ2/kHrP2zvGrTiktJLj1t8B/NJZ7eK6yqQiy2uWbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2XJI3ZD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747827562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9KOOfsW+8OgloJMhG+itfRoJTQZ8+HhBWqoWSniyY4=;
	b=Y2XJI3ZD4OVe3LspiKXmZIX4GIv0yHPtcX9uhQ45j4ByJlFW44y0m5qzGZuUrIbzz2s6g8
	T53RnzF40KE8KG3FXigqeGkK28VQX2XGS6gBZyMXjX9F/0mo2ZCzqOi4A+k9fMhZHeVXCQ
	4mW2zXhWVF7lnlZi0suK/Nb29/3eLkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-SfctiP1rNBq7bibb59yxmQ-1; Wed, 21 May 2025 07:39:19 -0400
X-MC-Unique: SfctiP1rNBq7bibb59yxmQ-1
X-Mimecast-MFC-AGG-ID: SfctiP1rNBq7bibb59yxmQ_1747827558
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a362dcc86fso2049297f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 04:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827558; x=1748432358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9KOOfsW+8OgloJMhG+itfRoJTQZ8+HhBWqoWSniyY4=;
        b=EtPlC91znf21GshCd1Xyr4vIxRZGfIdD5YoyH2sRiOHfHgnNT0xoTY0MVsvNcV4WAy
         CBIMKSzevbuk1KARp4u2rnF2NegRp1ZmwyeLsKvGEMKuHsEyxJpP+pFaAJKBGPIlFam/
         vjTSyj8lETGHLRuiM9EzCj67cR2K1W1rKTPuEpf3PpFGO8AB3U0M9h0aJgmytpLCDKvJ
         xXmJbamULb+Ruh+j3d7FKoFInHXV7/T1g94go8j5feqQIWbzHClX3OrxiGlPh8RM/pGw
         dLE8jwMBXB/qnytWXlylnnQok5tJuFXFCwQ8AhXL6C6g4fQoBpCr3170kd/BDm7smUKc
         wMgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRyM3Bxqt6LSnG3MVsoAM32wOrt9D3Pa7LQl1XP+okScipySjBELRTTsTUTKjT89pUBGjyOgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMzdbn1nYRqlk6HwOu7EA1uXa2PfBaDYWmAUEsi22DruzuMsJ
	HKFNsw8OJ2EdQoPclalISEMy1f7Nye2cp9LZp+lAznEazCrHilFLHCpgNKwtJGWu4g5B+P4KX5Z
	BuO2IOdEBIyuwQR+sch1HcAulvQWnC+deYb5IhQRmfxIzWCp8xdjbI8cmnw==
X-Gm-Gg: ASbGncseWUBRMCIP/FBrSznAbq3xBewhixCDGFCozxGEh7VXEmMAprTNehG1hKCYbys
	a1pkLiu0KkilLy/PNzOsiLGFMa7HzzRm/GKenUJbb+wHbfWh9oiZtQwOoGReTLRtctja+Oc61ah
	IgReNdE5YRemcCjUW3aO+nSj6P514BpxBv2dTEr0Z2boRiYJBcQ5+4G75LGWeGXRiD5DmgYIzUA
	NcZ39YxlEXGg35Vw4WIcKMpSl72mNVwhBCQii8yNqVNFAEV0HQglk8fzqlKzPo7ys9AgJLERlYl
	OOUNGlnbZbh2KBXE1L4mxwXuayxeJy71lavh8/7UIeE=
X-Received: by 2002:a05:6000:2dc6:b0:3a3:779d:5f42 with SMTP id ffacd0b85a97d-3a3779d5f61mr6318198f8f.3.1747827557909;
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxQsTXZ+Ts2cIK3EuR4b/M12UVesyDgK3ufrotSRgReR+EMMzUPKugbn4ggPlauNfM02nRYw==
X-Received: by 2002:a05:6000:2dc6:b0:3a3:779d:5f42 with SMTP id ffacd0b85a97d-3a3779d5f61mr6318166f8f.3.1747827557508;
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
Received: from [172.16.17.1] (pd9ed5a70.dip0.t-ipconnect.de. [217.237.90.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d224sm20072118f8f.12.2025.05.21.04.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 04:39:17 -0700 (PDT)
Message-ID: <96837efb-63ac-4191-8e2a-4785672c8d7a@redhat.com>
Date: Wed, 21 May 2025 13:39:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: can: Import tst-filter from can-tests
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <dac10156eb550871c267bdfe199943e12610730b.1746801747.git.fmaurer@redhat.com>
 <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
Content-Language: en-US
From: Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAMZ6RqKmPD+BZkVC1C-vn7hcAVdQr8Qhd6PW8bASZiQkD6MV-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 14.05.25 11:47, Vincent Mailhol wrote:
> Hi Felix,
> 
> On Sat. 10 May 2025 at 00:07, Felix Maurer <fmaurer@redhat.com> wrote:
>> Tests for the can subsystem have been in the can-tests repository[1] so
>> far. Start moving the tests to kernel selftests by importing the current
>> tst-filter test. The test is now named test_raw_filter and is substantially
>> updated to be more aligned with the kernel selftests, follow the coding
>> style, and simplify the validation of received CAN frames. We also include
>> documentation of the test design. The test verifies that the single filters
>> on raw CAN sockets work as expected.
>>
>> We intend to import more tests from can-tests and add additional test cases
>> in the future. The goal of moving the CAN selftests into the tree is to
>> align the tests more closely with the kernel, improve testing of CAN in
>> general, and to simplify running the tests automatically in the various
>> kernel CI systems.
>>
>> [1]: https://github.com/linux-can/can-tests
>>
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> 
> Thanks again.
> 
> I left a set of nitpicks, I expect to give my reviewed-by tag on the
> next version.

Thank you for your feedback. I'll post a new version with the changes
included soon.

[...]
>> +FIXTURE_SETUP(can_filters)
>> +{
>> +       struct sockaddr_can addr;
>> +       struct ifreq ifr;
>> +       int recv_own_msgs = 1;
>> +       int s, ret;
>> +
>> +       s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>> +       ASSERT_LT(0, s)
> 
> 0 is a valid fd (OK it is used for the stout, so your code will work,
> but the comparison still looks unnatural).
> 
> What about:
> 
>   ASSERT_NE(s, -1)
> 
> or:
> 
>   ASSERT_GE(s, 0)
> 
> ?
> 
> (same comment for the other ASSERT_LE)

I was a bit hesitant to change the order of expected and seen value for
the the assertions because it's documented as ASSERT_*(expected, seen).
But it seems to be common in the selftest to not follow this order where
assertions are used for error checking and failure message doesn't
explicitly say what was expected/seen. I'll take a look at the error
checking in the whole file where the more familiar form is with reversed
arguments.

Thanks,
   Felix


