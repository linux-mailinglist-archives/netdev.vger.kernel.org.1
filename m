Return-Path: <netdev+bounces-64968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE88C8388E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6088E1F24813
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224A56752;
	Tue, 23 Jan 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uttayg3S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAA58AA7
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998446; cv=none; b=Z90zwgUTsCjo+bUjC8GbPJWeFX+6JgZSFktdmgXXCPoXyt6BiEfrmtsiW+tFENiFAIXREwcdXr6R/U7oBqHmEm+tYRk9u5DNHE9QjZXdQpTcY0pGWUkl5ZesvipS06Y0Gz2JbbEdhpuvJj2za2McHb9MGwWsW8mX3zsTbz3v9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998446; c=relaxed/simple;
	bh=hi46z/y++lYLf5XUo+FHPsGxvUTw4GFFCab8NCMerOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okqlwavk9JoXd9EOp6je2uqGypTNGBrl6HR34lTSL5g7t/y7SemmTHrvw7DrFbKoQL0Bc0i37NfehcCNaxEBtbqUo/okSKG36H0FBedu8Cutm8T98Ay3GaatLqpSFDmyB74RCMGh3g23KyANNeeF2cjzTzXqUJ7mvSzIsUjAAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uttayg3S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705998443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vZkquo4bMVetSqpRmxjz3BksjJwsIQ9ON4CP8bAqCmM=;
	b=Uttayg3Siw+BTEOxdufWJmK/ulTrBcxpvdp7HwGxVk1i3CT8o99WYOYfsDjl7hEd8vHVTc
	MaMITyujxV750mrZP2ypWX7mNLnN8Z45YRZQ9SbZPO/taWm3m8dkYdaxqcFlr1UqvDw2L6
	FTOmX8pD/LQxjLieLKQEfeqt2G1NNpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-HDTsEXTxP5q-5PjkiH8fAw-1; Tue, 23 Jan 2024 03:27:21 -0500
X-MC-Unique: HDTsEXTxP5q-5PjkiH8fAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40eb6c599fbso1485555e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998440; x=1706603240;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZkquo4bMVetSqpRmxjz3BksjJwsIQ9ON4CP8bAqCmM=;
        b=rqRNL4U1N/VZ0KKmEUmI6UpZkrrvBpqXOc4Lfmgn2jUZybVr78r500oNAZ/MsjPfmb
         EG/AzvnXUeGl0yPap8i1k2Ov8hswe/2UXPLMCZqMZtbqrYmq0a6d7Pm1QEHkfGH5zTKw
         S20M3QOf0ypnU3hxeymnFQ8U84R70HR5taisFUAJed/L9NWX0atp36bLy445YVeVozaN
         /SOw1YSssKbeB8EgJ+dDhxb8JKBZvItOH58gEtSwnZKX3D96AsGJJw7XXReh5jzPs1Yp
         GE6oK2UCVSdfRo2zjwUfa16GnI02CA20gfK3kevOHYycN3WQhk6BkekvfvEuU6T/522d
         GPVA==
X-Gm-Message-State: AOJu0YwnpcZSAD/fFvsfb11koN0XrjRlAocV8sJEBE8auJGwPeY9sVWB
	IEOo95hzfQ+fcYuBdNtJknPhFVqFdEz2kYQ8SI/X0b02lErrsm9IZLEISRwV/gYoToHyiVU6IOi
	D+9twZz62CrBy6pns4Urx5lL+3bYNO7mogQy/tDUeJHbpTOQ1WgwRBg==
X-Received: by 2002:a5d:59a5:0:b0:339:2b19:ad2d with SMTP id p5-20020a5d59a5000000b003392b19ad2dmr7374698wrr.7.1705998439894;
        Tue, 23 Jan 2024 00:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElw+cOtRGQ+c5SDkkjZhiCjJa7D/X2gkCwG/6yndfINekRmTy7bePrH71rhJAmv4edUMz23g==
X-Received: by 2002:a5d:59a5:0:b0:339:2b19:ad2d with SMTP id p5-20020a5d59a5000000b003392b19ad2dmr7374681wrr.7.1705998439589;
        Tue, 23 Jan 2024 00:27:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b003392d3dcf6dsm6568989wrt.0.2024.01.23.00.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:27:19 -0800 (PST)
Message-ID: <c029e9d7891fcaf1f635e2a76eae9a5df898f3f6.camel@redhat.com>
Subject: Re: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, shuah@kernel.org, 
	horms@kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 23 Jan 2024 09:27:17 +0100
In-Reply-To: <20240123060529.1033912-1-kuba@kernel.org>
References: <20240123060529.1033912-1-kuba@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 22:05 -0800, Jakub Kicinski wrote:
> This test is missing a whole bunch of checks for interface
> renaming and one ifup. Presumably it was only used on a system
> with renaming disabled and NetworkManager running.
>=20
> Fixes: 91f430b2c49d ("selftests: net: add a test for UDP tunnel info infr=
a")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: horms@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/netdevsim/udp_tunnel_nic.sh    | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic=
.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> index 4855ef597a15..f98435c502f6 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
> @@ -270,6 +270,7 @@ for port in 0 1; do
>  	echo 1 > $NSIM_DEV_SYS/new_port
>      fi
>      NSIM_NETDEV=3D`get_netdev_name old_netdevs`
> +    ifconfig $NSIM_NETDEV up

WoW! I initially thought the above was a typo, before noticing it's
actually consistent with the whole script :)

Do you think we should look at dropping ifconfig usage from self-tests?
I guess that in the long run most systems should not have such command
available in the default install.

In any case the patch LGTM.

Acked-by: Paolo Abeni <pabeni@redhat.com>

Cheers,

Paolo


