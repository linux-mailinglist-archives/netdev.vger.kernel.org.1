Return-Path: <netdev+bounces-276243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCusFvi81WlB9QcAu9opvQ
	(envelope-from <netdev+bounces-276243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:27:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10F53B63AF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26D4302E93C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316A36A004;
	Wed,  8 Apr 2026 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JBIGfc1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24B36492C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615186; cv=none; b=YtMI93liK9zAjAmxkXR0NbB/sUa7KsPYbBTHnmcSxB2RCnaWRTaD1JpcZMpJH30/RjzZliBtYtNizd3US1NA7uyvBhsutD/f/a6AsiEj0cF61q5L8EWKnOiW9spa4UnLgSXqnxyg6CX4Ufi9Xbpz7GxwMTYyOJZx3SQWSMdBw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615186; c=relaxed/simple;
	bh=uIkqoIN48bXlUgQZNzCZZ3q2QkJhJ5wbb/d/trec/NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/ukqJ99TaeOTgRPA0QqW2gePv18QbmrTPa5ZBNtZsvZGiT0BfBEzMRteyGIiAC6HAOK7N1Oyj1A1vRCbiQ9aFpFfetOwxTqiZWbNpNw1xKU/L7Ii8g82x90iG1gTsGH8zNjIk+zQnMWTmctLBl5e0FwBPXrzLBw6J5QCm6mkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JBIGfc1K; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2b2429f98d0so37071415ad.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775615184; x=1776219984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t33OUnu4MPOI2bM9pPdhoQTKf54aeDCB0I51DZlIlds=;
        b=HkX2k3OR3b2ZPbRdiB4o4rZhRsICoTh50eQeeCh2zr9PC5xOqqWrZWscOwRt7iUXrl
         oAhFONzhmgMAkINKiR/KyECyvgs8IBRT8pHy2TEqWZDMLGrFFaB+0EDzVM3E2qNse2xp
         QuuB7MfDfeS/EWgBT0Jr/kgmT6HErfA9scfDXBBQKMuw9DwYzwhPBWSLFZGGbnrLSXEo
         aF8lPCg2hyAx9vsXttUr8ccjLCljHFVovIGMgqiCH5KfaLvGrjw9YzIMbjvyt5HuZ91E
         L/nUwrrU71iJWwAvzfabtQXsvzQv0li6rOIu+RVMBUvuT587FTBwaGsO3QbgEokS+NwJ
         uzFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdrg0nd+ufWrFVG3dcbIVhQY4nc6JKl22UQ29QHvOvjvE9IIG+lP2pQRxmUn3ct9fpbCYCaCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2GsRGm8hOD1aAksK5sjOsY1L375iQajfjUxX1nuTZ/+F3sc7
	OwJzRTUSbj2buLUJu3qF8iWk5UqAbsqdtX+cnljcZFKqmSd2SbFQ7YMOz0l8593pR2CtBVxJVHI
	NtPvl94j8uAEItrQpZxayGPAfvXA97R5rtnZAEGzFufgXQ848abe9Bj7tbh2q0moo/2pIW+m4ze
	HT5jwWasWQwdFeQchWOg9JsVw3xtCi3whgV3jGzkiSLri62nodVU/CbgDTxFxuiXqpb2r9gd+ml
	MM8Hn3mFQ==
X-Gm-Gg: AeBDietULAjE9MRslOUeiFn17LyBXe7iy+zQqhNfWMxTjriucQPxclSjg3vrPZfcwil
	Xwr2H1XPG4MiKU2r0xqgTrRU1irMnf2Rc3lCHjpC6C9Mwuv3LXhU6sDNoPamWCb8bPXcT2N82GL
	nPx4kcuI+Jho+iHeasylRGcb24IIkRjDA0lzVjiEA2BGffYbc53+y8qtqF/hVMJDYwxg2Q/Oakw
	b0bZN6gUuD6lOpwP1v9XYxmJmW7vNhbIfFv0xdKES9sjsai1aPssapZ9tozp3fQzSg4ASqM1IZd
	VFd45vDVTksl+IfFOHVGscb61vk2vRilWpf8mxSeofd5HQuEJdOcxI6RnOsIWj4Pi8cit869LUD
	KoFMVjp/w9qBtH9nQryijyVQP2UmrZjyfpFuleE5jx+QT1obLzdm2nxX1R1NTMBFAYOrz9F3Vus
	dL4URlujuI7a61v1KR4Nl4AIcYo+BTJiSkMectTjGm99ZuRbl+c6WvsBs=
X-Received: by 2002:a17:903:2ec7:b0:2b2:454f:b951 with SMTP id d9443c01a7336-2b28176a3cemr200431125ad.29.1775615184252;
        Tue, 07 Apr 2026 19:26:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2748a1524sm12471545ad.28.2026.04.07.19.26.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2026 19:26:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79895ffb315so140486397b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775615182; x=1776219982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t33OUnu4MPOI2bM9pPdhoQTKf54aeDCB0I51DZlIlds=;
        b=JBIGfc1KP0u2cf8fFj4/U7ti7rhIv/XNpqqkLeng5kJQS1xD5z/TQatSqVBPlsbqVY
         3GJW+12ADqYRipVYl1OvaqvXcwM2BFpsOqQYnIZeNFAdZAYEtmk6K8OXdgwmdPGV4yL0
         Jzo+B83pYPZuVYyBU+fsd7iCSTAPaOTOOUzZQ=
X-Forwarded-Encrypted: i=1; AJvYcCW4Wp28gjOGv28+WknNWrV3PYJxbDZN9Op3hAUEH7DER014NqV2WQ/ylU6UvnxUZr5CrCgSWz4=@vger.kernel.org
X-Received: by 2002:a05:690c:14:b0:79b:cfcd:ad79 with SMTP id 00721157ae682-7a4d89b66b5mr200425447b3.40.1775615182515;
        Tue, 07 Apr 2026 19:26:22 -0700 (PDT)
X-Received: by 2002:a05:690c:14:b0:79b:cfcd:ad79 with SMTP id 00721157ae682-7a4d89b66b5mr200425277b3.40.1775615182114;
        Tue, 07 Apr 2026 19:26:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:3f50:2990:30b8:b2ae:bed4:118d? ([2600:1700:3f50:2990:30b8:b2ae:bed4:118d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e229135sm79047637b3.3.2026.04.07.19.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 19:26:21 -0700 (PDT)
Message-ID: <6c5d81f6-db20-4f64-b054-e346c22b1a35@broadcom.com>
Date: Tue, 7 Apr 2026 19:26:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bcmasp: Switch to page pool for RX path
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Heiner Kallweit <hkallweit1@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20260408001813.635679-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260408001813.635679-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,arndb.de,blochl.de,gmail.com,suse.de,vger.kernel.org,tipi-net.de];
	TAGGED_FROM(0.00)[bounces-276243-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F10F53B63AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 5:18 PM, Florian Fainelli wrote:
> This shows an improvement of 1.9% in reducing the CPU cycles and data
> cache misses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

