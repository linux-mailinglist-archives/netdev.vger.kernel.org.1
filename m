Return-Path: <netdev+bounces-239504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD1C68E43
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 518B3348FF7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EC2D7817;
	Tue, 18 Nov 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arQ2Amy8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nKVJ0bXE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F323D7F0
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763462511; cv=none; b=t3PtQBuZMLa75dpF5v8LfMuI93Lzcrqk4IfCPLNi78zEIQpxaoFaluaekacTdcHCovzuv8bJ6jCbxslojqldfQ8yNXQUeyKC5GdymAXrLqq2YnuiCTuakKy/qZVvZkLCWWrg6k4dbEhsdgxk7AY7h/D4gQlKLYrG/iTMSUWGx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763462511; c=relaxed/simple;
	bh=1VlVsWjT4e5GogE/BiL+60bYtrOkKXu8NWe3+ZNmRns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luGC2i6akE1fSDwrW/ZRX8tbfYLEd+lt79l95yHqp5jQy6spIMBlfdR3f5L+6HFv//yqPTPfMp29uThfGZbyLoQWZMzbEKwd6v0sWhe175v/eszv7r0dIOJoD1ybpsvD+E0QtDZjVDaDoBGCmU63DJhkeDYuSnznSNdGTgqjIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arQ2Amy8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nKVJ0bXE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763462508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZFGFOqqVwjw+gOO9Lnon/GlI9sz/PWpIcbCycKz7EE=;
	b=arQ2Amy8cQ7MRv97zMmlj/fvHl2eIbm7YmYW8fVmgRngQMPdXWmZBzNlvappO5KHHIXOSL
	0NxIFRNKPop+/nwz95UwWA3l4UWJU3yqdLHg+qWfhyndFUTGilcvypbFaAx9q6xh5lAJ4v
	+antayxOuvPT9UpBeJK5FhdYfGvg8e8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-wIuJlJfYMV2EACZXWjceAw-1; Tue, 18 Nov 2025 05:41:47 -0500
X-MC-Unique: wIuJlJfYMV2EACZXWjceAw-1
X-Mimecast-MFC-AGG-ID: wIuJlJfYMV2EACZXWjceAw_1763462506
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779981523fso24013835e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763462506; x=1764067306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZFGFOqqVwjw+gOO9Lnon/GlI9sz/PWpIcbCycKz7EE=;
        b=nKVJ0bXE0hZbfwY1qaVdmhyjWvjn4mqALjiE8BJI57BwbdOiex+Ltt1C/kRoNOoD2y
         hHBz9HnuzYo1BpgE7Xg+6331luwN52LHqnMHYW9ha30D1PDm1tOCYL2+E7wKppAc1MLN
         oveOR4cDPj7o8P4s0sIrKeCTJnZuY2Z1NiS/GKRqQ+tkebx9Rk76n+ETZqi3H/sZJRH/
         oSd7Fv7meXl5m6/XL36hmaqTYL3fcqUkIB5P8XxlVC33H7VjDH2fKvbzCnB2BR/cBZMR
         xT7BHtHAQ4aLgUnqotdXvgQKCGJLm+14tE8xbvSlF0sK3uvl4zvy++sE8u1LgCtcEnHN
         f7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763462506; x=1764067306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZFGFOqqVwjw+gOO9Lnon/GlI9sz/PWpIcbCycKz7EE=;
        b=GxQsK+02o2urKRXZ+V3wlyyKLMjcrmH9cFMx6jw3Ujsfe8Bet+brz2zJiAALQ062PY
         npZN27UFoMuqWL+LLcf7W9clkrChoDNsDrmNHSYFaJUrIcuDz5F5bkRHb/V95sapAvmQ
         sQ5wsoB3xFNrwsn7/K+eO016jBUz9mzmcuyrgz3D1fFXmRWrkfA7W2+fjFLkjHyphDtu
         z+fHQV7Hrz2rqQRDSes+LoxIKA7ghIm9bAOE2clqArv0KKkyokl5a4Y5AckSZfbLxDGb
         ZRLk9apuS+uAe4P7mRBqUqVQr0rjTZIHT7pkvOG91XP1fDNdldvURBh23JU1o/uOcDNW
         WqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC6YUCaSwRGyDGUeW8h+o75D7gHPk8jIpqYoZ3rHdIi8u8Jx/u0VFKW9qf3Q3CWgz1BaVatmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYWl3fwpP0BJy5VnjHL6JKfl03Go6pcucLC+cUFxRdkUNlsPb
	2+8ONrpyzzlRVq2fvKWwFTrw1uqGh8fUhi4VYcxlX23w3IDkjtnwJ3VQOVT0SRvbOXOl5napUBU
	IsJNtdkNX1GnKYhZo8E+QqNBP13TouzMOXr6uT5zPyKo2WVqF9ItrxEONEA==
X-Gm-Gg: ASbGncuATiZdsfkOBrsZjElbG5xMkQvk94K6MMT5Wg2kx32aCo/wmplKc76hbrqATws
	EozrE+kYzI5j244vvMSI25O5H3wkN6iywVHoShZPgei9zZp0wvt6LF5CAYgkxZoBUdokgdRrpZZ
	9cEAwN+kJiF2Gz7975aCABtU4Oy55FFZRkFBHBEYHAsNNjjdzUqTJXicDsoy35BeXlnEriEFaia
	cnjzCJpZWHtajmNsey/mBwR0zmaafOQJy3haVAp+jsfsLFwl+QcSZ/LvbIreZhkftj6lEFk4/ns
	HsMd6MFvc1x4DmIsCd/5abzdrWja/A29AZsKr/Jw5wbqQr/YecPSZ0NYWK/3DfFfYE7DYJTmEgp
	mHLki7Giwmkbe
X-Received: by 2002:a05:600c:4703:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4778fe63090mr150947755e9.17.1763462506157;
        Tue, 18 Nov 2025 02:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1f4y9akzvleGYB/KK5b63NZAoIPE3Tc33qIe1HHEOyVmf3X9N1YF+Ml26BiNAwsbOvJ1bFA==
X-Received: by 2002:a05:600c:4703:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4778fe63090mr150947415e9.17.1763462505733;
        Tue, 18 Nov 2025 02:41:45 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a974cdc8sm15733425e9.2.2025.11.18.02.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:41:45 -0800 (PST)
Message-ID: <faae096d-9771-4ae9-9211-e54f3e4dc5a3@redhat.com>
Date: Tue, 18 Nov 2025 11:41:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 01/10] net: phy: Rename MDIO_CTRL1_SPEED for
 2.5G and 5G to reflect PMA values
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net
References: <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
 <176305158293.3573217.9476472903287080085.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176305158293.3573217.9476472903287080085.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 5:33 PM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
> CTRL1 values. In order to avoid confusion between the two I am updating the
> values to include "PMA" in the name similar to values used in similar
> places.
> 
> To avoid breaking UAPI I have retained the original macros and just defined
> them as the new PMA based defines.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Minor nit: if you have to repost for other reasons, I guess it will make
sense to rename the patch (since it's not renaming the macros anymore).

/P


