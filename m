Return-Path: <netdev+bounces-278375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM6WFswN3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D253F8371
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D82C308C1A5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6F3CA4A9;
	Tue, 14 Apr 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDB0Mgid";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZq20/WJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9C3ACA52
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160036; cv=none; b=LPXOicdvtqX+q/Ccd5gHuUe/ar96q24HwFyCiucVrcuRtHh6hXDnOXwLtUFCPEvK58/Z63nsjyg4OOM1tc3TFpvJ/4d94X30KQ2d/zUHzjO9mZdMMvC/FKSSSCnz5mby48pqmVz3MtmQ342bMhtO58hhVeg/jGO4CJkRbuecF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160036; c=relaxed/simple;
	bh=bv5AeWRl6aqaLxTnVdjqykd7H/2wPJRUbc+/MvSkyxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HizXJI9w+q46rBXc3ZdF0QrvFJI3azFvwW4ckVYMmakV+z+bGneszXDjfnX5oJVBqB5gQQsW1N5YRu06d2hmkabSIc/Hy1VwuVcAgcbzyowJmbO8hpHZs27YPH4B5fhdZZk4ePtdkdoQc1beGjR9PRHPuqrN8U2vBjl8hU8afiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDB0Mgid; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZq20/WJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776160033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFua1/KhgIXdwvS4cvD1iQ3GFhM2dsTn/9+KosrTEag=;
	b=IDB0Mgidfd1ERE8ECMjkVa5PBlfP+mftZKBOJJp1W1uzf3TWMADurkkyr5TGGPKv4EynCw
	atlLmL9R7hXsZkYy10K9SwDXkXmuOZGTzMYtG+D8KuKJ144YNFJsY2sWLIwUbHWtWfVqeV
	Di0bdnJeO+VXMXus/3FLjFT5m83vOtU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ag_-g-V5Oqqv5FRTwfPE-Q-1; Tue, 14 Apr 2026 05:47:11 -0400
X-MC-Unique: ag_-g-V5Oqqv5FRTwfPE-Q-1
X-Mimecast-MFC-AGG-ID: ag_-g-V5Oqqv5FRTwfPE-Q_1776160031
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea728e38cso306796f8f.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776160031; x=1776764831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFua1/KhgIXdwvS4cvD1iQ3GFhM2dsTn/9+KosrTEag=;
        b=UZq20/WJIQ3sBx/QUx8NBDXGQG2Qn27OakOmsXMglzBadJnJzIb9eC8gxJSo4qU4B9
         0s6eIxQIFveDAgegRZx2ODLwqdt9QsIy3n1ctMQoBSNhlKt5iDbiwU1kOF9vl+bZmYsv
         ++/WTDYYuVEP9X+H0lyPZbQDifY1eImOITlcNCcmQsl02WY5+vYdBu3WFF6pnOm6l2b0
         q0bUvWvUSjTngwQ4hDkxJ9ElFsea3eMr1/qbgutfcpDpLqPod9lrTfugrlxaDETefQRy
         9lhuFXhUaUbIPQSetpFDVxmCKO1rFloLCOXKvgSyXebVLqRQfV74LxMvfLB1JrHRrlEQ
         c8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160031; x=1776764831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFua1/KhgIXdwvS4cvD1iQ3GFhM2dsTn/9+KosrTEag=;
        b=TWd7fcuQkKSluDd5/5gB/fzi65vgDBT09KHZLsa527amnwiKCdQJoeW9sr50LU14BM
         VvJpDGfAudhAqvBOMH1opIChGMcCqdD73XS8U+uH2HJbKDydX88ruIk4BlXoOgniRuWJ
         Aqn8zw7R+Be+yi68cBno4Vnds7FyvIiRj/vJ3EaWbHVeo9h+ljNSXSlqb8jl0ylxggod
         2wqZOPPM1sQXOppehk/vZ3m106kpMcwebKnUIq0ukdi99ya2AqJAc2xluEmisdwzYzNP
         EmLQGRgsqCRneyUDBDtWpDtn79gSomHRp2soteJ7zTvxH5XesubSRB8GtodwMi4Yb+m+
         LtAg==
X-Forwarded-Encrypted: i=1; AFNElJ9hP+wIoBLh78yzaLTZQbYuxq6F24HMXYXRIAMymz5OOHofjnS5cQYQRH1yVB57OyDWlaJ8bqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PX2CXF5PgmxJc/Dm3YE3td8Mya4aJ6jK5cXkBp7lPECg5qqv
	bVr+2+gLowazO2QbGJuIZqQKCsMipiju/lZC4cb+YMVxM1Dy44LlQTnYy1ta0jHtKvVS8m2uW0J
	x1n04h9i/xTUCIINSQ5B6nMBqRTwuP1EgsQxjhU9FSa+tIR9xvUDypfSNSA==
X-Gm-Gg: AeBDiesaP8vjz3kTo3w9Orb2Q+YN8FGxu7ALxCIC7nhJyDIyUomaFnmvoiPQg6n/s6k
	G/yLss8fOD6aNjwI1RfofOVOD0SLNERerhu+/FqVuIl49b43tyFXN5GVR33WuVaxQs5wSx1N+c6
	OWadJIvk4r305bHdmrhb3Rw4+Fil6Kl+mPRAfXOrMmkQLflD4P9qfazsPyEvkEmmTvlvURYcooE
	gXBbdpNHRU8D9wPGjAqZJsEU9KSgrNE6WU13sWBqssdv5Y2TDQkJhzZZjhOikb5xSKr+nZ4mHpg
	Vw5PVHnBhgssMn7djwTrXYeQm4OkNU2iGabbZHni0iECete4UYvmMHNc3XRXrzgf3uErsGCUC1Y
	z7t+0fgtsTmPlSN2C/h8Gc4fK4pJxYBgBc0f0NOkotlpkz8XiQvEBPNDA
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr159160475e9.19.1776160030510;
        Tue, 14 Apr 2026 02:47:10 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr159160155e9.19.1776160029969;
        Tue, 14 Apr 2026 02:47:09 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm42116795e9.2.2026.04.14.02.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:47:09 -0700 (PDT)
Message-ID: <a3974cae-728d-4eb6-8bfa-f926ed1c49ce@redhat.com>
Date: Tue, 14 Apr 2026 11:47:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: cdc-phonet: fix skb frags[] overflow in
 rx_complete()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, stable <stable@kernel.org>
References: <2026041134-dreamboat-buddhism-d1ec@gregkh>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2026041134-dreamboat-buddhism-d1ec@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278375-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,lunn.ch:email]
X-Rspamd-Queue-Id: C3D253F8371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 1:01 PM, Greg Kroah-Hartman wrote:
> A malicious USB device claiming to be a CDC Phonet modem can overflow
> the skb_shared_info->frags[] array by sending an unbounded sequence of
> full-page bulk transfers.
> 
> Drop the skb and increment the length error when the frag limit is
> reached.  This matches the same fix that commit f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path") did for the
> t7xx driver.
> 
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It looks like the fixes tag should be:

Fixes: 87cf65601e17 ("USB host CDC Phonet network interface driver")

Right?

/P


