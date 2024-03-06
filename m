Return-Path: <netdev+bounces-77974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC7873AAE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378E0B208DE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C51350C6;
	Wed,  6 Mar 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="d+3OYhKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08C7FBBD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739054; cv=none; b=sKXSCijL8YbJloIr90LIAPp3g/N2grhx5PzzFkTH1u7Ab+6bvZJaWin8jEhM65kJ33bUfezAzoeF8KkF208vw+++vuCg8XvERrC4BTZY14pIdm9SMlJBQSS2qFMXIPS1HTlxmEwVoz2ekZXrkxy50GmN1tErlBVutnPqRLiBjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739054; c=relaxed/simple;
	bh=2+qaUSLGHOnZ0UEDP/W0AcOAmnAaie1sUkRN19UGt2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpBGYThy7Dbfzq9RZy/JWPdVejHk8Sc8UBeni1FbSvGwl6XtLWL12rMUA6ZUOEf5WMnvQdd55dIo3N/p5nfJGEtGHYA67i7BI3xvEttOESYg6BdATf8cU5dLWOQYu2IuOohtymONWa8tFz2/gJkb8ruZKSypvzjJE7MGc6630bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=d+3OYhKS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso9330979a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709739051; x=1710343851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82Ehdepy7y3ocqXPKl2WoMakc0rHqN/WJxyAo+5MaRc=;
        b=d+3OYhKSUwEx18i145icteeS1zOvAvq9CJKj9ZCFwNyhC7vyzUxTgXzIQ9BQ+JKz2V
         Q5fmBRbwVq9jRRgeqFccmsejHWrn/2G3vIWzw14dbB2x/tlG8rvLE/+8oHgvX2hIivQV
         ksMSA6XHD6cIXTKgJPwqhMK5CkG2XFhB1XSjm88G4XZXjod8eSvNd6dcOwhKYHou6tgv
         a4WMv8IJXCh9a1pTJvfHo6GTbip9eGQCXGZoEVpWQDmGDQzSR7pUtH92faKYKXkmp0Qs
         l9J/07lNfw39nvb1wJ3PeTI8M07Zj/IxeDZe3Y+Zb5ikPEhYzuiFYk7ioOREG7qd4kuc
         KllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739051; x=1710343851;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Ehdepy7y3ocqXPKl2WoMakc0rHqN/WJxyAo+5MaRc=;
        b=QfuhFvPTJkPugXIaNWfnE95+nQilGcmN9+PcVqeBi+Bje+mqczR7fTwfjVrtcOCakx
         y3+X1X8d0yHAWSgiy33AgZBgPGjH+89TFujGbQbk+sv926Jr/f6TdmtvuQ4mrE37/Vzd
         9vfFDL+oVWUAkM1t+cZUMmc6JfsegxCSmI668Hr12PmCCSwYKtc8liuXbCDPM6PybNHn
         BK3q6EEEL5eEWWjV7wVUVi1a9oqq82MnC9OPI4cKgBAFXpXAMwVPV7WCmAqnq2ufmUKT
         nNqDv4gf3DAOd+6XikOtnSLJ4FN+5wLDN1V/9P/uBsN0ZufpZCMqr4sax9eU4kJR4zMJ
         5FhQ==
X-Gm-Message-State: AOJu0YwwHFfpkB7FPSxSlYDjPfZWzyXs9EdGO2Ys4Nq/pgvzLP1iynaC
	bTPfK2Fkg0P1qYYMGssRNF0fucTE9AvHlW+4IYh+tbu1zaKAgKjxKCSdkolHItonV3sPkDcwlNw
	j
X-Google-Smtp-Source: AGHT+IFxUJezuAZJeQ6vpW3G+VolVhIMz2vTKuOssKYUTZdhXr303ZUl1SBMOty4QXrnYtYUqirI0Q==
X-Received: by 2002:a17:906:fb8c:b0:a45:a7e5:fb98 with SMTP id lr12-20020a170906fb8c00b00a45a7e5fb98mr4072097ejb.27.1709739050663;
        Wed, 06 Mar 2024 07:30:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id f9-20020a170906560900b00a449076d0dbsm6082024ejq.53.2024.03.06.07.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:30:50 -0800 (PST)
Message-ID: <3ac53079-28c1-4032-a251-c792d2d35383@openvpn.net>
Date: Wed, 6 Mar 2024 16:31:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/22] ovpn: implement TCP transport
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-13-antonio@openvpn.net>
 <20240305151203.GL2357@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240305151203.GL2357@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 16:12, Simon Horman wrote:
> On Mon, Mar 04, 2024 at 04:09:03PM +0100, Antonio Quartulli wrote:
>> With this changem ovpn is allowed to communicate to peers also via TCP.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
>> new file mode 100644
>> index 000000000000..d810929bc470
>> --- /dev/null
>> +++ b/drivers/net/ovpn/tcp.c
>> @@ -0,0 +1,474 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#include "main.h"
>> +#include "ovpnstruct.h"
>> +#include "io.h"
>> +#include "peer.h"
>> +#include "proto.h"
>> +#include "skb.h"
> 
> Hi Antonio,
> 
> this breaks bisection because skb.h doesn't exist until the following
> patch in this series.

I must have overlooked this - I normally check that every single patch 
does not break.

Will fix it, although the whole ovpn code may just be merged as a single 
patch at the end.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

