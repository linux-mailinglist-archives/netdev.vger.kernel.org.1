Return-Path: <netdev+bounces-295243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xFx5AeV7IWryHAEAu9opvQ
	(envelope-from <netdev+bounces-295243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:21:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94455640467
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Z7qWBLZ+;
	dkim=pass header.d=redhat.com header.s=google header.b=YwWmMvKB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295243-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADCE3036629
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011EA47CC6F;
	Thu,  4 Jun 2026 13:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E164418FC
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:19:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579148; cv=none; b=obQw1A/gUj2v8VwuW7gIp3nUfitvWVA4QW9DxWcULcY9/uaKp9jT4EIj3XzB30x3pU0WQ2ICVGu0mxe8LPT8Go9ZaI6Shp9Kjoknu16dPNvm1ox4g3cqnhwowcyY+IZIDjL9bPQFV7yK8pAuF493Z/qIFUUhLZfHK5BAR9+MWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579148; c=relaxed/simple;
	bh=ZL2GPEr3Ol2qT7YzkCE58F7Qiw4vVP+eKl/QElSmojU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfCWc0dwuE+SRu1cEcykMyrLchREl1FxJy4tQow9ReqbDxP5bUK50ld7Mv6ZjywjHqcvcCDSNPuNZqliXqj99lw3ZiQnt6gQ6k5d+Vq1zPqktajlsBn+YrVkbWtWv6M/Se10S8/CQKPCTj9ioRpzqkGfNZf9TI6Hg/6wl28uzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7qWBLZ+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwWmMvKB; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780579146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9NLf3OTZQcVdHSOSM3gNimtkOpf0GLwo462qJlWyY4=;
	b=Z7qWBLZ+7W1wD640MW6X2CeqEV9yN0OvHoVCmjzDuTTCJCuA92wBmo5mIP20YEZN4cwAzE
	T68zOnpJ+MsAV2N0af00/ba1CDrCKjY1GtaDzfa3nn/o8Mp85dj2bZc2gZ80VkUddITN+l
	z2htKQZYij+YW07fGTCqDMcnPTDpTTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-6cPGE0vjMC-lwadfO3p1sg-1; Thu, 04 Jun 2026 09:19:04 -0400
X-MC-Unique: 6cPGE0vjMC-lwadfO3p1sg-1
X-Mimecast-MFC-AGG-ID: 6cPGE0vjMC-lwadfO3p1sg_1780579143
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a7aeaddbso5738755e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780579143; x=1781183943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9NLf3OTZQcVdHSOSM3gNimtkOpf0GLwo462qJlWyY4=;
        b=YwWmMvKBg9sN0srUH0/NYGk8t/fDExQDXtR8OsE068Yj0onW1r16hCDGGeFeWLbw80
         lzwlW7Kq4bjnB+JfpozomDf4Hr9XoNq5pLgHLThbEKBAtGzjkqEbapxTwCpus4MtSnrH
         m7Jzz5JZzGyKBZhV9MVfkg+zdbDc9V5zo9Yr7BH+Ct/6QY05rYGZxmceVPJEH2a+UcoE
         UHVERDmswwo8IPbNWPgMgHT6o6QUzKBBWYg0dbPgu035CvGPnvssKqcpYeTMPQ7F/EpT
         NdSew8+ELJC3XgBpJSJdI2yjqbDtSN6jwfPytI7YczQt+KIFkDi13DCqIvrss8Wllv0k
         X07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579143; x=1781183943;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9NLf3OTZQcVdHSOSM3gNimtkOpf0GLwo462qJlWyY4=;
        b=rkgnkF61Bc1NtR7rnxKcysEyGAFV19K4Tx9fYR1K1wzsoWJ+eQYFHrIuhbOls6Z80o
         jvYQ5s5frXXwE+tCvUf6I2qNxReUoh6VAbG4+Qc72o1xZZapblZk/DxRpV1kJ3iEKkGd
         kwI14JsnFR13x/wedjUYyUspMKBOqwHb163OoT+r+3C/fco61+hx1QyAjKCQV4j5/1CS
         lv1jmB3tAgB+IC3DdlG7GfLIZ6v847CIhC7R6hRLELZ7qPnVeYJpuKTpeDc8zhy0mthc
         DhYdCeWfbrqaHRuL4qXQMBaqerbgUGVNdOduL8nb23hQFxDpqIATrPiF0+yA0gPFxl/u
         lAbw==
X-Forwarded-Encrypted: i=1; AFNElJ8b1X6QSymoLX8kBuoy4szuNYMYKQD2GjzNXOgvLI04Jfw3tFkuKeiH/B9tOjhxXinESP/j7as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8p+jBoYK/t1QuaVAuW+GqgRbMG9EbMxPbSS+BNKJzAcKFUrF1
	RkxR3uUwpLkG4uBzY3nWekQnbtJDFVBbtX4FVMRo65RNU9JfVynJvoq/wVO/dPz1mEpsjo+3JqZ
	5HKtvJkFxqN1NOI69wqNj41qTZhGri67+sWdZFinoRG/hE7hPILKEV3vTmw==
X-Gm-Gg: Acq92OHHamH4npWmaB4FNEUf4N0VicCckTDVWLipM4RAPrc2e6VR0SRiLTBzso9BKYl
	jfZ3YVlFSjJkhE9nmOlGhxIv0jxU42g60+ZnSafhJWK2HBTUDpYEIKlGIQ2Lik29zz9IfKMsmP8
	3i1Qdj5Ak6Ix6ciobHXy//m26NRptgqnJpiGK8bTT/OynhB+Gl3OB26R8mGiIEB4zI23IhXhk0u
	EZGDAYeGqQbJ5mgcgxXMK57Sliiud6HdOqndmX8MYizhqmcH3aBX9ialfcOrd8nK6/I6hcy+/ZH
	TyxEEzbi6Vfiopok7O9doOs57v0qADBa/9r/IcTonxYubIDEPzSXFe5Ud7MWF4OKYlohM/C6Cyj
	+Qkdr3BpIYrMHT2jLv9nJfQcUC/rqi26vsKA2DAXXDXqp19GPpom36dFoicghkm+jZnM=
X-Received: by 2002:a05:600c:6095:b0:490:bb60:68ca with SMTP id 5b1f17b1804b1-490bc4b54b4mr51068615e9.3.1780579143354;
        Thu, 04 Jun 2026 06:19:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:490:bb60:68ca with SMTP id 5b1f17b1804b1-490bc4b54b4mr51067875e9.3.1780579142742;
        Thu, 04 Jun 2026 06:19:02 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a273e3sm107604705e9.0.2026.06.04.06.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 06:19:02 -0700 (PDT)
Message-ID: <42052da1-2d33-4023-b383-482006fcb628@redhat.com>
Date: Thu, 4 Jun 2026 15:19:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/2] Resubmitting with cover-letter and threaded
 patch series.
To: Selvamani.Rajagopal@onsemi.com,
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Piergiorgio Beruto <pier.beruto@onsemi.com>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pier.beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94455640467

On 6/1/26 6:07 PM, Selvamani Rajagopal via B4 Relay wrote:
> According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
> specification, MAC-PHY interrupt is "active low, level triggered".
> The specification mentions about the conditions in which the IRQ
> is asserted and deasserted.
> 
> Bug is inadvertently introduced by treating the IRQ in the OA TC6
> framework driver and in dt-binding YAML file as edge triggered.
> 
> Changes are done in two files
>  - OA TC6 framework Ethernet driver
>  - YAML file for the vendor that already uses OA TC6 framework.
> 
> Maintainer for this driver is already informed and aware of these
> changes. Testing for these changes was done in onsemi's setup and
> found to be working.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Note for future submissions: the cover letter subj must refer to the
series content, and not to changes from the previous revision.

/P


