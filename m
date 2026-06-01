Return-Path: <netdev+bounces-293622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC9qJaBLHWphYgkAu9opvQ
	(envelope-from <netdev+bounces-293622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:06:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B461C1B0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084D430BD8C0
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C51368D59;
	Mon,  1 Jun 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GD7GI+AA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tHSjnK4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E5386C37
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304389; cv=none; b=ZiUOiS75hy0pZCm2Bt6gvRaLgg42P4rV23YdKZ7cIgNDpWQWo2cjCtqF2WU/6LLaW0JmDrv9d2M5pw+qneopRa1YvSHfSYs7rl+aifgUe0oow7yYgElJYxOh6C4ujd3x6b/qDLHdd/Z+4gt8dvHKU1cLWESLV90LZAyN7WTMYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304389; c=relaxed/simple;
	bh=TVScjomRSl5LC4nYX6rpuR5ukHlnDDLqc89RHEGAHhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWKdIUv195HL39vEo4L1g3uqLb+8JLx26xdBPfFzcKTq14uAt2RblQwdWvLpm1PNHdQNIsNmmZQ+j1maidX28aDZL1DBMiKC8dT02QnED3xAHF75EPQ/F5hE4vJQQGw2BxwBusBgkT4jHR10dR5BBqmIhF1MDQ9OI84sl+d1RrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GD7GI+AA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tHSjnK4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780304387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh3UalaMjz0IAlXO6aVjAsVqA/VpmRztwPbl3KV7dus=;
	b=GD7GI+AAK6CTkJHy2wiGIHb6Ndj55thF4qjrkDknpfTpnLQmwmBs9/PKuBSDHTs8r90VGF
	wCTiBlWcRGbs96C46CmbpsL31jREF/bvrJL08TvIFK+Tw4jmJg37CQy9H+IOJ+X1ObEd2V
	5EiXrMT+J/0h0+M4om4vWhXTQ3iCQrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Ez_xaNZWMI2VKgu8qOXp0w-1; Mon, 01 Jun 2026 04:59:46 -0400
X-MC-Unique: Ez_xaNZWMI2VKgu8qOXp0w-1
X-Mimecast-MFC-AGG-ID: Ez_xaNZWMI2VKgu8qOXp0w_1780304385
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so8227775e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780304385; x=1780909185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dh3UalaMjz0IAlXO6aVjAsVqA/VpmRztwPbl3KV7dus=;
        b=tHSjnK4BE1Ea1rHLWmt0SOxeVJSYpyUGoEqd16swGyVcPngWzbOMKg28FZ8DKjB5FX
         jeBVoOWx+IKhouqvvZCM3EaW4n8NRw4iBhQv2JnZe1lBdtE7ALzF7IxNiVaR3U45QRHZ
         FnQQw5zU58cvjXw0IMXVieO3sWdLaxPJWhzm+nd5O4swSHOZkTHS0a3u1kLvixz2096S
         jxuYjPcUN/v1MjQIxZ+p0BaPgA/42nVWdU7OiW6jjw8OvAcOHnB0fiWCbzwrumuO1WeF
         1ZHLEzbRryFfDSpXLqVG1Lia49WXOeSWI6+fMeFqQ0X3w+oBbbky0hJnxUCIJusHRGto
         /K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780304385; x=1780909185;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh3UalaMjz0IAlXO6aVjAsVqA/VpmRztwPbl3KV7dus=;
        b=CphPipipjPGvyVvbw2OrViU6NtH3EGZvsRYiQ/fkJtDO7LwRO4NGQ8arSEqUgV4dKt
         FndKZskmXB4Gdsxq+ytc29oUjJq3lp8lFBBcCPg/3xgaQmsQDzBS3ReQKSaAQ66yIGRy
         ImVJLDm5eENMQ1Xj/TQHRBWi20jELTh1yeKPLuuWVQLwWHgDfK+Wafpu5CaDnKwJe5dp
         nJuKSgbdu9njKEJz9uYeQ9w4ly/oiKWXlQ2NRFhJU2Sr6EElLntstapT5onPiU+a9R8a
         YywjlmbBSrPgvjkB8hqoFtymlO4flg/v95QPzM4iYSTHgiykGL7Ysy75IOBtyF7f8hca
         PMmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Qi6EQQuMlnJwWi3F2bUh1t/KMPEv1UOwy3Zx2n3DoaCO0lQrH1NvfCz0f3jSPsEXVKge34c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnKotePkLs5fSkkmR/8Dw6AzCnIcXnSSd8Zj2qra2/L8a4bUH
	sGf4ovVfxKzeu1sgt9CtZ6wTamNxuWnMrPM3itjSQxDg3mVsb0PKqH+I/Emc2ucGnVvZ+4xa9eB
	d15wZyiBYvalk46o7jSixMTmBXhD+eXGediwNvb0TTeVIQdOjVfuMv0x03w==
X-Gm-Gg: Acq92OEa1NdZtm27bKBd54T8y0qmRy/5pWTpsK3alyr4rRr6FxfMVJY/mwMHkY1eiCr
	s+Jga/Hhw5VxVYhvMujQl7P0WXXJwO7jsSqQmi94JN5oG0Ewgo+r+AriP9xjEZLqrieeJdtRCW+
	TdAma9kxg5PL/z0RZSpbAa3Yej2zJhpn0Dni7hdurmAyxwnza/FUTSETnIsdKOiIpX3P5Mn6ga1
	y4LQ7o3tUUvz3DHhgv4j0luG2uBKWqoQrISQ6H3nQCGKFt4F4NiAwxPcBgHfp0OjDF8cAlALDWJ
	AUJBSTaTEku6sbgrl+N+rxK7e2zvhnEN+QdBJCHdWiWMX2kRSpjHymnJDxxkPzraIx08s0nCh6/
	UyGYlIFSZAPJeNTKbvAX7KxvUI+HCnkjNZCiepMvRcq9RwL7iHnoywYWUctPx1WdeipTU
X-Received: by 2002:a05:600c:6214:b0:490:44eb:c1d7 with SMTP id 5b1f17b1804b1-490a297e571mr227396185e9.30.1780304384937;
        Mon, 01 Jun 2026 01:59:44 -0700 (PDT)
X-Received: by 2002:a05:600c:6214:b0:490:44eb:c1d7 with SMTP id 5b1f17b1804b1-490a297e571mr227395355e9.30.1780304384483;
        Mon, 01 Jun 2026 01:59:44 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm252667425e9.7.2026.06.01.01.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:59:43 -0700 (PDT)
Message-ID: <d50bb4c0-285d-4e77-b534-2891c9df3cd3@redhat.com>
Date: Mon, 1 Jun 2026 10:59:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] net: dsa: microchip: implement
 .{get/set}_wol only if needed
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-6-5b63e732149a@bootlin.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526-clean-ksz-3rd-v1-6-5b63e732149a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293622-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 156B461C1B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
> @@ -3798,9 +3795,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
>  	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
>  		return -EINVAL;
>  
> -	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
> -		return -EOPNOTSUPP;

Sashiko noted there is still a ksz_is_ksz87xx(dev) check in
ksz_wol_pre_shutdown() which would probably keep WoL broken for the
newly enabled switches.

/P


