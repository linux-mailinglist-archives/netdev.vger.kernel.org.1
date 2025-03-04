Return-Path: <netdev+bounces-171607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7216A4DC91
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771FE7AABF6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429831FF1A0;
	Tue,  4 Mar 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEo7Or26"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A991FCD00
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087724; cv=none; b=pfiYZbqm6MvlUa3u3Q7zQYoyMbTtsSReovQ98nCMymqsAPVeb6sVN0CqZPJC23SKGweoLkowaNUlpW5ig0w4vXJ8TKJk6C7vbGmqxAz7KIgsY1cq2NKTHOeZuYhplqDOw9yhRmh44lE1mP5o9yJe3afLNUC0wBZkWpdVbDwti7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087724; c=relaxed/simple;
	bh=KnUdtItjGNYgdCcN9y5Rg4Cul1YLre/02YFHO8L2ZVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYyLUoI5qSfOfM7TykoYJLhT87A7gzVaAZv0G0M68n8w7NuLY3h8HgcEPPoxbX5ZSMAVeV8EqF2asCnzeAMw5AVkFFG8tuaHStBsFR6vMfo3jgf7ycyZmv46klE0veIYHZ0uF2gh0ZIJ+8yTmHdQmosFO4NCLDNDZcZeIMShYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEo7Or26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741087721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
	b=DEo7Or26LH68jEO1u78ZhEV+QENITBYY0lTRcE5gViFF3sHVzfpq1daqI1BBbTkk/KREr8
	CF9FBbtBV4Pu561XbJCaX4CUEgOPcYGat0Gy0pWyRUcAygd4j/ynKE3WevTVO7J8+CoUov
	PuC+a9XZxZMf2NL5IWfcwkZyggT3Wy8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-VYwcPu9AMny6A4YTF6lvAg-1; Tue, 04 Mar 2025 06:28:34 -0500
X-MC-Unique: VYwcPu9AMny6A4YTF6lvAg-1
X-Mimecast-MFC-AGG-ID: VYwcPu9AMny6A4YTF6lvAg_1741087712
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3910afe5769so942552f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 03:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087712; x=1741692512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh0+rygjvEWvFpambZXtqMxwPMY88Yx0JvlayLr7tDE=;
        b=tq85OXjCdJNaoDIA8lLTsZ/Po55gK2LoCvkqibvbkBRbU85sd1qP8Jkm61b3tIGA5A
         pwM1PWmRC6XpIn4tPUzlGW0yoHQBqWVOcP8ti2SsYffH0fOggpiWxtRYG/S6dyK6VwM1
         PtSUaZ4CwP+tGnJUNkMC/6SDgv55ZcEPuxKmKaPM4B4N/SJihpueCEoQ0nxwCtGZ+mUZ
         MWVozhBHslX6aL1nYB/nGoWmRmlyxu0fzz+WiG6NJSDBNNI6Ktjpi0xh5/xqOm2GL/mt
         IxwZemgGI4L4atD9sCzotLt/AhBgzKXtbsrn/66HYeK1Pb81bnfI/R1HXe8qTj0HrG5j
         SDZw==
X-Gm-Message-State: AOJu0YwRXQJR83XE5yZNLze9F44ioAvCe97ExA4i/GyKxauiE9dtEMUB
	8lwybmk6zICfZl7Ufbi7SNbjXZRWw0Sd8fnixPjNrMiq0Eo00QCB6/mfw/n41wJooUYl8TIuTvP
	BfZqi3+0GfEgHHKMgQHpOPUNPvOCpzXZ9O9wXSmomB8H6mNqjWaLUUQ==
X-Gm-Gg: ASbGncvTm9QNgR9QMPoK49MGiIsZKc6xPAUnyJvWZGB3zTmoa3ApEWPpjKIsLp6DjJ3
	vzNbjP2CeoyAH0Tggg1+/ZXSBkouBUx51pa32mGkTN5bPgZsLzZSxc3X5FGR8yJx8xJ4k0dO714
	Dfvj1qDejwIhUU5lxVN+g4ve7zeWQInb2mXXyf5bCRqwaxciMGpg9hkcUKbVNzfcBNyYcb5auOk
	cJ1LUq17sdMSNeIF5pXMlBqnoroovT1GZoFUpJrzY44uM48ESNbERCtWxiy46+/MhL+xNulMknU
	MR59Zt0CZ0wPJv+/SFglvSRyo/iURRuZW+QNvUe+8TRc8g==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424451f8f.43.1741087711878;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqZ/TRGcqVpyJ16gAgzdOfvndPozt1EifipipyO5TrSqSLkUzB4NwQLxlVOUb/6RXZ9PIEUQ==
X-Received: by 2002:a5d:5f89:0:b0:390:f698:691c with SMTP id ffacd0b85a97d-390f698696emr15424428f8f.43.1741087711524;
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm231184535e9.26.2025.03.04.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:28:31 -0800 (PST)
Message-ID: <63e68624-3672-4473-be15-ce04eb3cd2ed@redhat.com>
Date: Tue, 4 Mar 2025 12:28:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250228092449.3759573-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/25 10:24 AM, Haoxiang Li wrote:
> Add qlcnic_sriov_free_vlans() to free the memory allocated by
> qlcnic_sriov_alloc_vlans() if "sriov->allowed_vlans" fails to
> be allocated.
> 
> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

AFAICS the fix is not complete: sriov vlans could still be leaked when
qlcnic_sriov_alloc_vlans() fails on any VF with id > 0.

Please handle even such scenario.

Thanks!

Paolo


