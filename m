Return-Path: <netdev+bounces-259417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDz4A/vSlmndogIAu9opvQ
	(envelope-from <netdev+bounces-259417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:08:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991215D372
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC22A301950C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759663358D0;
	Thu, 19 Feb 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vv1QYuhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247970830
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492088; cv=none; b=mKipEmc48PWJ7wgqXIGlSqwoI+eRKqOHqcWJOA+Ei17X30vxemQP6N86FkTf/ZP9HlV+3u0qPgPaOvExdcuwanerFWGfjdgKJym1mhMMHOz7JyOXOfnO2ND+fUlHyhbAOsaRRZ+IOxreFvQWR5EWL9G+X68j/VL/VAURA1MbIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492088; c=relaxed/simple;
	bh=R4zOkh8j9WYg1RnzjoeVY8RuZ5akoF5Pc6lFo7NEKxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBhWJLCUVCVVufjl9JrEbH+W/s/1jVEk0pS9PUVsVW/UvKT6y8vY3n4X7xy+NveFMFpHv+iZERbUReOG1LzAa7DpW1FL/LV5H6Ag4vM8lH1UhK0bjeg663TkOBkiDrAX3va9Lc2VLjtr/USlrjHXxFPhcaTUuulMuweolhm1nsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vv1QYuhO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so7232655e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771492085; x=1772096885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/9wHYnHGTTHempFopgxz7/CmcRcIGwmkHQS+IZx3zI=;
        b=Vv1QYuhOI0RfEt9MF8af/8o+mSbyH0wwdkg7eWujmTDiIeyBRCxpyqKfXakJ81Ewnz
         pQTUIy65qrKkPJD9zH36Vy9tNtfD+xQUtOXPYZwXv0r9uHaxmj0GECb3DMn4dx4ZLcUd
         /Z+GApAVbqigtZFnicBvpS0Pl1kV6zmtC9MsyVEzDutEoNYmN/HDTGz4+h0iRpOrThya
         zzgoV5g/XqVfnLNwNOSTl6qiQgZjFqRNOTpTMjQNcYiJ+XThJqAku9/wknX5bmhSLkgw
         LdLJ84ko5+zU0hQIYLQeONchTsBRr9/mBBhpFa8SMqq9+jHOcU3V0dCrX+jY2jnhJzod
         r/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771492085; x=1772096885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/9wHYnHGTTHempFopgxz7/CmcRcIGwmkHQS+IZx3zI=;
        b=gRuJrKbBsah5HUZNP5rHKzu0Wt9XAsljEgog+x25BOIpaX0US6/IwZ8YAxtjYAFQy9
         XWTORIaJqPMVKvpllQHKW687nWKlIqcrv6pUQ32erHLKp/oZWIB1QsU+MXR+BbTvNhJw
         7TcJbleEEHvv4fsqkA8mGLbW2t8MZnJHTTg04X9dTwYrxBAH7OhU4jUdCbXv/ICQTrhH
         t3Mop2Yni0Ojahn4lB58O2Poo0GFdGqHLvOShz4UsezDfEqSvo3deRAuy4R/kX8iT+l/
         uhSBI8u94cd9WB736ZWfLG1pmTgS9CdPE1HBC8Sh80HlqBpfJlhLTj67Z7Mu2s36tJWe
         OBLw==
X-Gm-Message-State: AOJu0Yz1lgwBi9RYHF4jsvrh3HnECgIGIxlKPaQMsLPkc4rYklN360A8
	dO+He/3QWlYQZKPRYJk2zVqNxstpWkQBe8v7mGJ15Z7INRYiWjxi1KF3U5O7HeOjJv4=
X-Gm-Gg: AZuq6aIXp54MqjaX3ldZ0FbZLNVWXVsjL3gnsTYCPy+yyE9qUd/YpCoNWGhaS9GJDD2
	IqrRcwnlaeB97ei9TbC5/hm111MMEpgVIHaxMSjkzN54zVJHCh5nR00cd2AGbRufCuOdJjAOPv2
	s087mQn+8Gr3NbIUNz3csBMnCproYkiyssRbCBQTP3oxMB9qXvDQYaCJOA3CUg9Dy/WGY7J3x0v
	zPs7ESNkX0HwSxtxErJUi5s+6IyUjfOGcQjwJ8Bh6CisnksjNAY/g/rFJBz+xgSuf9yjVlzJFbf
	uoWIxwBzaMRk+1HLXrWx8Z6jmx/3T8wdau7yAILQx3XaxpXx+kPXb0KXQDUJig3l5gVG79vugMy
	Enc+LvCvEMMR7jf8Hs8I9QeRK3tTR3Clip9DiXjEHYuTMMNU9KfAgHqKyOb4jXa52YOS0sNhMXq
	gFfLJGvWZr8zfjt+Fn5HKN/D17+qobzKTIq2TSwgsua49KPaEi/VdNJU4Vffzo3e8P3Y0=
X-Received: by 2002:a05:600c:1c20:b0:480:7162:fa48 with SMTP id 5b1f17b1804b1-48398a549ccmr79991675e9.13.1771492085201;
        Thu, 19 Feb 2026 01:08:05 -0800 (PST)
Received: from ?IPV6:2001:a61:13da:3801:6d37:5b4f:1853:c2db? ([2001:a61:13da:3801:6d37:5b4f:1853:c2db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f95ab0asm18354175e9.7.2026.02.19.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:08:04 -0800 (PST)
Message-ID: <815a5ec8-4dc9-4716-9168-65be07f7aeb5@suse.com>
Date: Thu, 19 Feb 2026 10:07:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 2/3] net: usb: usbnet: switch to dynamic allocation
 of private data
To: Andrew Lunn <andrew@lunn.ch>, Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
 o.rempel@pengutronix.de
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-3-oneukum@suse.com>
 <8d1bf5ab-f154-4e64-84a2-929d06fb4e6e@lunn.ch>
 <9256ed08-d7c9-491a-be37-afb4d245e4c0@suse.com>
 <d72011ec-4c44-438c-8354-10b8493b2fbd@lunn.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <d72011ec-4c44-438c-8354-10b8493b2fbd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259417-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 6991215D372
X-Rspamd-Action: no action



On 18.02.26 15:01, Andrew Lunn wrote:
> usbnet_priv() could do something similar. The initial version would
> return the address of the unsigned long [5] as a void *.

Thank you. That was the detail unclear to me. Yes, I will rework the patch set.

	Regards
		Oliver


