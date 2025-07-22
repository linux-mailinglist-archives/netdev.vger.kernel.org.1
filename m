Return-Path: <netdev+bounces-208835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED06B0D584
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C14A1AA419E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0282DCBE2;
	Tue, 22 Jul 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTbD5IpT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD722BE7CC
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175628; cv=none; b=FvbmnX1kk0hX1Ti1PrBIEe758iYa231kkav0sJ7I2Jej9xiqhYaZaNGo/tKxlZTb67gID07ofBtCUGaqEtfrcmfqfFlzm2T7yMRIkchmuShKmUfFsMGG4zIywVEYlTGN2uwJ+3tY0zHihbTUrtAJIDGCqAmDcjZ/VuoEOqa6MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175628; c=relaxed/simple;
	bh=B2n5ZdY4BWnmq8dgSRdoBM07oIPGeT0nJh0yRSNPcDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFxYC/7WUYmqdfXGGtfRQqnYAAZNu0eur54U7mctog2Rh84uKzv8YqJ8oNZnDCngi+0r5w7B/qGfnsj0r7FOeBjjOzTKeS/ZDr1vvwvFikAW+WGikkBIMEbjSZNQIQT34vPilkX8/Q2jYkd+WYBgqZ4bh8nZLIZVB4DBZ7B8ZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTbD5IpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753175625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KUgQFDAP+t55lsxkHmzTDmsyAfOdX9/W5yq8F7vE3o=;
	b=KTbD5IpTHb43FqOlnEnCnQFqBZrEe8K1hXojPOERNhYqAukkgQsPs8HkhsbZmQKhpdH/IO
	oLYMhXVGqfOlYnvOns09M4S3jspeY7/QO2qqEkLG0SCbghl+b70gKhX13qe1Q8ncuX1q5A
	EjU+B3aVr5hDLlfUJlK3ZHKY6BU8HDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-GYp-hz4JP6ey_3jfnsOnow-1; Tue, 22 Jul 2025 05:13:44 -0400
X-MC-Unique: GYp-hz4JP6ey_3jfnsOnow-1
X-Mimecast-MFC-AGG-ID: GYp-hz4JP6ey_3jfnsOnow_1753175623
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626532e27so35176325e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175623; x=1753780423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KUgQFDAP+t55lsxkHmzTDmsyAfOdX9/W5yq8F7vE3o=;
        b=unAtCwXkSkyJg4AMwJ/PE3iljmImNCb5zJRgzV8OMD/N5Rs/ZuaB0SGORuhol3ODN/
         QToWYABhrqGbq+vmZjNr+7rhoUF6YTAATE9OnL05ATKku09MG5q10wJZDnPpJQttHr5E
         I9nYtKpfBVGma5WN5KCurGKrePqhfQemKRN5X6VXjPIcUgn8t0HVTs/CNuDJ0LQ8fcWH
         qHWBGobeGItRdVYyav3T99rvDLK3By2xEPFizdsMEwnX7CK++JE+HUExaYHmfeV1NUUs
         cWTeZazonnpanFX2lloOXjCriW+evU9Kj2z+qRhvD/xcNTCc5cx9S6AtGd+5v1dKThxX
         YJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5NOTTIvtiDI/r9S8YfIsgVftCY9oKqk0z7t6oUowwDVeWSsQQRGnOBu59vQzi2Cbjmisp11U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNN/4acfYD0uagznV5bfYvkWXhRJORcNOCXOR2ISq0agSMd2e
	CgVJO5GvwFYNEmLod46T+jcbyxAyWUbCkiM9sQih6f0f/i2M82hmKSX+S6jVjBEBARCC4pd7za3
	mSf2LZQ4mKSuab2WOMmnMfwhdatsPq0e0l72IROI/eTHfMK06zYrrY45sIg==
X-Gm-Gg: ASbGnctEawwaM/E7+nJsDr4ijvt82KWkbVzeijalpXa3qlbbHeFnCSYeBvQLfnnn7MD
	ZfUak6+eA9E00pmfD3NAlNddRTD1B4RtJiTzymRZ0IfK5X8rzY8HlBzJBawKBURbHdekq+ulCQe
	298xgCSSbSkfADXxUcMe/kpVZ09dRHtHQfu3t/wusyNZo55XavaxVBWLHWp3xjfSYriKvBLjUGc
	KLFiI7XcWIgLQfS2NrLoGZv0dQN3XuC6j2GHDGkZViN7TMYySJHS2EOkKn4jWq2FxQmbGLYcDdA
	6Wpw6MWEeQdh/t/G0sP2KVju3rr9tCTHg6Lp3Ekc2G+mnEej03XIlUaoW+yyIg+s9bKMc9Q21Lz
	TSxFVz9nR9GE=
X-Received: by 2002:a05:600c:64ca:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45630b6d6dcmr221103155e9.30.1753175622746;
        Tue, 22 Jul 2025 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq2utjYDgYZbdBZDFtzvubW3FftekBDVtDRK28fBpcCfuSioqYjLDM06EFbnwhSuf99i7wcQ==
X-Received: by 2002:a05:600c:64ca:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45630b6d6dcmr221102735e9.30.1753175622268;
        Tue, 22 Jul 2025 02:13:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45862d6908fsm10825645e9.1.2025.07.22.02.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:13:41 -0700 (PDT)
Message-ID: <49c4e674-ab1e-4947-9885-5c73810368eb@redhat.com>
Date: Tue, 22 Jul 2025 11:13:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] ptp: add Alibaba CIPU PTP clock driver
To: Wen Gu <guwen@linux.alibaba.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717075734.62296-1-guwen@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250717075734.62296-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 9:57 AM, Wen Gu wrote:
> +#define PTP_CIPU_BAR_0	0
> +#define PTP_CIPU_REG(reg) \
> +	offsetof(struct ptp_cipu_regs, reg)

Minor nit: no need to use a multiple line macro above

[...]
> +static void ptp_cipu_clear_context(struct ptp_cipu_ctx *ptp_ctx)
> +{
> +	cancel_delayed_work_sync(&ptp_ctx->gen_timer);
> +	cancel_delayed_work_sync(&ptp_ctx->mt_timer);
> +	cancel_work_sync(&ptp_ctx->sync_work);

You need to use the 'disable_' variant of the above helper, to avoid the
work being rescheduled by the last iteration.

Other than that LGTM, thanks.

Paolo


