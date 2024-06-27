Return-Path: <netdev+bounces-107083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD6919B95
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55DE1C2247B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45636B;
	Thu, 27 Jun 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="op1qzA5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD775360
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446768; cv=none; b=OGGzg6HqCQ3S33VCouBfAJhTboD5QYE6qZ9HInlo3ApkLVXnM8KqMxq1cXHLFb3becIt89Mk9eXXYZkQssEmVu8YffpXu1pGs9up+AQrnel4DyEdL/vkHuKV43hJYZQWQKBFnixLgSaXQcevNZy3PmwYXBdQu6JyU3aMepfd8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446768; c=relaxed/simple;
	bh=kNYFQmwGc//9Em9SBVQpW+X+BzfkEKJflUzBBxzuxv8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gULgkfrdcMFMfYa+xHC1ZV3EPU/zosX3BffhD+SaxDvG58suExQ+hfZZYgwXnePgzB8gfU927hcs1A/Tx0imQLZfOB/GnAxuMrxZ+yzN/gQ9tJS7oh+7IUPpKRRCYFGSzeNZgcst48b6AGlNpTqRVH+UtSrpmot6K2P8y3lF7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=op1qzA5c; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCD1C3F733
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719446763;
	bh=Kj/hmS3QIv8Ld1uuHQ/9CSyRNoTOR3BmhkQcZ8RyOvE=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=op1qzA5cjqZMGRtkTs3sbKBS1Vgu796OMrm7kt9oOnaA6f2/8l8V7nJjJN9EW6smE
	 EZ2RGGkFl55FhBPNX/P33AOYg9NPvWXDOlc9b0BuuIXLi9Cv6k9WG7cniUvTJikFTx
	 +eqhYXi1jwXIMGqSnmQklM1vQHhXXWxSzUoyNoitejx+qYFoqPnf/lTI/EhYVF97ah
	 IXljZh80+Jha6oCHXgLIkDxaJu5F/ypRdZXCdzpjrzaEyP0cOoH+Wg0QE25g3Yg7KE
	 jWIodz3sGlO/42poyIJMvqhnGjnoQjIQyxR0F4YA5sUxxDI3286/RoanTeAgXrvZug
	 C6r3nbdm1j0pA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f9e9aa8cf3so71673895ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719446762; x=1720051562;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj/hmS3QIv8Ld1uuHQ/9CSyRNoTOR3BmhkQcZ8RyOvE=;
        b=fLpXgPp03MGifBQPtIyDl6/YNfeP2r6Tapi5dmrGdyQhwQlELhcQhc6ZkwXopHNBQN
         5eVomiSzeFQL9nvdg/DcgpVotGmbGUb129SsNUiJ6Av0bhYmYyfbfSe4XXJAmL1nboxD
         /qLNwPvWVtipsF2vnmzbhMZB+fQ2hbyZXo22hSuLY20oy+8nbs1Iu+0HVLFv+Q+lcY6j
         OIPVjLoxTlPTBKoLdU0Io8mNlw24BkAyJwZlO6jMy3PHCvKQJIGebrqsfnckeYimY94B
         yk8I23ey+e6W3DSxySeLIGPz91/RNsO//j3TIUllVlwzI484TJctAHslx4vQ0YVqL6c1
         8soQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3NKr9CJJPHw1DvGGjK9HPND5jJ7P1YRQtRZtQInnrUh0rjcDnWTB7CyD+cgff4yjf/QaZi0zwbJhSiI6Th1G5bsagwVIu
X-Gm-Message-State: AOJu0YxgBFnOvra9whStxtxnDQdXkzO8Tjjo30tH/n608J941a890Tvl
	WsFoF8jkDetEY7FVA6S0KxXzA77N96z/iBbn51Z7MLi8akqmcfXxyufFduf5KcaZRnQWL8XipbU
	k3whZV9zm0o/AuSaHdmquD5oqSUtQH8aLKnY6D8AA/tmZnQFlNMNrWBQpRNLeNdm9HatgJQ==
X-Received: by 2002:a17:902:eccf:b0:1fa:9149:4973 with SMTP id d9443c01a7336-1fa91494c44mr33261505ad.12.1719446762149;
        Wed, 26 Jun 2024 17:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBrY30KpzDNPN4HsgRYFw7DaePaXpoIKABX6eblzD3b5QOoMKP6wjhFXej+vcyF7qfphBaUg==
X-Received: by 2002:a17:902:eccf:b0:1fa:9149:4973 with SMTP id d9443c01a7336-1fa91494c44mr33261295ad.12.1719446761626;
        Wed, 26 Jun 2024 17:06:01 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac9a80f0sm684765ad.263.2024.06.26.17.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:06:01 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B88689FC97; Wed, 26 Jun 2024 17:06:00 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B79E79FC01;
	Wed, 26 Jun 2024 17:06:00 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
    Amit Cohen <amcohen@nvidia.com>,
    Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
In-reply-to: <20240626145355.5db060ad@kernel.org>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Wed, 26 Jun 2024 14:53:55 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1429620.1719446760.1@famine>
Date: Wed, 26 Jun 2024 17:06:00 -0700
Message-ID: <1429621.1719446760@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Wed, 26 Jun 2024 15:51:56 +0800 Hangbin Liu wrote:
>> Currently, administrators need to retrieve LACP mux state changes from
>> the kernel DEBUG log using netdev_dbg and slave_dbg macros. To simplify
>> this process, let's send the ifinfo notification whenever the mux state
>> changes. This will enable users to directly access and monitor this
>> information using the ip monitor command.
>
>Hits:
>
>RTNL: assertion failed at net/core/rtnetlink.c (1823)
>
>On two selftests. Please run the selftests on a debug kernel..

	Oh, I forgot about needing RTNL.

	We cannot simply acquire RTNL in ad_mux_machine(), as the
bond->mode_lock is already held, and the lock ordering must be RTNL
first, then mode_lock, lest we deadlock.

	Hangbin, I'd suggest you look at how bond_netdev_notify_work()
complies with the lock ordering (basically, doing the actual work out of
line in a workqueue event), or how the "should_notify" flag is used in
bond_3ad_state_machine_handler().  The first is more complicated, but
won't skip events; the second may miss intermediate state transitions if
it cannot acquire RTNL and has to delay the notification.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

