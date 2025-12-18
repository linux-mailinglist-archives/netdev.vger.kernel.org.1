Return-Path: <netdev+bounces-245428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1AECCD166
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8C3230536BA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676F307492;
	Thu, 18 Dec 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKUd0Y3M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRm0jJYW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCD286419
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080613; cv=none; b=WK88ngjZA6EdYA1DKeEqGS1BWTTHewQXVjCYKVAQtSKRbm6pxg7X8u9DPWCXVLp5N3Lna5jT7m0wdnEGBN36wyrPZu/wlP44AyJrpmDtNEH6QJvSegWpJ1Oc6Blra9JbGCUfwoQzi139kp8dov6iPRbsnDKHVyVpjpEVjr411IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080613; c=relaxed/simple;
	bh=6/yYhYgQ6pJfdfJ5AfFA19K8ef938cCAQ4eaqPxSS2c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KgVF1G4sxrnzVK7tQinLQvVjFIQeNJTaWYaKtSz+KR6AbE0OcI7v+6gF4sUIoyiwTylUbL8Rv0S0CXJg4PeAc0cb1rBiQWgdvnpV0lX/q0keLCBOFdZQ4Vosh1JP4nMpqvbhOVBAhqhGORXmcrRTzuNcxn3pkAjX7AwMnZKQSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKUd0Y3M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRm0jJYW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766080608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/nvURuRbYGEbBrNcHxzw5Vx6JKRAxOIX2icgNRxbPo=;
	b=ZKUd0Y3Mort7DQj2mRIZH2kNJrA48R3mCIJ84pz8jL7L07Ve1fN1Ae4Gfo4fIupaPxGTTJ
	qkVWkQz+dbBFudaTpmh5qeUWoJYDLThWqdvGpm0/nHmeRtSP6om1wrRVcjqTNFAsEB4v7f
	jUg/h9a8Fg4x08VxzA2K4V++IautFE0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-rQdvyInGNh6WmlIjAOionw-1; Thu, 18 Dec 2025 12:56:46 -0500
X-MC-Unique: rQdvyInGNh6WmlIjAOionw-1
X-Mimecast-MFC-AGG-ID: rQdvyInGNh6WmlIjAOionw_1766080605
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4788112ec09so9429955e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766080605; x=1766685405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/nvURuRbYGEbBrNcHxzw5Vx6JKRAxOIX2icgNRxbPo=;
        b=PRm0jJYWJaRqzPBGuCLWRY4uaJvy5oxquY3WeaatuKTBTbukxA2/42FNtRXCodYfin
         IjCCM6f8OP47IZn+Y+QZQwNi24h9aMSusVn63WWMP/vV3w/YB4MiRf5X79XUTC5dm08o
         QW2SN/XIn4VUdrTpqi/kysR5mKQvSFuoabei9kRpJBQtDcokXfofB39Tss0/iGpa5bkU
         ww5FIJCvG0IhPcJIrWgYmVFAapg3jT75hhHtL5b4vZEeuExwGucJDrsIIRfKwtjPqzsJ
         nj32qXS+4m5npc2gxVIz3z8GmkHMMT/AGp4kHhicGdGRwc0bdZ5AXeWFerNhOxyan9mx
         ryGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080605; x=1766685405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/nvURuRbYGEbBrNcHxzw5Vx6JKRAxOIX2icgNRxbPo=;
        b=ZjSjyyRL1449emQb4SRN/wM0Qtfm9ogt5MIgxRfv/MWIHjWwW8jegXfQh4jzCKJ/s5
         QfsxLtpkW4l6+h47Am4KZg/P0lIEKDY2nRATkO/HUOQdpfYvI8gICMFdb2RKMyxTLwKD
         NY7uq9t7oJ+HgA3ND/2TWPbAY6o7hk/p8QK/8DFc/1C6rfP6wbsxOeXFj/zDlLTCj8Ur
         8FNBWxTkW9hzjfRpJE100XcPnlATFTtFlCkSuDF7Ks7yHL1gFBHLZgJP5Qh+EDxsnbq0
         AvVATUIw1hvd9Ml0dW/Xo2+T9ZtaoR+EjdBhth4ViIc6rg5K1VfqQP9N0nhrQnpJzmP9
         aiQA==
X-Forwarded-Encrypted: i=1; AJvYcCXOe/nONiseXXBdj5DoUFhU/ozPh/BlIR6YSD/RAadaVCHC1PwOejMSqWC6Vr2f1INOupe3eEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Pit32jbNxbi0JYTu7OC9yv/Z064X+1+/TzkTs9wd/XI6yaJ+
	LEzySu9XG+D/P6Flbj/aeenOqhJY0dsR4fTR2ACn4kONvNwLGpxdVPpbGCB1rntg4CFTosJq6YU
	Nyf9qoNXLUBGBhEzTF+SKEMDipDu8z1y9lz030OldDxFbLj4DHV699yFQCNS2o+ON6g==
X-Gm-Gg: AY/fxX4VWecBjn0qJ+F5qBdMFHszfhGLoLvMaBk5DKE+wTLYDHRSvn2m7MkFWxgwwph
	cmuGPgYh/6pPXowJ3YoSW+3crbzkaB3Ejgga1oo3NAEllg0740mdK3yMp+jy+D8FEYOeHvE0WK6
	ywFNtAasOvv8ASNZP9I86yQIiVihX2L42YYRjWd3m0P0U2RQuUMLkq03Mth11ucTtXM3nvPQnza
	kbDbFubLfjxof67JEe+/xOpjh3qqm3IC6ho6rteyvcO9V5+aXr+cro64l4QNizFrTRtIfDabu3Y
	XTmt9qJ5J5q0MszyMxNFdxiIzQMJG0uw+LMACuI1f5Dk8hATkCc0+7tO+ZNCnuKvscyW3x9l7C5
	JL8SMqA9DTJ9HkA==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr519265e9.11.1766080605064;
        Thu, 18 Dec 2025 09:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgrcIvWkP1nwIsKEGREwejr5QqQNqzaS7u0C87Pmc/WQW141qPxXzIEEN1/zjdt3jxifaoZA==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr519055e9.11.1766080604714;
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aea77bsm17333035e9.17.2025.12.18.09.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
Message-ID: <dbb8af8e-7330-4130-a62e-e05f490f19be@redhat.com>
Date: Thu, 18 Dec 2025 18:56:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.19-rc2
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218174841.265968-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20251218174841.265968-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 6:48 PM, Paolo Abeni wrote:
> The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:
> 
>   Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc2
> 
> for you to fetch changes up to 21a88f5d9ce0c328486073b75d082d85a1e98a8b:
> 
>   Merge tag 'linux-can-fixes-for-6.19-20251218' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-12-18 17:23:07 +0100)

I have a question WRT the next PR (for rc3). The usual schedule is quite
unfortunate (25 is the important day here) and I'll be able to process a
limited number of patches in between. I'm wondering if postponing such
net PR to Tue 30 would be ok for you?

Thanks,

Paolo


