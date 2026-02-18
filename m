Return-Path: <netdev+bounces-259180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG7lDpIRlWnSKgIAu9opvQ
	(envelope-from <netdev+bounces-259180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6F15278B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B83C30066B6
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D72D0C95;
	Wed, 18 Feb 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S57BOpYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9C262FC7
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377039; cv=none; b=PEPpe+SKTNBPVdr94JXp4F7/WQBc3BsGDG0Y+6DZXnkHEEH93YKEx2v4LuYibfrELf8JxkXvvAmMIk9SC/2F/VEWY3Isv/4ZQx8rCN8S//vlBaa5aA9gflq0aKe8+4nGRTKGspTPpAzc77laMX1q9CsWA0YolBTVb11aVb9N54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377039; c=relaxed/simple;
	bh=AgxuI5ccrgLWNJbs+jIpzeLqmqALpfjDDErTO+AEH3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIzm2bVhNSEMM6rzhaN4ygitqHyf4h6LS5+0HEJTRj9/maocb9sDuw/zh7xA5T+OY3Py4OvRMDvYMrGB/DZNZhvQYKYK7dKhwLq+zVuod4DEB2wQno1Up2dsYygh+83VtZGC7O8pp2vwCboIpWz1vVD1PjVZMTytT5XWC1tDDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S57BOpYP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5599001eec.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 17:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771377038; x=1771981838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaLulxvPHYvGz4Xb3W5g68oYo3k4BkyuzN9QRj/2IQU=;
        b=S57BOpYPm0CYPfJUMrmqLY1kcCSc7WYJBAop5QJIuLiZz846mf7VpCSRqPxFE+JA6R
         tSxXyi6JpMa5goFgUMZ8FMrfoHjPMK+Q+uB5hDqqlnnNzUstYxmTCSDsoJQFLdAa39fU
         Ikw+AxCtPl6xmJrWT1ii5nrxAk9pBZFtTwfn+MZ3hCRL4sAFGGZYx3NmnOsqz1y6GrSv
         D4Phch/zQMzwAL6K23YXU3NgGKSyo+N2wBgynuPBWAF6ZKc1wjLqiTOiqHBhNdqpj7wI
         HM05qCfdzAGj5AxeTlW+NbNQRTci9OGxAH6Wt96lFpG1oiBTMf05mGSCYynYW0PSZ7s0
         ZV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771377038; x=1771981838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaLulxvPHYvGz4Xb3W5g68oYo3k4BkyuzN9QRj/2IQU=;
        b=hGD8VkztebC4zmUaUbDpOCL034TQE3r5uNbHu4hvkFzMp0qUdnvAwngUmUBo481eAD
         Trz1WY8AlkTknEzwEAtWP2xzHjWajp8fLww16aU4+Hzdu9v1UAv+4gXdK4R1V4VXSPJM
         ts2geQQPx05CKqNswSCSyJOKto8gppwaMxM14ZVUwD4c8Qp+iW6fsS+/AgueusHLxbzy
         0wvJ4IlLfEB0vU2/MmNdgFfbLe8NueB9yYvt9FusDj6GxUnnrPtH72BVorfDxp94cOUk
         drHxdlXqqEKJfwvwR/VAW75QH4A+BU0PDzs40IFXt/IHJgYB9k5nmEeW50KhN2ObyKdt
         2DUA==
X-Gm-Message-State: AOJu0YyWr/AOK6ycGRrMLHpDs0aZ6H6Qgl6/My3nf0LkUYe3F0e9538w
	557XUcZNzSKYNbJD30lVHQDDSVAOUwYJ/6vkOs1gEzH5gyoIaWIWR9w=
X-Gm-Gg: AZuq6aJ+E+U18tUUA+sgiEXR0teKDhZuHm02qxS4KHcVaIbhlqP1a/v211Kffhkdj9T
	lv3I1/SSiG0QhB6SNoIWzbBWuNRpzNBdxkCuHog8QMRazY7oGtzTswsEfHkK6sXpY+qTS9+/dWA
	wSc2ZS+PqeA+vHa0pCVDz26PhLpqQJVzY84fBrVLNYfhLtmh4HfCcU1dJTgBeAGbxaz9chQukRx
	H7eVtdU3QzherLX43yMUkzfmzX0wQe7EuaUeRrL5p/pl1SN91j6NK2dIUgmQuQfmWcw0bYQ4nou
	wTud+86nS56iMbd1mCj8AVmJ1c8KcgX8yIf6f+cEx+N2r9y4hTkf/sZ4n83zvC4jDJQRisHonbw
	Wfxztt/7m7kuqd0lVNvA2QVyMw6PUIt5x25UVK1VNDSv0YOu24Ek3NcExeYW5bgOBviyzjm8jiA
	Sa//nX7GeDF4qU931bU8pvnFzSeYEGsgZQo66aUhVxwW7vC8MQJoirO3bX/FNsEIIsUNv3LDs7N
	TKISJzvbUvaPM7yhw==
X-Received: by 2002:a05:693c:2c93:b0:2ba:99cf:e191 with SMTP id 5a478bee46e88-2baba0df2c6mr5760451eec.23.1771377037432;
        Tue, 17 Feb 2026 17:10:37 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm18751848eec.22.2026.02.17.17.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:10:36 -0800 (PST)
Date: Tue, 17 Feb 2026 17:10:36 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZURjBHTHRvjP7Ee@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260214033859.43857-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: D5E6F15278B
X-Rspamd-Action: no action

On 02/14, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> __dev_set_rx_mode() is called with addr_list_lock (spinlock) held from
> many places in dev_addr_lists.c. When a device lacks IFF_UNICAST_FLT,
> __dev_set_rx_mode() calls __dev_set_promiscuity() which propagates
> through dev_change_rx_flags -> ndo_change_rx_flags -> dev_set_promiscuity
> on lower devices. Since commit 78cd408356fe ("net: add missing instance
> lock to dev_set_promiscuity"), dev_set_promiscuity() acquires the netdev
> instance lock (mutex) via netdev_lock_ops(). This leads to a
> "sleeping function called from invalid context" / "Invalid wait context"
> bug when the lower device has request_ops_lock or queue_mgmt_ops set.
> 
> The call chain is:
> 
>   dev_uc_add(bridge0)                      # e.g. from macsec_dev_open
>     netif_addr_lock_bh(bridge0)            # <- spinlock, BH disabled
>     __dev_set_rx_mode(bridge0)             # bridge has no IFF_UNICAST_FLT
>       __dev_set_promiscuity(bridge0)
>         ndo_change_rx_flags(bridge0)
>           br_manage_promisc -> dev_set_promiscuity(team0)
>             ndo_change_rx_flags(team0)
>               team_change_rx_flags -> dev_set_promiscuity(dummy0)
>                 netdev_lock_ops(dummy0)    # <- mutex! dummy has
>                                            #    request_ops_lock=true
> 
> This is not limited to bridge/team/dummy. Any combination of stacking
> devices (bridge, bond, macvlan, vlan, macsec, team, dsa, netvsc) over
> devices with instance lock (dummy, mlx5, bnxt, gve) can trigger this.
> 
> Fix this by deferring __dev_set_promiscuity() to after the spinlock is
> released:
> 
> 1. Change __dev_set_rx_mode() to return a promiscuity increment value
>    (+1, 0, -1) instead of calling __dev_set_promiscuity() directly.
>    The uc_promisc flag is still updated under the lock for correctness.
> 
> 2. Change dev_set_rx_mode() to call __dev_set_promiscuity() after
>    releasing addr_list_lock, based on the returned increment.
> 
> 3. Change all callers in dev_addr_lists.c to release their spinlock
>    first, then call dev_set_rx_mode() which handles both the rx mode
>    update and the deferred promiscuity change safely.

[..]

> Reproducer:
> 
>   ip link add dummy0 type dummy
>   ip link add team0 type team
>   ip link set dummy0 master team0
>   ip link set team0 up
>   ip link add bridge0 type bridge vlan_filtering 1
>   ip link set bridge0 up
>   ip link set team0 master bridge0
>   ip link add macsec0 link bridge0 type macsec
>   ip link set macsec0 up   # triggers the bug

Can you add it as a selftest under selftests/drivers/net/team/?

