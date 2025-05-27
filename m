Return-Path: <netdev+bounces-193571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B7AC4902
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC2D18881FE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220151FA14E;
	Tue, 27 May 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikjz3TI2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5B1C6FFE
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329360; cv=none; b=oBN65d1rIhDckjS+TApBTDQ9biqWbpWhQ3iZnEfI30URoq1fyo0tAipM+dzmHydCVtrDfR2oRDX2PTZigcDIRqnrXfWYZOBNJ2wJiFWiJS33bkeyEtOJYgMo2QkrxAfzFFnwN9RwutsaLE9MXu52KRjq/q3myAcvVuGu/Ld45ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329360; c=relaxed/simple;
	bh=uerM567QcQCVqLcNbyZwn68Uozgpe9FXmx2lyhpHDvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLW8upo6Gl3E/zoYE1BKP0xXZKXGKamjDIj72ogqxoIKWKT/WBp7xYTkj44XaYFqQdPYXQM8AclTu29g1MitCZomfXQTRDE4CXjfN0hWPT9DUJy5nNffdBgSwiDHQ2H6ec+98Vqa+Jj6kQ7ZQTErxuWYUPROMlyz6yVGGVx78xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikjz3TI2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748329357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
	b=ikjz3TI2RNF/P/IQm7jZhhyyq/ZfulKQ2wJ5drc/IDwl7zP1qZP5RdDhfUDLrv7bmy1YAO
	Ip/lLhyR8Vd38TcClkZZ5pVVxNzT5YTjNcgETdwbyAowODJs197GtAexiTnJnZGT/iSnQZ
	8jnc/bZ30tStRVRL3hscPSEqz+C6bSc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Vy37k_QVOaSo3eygzji4mQ-1; Tue, 27 May 2025 03:02:34 -0400
X-MC-Unique: Vy37k_QVOaSo3eygzji4mQ-1
X-Mimecast-MFC-AGG-ID: Vy37k_QVOaSo3eygzji4mQ_1748329354
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a371fb826cso1179124f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329353; x=1748934153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPj65lDKBn8X+w6dITxUNDiVhmFCDqyup7L8wrKjKWs=;
        b=dTEv4RB7h4sucx6bYxFFtor0oBczCYcrx89Gc7WZtl8e6tvsnhIhd6X5H+loC3Mu83
         qiL+qO5FtFZqbVbtHDORWNw1B+xEk4KtYYln/GsSV+ci9SuEiqx8BAnHrrbVMM8wLz8e
         SZxm84/05VTORyIzVDSv2H7JGE7UubvL1hHCxaI8BdexGQRrK92nOKte31XcnPlZmXCB
         CEXPi001xxwoMgNk7GZp8qtFoaL/5LxH3F2ruOVcFTvCgi2eYlakFWqb20cSEYwZi5oH
         0IljKgd9i5z9EjFqnQ8SNRTntW6nOvP7qvSEmwyWlh4NC0oz8cGgEk2wfegu2BKK/n/q
         1JBw==
X-Forwarded-Encrypted: i=1; AJvYcCWSWrNp3JJ1EQJoqk5ZTfxwFS1vQJWFjq52zYBrdJW7MKZsuMLs1OY4XSYdBhPYOvNtVgeweMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFSuHkNc5kRhLD+NKprZgGngoKr/eKWnxMDgRqSjx4tJWnIaS
	S7g53szwdKrjSENDjUyAIzd6MGL0OOr5G5J92JZwzaruZqUQlm2mpON9u46Tfcts5ZwTzT1msvX
	a9VYrt2MC9dXo9uh3oLjRqiIZfQZP3cfNXdVIo+Qbjvm4/wSe0nZolQ1Wuw==
X-Gm-Gg: ASbGncslIe6qgSgHelbacKDAAxPG1oNoSJigdpP3Z9TrYrlDLxW2Ws1Lls5C955Y+Jn
	GtgEYdsr+Lwt6nrPW39qQhOXoD8pJvKPcvk5lAOejjZHQmTRHL1+uJe49lZ0kfDM4oQKbR/UygF
	DewfAYsuGgZ+qo7yhH8w5PvftJa6B7ieTREziIQiPUharkUVrGIaxhKZHW6NPSO/OroB7it80o4
	n5MPzwkZA+kQNfbByOoddlS5Bc4dOJ0U3uwhdVKMbHDoOjgeqWKd554tzYdvBQmvSPxXYUoNCWJ
	OjSZz/Ijm5N8E9UNkSDVJk9ljG5do1vb3y5+ZdBCwpuZGii2XSoDQQkwmHc=
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608619f8f.57.1748329353537;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGex5mHhM/OYaq2gRKUAD/HxHUJY3MptMrHBU8jm/eQhY8uxpjEvS25/QUCzUXZRuezIVGAwQ==
X-Received: by 2002:a5d:5543:0:b0:3a4:cf66:efbb with SMTP id ffacd0b85a97d-3a4cf66f1f6mr7608571f8f.57.1748329353087;
        Tue, 27 May 2025 00:02:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cc52ab88sm9930473f8f.11.2025.05.27.00.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:02:32 -0700 (PDT)
Message-ID: <e1429351-3c9b-40e0-b50d-de6527d0a05b@redhat.com>
Date: Tue, 27 May 2025 09:02:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: core: Convert
 dev_set_mac_address_user() to use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Maxim Georgiev
 <glipus@gmail.com>, netdev@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lei Yang
 <leiyang@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Philipp Hahn <phahn-oss@avm.de>,
 Eric Biggers <ebiggers@google.com>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250521204310.it.500-kees@kernel.org>
 <20250521204619.2301870-8-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521204619.2301870-8-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 10:46 PM, Kees Cook wrote:
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index fff13a8b48f1..616479e71466 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -572,9 +572,11 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
>  		return dev_set_mtu(dev, ifr->ifr_mtu);
>  
>  	case SIOCSIFHWADDR:
> -		if (dev->addr_len > sizeof(struct sockaddr))
> +		if (dev->addr_len > sizeof(ifr->ifr_hwaddr))
>  			return -EINVAL;
> -		return dev_set_mac_address_user(dev, &ifr->ifr_hwaddr, NULL);
> +		return dev_set_mac_address_user(dev,
> +						(struct sockaddr_storage *)&ifr->ifr_hwaddr,
> +						NULL);

Side note for a possible follow-up: the above pattern is repeated a
couple of times: IMHO consolidating it into an helper would be nice.
Also such helper could/should explicitly convert ifr->ifr_hwaddr to
sockaddr_storage and avoid the cast.

/P


