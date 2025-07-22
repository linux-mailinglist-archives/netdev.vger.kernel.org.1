Return-Path: <netdev+bounces-208992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B337B0DF81
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277A13AD316
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750828A730;
	Tue, 22 Jul 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbMYhK+Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2066450FE
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195654; cv=none; b=IsipS968xlvzJ42C1dCi93DpD6bCN97XCyXFcn2j6KoNRIdCbEvNHWj2iX9lc0qFah9xBJNlL5+a2bMNGgphuHHijeh5HDlFP8fWh/DVzj+rMiDtidAq+R6HFigc9qCqqowB5vAxkgHBY/o4Q+m97bdsEiTmHxg89lbLtDS1KIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195654; c=relaxed/simple;
	bh=yid3Pf8JVy5PVhiRX1APcX67usBd0s//BwR5DPx2DGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMY0GvTKcnzp6yCYSdT+uoVX+yhbOXPsndsCKY0B4gedjwGoWk+y/iLcucOq8DB+sX6zYY9gqLtQq5VbLDIoXCWRo+vLrEiSA/cK1AFdXmSSQv0qF+Q/DMYgVWLLnpXU6wHpaYcZOA0FNX4NOzZh/QLQD2HZpPHslhsjBD+kLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbMYhK+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753195651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJ8vXE+Vczyk3Kx59J7cCpTx7+wsx7aT9hfzBy8n4pk=;
	b=hbMYhK+QwS6KKM8zvqVG9ykEL3MgwQL+jzlrErwMTb2/Gj627R9kPmamGblgLtF3/UAIOj
	TM/1Eg5x1jfjPDQkr5Cd4swag4cggCybnM/b2z70sTQNn6AZIcLY0CBdBm2QuEnyeLubzO
	ub2P8wUjeQD1SRyGi9EF+SaO+FHtRzE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-CFe9JVeDOBS2bagelOO8Xw-1; Tue, 22 Jul 2025 10:47:30 -0400
X-MC-Unique: CFe9JVeDOBS2bagelOO8Xw-1
X-Mimecast-MFC-AGG-ID: CFe9JVeDOBS2bagelOO8Xw_1753195649
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3633155f8f.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195648; x=1753800448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ8vXE+Vczyk3Kx59J7cCpTx7+wsx7aT9hfzBy8n4pk=;
        b=jjSpAzbJ4xezXBDlJtnQ2wQFJZHuzc61Zs/iTLB1u+Oq+d/8w9ZrfJrJsl2lKIxz1R
         Fjz0+4cww3+QAARxPDlXXwP+k2YC1MNYq5Ktwmp8oJTVY/tVmOYR9wkp9mS9xD4V8iPf
         QtkFLHosDF/P9hN0mnEEtpcHyJ13RlBcI5gam1okbxu9MGqFhEGm2ZEgw9kFEJJfG8IY
         qQHsadMphNd2WLxMn5Q22LfNEeMs1B3QcdjoNOdlXe1P67/0tgKIbb3XxBFgpaAkD9VN
         dJE7tTSJ3gSu5ycN1K2crD3y1UKXxjf3JdDPLKGkvq9iuTjtT+B0vCfSoyavjA5WByd5
         kCHQ==
X-Gm-Message-State: AOJu0YyGMFxA/0PRiCTfRrtyozpMoUx4efjCLJ5IoLLcCz7e9JmP152Q
	GUIjGSW6G3zOVdH8gRkfoJX0t6iYUKiQh81jiSKxD1HuC8TgTTLC5S1iEEcAVXn1ORary/HEswR
	VItUCHwnRyqqJA5M7fNmDFlJBDhjzLeayRJtd/N43X+SA+EsRA7qSYvdhpBNYlKaAiA==
X-Gm-Gg: ASbGncvd5sJ19IiSHBNGVIrBHjaL8bcH/WuhsgQPpFb7yaa/F3DVTtJl/6wO/OHMJYN
	sgv9zOoEDJapuRyvQYaXw7Vhj6ofcUYtKQWyknBWSaZSmmdVPt2gnrD7mRKpSS4paukAux9Qjlt
	Z68hcvQV48MIcaSmegCTzOtzAvckr9ql3ULMsx4S5Lk58fajSI7s34g30mCG9Eq8I/67aepV1uX
	SyZYWdIEsqnyCfrjSRiLevGTNZfz4OW9voHNdI0gO36XF+BAJj1oIGAKB0GFycW0oaYISYNdOEG
	hkB7Eo6T9TY4l3G5IAb8eymnEA66woq9WmBYRVCtMi8wtRd5IKQ9MxQtZAoJBc8Sdl508Rb7Oro
	NFwye3AeTOE4=
X-Received: by 2002:adf:9d83:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b60dd8d273mr17104755f8f.59.1753195648525;
        Tue, 22 Jul 2025 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8epZG9iPVbWXB6bK+gM/AgDezTa6OD5QuPw/xFJsVYHane6m8Wt3ZuB+vNEcUojz/bvJE8A==
X-Received: by 2002:adf:9d83:0:b0:3a4:f7af:db9c with SMTP id ffacd0b85a97d-3b60dd8d273mr17104731f8f.59.1753195648084;
        Tue, 22 Jul 2025 07:47:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c8dfsm13644741f8f.82.2025.07.22.07.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 07:47:27 -0700 (PDT)
Message-ID: <d1bc6357-9bdd-444e-86f8-9e6955f46624@redhat.com>
Date: Tue, 22 Jul 2025 16:47:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
 <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/25 4:04 PM, Eric Dumazet wrote:
> On Wed, Jul 16, 2025 at 1:14 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> Only handles packets where the pppoe header length field matches the exact
>> packet length. Significantly improves rx throughput.
>>
>> When running NAT traffic through a MediaTek MT7621 devices from a host
>> behind PPPoE to a host directly connected via ethernet, the TCP throughput
>> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
>> using fraglist GRO.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
> 
> Shouldn't we first add GSO support ?

I *think* the current __skb_gso_segment() should be able to segment a
pppoe GSO packet, as the pppoe header is static/constant, skb->mac_len
will include both eth/pppoe and skb->protocol should be the actual L3.

/P


