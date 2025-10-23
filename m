Return-Path: <netdev+bounces-232064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B0C007CB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B1B3A4BE9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09F30594E;
	Thu, 23 Oct 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7eON04L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4130AD15
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215287; cv=none; b=Hb63NIUS5Exdf0K1VvHrHJag7XBsEpZx88O51PiLE3BSionVl60alQGwCsy7YZ3eHtAPDR7LGN6oVubLjuL8i8tVfNg4Jv10mBlqNMfc4v/wBClroNTDYqd44tie/nT2XULcdap3iCva4UNTtvKGD5c8FIf2ETSWNG6w/PoCYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215287; c=relaxed/simple;
	bh=t2XBm2RDZ+fGSLb6wVsJDP709r8nUGdrXh7wf13qD+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo1C5LQMkJyrdWG/xYmopr7tb7yfoIPl7xzCuXX1GHnuEVM2krVuTD0PSYzB/ca1yMCF02U6UGvSi3EDbM/J/PO2OgFZEbP1PfrrTLyT+dzWNasDMa6jDUTUAuzZ/rG1+V/f/k1McBlqTl54V60vVqqcRFjsxSq0Q7arBRIHCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7eON04L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761215284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5P4TVWp9LJ4R7S0ueu+xxAf+h+jyoun5/P4L5KQH2M=;
	b=Y7eON04La3cX+jRdjdLcVsEL1YsOAdvk+JImWtqylrIdIf9Z0fIZ/HTScTypsStEBI5i3L
	AX4zEL7QdZQ7sBUA9agf6/XBNJh6673JsbP4+OvwNR8Em1xHbsJtUUsAZh4OUS/e+LXcVq
	RUUDuCQKuZfBgVKgE7/RMUkgn2ucOHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-KMfQxcglPXmw6B2p0-l4aQ-1; Thu, 23 Oct 2025 06:28:03 -0400
X-MC-Unique: KMfQxcglPXmw6B2p0-l4aQ-1
X-Mimecast-MFC-AGG-ID: KMfQxcglPXmw6B2p0-l4aQ_1761215282
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso4549105e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 03:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215282; x=1761820082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5P4TVWp9LJ4R7S0ueu+xxAf+h+jyoun5/P4L5KQH2M=;
        b=tQcSWzLD+9sq+jVjdCkkmHZgNzn1fAWeSFLJDRztRaBaCvROtAKuebfK47wKVbRyJd
         xP/CIuVJFFRqaXyAueFK7BeB2bXI5L//tzAT41DYsG0CX834DHltLteYFBzO+g/IEeQr
         ama/UrE9XWN0kMihDYPd+9uQ0tUt52ZLS/f7v9xf8AlHF6epRUO0pwtboln7GpkFFdxG
         8M4Q7dtSZthhARpgaaieGDQGBX0MmaLxwIGPIovsDQI23G3h9C9tV+L22VmUuG9dfe2C
         3HwfB759wuPDNbF/5CD/FOd8TxeNxOCf9v9xrk3Wmm7x/PPgea1oXUS+8kXLzIKX+MKh
         221w==
X-Forwarded-Encrypted: i=1; AJvYcCUDddnAUhYG8G/0b15f7Lr4WIFooLdyGrYd0ogPW6o65JNsHxZN5d0axqPs1Q50y/sHNLjgLOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4L7HE03g1zfKd8iPVLA+XPusf6CXxUAXEJf6gXJrm882zMWE
	fm7lYqkJ9UEc4/tVsgGUehHEcw0gTfV28RELjw+8dnpotj6bNYJ5aEUNJXvAQU3uSm3Ii1jyWP+
	d6BuW0H96ws9nB1ann8dJqGPccrbPZvsu+UQimSkjBycIwrkjBiUzndGYkA==
X-Gm-Gg: ASbGnctxgZMaGwnIwv+kZpVYzDHwAJCPXTwcCHEtvRMuKPTkW4BNi8uWIi9NvlCXdGb
	hZNLB80q5EOvfwz6mB9nltMWt41lLF4VLH5isxfsENtitpQNN1vW3gOwur4SLdqNYKVGly33heA
	5qNrq/+VesEdwG1x8NuoQgfTF4OaFLbvkb63pe2TkeaprRhZrjekSJa0/54WG+g2jYnKXOq3do+
	XJE7p06qmnVYsYlO8HJNS5bZrJL7ie0Rr8YkQUYGzZWnsbwZfcY87wZcJj5FhAGVtW1dxIKGPVU
	/T9Y1TqB5iEd9DtCwSU2ob38NvUp+7w1nTi3RgxZrl+ZeEVsSYPoPkLR/t69uWSAWAYLMwIHYrP
	0gutWyFQhYQVXLmB87xVumrh9vZvk0ao8bYrxzwxxFPthb+o=
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr178952495e9.27.1761215281787;
        Thu, 23 Oct 2025 03:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGK+0JT31H80kEiGPKgEcv2rVY+0jgTu6VC/4TpxBhsMsHkT8KH9pFxyQO0M1ETPaItKmYWQ==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr178952285e9.27.1761215281315;
        Thu, 23 Oct 2025 03:28:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm56657325e9.1.2025.10.23.03.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:28:00 -0700 (PDT)
Message-ID: <412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
Date: Thu, 23 Oct 2025 12:27:59 +0200
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
> +	if (!src_dev->dev.parent) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device is a virtual device");
> +		goto err_unlock_src_dev;
> +	}

Is this check strictly needed? I think that if we relax it, it could be
simpler to create all-virtual selftests.

/P


