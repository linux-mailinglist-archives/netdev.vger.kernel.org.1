Return-Path: <netdev+bounces-268591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AuoIENJuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:29:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D84702A9E41
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3A6301CFB9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7A3C276A;
	Tue, 17 Mar 2026 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvcrnOtL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+Q2nC5t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379D369960
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750592; cv=none; b=N4xpCKq8fwn/iCVoO5p7KUneEvGxs2tvRASo8Xmj2GfMEOB1Yz4nePCp+HMxB7Yv71zKB3bUt3cPrfbZWZ4+E8T9BMNrClWklF5Q1L9sntTzwsRRRPX0pKI4f41zP6LSdGyd3H4RuvcxlVXXVKh4GtDFoUEX5COW8FmwisxEOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750592; c=relaxed/simple;
	bh=ek/OTR9TzEQG8GC6iLctNmmeEw1KAmo/SHR2qgOxncE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiLHgHLa5697GHENU/FHap8ip7kMYq1bxCU2RPbNLMNPp8cgUMNRjCky8ED98DqejtIqe+S1YD0NVd5RGVluTrIDGW0oJCDKDLC8APaEWfPVv35bH88sZF9bssLGco/xNDjEuYxc7zpkp1OEzG0YURGo7z8J7CFW+q/M3ausiMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvcrnOtL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+Q2nC5t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773750590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuoj/plf+Uktw7AJq60yvpOQvb8+oLR4qq5/10wEIF8=;
	b=OvcrnOtLwm0vGCxTRGmdwC9dqWRlpvxlbceJTVo5U0SL5Q/VsIYBgzsozInUo/QjkDoIah
	7LLkatdrjbeziW0pfdr2rgMBE4sLTReLUg4270a9aomDPqf0Jc1chkJhBBHbqa7edHuZz+
	kEf1jdarUssp2KbMPXvGcmCC/+Wgltc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-cbJ4Haf3P4Cr80wfVRq9nw-1; Tue, 17 Mar 2026 08:29:49 -0400
X-MC-Unique: cbJ4Haf3P4Cr80wfVRq9nw-1
X-Mimecast-MFC-AGG-ID: cbJ4Haf3P4Cr80wfVRq9nw_1773750588
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48532df52c5so81920335e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773750588; x=1774355388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iuoj/plf+Uktw7AJq60yvpOQvb8+oLR4qq5/10wEIF8=;
        b=S+Q2nC5tRug3lyi3CeNQipOUbFsWpsjt1v3HD0F8S1mEsjet+sDDHFjQU6FBQvleM/
         vMeAo9XJjwcNiS7sLObZ+Kjichh3JDv/maPJZhT41+sq2aL91Kp4zmj/HbGAgKDCCdb1
         3A6hUQEnEbMyf4hQayLuvq1mCBEWi6lakZoIqUHrAAvu+XUelsxwtcNbo/y26QVX6MOL
         ZuxDq87035HRO4QWMRK5ieq0wRocZ8EUUKJua8AIDouQ4DlWAsy7sELd57RsxDpsnQ6C
         Bhl6MZVS18pWKwX2O+ZwZ6/YY9j6Oo+Np0hViOfoeQRorBT46oFD618hiOtshwq5/fYn
         OC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750588; x=1774355388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iuoj/plf+Uktw7AJq60yvpOQvb8+oLR4qq5/10wEIF8=;
        b=SZd33wtcKT6PTZfMOmFknsdzgCxIUNbPp9KqnJtiGSTe9s/2dOBOXA58TF/Eyg35rh
         hNm0OIdiGB0q04CiwmTH9K8RpzrmgACYfSGhJ2OBM6TndThNxzGcojKT4yLobW7LogX1
         J6XnzkdKD2OcEYtnW39DbNOJ1nsuusfTIv02dRCVvNjjzuKM/XkQ8RRD+O9WueEysB4O
         OcFW3NiYH4qysHt+LfGrltSOJpobq2xy4cp5gsbtwRGL29LsKH3UFjl1Qk6fjmTE2Mci
         AjMv2Y04E2FXLskpX2sdvH8MjC+3Al0KKa/SDisjbJn94/0vEMet8Lykr2V45h90kJIh
         7MhA==
X-Gm-Message-State: AOJu0YzvW3GRqAUADhT/U+bWvq9WUVz2vTJ/aG4Dw34rHbHKSqsrRpnX
	SPrYGVLMRkV8nkDC9TzOYTqidxfoxjYVeFKcB0zl8l+3TxXL248WoipcPR31UuYPwgw5M95qJLJ
	1uecr4CcAkRgvKFhQg1cDuN1Q9MV6N3VKz4qkoRf/cJEHNq7q5J0BZYBaHQ==
X-Gm-Gg: ATEYQzxF6+1CzKgtWcSE9nPj4Hwook/asxsgd3+38CruNUr9wv8K29hp9xQK+izpZ4i
	PMS2qQr+xjeCb8FmnmA7loGyS0sxu/EpnH/nE7GZVzIGDzJo9qzo9tNzIjnOCxbCH2uqT9uUsvl
	CyoWFPrlRJiDvOrgCcSBBycboA/tHtYobvpJXvswS43loTpKu+c6NPs7dkVIr6bOz/n492dyfer
	4QVUyrXfp2izrDVbEGpx4Riht5wxWeGpCI6NJEetuCN9rq8/2EQKVdsO77GTFaVWOQ5X7RGtV73
	fWJbiyoAPHVllP+dz3e/xAxzVVlUhHZI+cqS/adLtaavCkBnS7kmPPez5pmN7kkeAbbDuEjHzOL
	fUAxjjcdo3eKfjNmeP2sev/DZ16JpOsll1iddzArGY87GN2ty1ONnYZA=
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr271290445e9.1.1773750588027;
        Tue, 17 Mar 2026 05:29:48 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr271289565e9.1.1773750587509;
        Tue, 17 Mar 2026 05:29:47 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaa3b66sm73020775e9.11.2026.03.17.05.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:29:47 -0700 (PDT)
Message-ID: <fb33e9ec-d93c-45f2-aacb-7633beca7805@redhat.com>
Date: Tue, 17 Mar 2026 13:29:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] net: macb: add safeguards for jumbo frame
 larger than 10240
To: Charles Perry <charles.perry@microchip.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260313140610.3681752-1-charles.perry@microchip.com>
 <20260313140610.3681752-3-charles.perry@microchip.com>
 <DH4DORKIV5RB.3P7Z2RTRNCXH7@bootlin.com>
 <abhLO8fna/ioyd6O@bby-cbu-swbuild03.eng.microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abhLO8fna/ioyd6O@bby-cbu-swbuild03.eng.microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268591-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D84702A9E41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 7:26 PM, Charles Perry wrote:
> On Mon, Mar 16, 2026 at 06:21:38PM +0100, Théo Lebrun wrote:
>> Hello Charles,
>>
>> On Fri Mar 13, 2026 at 3:06 PM CET, Charles Perry wrote:
>>> The RX buffers for GEM can have a maximum size of 16320 bytes
>>> (0xff in the RXBS field of the DMACFG register means 255*64 =
>>> 16320 bytes).
>>>
>>> The GEM IP has configurable maximum jumbo frame length that can go up to
>>> 16383. The actual value for this limit can be found in the
>>>        "jumbo_max_length" field (bits 0..13) of the DCFG2 register.
>>> Currently, the macb driver doesn't use the DCFG2 register when
>>> determining the max MTU, instead an hardcoded value (jumbo_max_len in
>>> struct macb_config) is used for each platform. Right now the maximum
>>> value for jumbo_max_len is 10240 (0x2800).
>>
>> If DCFG2 contains the value then we can runtime detect it. With that, we
>> could make the macb_config->jumbo_max_len attribute optional. Then
>> start dropping it from platforms where we know we can trust the DCFG2
>> value.
>>
> 
> Hello Théo,
> 
> That would be a good idea. We could use "jumbo_max_len == 0" as a way to
> signal that the DCFG2 register should be used for determining the max MTU.
> 
> However, that's a new feature and it doesn't belong in this patch. All I
> want to do in this patchset is put the real value of jumbo_max_length in
> the PIC64-HPSC macb_config and make sure the driver doesn't overflow when
> that's used.

FWIW, I agree that is better suited for a follow-up than for the initial
bring-up.

/P


