Return-Path: <netdev+bounces-242220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8AC8DB62
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A14E44BC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B326F29F;
	Thu, 27 Nov 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrQrGyLD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r+JFufm6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321122AE7A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238532; cv=none; b=g0liIbruPbQMMVSTMeOTf7dOpNEpn1Vxf2LHxz9ArImv3pxa7Tnx7/iXDA3XG2FOXkb7sCa8ZLGg1iBcSYIJQheMBbpqC30ukb5eF1PrmKPS57uGhCt2zfaFCJG/Nfzk3rHtwaL9Gq4tW8j1VUkfatlvYvKEKqJWDJDPEyWpV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238532; c=relaxed/simple;
	bh=pwilmtuwZCwVGcEBxCIcxfJ/scfi2T4xcyOMcvootqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWFOPQ1W06qTkYVRPl0ec5tzsZNbTBuJfn9ikdyDnDjVtrs/5Jq07P6cAy32+2CTjRsAiqVt6ytQdB+/da9vHzf+9PqJ55jpWk165oVJWfvUrKIHefGHhRWbHYjKEbm7RKFg20VGHUg4VEsBt3AkLn1XWABuCTrLIkrmptzZi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrQrGyLD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r+JFufm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764238529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
	b=DrQrGyLD1ojUnMAAH3xupiY5a3GHD0mVeEaDWjrV/Ep6+otT6zrjr4/Au0IFrSU3lvlnB6
	jb88PpeDss2y+mNM5HeU9MLafsOeJhGpY3dcQwWWtadfxTY5Zf0oT0lF7DnroyOeQ9UURr
	hPgusCURlZfwWRXF3T1g5LLmZbF9Sd0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Z7-CobhVPqSXKW65wI0Azw-1; Thu, 27 Nov 2025 05:15:27 -0500
X-MC-Unique: Z7-CobhVPqSXKW65wI0Azw-1
X-Mimecast-MFC-AGG-ID: Z7-CobhVPqSXKW65wI0Azw_1764238526
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso3317385e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764238526; x=1764843326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
        b=r+JFufm6NuDNfVqptG1hxfYgmto5MJQvtV3ueSEovJ8dTSF+YXF6OICo9A8XQMG3t5
         kXDJebbj2rhXO5YgDBiTrU/1FI1Bx9xCXee2FrymATL0dCCJouoKSo7LLeNfA+nfsAMu
         j42GyrL70x03EnmbM9uSyASEpd/zaT03VieCAqgP0nM+ybhS8++9uHBuomQ6FiJ0Ytz0
         enuYiLTV2URJbi5Of8LBhzfLGfIZqZJVl7n0CUebW/cbrnXOxQZgvLcUfwdhYyx5VD09
         vDQGBqecLabcRn5nZSW787273FgHtLhx25eOsikSJMCH9P99FxsqjD/+968qELNB3BNB
         2YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238526; x=1764843326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cSz/b0Kd5xpZ/T1Df2U+cJQk1otyVLFFyjvMg96kbw=;
        b=AW+Q1M3FlltAc+Ed58RQt8LfKL5TRgNPyFPN+KaIsvJyYHxbOxHPL8cDUcHV7MCgFw
         PbnqWnw41AShnRU5s2HEqvnLxgtbktz226ZFsesPLzNutjgPMsGen+gA7Fs8DZG8qzJw
         moZ5isixmwFlbPux8Wtm8xPNY5v2FvBe7EfNmWeEwhQvNBXEW+4OnrQF6yYlpBay8k27
         I1N7aFD1don/7LVB/jaw+nC3+7zky2tkV8HcDcBpTK6AYxgmtidez3hv8gL55GnNypjh
         lAdsej34bFKhAONBt9vHUc0G/5ardhVXCehkxpFhHhvw/+xTZvg81SbhRtd8W3kaTMhV
         lbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6uf76HaaUX3XTzdYqg5lCC7tEnB8qBjRepHvYfbR755EKXMmPL5lwCH72SBUG6U8WZR7XDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9V9fv+aJeVpg3qNcdaODu5JArDyGMTzg2G78Tf48FAxaVuQnQ
	pBjP49QRN1PYlTK1N5x/w9uPvVYq7y5umEih5xbwpvftDbr0vBP9kxLT3R7s4SXGCpZflfS2t7x
	Euwh8ECYCVHQqjOBkgSi7YHmOREoWIssXop7rFbaNdUvlWwKPzFSZdV7nhg==
X-Gm-Gg: ASbGncthRkK7Fpm9Cu4e5Z3XBnTxc3QXpcBdKsKsLsvHUePpB0K8k/tjykih+oxQ+Hv
	PjlxhTvz3cwHkPiYtkmGca6tPXtBvHg+io23+8oMnBhXdNXcmZNhrJDhRcPU+vnNiGo0bCdWVTA
	vZrCRPpOTtGz3LQ2CRcG+qNHHAvAk+jTIkrTahFXL0Xf+1YHyINIXqRB3ZhAKZYoh9oT4b2ITvX
	NMFhCjzjLbtri/jQHKS/ihp54+J5GAGJAqlbUC7yKdmXTcqR6spXWxJpwcVYpBQQLznq5w2KHnz
	VVr+OUjWahegCws+I0jPY/JGUCBVyy8oiOIUTVYshG8avYzkhHTEKjP/Vsux5P83tbgK9lhXY65
	qpSnh6Gffug8c8Q==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr248418775e9.7.1764238526427;
        Thu, 27 Nov 2025 02:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNb2PeD4KwIGCMkGgjUBm+QcFTwjLt9m8CIMLyVfjrnQH9DmdPco7CEVggwzpCQSSl5QxaTA==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr248418345e9.7.1764238525977;
        Thu, 27 Nov 2025 02:15:25 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791115caa7sm24218165e9.6.2025.11.27.02.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:15:25 -0800 (PST)
Message-ID: <63768c05-e755-48fe-a4be-9715f8b5ab2b@redhat.com>
Date: Thu, 27 Nov 2025 11:15:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bonding: set AD_RX_PORT_DISABLED when disabling a
 port
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251124043310.34073-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/24/25 5:33 AM, Hangbin Liu wrote:
> When disabling a port’s collecting and distributing states, updating only
> rx_disabled is not sufficient. We also need to set AD_RX_PORT_DISABLED
> so that the rx_machine transitions into the AD_RX_EXPIRED state.
> 
> One example is in ad_agg_selection_logic(): when a new aggregator is
> selected and old active aggregator is disabled, if AD_RX_PORT_DISABLED is
> not set, the disabled port may remain stuck in AD_RX_CURRENT due to
> continuing to receive partner LACP messages.
> 
> The __disable_port() called by ad_disable_collecting_distributing()
> does not have this issue, since its caller also clears the
> collecting/distributing bits.
> 
> The __disable_port() called by bond_3ad_bind_slave() should also be fine,
> as the RX state machine is re-initialized to AD_RX_INITIALIZE.

Given the above, why don't you apply the change in
ad_agg_selection_logic() only, to reduce the chances of unintended side
effects?

/P


