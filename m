Return-Path: <netdev+bounces-263231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qANWF1nwpmk/agAAu9opvQ
	(envelope-from <netdev+bounces-263231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:29:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D49111F17A9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDA73097BEC
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58018426699;
	Tue,  3 Mar 2026 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4UmdC54";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ6I30Ul"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFA423A7A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547611; cv=none; b=gOu0JjSApHgw3T9yI9DbfaYLfJES68BXRdMOP1Vmmy/jVXrhe0wU1ivx5TEmLuMEJje4SdX970CSd0VYaZHLSS/Qt/aBL3ZZYD/dvuy4wfEarGy4mvp0hMCrL+qVR0ydqa+uJ/qpDaNDwkx/1vjnfrLyyvb5MRdZtCx6R1vddYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547611; c=relaxed/simple;
	bh=PEJ6AUJ8333z6GPyIzveddG5FlyIB4BbeK84ZRWRQHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckjOdv4kAYpqfdZ3S+qNjoiSq13JlsZSFiZb/3IRsJhcyqRJGP1BeEhaL71U/5EHyMbezIYmWWIiHtxDZWEkRHQBpUICf3T51g/juehLEB1tl8vfZqkPNZovspn8TPiJjv6BDav9cxo7MYTMkLheH/MsyZiqEYTo7p9YLqmkJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4UmdC54; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ6I30Ul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772547607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
	b=E4UmdC54oAWxWiI7pTSBDHjVzYbCOiSD+Fb0tYtYHo6GcQcL+ZzaQ7AZlRZGd1yi1pZON5
	hseROwnvFA0dOMJa5l1RAFiy8osyGbdfs20QO4YY8zFgjCz+63IqChe03p87YSUZGjH0a7
	vrh2cvCSzj2UV5vM0PAf+7NxuZwtdKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-lMITXKShOLa-EErVPT9rlQ-1; Tue, 03 Mar 2026 09:20:06 -0500
X-MC-Unique: lMITXKShOLa-EErVPT9rlQ-1
X-Mimecast-MFC-AGG-ID: lMITXKShOLa-EErVPT9rlQ_1772547605
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso71205575e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772547604; x=1773152404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
        b=KJ6I30UleCBUraTjR94aB+LOPFYZ18HfWs+w93g+FXfS428n1IgM3Vn30Vyh47Oyg+
         ijaB6DM1myx4anLm0/P1KgFhsumyWzBOrd0dgnrdUPQMyPSHk+BFJFe1PoUrUZ/nu8HG
         6wNFkK2gjpeEiAN9pUPo4z61jWjK7Qpd+KTED4ye7caC9oB5+nCXCtPW6cKc4BnqWNQ7
         aXc9cZLzMLaYNTxR2oSItvKcvko5zzsLdhY4vscixxaWm3OIwecuJYjyYklEMF6ktW16
         emIw4jcUBM3Cs6c20vOFG9zWYr8YW+AYySLYhfHCaHvWAdItBq4BpWb9vULXIFZW8Wo9
         Su+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547604; x=1773152404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
        b=fJ2J7gIrG72Gu1s1RjpjHFOjuQBHOcec5WI4FHsv/zCwX8YXWUn7JQ4cQPoJSerHHR
         8xZoIRTEllq/ewrO+J4iJ1RMef1DkqirqVYPGCtm+mAA/x/9ESa2nnaCAlb2QRtsf+kH
         w9cExsPhLEwwFuyWGhL8DSGRLE+zC12ap+0JWtX9DHH5oqvrrV0GA1h5/eG85vLlJrOH
         7P6Wt6OoaE2mwGL7wu90/pBvA8B9UEzBtPhHvGUPzbM2dSmAI3Er00SBxzCkLPL1E1op
         Aqol3W461nT1SglkCrBwGra553lRuVC27KRjz5oNJKYVCFYR8h028bCZj6g5inZJ+Jot
         cu0w==
X-Forwarded-Encrypted: i=1; AJvYcCUFQeHywY6OybNEmb+/bDQ3l9kNlDjTGXCHJPW6Qk+z6GbsJHdx1uRab3mrS7XL5uppHFgiC5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcXQ82+IGb6Nna/w3rE1oL8Z8B3KowMtP1k4QA0AYP2yon0rt
	7HNO7wJkNewkcqGlsB69zYuTOlMETHZUkad3Lhwp5W/6gm49D3DS5ds02KEPxGRM0OX4JUVkTCe
	aUkHab3tnHoAKS/QyzSxPowjPA/1AU6Rt7BJdbEyTPOeqYWrOz08MBWkD1A==
X-Gm-Gg: ATEYQzxdNI9kmUYCcCayjybwZ1gH/IYmtljeB+HLXI4rv4CFN54EaGQTioqHNe+8Hb4
	8kORJZPbNTsULDx6owsVt2pT1B3531/9uWaOKi7BUZ/jZOpT7xjSujQ9y6/aV+DbTPOFRPURVHo
	QC9CZP6Jup62BDfto/K5cq3HbQZRcJiPKrIZBh4AVBFblnpue/G4nebvKHRnQ/KCnukjknH0Vr3
	zEpNGh0I9vHv8cFVLPDmymCuLG2w+7WfxbJK/bFSBsCApx6zPK90ULNwqfGcDBD5h8W7hJE/909
	1sTuYw4V4dus2WLinMGNScZQagq9GY+24yFy/tndsq29UKn5+rVa3j47qO+M8w7vY4sX33kEQcH
	+IAeMe6xvljQbzA8X84gmwFEy
X-Received: by 2002:a05:600c:8711:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-483c9b970a5mr262967575e9.7.1772547604261;
        Tue, 03 Mar 2026 06:20:04 -0800 (PST)
X-Received: by 2002:a05:600c:8711:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-483c9b970a5mr262966805e9.7.1772547603697;
        Tue, 03 Mar 2026 06:20:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm481248085e9.1.2026.03.03.06.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:20:03 -0800 (PST)
Message-ID: <7c39c1dd-dd49-4847-9238-d6cf147598da@redhat.com>
Date: Tue, 3 Mar 2026 15:20:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/12] can: ems_usb: ems_usb_read_bulk_callback():
 check the proper length of a message
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
References: <20260302152755.1700177-1-mkl@pengutronix.de>
 <20260302152755.1700177-6-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302152755.1700177-6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D49111F17A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263231-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 4:16 PM, Marc Kleine-Budde wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> When looking at the data in a USB urb, the actual_length is the size of
> the buffer passed to the driver, not the transfer_buffer_length which is
> set by the driver as the max size of the buffer.
> 
> When parsing the messages in ems_usb_read_bulk_callback() properly check
> the size both at the beginning of parsing the message to make sure it is
> big enough for the expected structure, and at the end of the message to
> make sure we don't overflow past the end of the buffer for the next
> message.
> 
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: stable@kernel.org
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://patch.msgid.link/2026022316-answering-strainer-a5db@gregkh
> Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/ems_usb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 4c219a5b139b..9b25dda7c183 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
>  		start = CPC_HEADER_SIZE;
>  
>  		while (msg_count) {
> +			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
> +				netdev_err(netdev, "format error\n");
> +				break;
> +			}
> +
>  			msg = (struct ems_cpc_msg *)&ibuf[start];
>  
>  			switch (msg->type) {
> @@ -474,7 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
>  			start += CPC_MSG_HEADER_LEN + msg->length;
>  			msg_count--;
>  
> -			if (start > urb->transfer_buffer_length) {
> +			if (start > urb->actual_length) {
>  				netdev_err(netdev, "format error\n");
>  				break;
>  			}

AI noticed the following:
---
Does the check validate enough of the message? The code checks that the
11-byte header (CPC_MSG_HEADER_LEN) fits in the buffer, but
ems_usb_rx_can_msg() and ems_usb_rx_err() both access fields in the
msg->msg union payload starting at offset 11.

For example, ems_usb_rx_can_msg() reads:
- msg->msg.can_msg.id (4 bytes at offset 11)
- msg->msg.can_msg.length (1 byte at offset 15)
- msg->msg.can_msg.msg[i] (up to 8 bytes at offset 16)

Similarly, ems_usb_rx_err() reads:
- msg->msg.can_state (1 byte at offset 11)
- msg->msg.error.cc.regs.sja1000.{ecc,txerr,rxerr} (3 bytes at offset 11+)

A malicious USB device could send a packet where actual_length equals
CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN (15 bytes total), which would pass
this check but provide zero payload bytes. The callees would then read
beyond the received buffer before reaching the second check at the end
of the loop.

Should the validation check that both the header and payload
(msg->length bytes) fit within actual_length before calling the
processing functions?
---
I guess this patch could need a follow-up? Not blocking the PR, as
AFAICS worst case this patch still improves the current situation.

/P


