Return-Path: <netdev+bounces-230429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98648BE7EBF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744654E068C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA32D6E71;
	Fri, 17 Oct 2025 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qYPmCzhb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79612DA774
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695107; cv=none; b=FS8+ateeiKBq6081ZOSuwWmq/angBpxraSIhO+ogSa0lgzCwpI7ed5daOpRulJfyRvU/yh/B7TfjoLczjoSQb/r/io3p4e7G2YqGB+sMPVOcGktcbVfIvTe/sqZ+LGf+SmFNc1KCczg00IcnKiscmOFZsH2NFzGiNc7w1nxpnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695107; c=relaxed/simple;
	bh=uPh/ii+rgmvbCP0wm67KTw3FbLTpuetEo2DXOFYd9RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn6UuORLy76pL82slh+WDvKCjgP+p1db8LDXmri6PHQcl+Lv+PvDitMZAA8ibMeUA/QGHl6qXpjKmFZkS3q3E/mYXI9VEXZPqhZZMv5KIO1pOB6DrZVmzhN6s7ZNZpOblj3Sdf3jM3JvSW1G2EN1HlaDCe/WX8lEyGPjBeqmL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qYPmCzhb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270491e9easo741955f8f.2
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760695104; x=1761299904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGr3XDWHjHOJAcUpC5wF1xjA8pPevM01/q+Ros0ANMo=;
        b=qYPmCzhbzSYZrdIRVqWX0Tjm2tc5SC3AEn9oUGXJgKfeIgDQYdvgV7hF12GqF+n7P9
         VGPhm7sq+HR8byr8quuyx8zJ0NkC1Mq7yQJ9lCQ62Zw/AdM6Cv76+XPpsojFduywUE12
         VvfcBBLC9YbQOtbYssnSrsjqe3B5IjyhyWPj8DxmTKsFq/Qg49eVBFsnNMlk5QatC0HH
         EjMZyR7HO8moGzLseEbX1A7qyGvO7VaA0MM4GSMMM6iznjNWF9l8+GbxA312nfGpTrZp
         2g/Dk+/cIijaSajVib0VuZiIyj4WR+RHOotWEZBC1bWXfdgWAn+oSNoW0ruIuQSsi7bF
         2Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695104; x=1761299904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGr3XDWHjHOJAcUpC5wF1xjA8pPevM01/q+Ros0ANMo=;
        b=WzSrrsMDiLkhdnTu0Z3Cx5llHsETJngkaSzO9ROnZbSi0DHj9A47lpT8f1xeexlM5K
         xHVaPORkPpbia31ui9uRKwOUTK1k5BVMsV1rRRBPM66xpnFXxPWmV+ezu3AOg5icqCsk
         UCx06j+7PZztjO1U84oVPG3UHpqsCKU9AjgaFPMZ1OQXBOEtbu9nbI3YZf6k6sbNdQo+
         SWa7uAcG6gzglaUczq4NSQfEjvyTVIhJ6xX9xKQ8wa6nr1to2AxEzLZ4xEG6/0HYOKP/
         y9ChtbaLEewHX2JsjF/QgdHXb2bpdoUbcEcQU0UUYzkjFKrxjig7Kbm254BuGJfDWfPp
         r3/g==
X-Gm-Message-State: AOJu0Yz18TpSRwx2F1JyYJEMjYCFPDNUVf5Udlp8ei68nGIvYISFtJx0
	Aesq3xEHkuQzkUWrfkH9Rt7lHz4QdDPMRc7WMFkvI00mFKNsO719FvBxl6T9FG3MngdNyXuW6Y3
	Esk8B00g=
X-Gm-Gg: ASbGncuSpPLCK1JHEii5s9GDwnKkSDFlVDdQbLOAmUOjNLSjHibnMN9ooKpHZTugsBK
	FJVS88GyHbzf3umOIf5iVDOvKh/vfsrBW3sRwoufRw7qTVPqlaLVVGv0Xfo0BxMFlzsqZmgJp/g
	tp929rjqVl2BQbPyBhjnx8SM4nxNdUdGxDlOU3ITMQUfQpkMR+ANkC1yOAX8pTDB553B2RMCmQ9
	bpj2yi60zAGMy4xBp3beghVDXtG28HqunNRSErADvok4ORmQ5LjPtRoPzCPBlRLdNtPOe+ITc9X
	U+mUyO6EELkVDN4qeG61fezw4gGs1IP6lv6dyHB7crHBmzf2V3mD3RLg4BvvXW/6EWrCt4gVEJv
	kX0eShNRhfppZfGEkDU4eM6m1W1yitK2T7wxSJFQtS91tcdwHlR7oG580gBzXZpkv11zgQ4EqF1
	DK1Jl+jgqm00/Smjq6La7OsVrIToaQr/+HwqHavw==
X-Google-Smtp-Source: AGHT+IGGJNKEyEbaEv1ZDoXrARqgE/0dnSH8bQ2YC5QoAeNPQSjV6b1dU/j/crVsbpev8hT0qvinUw==
X-Received: by 2002:a05:6000:2887:b0:427:9a9:4604 with SMTP id ffacd0b85a97d-42709a9465fmr370577f8f.45.1760695104131;
        Fri, 17 Oct 2025 02:58:24 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm39944499f8f.34.2025.10.17.02.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:58:23 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:58:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sdubroca@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 0/4] net: common feature compute for upper
 interface
Message-ID: <gstrsf76zi5twyohlimenl3zli67k7l52vu27qwt5csrevrqoa@th2fqrhss2zi>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>

Fri, Oct 17, 2025 at 05:41:51AM +0200, liuhangbin@gmail.com wrote:
>Some high-level virtual drivers need to compute features from their
>lower devices, but each currently has its own implementation and may
>miss some feature computations. This patch set introduces a common function
>to compute features for such devices.
>
>Currently, bonding, team, and bridge have been updated to use the new
>helper.

Looks good to me.

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>
>v6:
>  * no update, only rename UPPER_DEV_* to MASTER_UPPER_DEV_* (Jiri Pirko)
>
>v5:
>  * rename VIRTUAL_DEV_* to UPPER_DEV_* (Jiri Pirko)
>  * use IS_ENABLED() instead of ifdef (Simon Horman)
>  * init max_headroom/tailroom (Simon Horman)
>  * link: https://lore.kernel.org/netdev/20251016033828.59324-1-liuhangbin@gmail.com
>
>v4:
>  * update needed_{headroom, tailroom} in the common helper (Ido Schimmel)
>  * remove unneeded err in team (Stanislav Fomichev)
>  * remove selftest as `ethtool -k` does not test the dev->*_features. We
>    can add back the selftest when there is a good way to test. (Sabrina Dubroca)
>  * link: https://lore.kernel.org/netdev/20251014080217.47988-1-liuhangbin@gmail.com
>
>v3:
>  a) fix hw_enc_features assign order (Sabrina Dubroca)
>  b) set virtual dev feature definition in netdev_features.h (Jakub Kicinski)
>  c) remove unneeded err in team_del_slave (Stanislav Fomichev)
>  d) remove NETIF_F_HW_ESP test as it needs to be test with GSO pkts (Sabrina Dubroca)
>
>v2:
>  a) remove hard_header_len setting. I will set needed_headroom for bond/team
>     in a separate patch as bridge has it's own ways. (Ido Schimmel)
>  b) Add test file to Makefile, set RET=0 to a proper location. (Ido Schimmel)
>
>Hangbin Liu (4):
>  net: add a common function to compute features for upper devices
>  bonding: use common function to compute the features
>  team: use common function to compute the features
>  net: bridge: use common function to compute the features
>
> drivers/net/bonding/bond_main.c | 99 ++-------------------------------
> drivers/net/team/team_core.c    | 83 ++-------------------------
> include/linux/netdev_features.h | 18 ++++++
> include/linux/netdevice.h       |  1 +
> net/bridge/br_if.c              | 22 +-------
> net/core/dev.c                  | 88 +++++++++++++++++++++++++++++
> 6 files changed, 120 insertions(+), 191 deletions(-)
>
>-- 
>2.50.1
>

