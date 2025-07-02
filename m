Return-Path: <netdev+bounces-203320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C050DAF14F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06561BC6F62
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD6B26C396;
	Wed,  2 Jul 2025 12:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9826B77A;
	Wed,  2 Jul 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457949; cv=none; b=n3A8oxhdbaqaeyxQhQ4sfiumrTY8vhIbTMCuKyQe0wzsUir0jFpzus0xJmouB7xhtls2pPO/qO6COQlQtvQdRwJos4BtJRb/oBapk+dwn5JbAMxY9ETERfUsK7cpfyVrOU1A9VLJkqITgxVAkt08sJj8jc/kBpJZP+9V3JJyT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457949; c=relaxed/simple;
	bh=xow1Fjv6ss9sNC2NMRzpU0M7suQLL8EpW5X7MD7TVuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzR4rmAgZgFlDwDcqCZ1o1doG20YUCDIroT+unCB+oNvpgoD0uwtaxCrgd6963eJv9raMnwezi+tlcTmvBdPd+yaPqmQlJ0woa+368nvGs7WXTljw1x+BblToeQfQVUYqiuVdXAbrNgOK+hWsCB++pjxaDNaPYv/v4LnLKeGsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E691F61E647AC;
	Wed, 02 Jul 2025 14:05:17 +0200 (CEST)
Message-ID: <2684a01d-58e4-437d-a031-08054ec00455@molgen.mpg.de>
Date: Wed, 2 Jul 2025 14:05:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for
 ISO sockets
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Li,


Thank you for your patch.


Am 02.07.25 um 13:35 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>
> 
> User-space applications (e.g., PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.

Does PipeWire log anything? It’d be great if you could add how to 
reproduce the issue including the PipeWire version.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
> ---
>   net/bluetooth/iso.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..6927c593a1d6 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2308,6 +2308,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>   				goto drop;
>   			}
>   
> +			/* Record the timestamp to skb*/
> +			skb->skb_mstamp_ns = le32_to_cpu(hdr->ts);
> +
>   			len = __le16_to_cpu(hdr->slen);
>   		} else {
>   			struct hci_iso_data_hdr *hdr;

Kind regards,

Paul

