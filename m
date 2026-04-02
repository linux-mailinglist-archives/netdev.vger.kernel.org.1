Return-Path: <netdev+bounces-274587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJZ9OheCzmmDoAYAu9opvQ
	(envelope-from <netdev+bounces-274587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:49:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560E38ACDB
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAD1303CC21
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BD0846F;
	Thu,  2 Apr 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Z5RoTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F931BF33
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141248; cv=none; b=cxUeop8MwC75HSpdqDulGbbeN5u7SOde4ECKzKuDb731wvoZ/mry6u5rgiTepdWDGtdrBHpzA1mEy2z5wRfpMYL4w8BPuthJS6LQzCSs3R2v5Ebg+d2qYcFwWe1vIJKj0bgQBPbS+lg8wyrBrHGO5/wNHUxSQPiDsI2RzofMntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141248; c=relaxed/simple;
	bh=syQhn3FKDSt7aahom2Cd5r2lVp93DM2NQ4SMHj+9K0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4Qa4XDux73PEd+thq9CGjeJAO1MF3kkNfEFoyLCmnKRS3Kk7Q17h0yh6wk+9N8GNWBQxS67BMdpNoAReXFoImAImhrb7DCA2beXSFqYX47csExf6ezgePAT5Krh0lVbMq/2CJaP/sMR8T/8VY8IQEFXNShqzWgMul7wpCS6le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Z5RoTX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso7973705e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775141246; x=1775746046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=syQhn3FKDSt7aahom2Cd5r2lVp93DM2NQ4SMHj+9K0s=;
        b=d1Z5RoTXvsRwDc/LzwAq0eR5Jo7LOkmQaJkg640eZK4MNBcqYh/AokZ1MqzVf4q1mu
         4UU5wUcTjxeUBLOfLj5fP1/vGetDZCW93zkEAhXYlrBtD0xhLMqqKjSEMuyH+NvSA7Xw
         3DT+K/9W6znJ4N9zWTDq2/ZkuY2VQKNiNxEd9Vxn4WWdgogDqtiQanMl5kWNXnf60xpg
         Y60wkH6V11t1twotoMjynVySYirCfzeNUHGW0kJalS7nW5TXnd1S4D3Cqk28Cmj2l8v9
         ByocPnBCEQjlY8TcUa4Bm+DYjjigjplnToyaaMkyF5PFtyVhd6Wi8Lylyu0DEFdq4r26
         Uwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141246; x=1775746046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syQhn3FKDSt7aahom2Cd5r2lVp93DM2NQ4SMHj+9K0s=;
        b=UXAJplrt5iqjxjJ4tO9XFmQDV0SoYBEDXwa/vUTpEergMM5mlsaqosD1z/UTlasRqW
         g/YegYoj5W+rKQebm6m4gOMR28bdOCfwEkafvfQwKf4G0556xh5gNi6XCk2EI/jvUHZm
         eyvpfrJOLF+dOMeB1H1rFbioh6BTYvXXGr8deHDQAn1kfcsEnv7hHRnsTbFlJNCYlfTf
         6V9ROFJKEZtPfEBUUE9q1uipihOExNi/V2b4mht/e6PxPzrQzd1SpFag7zFM3KWgoa4P
         FbstTuwkof6/us6dsp7cP+oMoaxfcjZWirWiT6WSMFiQ04cvrQw7Z9dCpcOZb33zY/9i
         p9/A==
X-Forwarded-Encrypted: i=1; AJvYcCVUEeqf7APRkaici0f2iuUgIGD9ZgSUBoV2cO2EmFAHd36r7xhY4ON3BDl6Uc9Y9nqRbhX8FoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZwhrSDWwLxx2//dzsJyOuVq8u9tmB4l4o8CSRb8CJrd5r6EE
	AhFemR9zgx/EJPJm25lHLSOsjY57s0Uder4tYTF6apGfP7UZOWByl9lg
X-Gm-Gg: ATEYQzwwKSn2r73DXjIf2BZ7ycu1rJ3C8gMfM206zFG3syHSySMxGIg674R+CzBvrky
	A572M004ys4onXkcbBst/vJNB7D6AOeV3Ed38Hh2pmBVIN1D2EGV3y7TKIvlSxBNvv465zK8tYI
	iPUv8RfluzrPvqSQJnk74704WvjAd8pEGe+Q+Pnao1l6pDh6B4Sxjg5lZvxj8Z8BtGqx37mVf7G
	Y+/WP18C2LLWqv+WVUgV75rjjCByuufsFlRc4E230rf4lvR7rT3pqN/0NPY13zJiTKoN4IuZKdi
	2hMDushlt1V4IBT0mYfD9SsqjtykXcnEhIuQ1cbkR2V4avdDfFtjSxHh9KWSULpebTYseEdgBDq
	yLN3Tb6DlJ4RBYPJpAUr0lFyJrr+fbjjKx2FmZv92VT/dX0Fr3YzHfYIEy2dswZt8tCucobfhKj
	sh9EJQvxUOPQ6Wfbx0H7dDb11mjDxdAgjJGZNaZwxgUL/VifvFiU/ynDNXrw==
X-Received: by 2002:a05:600c:4f08:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-4888b6f7f8emr56182235e9.9.1775141245586;
        Thu, 02 Apr 2026 07:47:25 -0700 (PDT)
Received: from [10.128.11.51] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad8d28bsm87489185e9.10.2026.04.02.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 07:47:25 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <cec5001d-7ac7-4b21-a3d6-6052e1d8fc87@gmail.com>
Date: Thu, 2 Apr 2026 15:47:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stmmac: cleanup dead dependencies on STMMAC_PLATFORM and
 STMMAC_ETH in Kconfig
To: Jakub Kicinski <kuba@kernel.org>
Cc: manabian@gmail.com, davem@davemloft.net, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260331125817.117091-1-julianbraha@gmail.com>
 <20260401185814.45dfc444@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260401185814.45dfc444@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,st.com,foss.st.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274587-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5560E38ACDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Whoops! You're right, good catch. Looks like I've been staring at too
many 'depends on' lately...

I'll send out a v2 - thanks for reviewing Jakub!

