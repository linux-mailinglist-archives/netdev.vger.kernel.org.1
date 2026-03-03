Return-Path: <netdev+bounces-263407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHv4AohBp2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:16:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB41F6B25
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF36F303BA27
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEBF3CB2C3;
	Tue,  3 Mar 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TkTPQ01R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E132E75A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568965; cv=none; b=gvpyRlT4Zh6I1FP6c5iZac4rf6ZUGm6Dol++b5cDzHJBshkoBcsD7fmXP9H0S961bPNRj9uVMI9Zwn4InZ53V8PRMoGT/TxLKlFJ7f3OHKRFr2qGxX7uihbaijeOvOUy4v2gmSqjPbjGYJMkmB9uMLYPa6VwB6p9c1xuCUEX4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568965; c=relaxed/simple;
	bh=xY1OWFFMo67s+cFAQbI7rd0H28CwvlnCO5208IEDylM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSWoPlzBdOcc+HZwXGFOG0nOSPPSnLoRFPNfODCFTCVnV8T15d+kcH51Pcr3q9wAjyCsZgQQ4Df+bwxskejIgqkmMwF71Tgn8WC0nySt8UV831hUGdBKICmYqHFmcpFCGTwStFcCDMEMbDqVVy63HUjzCvNM7M93OJGoycWVhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TkTPQ01R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483a233819aso59641285e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772568962; x=1773173762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+SdczsADtRc13OWugNiOcO122lxIc7wYzU5eTJlVRTg=;
        b=TkTPQ01R5ajfxblSkDcyjeOVtCfOF1wDeWdeIg+EAVPqGPgx4JHG8uwZYaC5VuPFSr
         aJtzRhqpbbbR1dGEGHNfCnzo7E+aWXtKlOAU364qz6Jz/4VABYX5kP8dNKAtCWAi2Joq
         XxDRrNc+HinBSLqLLQ8Wr9ZcAYDeK1hr9mXZaiLYfGX9mxLQYGtjLjUoHuSbT3xnZdYE
         9pxYgAY9FzOJBPcn0nyfN7Sfn+LwZGXJO3SCyj4Fc0DoD4rdxU5jjKmj9uwQq2R0PtDF
         ExEO1IxqVOMcZrVGKURt1iRa22fJKEQ7d0Q/DkCi+BJpZXw8WE8dbgpazqNCJDxrijYU
         +6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568962; x=1773173762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SdczsADtRc13OWugNiOcO122lxIc7wYzU5eTJlVRTg=;
        b=W7gOQNPBNP1yzMEc5ilCHHEtTCQn48Y/3hWyq6AKyXog/9wK47pGdF/hRSFHThUQkK
         H2uppIBvc4NbIvZab178AU3V1Gw+2PU5AmhcptqNTa40nynpb3+/2U9VXs3cdHaggEuK
         Pk8CrekDyhvDHtUoBOPfKfouYnzsIuOaXMeO1zifroCz/OFkRCo1ruhnqqwg0YTs3qES
         whnJ7bAogf0uRQ7ssX9NGTv+c4+JjFYLiZ+Y98XPEZCs0CIMmCJxsgcJRm7VpOlrKxfK
         7nnfPIv+s9CdsO3Ms1ZTue+LL4eiKFsd3qApvmN93PINxjaD37IZoTB4yZI4lB11idM9
         le0A==
X-Forwarded-Encrypted: i=1; AJvYcCXGw75eNDH4vFDiIX79DHIyBAHo6f8d6AOJcNijEh3+je5LOMwMCvxGt5x0XUk+/nHTMJdNjx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKx8GSDieKIoWF91g9YL6WL5G/yWlohaZdJJFcoGgWa54cBu3A
	5QQFO4sBxKy6m8lnJF1jxB9NeJ3Vf54Vb3jR6H3EJrBUGqAP8+aFJyzhWbzx7tpg2rtlwbyaHnG
	tNJ9Ev/466vp6qp5J/ANLfKvVVnSN7DAAm17DVmhSq3CsopE77LzykQYBPPC1NLbw
X-Gm-Gg: ATEYQzyq0j+UvHGoPWP1s6xCzo11EbJTSXmtflTlymQtCZ5zEG3x/yYIFn1kMCCPHqH
	wUnhQhhbLhSxAT/7sMrDsCtwi/s9uHTd7yzBJNXJjtX8XxvXRGeHnAyWu/MfHIzc+VVny+/aPqT
	mNNrsgG6L4eR1rsERp8ol6g4mq3B+TXVQf7pIBhudh+J4gNxyKYNJww5Sbs8d40kxoblUu6p7aK
	FuO2ekgmfJCepmWMIyPSLtsI4GsvZLT4juSIeTCgDM/5oI8pPpGjA6q8+bLENYDmwj/BEMQPOkx
	X4q90schKi7+SUbkvqNEfsD4codMDw/eqixLghGAk4wSBeacM/08VpHi0u9vcv8TnJyVrKFiTSL
	fDvYd8B+F+CY4eUlFvKrOZ2vrvznhBbu8LzQ+qBfGB4MtCS9yoYvQJwobF6bOsFtqdTjwLk8Rj6
	bSRm4G2Fc40dr0lMWQ9aACPNgi7nohZDa+hCCLbb5Gk9n2titUPFnkhhv2FWWlTg==
X-Received: by 2002:a05:600c:46d5:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-483c9bb7c16mr291920495e9.3.1772568961754;
        Tue, 03 Mar 2026 12:16:01 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:8c1b:8bca:3273:e279? ([2001:67c:2fbc:1:8c1b:8bca:3273:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851880724esm3579975e9.9.2026.03.03.12.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 12:16:01 -0800 (PST)
Message-ID: <6aa197ce-9e72-473c-a8c9-d190d85fb625@openvpn.net>
Date: Tue, 3 Mar 2026 21:15:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ovpn: Fix race condition in ovpn_dellink()
To: Hyunwoo Kim <imv4bel@gmail.com>, sd@queasysnail.net
Cc: pabeni@redhat.com, netdev@vger.kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org
References: <aaVgJ16edTfQkYbx@v4bel>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aaVgJ16edTfQkYbx@v4bel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B3BB41F6B25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,queasysnail.net];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Action: no action

Hi,

On 02/03/2026 11:02, Hyunwoo Kim wrote:
> When ovpn_dellink() is called, it invokes
> cancel_delayed_work_sync() to stop keepalive_work before freeing
> the device.
> However, ovpn_nl_peer_new_doit() runs without any lock shared
> with the RTNL path, so keepalive_work can be scheduled after
> cancel_delayed_work_sync() returns.
> 
> The following is a simple race scenario:
> 
>            cpu0                            cpu1
> 
> ovpn_dellink(dev)
>    cancel_delayed_work_sync(keepalive_work)
>                                     ovpn_nl_peer_new_doit()
>                                       ovpn_nl_peer_modify()
>                                         ovpn_peer_keepalive_set()
>                                           mod_delayed_work(keepalive_work)
> 
> To prevent this race condition, cancel_delayed_work_sync() is
> replaced with disable_delayed_work_sync().

I was about to agree on your fix, however, it seems there is a larger 
issue here and this patch is just addressing one symptom.

If you are truly able to execute the whole ovpn_nl_peer_new_doit() after 
cancel_delayed_work_sync() and before the netdev refcounter reaches 0, I 
think we may get stuck in the "wait for device to be freed..." loop.

That's because the ovpn_peer_new() will acquire a reference to the 
netdev, preventing it to be fully released.


Sabrina, do you have any thought on this?
It seems as if there is no safe guard against adding peers while 
destroying the interface.



Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


