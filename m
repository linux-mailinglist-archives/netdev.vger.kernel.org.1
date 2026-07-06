Return-Path: <netdev+bounces-304999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8U2WCB+bS2o4WwEAu9opvQ
	(envelope-from <netdev+bounces-304999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3E071055E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Oj1iMQPw;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304999-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304999-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC4FE303E9EA
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5242377B;
	Mon,  6 Jul 2026 12:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B6423773
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 12:01:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339263; cv=none; b=CoxzyyCmvcFABTVE9iUVWxsuUF4TpWSK8CF9mV5Q2rm9iDSyBTIkmP9lyeRXQcEYYW0byni03YQqKCJRIRnOttr39RoBwTwy1ndVmH0PhkZ2aVjEzuxeROkP24M+BBuWGaqsOs01MZiqvnNGQdcJjwlFE56SahQB9P+zwWNyP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339263; c=relaxed/simple;
	bh=EAlHrwhetPy5UUC3W8aIh5wf5YgWxz04Rg10+M4pvug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hHqXSqNE3+hGjTXdUBFyjQQgSaBLnprRNAKE9i1oOe2OM5VzSPwG4oto35l3nmJWNDQqxTLAYkSYmrNUCrIoNdn5CVOIGbuttFcyTruwHWKxHbdVnK41TPQTBxFLXo700cQOxpDMNi9YAHhj7ALJx3PkJ8ZSQCpz3uTE4+SM0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oj1iMQPw; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso18717735e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783339260; x=1783944060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fprC08uNeLBQCAiE9ZHVQcO4Xl64TZSly/5LDUMpKCs=;
        b=Oj1iMQPw7xpYSXItOqRWr/n6qemHggsm13KqJ2SokgtGuiAcpaeyWp7LLQMsBOcbp2
         6PK55C5AAcr0vzLCUt/QoJFj0bMUqyu7KF9jtcf9MHfm3tBBjABTGmN8WQTn9cD+KpdU
         6zTH2D3Nfmg7mvGfDpR/UimTBTufaW7AY0L/OcVXeXbHlszjqVljooKbQMnaTfSwctaC
         1XGcWV6VguhM6XsLNkFJCH4kjZIoRUYsZIMC1A9XWRHgwo2D/AG2knuM5kgdWUl99GIM
         myO0igsRg42UY/nZ53uJI5LY5EM2FPxTzByIl/Ot2wkQYxtDwRnSdHKVxLjKsXAeww9F
         f9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783339260; x=1783944060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fprC08uNeLBQCAiE9ZHVQcO4Xl64TZSly/5LDUMpKCs=;
        b=szlZbOKXxhesEyWuVd3p1yJI0+/9EOlEgB5NbgdLbvs7TpL8OdVMiLoo+Wcp432wHY
         4EDQv3OYtAqbAcdVLzhb1cBeAQoysqnkRmRW0cltObJBVcZv2xlFMzoQa+HWK13+eYjz
         PFp4tQpz0EEWEoUtf9C1jjYcaRK+n+LJWos/+FF5sRPtO5Df4zfcwH3+wgBEKlBaX9Zh
         qCOcyGtCJVzOE1v2bWB3RR/eBRscrgj9x8yqOyKmPaLo53ld4bggEM270dD69laamb37
         n8yGlxLTR2GKSobGGGBoQybLhDdkG2KTPdt+5Ef7WPVpfR1YbyfHhUSWlMKuJfo2+2T8
         HM6g==
X-Forwarded-Encrypted: i=1; AHgh+Rqpn6/eFbhRwRXV2LMkCZY4yyq9rDM2g+zn9II0fW3liBwRXibgfHMUDnq0dc7+55e5DHTHOuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+KyOMyHzm06vDamRpYvOmxUC7sUDg9A9oNpGDtYQG85odnPj
	fLW9gdV2EtACywP7lWZ2K0hsiw+35EY67E/bMXyi+2PxqARcwGDvUBpRNp2qx3KkaoQ=
X-Gm-Gg: AfdE7cn5PkO41KKaX3yujul+vU57rzERZCNNQyUmqONiuFDmyy1pEeXX3u8UbS0xLln
	1XHsYs4UXxj26T6/HIDzBCAg3rSUukTsHJVVa1xuqt49NXXybSaY9A4DQscr5RGHI3os/7w7n3p
	tRb/p8c+ufoP5JpwQ1p8TGEQ9eeHqouYw3U1WVSX6CAHFSz+eLM+NFre2e99QTeU3ktYw/SwVHF
	tiMiGA+v5CrXC8XXopCxeS6jU2QcEzxcmHRstEZvD3KOCBweZbrIelMB9DerbnzzTwKz09LhXio
	DSuc5m0vulbgDRilFfA3WtxaPGURzkC55p0L0+pRG8Phuv4KHq+dsrym/wLpQ06T5jppFYT+G93
	fHZLHRccCy7swLiyRNjEJv1PaBZK1nJDVhvO467b43iRPrG5/ArUHIca0aIgD/RVdg7+igSasxi
	pl1/flVEnLbzlSq80ygJWuFMdy++Fpz9N5/gTiTgk2NgO2wRaTxmzjPo8=
X-Received: by 2002:a05:600c:540e:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-493df0aea9dmr865725e9.26.1783339260467;
        Mon, 06 Jul 2026 05:01:00 -0700 (PDT)
Received: from ?IPV6:2001:a61:136f:7201:4a82:7cef:c61f:a3f3? ([2001:a61:136f:7201:4a82:7cef:c61f:a3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm24625159f8f.32.2026.07.06.05.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:00:59 -0700 (PDT)
Message-ID: <cbb51e43-ad79-4b6f-b38b-3ec2221de814@suse.com>
Date: Mon, 6 Jul 2026 14:00:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: usb: centralize usbnet_cdc_zte_rx_fixup
 in usbnet
To: Manuel Ebner <manuelebner@mailbox.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shaoxul@foxmail.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702143142.890654-1-oneukum@suse.com>
 <20260702143142.890654-3-oneukum@suse.com>
 <ebfe837b7d4ef61442822105c3d71ca306106c14.camel@mailbox.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ebfe837b7d4ef61442822105c3d71ca306106c14.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mailbox.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE3E071055E



On 02.07.26 20:19, Manuel Ebner wrote:
> On Thu, 2026-07-02 at 16:25 +0200, Oliver Neukum wrote:

>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
>> index 5544af1f4aa5..7beea6d0e731 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -2347,6 +2347,25 @@ void usbnet_cdc_status(struct usbnet *dev, struct urb *urb)
>>   	}
>>   }
>>   EXPORT_SYMBOL_GPL(usbnet_cdc_status);
>> +
>> +/* Make sure packets have correct destination MAC address
>     /*
>      * Make sure packets have the correct destination MAC address

This sort of puts me into a conundrum. Does networking code use
the short style of comments or not? The documentation says that it does.
I am fine either way, but I need a clear rule.

>> + *
>> + * A firmware bug observed on some devices (ZTE MF823/831/910) is that the
>> + * device sends packets with a static, bogus, random MAC address (event if
> 
>   (even if the device ...

Understood

> 
>> + * device MAC address has been updated). Always set MAC address to that of the
>> + * device.
> 
> Always set the MAC address to the one of your device.

Understood

	Regards
		Oliver


