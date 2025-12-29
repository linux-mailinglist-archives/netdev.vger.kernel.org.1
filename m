Return-Path: <netdev+bounces-246248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344CCE7B04
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 17:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7606930049C8
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4A2571BE;
	Mon, 29 Dec 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBgBn/rD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hcv+ZOwk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DD225408
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767027002; cv=none; b=W57UxYR/nCfsX2/syem5uE3ZaTaNev/i+8ryTyL3XrICPjXgTEgg4Punyb7alPmSIZgScZExFU37OTdeuS64tHnUDDtz2NyOXTREb6WKxAbtLhTp3h1SC6E13ku5idbZjo6nH9OuyV/ubZNimCEmHlFODQj3Dx4ZFi8ftyR6FvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767027002; c=relaxed/simple;
	bh=AzM6WD0MWK/FsXIaBNhCGFJnSwLcid0FzvS40MnMtN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StCwGQa0CDpLNw8UfRkZIPW76s3dRCXvHAVxCb4EjxFxlIdCl5Go8nMT38ArgtsmFexNuOeePGbe7OkwgYgIThw1/OyeWqo5g2tSIR6h97ZHz+kPhvUPHwPiyG1mYzrMx/1eXwvcleI2R9mDDjhSyhiWJq1byrNcEhg4hNlbbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBgBn/rD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hcv+ZOwk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767026997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao5ZiA59EOBjNczYwa6EnPilxk5HejHSrqqhhNpo/PA=;
	b=HBgBn/rD/U0Xyqz6tYY5N8lwsphFIeGdt+CsNdjugILc+BQxORvGk+x85DYSUQyBAymYOZ
	x5Tz00ePOoE+CPQ7JagmYYsm/CwsS0FJ7eELIH7Zk3bFem62dl14gBOa0VqjdGqQnctqf6
	mkFhByvoH5BHuV5bWOOE9At//8qc29E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-B0lx_sfoPrKQuziEoRt6jg-1; Mon, 29 Dec 2025 11:49:55 -0500
X-MC-Unique: B0lx_sfoPrKQuziEoRt6jg-1
X-Mimecast-MFC-AGG-ID: B0lx_sfoPrKQuziEoRt6jg_1767026994
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so54136155e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767026994; x=1767631794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ao5ZiA59EOBjNczYwa6EnPilxk5HejHSrqqhhNpo/PA=;
        b=Hcv+ZOwkouKBzgdAqir15hNRiJZdsCmZNCcTqlEuba92b5aSb7Bf4DwocEeFHmhLLW
         MSTTuC28blX+sSiDH6BgWygcddNcvP2+0RBgoH8WKfmYVYgeFT2WR00XD8EBjfM8z7nn
         /YU0DpmUscd6Ci7NXVITqe/KE8NQej34mw1pc2b28whz5m4yrU0Nt9b5KvqMJaZ+cO+8
         y1Ks+h4sk6DX1DIThJpsD2kjiU1Z/2UhJYV1ykLkkieDQiVXxZwd6fwpQGFT86wLd2La
         Lz0s8Y+OC4xU8KLfjqO7nsi1XOXOqwnw1FhzsrA0bbDBY4A1n/S/9NK3lQ/Sdrps70LG
         MZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767026994; x=1767631794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao5ZiA59EOBjNczYwa6EnPilxk5HejHSrqqhhNpo/PA=;
        b=Bz2LKA0il4oyPj11ZNn12ZNBxZJB90kK7FzkmwNXf3b5hnjyEeuPlxr4l4Epn87buc
         xztRw0Dk7ZU+UINcVxegmoYkOP4hinTUtnvF0fPRxSzvpgLthmKwWK1Dv+4rTftfxXkJ
         eW6uk5TPf8aBnb8fVLX5wKR13WD5g4s0z+WoiQN8TSOwB1SI8e/w1wMAueXxg6CI1YMN
         6mMHmUTU98x7lI1XeHJIhqFYg/6ErjrCiE6PHymrva4Ai2EltAD3JGYd8WyqklbJyAwb
         ErnvBEFnRGMD8F4q8wJJgNVN06ie9+i2eMnnaXfEkJjG6d0Aagyq2aglCzYljHeCQDnP
         6/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVMmrMYgBhYOGkDzIzkZ5hC7xd+tX5loWEvTry7+Rv5nf0I8dNKWmy5BWyKzzXHEPwjVI8RRfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37d2CmDakp5KAW/Z4MyQygv3Y9/zRAyz65rCGSpATb1K7ilNs
	UeGu64xlSf15jtbbMHM1T5B/vZsSajPzuwlAwOedSq6aCN169+uUVLg9cuEw2Sb2jLVH/xGqs3N
	MNHWcZh6HLc2GKn7OTccMwsskRYoC94+eciGp9OUO9SKww4vyPusGbt6PMA==
X-Gm-Gg: AY/fxX57cgRGVrV9vFlXuhY4FLS+26OyBBAENrcVoU0fZh1SW6zx2+oqEfgAOlO3PtN
	aYeCfmYsxiEVH/Ldvpx2pF1cah7XAr+OGaV9QA69apTYSyWPuwFh1MnGmZn3MpsE1Tnix6GjX8h
	iUSqdzWuJZAS4WtYrEVF8eIs/2CFuOI6lFdKq+k76194NQ+SubSpaXmPUGIVINuXkYk8JShWhfF
	alf1h1rCfbBfoRy7+TDmxgx5SQjd+NGiefSM9eptFdRksh8ebHnHMHgTARe2iDlNq0gRj8tCXlz
	RpJ1dQz/pdzpLT2mIqEw0IV2GkALSKH7WsRhv3VGa4PuQ4cSKzCSTMizd0gukByrQGOu55j8hky
	qXr0zcIetF8N4Pw==
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47d1953345cmr320162985e9.6.1767026994318;
        Mon, 29 Dec 2025 08:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5jir29sqSnRIa+dGezdvLian1PT0WCMBzRUGkyPlPFW7kXWMbwx3YRZNHNwgZydq5E4AqUQ==
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47d1953345cmr320162705e9.6.1767026993899;
        Mon, 29 Dec 2025 08:49:53 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa0908sm63089701f8f.31.2025.12.29.08.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 08:49:53 -0800 (PST)
Message-ID: <686e49cd-4154-430e-868b-fb95ff881694@redhat.com>
Date: Mon, 29 Dec 2025 17:49:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] A series of minor optimizations of the
 bonding module
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, Jason Xing <kerneljasonxing@gmail.com>
References: <cover.1767000122.git.tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1767000122.git.tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 10:50 AM, Tonghao Zhang wrote:
> These patches mainly target the peer notify mechanism of the bonding module.
> Including updates of peer notify, lock races, etc. For more information, please
> refer to the patch.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


