Return-Path: <netdev+bounces-178739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF22A7899F
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30F116C70B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC79B233728;
	Wed,  2 Apr 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+GDR3SW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8C233D7B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581707; cv=none; b=slLQBbbgjZNg0aCXVizT4eBR+ZnVlXfc/oQ2qwPN8eM9x5XEXMYCm4fdwGXt/mw+HRWu/ql5kxfwazXLGold7z4UNP0GSZ9hhvZQfH944SfpLxwIcaITgXhOJv8TGRBg45/f5YSj2281nXz8XrJ+h/Ku5Jwd8nOYtSRIYZtQcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581707; c=relaxed/simple;
	bh=bvO2iFa/2lgFG76PsRacW3COQAh/r61vBzOyM9qnNnk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OqC7aNL3II4Q4lfNEvevv4PdNPG7ColkTZnKa5kdGLEbtiRBAoEfhnyufCiVbwxOdTpObbzOEUk3/pKvLqmGJ6NkrqEpQ6+nEbFG8AYXXYuZV18xDh+gGuVmUpHGOcnEoih3EneI+SvMvOKjVejQhgQGl6NO6SFavNkDDE3seh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+GDR3SW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c0dfba946so2761444f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743581704; x=1744186504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShQmyeswstC0n/v3CC2coyqSTfNE3iKp1r+W+k6UCAk=;
        b=K+GDR3SW/v4xw/TgejOuuBUHqSXQzMnV/wUQnbpqhDiMZj9BdH3HEHY4aToUb2gPQs
         PTRtFbDhn61AVcBYSZRtMbc6/XfEGWuXzyteE5VpsHO+h0A47BXTYkUPlN/AbinaShl8
         rmDaD6EOQESzFwgWJ7WsofdoVPezVNLq++c33z/30HSheKv9Nd8h7T8TXdJPWHOlk5SO
         a7j26bHYOTGjDtExtXIOZkL8R6qm9hxKlI4rXYaBokpoRDLV1aT8i9Gu21Ul+gd1eKF/
         e7OLHwyc0IDtDP2PBLwqsj4kH3Nqe1SaH1ttHfJvgkV+Iwc1hGcETr6lFOqT7r4J9TJY
         a2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581704; x=1744186504;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShQmyeswstC0n/v3CC2coyqSTfNE3iKp1r+W+k6UCAk=;
        b=YZ5HY5RchpbxQAL3hbzJEbj1x6eq2W37fXnOIpVpcmZ+BJ0gmJqmjZthTg7yQp6Fr9
         BtHvcES3alvHceq7nK4Cur5XVcYVUrcHnWnYwzSrl4CGKWSDsmW/tPHeOmfp4H5k2/fn
         ShWgHhpAatkUpO9CWSw7E8/tOqrSob1F7PZwvQrzX1UUPLP0x1+ngBpvdMDPZLmVOQOP
         9CxV6d8Gu1HGB/OWS6fQqYe+crL5MF6ThdRYi5Ot4yQV4Fh8mjftaL2XKtz7EmLqmNbv
         Xvnw/S6a9XXzPaM6Qfht0btk6fvGecyx9XbyzrW80jBr++Nhi+nH0YqETuYPRgM9pEjM
         IxLA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbGuUWURPoBq2GT1iMabIrEyUyqAdPouzKkUO1fNk72ue00slHlGxSlRg4n25tUcPqakNE3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dykChaBXmkvc4yff1rCUVVu8E7x27TOmy99bIVfE4Vym9E6p
	mJdhYrUYSU2s3B9kbNQatyfzNqv740ERkrYQiQWRzC9ekuD4NqXn
X-Gm-Gg: ASbGncuJT7eSgsC8XlgWwIYw7UsvpjMBip0lpe9dSzYv1sY8U6/IMn1kgKQalLdIxBB
	6FeSiAWDpZUhOMI2mnHtVF9V8DSN6B3DuhmJp3H9oqKZcMSZqQYqXLiCl0ccNdRaHEdxjcVwgBr
	BtgNLVKt41/OMqkveu8/VuyEQ+Gant8SoFVo0XbhHKKPIssuiQPV05xBLtg0Zhk+jeWZRQUVl51
	0g4g/vGCR8Mp2ZH7Nr7uIW8cYd7iTPA+R55wSOddxNTJDX6uWxtyTx3LI8swk9nYJXEfXfaVPfq
	JJayY2sbVCQzWPNMEi/c1xPadJbsHdMYh7/oDlC/+FawjWnj8EwTCy0+rhWy+bdd+FMkqxC9SRs
	FdmKq5CV+x5feO1TGn4x0dWgRBnEpuzUC69afDks7L0Y=
X-Google-Smtp-Source: AGHT+IFwS0c8k/hxSisUYrpq3aKT5VDKZknRzs+/5VuFDOolBNXcjorTDqxK5dBjJWhEXi9jRN9wWQ==
X-Received: by 2002:a5d:47c6:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39c1211d5d6mr13682159f8f.48.1743581704322;
        Wed, 02 Apr 2025 01:15:04 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66285bsm16036047f8f.21.2025.04.02.01.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 01:15:03 -0700 (PDT)
Subject: Re: [PATCH net] sfc: fix NULL dereferences in
 ef100_process_design_param()
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Kyungwook Boo <bookyungwook@gmail.com>
References: <20250401225439.2401047-1-edward.cree@amd.com>
 <Z+zITLJ4wB2Mhk8h@mev-dev.igk.intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <98a26384-5d6f-d5d2-3ecc-1914a74299eb@gmail.com>
Date: Wed, 2 Apr 2025 09:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z+zITLJ4wB2Mhk8h@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/04/2025 06:17, Michal Swiatkowski wrote:
> On Tue, Apr 01, 2025 at 11:54:39PM +0100, edward.cree@amd.com wrote:
>> -	netif_set_tso_max_segs(net_dev,
>> -			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
>> +	nic_data = efx->nic_data;
>> +	netif_set_tso_max_size(efx->net_dev, nic_data->tso_max_payload_len);
>> +	netif_set_tso_max_segs(efx->net_dev, nic_data->tso_max_payload_num_segs);
> 
> Is it fine to drop default value for max segs? Previously if somehow
> this value wasn't read from HW it was set to default, now it will be 0.
> 
> At the beggining of ef100_probe_main() default values for nic_data are
> set. Maybe it is worth to set also this default for max segs?

As I read it, ef100_probe_main() does set a default for this nic_data
 field along with the others, and sets it to exactly this same value.

confused,
-ed

