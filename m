Return-Path: <netdev+bounces-272163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGmXOEJsxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:26:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F43391F3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951DC3044A62
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B742188B;
	Thu, 26 Mar 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlEwdjk9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj7CkIEb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0841C2F6
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545875; cv=none; b=OWl5vcPVfhNIoW5ZeAKvZvWPnjVJEiVE0svKpQg+scwwHY18Vc76FN8EvB0laqanbddebOEiL0h3hoRh6c+ye5YJs5otmIyUdHURKjvTAWMlYfFWeTA6Kuv22KkgZ92I4NlB/ccjA57gPottCjCOtY0GnUM8/Aa6qrWmvB4U8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545875; c=relaxed/simple;
	bh=6lh/9+lWOd4MRDZPa3R2rHb2mYK4OVHfg1BwksGxMQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVqU3DkyrjwPgwu0AE2XamLLcOSK7jv66AqQ+1T6WjlT67UTbeQI8Uv8/7qg8n8kFipgTagXx7BbhER6lhgnxI9a04NdA0a3t4X8kI0n5O6AlY9lPcld8HO3Zeb0JZlADz77TczZCWEQBOfNGt9VbC/G54AlyRpsYMG2tcHSxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlEwdjk9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nj7CkIEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774545871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
	b=HlEwdjk9AnaE7b9PF2j4iEWMSLTdJc0uFLRsexQm+77VqgU81nFjdbMIf0WuQbpwrGMy05
	kh3ieOj0LD+cNMJGySgFeRybWeBmOvqv0qXgP0LDIwtjvr3c6DC+cdTmkGNXm7B/FRCQXv
	c6nl8RJ2BQYsvgnlQjvdHCdFnnOjQdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-_phA1SEMMiW-aa7drk4aKg-1; Thu, 26 Mar 2026 13:24:28 -0400
X-MC-Unique: _phA1SEMMiW-aa7drk4aKg-1
X-Mimecast-MFC-AGG-ID: _phA1SEMMiW-aa7drk4aKg_1774545868
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b8c472f3eso739989f8f.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774545867; x=1775150667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
        b=Nj7CkIEb3B3YRZzu5mUwfOwBTAb2pInYqMs7k5iPUvpz0ZUMsI/i6eiScC8EdJeOKk
         m+RQiTbrD6tyA4Ra8NPI6lFKBH9d8mgqKMI7rJ7Cfv+wDYTXjgFEM3w1/WsDgLeFH1Rk
         5JdlMcuTA+nXRSfSjDMoKjiA70SfDgKA3ALoAmpSP+50fC0R3OYjl0DcrHzRFdOmxFQi
         rfl1UsozYVwIGTR8A6XX5Aw1cSqu8UBzA0Zz4dCXgc7ADQJ3jEelooUdlQDyVwP8PI7L
         h/svM0j1D/rn+xb07WBhk8qPPMnTcKpmjxrY2XHHmdHkliLgmgb6m2MD2tpiOfC8d+PH
         +WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545867; x=1775150667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/AKPcQGH4Dz/y9/znL7t7+7nhoF5QyraNsyrc/eBwY=;
        b=ozedxGjVaoTzz4ir39ZGyj/9AfF+lGQ/+NxfeWPqAXpsCfhz9yEXFrn22QUtd82bHq
         G9XI9ln4wpErdDC50jyt8F5YKc5RbWJ1VLxwqMrnCQkqnqAwcg60mlT1Mon7/8miYF49
         fwFLasrexXTOfuao4FkImWg92KZRWbUF3sCVJ7x+xZrOkBf3raNEENUbBmpMmXqEhIn2
         egGcLoZcMBBT1+aMSs2LkMx+ps+8a2CCbSSEXxnBp3ENSMTYAuhO/J/B3/nPU2qqgNgj
         Rh71jy0igvr/PzEQvdPR4oSPel9o72orE/j7FboAS1EiHV0SQpwjJNv7V0DOvCkvNmzJ
         laSw==
X-Forwarded-Encrypted: i=1; AJvYcCXzqg+3JDhH3L+P9ys4DmrvCukiyhj4z+8bq/nLauPSbMfGakuloI8KGVq7YLKUEzap5eff1OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRPqVNPp/9NMXNfWJFN/D1OHrxopPKjDxlcDv6oj90ehM86sb
	KmsyD+G5zOViLNL4KaF6nbtxAyYhVNhrRifdU6xZ2yyNwHlTKlr/RoOwnRD6woVrY7rSSbak+XY
	4UlS7bq2YrKMDaq3zfv+5cjVR+4xlgfNiFWNWMk8d6eiUd7AVMVJMqjG88ipF2w+kaw==
X-Gm-Gg: ATEYQzwn24d6XpnKbqzpcpdNJLKsZJzRSQDO20Q9wigENkuJ6OfJvZEnpC14gB7LhvA
	aknf/TpdtVd8mfLI3LBxQJIcQ7h6DwbnWpSdV9So2R/tv51fefqe8wgLk/V/UvbxgaqKvkyn/eH
	1H6Gbtz94ReTgkB8DNOpCHb/O1jh0XdKOWsPkgvgLwMNlqN0ycgyV9rnYf6xCnUW7CaIQTaNntU
	ERrdiO/3R7vDWY2YNu3rmLHUcJ8yMgPnNPB2cR5MvbjHLaPkKlNiu8gAJw3sG7VIC/n0ixVZDAB
	YH0vp0RfQzUUx1vmZBgCaBAgdliC+Zti+PgVzNx2lXS2E7Y56bUmUS2pKUaA2ThNq3TFP+Wch4X
	siTqpBdcett4NS6fPoX3D0rYHiSAHMtIggj5RmD86+5rzz1sPzUASKrOC
X-Received: by 2002:a05:600c:c4ab:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48716039ce7mr128858065e9.21.1774545867507;
        Thu, 26 Mar 2026 10:24:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48716039ce7mr128857695e9.21.1774545867097;
        Thu, 26 Mar 2026 10:24:27 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48720937962sm18401415e9.32.2026.03.26.10.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:24:26 -0700 (PDT)
Message-ID: <936e4100-5e3e-4c3a-8598-6724d904deac@redhat.com>
Date: Thu, 26 Mar 2026 18:24:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2026-03-26
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
References: <20260326093329.77815-3-johannes@sipsolutions.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326093329.77815-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272163-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 759F43391F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 10:31 AM, Johannes Berg wrote:
> And ... more fixes from drivers came in, notably iwlwifi with
> a bunch of things (their maintainer had been on vacation).
> 
> I'm going to be on vacation next week, but I'm also not aware
> of anything missing from drivers etc. right now, so we'll see.
> I doubt this is the _last_ pull request for 7.0, but I think
> not much more will come in.
> 
> Please pull and let us know if there's any problem.

Blame on me, I left this one out of my bag, and it missed today net PR
for Linus.

/P


