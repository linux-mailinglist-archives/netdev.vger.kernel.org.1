Return-Path: <netdev+bounces-175688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EABA6722B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048C5188D49D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF072080F8;
	Tue, 18 Mar 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2zdxkYZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC11DE2D4
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295960; cv=none; b=Cw9oaz2GsgFH8DLamcyBBu3t4L4dxaVkG2ZGJMbtU7OTGzFtZ3DQD8ML9YA3s7OPVwnyD2dksgVMHnDaDNwMyepM9ct4VixYCBljzSEPNMtHeylzJB5GyRy13o2HfdR2cP9UJYE5CEPpsTMHoUil1RysylwGuVmRQC0vGoIK6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295960; c=relaxed/simple;
	bh=AIc+byXUQxY2P9Gq+P0dpjQtpV0SboQBC7kxsHtfBwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soCtnG7Q3+4cfDFdzXKs3DT6jYfaJtExjC1rTS0z1UwF401737HEPoJqfQT79tkySWLJDTuxFk0p7ehgAIFJxrvjKs66ZQ4Z8ppYB2rz+A/ZVrqNETw0YMdtt9g3MXvp4HlqCcn88zEIm4azNK1HWZBO5IJTvAl+MFDy4WesWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2zdxkYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742295957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
	b=d2zdxkYZDeC228ac64ioMhLuEtZDTrMqC4DqGi9VnTtOyVZvxtZeTYWHCULse/3cdvY2Km
	zv1MlwGn5RV4AnQQbQ1hkYUfMxs42FHqPHoJgqe5jyHS4sLHeFp2XrMDR7+g3gQOUIN62F
	OK2+3LdTWcnfThIui3ktUeJX0mDcK4E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-t0D7CqzaNROIR3oYE7trSw-1; Tue, 18 Mar 2025 07:05:55 -0400
X-MC-Unique: t0D7CqzaNROIR3oYE7trSw-1
X-Mimecast-MFC-AGG-ID: t0D7CqzaNROIR3oYE7trSw_1742295955
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so22004945e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 04:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295954; x=1742900754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYxupuol3hzt3Y5BwfutJ7GZcSRT1GDccfIhI7TAGlY=;
        b=d4RG1bri6o3IbPbohqih5FneHSF8AdTQ5q+t7Bqkecw+bitPUWjbqNLvrzLjLfq/t/
         vh/HKNoklh7yozlXhGv/SUqnSq2glDSZ6/jbCFl8CEqmjDBAHXaVxWya3RGZzrt58w/W
         A6qzoym6oi6kPpNY5Jr9c+t1O1cPgbvL0NKs3GHvYeQgwqlLpv12lWN9iYGK6OK8oG8p
         hCl6fNPolXtr1PUwba78/w91MweJq4kxiep/6IMdy5vZRvnp1RkaeujMF5Tf1dHKP4EX
         L9iErVQkC7ADJInzwL6uzqiNx1BhOH2TY/J2Vf5ZEyNKxRFeiVLw7ESYmWW0L605dgkO
         8iKA==
X-Gm-Message-State: AOJu0YztRYbYGp1F6FJmLwMwNQVkLLn0xyfGyKyLU+Q6RgsPwNVJTLHT
	DIZmLkgw9tTbHY7CuH1/PN2dMQ6hyACtUVaeRQtCKHGjPUwV7kY5m68Sk0Vpoeeml70SUoYEVhE
	IKbQYyvSPjC2VdrB0LnNwl/JxdCOYQPOmLmhqvloIpeQatcUBXb5pew==
X-Gm-Gg: ASbGncuEBUoZkVOT2G6gp7IAIz6TENcE3hirN0qaNBsZXVZdFi4EwccQbLCLcGDiSp0
	R2JfN5nmtcJUP8oO12/hnmbfpRMNbYkzQbCIBa1ML4UObAz+tSvg1q9Pbmm/xHHrR+8WPTMNYtF
	EyLC6D02EDGxD/vGBuHBKSeZNxeOnFyjCY9wF5WwMEKkEC061y6fEZbYu7yIph45d8OrAJxNivE
	kyxyukZLjLXr+jToNQbMGg/KSDK5XfmTRpIhZkk3oMjqOcYH/4JCXHUzK5sOZDb6x3flAIklDTJ
	sS/jL0qKcNFiZfRnvpL4CS4pcbeW3AM6rw1MhPtZX3X7xw==
X-Received: by 2002:a05:600c:34c7:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43d3b951a70mr16594195e9.6.1742295954666;
        Tue, 18 Mar 2025 04:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjOQJ9N2uizMg7NPUyYVTQbobEjlEhqs1ZRY7mDMuFURwbgXUYvDp8nOZ2LQ0I+DuyUV9WnQ==
X-Received: by 2002:a05:600c:34c7:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43d3b951a70mr16594015e9.6.1742295954311;
        Tue, 18 Mar 2025 04:05:54 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm18225173f8f.91.2025.03.18.04.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:05:53 -0700 (PDT)
Message-ID: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
Date: Tue, 18 Mar 2025 12:05:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
References: <20250313161738.71299-1-sw@simonwunderlich.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/25 5:17 PM, Simon Wunderlich wrote:
> here are some bugfixes for batman-adv which we would like to have integrated into net.
> 
> Please pull or let me know of any problem!

I'm sorry, we are lagging behind.

The series does not apply cleanly to the net tree, could you please
rebase it?

While at it, could you please include the target tree in the subj prefix?

Thanks!

Paolo


