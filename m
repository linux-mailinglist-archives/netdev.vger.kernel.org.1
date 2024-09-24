Return-Path: <netdev+bounces-129551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F49846A0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E21284BF9
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7F1A725F;
	Tue, 24 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC7vJwWu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA333224D7
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183853; cv=none; b=ItRU8r8O833daxfof9vwaYzSqStW7elO+dMPftRKxPcREn43UtqNaOlWwu48stgjWSrXfYIFajb8tpf7PKzxe3VNN9Pe8cwbWgC2IMTdQL2FIXKm2iyytj8cZrvoIUOw13MOMkw6myV32ui/M1GditWZ0uj0xgwz8oHW3XrQUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183853; c=relaxed/simple;
	bh=1in21SuDBEW74Rxiv4edWzVZdTwTeiWxyCb7NZIAj1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAkJ0csX+s3lTgOtLJXa1zz4pdGWCfg2yoQM31hYBtObzX8i1vv467ABAGQnNHCihwCNVG+HV66jiZYAClcAUTLGQnBpDhsZFb3EDPLnlHVTJtJnho4oC+9bepjAaPcvoMuz2wrPk6nk0V6uHvjE5IYq/DQIZwUQji5771Zbsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC7vJwWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727183850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPlQ33SbBVQXStogF5r8U2TSC0bE2p7NNfiXWXG5gLg=;
	b=jC7vJwWu+y3RBlEBcZhVR7Cis+pM1hXIa6Z+iUwUn/HB85FbKHNsO64ayEOfu8gUWp2nir
	4Mc5FFNdIZ1GOyezoyGqrZot8Ldq9odw6c27Vi9ajaS0Pv3yQkeR2ypf3WXuY8XS2ezfSu
	16OAlTNm8Nv4vL/TcZY0Xb9fV/xcdR4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-0x-uaK4jNpab1O6dDafVjg-1; Tue, 24 Sep 2024 09:17:28 -0400
X-MC-Unique: 0x-uaK4jNpab1O6dDafVjg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c32158d0so2955261f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 06:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727183847; x=1727788647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPlQ33SbBVQXStogF5r8U2TSC0bE2p7NNfiXWXG5gLg=;
        b=NT/H2NPtdsMAYMHYgIMD0x6gybBAE6awOEIi0Lhafz4l9aKDf3J6uLSseH+czs7LCH
         /xfczmvv3egqIdvgYoF0DfsIxb+Cm/t1sN1W/yUEy0HLINJPYicfJuNEpJSoifYzyUe6
         WWjSJ/Rko1Kb20HIiDIi2k/sZyc1+MbZdpxAk85OvUCtNn61M2hq22Gxvn4F+0sGcWAY
         4gCLW1qgK6oHqYR1sfQwNIyfsnY3lOmgPvq7xb2fnkzSSUNIoy5Kt2XyJcFkT9+dAfZK
         E/lwHnvW49pjXULsE6KMRMj6SG6jRrAEc91yEvCchvHzxiz0spgzKdWGbe3M2gYdra9z
         2Dhg==
X-Forwarded-Encrypted: i=1; AJvYcCVjKQF4ZjbK/kGOLTsgP1EVgAVBxIaqpejDo+YbTJmWfF4dkbVgemK+n5SvO72UnY+90WZU9YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZRE+tb72qTBqgPdXUHKOmt1unl6VeUprOSjvNu5o4gcUM2vYh
	XCkr1x6gMvitw4mQULtavEwRoRdeBFbM4cyosW6vuPMiVq5ftYML7ZLm474zdw4ipfpLg0MzL+S
	9rZ62E+F2lM6gBliQeb9TVeiRGLLAotqXI1pjtSXhOLxTm+Fr9MHfjg==
X-Received: by 2002:a5d:52d2:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-37a42253338mr7379657f8f.9.1727183847456;
        Tue, 24 Sep 2024 06:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHalw2H/ZhllOsg2pD3AN9N0EesDvnXF5Zl23dNrjTArI5OrAQ61JSzlx3fLh6aL+0YaUxUMg==
X-Received: by 2002:a5d:52d2:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-37a42253338mr7379647f8f.9.1727183846970;
        Tue, 24 Sep 2024 06:17:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810::f71? ([2a0d:3341:b089:3810::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7543f3f4sm157246955e9.16.2024.09.24.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 06:17:26 -0700 (PDT)
Message-ID: <1b507e18-24a4-4705-a987-53119009ce3f@redhat.com>
Date: Tue, 24 Sep 2024 15:17:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Bonding: update bond device XFRM features based on
 current active slave
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jarod Wilson <jarod@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240918083533.21093-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/18/24 10:35, Hangbin Liu wrote:
> XFRM offload is supported in active-backup mode. However, if the current
> active slave does not support it, we should disable it on bond device.
> Otherwise, ESP traffic may fail due to the downlink not supporting the
> feature.

Why would the excessive features exposed by the bond device will be a 
problem? later dev_queue_xmit() on the lower device should take care of 
needed xfrm offload in validate_xmit_xfrm(), no?

Let segmentation happening as late as possible is usually a win.

Cheers,

Paolo


