Return-Path: <netdev+bounces-258267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMDtA1lujGlmngAAu9opvQ
	(envelope-from <netdev+bounces-258267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:56:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BA12401B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F363004CB2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5231619D;
	Wed, 11 Feb 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBmVtAhl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0XKRK8e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4C314D07
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810962; cv=none; b=gJkE02GAbSxs8tSSw7zC0VyxE/vIaWDpRqncvOHaed0zP7TGlX0Zfm+gFYG98ZeS21/4qZ0ozVVA0oroBJ1FAhnabJGyXAg8RZiwlNPYnJA8jsMkRqlLifLZwzKkq+gXJbFreLKqSGcIzD+nw3JcXaInqFXngcEO7WTCdZJULq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810962; c=relaxed/simple;
	bh=+0oTiVEciU4czR3f/w4qaJMu4GmlPg8+p7LTIxCV06A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUwc8l8YfpHrKmKjLN13BtknqPP7zmxZvGVBW/cvewmxAm9RhF0IHA8xlDqVUzG5GBv4Nq8XlBN7F2pLLw15j6O1KDP0ufExCQI35phUlqWmbDxu/HWSthLm5Rz3JHzvdj4tTDYiO8i/sd92hldgCcoo9yMGM4QHKQOu8p5LoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBmVtAhl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0XKRK8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770810960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY/0evCgUnAgU67WTuuAcR9YOZDCXErhCMNHMcMC0To=;
	b=LBmVtAhlyK7nxiOrE1qrhiRXYda0KAGm3cbNmaeG7cFIJb/W3G2ajEPZbA8xolV8ZU4hu2
	fu6UDT9LBOof6DxLU+TX+I9rz5kgng4jstKeVDZQ+k0Fl8x04tQ2dKLi+SPpKrBwc8Q9KL
	Yp3rWsus+63zW9KCZpTrLXYeRDpgMAk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-NAvZQHj0Nl-BuAcRrCAB3Q-1; Wed, 11 Feb 2026 06:55:59 -0500
X-MC-Unique: NAvZQHj0Nl-BuAcRrCAB3Q-1
X-Mimecast-MFC-AGG-ID: NAvZQHj0Nl-BuAcRrCAB3Q_1770810958
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-435af2d3144so3259688f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770810958; x=1771415758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY/0evCgUnAgU67WTuuAcR9YOZDCXErhCMNHMcMC0To=;
        b=K0XKRK8epYl8IZBDshFy7nylL+9Gx1BrBDEz6hfb2bQRcpkwityShmWhrfi6iGFqa1
         GLrVTo61vNWfHVn0ZAOyCyZs91z0b1aVd09/b0rhLWexnpcD3nNMsPy4VxjSLAMn1GqU
         sQVKzYF4qNM1atz/RW5zpdVcIALP6JzzRlugpqfFMc2ilFnzkTgjLn3KRc3xlE7D5+R8
         l3KgxyznpqLkwhiwhZclbqbBfLs1YXGU2VWTIfB/mBT6dvC1xkmYX4K4vcW3YoeGMcbQ
         Ab/M12SLWisyKsjuOkqKQ/gC0g36hjI/01IvhC7ufz3ZDNmNnd1hh5v8zk66xxaN4wUH
         7tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770810958; x=1771415758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY/0evCgUnAgU67WTuuAcR9YOZDCXErhCMNHMcMC0To=;
        b=mR17vZ8zbopEv9SsA7WJxzioKzTaDgQaF5V9jXV0GLCo/QwrJX+zmCjvtLJHTwXW6L
         1AEU3BcfE1trCQEa25jGu7Vf2lN4HexAas3ZH6WyNAi/u4iRefON2+AB8P+OpJlltE7E
         IrBDP1Qk8zdnzDT5pRIQHaMUFPY3ZkEMezkFWIH1Acqblh7BMywvFKwPxJNFFMpEoH/T
         2Yur+WAxjoSYU5/LeiRL+aX0jvO0kwkqNOpGgzYAc+8Pq3+7hF8WgSYsP9edl8WBvu6r
         kHRVfgJ1O9MzAe2/2nuHR9uvC1X4jXtUFcN0ejQOcji1omc/eSqrkiYi6wNleHAp39Zz
         cs3w==
X-Gm-Message-State: AOJu0YysTT7gRhnQe4sn7TBGvNXsqWhGh+/f5MPeKCd35nEa3Cd+nwEC
	eeC/+0uTMhSMp4INS0dzI8uakcBdw3j/xWe8unu0sY6Ux2BoVQOuSXH10Hx3LbSYmdptXJBKIoS
	AXy0D2/yIaplwaVLKxmdwqMsMxA2xIZesuNGy4X2I+tjctoS5iCssC8k4Aw==
X-Gm-Gg: AZuq6aJvfFoxaZCglSSi7XkMXXc3yH6MyHw6m9kDWqEA9RTmzMf1Pz1MA1g05t0iqHa
	SqYmkWDmObMV7/555UKA1uq/98mLKSKx1iVa5L8cJ0VlRsvUIL3Y129zBAo0xQ1TZ0Lmez5RNKN
	ks/h7hyek8w/RsZEcMAe2hRFZ9j1KGDFkLtd8lsczHTfnAE5btd4VQyRnaXUdPkp7rQRDnwDBpP
	trfQydZPvrASjo6gTax5V4WOMnQMi7r7WAZGelbPWT8MLtltPpBy/gpTgysjWl7qwIWi9+rPTDy
	AwMDV7E6AwCTgbHpscoQO7KCXQNXbc9weFkLYw9INy4WCCyh01vvLuWw+pzBwhXn9RK/2bSFAno
	v7lHFwBGDHFBbxxeTg8SSXqBaOg==
X-Received: by 2002:a05:6000:18a8:b0:432:5c34:fb32 with SMTP id ffacd0b85a97d-43782c259e6mr3400554f8f.23.1770810957932;
        Wed, 11 Feb 2026 03:55:57 -0800 (PST)
X-Received: by 2002:a05:6000:18a8:b0:432:5c34:fb32 with SMTP id ffacd0b85a97d-43782c259e6mr3400519f8f.23.1770810957451;
        Wed, 11 Feb 2026 03:55:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc54csm4207496f8f.25.2026.02.11.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:55:56 -0800 (PST)
Message-ID: <f2882370-a531-4a83-ab39-cf73878c0d03@redhat.com>
Date: Wed, 11 Feb 2026 12:55:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] docs: ethtool: clarify the bit-by-bit bitset
 format description
To: Yohei Kojima <yk@y-koj.net>, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-258267-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[y-koj.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C0BA12401B
X-Rspamd-Action: no action

On 2/7/26 11:25 AM, Yohei Kojima wrote:
> Clarify the bit-by-bit bitset format's behavior around mandatory
> attributes and bit identification. More specifically, the following
> changes are made:
> 
> * Rephrase a misleading sentence which implies name and index are
>   mutually exclusive
> * Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
> * Describe that a request fails if inconsistent identifiers are given
> 
> Signed-off-by: Yohei Kojima <yk@y-koj.net>
> ---
> Current ethtool-netlink documentation doesn't describe several behavior
> around bit-by-bit bitset, which makes it hard to develop a ethtool
> library without digging into the kernel code. This patch eases the gap
> between the kernel behavior and the documentation by adding descriptions
> around the mandatory attribute and bit identification.

This needs review by someone provided with English natural language
skills far better than mine. I'm wrapping the net-next PR right now;
this has to be deferred after the merge window, I'm sorry.

/P


