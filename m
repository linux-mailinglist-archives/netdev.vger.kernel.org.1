Return-Path: <netdev+bounces-232075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774DC0099D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795BD4EA818
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81EF30BB9A;
	Thu, 23 Oct 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq22W/IH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8A30ACF6
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217208; cv=none; b=XPGYOperTJQ4hWrWv3q/7/ghs2CkRwD8WRiq/XKTie8ztdhYCAXEG10hosucVAwvMq4eNyv+RODFbT8oIOXITlr7g0nyQ6sleX1N7l6cppoWf0s/1bmQgqB8E54TSPLq3ilAVbwB7GnYI70vwkEcG/5RWxmritnLE8s7vMcZHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217208; c=relaxed/simple;
	bh=C1Pp292wr9u8EzQo5FGAynEK1LI49VCDkvagkZiSjy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loQKTIDbrPpMQs5iuxNlM1wOadhIyFc4t3tgu7FPoyVxKUzoEdxrEsAGl2x41elmypeRD9j/IbUl/IOdgZurfeucYtJQeAmeqTUSrp2Q1P0GdbQtZxhCmoYsf0aAh+aC2tbRli4EUEg/vB1ElQGrARN80I68cBLOKmfCFd27T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq22W/IH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
	b=Cq22W/IHktldJONEZayu10Be3rZLtm02DhF4991bZacAa0NAbjhzcL5+C5iQCX08LBX9sH
	7oD9FZQNOzVHsr+npiMt5kN6ulCZo0fNHq64ONbwGF+EyG8RHo0ZU92BJuDtwObvke8B0b
	F6yHeHcavOnc/HS3bDD0KP18cAphavg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-3jKVKHpBNAWvTWIZ3mGfLA-1; Thu, 23 Oct 2025 07:00:03 -0400
X-MC-Unique: 3jKVKHpBNAWvTWIZ3mGfLA-1
X-Mimecast-MFC-AGG-ID: 3jKVKHpBNAWvTWIZ3mGfLA_1761217202
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471168953bdso5471135e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217202; x=1761822002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
        b=QL9bTYpZfk1myPqZViA7ZxvJodxf5Uc5Ken2NNFhnU086qmY4EQz1F2ww0zP7eMmVB
         x+XLxb0Mnq0w82QBCb0LiHc1kklVK/oUOetQs+rpgWn098PWoD8X8Xx/XUGORAsWQ/cy
         u/ly/aPaP+Us3SpnIqrz+WqkR0QdeG4wqmxIro1qMvKDcg5x7Dumh1p4dkyRiz2pmrSP
         vCDErVsZOqQEgkH/WSLcFBdmQa3RfN3OUjEIi574lhMrc8nNQoODR9LJhbakPJDRIh8D
         Bo1XX42ZNhsbNTK3ZmJ5/NMOFVjz9dyBoUaJKfw7VLJO+i1dTmwBExLFn4oJy1xI2ThY
         Eesw==
X-Forwarded-Encrypted: i=1; AJvYcCU7KO3MfuRlQmParI9WhWcn0iVk5jMZQjzUhCLkShb1nwT4zdVy7wdmhxbl/lWSU7zhQHZbpig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84nWSo+BD9hudUZ0AjjDO5/X3man0i6GyjE+LkVCJY4SF0FGU
	mnu70xIIJLWEeXARBFY4DPWBiS2XhVakVX4EEf6RVYObKUU8DljfCBSsGKG/Ggr92K2IE+wxa0N
	5/N8vqo05VLO2pNaV0llxhuYVDkjU9sJWvAAUC4Pd6vF/9clKhLWdIkdeUw==
X-Gm-Gg: ASbGncuTF3ktNa2cCQCPxAhFXABpJnGnsM8MqxOHK3GzP12T5oyEsmHRMIVTCaqfjpx
	LkC0Ytutv14W5ZUfIzNDi3vB4uEzbaT9eMwZ6dzuqkXHxxonCUhZJq7g5rROaN6SHJsMe2Nvfro
	KvIuI7MeYdK7NEyYiyc4B6LnkC3PTJCwPz/jVcovw5mbdnP5pacUIQi0EtLQ7+xc6mX6a0XB5gQ
	vOuFBlW7iincUZAQxzaqpremcje928lOrK8YTEg1viYvssmZ4kTgkcPCZ1IL1GJL5okOrM89ylT
	v2pX+t0y4/9TF2/bIwc25/BBwv+wERGsdFAyjLcCwjGtbv5BZkongMo7RyEctv8fJXMyIquIFeN
	41ni+8ty3JBc/HkZmS/jYB/+u8Tww+0aK/MhROBByO+tepdw=
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330305e9.8.1761217202290;
        Thu, 23 Oct 2025 04:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVkcD6BOYZ24anCxqkCdENWyVIeDStBshfMtRIpeohF2t+fEegH7komx/yFzU5BEDs7jhjg==
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330125e9.8.1761217201896;
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc6esm3288915f8f.25.2025.10.23.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Message-ID: <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>
Date: Thu, 23 Oct 2025 12:59:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Another side note: please include the 'net-next' subj prefix in next
submissions, otherwise patchwork could be fouled, and the patches will
not be picked by our CI - I guess we need all the possible testing done
here ;)

/P


