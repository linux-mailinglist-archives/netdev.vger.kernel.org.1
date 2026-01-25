Return-Path: <netdev+bounces-253201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDsVOrx3dmnqQwEAu9opvQ
	(envelope-from <netdev+bounces-253201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:06:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39C8250F
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B5D30038DB
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEC2F0C74;
	Sun, 25 Jan 2026 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TevhOiBd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EE26738C
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371547; cv=none; b=S/WRVKFShyrtbhNHNL0jMIvD27Y9ILi2du0c1e1W1sPZwjcmz+Ep8qi/1v8vNsU1ctY2TFVdfvBKJnigh72fPF4z73+X5QZEui8BW+N7fX3fHqINTboc+49kkfMxBQBT+1I368srOGZ5U/5PgXBD4z2eciAMZH2mTcPDBCeMAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371547; c=relaxed/simple;
	bh=ycGk0CtMeW7gP/6ErJi71CoEIMFACqdsXe2eK58bneY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAuyAmQpt6Ml+pdXmBzJQDHmapDej4SyKiI0S/7/bA3n1obkF5GqE1OcHKndRWJthkycQvUowmZxwxDH6ax7653yEdu9lR5NMbzsWywVmZ9TpwC26V9M5TONd1nRnzADDEQT2JUbi+DT0x2Zc7aUQPqFKgP7gZwlMur5tZMZMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TevhOiBd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso30078775e9.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371544; x=1769976344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n49mtwqBKQFWj3g1whYCmVJ/2ZLD1Hd3JqwhErWWRKw=;
        b=TevhOiBdN+bELy7jGPsvP1EFTlwzBGCIbvFDx/h5bT+OrF8bP9t3WVNcu2dJmiTC5T
         FwnvuabW/ePxex3Aal1tVhPGJgCW5zpoYJReprW0aNMcFT4PfkAr5GDwMs0eucTP9Xr1
         FCpskYdJ1DbOCjxEG5l3MAXp7ww/WNv4mg5S2vYSC8zQDLVrzrjM1iHvOjA1SZ/XZTjU
         fDmkKbczyE0FT+KFojSQTTtMLphlpuCAcZdgozzNlyQDHxf32jXPdBJhIChRONvVhTrn
         mQLGUFyRgFi+GUuHd622veR06+Phfn+6r6HW9B7Mh1JGT2BwT2b3gc/Kc7ra0T35BvL6
         jtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371544; x=1769976344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n49mtwqBKQFWj3g1whYCmVJ/2ZLD1Hd3JqwhErWWRKw=;
        b=hKlGfqASUvfp2VYfLhrc4uIFsOLMMHwhvV8v70z0p8hGGPQkTNDKLLgqCP1aEKbSSG
         UDPkgrtQ6ABkt9N08HcLZGG3+aAf3fNmDf8+dyRvYkqWcophNm9ziIqBE9I4SQFWrskE
         PqBPp9DyiEahmYcefDJz5vbGGjcTAhiUEQmtg1ws9ArHTK2f8r1gBDpQ+RByb/jOmm+Q
         oYU40ma07KJ3MiQS0SKGmLTpTedsPpHPhPsZ56kVhtOScT6t1D2XaN1ujQoKWXmQr32h
         20fWk0UlOlLSEYYgUgMMdSNx0rzN5kr+Bm0jteaJm9VeS5Lol7X6VCLbwxoraOwVcuX0
         ZAiw==
X-Forwarded-Encrypted: i=1; AJvYcCUNEpcGaRJgdl4y2KyDT57ikxfhjzoZ5vDJr/1ajbgy0gcLxE33NPUfynedtOjL5IIeSL70Ykk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0Qvp8WzypvxZ1+2TLj/9MKQ39H2bP6PX5mCqYUXqxJO6MLpf
	JrDxDAe8Aqc/CbfIGAxrJTetzQWZfJQo0bo8m7x0+vsFmlCpPlArTwFour/HzA==
X-Gm-Gg: AZuq6aKF298Stbb/VlvUwsm//8e5f0jzveBKr3FG3DAVfkmRjDPi63BdJj1zCul6v+X
	3EN/YlkmQkQ3ZU3VW5DAD88utoeWu4Kxq/MsEnXXUu+AbCr3RRkBlBj1D9rA+AHfKc7HsOuuL/u
	IN2YRQMukDhMjE7sTrgbAGkQHGB7tdapWQFXaVnDP3/VCKBHzWjUlTZ9IF975gA+nhatjvzgs+e
	dbmdVEJEESE225OO6qA+SHp4/58q8DfCbtzvHKZTrEq2sI2mZdUy8iM7OXOF8uAOA5wriV6gxeS
	ko9J5d2yBCII2j3NonVCMaz5zI/O682UUo4Upg0MyHsEzTWnnMb+LJDZ85GWGMagaFu9XO20FXH
	EB4Pzwa6I+IVgcpSiKJEkXJ7fpAwYDMG18XgL+FGQT4mcaGeUxe0/214BoQlotHwiPieWdv/N5+
	ZrSBtlxoUtgAHGOBD1NZ41aH72bqtD9Z+Pf5Lr3151bkTFW8WfvO/PJwQvl2qv32Hf7sCaKJLBe
	JsYJqvIvZQBFkVfeOWeIixBTMUyw9jeRAUA8nEkQrccrknnDih0TQ==
X-Received: by 2002:a05:600c:64cf:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-4805d0646cdmr38080635e9.34.1769371543887;
        Sun, 25 Jan 2026 12:05:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:cf00:d971:93b2:48cc:4e22? (p200300ea8f0fcf00d97193b248cc4e22.dip0.t-ipconnect.de. [2003:ea:8f0f:cf00:d971:93b2:48cc:4e22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm306058025e9.14.2026.01.25.12.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 12:05:42 -0800 (PST)
Message-ID: <6b52acda-026d-4506-8864-8445fb8c432b@gmail.com>
Date: Sun, 25 Jan 2026 21:05:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: make PHY fixup support always built-in
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
 <aXM96CNzkiSIPukf@shell.armlinux.org.uk>
 <66f110ca-3a49-46fe-a996-c5ad477b8f4d@gmail.com>
 <20260125115701.27a3db0c@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260125115701.27a3db0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253201-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3F39C8250F
X-Rspamd-Action: no action

On 1/25/2026 8:57 PM, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 12:39:22 +0100 Heiner Kallweit wrote:
>> Recent removal of the dnet driver removed last fixup user not being
>> platform init code.
> 
> Oh, driver removals may need to be reverted if someone speaks up.
> Could you wait at least 2 releases with the dependent cleanups?
> We had to revert back at least 2 drivers we removed in the past.

OK. I'll keep the change in my local tree until then.

