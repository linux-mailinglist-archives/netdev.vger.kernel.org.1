Return-Path: <netdev+bounces-293611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPeYIUxAHWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E761B5A6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 729DD3006D6F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D03890E2;
	Mon,  1 Jun 2026 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkQbxeZk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pOZnbAMW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F9387369
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301894; cv=none; b=uyJfC7p8kmYcJlGbBsvWsYQDpRBD71a0tFF6Uc8D6APax2juy7PpTy8dMg7ouOJP4kQ/ao9LG7+SCxsYFoEvGWkLfFTBPpzr7AATA1wXe2wFAXBlhS04UAWn2f+fU9BhyJBahVH9XG3wocPvqiagxemf9R59ZZsP+MXbt5l6/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301894; c=relaxed/simple;
	bh=6nbwqc7SoK4Z8hnTgJZRBIB6Kjm/CRO/04DycozixlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVenSOQ247kYC5W+gWg+xZz4fVvuzgBnW9MdJgxr8tlThdEy8ZCtWhD3B1LJKQXSoB+6fmjkhcdC2x5cXOtp4YcBgyPqMGNjTED+M4A1Z2d5ieApzI0zYYyuTlJtskpUh8/+IfB8zn3UBSvSmHlyV86rJ3Ge3/k7X/OG/G+oDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RkQbxeZk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pOZnbAMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780301892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEJJ/20SLX0lkU+fV5cPCQW1eeTUdHRlLZryRM9YpJE=;
	b=RkQbxeZk3Mjr6FuOO9kU4dOsXAUSODlYySS1oPxuUmHoWFCTC2Sk0BRl9QvxOYHVZd0r55
	5kDATfQl6oDrciVnyx5z9TcjJX1QQ6gYMhbRWdszBOyGnW29wUtvK9SfGdRIf1YZNprqdO
	qDY1tPTbMgF4QyUAAlmcxtrYzj+MLmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-N96ey9QkMRmnBC-NDdgVGQ-1; Mon, 01 Jun 2026 04:18:11 -0400
X-MC-Unique: N96ey9QkMRmnBC-NDdgVGQ-1
X-Mimecast-MFC-AGG-ID: N96ey9QkMRmnBC-NDdgVGQ_1780301890
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef0af9517so2459340f8f.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780301890; x=1780906690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEJJ/20SLX0lkU+fV5cPCQW1eeTUdHRlLZryRM9YpJE=;
        b=pOZnbAMWmxMvOEwczpaWRk17yId07Pvm3XoEr6//ksaFl48F3dmcBgU5k3qOEOODcq
         5aF7iR8h9bQsro44pXTqS3PAj3MALmXy4/chAadWwr6FP3if22F2umHQNOt+QlgAm8V4
         M+e6jRSd9Nu8XGNxynuHKMZHsdwj9+4oo9aFDZmJljKrWGm1gTa1R7BQDRZcBI+TVAKT
         pAOwMtaqI8ii511oR+qy3SJBhQmPvsm6mRRllAJiRD5Ah8pADjRJr8bqYh4PqpFTeZ2p
         jsITG9Eb9bGxGK0P6HDA7CImtPfCYJ087zroo8r158HYlnCN7UUYZASYoaMh9i32hLMe
         6WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301890; x=1780906690;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEJJ/20SLX0lkU+fV5cPCQW1eeTUdHRlLZryRM9YpJE=;
        b=L3OenESheAGcaVyfkGJWw8WXy65Fup1sDMr+7oT5QvmBs4J4GgHvWF85KzEtzXSLmC
         BZWS8uXNo/hnMqhSMU7Hrdj1Te+l7T4lClAjmn21pcPnHCn42h+BDYNuQwwAFLfsCI/e
         mn7nyqJCKRptqXgFMkbqkBgvQB+7B//+zmDJ5fkLZCBe7XksqDAp8xjvc9Vsq/QJQeVK
         jylLNB2GzMa4aWBj83Eq3pANnwVjEYlrlHKyNNv3suLuNfzFKhYOpvl9hdM5PeIdXB2p
         jX1ocZV1n0s3+95eyFDu/ipBXR3gIFQQUME5nByYDtEYTmwIohWv/hckmL2UEEQkLKip
         U12Q==
X-Forwarded-Encrypted: i=1; AFNElJ/h8FxASNlckmesCDLY/wFZGuCohtERXFt3j/TIRBx66UYqwZ5P8E9HpF03zJfwiV+wstExM4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3feE/ExGEmXu7Vx84AN4+kbT6DqHkTEXB1Ddcx2NCoLrIKNBn
	EnUTERrgVZmOCohMpx4+qSydP4Nk4mNxSlFaOCd77g1yPp3qBpsqgGzx7HwfaDJyQg4n9P1ZMxr
	myGGXfZckualOTcPB9WQrfq53aWNVA+02M7AqGVHFf7JeCwumzgJXLemt7shsO1JzMQ==
X-Gm-Gg: Acq92OFKbx3+LVm+zejk0HDaS9s145P2ZZWG2bQaoqEeUK5AF1RFfFAWBb9Dn8hhl7d
	hvp3MjgaMOZn8hDoKqi9jnQwWTShrmDVcTf2qdd7BnfoiJG0DPAqeg+dPmTWfnHUHmiQmjQMMtq
	OWd+4/jVFmTt6r6ROdt7ybjsja9b2duCO/AQ5w95qrKcRAwyt27oqEeUsA6WWXa3WFysw0Jyvpx
	MQGvp6CsiBjY+gPEPVBfAmG6IAdDjgVLqcETjOyG5sf1QganmfO4M+Ep9nAdsUG6UBJuihN0TaT
	XxaqIq2UyfiXKejLG6QQ29QBI5JJ1wLjQr5tFNVWEGi3i0Z1rsu+bSlRi14G4Q3ffVP+5YTizoU
	yC3RY7nVaIpSwSTpjVvbais1kayhM4Hzwn80cVHq8RdzueNTjeW5kFumEEkUaL8mdYYxw
X-Received: by 2002:adf:ea85:0:b0:45e:f302:95b with SMTP id ffacd0b85a97d-45ef6b8b285mr13537452f8f.37.1780301889926;
        Mon, 01 Jun 2026 01:18:09 -0700 (PDT)
X-Received: by 2002:adf:ea85:0:b0:45e:f302:95b with SMTP id ffacd0b85a97d-45ef6b8b285mr13537384f8f.37.1780301889474;
        Mon, 01 Jun 2026 01:18:09 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm23670057f8f.15.2026.06.01.01.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:18:09 -0700 (PDT)
Message-ID: <479e07c4-256e-4b34-9b62-bc6fd31438f5@redhat.com>
Date: Mon, 1 Jun 2026 10:18:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 0/6] bonding: 3ad: fix carrier state with no usable
 slaves
To: Louis Scalbert <louis.scalbert@6wind.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
 kuba@kernel.org, fbl@redhat.com, andy@greyhouse.net, shemminger@vyatta.com,
 maheshb@google.com, jonas.gorski@gmail.com
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-293611-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 849E761B5A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 10:40 AM, Louis Scalbert wrote:
> Hi everyone,
> 
> This series addresses a blackholing issue and a subsequent link-flapping
> issue in the 802.3ad bonding driver when dealing with inactive slaves
> and the `min_links` parameter.
> 
> When an 802.3ad (LACP) bonding interface has no slaves in the
> collecting/distributing state, the bonding master still reports
> carrier as up as long as at least 'min_links' slaves have carrier.
> 
> In this situation, only one slave is effectively used for TX/RX,
> while traffic received on other slaves is dropped. Upper-layer
> daemons therefore consider the interface operational, even though
> traffic may be blackholed if the lack of LACP negotiation means
> the partner is not ready to deal with traffic.
> 
> This patchset introduces an optional behavior, widely adopted across
> the industry, to address this issue. It consists of bringing the
> bonding master interface down to signal to upper-layer processes
> that it is not usable.
> 
> This patchset depends on the following iproute2 change:
> ip/bond: add lacp_strict support
> Link: https://lore.kernel.org/netdev/20260408152409.276358-1-louis.scalbert@6wind.com/
> 
> Patch 1 adds the missing IFLA_BOND_BROADCAST_NEIGH in if_link
> UAPI header.
> 
> Patch 2 adds missing broadcast-neigh to YAML rt-link specs.
> 
> Patch 3 introduces the lacp_strict configuration knob, which is
> applied in the subsequent patch. The default (off) mode preserves
> the existing behavior, while the strict mode (on) is intended to force
> the bonding master carrier down in this situation.
> 
> Patch 4 addresses the core issue when lacp_strict is set to strict.
> It ensures that carrier is asserted only when at least 'min_links'
> slaves are in the Collecting/Distributing state.
> 
> Patch 5 fixes a side effect of the previous patch. Tightening the carrier
> logic exposes a state persistence bug: when a physical link goes down, 
> the LACP collecting/distributing flags remain set. When the link returns, 
> the interface briefly hallucinates that it is ready, bounces the carrier 
> up, and then drops it again once LACP renegotiation starts. Fix by
> resetting Collecting and Distributing state as soon as the link goes
> down.
> 
> Patch 6 adds a test for bonding lacp_strict both modes.

FTR, the more I look at this series, the more I think it should be
net-next material, but I'm also ok with Jay's judgement about the actual
target.

Still I think the sashiko's reported issue on patch 3 is real and should
be addressed.

/P


