Return-Path: <netdev+bounces-126542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58160971C2C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C71F2348B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08DE1B9B5D;
	Mon,  9 Sep 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ryg7Xlrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9B1B253B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891128; cv=none; b=XevIsp4evuUetLguxKZeQF5xKI6+ptCuuqZz+SxVB48RZbVTZaam3m21mOBls45oeHqdbBymqJakpDTI6XXpdwtg6/f4aH8x2gNB0BTQD7Ak304WR7DICkkHelDmlc8k8Dh8qVoxq9M3pIYeOjXdvrFJSLDaAAusK8TWeNfjGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891128; c=relaxed/simple;
	bh=O5mfNZNWSQmslDQF0bAUnxAXLgO4SbI7QMmeOs47dXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2YYRsVOgGYSXHz/KyNaAfiwjIfrQZg/yGjdQJcdoUrOiFtl88zg2Fy5c6Lf7HaT2vEXqhI+fp/g34NQ0Ohbzjs3Em4bHh605LpQaV2roIOw9Kt87QJJv6Dj1ONY9mNWkbgL97C6g/f+YCKJRg/uq8hC1rA7DwBOxxCc+0tVLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ryg7Xlrl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8ce5db8668so447208166b.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725891125; x=1726495925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnorMDFGC3qoYvnxYe1wEVF9t4iL+NZnyOqDkPmCA8k=;
        b=Ryg7XlrlpnJzXdiISEXHrgLX9iEczkPSSwuhuJ4yp7xPFPvNOdPY1o5KJsEjwxGReP
         acDmxN5L1ZyoUrE/qz0WbGtZs+kBbrU3Qdp2IJpI+x5CvxqNvUmkpDpMzxY6Z4No1cbk
         YQa/Gf/U/L7kVC3wmdWJNjriEe/0QvnokGq/g029/T4zGpyE4SKFyLRt7pEmUNj3CuOt
         fHqSDVKJfRdzKdDN5rXPTWNaZOAGyXIip304312GAzdaAym5J1XZRuT0wXfB5XNp7+nm
         8n6og5A7AzBXyNVdxwX3rbH58nm3HPnIEU1N3L5DJ/sYMo785Fvk267kmPEBuevGdNLA
         Xpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725891125; x=1726495925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnorMDFGC3qoYvnxYe1wEVF9t4iL+NZnyOqDkPmCA8k=;
        b=ZxTxqr6L4Dk2tgYFKy4GmszbVFxlH5gexO5g9gQ3f4N0IVSfQ0bgHI6df683gzpm7x
         8jRwpr7jBsVi6pokC5LWT8HnoLooDbet5LH0D8nkAv9eU4+zrCer1A12odXIVL3AcKET
         TO0sSet8h2SkhBSFTbvyN0h2yF44s4GDHSfj4TIZjK3PL3Q0hy0CVByqC9b6LJmGQt9W
         CAz4VQg/nVcDfSqFqoRDTSmlT3HSQKHjNiAfetgu1rEyvAQBvYG6HBRV6Qq75b5/NnEf
         oEX/poNeZn5TXPi9VSQk3EmJ6rqsWfMKb8JbdkG41Fy+mTvtpsl0gSzxHY0RA/N3mp7T
         7ulA==
X-Forwarded-Encrypted: i=1; AJvYcCVU3iMPhqxEPybZZTcI3LhkKhBzVlqtDaZQlxCLX4E0W2z6dipmr2atKk7P3fgCR59TfwNzj9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxarwyJ4RRJc+PCR6uu6QLqnwvVGe6qzQx8/dlv67jKULI/wZY
	wulPIQoCLVRO7mSTSRkHbKWEb2/isxFfUhja7MFzreaNbYqFQdyWUupULS2STfg=
X-Google-Smtp-Source: AGHT+IH29phGJU3vO43UKI83dtILQ+Spx0NTz0kxCvYMdA/X9OFUY6W0pz0jqNQ7j3qvtJpnAYSdsQ==
X-Received: by 2002:a17:906:4fc7:b0:a86:4649:28e6 with SMTP id a640c23a62f3a-a8d1cd64171mr882855266b.57.1725891124481;
        Mon, 09 Sep 2024 07:12:04 -0700 (PDT)
Received: from ?IPV6:2001:a61:13b3:9201:e68f:3bce:663e:dfa9? ([2001:a61:13b3:9201:e68f:3bce:663e:dfa9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72ef7sm348459066b.106.2024.09.09.07.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 07:12:04 -0700 (PDT)
Message-ID: <7114bb16-c7cb-4521-aec8-51e35abaa00b@suse.com>
Date: Mon, 9 Sep 2024 16:12:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] usbnet: ipheth: prevent OoB reads of NDP16
To: Foster Snowhill <forst@pen.gy>, Oliver Neukum <oneukum@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240907230108.978355-1-forst@pen.gy>
 <mJ-iCj-W_ES_nck94l7PueyUQpXxmgDdxq78OHP889JitvF0zcid_IBg1HhgEDh-YKlYjtmXt-xwqrZRDACrJA==@protonmail.internalid>
 <8510a98e-f950-4349-99bc-9d36febe94d3@suse.com>
 <4be673c9-b06a-4c2d-8b27-a1e91150df94@pen.gy>
 <6BnH4O2XKc10y5baGCbmsK5bvKjVwAwL1qcdUy2GYc06i5huflew3Mx9mf34yv4GUipEkyvF5kCYDT8WMaZ3xg==@protonmail.internalid>
 <d15bc43b-f130-4fd1-a758-b19b2dc99d46@suse.com>
 <3d5a69be-2527-41cd-b3f2-28ae86084ee7@pen.gy>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <3d5a69be-2527-41cd-b3f2-28ae86084ee7@pen.gy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.09.24 15:39, Foster Snowhill wrote:
> 
> usbnet: ipheth: prevent OoB reads of NDP16
> 
> In "NCM mode", the iOS device encapsulates RX (phone->computer) traffic
> in NCM Transfer Blocks (similarly to CDC NCM). However, unlike reverse
> tethering (handled by the `cdc_ncm` driver), regular tethering is not
> compliant with the CDC NCM spec, as the device is missing the necessary
> descriptors, and TX (computer->phone) traffic is not encapsulated
> at all. Thus `ipheth` implements a very limited subset of the spec with
> the sole purpose of parsing RX URBs.

Splendid. Perfect.

	Regards
		Oliver


