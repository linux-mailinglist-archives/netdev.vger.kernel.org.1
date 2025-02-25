Return-Path: <netdev+bounces-169446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51616A43F75
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B819C16C7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BF267AE8;
	Tue, 25 Feb 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N06Xrtbb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3F267B91
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486738; cv=none; b=h5qY4tekY3qKOcYGeexLdh57IEzMRtryeMSRUdc5KqTnESzORxLFPZfrWQFAKhC3wN8D6vzc9RtgpWqkmkrKQnivpYfZ9mPEvoHh5Zy2ViKGnZsnDryzsZ7nipm8NTnVHqV7vkytTzJ1djqZuv7A8CeZBIK5m8oJvJ/Y1RWh3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486738; c=relaxed/simple;
	bh=LP60O3WnuTx835fgp+4YpihIg90RNre+B78u3Fcgmc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXUzsNdNAoS0J7xuAI5InD68W8acB1IKqO9JsJhBBOqRet42RMqxBSV7y8FBJfndCq4yG5jv2Lbs/8t0YjNjTag13aSWlBPcR0EUtzrbTrUsL3m5jAM3xtecSUOXdT5iqqsEJKeNpc9Q7v43wZ76/6OksQ8DB8dGrD7nOcZGA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N06Xrtbb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740486735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LP60O3WnuTx835fgp+4YpihIg90RNre+B78u3Fcgmc0=;
	b=N06XrtbbfBpVINwDlVJYBP5lvB0eVsuaeE+Ntps7cXTjAmDQRuWjvCi3P33Z0s4yQlMcOl
	RRnuqCAWAWWqMu6qIP76Dc73moxVOL1eKFOYgcdtLO0fz3pYXNM3WfY5jGqeEv85BNQSj4
	tohJufRwRdm25vOxuU6zFR2VkwOT36w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-P5nYJgCYNu2NooRK78nqCg-1; Tue, 25 Feb 2025 07:32:13 -0500
X-MC-Unique: P5nYJgCYNu2NooRK78nqCg-1
X-Mimecast-MFC-AGG-ID: P5nYJgCYNu2NooRK78nqCg_1740486733
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e180821aso28191725e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 04:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740486732; x=1741091532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP60O3WnuTx835fgp+4YpihIg90RNre+B78u3Fcgmc0=;
        b=XtEA8WdESeo9bgRm0w2NDGSRfkJ5CqtJEaEnrduNQ6q90O3hxpdjHQo1zq6MAcdBE4
         AhUZscnDlLYbUqntdurpLig4tlltp9nzn81kqRuSSxYcnpnYGCq0YUyNQ+SV/mWeRMgX
         Jzvelk1OwgKTYoZAvX+cdfIg+DznEq6+yWuAbFad57atybjWpcA/FVHqKWyNK0PWtt2D
         VsKpOPrX91lDX5gQiPdRH7JvY0X2AL2f8RLevZQSwZCsJ34CzgLzBONKg0XUtPvCiT5y
         BjpMx5gJ8saA3Ms0w6SK8ILTTyE6wyAP2FmgL2ngDdgOCAzbftJKRHeIUPUUm1jUHWtS
         0oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQLvaz6hYfhvxE8d4p3FuNLPghY2fWT08J4o7kX4Yn7yPyhNhTQU1VKkYA/3xeMcPKGSB85o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxgvOJa7efZu4W7N1jrOvcJ0cFi1oE4Y17r9GRgO1bEpwQo8l
	DW0BMwJPGCuh7vftMuHPAAEpfCKFyfz3YEpdz5mxeIWJ5RaR8FnLVwzGGodxfnR6D2ithxBFPRD
	l7JgrKOOoFoVk5f57jGID4qEadnOWCDgnqhbgDMBbMQ16NdJvw9zqBg==
X-Gm-Gg: ASbGncsSOZBClo1FoN+iGviLInaX/QVXpZI8eF2mkVMI6IrpH2bpOZI3hoRLOE9nQSS
	VfRPa9xvgLz+Tq4wpu0bpoJsJswU4ViLNBrQBUKifhOJcqfpsb4yOAQD0RA9V9Eq1lTzKqJ7/Mu
	e/AKsRAvRPNuS4CTW1VTuV1emkKD90aUWjj3Ql2CNwJNK8PgqhH+kgQKN5QZIS3HFjBPTF8MhAr
	v0PsywFOdLYEqjKxya9R8iSsAczvxzRgfGS7EPu6kItp4VQbDaBmsgKZjPIUY8GWmKz6EZHQkUj
	ktvPzRbgYS18yDrcFEi6ch/Rnu2A+3fj19hTYAjDFlc=
X-Received: by 2002:a05:600c:4f85:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43ab0f6601dmr20938705e9.21.1740486732688;
        Tue, 25 Feb 2025 04:32:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUB5c9hdIlylN6JPp6O8VcmO5KO4EEI5sf0StQXkyS0acYf77zUG+YXDpjr3Rs4rUD7naZxg==
X-Received: by 2002:a05:600c:4f85:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43ab0f6601dmr20938485e9.21.1740486732272;
        Tue, 25 Feb 2025 04:32:12 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm14493675e9.0.2025.02.25.04.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 04:32:11 -0800 (PST)
Message-ID: <0d01c507-f97d-4d62-9f9f-add39cc13eac@redhat.com>
Date: Tue, 25 Feb 2025 13:32:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: socket timestamping: add Jason Xing as
 reviewer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, kerneljasonxing@gmail.com, kernelxing@tencent.com,
 Willem de Bruijn <willemb@google.com>
References: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250222172839.642079-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 6:28 PM, Willem de Bruijn wrote:
> Sending to net, following recent examples for MAINTAINERS changes.

Yep, the idea/goal is to propagate the relevant recipients list ASAP.

> But note that the BPF changes are only in net-next at this point.
> I can resubmit against net-next is more sensible.

I think it's ok this way: the 'dangling' F entry should not cause any
problem.

Thanks,

Paolo


