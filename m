Return-Path: <netdev+bounces-223397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2EB59045
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849D12A1DCF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA7285073;
	Tue, 16 Sep 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKl8mF+B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3E283FFB
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010804; cv=none; b=BOy5IvveaaR9LxcX7wswk1o6NZZy2/cwuBZ1a1uBBUvouz1cedTcjO5vOZ4okbtikmFhmRKOxcjqdbjHR2MOVTnB6Kt1Mj2NkFfzj1rOTD0ULjnxKFR2NWyVUwcscZF5+HMbWgN4etAznM5bUtKlji6xWzUonzP0JA0eiSRGujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010804; c=relaxed/simple;
	bh=wyzFXdhH71/K6R4ozNwpypG96FdPPhKK1bsIffaUOAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XllRdqRQWjlFqTzMV3CbY0/Gy2TtR4OmdreQFwvph39+7RU+fkgCoqAwpcLvpGdWMU+2Qpm4a9ToP3z22LFzPh+q8+XfhynoCPlTtZVCXAy72VAXLVIcnTW1pqp3JrJyhDdEUFfDFLwuU49Riso9Yri5VbwszRBHxzqT585sjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKl8mF+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758010802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzL2N1DLwKqBJMwL8CAS9ydZTfmXfd5ccrcFe6t3UgE=;
	b=cKl8mF+B2HrIPufSGUrOV9ztHLqZHbhhCz+Fi+9OTAMuT5ZKdV9zr27FEvhQzDP5KYyaM0
	j+J+ZSg4XbfmvPZ/A/M8k66Cz16KPJwabzPaOYo7uVyZNRWYhAVkYuysFm9T2+/8ofdX0/
	atjWij8Tc1PfdxBwc2vsuz2lhBSEj5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-FU7JORNSPO6fYZOGemM21Q-1; Tue, 16 Sep 2025 04:20:01 -0400
X-MC-Unique: FU7JORNSPO6fYZOGemM21Q-1
X-Mimecast-MFC-AGG-ID: FU7JORNSPO6fYZOGemM21Q_1758010800
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ec7be07a17so246333f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010800; x=1758615600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzL2N1DLwKqBJMwL8CAS9ydZTfmXfd5ccrcFe6t3UgE=;
        b=f2+a0R9AXy/FgykB+0mxq0W/LxD0p3N7aFp9Ay+U4N9zh/l6MA3ivWnAMlq/Qo0ggk
         iwGdElw6n4WdBhot8YSvQQ7VdMZl8+UaXU5VRmz/XIOUSeMMuNR/43xuTRuqRoqwrFXE
         bFJQGaTM02gUmyn7wFUsf/t3D3gh6m7ML+2yytVVqIePOZYYhfYr0FmJrqU6WIR7b+eZ
         CwiOSfSxmFqAPuhnTKf77CmkGHKfp2Typq8Z/WX4EA+se0tId14i+EcrmALyVIZZmVAb
         FGHX+pBOjcs6IGt1nHwb63w+uNszmeeJZgIcqz0IswqBPgZAkBxAHeA2KLfD4y29byMN
         YQgg==
X-Forwarded-Encrypted: i=1; AJvYcCXww9pRiIVix+5Sa7XhT7xtuKuAgSa7uJkUjMuK4hQ9eoI7eUp14ET9y0A2rFCYbzyocmMqlBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEHKhhkp3QS1ZlqNWndFQ/sh//v554n2BlKXMrjVx712tk+Lu
	1E+6qUx9VApWgvLXfSHAgbW5cEopOvemnnRBPGkU416ED0BZhmVi02LvLofCCo4R6fzOXLJw8N1
	vjAePtdQeGD+9rYMRH5cWaF//cKpzjs5ygUnt2ULrPONHFpWcE/7S67e5eQ==
X-Gm-Gg: ASbGncvd84kUjwsDpvkO0JDCFcf0wM6vN+t6ZkP5cNzMV2QDSWjizEjVvTN1S/qGw/a
	ILtNcSFCCu+/ZSuqifTJZlTLDbHi+6yITS8tsUQhPgYgFeQXxPKY7xfoO4xvn5w9RqHMGC56L6h
	voDsIlKISp8dS2du53OrPf8d30wuW7kc4mjTN7ctj1qPIV196ar3juMkC7NhSqV8lad4eM1PGOr
	brVrEPUKCmTI2AcetKXQH7mbZSsuw+qRcqU0Fkr8sjZ/Ybn/N/EuHGtDhW9NXSwNwzf651aEbcL
	J0JotlI2de8oqHaSkqQTda0oL9qLD8mYtPAYGYOlvgM3IIFm/LhZvAaTKElWJmLk8lNehULtOP/
	n4l2VlrMAvESu
X-Received: by 2002:a05:6000:23ca:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ea5f764a5dmr4367644f8f.22.1758010799657;
        Tue, 16 Sep 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEno2K+NdUW6UjWVLC6LxT9P7Qfem/6TR6gFdG8F5R9GArEc4/f2xtzeLzakkVXchgcRbliwQ==
X-Received: by 2002:a05:6000:23ca:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ea5f764a5dmr4367594f8f.22.1758010799204;
        Tue, 16 Sep 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm10432408f8f.44.2025.09.16.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:19:58 -0700 (PDT)
Message-ID: <e50be1a2-4e9f-44b4-b524-706be01c97e5@redhat.com>
Date: Tue, 16 Sep 2025 10:19:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] dibs: Move data path to dibs layer
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-14-wintera@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-14-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> +static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
> +				     struct dibs_lo_dmb_node *dmb_node)
> +{
> +	/* remove dmb from hash table */
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_del(&dmb_node->list);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
> +	kvfree(dmb_node->cpu_addr);
> +	kfree(dmb_node);

I see the above comes directly from existing code, but it's not clear to
me where (and if) dmb_node->cpu_addr is vmalloc()ed (as opposed to
kmalloc()ed).

Could you consider switching to kfree() (if possible/applicable) and/or
add a describing comment if not?

Thanks,

Paolo


