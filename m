Return-Path: <netdev+bounces-285491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLJYIfX//GmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB524EF241
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C563037E7D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536B340281;
	Thu,  7 May 2026 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRmSSZ8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0822C0F81
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188237; cv=none; b=f4hRhZ+MJpKZM8vmfOpeLn0LvyMSDIGkfbup9qzUHarVvIfV3YqXc122FAuypBeepFyQWi961qsvdFRvVNVai26P91xRXh3emtamMi4OI4H/GRr0MZfr1L3nxnJDohuq9qi5PY1s/pvrG7aAFvqdJ8Y5V3qJ88hiZ+sS8mWm5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188237; c=relaxed/simple;
	bh=C1egXataboGD8V7S8nUM75Vxl9j4LaRqMZQEa8H73cA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBU1UuQ50+SDPf6QV1ID8mbyfaVinSL9Ly0IIvCqymLrf18Pd5500EIZXsvmWmolnT7+tRBt4jnIVdEmiwFxzL4OuXtfiMIafmDWGl0OWwtboAtgzGSrnabMz1a0v6AyqzJcfJmxiqco78jqFGKY45P8LPVrOINv7kS5q98HiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRmSSZ8r; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso12209745e9.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778188235; x=1778793035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDB2kynTXrWcwphsOwn0vQehydK3h/uhiBsQVkQ58dY=;
        b=nRmSSZ8rgeaWkfeK8d84rCgBx91kU8mWWx+q7ksIvWdQzTkzTpMh20Q2If44XGtKZ6
         sD60MREIWzhHlV3qMrq0/V928m2g9KVJLxBkOsadK1GNo65/A63G1M0NGoCX4wTVXWBl
         AicguXBfkBgUl9AhA3Pc7VIBrhqmG5KMuW6sYnJ5zLPI2pY1/lQJb0glKKbB5k4KUW+T
         ypXiuDBsDB2X/NmCYaormQ/9I8FRUT8PF5ue/RN2KlPr1Eu8KMVq1Ox/apHN0lnGcWxt
         fqewyT1GNUryFjzvtoqxAXGa/rWcSxIamM0Apkdkp2ug+bQs1WCmimnI5xgtzkz3XgSa
         wjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188235; x=1778793035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDB2kynTXrWcwphsOwn0vQehydK3h/uhiBsQVkQ58dY=;
        b=QxBiUK872zwsuh6FXUmJsb+Uo3fMot2oc6ttgpTgjhdqPCaxzU6AEI2Nt+UR2S0gVf
         2bpQ5oN0K06suTesMm1S2/YnHG/MeisiI0a8ji4iyfl3DNnjjIqRGXxzeUy6JNLn5UWh
         pPmNNBzTFTDWoNnmZHB/9aeJU0PZLYq+9GuTB3LJ9Sj43MTDxpbifEo7QrKwMI86i1UK
         Qz2sGxovFM1ACVs7bDNSsvv2reNwBfFb19PC5xQixv5H0Dl1aGPhPQWkF2A5YUh5Chnx
         qWD3bfcXf5uLJdPHTOAZr4EyBJz7IpMH69dOpwjAARkvcVjQ6MbVnJtLURJ8JSEitTG8
         s6QA==
X-Forwarded-Encrypted: i=1; AFNElJ9U5UTgndjY4bG2ujakMQmth60TsQgSrCPEkR9BDIHRKrlQMMbKhrw8q9OgMtVn+3ktXtzs07I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHE5E54PhA66NnTlNGJPCY/HA0fDl9vQTLM6yu4XHcnyO6QmuL
	Pd0x0J9eU5EyrGfzDYqFROnjtvJcbreL73yRbEuZOuFqcN7KJlRZIe/E
X-Gm-Gg: AeBDiet1ZR52guSgwyZ56HhJ0j2VrU/Zv9o0DkGL78QbScwSSARcpnJQSQzc37IdXj/
	+chjIc50nU/tIabjxv5HzYXXCK1OXySHWeHesn/ZQ6jhr5/R/QGuRM0xXb8uwC0zBlu9pKb5GUt
	TKmqqjKChDDD0N40vHDmFeb5Fw28L6ARjkUTNzzC0Nr3wwRzVTB5oqs73F3KSzBfMu8TmHU2al+
	ZlIDzcDY7KXtieF3AGCOFkv9PqKRVQSOaesgbXH8XpT+9jTeFSxGEOuTTrJ+1/3UWw5/RzMiKNo
	W2CnUVcrauzB8+AHzsVxIYRGcCdlr1dWUOFzey61IGY244XBWACpjXHC+xdwFFlAfhs0oTO7Gde
	Wv58CEKbVgMUu0LH2SkvHDiklr++2Y1j6phBZBBlu2Jr06lgoCbVfbBlLuwTa3K27ZKIh1r/zKd
	mGpVPy+SzGYfA/FX/xt1+qwD7H48zY4SoPhRRuxRsZm1zvnb94Akp0oUF5jAWo5E1xB4vTx9dOD
	FA=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr87304385e9.10.1778188234385;
        Thu, 07 May 2026 14:10:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6616481asm6938195e9.3.2026.05.07.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 14:10:34 -0700 (PDT)
Date: Thu, 7 May 2026 22:10:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?w4FsdmFybw==?= Costa <alvaroc.dev@gmail.com>,
 jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:DEVLINK),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with
 strscpy()
Message-ID: <20260507221032.059b29a7@pumpkin>
In-Reply-To: <20260507075234.1630060f@kernel.org>
References: <20260506211415.16343-1-alvaroc.dev@gmail.com>
	<20260507090445.3448d536@pumpkin>
	<20260507075234.1630060f@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FB524EF241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285491-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Thu, 7 May 2026 07:52:34 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 7 May 2026 09:04:45 +0100 David Laight wrote:
> > >  	case DEVLINK_PARAM_TYPE_STRING:
> > > -		len = strnlen(nla_data(param_data), nla_len(param_data));
> > > -		if (len == nla_len(param_data) ||
> > > -		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
> > > +		len = strscpy(value->vstr, nla_data(param_data));
> > > +		if (len < 0)
> > >  			return -EINVAL;
> > > -		strcpy(value->vstr, nla_data(param_data));    
> > 
> > The only sensible thing here is to replace the strcpy() with:
> > 		memcpy(value->vstr, nla_data(param_data), len + 1);  
> 
> That'd probably be a good move, to avoid getting the broken strscpy()
> conversion submissions. Care to send a patch?

I'll lob one in soon.

I'm working my way through a compile that errors strcpy() except for
constant strings into arrays (ie the safe ones).
Why is it that the worst examples is in the 'secerity code' :-)

-- David

