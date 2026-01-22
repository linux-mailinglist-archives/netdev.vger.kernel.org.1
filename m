Return-Path: <netdev+bounces-252311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBVlJ5MPcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC01663FB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A966D9050A7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB03587A6;
	Thu, 22 Jan 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvVpSFwc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j1DyJ+BD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8C3563C4
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081846; cv=none; b=m8nRbnwGQaEQfYFFq85X2/zl9m1EKCxjljDJnE+7UIoObJrmSBZSRxoP2Sgs+BByZc/ZJn6QaYtqq0N2qEYJ7+uJnHwYjt9l2ocrL3E+IXKlqjuh8a833U6gvcy0FYCQGoaZA7YqH8KUUvWE5o26+dTdwegE+iLgZQicMRHQBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081846; c=relaxed/simple;
	bh=47vdssggo+h/Zlz7kBJBl5ByRnPHVor2xs5SYsppYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7hBI6UeyM4xeHbf25CZTdI7dEXtC9//8jBRhZmk/Vesw0wewr7lk1VAglUBrU0Z+TuBZB5zZhqaiSulugSvdNpIh8G2VWUKY6Iwh5NS/DylcvjyZxChn6vKdy97nfwR+4QduDuZ3BglB8CMo8GYPVgddW2fXpKFqD5jVOnkq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvVpSFwc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j1DyJ+BD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769081843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wNs9tyPabqN3sAug4aUnrZjg9O+jb6nYLQLd09yp0k=;
	b=NvVpSFwcVsuZzeXbByWp6S4i32vdSpFJrIB7mcxwInVMTc/a8Gt3ZHAZVfKeRWYO1FNUT9
	yqNPzoKcax7Mmi+rvb9fwZpbZTo88JLCf5yqV0hltrNJbqNBKxVj9YVOQIezep8Hcz6i3n
	bSrsG7T22EuxBRMqkIBahUQBLFmQDOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-naDELoRDPQSwNd4Hnu3eBA-1; Thu, 22 Jan 2026 06:37:22 -0500
X-MC-Unique: naDELoRDPQSwNd4Hnu3eBA-1
X-Mimecast-MFC-AGG-ID: naDELoRDPQSwNd4Hnu3eBA_1769081841
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a0fb0c9cso854712f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769081841; x=1769686641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wNs9tyPabqN3sAug4aUnrZjg9O+jb6nYLQLd09yp0k=;
        b=j1DyJ+BDUw7gZy4tbSPZ8a2D3XeKQ1N6bOtTW5QDH3Bg3fxLSj9uAXIgfaIjFj4QlR
         H8MTh8fO311FeQ8OlIIZ2luhKzDou8l+nyDcfOzqAo04wurbWIYMpB24Z0NBZXDLlVmM
         OwK8UwAjWZOTrskAyh8NXRJUwWRka6Rb5nPDKFokG0ELb2A+6cyNAlUONTjdUV9mME0j
         Z7TsGlQx2EJ097wWpUQydk4hTTfzfZEk2UQZcbF9X8sEdCk7VDS+asIrxyIChApx7Scy
         F9758faZBm1/xZc0GfwGTvcmmYJaFfuvT9nr4B7RsqwjL3+8Jc4mGkCN59C8kYGqQS3u
         9jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081841; x=1769686641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wNs9tyPabqN3sAug4aUnrZjg9O+jb6nYLQLd09yp0k=;
        b=MdHjMX/391Fj8ixjhFGb8NY8kmPMN2Vh1VeGYBwC5yYKBGMEZgKcQiR6JmHw8G10pv
         MGHuqkeRURbwwboW6dbMFvhbUIEXjVueT/Ei/YFI+dFjNdg6/8RUdCz9JT1CuZFo82bG
         /T8kat0W+gZr4zYX7rLz1vrEnhMOrVG/B9I0xilm317F4y9/xRbyxUVhnsHR0apc3hxv
         u8Fa8xvxfuIV62OCMEof4+A0nDc5y/j5tDb6rrRJQrakz0oR+97nK2TEmfK14AnYp+RN
         b6IQTeXE9+mB9IiRIvFTK+lxaI9AFx/zDkorNhxOfo6Bzo6mEj28dhsiDCq3vaUDPW9t
         thoQ==
X-Gm-Message-State: AOJu0YxkGiwk8hFi1lK5L1QufVdhwwuRUrKKylmwCdCxP2i9z/GobyYz
	R9zyLGJam9lZ7g92UJLlWz0aH5Tyr5cwnmA6muL/RS3g1zbsGz+d7dPEzXyEPRu9UUZz7Z4LCez
	zh7ZWX05tswJUrcCjR38L+rNbQhTh4K+5aT3NpSPmE2B0tB3f1JWJ8brKmg==
X-Gm-Gg: AZuq6aLKzMi+4YWntaZ4naUr0gIwlY1hy1ODuItgK8Qm8YznSLdjoace/ljHcjLYIxT
	7o7/6P+otpi01fpiSWfqH48kS9Xo2bsHT3poBK1ui9dAMkqwwNLJNgKc7oI8EnMOLKx83tUcTBm
	p0o6rBmMUXcPXHSQArDU1pWhEToTDjqZJ6onojS/isyKMQkBLZ187iXTm/y2Jd2UWzpAJU2ili2
	vuW7fI+3iPyEsS5bsNFh4bS1XAiXJk5YUpIZSDyCdRySusybemVknuuX6jLoWg1EgxXF2CqHNTZ
	5MTBoxEkWWgO8eucwicMp/V2C83mkoeVxl8msZCjvL1F9PwVtWvOI/1OFzrxpcIDSfC7Nwnyees
	Y3myLq6TrazYe
X-Received: by 2002:a05:600c:34d3:b0:479:1348:c614 with SMTP id 5b1f17b1804b1-4803e7f03fdmr128686755e9.26.1769081840531;
        Thu, 22 Jan 2026 03:37:20 -0800 (PST)
X-Received: by 2002:a05:600c:34d3:b0:479:1348:c614 with SMTP id 5b1f17b1804b1-4803e7f03fdmr128686445e9.26.1769081840134;
        Thu, 22 Jan 2026 03:37:20 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424b18cesm51351875e9.4.2026.01.22.03.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:37:19 -0800 (PST)
Message-ID: <86b8feca-8e82-465e-a17a-b751758306ce@redhat.com>
Date: Thu, 22 Jan 2026 12:37:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] net: phy: add a new phy_device flag to
 keep preamble before sfd
To: Stefan Eichenberger <eichest@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com, maxime.chevallier@bootlin.com,
 francesco.dolcini@toradex.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20260120203905.23805-1-eichest@gmail.com>
 <20260120203905.23805-2-eichest@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260120203905.23805-2-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-252311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,foss.st.com,pengutronix.de,armlinux.org.uk,st-md-mailman.stormreply.com,bootlin.com,toradex.com];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: DFC01663FB
X-Rspamd-Action: no action

On 1/20/26 9:30 PM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a new flag, PHY_F_KEEP_PREAMBLE_BEFORE_SFD, to indicate that the PHY
> shall not remove the preamble before the SFD if it supports it. MACs
> that do not support receiving frames without a preamble can set this
> flag.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

I understand this has been suggested by Russell, and LGTM, but still it
would be nice explicit ack from the phy lib crew to ensure it matches
expectations.

Thanks,

Paolo


