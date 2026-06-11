Return-Path: <netdev+bounces-298334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gixeKbwZK2qx2gMAu9opvQ
	(envelope-from <netdev+bounces-298334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E346751DB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:25:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j+KPXMHj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298334-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422B032D8FEB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A383A873A;
	Thu, 11 Jun 2026 20:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE663A6EE5
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:24:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209497; cv=none; b=BH10SA1bmMjv3sDJrvoNmyrhcm8uDhCHi9SfG1fG7PUXU6tQyi7gB/8XqO+AEkF0to7uFZccdBMqY+k4Kq8ZXcOab7Ri1/YGJwqOZ1CXWQ2kjKYx0JaXTDKgD8wN195mxMktlnkqubJSpxOfdXTiR5NVsrOdN4uZILdVdDe76Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209497; c=relaxed/simple;
	bh=9hHbKRPUeKEmQ2HcDrC6HGkij2GsBMBs91PfKigEEtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zvgfxe6JyKRhJ9/o4AHOb2IMAM3vVpTaH//zFf2nerGiGOtQq+nB4YtstHs6Q+srXh2yfL505as2QBzCdJmTvqNuwBGL776gmVQlVtValo1vldxYG9ZFvYTH5kQJ6bEnI35PaC91vlXP5nuq9UdHKAOkpKPM42z8I8BpNMiP5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+KPXMHj; arc=none smtp.client-ip=209.85.215.195
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c858961a8efso99764a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209489; x=1781814289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSAVl8SvXQVdkcAQ0RBUEV0NrySTQO4ibOhD9gpdyE4=;
        b=j+KPXMHjUgWxZ46Qob7UJsKDod3QpWJR01ICVu7et0bwgb/c+KiYPOY4lzpOyIiuPL
         Fbn+A5b/11HJ766O8de4TKi2khSk3/T8bvPiMmJsI2D62JfjW1ydZCLGO4UQxJHVK8/7
         QEfGxIDHbRIHa40Rb+g3YcOOsTGH3i8yLEW7Fx5nN02xAqXkdKBbfBiPAZMf8PulwANk
         bolcDXsfyaSk2hMIp1HH8uDDwIRiOZTGxrqwilowaIj1Ow2XyYEACoXbw1ST+cGkEPm5
         82AL5NqNzc23tOLYbLvo6HqBwhY7wBVsJjUsejlRDbPzbo+PotErxhxKVjdK1iB8Cmrh
         GKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209489; x=1781814289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSAVl8SvXQVdkcAQ0RBUEV0NrySTQO4ibOhD9gpdyE4=;
        b=DmxRYW6Mg3gsn7Td4hj6q7ZirEuPW0+uCYm6Eew7nBAtooZfocy2/7isoN1oXrmwqH
         JA1CzV0rshGdPVxhumeOQol2cxJ+SoLmVHpq+6yPHvJ9+yfsZ3U04pNBguHad1knTT7c
         x7hcr/7Hj9Ga5PdtoOJd3DpY1gwZZ8Nw9R8aYX6FnNjQLdMrxUN9BWE8wdhCS+KbfzYD
         xLHtb8rYnG7luMS4zFp6QJOCBr1zTxv3GjZoOJo4CtU4RK8HAP6LLUwBcV7sr7z5IMEl
         krb0klyVPoqyqSlDya9KO1gQ1PARLJqgKchxXZEjjJ6a6pMUaZYW6AEMp3BiCOJsb51q
         jbpw==
X-Forwarded-Encrypted: i=1; AFNElJ9DPCct5YgHCjmPTrZbmXohpquSvvtsuaoqgDhAhrFhbUgOXpMIUjW7Xhrdf5z3NAdXpA9nOss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01UUDSAsbK7tKzYqbhIaSVe3Y87jmOXfyTi9ofTeQrdbtDdfM
	08H8Vo6NHpJoBRmH0sU6uAacVqA/TOakHCXk5ub0MNpWXE/HXPVGyUlyEORotNEq
X-Gm-Gg: Acq92OEjuoyg916X+hAy1J1togJAudMe3CiDamIvDQn6nuzUVosFEmNepwuKZNlCB58
	0UpJrhD5hLjcYtkSTnNbXGt6Eo1epauWFIxB9DF/aMqzU0Ay7C54BW5tGtjm3DZdOpqCz/6qrlY
	Mp2GPFZplRo4HcbyPQLILy4RuErgxkOnt1AvQA4rRgJ7UYM8HHo6M7CwGpd2IozmwasPzriqszq
	Y3LpUWDL8kaC7VcxIupEyD3roZ9WEZ7LxeFSq/km6FV967dhYpi6v/ss5os6OlqnFwBWSKUGkxb
	/EJyIUGlp9TDKks316+sB9QLj1eTzYdlpK/g3yMYpibg/9c0IHNxW1L/WyO6UnZlbrqPfithHEP
	wesXNEfhP61beccD04hMx/OCg7j/Bhs+8vM0zQvMjNdfZrhhV2KKlCZd8m1hTvhcjOht0Gg6wWe
	RfhhmMeElC/ntLn+4EvLdtaStc2YQ=
X-Received: by 2002:a05:6a00:420c:b0:837:80a:5abe with SMTP id d2e1a72fcca58-84337096252mr4757483b3a.37.1781209488646;
        Thu, 11 Jun 2026 13:24:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bce087sm2863653b3a.22.2026.06.11.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:24:47 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:24:38 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch, 
	gal@nvidia.com, jacob.e.keller@intel.com, sdf@fomichev.me, 
	kory.maincent@bootlin.com
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <aisZfavnmObJGal6@devvm7509.cco0.facebook.com>
References: <20260611200355.2020663-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298334-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:kory.maincent@bootlin.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E346751DB

On 06/11, Jakub Kicinski wrote:
> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
> 
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.
> 
> The mlx5 features update is related to the "compressed CQE" format
> which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
> Disable rxhash when CQE compress is enabled").
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

