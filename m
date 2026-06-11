Return-Path: <netdev+bounces-298014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5dzONd52KmpkpwMAu9opvQ
	(envelope-from <netdev+bounces-298014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:50:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A067003B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=e2OBe6Ow;
	dkim=pass header.d=redhat.com header.s=google header.b=iXCp4n5k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298014-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C66B300D614
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202D369D54;
	Thu, 11 Jun 2026 08:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC536212D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167834; cv=none; b=kvfgR0IHEXVHDq5IhVq9+swY3lNqiPbV2xPonQCYbt3zKAOkdNCjBS32ltOaf82aAXsPaBdki3AtzLAyYBOfO8kyNh+r5zxuR66Tv6xm4igFXUTOBNA/0GDRTE+WCxLnxRpfatPn+tuqNJtncZAMl79dgcTH1ZdcivwGJysJ//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167834; c=relaxed/simple;
	bh=hScv+/Dg2XQbBeFR+q7U/xKDIGWAPmkZJFNTNr4VW+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7NPjct6/0Q126SyRko2hUi+CL1BMVrvoJGRZ3UD/Rx3aFedJMbRIlrlDOqATthAeFVPrBu3+5RzlTFYsY7+k8/Yee727o8iENC9HNEiwyO4LE3iASOxraxPUSL6tYi6qFni0hrl4U52otT2OtWvQxVFFvbkp+5N1EN4grde8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2OBe6Ow; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXCp4n5k; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05L3jrJVlFcQn4GVsQrHr7saBG8RDpkpSs796Rei0Dg=;
	b=e2OBe6OwVkNn1Ui8VH5KrJDerb5JbJKanSqJbjl35xU9fZGr1oemzuWNrPknDJ8B536Ou5
	uFEwoktXDY4AxhNQGt3zBbQaHSoV+cy+SgWZmxTQhbkwhF0+2dKlihipjf7PrPXyoAMsqu
	rMeOs6s2dwu3vIqugVLgL/RY9Xnl+cE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-m0Dgz_Z7PHW4fFS1e9MWfQ-1; Thu, 11 Jun 2026 04:50:30 -0400
X-MC-Unique: m0Dgz_Z7PHW4fFS1e9MWfQ-1
X-Mimecast-MFC-AGG-ID: m0Dgz_Z7PHW4fFS1e9MWfQ_1781167829
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-beefe797002so394732766b.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781167829; x=1781772629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05L3jrJVlFcQn4GVsQrHr7saBG8RDpkpSs796Rei0Dg=;
        b=iXCp4n5kVCvG+4rhgO3o9on6fXwHcwNUXNnlp1vq0ffTDMrETcUzlEzs69DW5l7S57
         OTWusUGzECXgKjY4SkC8n+JLcTz5ZnqyX4fW11Lkc1NPpJJ4ejM3/8Ftzofk8SvSM/LN
         DUC7Zka8JQ2ow0cKfOffwAX4K72xl8GwOVQ92QiAsSvef+RBlkiYDIFDrSpH8UX/xlHm
         zbONGwfpr04jY3YID9nNP89ChTRTUbeasWaeniS+C26iXmpv0mFSC4wOnIHiL/20Izep
         hAa0uTvN2sEQkCTfM3gmRAoyC1LTn74NWqdhD617ECfLtYGCzW/8XAusaFHKOjcWfS5I
         rFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167829; x=1781772629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05L3jrJVlFcQn4GVsQrHr7saBG8RDpkpSs796Rei0Dg=;
        b=tRwIncyv7/G0bsqJCKSKAftHG8paZwdRcCRXiAmf5c40fUQjByHh7Sh7gZ0dJ5auHt
         1/4te2cCJrtvyYUyOorpqaLwt39lKvlZKqqOmAlHxIL4ue31AgqFIroRqlez92PQ34/E
         sriFnK1Bdljj6257NgewuHx9f3ffvaZAd9U9JzwO2IYATOPC03F0V7rCOEved3Uyej84
         KzeqdfCbRMnv7b1d4y09ytOyIu9c+5LrI3BwyVYXFj6gIHIeUjuY7MRM6KSXPCvnlcGm
         TUiP1Fb+L+Lvv0N/1Kyp8pw6U5BYrLYVAnU60xwzr9qIQy9IPtp6/ZwLl4YGfAeXvlFT
         3PjA==
X-Forwarded-Encrypted: i=1; AFNElJ+6cxVlOitHIf8kTQh2lY3gEyDTv6K/dQv2QrPF52DA5gvhK6EXs0NS6NgI+DMayXZJpsttwLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLzM1nFpBLnv4Q6kizsGlap3ZedYjehiw7Ye1oPBLVk611JZU
	/ulBz9Ue+kaDRlZs0mrcFT0uxtnzMWCT1Sm6+R3D6lu6ukI+i9luw1A5qFcYwCE53o0b1wNnEo2
	/M5Nj0VZauJ8Te/rz6It96D5gAs7rCdSZHam/+2eNzrO2z1X5+4YOQPovSw==
X-Gm-Gg: Acq92OEc6jGvn548nqkkshfi66SqQj1Y5DrdXMJSu4Bzi366fQnTJeztXoHzpLfzsPj
	P4M6HewNitc/eg9w1GimPWmyVFziMsBWPavHqvInLyqCIFIFadnj+21ImRpskyKL+s1GGop2u3k
	V5MOdk618MROAVKJi8eI4qEjDqeeauJ5br4z2wWsIydmwvkcyxOdC5qLQ5x4xcvzG9ccZuFUU8q
	Ml+sSSZwiXvZN/k/SGU9mzNLnLuUE7eOhw2L0AGhxXs70XARNyJIwau02VKdaEt8v3Xj+ik7JEm
	w0RgGUhuNpm5BLg/kRFjdpNGp6LmYTA3luE+WUXH+MKJ221P3OUyKis46CSk0z3MK7jjAhthd0Y
	vbsDOKVQIeIoTJM3CbA75uIBd7t5HfZoU6tRPzgUtN8MKpbb9ahjf1N6vYfx4agbmcA==
X-Received: by 2002:a17:907:a04:b0:bf7:a616:cafa with SMTP id a640c23a62f3a-bfc880e7160mr73166166b.34.1781167829371;
        Thu, 11 Jun 2026 01:50:29 -0700 (PDT)
X-Received: by 2002:a17:907:a04:b0:bf7:a616:cafa with SMTP id a640c23a62f3a-bfc880e7160mr73159566b.34.1781167827875;
        Thu, 11 Jun 2026 01:50:27 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb1607631sm34291566b.14.2026.06.11.01.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 01:50:27 -0700 (PDT)
Message-ID: <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
Date: Thu, 11 Jun 2026 10:50:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
To: Grzegorz Nitka <grzegorz.nitka@intel.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 poros@redhat.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260607183045.1213735-4-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-298014-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 691A067003B

On 6/7/26 8:30 PM, Grzegorz Nitka wrote:
> Neither parent->dpll_refs nor pin->dpll_refs on its own is a correct
> iteration target at unregister time:
> 
>   - pin->dpll_refs includes DPLLs the child was registered against
>     via a different parent or directly; blind unregister WARNs on
>     the cookie miss in dpll_xa_ref_pin_del().
>   - parent->dpll_refs reflects the parent's current attachments, not
>     those at child-register time. Another driver may have (un)reg'd
>     the parent against additional DPLLs in the meantime, so we miss
>     registrations that exist and visit DPLLs that have none.
> 
> Walk pin->dpll_refs and use dpll_pin_registration_find() to filter
> to entries whose cookie is this parent. Symmetric with
> dpll_pin_on_pin_register(), correct under any subsequent change to
> parent->dpll_refs.
> 
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

The current guidance is to avoid the Fixes tag for net-next patches,
when such tag refers to code already into Linus's tree.

If it's a real user-visible issue, the patch should target net.
Otherwise if the intended target is really net-next, no fixes tag please.

Unrelated important node: sashiko (gemini) still has some comments, some
of them looks new and relevant to me i.e. the possible divide by zero
bug in patch 11, see:

https://sashiko.dev/#/patchset/20260607183045.1213735-1-grzegorz.nitka%40intel.com

/P


