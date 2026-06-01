Return-Path: <netdev+bounces-293774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHgrJp2KHWr5bgkAu9opvQ
	(envelope-from <netdev+bounces-293774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3287C6201D8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B9F83012541
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431A342C8B;
	Mon,  1 Jun 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8gfCwmj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="arPen6Oo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6F2E92B3
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320923; cv=none; b=PnIQKpjqqGyVGxH4P4ZdIoUxKj71UUyAJUU3j/lYeH5LgcrQGP3OWYe+of2+XVumpKm3zgSf5bClNl7fpc7zI60G2PuCVnykx0PvTut3qqcEIXJVYn8polto4i3JXmsjgSRwDgJ7OBHQkZqmfFuepH/b3+8EfK9yWgqpFPFxdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320923; c=relaxed/simple;
	bh=m32qSUAXVjpyncss7GiQlnwAzl/QfOaeg7wL0TgVbw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx2qLuscik06TFjI5QjzVR0c5GIRpg+GMU11rHUo66svfJCrd+sDIamwznTlFpAOGhCjuMHlRxdVuP6LVt1Nlu9HVkEbSpkXsmT7goOoP23u+nPYforSGkiKpzJIz4zv2o0yjzoR8nSPNRasFQGa7vysozFE/mYtDqCicoFGMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8gfCwmj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=arPen6Oo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780320921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfdsTh+3CdSmsfs62S4cjyp5X9DVQGHdp9VpFPmmxi0=;
	b=K8gfCwmj+UYNr4aVFp5r9dkEDMCZtgpJCmoPKzPbpM+G+7GxVEc0VJJVv9FajA4dTxWM1w
	SavXLJcDusD7Ta/LnL0vVpjxslAsSJtLd18eKzVYw1Htepe+2hiKCHRnoSRVV6uzF2p6P0
	Vgmq30Z7GAjkPtK32EmJffEDQsLZocs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-L4RcIpteOgeOT5cYKBI2ow-1; Mon, 01 Jun 2026 09:35:20 -0400
X-MC-Unique: L4RcIpteOgeOT5cYKBI2ow-1
X-Mimecast-MFC-AGG-ID: L4RcIpteOgeOT5cYKBI2ow_1780320919
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4904ee02e72so80903555e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780320919; x=1780925719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfdsTh+3CdSmsfs62S4cjyp5X9DVQGHdp9VpFPmmxi0=;
        b=arPen6Oo4/PXMavakwqR54v2+/8wWPUT4uapOEXC1Zedg/aw4lSDObBRBmOt1f3NDQ
         LOnYFl1SGdwG1JOzhItlbItd2RMOT3Rvv7L/Sr6HM09c8wp/+LTrdHp6E8G/RoV+COZB
         dauqUIIbllrqEpQsBsBiA25b4lz2iNPoFiIoUAuq9WhBMbmuN/xElSBQMpQzZkgbuBZG
         4Y7Ie1cmT0so3vBpXEIgxYadFnh4oe8hyokzc/9qnTcmWykk8NTO99XMmLea9lBJ4/9z
         ZGcYHNP925ifY8U0iP0LSxZ1wMY0ao6iQv2ADKUYTy2F+ZlgmxY/KvYllHSuDSuUOn14
         h1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320919; x=1780925719;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfdsTh+3CdSmsfs62S4cjyp5X9DVQGHdp9VpFPmmxi0=;
        b=ZefrEFhfz7jJRWzTLATqen5ZloBBT/qqQEkpmc1MRs9NJnCE/5m/XfX/ca60EG89j/
         aCSS5mUoihi8U0qNxRunGiMHdf30sbHg09KnK/1AGhoD419WI+fMO8TvQbU1d/LChpB3
         UhJb2HFftFUpmrMY4apqiEWFWZkymPhx/I8k/jUf6dcETE+izM3Jc97Hu1d40jAUyGFD
         wIAM/GHSsEDNcDqH0nxd4RNDjSecUBL7lcZx1apxOMsQ58uj+TGwifDKOVL4Ew+czcQt
         qBJHY4SIE4xOLxEcUywBAI7XFEmWgNiXUQv17FhmAM6/bb80mTLrLh0gu2a+ngNOqR/a
         clnA==
X-Forwarded-Encrypted: i=1; AFNElJ/tbdLzSPLjdkB16S+iI7ksm1x6X/qazC2cNSpiUwKhoOe5FRyzfmmsst9LqyZMCgxkhy3zDiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivncEQ6QiD2sTp58d2ZtkFoOrcXOsY7DrM1sjqkgOSGEnB6Wt
	9RzWNd03EaBTV7UEUbT++qLe/BibJ9HktuyCmtOcEwwQA/XBlz46eaEuIy8RkmpjKu42na6gEiL
	MnPRPF4qW9ykhzMHkRMdCBUyeCfu1bVqPVTmpf5fsdcCmjUdOHmSqhT7wmQ==
X-Gm-Gg: Acq92OEXEWx1IOYMD1y5+ms2k9H4zphyNcnJbcee3UI9v31LjGsLAZR9vJH3Y8TYacb
	pvt5ByLiHbXnLcYYW19pje4gl8fLKudsSCAaxyv+EgHkEbqprKGWuJsdFrDMzCsqGnHMdhYCaVI
	STSc17y8+fu9IaXbcuJw5jYAVCInAykfhwntK9nd8oD9UdQ3PtJDqKpbrjrQ9CljZ8jpXCX10J1
	WWbRq8mxqISu311uK7D04xD+3AEnp/r/Y89F4f8hOChi+4GxVr56iwXUvTvyglVfZerB6Wh+8Ys
	gEmkbbIXHlgARgRtoyZOH6RfP7RbcpcNUKq2keol25cOi4R9WvalIuv1ZNq6OG/4Xo5COkqx9Vo
	S8WcEvfzdu9QMhU/7h3qx22G8WWHIP6bjGiRBhCwku7EyvzhYD9muKh5kaFVWaNFW2rOB
X-Received: by 2002:a05:600c:c285:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-490a2966ce7mr121903485e9.24.1780320918807;
        Mon, 01 Jun 2026 06:35:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c285:b0:48e:5fb8:f80f with SMTP id 5b1f17b1804b1-490a2966ce7mr121903135e9.24.1780320918354;
        Mon, 01 Jun 2026 06:35:18 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b079c7d4sm67795e9.7.2026.06.01.06.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:35:17 -0700 (PDT)
Message-ID: <0b71d385-7504-4a5b-8e21-dcf7c692d456@redhat.com>
Date: Mon, 1 Jun 2026 15:35:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
To: Jacob Keller <jacob.e.keller@intel.com>, Rosen Penev <rosenp@gmail.com>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260526202247.13823-1-rosenp@gmail.com>
 <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293774-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3287C6201D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/30/26 1:18 AM, Jacob Keller wrote:
> On 5/26/2026 1:22 PM, Rosen Penev wrote:
>> The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
>> threshold from ndev->mtu directly. The hardware sizes the threshold
>> against the L2 frame minus the ethernet header, but does not
>> discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
>> 1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.
>>
>> This is normally hidden because JPSM (and therefore the MJS check)
>> only engages when the MTU is raised above ETH_DATA_LEN.  With the
>> qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
>> during dsa_conduit_setup(), which is enough to enable JPSM and
>> expose the off-by-VLAN-tag in the limit.
>>
>> Pad MJS by VLAN_HLEN so a VLAN-tagged full-MTU frame passes.
>>
>> Reported on Meraki MX60 (qca8k switch): tagged VLAN
>> traffic drops at 1500-byte payload, while 1496 bytes works
>> and untagged 1500 bytes works.
>>
>> Assisted-by: Claude:Opus-4.7
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> If this results in dropped packets, that seems like a user visible bug..
> Should this have a Fixes tag and target the net-next tree? I guess its
> not a "regression" since the driver has always behaved this way, but it
> still seems like a bug to me.

Given it never worked and we are trying to keep the amount of changes
into net under control, I tend to consider this suitable for net-next
i.e. enable DSA support.

/P


