Return-Path: <netdev+bounces-82008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32AE88C104
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2126D1C355F7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416A481A5;
	Tue, 26 Mar 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Z5w4GuV1"
X-Original-To: netdev@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317B4E1CC
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453407; cv=none; b=rqA5wHfCOyebeRN9Hh7yZCx/AvGosisBMM6c8SLe4xv05kxmS36VyDxjmKFF7DjmMLtdLaXJdh7g0MD20fjmt79+/wsPrUN01xhJgFRmW2BN3sxBmRCZ9it4GEC9Js44gtQPuZiN91ghv7nvoMedNvBM+3fgsEfsUxvN1sz4ndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453407; c=relaxed/simple;
	bh=O3/uGb91PFbdzFCMy5zfjku5UN+X8xYy7iiLrmCyeDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMEb/6HgdJFl7BVDVDHNjT2lMRxbYIdCWbNpgfkFxGAk8DMn2v4dg1DuKBLCRrE0I776jjeS0grShx2k9cmg91LokhjjuF0bXy+cHYCPwxkYLzOMpOs5blX8YG5Xm2YtrBz/pXFgsM3eEF5yoeeZVh/dYbWRE64CChoNCHQVAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Z5w4GuV1; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vAE7TzatyoGbv1GLQ9UEI4z1EcUU+8Ks0r7zjwSdCKM=; b=Z5w4GuV12elzh54zAB6zboCcly
	5aiHWHu1AQ/mNrdjN3V9/WSs1/XpxPlTZIyGWNBh1VWRbvQr0oQGlEYThWm3XQoGujvQZ9UqGPg/J
	i1KZ18IHT36/Io1OpaRGRA1WgCnoNPMPVosLgQz8KvcscYM53mNi2SEjVVLE6FNihuWw2wyZC//va
	JayCpsaLgKn4EFkubKxSutzXpLa1KhN95n0D/EnXpVi8bH5gYNgyDXAOThy6y+nCndUUb8zAyqlhl
	nJda/mBY41mGwKX66GS1Jzx4Sdb3Rr8nLGa/qKHG6QyalodLuddzqzJ6vLS85O3yK1OxBT+T2DOgu
	b/5i/Efw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rp5D4-000BSK-Pm; Tue, 26 Mar 2024 12:43:18 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rp5D4-000MjT-1B;
	Tue, 26 Mar 2024 12:43:18 +0100
From: Esben Haabendal <esben@geanix.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Sergey
 Ryazanov <ryazanov.s.a@gmail.com>,  Paolo Abeni <pabeni@redhat.com>,  Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
In-Reply-To: <20240304150914.11444-4-antonio@openvpn.net> (Antonio Quartulli's
	message of "Mon, 4 Mar 2024 16:08:54 +0100")
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-4-antonio@openvpn.net>
Date: Tue, 26 Mar 2024 12:43:18 +0100
Message-ID: <87ttktcj6x.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27226/Tue Mar 26 09:37:28 2024)

Antonio Quartulli <antonio@openvpn.net> writes:

> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 25964eb89aac..3769f99cfe6f 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -101,12 +104,23 @@ static int __init ovpn_init(void)
>  		return err;
>  	}
>  
> +	err = ovpn_nl_register();
> +	if (err) {
> +		pr_err("ovpn: can't register netlink family: %d\n", err);
> +		goto unreg_netdev;
> +	}
> +
>  	return 0;
> +
> +unreg_netdev:
> +	unregister_netdevice_notifier(&ovpn_netdev_notifier);
> +	return err;
>  }
>  
>  static __exit void ovpn_cleanup(void)
>  {
>  	unregister_netdevice_notifier(&ovpn_netdev_notifier);
> +	ovpn_nl_unregister();

Any good reason for not using reverse order from ovpn_init() here?

>  }

/Esben

