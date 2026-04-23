Return-Path: <netdev+bounces-280627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JMfOsXC6WkAjwIAu9opvQ
	(envelope-from <netdev+bounces-280627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:57:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292144DC25
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44621305C8EE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CC3D47D9;
	Thu, 23 Apr 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="Fd+Y0jAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8C3D411A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927327; cv=none; b=VS73AanrC5HJLwUcluSinxnnZpPqAADWFimK7qm1CtGjCI2acMJyKOhrp17GN6AUhyJ2zQR7P6rMMn6j9jM/RXt97zmWRtnQLm8NlbkpovOnIdlUMZWbIyA1BztWZaZ0iQfLhOLl7g7DEIx/v6dCHPLZs5yVkDu/0zl51l2S69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927327; c=relaxed/simple;
	bh=WkK0k/e0hNXF+pgwnaYOKO1eVKPkc8tQ6NYSLjy9qVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLSS/XAAKIhcxcG9jc1DQwdnqAyG6MLgCYhZ+DelsqNDREUJ/WZCuUsvsE0W60KNGZmtUSeHMa3KI37KBYBKwB4wA2BN4AzL4OXT/bFg/y03G5rPcU5d9aSmBoN5o6d3RhUNZCvgxNl5G8L8vUJBdcNjih0RVtAVhZEY0g4b9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=Fd+Y0jAk; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12db7bf1541so2634299c88.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1776927324; x=1777532124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKzsjqI7iNKcF5Q0iWD4bwo8udZOOyNt3EuqeHWnF9M=;
        b=Fd+Y0jAkz6C4Fx9f/zRoYFB2oWEeWQTCCFGGwqW62keipxm4aeRgSRr2hBnM2WSQ+B
         8pZGVF2/cYo/195cuf344zFNgyoSvIiOKLPX4ZPiJQAPjIvLvfPWq4RhQSP7Axag0TtZ
         ASm1x/PClm0Avt2UxSECy+32lZZ0DZE2Weora2pkW3aZhwbCENAlC8xqDstOuaIB9l37
         te9Jydw6P6xG90+BAZL0yUK2Fv0VsD979ZuGLqFKPNN66qjZa5HOW5buZymy67G3PgIB
         cVyu2ScPB+aVoKpxW906uyFAMwEkKfKiqpfSGF6UHgb6ZoUaNkxkBsaxLgXqjPGk2RMD
         k75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927324; x=1777532124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKzsjqI7iNKcF5Q0iWD4bwo8udZOOyNt3EuqeHWnF9M=;
        b=Rwu++O0fh6O+egFEZC0+Fxj3hWihGJ+92tYxt0ouCH1mzo3+uFIwZF6CHzXFZ/eG0R
         hgxyf3urzjIOxL6t7+aZfT7Txk7nmpVvJ3ru1XiQkU1cuny8oPIvfNtx3OCm5Y3LYnfH
         IqwBBCHgiklEdL2g9K71roeziCPX2MplZX0Fhx5UEBS05TGyXwY6avTAFRCDcGKYCX/o
         77e3keGlPHp3+evHWyZi+a+8HkQgSpvW+qHDDKBjCRTnCgXePbDh/EhnJU2MQ4hBmwrC
         bJh7yDK9RhgWzJmNNDosCEcEvW8DoQsFX9gyKNiZx81TLpjH/9UBNadE7SaOC3RJrRAh
         pkig==
X-Gm-Message-State: AOJu0YxcX7HVcCq8DPv54OBtkjOKZzGZV26kM/UAqciybstKPVcujRTd
	LTT6VlbmDFNk/WF0q7NFD4YK4v4g+KWh4bBZWBt0zLw0D1vkhc+QO/mcgfhk0apCEGg=
X-Gm-Gg: AeBDiesVHeNIP34cLUnL47DPNnLp8ueKpRz5WcHHIxjII+qKlsIohYIVqgjjrQxWaKG
	7WLtKk+1BBJ7xvTxwZaAlOHo+tQOU1sumP8n/lhLURPETaWrHiFZuOCq6JRTywyb/AIqGSnAiXu
	XduvsE1eUWmWrsgFYC4cEGXWlGV+1WPa4GWERty8tGu9E889XX4o7ELpfBEBJGg3uKNb54J0lCK
	dH22RtSAVwGQtz4G1+TaibZfjS95UCzM3++CqbgFoZv1AqQovHFGmhBtrxYmm+2SBXBYXGqKXyL
	jM8RkwcMQFx0J+9FUCPsujamIih1oOGiHyt5bqJxnIxxyEGgb3JlVVuvNoYVbCu4Cm2ztBgXBSE
	nibB/rnw2kSatLnUztAWUn3Jg6+/Fb22z9Va+CyYw3AqyLmKHN4eofp4f/jpVNQEfZ112Kr5FAX
	hHypC8QWjFYzgKQmPbCY7hnR+vEom5Z+WuiS58okhlB/TNtLIXWtSQXNeCFbczWgTXIeJXdjgD+
	6W5Y9tMFczgJ6s=
X-Received: by 2002:a05:7022:fa0:b0:123:2c98:f65d with SMTP id a92af1059eb24-12c73f6fc12mr14027226c88.13.1776927324063;
        Wed, 22 Apr 2026 23:55:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:5ae0:228c:e58:7bff:fe94:34ed? ([2600:1700:5ae0:228c:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm27268805c88.3.2026.04.22.23.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:55:23 -0700 (PDT)
Message-ID: <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
Date: Wed, 22 Apr 2026 23:55:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423001517.79219-1-william@wkennington.com>
 <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[wkennington-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wkennington-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-280627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[wkennington.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william@wkennington.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wkennington-com.20251104.gappssmtp.com:dkim,codeconstruct.com.au:email]
X-Rspamd-Queue-Id: 4292144DC25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 20:47, Jeremy Kerr wrote:

> Hi William,
>
>> Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
>> check to ensure we only transition the flow state if we are actually
>> going to proceed with the transmission and locking.
> Good catch, thanks!
>
>> Subject: [PATCH] mctp i2c: check packet length before marking flow active
> You'll want to indicate that this is for the net tree, rather than
> net-next, so something like:
>
>     Subject: [PATCH net] net: mctp i2c: check packet length [...]

Thanks, forgot the convention...

>
> With that change:
>
> Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
>
> Out of curiosity though, how did you hit the hdr_byte_count mismatch in
> the first place?

Our current theory is that we have known buggy firmware on our NVME MCTP 
devices and we are seeing some kind of corruption on the bus that we are 
going to fix in on the firmware side. We started also seeing kernel 
crashes along with the bad firmware symptoms, walked through ~110 kdumps 
and found i2c locks that were held by 2 owners (eeprom reading and the 
MCTP TX queue). This ended up causing deadlocks in the i2c stack that 
result in panics. We noticed in many of these cases that we had 10K+ 
BERs and 800+ NACKs in the i2c driver stats struct at the time of crash.

>
> Cheers,
>
>
> Jeremy

