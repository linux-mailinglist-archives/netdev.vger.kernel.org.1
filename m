Return-Path: <netdev+bounces-294155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AAuE4y7HmrZJgAAu9opvQ
	(envelope-from <netdev+bounces-294155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A16962D427
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77DE30433B7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD26339708;
	Tue,  2 Jun 2026 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OYnVs0+1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97899393DDD
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398769; cv=none; b=VEho5GNmGnQ6wpaBQEESQEmrEQKOFvyxKLiLKZROXXApRpdWWKhAh/yQXRjRgUzo4HqoQ2yH+8YNULVvETiF+P63e5M+3sYm2FM2eVAOH4C4+Xj5T50gLfbaLcisN0RdAIgAHexppzroYDzs1858ItxW4p/qA/J9j0+79ZArk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398769; c=relaxed/simple;
	bh=OR388PN+R8iXCryfYfMn0uk00Bh1a+mLKoUwk2NbhB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPnJWZl0uZONT1RHz+YwHOJTm7QANL7YkaIz0p66cui8ngpGfOgSYMGDUraaBM6q8WxoXv57gkm/hg5YoLiQy8XUQDMxc/donE5U/38Vh4vAlta405Xp5rPFCIUM3aPzbpuL78bbI4JAcvOAJJzB77C+P5rbwj/pvPDBN4z9esU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=OYnVs0+1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so10284605e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1780398761; x=1781003561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKEseg4pTB9VF+7SmfAwywfYvp28t3PBtR5WqnsSCWw=;
        b=OYnVs0+1EyzuooQiMhz9iOp1wnAgxLSE8RDTucDoTL8Y4Vb4d+NWfjOz5ShPE+TSRv
         GfbfLznb2yOG3Vqgjq4xYoZFB2JE4TatGJIZDFTkKc967Gc0I+IWqyTRbVpLQ/Wh5/Km
         uAGlVLevTfPvWfJmHk9UFVknvVVLPwhF3K+bdtUnPNdkT+ZRyRT/BM4yGtSwp1qHyjuN
         3GxQKF+T8+Eq61G4/U/gYw61K/4JBegTZSSETaABP1XApFmrYKYQ/srMDcHXQN32EGAD
         1VGqZIypWLeSlpLgXJ7tazlGcu+tr2GwQAW2TTrqjMLD/5Cg1SKhUhcy+zHE2xrnbeCA
         XVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780398761; x=1781003561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKEseg4pTB9VF+7SmfAwywfYvp28t3PBtR5WqnsSCWw=;
        b=FOKb1sV6H47RZm5bhuwY3U2IN83E8oHx/IlNJI9fa/l5M8OR7IpeDXQ7yKysLsoLs5
         b57UyYxBY/IfusjflCh2+u0F9Bl9Wkh2Hep0UXcZc3GnCrlUAS+cfD5YIMWdUxe7wS7Q
         wyNpb9EAYbWSds0cCj16A2lCzL2yPO0l6eM5SgPOOfJ5XYh88B87na2JJctw0TGIG59y
         GQfKYS3W3g7xrOI7IzeM6b85A4cNRN1oOIwZESVeKkPT2UbN/7qjyDgp8tA021X7uzcX
         01rexX6KrdV5y279MOlncY0CxJeB/7D93E4HZV/yjYFXnU5cYhCPeh/xE5grikbjI2cQ
         Sirg==
X-Forwarded-Encrypted: i=1; AFNElJ/eWoICE1OqLvVM/OpHFSMjWouszOMOXSih/P9MKhdFe0rYb6Oez1zqVvnZTD1YMohBaeskuUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTUmT0I5z9rVCLUfGyPbviXF3k9I8pO05BhEjuC0KxuMHs4WU
	JWitFin6oJjMgI62oxBVkPcvi7Yi6I8Ija3dihieCt2zNkY5TFfiQEC/PjvBQ2ZsOg==
X-Gm-Gg: Acq92OGetnIObvgCZ6IZYRLvSRtCVeiLeaWLauVqPbiboyTbJeZCJv2YtwW3mE9/NMk
	+Li6qKDHGNP69jl9JABbSom+V4H4azv0eJOmhTzB2tH8tHiTvScrVeGGI+a/2Vu6E98GI3VNj+Y
	UQ4bO8bWROwZ6dTb8Jipv54stjdjJasr0TLbQ3rAq8O1g2sXEXx9e3hKZpFEaYYKjOOlcsA7cxF
	ERQy5ETV1vXixO/szAuvUpXObt9HFl3eQJJ/RNnNEoFAAuKC9NWMoEhzKOm0kavjrP1BIA8sx8Q
	ypsZwDAfZmrXi5AB+ZZI/UyZxaXfcL/5e+waLiy1LUJISijGVBQMrzPVKJsUBcU8+XGllmspeUV
	oq73EfdVsnSXVpfARb45z5PRbnTfqcQyvwMU+o1RTSS8mqIw6547vADsMB/Lk58zfAhHKmEUIIS
	cLJko7Fu89AwUMGiIHqmA/IkPRxL+sO3F3gA==
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-490a28aa789mr287889775e9.0.1780398760904;
        Tue, 02 Jun 2026 04:12:40 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm102675545e9.0.2026.06.02.04.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 04:12:40 -0700 (PDT)
Message-ID: <208dc7c2-971b-4335-bd64-a107be8c6018@arista.com>
Date: Tue, 2 Jun 2026 12:12:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: tg3: guard napi_disable and
 pci_disable_device calls
To: Jakub Kicinski <kuba@kernel.org>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260527115535.1686932-1-yurypm@arista.com>
 <20260601195049.766544fb@kernel.org>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <20260601195049.766544fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A16962D427
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arista.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294155-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arista.com:dkim,arista.com:mid]
X-Rspamd-Action: no action

On 6/2/26 03:50, Jakub Kicinski wrote:
> On Wed, 27 May 2026 11:55:35 +0000 Yury Murashka wrote:
>> During PCIe hot-plug events, uncorrectable errors can be reported and
>> AER recovery for the tg3 device is initiated by the AER kernel driver.
>> The tg3_io_error_detected function is the AER error recovery handler.
> IDK, I really hate this NAPI specific tracking. Can we add a callback
> to struct pci_error_handlers to let the driver know that things went
> fully belly up and the driver should pack up its toys? Sounds to me
> like the key issue here is that there's a side exit thru the state
> machine.
1. We already have a similar check in the bnxt driver. Please check the 
BNXT_STATE_NAPI_DISABLED flag.
2. I'm trying to fix a specific issue in this specific driver.
3. Your suggested changes are a long-term option for the fix. They 
require a redesign of the AER feature. Plus, I'm not sure they will be 
accepted.

