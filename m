Return-Path: <netdev+bounces-137822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5879A9F1C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B41281D49
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC5198A2F;
	Tue, 22 Oct 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv2dfv/G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34D22083
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590536; cv=none; b=FBrB0bdDEkVmq0TeqIQ68VHkBlX0dnjDZlm1bCS0c38LrwCbPVnlJRJj7VMoidkRp02yiwihREm0iVye3HrktkUM/ZyCthHSuiBgDDsNsaPaS7NkCODJ8cZaJIcZ9fZa7erarWv6blNqLby4Z96+i2RWJdLoIIHYilZPT1o9gSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590536; c=relaxed/simple;
	bh=np/oMiEleV3eiDfO38QHX5bBp+FCGGZ9axapg3vkJXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL4ezv7N50IyStYQD6W4Se36ljHndvYReDIfmplGRFHc+NVEJqeC0FhgnISzaRjdu0CXhVEAJXL8zQDtb24Cz6jDG/AY8AB6O31fmUHe0cdA7dQq7nksI96KbOP46QzSJtBA2Mn2t6/3lwWYy2m95eQzCeMJmdz5AESjKj+fJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv2dfv/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh4JWQgDCy7f4hUaCVPSilGsVTg/1tlAM2ttQqHSmuQ=;
	b=Tv2dfv/GnTJcC8bM/fxhr4bvHqVDZiqqke5t79IQuIrABnw8PEOdzbvJmIrOlhRoo64JB0
	xD1kNjYkR0dOcESc56GLrEK1BTTNNJN73JmnoLKIsR0Jc86GOkwg/2CSsXU3WJU2GKJViN
	oIn4bI/5ujTnSP024rnf/j41kgz3hvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-EbrKQD5gOESvh5E9Su9X1g-1; Tue, 22 Oct 2024 05:48:53 -0400
X-MC-Unique: EbrKQD5gOESvh5E9Su9X1g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d531a19a9so2721900f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590532; x=1730195332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh4JWQgDCy7f4hUaCVPSilGsVTg/1tlAM2ttQqHSmuQ=;
        b=hm88xU75IW6Hh01H+Vfrw67GynQ5Ry0qEJGqlllKM1IDpHyjxL9GumxeEhvKxxoYyb
         w+4ybV/9Wldq0zW0S7CfyDWnsguVavgiUC0MWViI4HlTU9ycGqgmenIQBw1TpBB6RJKg
         OZi3YIby9OURKizLu7/ktqe7bRnLjCaJRR1H5vjiu8ijjK1g/HMVBMOazuV1ypXEm8kG
         3e3XSoiYyYaT0q6QVTorgQyb+jBUdBL4P4/VKovsQA1ae+mh64atxnSZo+JV/nzKZNVZ
         ZoHFen77Da3y57srOqk6z920QeXdfHJX0h2iAx06AEqRZg1ucsGlYj6v1hJCZEy43sNO
         Bnkw==
X-Forwarded-Encrypted: i=1; AJvYcCWXopAahpquV5b+9c2mJu+73P6xWZUVRlxnZO16tyLPJXAdrzwJCDaW6JzrB+2qJW60TwbAZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmzhTPOMdKbM+9KCo0TZCfEOue9MjZQ8Oei6RPCs4fRfaC+y4
	Xlbb9cu8g90QFnCf3ef6B01XOIbLgHTlcfY4cHCeWgvLUMc19V/F2kQxZHBzZRtRhiqVuR5j5MI
	y2pUWpAOQEwnYtS9vTOCkov18N7xV5tuV3/HunllEp/6lJb1B4o1Gig==
X-Received: by 2002:a05:6000:124d:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-37ef21329e6mr1350922f8f.8.1729590531682;
        Tue, 22 Oct 2024 02:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4nJbgsS+oolp7+z293Shdqn+zOCHUUqXKuuAQbREypUB/3N+OmB5ozWRS+gZFiWSQ67Qcsg==
X-Received: by 2002:a05:6000:124d:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-37ef21329e6mr1350911f8f.8.1729590531351;
        Tue, 22 Oct 2024 02:48:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4b26dsm6243789f8f.45.2024.10.22.02.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:48:50 -0700 (PDT)
Message-ID: <278ca1d0-2a21-49a1-87b5-34b0f03bb9d3@redhat.com>
Date: Tue, 22 Oct 2024 11:48:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 12/12] selftests: ncdevmem: Add automated test
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 Mina Almasry <almasrymina@google.com>
References: <20241016203422.1071021-1-sdf@fomichev.me>
 <20241016203422.1071021-13-sdf@fomichev.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016203422.1071021-13-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 22:34, Stanislav Fomichev wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 182348f4bd40..1c6a77480923 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -3,6 +3,7 @@
>  TEST_PROGS = \
>  	csum.py \
>  	devlink_port_split.py \
> +	devmem.py \
>  	ethtool.sh \
>  	ethtool_extended_state.sh \
>  	ethtool_mm.sh \
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> new file mode 100755
> index 000000000000..29085591616b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import errno

Possibly unneeded import?

Thanks,

Paolo


