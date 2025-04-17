Return-Path: <netdev+bounces-183689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74790A918AC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B48E7A53E2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4222A1D5;
	Thu, 17 Apr 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEG3rHhj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1422576A
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884231; cv=none; b=USdcSCox4axecMqByDjc5U7GxmXIc6dTa5SG3qMOMJNSHNT+zoTmmhe+3u/EKMWeEZ0B8K5D3umgjFDrifqp7ISs+3LK2PebSk6D4HKwKfboW+ndksmeucUEjOI3twO9gvax6OWg8OtAjFFkulmwfJXT0UEzpoYN7ZpKYnEs9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884231; c=relaxed/simple;
	bh=EqCOTsE+QB5UW/VOIVbAS0MuBQ504cjzCxczF0GFvzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REjREiOcMr+BWfKhFd9s2kJBZqPMSlM2PqIR+GtTVVNWitWHHwydVGYL8wEEFUtpi3aBQ4Fg8qHlE5S2tRjwnK+IDk8gONzaTCrwG6H5n1g5bJQT672Vgm8oSSbGxegNcZPm9SOP3m4wt+r39xK/GzKBpykc3Z5JMQ6ih8lAqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEG3rHhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744884228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eca6nYlnj6Q/YeQ89T3yXHQz/N/LC2yMQtBQUQX05wA=;
	b=PEG3rHhjtnbyw3bqhLENLBaZL4jeC+rkLkjDN402R7lnOP6ZqU8SFGM4M8S91myKrR6LZv
	1OBMW0Er8ELhq2nKlpnmWGdqsxgr9LLmhOEKYgNFdolRdFgMOtAqWwq3qKh+jD4qHRV2vZ
	xdqyfAjQV1pEFC461R7cWxLRez6eUsw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-gkd0aY-4OuO_QBG_gt1PJA-1; Thu, 17 Apr 2025 06:03:46 -0400
X-MC-Unique: gkd0aY-4OuO_QBG_gt1PJA-1
X-Mimecast-MFC-AGG-ID: gkd0aY-4OuO_QBG_gt1PJA_1744884226
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912b54611dso315391f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884225; x=1745489025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eca6nYlnj6Q/YeQ89T3yXHQz/N/LC2yMQtBQUQX05wA=;
        b=MrZ4aYic4fCIbHEQ7Xsfj1oOdYRCgi7ehU1IpAmhwJ0Y3+qJnwLQVxIelvINSYTn6c
         4eu+P5xF+uz/p7NhW/44krTjokrgY1FYOo7JAFTxijE2VP9k7ggyme06xdezWvCKSAqH
         8bERsWo+nqa/rqwsi4frCNThVJmiGMoxM6qJpaPikyQ/nAnMoHdWxoO+knH6FzyvqaoT
         3Hd/gajSSYbxZ3O9IndcInB+uf88Zt590UeooNINbLCggMYOxKawRZ65G0TYTOqcfmqH
         KYj4RjcnF392TZwB+5N4kwPGdxrmhcAF+ePvOX/0sqUx73EBAI2PKPO9p1BY2hs4vM9V
         jCDQ==
X-Gm-Message-State: AOJu0YxnTjri3LoDptdcg9EfWCXoMUxfc5HXXtiFpKKTErIT5GfKe8vN
	Uz9JuQ4MoZ9rhuXsp6PN8da0qi3teqYQB8Ry9GwdT6l1jQmxtbuhcm0YVDBzUx4oiFirHWJI4+q
	fZQLNfU6FSKH9cx0TLzyZ9KiTc8skwnErzc+baC7Z+RuMQchdmF0r/w==
X-Gm-Gg: ASbGnctzPH7NwHt8aBu9GcoUpGp+/TyqAoFwJJVXQL+CJ7b1I4XV/0OiOPUr0U+t+aI
	LRJvO999vkuXw9AhrpUh8iL1jdWFGKc4gpKZ3HwhKlTlCP5LoMnUeEFGuO20eut4P6hoE20du0M
	fDjtj4lfZP56KROhp7zNTYgOeWg30EqgKuhznHe6D5QSaXF+E0SQ6aKqiwWJtbt7QFePB8pfZJ3
	OaD7iJ96r18I6G6m2DkzG5B/XHSFdewmo8JQEyldaCEHdqARUNNnkPBKj9iJd/B9aqxJzekJwJf
	RnoEMhqmKaEHex529gMICSdW+G8YrbCokkUlFEnkSg==
X-Received: by 2002:a5d:5f54:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39ee5b8b7e1mr4746223f8f.40.1744884225631;
        Thu, 17 Apr 2025 03:03:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWbMd5UZNS52cZp1/RVD9DV2YcByv7qTywhU//hbfm0mgjXhAdZwTqwRIUercg2jPhhkOtQA==
X-Received: by 2002:a5d:5f54:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39ee5b8b7e1mr4746191f8f.40.1744884225284;
        Thu, 17 Apr 2025 03:03:45 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cceesm19733949f8f.73.2025.04.17.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:03:44 -0700 (PDT)
Message-ID: <564ca4ac-661e-4126-a65a-106d3c28a47e@redhat.com>
Date: Thu, 17 Apr 2025 12:03:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: ethtool: Introduce per-PHY DUMP
 operations
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
References: <20250415085155.132963-1-maxime.chevallier@bootlin.com>
 <20250415085155.132963-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415085155.132963-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 10:51 AM, Maxime Chevallier wrote:
> +static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
> +				     struct ethnl_perphy_dump_ctx *ctx,
> +				     const struct genl_info *info)
> +{
> +	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
> +		dev_hold(dev);

Minor nit: please use netdev_hold() instead.

Thanks,

Paolo


