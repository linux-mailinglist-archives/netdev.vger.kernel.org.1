Return-Path: <netdev+bounces-261333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LwnOy1BoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:48:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D591A5E00
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B6C3033522
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0798A2D780A;
	Thu, 26 Feb 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwYEF+gL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CD2C1593
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110119; cv=none; b=rp7AQRhenZlrkNpP6rTrrRB+ZuJVfvKHR8kAAonh24gIZGITGVVwwc/h4y+Ows4I05nqyxTdXXOxulpKRwqQQ3XamOOagDmq5lSqXDUj/JO5MKkjziuHH6F9jqHUoyhW7njtFv9CzpJzbXXq1x/doIyCpe6ZhIHVSamkVrjQxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110119; c=relaxed/simple;
	bh=xCXfprn4FrQzYyIjCT8vcqONZ5mA7SGSBmwwJXyM9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntgsrEXRNHIJhUBMJPLlf2F1SPzyn0fFU4Vst1niegxgaEn1BQeaVT1G+LK9jGipbXn/PbfAHYs4NG6t8UGNO84sNTpDDZFEi6g+qEDMUZJ0GGDb7OfVwtmlUTELQH9+fOG0/PdsFFwJsoyQoJSMSfhEvBj+GEtPHr0jQAfiI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwYEF+gL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8273eb7798eso260023b3a.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110118; x=1772714918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGhBIs3dYbcFk6P/XqQpMpVB1hZMUHNjX+2F9A4bd2I=;
        b=CwYEF+gL+c7kcyi9ZW6TMTWIs3Ll10GMIbktp/QgaHbifLcRmg3aTijqPjYvMSZYcO
         1JAhRoqvXFS1eD3SAdvZo/pv+UytIMjIMirs4t0UpF5IS89VqxlqW/hiZyWtcC/4TYnQ
         xJiM8jR47adJU/6yq0o7T9cy3pcsrvmtkTWPc/ESXUuO5uXd2SJmDLIqpTxYG5yZbW6F
         LbVn8W5ayZSKX1SHytdI+8H/Owde6kbA9nwu6A/kepaen2qoI6BqcRqnDeToCaBG4NgV
         1H0iJD5O0k2JP0UDXPsI2nuj/3ceArhKzBBZFXdRPDF7PIXc1JEnXG+j7vFhl0fKSMio
         qR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110118; x=1772714918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGhBIs3dYbcFk6P/XqQpMpVB1hZMUHNjX+2F9A4bd2I=;
        b=o/4ZMrdEHK5W66YrgKU3xdGhpoGoyJFHPh/qmN5fDYI5BqiY0WCRSxsvi2i4hAu9B3
         yoOpfO7z+qCgmUXBXa5CuPxcFKy6u7P9hYlKIF6TuHY66bzgQ4TSn9L1OoO3RuGQhlf9
         aSPZKxg7BXFg4ZUwYEb34PJRjhB5FcpCzTxw8sx9r0isJmNeKtMv/DMXT88TqEj5XjOk
         PwZwCnlha+RpNeXCbTwBtvTG00ifTeoP0Kc68hxjg1cb0ZzufiBNI9ZUhu9wSFea26nb
         PH5hALoFsdAvOHk97qY6LMq33hvAMxTUpl6DsBTmnyUqvWF+5MjDuAZRLEUnXi+lCcAw
         F7dg==
X-Gm-Message-State: AOJu0YxLTGKrkol3cFTcB5dDAH3AxRDgwifRTIBAxkqArKYbv05z/5HP
	kHeZR33hqmkdbnU36Ak/mgrLbEjGGaFVmBit27aqTeebUbBmp2rmFJOGdcmWV79TuXc=
X-Gm-Gg: ATEYQzzhwjCHzJQeTXwyUvoa2HcjZGZtSYN3fMhVFvIiqrXOGOSrT3AmQbAcrg+BdOg
	Tc9ti+ZYmF4xpnCaRQleL3LWe7KHXoyMHnrM8QsS7BactrDh889vwwkAujlxJIXCQlIIlMB6r9/
	2ST/buhHBhBftK2DPXYL4j75LSnQ3xWpbR/NRBRE6WOWoBTjfOv7FWg/6priR2VHwYTBwUjQ8Kz
	rPZ21hdgLxPoz/O5dPb8j7FG9ScuHDSiMeYpMgzZ5UTglUYwTHsphWKfSq7c9/KNc8y2xss27y7
	xYybzkT3QzspZNfC4tV7uw1m5/k4XknM7LXGqyJ9S7SJfd52EX4V8t895y7TEXvkuZSsKd148ZJ
	ZIsK6V6k05j9pC11pdgawTQzfbiMHF76RlhEWZzxYCxdtmwgCvvttSrsqJt74rZuzJbUFSWl7OP
	hwx4IJCRwm/SlgqQaXZLkb8/AYQ6E=
X-Received: by 2002:a05:6a21:648a:b0:358:dc7d:a2d1 with SMTP id adf61e73a8af0-395ad1ad5eamr4023452637.42.1772110118054;
        Thu, 26 Feb 2026 04:48:38 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa801954sm2040737a12.22.2026.02.26.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:48:37 -0800 (PST)
Date: Thu, 26 Feb 2026 12:48:27 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC PATCH net-next 3/3] failover: use .ndo_update_offloads for
 failover
Message-ID: <aaBBG5iu76-u7ePb@fedora>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
 <20260226114208.27774-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226114208.27774-4-liuhangbin@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261333-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59D591A5E00
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:42:08AM +0000, Hangbin Liu wrote:
> diff --git a/include/net/net_failover.h b/include/net/net_failover.h
> index b12a1c469d1c..f0f038d113a0 100644
> --- a/include/net/net_failover.h
> +++ b/include/net/net_failover.h
> @@ -30,11 +30,4 @@ struct net_failover_info {
>  struct failover *net_failover_create(struct net_device *standby_dev);
>  void net_failover_destroy(struct failover *failover);
>  
> -#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
> -				 NETIF_F_HIGHDMA | NETIF_F_LRO)
> -

Oh, forgot to fix this. Maybe we can use MASTER_UPPER_DEV_VLAN_FEATURES to
replace it?

drivers/net/net_failover.c: In function ‘net_failover_create’:
drivers/net/net_failover.c:687:37: error: ‘FAILOVER_VLAN_FEATURES’ undeclared (first use in this function)
  687 |         failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
      |                                     ^~~~~~~~~~~~~~~~~~~~~~


Thanks
Hangbin

> -#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
> -
>  #endif /* _NET_FAILOVER_H */
> -- 
> 2.50.1
> 

