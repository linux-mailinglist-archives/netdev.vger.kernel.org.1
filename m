Return-Path: <netdev+bounces-257105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPsCOoZvhGmx2wMAu9opvQ
	(envelope-from <netdev+bounces-257105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:23:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DEF146A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F71300A8DF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA93A4F5F;
	Thu,  5 Feb 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik2n60+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6IDvx+P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5935DD03
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286979; cv=none; b=ECRZsqben3aYxXDF5ir7Hyw0gTfatfEKxinI0wiEMZQEKHp5KK+AQ+wVdQk87gSpxTLgo0Adg5BZVj4Mx86sNdN73Y8qapB46pYXgrstUYxw3iHWLQpcvAXRisMw3oB3UlYP8e5Zh+I6BcA7KB5qFYFWw4yfEMxjN7x8xLdZXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286979; c=relaxed/simple;
	bh=Tqo4aNojmBNLX85qzwDX31j1FXbp0i7ynlln5Rmw+WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBINeutanVIBkJTjyCzW33II0RUlVo5w+nDeIN5eUjnTYpTRS4s2uElah/nTj1yaHEv7YGSwAzt7wWmOgiO2yT+RRN9393dreXdCBxK1JM+gd+Eww5/432iQX3jtBbdDi++kOueNfpCV6C26TGwYcxPYaAhip9e8mnT/HcXXvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik2n60+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6IDvx+P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770286978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9Z7kEi/eMpTtIprIqJhkPPv7Od/Mcq9DJKZHjai4xw=;
	b=ik2n60+i67fL3yq9RflaOnBExtjfjwBX/ciu/3NXpuePKEzOs2/G68QaTby1/VwPGUUICp
	210Rx4Qw8f29UFP3BQmlMuL+wbxijqSr5+TlE+O4+mT55VXcSt96x5lEdtKTgyz23pGUON
	0AMi+DgVTrtlW1F9wwLJ3AF7gWdACrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-h4OrnR6pNSeF6Xb4t6sOsQ-1; Thu, 05 Feb 2026 05:22:57 -0500
X-MC-Unique: h4OrnR6pNSeF6Xb4t6sOsQ-1
X-Mimecast-MFC-AGG-ID: h4OrnR6pNSeF6Xb4t6sOsQ_1770286976
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801c1056c7so4221375e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770286976; x=1770891776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9Z7kEi/eMpTtIprIqJhkPPv7Od/Mcq9DJKZHjai4xw=;
        b=f6IDvx+P83j9xD0Qm2Q5C60uoY+olApqusNm3o861bew+Cm2KVSDn+nk4B/0mZWtCd
         pxYKTms4x6Vcntr34c1UAU1AxUARj5+Q+wVQqJ+Y2vrxsLRTEg1CpNVXCIahsbMaUM6H
         Ic2I2uPabSHAP5FFhyOPd+mMlPPPA6MPNVJxW6iS/tuh9SX1Rp6TZy2Qe+Oy6SL7YX1e
         O8IsPJ+Ty2hRLMu4wxF3YF+9wc0nNUOraUxiBqhyQyOcRWbCt7sxxRZyz3xkWiyDRHaG
         UnFNjazlNqRmwkKxkXQvalAirZiXsmxWr8isTLHr3O9pmqxXnMh/EjnfzJddv8DBJnI4
         qf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286976; x=1770891776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9Z7kEi/eMpTtIprIqJhkPPv7Od/Mcq9DJKZHjai4xw=;
        b=CtrsC73RU0o+TobIp43+AhrDPaP9mWxmvoqAH5BamPzQmsLrjZBM0+cYDybIt9U3P9
         X8B057sMwJ55ktuRvNmMxyjpwC2qrXcflcI4pVkmByFqFRnntoMMIcwPY02VGT+DjCQS
         nIp8HCbh+5INLl0CeGgSYSXXmTOczcFgjRC/ShllBGPPcvI63s9KUiYmIz6fSjB+mKkQ
         7O5PN07BkaBuVHpVoy70KUcgsnn1k94Gs9e/Wl6M2Ca7fJJe4VSyABTBQu6+KvyL8c/7
         PMFZqGS7sYF90Coz6VD2Uu5v9KNmubXC0zk+SejxZ5oSTTo57e+lIIEglLB6eUxcCNWl
         reKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8XC/aV1Mdf7+IoOrJrHNZufBP5bpajnVWzGhlXhKSaU8B17Am4EC5lPJPY+ZAD1+9l7dof6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWKz6dVXRdG4G7MoFIg9/VkZE04k+ODgHmdJp5Zwq5CD8WW2b
	z5Md2aqMTyEY069EHN3GzsbAWfdvuS2+Ds1I9XXA5zVs+jqErHpIQ90u1l+Fjk98k5Fw+cXnNa5
	C7eiYqx0PkSRJUVn9/rEOBcJCAaV3TATojhSJNoQB0emlUwO0j63mN2aA2w==
X-Gm-Gg: AZuq6aINiLJlPs/eQKQlJKUzBwn7xomjEBZFpbc3EV83qBiCd5yL7WULtgnEazpwSsI
	QmGpwd7bZ5PxAQfSleuKISEa7ToCoSu4y4AeNN5489MLuihYGbaqS+3bOhY3CLPtHCESZs5FNVN
	rTxukYeRrnUD5DxKjUSsz/Q8HhdzbXYGAJ5RLxPRe/j8iCURM02dVXbYEoFNDMMZ00f0HNZUgSk
	aQCTFKz+olnjafR7vph+8QOYZWHsPhpX8ALjXN1/4dwAmxZit+7L/tBDNv+5dl+zotPwsc0bMKy
	dNCeOzznM+sh4FsOeLHt09yCBWseuKdgW7ZmN7NQKltap6XAJLr1JRDyLwO/833y9EqLF5/foRR
	u0NYzyeev0tAc
X-Received: by 2002:a05:600c:1c28:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-4830e93203cmr89495875e9.10.1770286976223;
        Thu, 05 Feb 2026 02:22:56 -0800 (PST)
X-Received: by 2002:a05:600c:1c28:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-4830e93203cmr89495545e9.10.1770286975744;
        Thu, 05 Feb 2026 02:22:55 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2085asm51424695e9.1.2026.02.05.02.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:22:55 -0800 (PST)
Message-ID: <dd029f40-7933-44c5-96d3-842f24952c91@redhat.com>
Date: Thu, 5 Feb 2026 11:22:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] MAINTAINERS: Remove myself from TC maintainers
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jiri@resnulli.us, kuba@kernel.org
References: <20260130212021.46610-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260130212021.46610-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257105-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 294DEF146A
X-Rspamd-Action: no action

On 1/30/26 10:20 PM, Cong Wang wrote:
> Recently TC maintainer Jamal intentionally a broke reasonable
> use case:
> https://lore.kernel.org/netdev/aG10rqwjX6elG1Gx@pop-os.localdomain/
> 
> Although I tried my best to help by:
> 1) Strongly objecting this breakage from the very beginning
> 2) Reverting it and offering a much better solution
> 3) Offering Jamal for video chat on 8 Jul 2025 and 26 Nov 2025
> 
> None of them worked.
> 
> So it makes no sense for me to continue caring about this subsystem.
> 
> Most importantly, intentionally breaking reasonable use cases is
> against my moral, I don't want to get ashamed.
> 
> Thanks for the opportunity!
> 
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

We are sorry to hear about your decision to step down as TC maintainer.
We are indeed grateful for your commitment and valuable contributions
over the years.

For this reason, we believe that it is a real loss for the entire
community that the situation has come to this point.
We hoped a different solution could be possible, but we respect though
your decision.

If we may add a consideration that we believe is valid for anyone who
wishes to contribute effectively to the best possible development of the
Linux community, we believe that contributing to and, even more so,
managing this process through maintenance requires, in pursuit of the
highest collective interest, the ability to mediate and welcome
differences in contributions and points of view as an element of
undoubted richness.

This sometimes requires a significant but essential effort to relate to
others in a collaborative and respectful manner.
No one is perfect: each of us has a record of mistakes, some of them
significant, but by supporting each other in a truly collaborative
spirit, we can ensure the best results together.
Because this is the process we believe in.

	- netdev maintainers.


