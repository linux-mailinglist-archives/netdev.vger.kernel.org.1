Return-Path: <netdev+bounces-165896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF54A33A9C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3611161631
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63B20CCD2;
	Thu, 13 Feb 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnXx21L0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E320B81F
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437498; cv=none; b=D/Unmiel2aMqT1N/ZQTDl73wcglnkl7l+RKUO3qvT2mIpgs1S9br0k37RBvxHTDMHHfwWFtLlUC16vAmLHHmYOWRGFCavPyzFOzYYb77dMIaNLxGIfaFodBDKg4u81qt18ntb0zvcoMwUqUaqhM+dZNGdQZYXCUP6FF9byu5E8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437498; c=relaxed/simple;
	bh=gqtrIsZFO3t9A6CHTJdJbDHsJywa65KGRaYdtfDNjSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=vFVA+35278TMLj4zPjf/HrXrpIv/2LPNPZwusbFeXqcdhdDIJZXWKq7YCQCycIMaq6j+NPZB4h4/97mUmhuIAVnt0MC/Elt292pdzBlEXDAo1ZW9463vmNThDpQX3muM3pWiNPdgxkkZPCgWpj4Z3xYj5Dof0qmu6pvzm5XJAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnXx21L0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739437494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPPXp+DqYBNPtUl0nhKlU9ascHyp2ZkvND5NvkqHXIk=;
	b=RnXx21L0V4gHwfZXI7bYaP6+YVyFnm5g7SLgIXglD5n/UIfqZSlcu6NqkxOP8iBlUCnwjt
	Hn/QJiEhcgwni/IwusvJV6ygcvY5urANJ5Q3ChLqVt+UI8GfYcY/uZQVGYgIzFwAfDuXka
	sAW87nRWsn2aHsZLLFAxBH2tlgPPako=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-gevHGm_FOaOTe2FpQ8tjaw-1; Thu, 13 Feb 2025 04:04:53 -0500
X-MC-Unique: gevHGm_FOaOTe2FpQ8tjaw-1
X-Mimecast-MFC-AGG-ID: gevHGm_FOaOTe2FpQ8tjaw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c747c72so3274405e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437492; x=1740042292;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPXp+DqYBNPtUl0nhKlU9ascHyp2ZkvND5NvkqHXIk=;
        b=lzvjSXYoxTchDfRhj6pgCmqDqR4w6hAVkdLm0+e2YuQ32mgMkJNo+o334FGMcoiB3U
         diRPRd1zlwMJQZFnFPGX38zun6ApQvOT09T/828JQXCDzJBWetshZxY0Hq6VdcRB8y4h
         1FdVDJWrunIw1rxkWEoIL4njiZjnAYqTVXRcOw1BQkzwPFH7yizIwaf26GepelDRRTZQ
         pWQZxW9RBgFFXPdaSeJnT/zgqvIboo1iqAyNxLmHNMZ5NUvxL7DndzhMK71Ojk76aOa9
         O5M7dSTFuwAdZV9glQOafIogvBr9gKoZq2hKT5NJNY3VAWSZCLdoRvQtOwLH7w7SUgYx
         mFBw==
X-Forwarded-Encrypted: i=1; AJvYcCWkJzzqz1fcIZ9tBDjxEyTaj494CJQ7vqi/pp5oFp3zX3KenE/zgPerJYRhCU1czhZjBB8Vi4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBv9LkGWKeK1V2TE93MxUcRwoUyCtXy9iClVMn0xyy0AVel1mo
	Up94Y3CODhDeyQ3Z4td9Y8SZdXBo10sWd9NKk79dlQgxiEN9u/0qbpaHwHoFwiyPFRD/KoCmauq
	nDFgedrylIfibLwrceUaZ58U/7rkqy2vlQ+JL5A2PpSFw3ZG3B3+7sQ==
X-Gm-Gg: ASbGncvtNnQjWgsTYiWqxvItERdUg/YG3ZYZIyDrhz08gZ9+dORfSeLwvYDoeMs2+ug
	qqfoNhAwgTJS8SCgEIlHnGabIntJ/XBEvaMak+YPCUBZPrn6sGxw0OUn/FQPjYY+t82gWWxYd6v
	I1sYbR+MNdVxIAKR9h/1tp6uVHk6nkRScVzrG4vqSv8HylGIMP0we5e7Z95olxNUvByd9VuJMAB
	cZ9EGjPfum6+CdC3Xmkj4xSPHqpEUlFJo9pd+7AOA1ff7sb7GGaoAHnKog7rNyDq91rep8wezTv
	MIjH8Bn1fUbNm8xXVJbcDxNNgzOTqHXj4yc=
X-Received: by 2002:a05:600c:46ce:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-439599258b1mr56603545e9.4.1739437492140;
        Thu, 13 Feb 2025 01:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWnvSDslS9x9V9t5sSHRI9c0hrSBXGtqBD2no/zOmtqcPI5lcyK+O8Y6XHZHX2Wk85H1SIZw==
X-Received: by 2002:a05:600c:46ce:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-439599258b1mr56603075e9.4.1739437491770;
        Thu, 13 Feb 2025 01:04:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d58f3sm1253334f8f.73.2025.02.13.01.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:04:51 -0800 (PST)
Message-ID: <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
Date: Thu, 13 Feb 2025 10:04:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20250210125246.1950142-1-dqfext@gmail.com>
Content-Language: en-US
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250210125246.1950142-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 1:52 PM, Qingfang Deng wrote:
> Add EEE support to MediaTek SoC Ethernet. The register fields are
> similar to the ones in MT7531, except that the LPI threshold is in
> milliseconds.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

@Felix, @Sean, @Lorenzo: could you please have a look?

Thanks!

Paolo


