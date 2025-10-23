Return-Path: <netdev+bounces-232059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40704C006BA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBFEC4F1559
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533CF30102A;
	Thu, 23 Oct 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py1ecGFG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699293019DA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214650; cv=none; b=hR0UwP4USCtDnbX0wlShjWLK/qOaHRjdLZ+0zOZ6iz29gCq2sFNWjzUOYaiZxjZs9Ycf6s2oOWz6vIQO/7ppi4g+ZHslnO6hTvc3Cnq2LR7Faol2fosa2xJm9REhfiDrN28nwo8xAmE8QnjFBoa2NcZSOrBBeJ8DGCx7jY8j6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214650; c=relaxed/simple;
	bh=SaXOkjj44KsPzP7FTIYWUkvqgupCP6+F02PzY45C/Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhRp9Ns9A1BQbmEoAXRvdEu9HmOqtQtOUXg34KVFkHbtxt9leJWFLHlm2PacpyqTWBoIyOK50aUk67JPHNdIVsVmTwFtbxXWFH9MfpZOGpY6cCGKUKRqWVCC70K6vrCSpL15p6CN1hj7Yh327pq2GvNNrt+KjXtL2RpPIprekWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py1ecGFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761214647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjTS7ITM5eNoZnzKqwLsP+1eY83cxIMzrNl1Nl1gq8=;
	b=Py1ecGFGw5dfl8KJyf6X/izi894uhVAZEJsP32/herMOurq4Qd2Nv9rRJAixduk5Qhou0P
	RzKhrZA3jzKiSs/krqfqrmPi70G7DkTm2jJDraNw3xCejgYUpkENiYbiyhaAQ/D2DJyxIt
	pDUrK9X742GxG4xv7hgIGRx4XLs2lZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ZhvyS64_NUG0SVk3wVAHLg-1; Thu, 23 Oct 2025 06:17:23 -0400
X-MC-Unique: ZhvyS64_NUG0SVk3wVAHLg-1
X-Mimecast-MFC-AGG-ID: ZhvyS64_NUG0SVk3wVAHLg_1761214643
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4298b98f376so231734f8f.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 03:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214643; x=1761819443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTjTS7ITM5eNoZnzKqwLsP+1eY83cxIMzrNl1Nl1gq8=;
        b=KEja3lljUVscQaMeCZbjZcaaxkcCAFchLgY4lY9NcrOoFbrBQxApAaRzdUaHCSnW/q
         4gXVcyX8j4uXsus8L0ZayWD1YS0WR9yTS/RYwc5IRsL3KOnOaO38SJEeXmVl8tM9hs2F
         YL+fUaUKsUapToJecWfZp5guX7iv2aeplaOg6Jl0zmvIlQnvURcc+WR8A/fIIFji6DzD
         eMCCShcy1dBxFi52tOyys8FQNgHqfy2q6/TuohbhaDlIPZ9dmxwleEa8E/2cBKeRQ41B
         k3dol4ZXDaKClug5Mbuy1JKBBAHHEi/QmNtamyHQmuIG8qPAXuFm5BMnFHVi2tkT6kEL
         7uUw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZxEBsKhMmV9cfkjdLYSX1QH+OUi0iFbQLh5LSrBipXiu0jeceSa7tPt9BaFqvOWpyZTDUJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcWvCaXi+b0FWJ7+CcpJ0kvuoo+qooQagLBzoccGvz9ZjFg9p
	8sJlXQK06MmUO/2er3Vye6CXtwG3iKZTCuv3ya5uvV1K7FsYpJj/CZ4BfU5FTKAcBeFKQzxameK
	xQ5d00DvBrHjIG2fLKGpl3FH37Xdl4xsGxdFAz8qDtRx5Wdx4u2cA3mDCQA==
X-Gm-Gg: ASbGncvRm3fEXxI1ZPutYTMTuffFH4ywV8zfiTh3yP/pWw3L6dV8xX6JjbUE3qVwoqn
	gjle0RMUZIArv9/YqMFvN6GhCFuFXU6vTEqHunNh+89p7igUVaBtKbTfEMoNejNrj6z1aiTAi46
	jQog0oispidmhVYpiT/6jQL8vr8o/gLtE5l7nR6G69S06QXBNBzioXvh4xup7AGGNY1BqfpUNlL
	KKNTZv9X/H8vmLgLnBIrDLhPvsjiPND/KTBgkIcUwLkQ0+y+oECVjTOCqppmocMVL56ZbC5AfsN
	SxO9NHJ03snQ2iGl0C3FXliffwKzucA0tncR6abOYq0ytuSemGwhHwilUEvfs13wfJQU8GP3NPz
	MQxCRv3NaL4KGhXYS1ZLan+MEpVSJ+M2OeNErfiPybwwkYYI=
X-Received: by 2002:a05:6000:22c2:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-42704daeba1mr15624644f8f.37.1761214642758;
        Thu, 23 Oct 2025 03:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy+UCM06cfKQOSnbHRidyNFTJpNDe1rcVCOoYg16ExjuarVIV3gX840vhikp4rbxjpMKykVg==
X-Received: by 2002:a05:6000:22c2:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-42704daeba1mr15624618f8f.37.1761214642336;
        Thu, 23 Oct 2025 03:17:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff371sm3129221f8f.21.2025.10.23.03.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:17:21 -0700 (PDT)
Message-ID: <3b091dc8-47ae-48c2-b7e9-ee3deea6d5e9@redhat.com>
Date: Thu, 23 Oct 2025 12:17:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 6:23 PM, Daniel Borkmann wrote:
> +	tmp_rxq = __netif_get_rx_queue(dst_dev, dst_dev->real_num_rx_queues - 1);
> +	if (tmp_rxq->peer && tmp_rxq->peer->dev != src_dev) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Binding multiple queues from difference source devices not supported");
> +		goto err_unlock_src_dev;
> +	}

Why checking a single queue on dst/virtual device? Should the above
check be repeated for all the real_num_rx_queues?

/P


