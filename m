Return-Path: <netdev+bounces-68027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E636845A82
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F591C23421
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9D5F48C;
	Thu,  1 Feb 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5KNOi//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2F5F485;
	Thu,  1 Feb 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798792; cv=none; b=nCdfnSC5dY9AN6scfdnLlnYkU3nSGaf9eoZquqSAfpABKED5Vc0rLr0m178aGpBGfEzQ0L51J4tDv+OO5l/b6UcNXJszegTVJBkxU0WPdMp4UfImHvcVlmVqr0TN2nXPcUK+L01qmPCR4fdwgj7K8Z9TaHb7Yo1xFU9Lp3WXbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798792; c=relaxed/simple;
	bh=+84JksrV2qhyYy3VihsPnWYPu0yGjsEP4I56qsMMor0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=JHcTqoCFS16PONja2nUyBPHSU4GA13AHKuR5d3Mpd94YfI2Shk6Vg700ECI0Q6zZwvh46tStBHGcW2IZ1NTq9rpYEMQAOl1lnYUO2+sbhD3LR/1UXBzMEqWD2PdOWhXXCc/7in/+92Kma6Du2YwHHvEWkvBwzK42ZsIeiiCmkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5KNOi//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6C8C433C7;
	Thu,  1 Feb 2024 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706798791;
	bh=+84JksrV2qhyYy3VihsPnWYPu0yGjsEP4I56qsMMor0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Y5KNOi//pM6l6EqX3cybIqsFDiewyvS5TZJu48Bh+Hy7GXseusCfwOV7sD1NvRWjS
	 h8JLiilAYOqzL3IekhWxwLzaDNh44LZ4KUQANyOU0I6yfCexNQ7q4dKRzcpZtZJwNh
	 AqvmUuf3HRDChsQs2kmu9foDYibD6SkRHrlCG3Z0PlT1vR6sxgfhZNHOst6CACP6R3
	 Izl4AuO2cTVHM5LTDPxn6PEaecISXvqZozablnzQNU0vVcDyXZBt2mZPZteZZCow63
	 Nb0Jl1uIiBZRV2w++Lz2iFrsb5TMDxJp3Nlg7KMvj96+LEnF49r0BF5TtOcA6QcJ8L
	 5KcJeTfqwh32w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201140024.1731494-1-tobias@waldekranz.com>
References: <20240201140024.1731494-1-tobias@waldekranz.com>
Subject: Re: [PATCH v2 net] net: bridge: switchdev: Skip MDB replays of pending events
From: Antoine Tenart <atenart@kernel.org>
Cc: olteanv@gmail.com, roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Date: Thu, 01 Feb 2024 15:46:28 +0100
Message-ID: <170679878841.4979.18209786390477643347@kwain>

Hello,

Quoting Tobias Waldekranz (2024-02-01 15:00:24)
> =20
> @@ -677,22 +691,26 @@ br_switchdev_mdb_replay(struct net_device *br_dev, =
struct net_device *dev,
> -       rcu_read_lock();
> +       spin_lock_bh(&br->multicast_lock);

The two errors path below also need to be converted from rcu_read_unlock
to spin_unlock_bh.

You also probably need to s/rcu_dereference/mlock_dereference/ below
(not shown in the diff) now that this snippet is outside an rcu read
section.

> =20
> -       hlist_for_each_entry_rcu(mp, &br->mdb_list, mdb_node) {
> +       hlist_for_each_entry(mp, &br->mdb_list, mdb_node) {
>                 struct net_bridge_port_group __rcu * const *pp;
>                 const struct net_bridge_port_group *p;
> =20
>                 if (mp->host_joined) {
> -                       err =3D br_switchdev_mdb_queue_one(&mdb_list,
> +                       err =3D br_switchdev_mdb_queue_one(&mdb_list, dev=
, action,
>                                                          SWITCHDEV_OBJ_ID=
_HOST_MDB,
>                                                          mp, br_dev);
>                         if (err) {
> @@ -706,7 +724,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, st=
ruct net_device *dev,
>                         if (p->key.port->dev !=3D dev)
>                                 continue;
> =20
> -                       err =3D br_switchdev_mdb_queue_one(&mdb_list,
> +                       err =3D br_switchdev_mdb_queue_one(&mdb_list, dev=
, action,
>                                                          SWITCHDEV_OBJ_ID=
_PORT_MDB,
>                                                          mp, dev);
>                         if (err) {
> @@ -716,12 +734,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, s=
truct net_device *dev,
>                 }
>         }
> =20
> -       rcu_read_unlock();
> -
> -       if (adding)
> -               action =3D SWITCHDEV_PORT_OBJ_ADD;
> -       else
> -               action =3D SWITCHDEV_PORT_OBJ_DEL;
> +       spin_unlock_bh(&br->multicast_lock);

Thanks,
Antoine

