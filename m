Return-Path: <netdev+bounces-221221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1EB4FCB0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F1C16AF7F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976130DD01;
	Tue,  9 Sep 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUA5Vdgf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EF21FF39
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424222; cv=none; b=lYU8ZjCuPLP5skj7his0mlzjGg1voIxqA9HvNbqyLRJy7W/vqTLHpHOHclEn27YV0FtGtjvAuDB1QYq04XruIVLLkMt8wmZacr+DYfdTL6caMYNN20XqDG7VeA9X6Pc/N2DaQra7rSjewXh5YwVQILkcjoYvl2dsNiSATk3Llgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424222; c=relaxed/simple;
	bh=98DC4HCuoz5CgwoSAEnSBvQ2aXZh8I2kr3Xii4wbUfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbIJ3S9pCoBRewoHC1q346xj+t7BBkIjuxHoc9SRli/ZMhhO6XPn5qdhSrxYUbz13PdxO0jx3llwTCybS/H+1kg3RabpzzO1j9r21qkV/8GwMkuTkjQ41KWRxnR/MpdgHzRSpYgNxvA1B0TQcl3iPiQlo2tUE7nfXcJ0Y05HjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUA5Vdgf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757424219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJpdbNvyL+Z18OtxBUxsceBDgPB6QJ9laM/iWa3uyTM=;
	b=gUA5Vdgfbmk/PsJfBlPf+maGhO9GrhorhGilb8m8M9QPMM3fSeKNvsJnU+RIZvg2EhnTsr
	diCGpP3vqM0ZzUMzxi5YBb+QXGdBR7Tau8KKDuOahtcID/qm80RdQTSkUCpLyc0l9LxpnD
	8rn+QqUA4c6Uoe9ycwViL0yJtgl2OIs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-26LrVnhtOvu4oEteY1Vhiw-1; Tue, 09 Sep 2025 09:23:38 -0400
X-MC-Unique: 26LrVnhtOvu4oEteY1Vhiw-1
X-Mimecast-MFC-AGG-ID: 26LrVnhtOvu4oEteY1Vhiw_1757424217
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd9a66c3fso9566855e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424217; x=1758029017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJpdbNvyL+Z18OtxBUxsceBDgPB6QJ9laM/iWa3uyTM=;
        b=jN5y9q6p7sJ+VxxnTn0Ulfxy/MAm854IH63Pk8t57ejTsk1a0KaJXnHcAb3SQSGLya
         oUMG6g4O7LBVHBlm+Z3mEZO8sKFiwEiZYQfZHVdMCHx1nnswqOVjqnCKtRPGPhQlqyUT
         +FECJf3x6AS+DVs0/zNhsxbUKZslQNrlWYK8aTtT1tq9CO/DXUgCtigWCIveK/ybKX6x
         mlEHLqictmiOA3kU2Bz9S3qdj0N1oHteViyYeLaQ0c2W+UiJ0Z9Xqwhy+X1QL9enb9Yb
         94ZtDJpq7KYA/yJT2+HR/eMGO6SBSE/0jhmWRLbfNsTPoE3yPkC/gjs75KYySjLnIsqY
         f51Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf/Wn/2P9sDYq6WqGQV/Yba0lu84ZqFKdpLc5ZJkY1iaLz7/pdVZWq7UUArTVD1R0CC3Fzmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHherJZZ+xshmbrWLFOrRrpHd40Gx3DvZpOXC+CRJdMiwj9rP
	wo+i78Hx4f6gHNTMEWwT5ra+Zqwm3lFq++HbfCUJ7PZdrd8q1jHigZEDl9vvxLQ5vW6Tgp6us5Z
	EEBdJRGy4eNir/WjvbT32aw1oQDIl6A1BjTus7hbnE/1H6hLaTJB+xruC4g==
X-Gm-Gg: ASbGncv2zcf8RlplWEbTkMWI3WdB0lt2iLdYPbllQyKGxx3q1bBF6jnHir29ndIxpoo
	TAtzYSI9kjzAJHGSqYDNIJC/TlpT6U1zHYVHGUDG1bQiq8TBsmEhOAeQLaySsbBkpi2HzRSLbFX
	SEZZjuvqY8EVDEwcxsAFhl9ELP/5Vyat++PKSoAyPAzHZzqh5fgA3SFPNgdntg48HBNBK1SmEnc
	WN2wD4dzCn1tP7jVcobLRsjreXCaksJHxPqgpOoUEy/3jWulC6AbOtSuTXC1P5T7nYRbb5CN5OC
	qSD8z1PPRJAhwcY3LI5c+41gBgjd1ZSFyRFUUn8DxNIU2NYeY5535IjM4i4wqODBsQCs/qMkGHQ
	npAxUxe0CI/o=
X-Received: by 2002:a05:600c:4453:b0:45b:9c37:6c92 with SMTP id 5b1f17b1804b1-45dddef02f7mr112976925e9.31.1757424216743;
        Tue, 09 Sep 2025 06:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHzLBbzzAcsotmseUpx3KCNv9WVvoz0FeEFM1JEBmpO4AzKKO5+O18bWhe1dW9n+AkeRacWQ==
X-Received: by 2002:a05:600c:4453:b0:45b:9c37:6c92 with SMTP id 5b1f17b1804b1-45dddef02f7mr112976645e9.31.1757424216377;
        Tue, 09 Sep 2025 06:23:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca20dsm2915616f8f.21.2025.09.09.06.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:23:35 -0700 (PDT)
Message-ID: <8c0b5b0a-60ee-4ed4-b439-11d5c106ac6e@redhat.com>
Date: Tue, 9 Sep 2025 15:23:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] bonding: Adding extra_len field to struct
 bond_opt_value.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-3-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714225533.1490032-3-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 12:54 AM, David Wilder wrote:
> Used to record the size of the extra array.
> 
> __bond_opt_init() is updated to set extra_len.
> BOND_OPT_EXTRA_MAXLEN is increased from 16 to 64.

Why 64? AFAICS it will still not allow fitting BOND_MAX_ARP_TARGETS in a
single buffer, and later code will try to do that.

/P


