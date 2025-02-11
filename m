Return-Path: <netdev+bounces-165080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0BA3054B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021373A47A2
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE151EE7AA;
	Tue, 11 Feb 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UIhc03Z4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f231.google.com (mail-il1-f231.google.com [209.85.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7881EE01A
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261406; cv=none; b=UrZySWbjBm3GE7XhDRZtZmzzuOrXgzk7G2CIjRvD8YjyF1KXmgP+19VXk4C91NurioDmWv2AXdpzJYR9XkBxWVXyi4CZ99sTG0BtAwDaDODJkSyz7Z86Y+hBQvy80+tbiN7+uhsBWT6JrCyZiAHBijdRxtVICBobbtXSHuab53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261406; c=relaxed/simple;
	bh=3dRlfMGan+sGfVh6Lt0DKEdfT3ApcFxw4JVYFKt8r2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcHKqhU6Dxi89DQpIUKb80KpxbXg/jjiEJSNcwDCj/5BvGvEpHb0ggsYY5gbdt/91WBvYLHztIFiZft8Y9RtIyfCtvl/yVFmnVVCTSO7cB/nVqlbbNUU57plmlG/w+rlt/qs/l9StCvLObKv2L+1C2brhHX8dZ0RfqOzBXnSKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UIhc03Z4; arc=none smtp.client-ip=209.85.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f231.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso49767815ab.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739261403; x=1739866203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaDCkKqlT5ei2VTbS0zVOlN4mD2KGs0Tmc410291NFk=;
        b=UIhc03Z4S0HE6y8QVOMg7BhSuf5zzNVGYJavDJLSyjyfhKN/kyG0mqNPbv7V9deKGj
         GI89F5vc7qRTBnLCM5KjchDWTivSmmrcke6gXT4d/jV7uyjQanppeSIrUXj9qUwGu0NF
         IovxdUmIP7L9m+mQTu3gyOaFty7ypYOhNYFFChoSuW1WIbaF38wJ+7pdegRnEltWElDM
         ogE1Ahzt8MeRanjPgjmj/n7HkG49snp3oUJhc3HYrPsOSNkgBdKqgXYf4LjCaYDqJtwg
         IglwyYUQdkx2bVXoFUve7czrv/FSF1XoHBjc0wDLhy6MqVnVU/3iY8fwv4GKsR/NSY4a
         vE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261403; x=1739866203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaDCkKqlT5ei2VTbS0zVOlN4mD2KGs0Tmc410291NFk=;
        b=Lh38S4x0Wh/q2lB69dRg0UYfGsOdor6TSb3XA9yLE78rFQFM/WJR7YqfcHKugr9mze
         ZYyrxeabXKzmvqkEr4nkFgPna+D2soUKL5k+xSbXATF90V2H7EbSXMKnlTxT9DcMAYbr
         EY6TrjcBzwhrohVyVlQrTxU9tJcgPJ1YqL0ZdIQR1jgV/82t2Uf5fyy0H2dUOGEiRFzh
         f5EQ/xRi1uDEH+fUputvqu5c2bY2uxU9FEdQSlsq456/V6rh3w3kuilvKXulWvQ2ghkW
         bfd7FdDBPaNQ0tzQdgbg0+EGFgHikWSQcJdfe13+8ghh58t5BX5KfzsMJmbskCI7mP77
         dZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWptg3wD7U3cRGr1nc0jVjAs5AeJo8vnQEKl3PGv1QAtVWqVR9cijbye82BuSGvlJqsk/Tm5Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwDxJm0ByjJI+GHvkbtXMvbeOB5qeiqlOSThZQIHyYmVJnPOI
	ZMUBTL20GDv+yYLW/M2JfAkfj+DrTjLjOEqs/unbb+wsCSWgZqBQpLXNxKt6lgz6eB/kLXRCSBU
	CzWqfp5bpoWBzomXV63AjVJWDZ/Jc0Ryu
X-Gm-Gg: ASbGnctICmP6PIAF08UuRSUyDg3mIMfGnZQXM63lzXerER572CTbWIdZ4RIvDmM388P
	2OqB2vgwkic+7pCSUc+TguV464nPh/2tprIxuu45pVHWarWQqfr7csR3hGnZwDL8dYLDkHk7myt
	1Q0t/NvX0Q5CLRQ6ymrkKzDvCOc+8FnG6wuEpxB4sYY3ftXGXAhILT6XA6vueWE+Gi6NrMH7wAJ
	tB9g3rWKI1sT3GmL5I/+gKACOxgC3MpBshaW/d4M0ckZ0rZA6dKFOrun5uHUxbreZZp3nsKzrG9
	chNJeMbQv/CAozUBa7+b3ZuE/vcwC1bfhh15xHQ=
X-Google-Smtp-Source: AGHT+IEMwo5VjdKz2jhvwbTMazKMW9LXnW0ar4oDIFk5cA8yF4AeeZYqTwfueN3DZErI+7kGC7U5TQe6tpAs
X-Received: by 2002:a05:6e02:2199:b0:3d0:2548:83c1 with SMTP id e9e14a558f8ab-3d13dd29dd9mr119458835ab.6.1739261403668;
        Tue, 11 Feb 2025 00:10:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d161a40055sm2226935ab.4.2025.02.11.00.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:10:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0A6D33407B0;
	Tue, 11 Feb 2025 01:10:02 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F18B9E40D80; Tue, 11 Feb 2025 01:10:01 -0700 (MST)
Date: Tue, 11 Feb 2025 01:10:01 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kernel-team@meta.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <Z6sF2RZRdqnH6MQR@dev-ushankar.dev.purestorage.com>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
 <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>

On Mon, Feb 10, 2025 at 03:56:14AM -0800, Breno Leitao wrote:
> +/**
> + *	dev_getbyhwaddr - find a device by its hardware address
> + *	@net: the applicable net namespace
> + *	@type: media type of device
> + *	@ha: hardware address
> + *
> + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> + *	rtnl_lock.
> + *
> + *	Return: pointer to the net_device, or NULL if not found
> + */
> +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> +				   const char *ha)
> +{
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +	for_each_netdev(net, dev)
> +		if (dev_comp_addr(dev, type, ha))
> +			return dev;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(dev_getbyhwaddr);

Commit title should change to reflect the new function name in v2.

Separately - how should I combine this with
https://lore.kernel.org/netdev/20250205-netconsole-v3-0-132a31f17199@purestorage.com/?
I see three options:
- combine the two series into one
- wait for your series to land before mine
- figure out how to use take and use RCU correctly to avoid the warning,
  then revert those changes and use your new helper in your series
  (would want to avoid this, as it's more work for everyone)


