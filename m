Return-Path: <netdev+bounces-180185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F26A80110
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B5D8818D7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F1268FD5;
	Tue,  8 Apr 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym6tlaX4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B4269AF5
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111801; cv=none; b=splCGFaQfG9EPMgFrRA/NKyu4tiat+GXDMOeJjcHPLtnFh5FW14SNsIL/2GCkqWSJ8yt0iyFn23b3F6BTCD6OlKmJ5nT874aCY0bvjnS5VtkMia7uB0d+BwNKIQWzf9dy+xWP43wCoMkfCYJS0qU1xp57+HVGHatu7ts94U4p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111801; c=relaxed/simple;
	bh=f0wyTvRh5lpgWiiGO9fwyzoCdEcKmYS3jgl7pHv8Jw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRPbdfyErNBE63WUaWsJ0CNRZaiS+NFb2C4telF08Aff7MqHXDZ+7Al4ZN78UQbhMZJ8aDgBy8Sc3gXTYMnC0SCBswPxo8w8ZgT0k+Htw6VKHVc0kcly1vh8dm6h7dcjSUVNaKKmbhPncShziLk+JHJ4gi3984taLLV/qO4bx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ym6tlaX4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744111798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiJcUwgw3G77cyBQmbSkkpxoJDuSwz/pqjPj/WDvIhE=;
	b=Ym6tlaX4swU649Umu8jjY3uz5Wc79tvzs06YjTOWuOYfJVQguY5DZnEQCXXcE3oQSP3CmD
	2ieCDWg+kx1JG0y7q4KM/Go19jjbfOd2dGzvMuFkdn30aB7shyhxNDAonjgmkqebZifTxM
	vIF2vnlsOZOifb9R3mOX3b3ebo2pzmc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-W9GIBbDyOEehpaCG16AWaA-1; Tue, 08 Apr 2025 07:27:49 -0400
X-MC-Unique: W9GIBbDyOEehpaCG16AWaA-1
X-Mimecast-MFC-AGG-ID: W9GIBbDyOEehpaCG16AWaA_1744111669
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so30453255e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111668; x=1744716468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiJcUwgw3G77cyBQmbSkkpxoJDuSwz/pqjPj/WDvIhE=;
        b=olf9cBm+YNaQo/pPgRmETEXnPTE8w7IHsATK2DzmCwP2i14GCTeze+V9YjleU1s8p1
         ByhQOK2qz5ip3EfgBLCojCJ1zK60g/hZ+lbVR0XQDhXRVICT6Ssd13KHCz7hCUfwxLxL
         x6LpRSqtic/aDwCLI0NedyN+WD/XM4l/8pPjrioNhCbz9cBoGitz4fK3BaH9mt4plkvX
         g/NEqNl2RZ1knyHNdsgaIjIW6Ry4YskiNzfq+ezZ6DkgN6yJmrYNfwj0ktTDLiPAJ1xo
         7msYS/HhoeA60wMkXnb8Dm+oLit4vGrQTbD13zOgq9qxWX/6xDToNvbgRda5lMtLdMsJ
         TbiQ==
X-Gm-Message-State: AOJu0Yy0HZTfgDh3xv4WoNi+5FVTvghPK8XAeDkEnBderApA4VdjTOL6
	GoFt8Hiqa65McpO1OD7jm//81AvB+22jp/EhY/RvSKz+eT/W7cfCbY8O6cMpqVT2KzTyLnZnupv
	M1njXGPI9XeHeziOqgWsLUbGPtwoiD9bNz2YmeH9cLXeKGODCdiRcAw==
X-Gm-Gg: ASbGncuC7Hq687wU3rJpsEA/2Nhu8TEWOsVNpQwBSoaI+JN18tpgNFnVPMpMap4gl+L
	u5e7QyhkzJp2Ocs9A2gTfIpr3j6jKxqm7C3soT4QlbWf2TEqDePHIhxXHD8fPy6zZPdGPSyhI5h
	cX1bQzo/SD7zIknrWkliMkosF+833o+6t4k5R6hLOzAPvX1awYrY/cyvxzi3RXggNqxDhtFGk+t
	XTHP4URlwUOM/DD8N6dgLBAl/tTmnPredgs2ET4qmARdVkRGrLnHzk7lahQEVzAdZfliqz3Lsvs
	oQ0guC8m1FiortJSJfZPcwkwQM15vYtVAefZEWnooos=
X-Received: by 2002:a05:600c:4e52:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43ee069569fmr126983685e9.16.1744111668625;
        Tue, 08 Apr 2025 04:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJoXZ2/VTIioZNKN80gDIxGBXzvfyGiFohuL9wpJ/xqRl2/l2496Uw3iNHljUOTZLrUqMGVg==
X-Received: by 2002:a05:600c:4e52:b0:43c:fab3:4fad with SMTP id 5b1f17b1804b1-43ee069569fmr126983395e9.16.1744111668288;
        Tue, 08 Apr 2025 04:27:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bf193sm156859775e9.24.2025.04.08.04.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 04:27:47 -0700 (PDT)
Message-ID: <f8f98783-0aad-4ff7-9fd6-0ebc8c734abc@redhat.com>
Date: Tue, 8 Apr 2025 13:27:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: Convert to SPDX identifier
To: Raju Rangoju <Raju.Rangoju@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 12:29 PM, Raju Rangoju wrote:
> Use SPDX-License-Identifier accross all the files of the xgbe driver to
> ensure compliance with Linux kernel standards, thus removing the
> boiler-plate template license text.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

You targeted the net tree, but this is IMHO net-next material. Applying
there as such.

Thanks,

Paolo


