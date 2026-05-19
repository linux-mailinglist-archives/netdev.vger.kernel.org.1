Return-Path: <netdev+bounces-289371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIEAF2UzDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECF57BACD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D56033089A0E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132745BD78;
	Tue, 19 May 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fsr6yzeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F739282C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184074; cv=none; b=ddN37+AzLXUNeEcaSftOI0E2EEa3hqUp9PrBJmrfA+Z0/e8IFsUbHi7itvZiGvpJTqDTqRkGHe5JA9GRlBWCLFhqwlKFtHGIr1snzjBde4RIIWCKWtieavtFGNrw8BYcGk6zNaeiYHBcI3QzVaL17KbujpModZg118on4IkzMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184074; c=relaxed/simple;
	bh=7wmEXaSPptYY/r/mR36e90hMTnm/HrThK1y8Mr7L4u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LDLtOYm8wSAYKfvWdvGoFdQKtdR0cxn9hN7/bDbs7aF++Dj4AOiyI+cs/IxHJQxERJ8yDxfbPar8lfSEo283DcA/evXdr2I12hgDngf9S6wBtWWcxPiGLiZGMIcMDLOS/PdDf7aNbahQ1AaXN473pzJspeI06BKHpOPBrQWi0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fsr6yzeh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd124546379so609153866b.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779184071; x=1779788871; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV3iAX2q0qgehd/Y9H3He32OWW5yDlKO8wzkeiAQo+A=;
        b=Fsr6yzehG/UPn+GIY4AsTdJj4Yovoypo+u0Z5rjZT099KWXAyIX5hQ9Jlf2Z42f1eY
         MhJpITXlEGv2zR+NxVo/OoKZkgdv0/0LGk7FULeij6aaGT2PU3RJmMEMWNP9WhuJ7DQ/
         0wRYdA1g+uHb+B23rWPhLcB1IN8GGLTQhAFHbRYbAXqN3rrU5plMwhZfBlx6jo6lSA6v
         g/4+IgP//WSUGQ/iU1aHEqWERxMQjDEx660P7jBrM5gS5eOQT8eWoJOpZpyi2ZDdgkmD
         191fxqYBC9ilUe2tUoMVj1J5jpLd/gvc/+ZnnB/gMNfWDvsV96V33RqPwStRStEtBw5K
         H2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184071; x=1779788871;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LV3iAX2q0qgehd/Y9H3He32OWW5yDlKO8wzkeiAQo+A=;
        b=jwmMWjjFr8ucCbBCFTOgTnycmBoZjyt1vimgJVVLmFIXGwDpKSXk2IXCyXo1CwMUjM
         0j+jZmYXze5NFZ1IGP+5FWewWp3Y2X6uzFV8KouVg38W/GQY8zzlluUdFQ5vK1cKRZ2A
         /TFtQ9YoOVljAY77m6Di/k9bHE8eZgvizR3yxSyTcvY9FuHhOZm8Lx2QnSRtccWKWWqb
         lm92cp7AIZCm4+sg6O4QMaE346dGE0ifWiy6E0Maze/xqE8678IDq09i5vVIFMqae5n2
         50ODpZsloOk4DVYrapUhA1Lyz7FR1RkfNWWvC+RP/hyramrbPJ4brCFs6PySS6DW8375
         SD6g==
X-Forwarded-Encrypted: i=1; AFNElJ87xvO7m9zyaAIytkGnk0zQpJrzQRdfw/Fo/3M/MTssO2J6U4nLE6m82iHzp1dH62X7Vlwe8GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygn3M8pe/GjUPnjKUbLMgVB0WB7j7uX1vOClKyRDXN1ezWh8AH
	MSBygHoK0jAwjZOUYy5M4dKhftmMsnQp9AgT1ChYaK583jzhv/aqmfnMmTvWYRLj4AP79JnxjEH
	p4Jll7Fk=
X-Gm-Gg: Acq92OFZwMk7ra1l6iBbQLx4t/FlPtyRdnwbxP5qrSDjNKdKZTtEvLznV3ljn50YEVn
	Q2Hg58QsrvMnxch25Lmz+Gl74Bd0cvvdtugx86FKrxiSQIRLyfmJGR20f8aYFZaPJvSSzSnbm+W
	pk8WCtGXIsnCB9h0vJhD+He6S2KPmWq13n4bmsjZ2Ef3iVFAhhnf1T6Kw/gY2fNMQSZcoq+nYMS
	74E2M2vLPSVxM+eqJQuTMizDOl6GA9dxtptIh/n2pYa4Ws4RdgacR+75HpVWnBB+gWTXLsZ1xT7
	0anBfUsUTMwjN8MZHN5XO5X2sY5ZVWy+sDiWPx/8I8AWI/jgIbZ6IX+QzUDF/A+0DTxbhXbTz1Z
	rndZYG1lv5j2GukfbCFOsy72wfYR3zgTcUL69SHS70b2KmcyyuyqkR8/07OYe4vikOhJFoubyXg
	/irPovukLIIeuocF4SiXHIM0odLMBMTufF4Zlt
X-Received: by 2002:a17:907:1608:b0:bd4:f2c3:69ab with SMTP id a640c23a62f3a-bd51796b1bbmr1123158966b.41.1779184071264;
        Tue, 19 May 2026 02:47:51 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecb7sm6148755a12.29.2026.05.19.02.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:47:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,  "David S. Miller"
 <davem@davemloft.net>,  David Ahern <dsahern@kernel.org>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
In-Reply-To: <20260518161827.2ac4766f@kernel.org> (Jakub Kicinski's message of
	"Mon, 18 May 2026 16:18:27 -0700")
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
	<20260518161827.2ac4766f@kernel.org>
Date: Tue, 19 May 2026 11:47:49 +0200
Message-ID: <87h5o3ohmi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-289371-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 0BECF57BACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 04:18 PM -07, Jakub Kicinski wrote:
> On Thu, 14 May 2026 12:47:09 +0200 Jakub Sitnicki wrote:
>> +		/* LWT BPF programs cannot access skb metadata but can corrupt
>> +		 * it with helpers that operate on skb headroom. Drop it.
>> +		 */
>> +		skb_metadata_clear(skb);
>
> Sashiko has a point, right? Is there something in LWT which would
> prevent us from working on clones?

Totally. I've just been spread a little thin lately.

We have a bpf/selftest that uses tc act mirred that exercises this
scenario that I need to extend.

In general, anything high/med from LLMs won't go unaddressed.

