Return-Path: <netdev+bounces-195221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13AACEDF5
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5C9174D13
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA951FDE31;
	Thu,  5 Jun 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YObJqro6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2C4A1A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120476; cv=none; b=XZ2OYhNSPw0GpqA3QH6FreWxeHIVLH0FVW9sXmPUcG8p56HtQsCxSJdpq5RxcAWQzAM97v3KB9tsAhSvRRpZVRrOko48hYVmdCzMyYVazznlxb6rZfRn8J2+b4w2xI/1M1AZ7Xr3+/ZY4nN5Y+lIFHbKmlsR/CkM94KU674E2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120476; c=relaxed/simple;
	bh=SihlFmMNoOXg25P2FXxSj0iLRomopos92yCSyJ+78rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7vcIVn0ioYpGy2plzgOH2sOVRjhGyErkKHWzyl1D7ltnzNAc4k92HJZ5uSF+FaOGK4MWEyp/vtQzSwGH1zatdxIWAVCHB1wOZahXyirLmJJGSOqb59HbZ7+jVAfiWBAEy+fJRBZT3rLAiVgoRD7oJLH+EbtJXru/Zbx019Mzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YObJqro6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcuhFfAWa11vawA8xvN15NfZq416k3c8iV3KAUqV11o=;
	b=YObJqro6zR8eiCx98GW8rvW3J6VD56XlNDRjkDBuzpOvWRui8fVTr8e7HDhpYBEcNlKkMS
	1xIZ2HWlXQIpKk6/l5O3xNBiRM9xiFpwOqb56xR+nGMCwDcanUOj2zbLzOH5kyB/azAN9U
	G3AMIGXdvTto9tmuPcAn3ZaqQQKAu1c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-hcFAeqFNM2KTG3NttJ_dlA-1; Thu, 05 Jun 2025 06:47:53 -0400
X-MC-Unique: hcFAeqFNM2KTG3NttJ_dlA-1
X-Mimecast-MFC-AGG-ID: hcFAeqFNM2KTG3NttJ_dlA_1749120472
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so346034f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 03:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120472; x=1749725272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcuhFfAWa11vawA8xvN15NfZq416k3c8iV3KAUqV11o=;
        b=FprSjeha2wLDGMTjlUG+cG3n5M9VBr4fa3yC28QANeWV8yLc5ug+lmF3WVWfnvJ1oP
         DSRYG6WKKNaAHsdi/CGF1k90r/0XvyKbFvwDSggix67OQT6Vl+VnGut2w4ZwqyQ7mehy
         qSmQL2BT90u+yldUnm/pkWepw0lXtNrsVeNhrsgKjdu1BqNS+Fz4M8pb8fbwV/MVDTKQ
         N5ii/rHOiYRewpBK0L5u2K2Va9nBYv63QikYs82RozxlPUyThirDUfwA+y9YhzTjwbsA
         vB1GMoMA1OB19zp6cOSSeDmBzKDbCwEpqT+S4sqTA9dftl7MIac6n60BzZgu4cXmhE3Y
         n9yw==
X-Forwarded-Encrypted: i=1; AJvYcCUo3wwfoy+/X/Knjx90J9TZaCG6k+NXzPwY1AtGOv3CoT3Z6cPHyGngtf8h3Xp2zre35wJXuMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGijy9oq+22YaMRVdnJinnj+qkOFbf8FbUh9+lfLvvMLWvJJeB
	rD4ecV6EnCy1mM069JlLapENE3KPnYG+veKVP+tED+rmFEngh9icfvudpgtNjEgYeyzCVb9Mgaw
	/CB0xDDOqr7ONy0fEEHwlslpuGX0uTcz/U8NrACJbpZ4xQrMvkEmfrmuiTg==
X-Gm-Gg: ASbGncvfxUmZOcPjYyVxipRGLJicvPe3lfjqtt6qvrI+DM7IB0XgjHU0k4CNsRkpaOv
	1ZojctgYG5mxh+G/yiPy9+ibv5jq7JtaRV5hSgZ2tZgmeJIWd7nEeLgMzZDhy1/veKYtLlLiXSD
	PB8EWQEt3YeZlg9L1vXDOZ5YGPJ5Xi7Q8xoS6kvlLgkdUTr7ew6lsSiRVmkxMHmPC3HUvEiP9Hf
	XyZGTwRHKeGnyn/UgbD0dz6lxW1zir2rvCA969yrU5Wy7G7D7rRo8AY7ikdgQdTJCU9Y7b9j1y/
	1a4vX9sGtSTh74fv4RA=
X-Received: by 2002:a5d:4404:0:b0:3a5:222f:c0d0 with SMTP id ffacd0b85a97d-3a5222fc378mr3756434f8f.0.1749120471838;
        Thu, 05 Jun 2025 03:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM7SunMX4sP9mfjfu660WBDMQErJBjFMYDMhhYxxnuiMQGd3A4cCG01NFowVJnvFViOezmuw==
X-Received: by 2002:a5d:4404:0:b0:3a5:222f:c0d0 with SMTP id ffacd0b85a97d-3a5222fc378mr3756408f8f.0.1749120471455;
        Thu, 05 Jun 2025 03:47:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a03bdsm24770468f8f.91.2025.06.05.03.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:47:51 -0700 (PDT)
Message-ID: <9c476d12-e494-45b6-a628-3c3871558188@redhat.com>
Date: Thu, 5 Jun 2025 12:47:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/5] pull request: fixes for ovpn 2025-06-03
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250603111110.4575-1-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 1:11 PM, Antonio Quartulli wrote:
> Hi netdev-team,
> [2025-06-03: added WRITE_ONCE() to 1/5]
> 
> In this batch you can find the following bug fixes:
> 
> Patch 1: when releasing a UDP socket we were wrongly invoking
> setup_udp_tunnel_sock() with an empty config. This was not
> properly shutting down the UDP encap state.
> With this patch we simply undo what was done during setup.
> 
> Patch 2: ovpn was holding a reference to a 'struct socket'
> without increasing its reference counter. This was intended
> and worked as expected until we hit a race condition where
> user space tries to close the socket while kernel space is
> also releasing it. In this case the (struct socket *)->sk
> member would disappear under our feet leading to a null-ptr-deref.
> This patch fixes this issue by having struct ovpn_socket hold
> a reference directly to the sk member while also increasing
> its reference counter.
> 
> Patch 3: in case of errors along the TCP RX path (softirq)
> we want to immediately delete the peer, but this operation may
> sleep. With this patch we move the peer deletion to a scheduled
> worker.
> 
> Patch 4 and 5 are instead fixing minor issues in the ovpn
> kselftests.
> 
> 
> Please pull or let me know of any issue

For the record, this did not included the customary (and needed) PR
boilerplate with the referenced tree and tag. I grabbed that from the
prior iteration, so no further actions should be needed on your side
(save eventual PEBKAC here), but please check the layout on next
occurrences.

Thanks,

Paolo


