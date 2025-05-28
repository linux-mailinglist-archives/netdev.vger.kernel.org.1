Return-Path: <netdev+bounces-193887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9550AC62E3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268487AF918
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C424467D;
	Wed, 28 May 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff6Tt3Wk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D210E0
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417088; cv=none; b=SA0cv1xanfgpbB4SVsT5Xule6TVAHoRPBvA+zsMFX4EwgPvcww3K+5vAYG9ImtVt5qR6Q+5xRAQ5DBs1GxdO3jKfCAsPY5GEXkovZusaOL2cEpTTjbr6bL7w6UmJpOVbw0CfLB+LqheSM9uQmN2GgWbNEamR1erzd537F2Y2VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417088; c=relaxed/simple;
	bh=6xJQzx4C9XKRYxfQfKcV+U7e1I4Iv7BNohHvGevc1l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKH5TnE5sWs7FMnfwYVb+cjjpglXUgIzNRaxMJ/z2m52/zdPZRY0Y5dmlBsdLcebhJhre000aBFFksJ/fuPiWsuuDr6/HWAsYDmbBlwUSO8/YrDi6cb1MiNi4mND0K/Ahmhnnx6U/FARxuKcc6ItmmFD6uODXwPNhhiEMVaTcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ff6Tt3Wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XYHyB+9SF/Z+X8QKiEUWQZQ80MVzujdD87l+S5+Um8=;
	b=ff6Tt3WkDfS/WEuuQYI8kxdyNwFSZMOSvcGPDm6CZsAP2i1rvkwkpi6o+K+e2gbjoN2SwN
	/9cqQXQj9Dt6VoK9YwyREchpeDFjjgO/QHRaq51MyX8kiygMhzWEcfuXiW8OdtmeuUMelY
	uzRUr8xqOU1YNPopnODosrZogkDODmo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Cpm3cZBiN4GaHIpxi2Xvrw-1; Wed, 28 May 2025 03:24:44 -0400
X-MC-Unique: Cpm3cZBiN4GaHIpxi2Xvrw-1
X-Mimecast-MFC-AGG-ID: Cpm3cZBiN4GaHIpxi2Xvrw_1748417083
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so26361055e9.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417083; x=1749021883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XYHyB+9SF/Z+X8QKiEUWQZQ80MVzujdD87l+S5+Um8=;
        b=PuvzBnbV/jU/JRQKdzHKhpuTqpV7pFarmyOL/VEsYZ6iJzj+1RBvYxDy2LYwqeA/RP
         +c/DW4leh/jlE10QRVhCf7p7PGWj7MjHNRYSt+EF3PRefgZMu9CfJHVWFcdvg3/gl5ds
         VtZ2kdUSZuV2MPbTObTFvDictn7yIeuRDbqdGp1015jEf7PxCgonk0HIbIw0Z8ebljex
         9jMTOUPfyFxyVY/vtN6XkN61dWC2KRfNK+X70SKCa4YcTV5bEJAZlPVh8GzoTcCfECmD
         yjpugmoNlt2U7yeA2ChPbRE1AlIaC2XzSaLsOfGESGHj8Yjlq3rxdJ1nBWhHMNQw+D7b
         ZXug==
X-Gm-Message-State: AOJu0YxeYdIr7hJTQoMf9Ld0mmoqYyJmDDaPTqej2ZppaCSAM3ZdUWTx
	+rhYTXPaXron/o/Mh4oZoAw5qlsJHu8mGZuBATi6eZrgY4m7fK1CO5yxeNrNgJ2mj7pIA+fpbES
	I5ycxRiPlIv9m98W6uVnmatQ0kyihKmGpW0Ek71BW+xQRRCrAA9CqPvZ3YA==
X-Gm-Gg: ASbGncvba22SiskPURYa6MybMZ8sKrkC7A242LaclSeq6kST0NUxsnsurlVPeKzXdnn
	MdFDw3lUgLyO76fr8xoXBmteS+vI4q47fVLSFr/+7RbPL87ytdmclVht3CQzzHLl5MvYn3gZL20
	uLWPJ209bpVREdotvOCS3apawaNOcRToCnLjIjn93XV34CMmB2TiAB6BEQV8hahRjyqOh5W2E7t
	rWE40HyV3ChGF38V3kbKUNW0Sa2hcH+kw1Yi0xeuMvoc7njZ2wVY2Zo1SgpxMUtUrWk+vLg+awx
	9tux0bZuqDvDN3hyRVrN9oyY/vuT2aNt7EtdFmCKfPqk+M+DhDOegZjpDwk=
X-Received: by 2002:a05:600c:5618:b0:441:a715:664a with SMTP id 5b1f17b1804b1-44f840b38bcmr46892695e9.20.1748417083453;
        Wed, 28 May 2025 00:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCqE1uwRo600JGmvrx2hbwcJjRSG8+fqxy1BRdw24yujy5GkHaEMyOu3ekjIht4ITlGdwQlA==
X-Received: by 2002:a05:600c:5618:b0:441:a715:664a with SMTP id 5b1f17b1804b1-44f840b38bcmr46892395e9.20.1748417083030;
        Wed, 28 May 2025 00:24:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064ae775sm11977185e9.22.2025.05.28.00.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:24:41 -0700 (PDT)
Message-ID: <dbc34cfe-c788-46bb-bd26-793104d887ab@redhat.com>
Date: Wed, 28 May 2025 09:24:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] dpll: add reference-sync netlink
 attribute
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
 <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 7:26 PM, Arkadiusz Kubalewski wrote:
> Add new netlink attribute to allow user space configuration of reference
> sync pin pairs, where both pins are used to provide one clock signal
> consisting of both: base frequency and sync signal.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Same reasoning of the other series, please repost after the merge
window, thanks!

Paolo


