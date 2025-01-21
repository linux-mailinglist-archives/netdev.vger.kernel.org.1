Return-Path: <netdev+bounces-159994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689FA17A60
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1714A3A2288
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735151BF7E8;
	Tue, 21 Jan 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zh6gEIB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E81C07CF
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452408; cv=none; b=ZJbZFvev10YELbG05LSu18ABZW4uAlW5N6ABa6q7aYbDebSrDbA8GfJsQ9Y0IthbqVRBHnzLoPfRjN8M4OgxNodmtnfkHr0zgsuXIfADd1NFxIbNC9ziz4eL8cNLNnmH9eKRmIpGN0bkhJaDOX8++IfTvD4n7xaHEZu0vUo1Dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452408; c=relaxed/simple;
	bh=gC0jXODHqgnMs+E4zdqJzbVf9F9ugfo1XB1dANjt5Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk32sj2885EwnBfy8VUwg0JJOxx3c4u7uouIqcd8rXb85eA9IlRMsLoKbKCwCjgPGt5cINql8jfrgXhhNucvqQSJTW3vaI27b5KWyvCmXlDTWKLhezh6S+M04X3fbSpgka+bmh75caQciLv1WsPOQKj6Vr9RCBCPNJvYk1NVv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zh6gEIB0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab34a170526so784525266b.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737452405; x=1738057205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVs5bpTeAvi9CCLhHXHq00ky/wFNRZfIU4hY3fWGGfA=;
        b=Zh6gEIB0j9/8/W+hTwoxCEC0pekeWG3UoNO+HQwaPTL4+X3hg80uhklnt1aOtXIlVr
         2yJ8ltjeE4t1qIqIB94lCtDcsqoz/foEHA5yH+5cqwmMXkoKBYdP7ZCr0vUPG2SkJX74
         2W8v1A1rqpH13K675GFF8VGgi6Xo2J4leYBWTbBhY2Oo+3UU4cnUMvCbry/Yn0jzfZBB
         YpHBUo3+br4Mtw5ZgWqHD8ml3124p+IOVxC/vS7f/Eh7KNkwkgpOtTLZS/k+h/pwWTc9
         uAdqmPak5PAV28Wo5J7F1SLpW6qNd42q1fbfTqmJbM0qn63Iq0T/74uMhVyt7d42LYMV
         +KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452405; x=1738057205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVs5bpTeAvi9CCLhHXHq00ky/wFNRZfIU4hY3fWGGfA=;
        b=xTOT755XAneY2etFdNsL9gSpt8w/TK67S8h02Umlo9/gNV0p+KSwwoP71mo99A/kKs
         rH5ITTbosXO7X833h6OQetf4xaIv32ilpKtD4Lb4TGDyqY7aYxBK3Jmnd7aVbJuqLRCZ
         1PagW9dfIfR7aPaVXywbaCmO+Vj1HnCCitCIVUtJdmQcqREQ14WgSh6LUBeeUxnSoqt1
         blkn7eqQm8W9QHsZlT7Rrepj4LsDKL7lISLi7lcrQQ0NaYFjl5j2CYGEwabrZHtY/pBE
         +FDLW/2TKRI5tKrqOkvhGe1tJjQtlOY1z1Mnt1rQi+bvo3DaRv6pJXfHIKn8vVK3ASDJ
         /ESQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcnR82nk87nHy21C7TzWWKELxhdzk+qGYjicKS2Inlc1xOGfDLDTiTZOcO4j+XI+NWZM1wWdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCxmZWgG4dQo+/4DZU7TTBiqfCYcC7D8i2fK08Ca+g4s59CIz
	DqB/IRH0+QevGM7sYczqWzbKFaYDmIEjneLw/Q7jmgduMw2L1vymJ30F1UDgwM4zvV8LKHUpHYh
	L
X-Gm-Gg: ASbGncvmRBo84N6jEMci3zXELW3RUavx3GjcBmd9ygaU11ckF4HiPaIuqOj5MQ2kdl2
	C4Q3k23kj+wUJFe2sYQMUH3I2ojhMDB3sW9GTaSWsGRXl+qezDeYd/NsqGyrtfdS7ZeKhRHQ1B0
	k8/5HevCCIz51WvmRYkcrGr+JRZMPk0i4l++pAHhgIhlGr4tZC/mgpzkDczPO1Y0PjAQcd+aEsm
	PbiBSyFR17t7RWEgY9fAVTUuyowp3710ceMbC9meoo1oG0wjxXVBf5wAsEzcq3zd8zZTLe+sPsE
	EYor2vJxTBV0iBieGLM3A0jMXjODyBKnOmjATQ==
X-Google-Smtp-Source: AGHT+IEeGUNrrZxGMszk2mE9kC9FLy9DLvACFEUA664lHYwmH9aA3cXQ7d0hpV2U+Kmohl64KhvHwg==
X-Received: by 2002:a17:907:7243:b0:aa6:87e8:1d08 with SMTP id a640c23a62f3a-ab38b0b9b3amr1455350166b.8.1737452404722;
        Tue, 21 Jan 2025 01:40:04 -0800 (PST)
Received: from ?IPV6:2001:a61:137c:9701:41e3:e368:740f:c4a0? ([2001:a61:137c:9701:41e3:e368:740f:c4a0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c6077dsm730191666b.6.2025.01.21.01.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:40:04 -0800 (PST)
Message-ID: <f54876db-8265-4d45-be9f-b18c422251b4@suse.com>
Date: Tue, 21 Jan 2025 10:40:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: qmi_wwan: Add error handling for
 usbnet_get_ethernet_addr
To: Wentao Liang <vulab@iscas.ac.cn>, Jakub Kicinski <kuba@kernel.org>
Cc: Daniele Palmas <dnlplm@gmail.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250120170026.1880-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250120170026.1880-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20.01.25 18:00, Wentao Liang wrote:
> In qmi_wwan_bind(), usbnet_get_ethernet_addr() is called
> without error handling, risking unnoticed failures and
> inconsistent behavior compared to other parts of the code.

Hi,

unfortunately this makes no difference between a genuine
IO error and the device simply providing no string.
Does the device need to provide a string for the MAC
in order to function?

Frankly, this patch does not look like a good idea,
as it disregards the reasoning expressed in the comment
seen in the code.

	Regards
		Oliver


