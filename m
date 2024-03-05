Return-Path: <netdev+bounces-77539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A0872242
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97801283CC9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68FB126F14;
	Tue,  5 Mar 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orOXyIhC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B16126F0C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650845; cv=none; b=sx+yb4C9HAFSiuphWwVXHoGST9eIbtWKxhQ4Ho8QX+iuZPIZwNooMhal60GbA4aMpOMyNSqG3N830y3uwQZjFwmV2qb9uRRqZrEyQbXJQs3AkmHDe+w6z8PQlO6mOqcEWoSDaUJxTeVqdTJMzE9v2N4M5Ui1sQBSdiGhWh5C1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650845; c=relaxed/simple;
	bh=pov8KNgClwckNhiM42kn0rWopyLiGD3QGpvlTjeulnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrWzAvye2FxsS4tNU51PEGBDWcCNI+zHyaD6Z3Uu1VRy4lc06Mp/2rCCI0NV3pzFRzD+GMzB5+lZV83TqnXfWt1h63iKDFlUZKOgY9lIbFdW1uLkM5FtpXATfM1EUDJqtz03c9+u2MQINr6sbS+/AAiYON7fYBEe7TH5M/NBCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orOXyIhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C72C433F1;
	Tue,  5 Mar 2024 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650845;
	bh=pov8KNgClwckNhiM42kn0rWopyLiGD3QGpvlTjeulnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orOXyIhCSAHCue9Ntqmw6fP7jec/3E7yYMyCSoLWyJvJXlXokTc9MibR4wqQXQCX0
	 MoRaVkFeIslSIB5YXEMHRl9UH22fZ6rELFTJwGd/rCjc9i2Lhs6fKhDU6HNHg9IFqE
	 M7XqAyL5UBeCI12WuKfqf93gmibXFwosKNGn92YaOVWqyFl3EuJqNXABkV1nqVfcB1
	 xJIIcYlqe/0xDyGXGqhMR2Dq1Ct0XCZxqA1GkXsbIhto5Hs5hmQvtS3DpvlC8OjFhG
	 S9Uxb7ck/5PI9XJYR4O9A0NFcjzghDvjnT5DT+akhYq76OFUHWT3D3atlW/aJ1iybj
	 5mscQ7Pl8M4mw==
Date: Tue, 5 Mar 2024 14:59:11 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 07/22] ovpn: introduce the ovpn_socket object
Message-ID: <20240305145911.GJ2357@kernel.org>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-8-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:08:58PM +0100, Antonio Quartulli wrote:

...

> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> new file mode 100644
> index 000000000000..92c50f795f7c
> --- /dev/null
> +++ b/drivers/net/ovpn/socket.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_SOCK_H_
> +#define _NET_OVPN_SOCK_H_
> +
> +#include <linux/net.h>
> +#include <linux/kref.h>
> +#include <linux/ptr_ring.h>
> +#include <net/sock.h>
> +
> +
> +struct ovpn_struct;
> +struct ovpn_peer;
> +
> +/**
> + * struct ovpn_socket - a kernel socket referenced in the ovpn code
> + */

nit: ./scripts/kernel-doc -none
     complains that the fields of this structure are not
     covered by it's Kernel doc.

> +struct ovpn_socket {
> +	/* the VPN session object owning this socket (UDP only) */
> +	struct ovpn_struct *ovpn;
> +	/* the kernel socket */
> +	struct socket *sock;
> +	/* amount of contexts currently referencing this object */
> +	struct kref refcount;
> +	/* member used to schedule RCU destructor callback */
> +	struct rcu_head rcu;
> +};

...

