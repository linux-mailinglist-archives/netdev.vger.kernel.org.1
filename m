Return-Path: <netdev+bounces-163436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99ACA2A3E1
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EE23A3D1B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A0225A29;
	Thu,  6 Feb 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bL/zORBZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F641C92
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832992; cv=none; b=jI2aJewh9rOo44oyJD6qT9FoQD7iugRUt5Yax9uGi4yWquatieRmDbqFP2tg97V5bu+A/YLLWclYHBtXXIuCibk6BLj8OHvCogt8ssLDrKDC4R4xBg3JhyfcOSVSnOXmh10ppF7AFq+S8H3XZaDCQoWJvdDbM4d0QZDFyaLp/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832992; c=relaxed/simple;
	bh=AjYqtpX63pgaTPOfaEZjZEZvSlOEauKmvVFPv/plYE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpEiugmZ+nxfwTQCKR8fcOOv6Kd78WjTFj3sKI0S5uaPM+qIJfu5skX7w2Uk6xft5aGr34PLToPGFznKFJr5sFZFTcLuW32WoqYBvACJdBQ1BoZGBYpfBw9CE1pSybvjV0Rrbc9Q5vx6IamWMsi+fjXIdzTJ/ZPLtGTDvvcS1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bL/zORBZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738832989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu8IUQW+rpqIFEgx58GMOcAE8CbvdH7P/fpdALETQPw=;
	b=bL/zORBZAQlHrjF9hkPZhttWQu8nDyaW/te7ev+X8jWNCqYzgob8u2//WLx3gBROvQV+QK
	SH10F80mYkvNRrxIG8sA7aKqwIjT9sZDqR5+wyXdmWhwBT5yvFfXPHZtClvMwtSWqpo4YO
	AkGh+s+I4CnQuJlJMA3UwAe7BUFISFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-xmv9gcftNh6LC_PMbzS0-w-1; Thu, 06 Feb 2025 04:09:46 -0500
X-MC-Unique: xmv9gcftNh6LC_PMbzS0-w-1
X-Mimecast-MFC-AGG-ID: xmv9gcftNh6LC_PMbzS0-w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38db8a516ddso292766f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 01:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738832985; x=1739437785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu8IUQW+rpqIFEgx58GMOcAE8CbvdH7P/fpdALETQPw=;
        b=C8MbKeTc88+k81zKILcJxni7EV1z4fmSbjScg2oE9FU6XFRe6KyYX/B4tcWuXJIpef
         FpbYw8cWFikYRqs77UT3A/j9GBe34bkfPZ4AW2tMgiCy+yF7pMvjTD2K3gCK8oGcrQbc
         dYHgojiEdinn7sU8PM3Dob+pjEdQ3AsnKlhDBqlsO+Pmrh5Xfy/XL6XznDL2Vg15l67G
         ypqD1Qy9HEkn6NpSJQPJDq5Mp7D/m73/gir7QkhyCnc/YaNetz099QWzRiGpKut7x5Gq
         J8sVQZRavYuZNl9AeAB+109SAzv8nN9GXzH/wUWe6fJfuO3cEiTO8VCH3DGdh6ErWGgQ
         fqmQ==
X-Gm-Message-State: AOJu0YzEnkefLbYdlHNQ9dikyrnODT6oDbQmS4lC/gPbIk/0MJpkX0a/
	0eFHE1ra3Ko0KA0Pewv1iOPN5ZWJm70Nttyre0Ew06jokiJ5XgHFX3tWjFg7W8VU4K0ro2j2ZtP
	2s2RiIs35eKkpfxv3obE9LYxm6pSe1rl4blIxaP/DNJ86PqFd9znu6Q==
X-Gm-Gg: ASbGncuiqe+oV7ONPDONFkPNSEdT+N99KTQrrdYeflRsKXmTueMUmHLwwv+HuLC5Chz
	Lh7MWj3pTXkNl5Ea3KRJJ7FHri8x4I6lxZdpLZisnp5IPhgXzT2VedSs4DrJjGn5Xvw+IDMohGq
	sKfS0gxFoEXc44AKmmMbqI+NQlb0AfKGQq9k8TmUdUocRcNGFCnG4Lohc41MvFokH3OPE01uUcS
	PxrADH11zqmqos4aTpP+f33ptwm2JTWFkucfKWggTD2jsIcNsThcedoJVJpnj4IEFL5UvpcmWR9
	z+MJaPzIh/C47i3FHhnyUfxInso6SGqcDWs=
X-Received: by 2002:adf:ef45:0:b0:38c:5c1d:2876 with SMTP id ffacd0b85a97d-38db48682aemr3048111f8f.12.1738832985694;
        Thu, 06 Feb 2025 01:09:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGSmlYj2qFmQhnZ9tEj3FNZcMdAr4v10hQyBba20u5VcBBdssgfzix4Lec1Hi7cuy1DjM2Jw==
X-Received: by 2002:adf:ef45:0:b0:38c:5c1d:2876 with SMTP id ffacd0b85a97d-38db48682aemr3048094f8f.12.1738832985355;
        Thu, 06 Feb 2025 01:09:45 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde31e09sm1181063f8f.99.2025.02.06.01.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 01:09:44 -0800 (PST)
Message-ID: <858c9ad5-e585-4c48-8005-edef94909695@redhat.com>
Date: Thu, 6 Feb 2025 10:09:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] Support one PTP device per hardware clock
To: Tariq Toukan <ttoukan.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
 <915e32b0-6868-43fe-9413-91c3732534b0@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <915e32b0-6868-43fe-9413-91c3732534b0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 7:14 AM, Tariq Toukan wrote:
> On 03/02/2025 23:35, Tariq Toukan wrote:
>> Hi,
>>
>> This series contains two features from Jianbo, followed by simple
>> cleanups.
>>
>> Patches 1-9 by Jianbo add support for one PTP device per hardware clock,
>> described below [1].
>>
>> Patches 10-12 by Jianbo add support for 200Gbps per-lane link modes in
>> kernel and mlx5 driver.
>>
>> Patches 13-15 are simple cleanups by Gal and Carolina.
>>
>> Regards,
>> Tariq
>>
> 
> Hi,
> 
> The series state is marked "Needs ACK" in patchwork.
> Which ACK is needed here? From who?

I *guess* Dave was waiting for some explicit ack on the ethtool bits.

I went over the series: LGTM and the ethtool part looks uncontroversial.
I'll apply it soon.

/P


