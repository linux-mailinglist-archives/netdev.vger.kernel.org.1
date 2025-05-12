Return-Path: <netdev+bounces-189652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B9AB3109
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FCC3B582C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F612566C4;
	Mon, 12 May 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu4NtSxG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E92550D0
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037152; cv=none; b=puz9YhKZJlCmfxQWOst9QdxLkxifBHyBjWgC3NNQ4YB5f9xcwh8/gzLQktUYEqAqGaDM6/u2yBsY63HzE/N0aoQz2e9DO2Xy+kHSi7CVpKvKnmTv9T0AEM24sPNKxvb00j0iaIybr0onWl+FNWM3bbp4VyKBMmGKdGj97D+Lv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037152; c=relaxed/simple;
	bh=1I7uICROjsJFl0KU9pggoeCNVHE1ncpwxqeo1xe8Pu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/GCFPJd12ti2U44p7S6BYp7KyyOB70AVAxyA/vE3Ljpa1rg80SCsxR9WnstCbVoe+dIHHJi+slWfUoYS3FhS9xpc+OlCxybVukoFgvQko3BbPwM6BYxrvKVq6IL9fgysgvZuNgOtAsrlACrCC/pBPSpAazAvFuLkGLnMCuZFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu4NtSxG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426159273fso622862b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747037150; x=1747641950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amKaGNk3wHqQigBny6NC10HW67wNH+Hm/pqfcllEXko=;
        b=Hu4NtSxGOJxmliqGnlEkF6yzEUYl/q1aaxzGiLuqKz2eYM6qLk/YIY3rjLBKAmyxFu
         jJuQ/73n3GOAUmsI8C0hJVOnlEo8iQ2TYd6JLeMFWXx1FAyPW10KWF3VlwZLiqLdA6H2
         rMHPmz6BmpbUVB1cUQPabjtoNKPTQmFZ6WrV2MYErC5IURMO/hhGL71OonmFzKsw+Tdu
         Yavk2bCnwRpVPO4JFOY/zoo8+nEjhZst7iJE0OZrbotHiGcniqGE76kwjGyJ/ymRmquk
         zsbi7Guy55E6U9jV+Aq07fqKrbJF2xhaRCqSmtjbM6d5Zzbb1QYw8YicDJBuBdDLQ/x+
         gIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747037150; x=1747641950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amKaGNk3wHqQigBny6NC10HW67wNH+Hm/pqfcllEXko=;
        b=J4mrydD+PNWEd4FExP+c+mJwHeAhgBfZ061OlPp9gSz9Jql4hwrm/MFOHLYPXSW+vC
         s9rH2LLJDyO5fe6xScGTXBfPdp2A+s3wTUg/5pU8wrE4MDPLYw/w2H/KNYIWJiiV83An
         ykHZZTCzjUAgsdrH5QH4zm7jP0Nlm2dADWFKHs291OFy1yygdg+L5U1Tagb1sccHHBJ6
         94lcHOwWOFOqOWUvJMarPP9s9Wl7zakotiRtfAbgll0nF8inepXszeHJNVXaT146rfZn
         DJMrr1Dm4/u2kVTpWmrgHr/YRxHcoiZyFyvpGfDA9ifTOeRWfaNS03HA6MAGTYgIA+cS
         OXaQ==
X-Gm-Message-State: AOJu0YzTePBTTMRWGBp/mT9nYxEhfXR7JIvkib17l5x0+Kvo/o9O27yG
	LJgoXEhIArAqMgmY0XGh2Q+KRgxJ86RAREDv4RvvK7TazWyUeDp1
X-Gm-Gg: ASbGncsFsyu+4XJXNLinZeDo1+TlgMzcrGVdNV1y2745txMqZcKgKKb0Xd8OzpjWti3
	WgAHzCCodD5AhVyYC7uOj3u3qR42S/b99yVOWtzcAHqccuVMYQaK/WisDwhGU3qxO//S/2M+yix
	WMSQBF0bu7zXbj5QGgaQ8IvabpYsjYUkGoDRdv5EaGGAn1FG5dz2iivmBzf6X1dJOD2TbDGzCMj
	CKohYHS9jDqOn6UCwRArGrMkGLbIuIgZZ/usgUfFMeYZ9mcMsCPP+zd+M2xKPyY+7DXIJKCWReW
	8uaY7FfR6RYDWRi0y6RQItdfCIl6K/ealvrNfqQ7mqFDFvIe0EWjPCZs
X-Google-Smtp-Source: AGHT+IGlqHs1u9wozQ0dCrQEbNateGqCgJxeLZdKIVd+2nBe7NUpe4irWxUQojgsyNen518pzyIndw==
X-Received: by 2002:a05:6a00:a0f:b0:730:9502:d564 with SMTP id d2e1a72fcca58-7423bfe5164mr15031811b3a.14.1747037149949;
        Mon, 12 May 2025 01:05:49 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b23493257eesm5110290a12.16.2025.05.12.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:05:49 -0700 (PDT)
Date: Mon, 12 May 2025 08:05:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: tonghao@bamaicloud.com
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 3/4] net: bonding: send peer notify when failure
 recovery
Message-ID: <aCGr1hLEUng-b-UD@fedora>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-4-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510044504.52618-4-tonghao@bamaicloud.com>

Hi Tonghao,
On Sat, May 10, 2025 at 12:45:03PM +0800, tonghao@bamaicloud.com wrote:
> From: Tonghao Zhang <tonghao@bamaicloud.com>
> 
> While hardware failures in NICs, optical transceivers, or switches
> are unavoidable, rapid system recovery can be achieved post-restoration.
> For example, triggering immediate ARP/ND packet transmission upon
> LACP failure recovery enables the system to swiftly resume normal
> operations, thereby minimizing service downtime.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
>  drivers/net/bonding/bond_3ad.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..6577ce54d115 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -982,6 +982,19 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
>  	return 0;
>  }
>  
> +static void ad_peer_notif_send(struct port *port)
> +{
> +	if (!port->aggregator->is_active)
> +		return;
> +
> +	struct bonding *bond = port->slave->bond;
> +	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
> +		bond->send_peer_notif = bond->params.num_peer_notif *
> +			max(1, bond->params.peer_notif_delay);
> +		rtnl_unlock();
> +	}
> +}
> +
>  /**
>   * ad_mux_machine - handle a port's mux state machine
>   * @port: the port we're looking at
> @@ -1164,6 +1177,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
>  			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
>  			port->actor_oper_port_state |= LACP_STATE_DISTRIBUTING;
>  			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
> +			ad_peer_notif_send(port);
>  			ad_enable_collecting_distributing(port,
>  							  update_slave_arr);
>  			port->ntt = true;

Maybe enable notify after collecting/distributing?

And also please rebase to latest net-next. There is another switch case
AD_MUX_DISTRIBUTING that enables collecting/distributing, which should
also send notify.

Thanks
Hangbin

