Return-Path: <netdev+bounces-277696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDjPB0I92mlCzQgAu9opvQ
	(envelope-from <netdev+bounces-277696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E33DFDD6
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6D7430628D5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EE19D074;
	Sat, 11 Apr 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXGXqnD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730828E0F
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910204; cv=none; b=q+vOMSvtTjzJ7TvCfs/4N+B9VdhjLAGsVkgmGC/fS2dMeSntDC8NMuP1K3clnKhpjuULzk/6bp8b3qs5xWkSh0a1mAJvM7uscYB2+I5/R7RshX7u3CM8WaUvPjPOiyF685IaXzQtUYANGbkyGSEC1H5g+/ZCZBHUNn9C17RA1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910204; c=relaxed/simple;
	bh=2k4mEIWah/8JE8SaX6vzVmYKk0AprhXtSeE7bW3CTZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLU4FuOG8+PT2GeRJxLaB8skSpJGUVTqBTx/yx375Ve12HZuExasJod0kpqfmqNXD2Qqc1g6oEmwDmDk2+V6DU3D0y+vvuFfP9j1tNf+x14IqM37ypBu0u65NoK/Y+T7/KgI3tk8JmayXsfS80auopphKHJ7oLhBNra9jqo1g/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXGXqnD5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso31270635e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910201; x=1776515001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prZtV8TeDGxI2L2T8HaiaAv7DssbczedfunO2mY/MGU=;
        b=rXGXqnD5KCSbthQsf3mQ42/xdIVj9JO0D6kPsQ+MiAMtqB9D6rdtcR+jiGq/hLxX6v
         8tXZfnIwdsZkDVp4dMApkoCjhYKYAs0K/XghMr1lL9wbrqBx1IcKdNs6dOAugBxa0Ixw
         oUBoc5dQN9m2kHsaK5f6kFD4skkK8rIH6sdb7KLXCjzdXS+tErWnk+17cD1biHrXWdXc
         drAkVebdkU+ekBRS6FU1zyiTNK3H2SZswN8K61xyy9mTg6mR4NQg48l/Gu70YrihqeT2
         0+LdWowTLL9RgMU0WgKuW2d0P6IH/GXYXEJfN86PCmkyA4fWnjXaOSVT598gHumHozq5
         w5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910201; x=1776515001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=prZtV8TeDGxI2L2T8HaiaAv7DssbczedfunO2mY/MGU=;
        b=ru0mMzE/F/u5DmZHLnNesOOeP/HkWtb5RmBedSVuC7XRILD5Jsc3QFq/+jlEu6wi1Y
         cXFo2/avdAWZUBHpt4yDUGWypPRybxCoIvdIaRamczFDps/8hnaWbnaV47Ap+Iq8mxmI
         4SHA2LfAVm8+0HGu2f/aqu2gJedlZDvaEPDg8OtHDnRm6Umn7XGXWHE4k7t2Qzu3+bUm
         I4knkUgNTz5pmm1kAehmpTbumMrJkJ5UfI/Vok7dbudQWkd1dk1Cam+aoXdfbrYJzwnf
         YNWHClkqqJU+jlnECcOgIlDHyIUehcvhWV5SA3spkircvhIe5Ia9plwcpgW7GfUXadci
         rc7g==
X-Forwarded-Encrypted: i=1; AJvYcCWRSLEWu0SfITE5NNwW87tVCcmj9mWybRi1eKhKFtUf/XzwP4jnYFAlpalioqXL3h8kNy2cFBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BTg0UT9QmeBPAPstkv6P/UC5DBwE46JlHGj60nkYCbyS9M+t
	DK0Q0AXA/Ilw6roiS3M/wBC2qWPOaQBOJBJg07WPHfTYRc/IzN2FuLOn
X-Gm-Gg: AeBDiesT/V14FHKYipC7RpyLYmoyQyDkkEQ+BOLuDGv/dr1gAFxpTh09GIz9wC2PGTN
	HRgNdC569cCjCUYZmyUClHBpb29l94fZ2ecQhEBUUKMna+wVy0GRwBbpA8p6r8i4+F4vrQj95md
	MLcye3VBN2YQPr65fHAKUO1jQCmT9/LCnu/7ll8S1+0hr50N8sMgazr1kt9zzCWoPYqAnB95meR
	G8Ndq2Sda+/Gx5LnCzkRVOdeKnesfQJALigQkda8fUHrco8UXOLa8gNYjIHeiAklIdKckJ9rzQ2
	dSmBwWs1aQF7MqKWtkwy5eIWA6xmBCQMtVk/PTV3497HdpYxlW5GvqCV4Vm9+xBwiIDAcbsCBxq
	ZB1o9mT2/7B+G7d/6K1pxRw3UTGhhcLg/+LYuFncPzWL2uQzJH5YodR6ZsMTky5XxwADQZ4u++j
	FJVljBV2WSYc817H3uTQaV+ZAgfhOz7LwxVFUxxwbfK8yH8rHgaPHDB5xDHt5/k1XR
X-Received: by 2002:a05:600d:d:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488d67b8dadmr71299655e9.6.1775910201380;
        Sat, 11 Apr 2026 05:23:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d85ae9sm62753825e9.3.2026.04.11.05.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:23:21 -0700 (PDT)
Date: Sat, 11 Apr 2026 13:23:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Pravin B Shelar <pshelar@ovn.org>, Flavio Leitner
 <fbl@sysclose.org>, Mark Gray <mark.d.gray@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] openvswitch: fix kernel panic from oversized vport
 upcall PID arrays
Message-ID: <20260411132319.560dcb22@pumpkin>
In-Reply-To: <20260411055915.1224902-2-bestswngs@gmail.com>
References: <20260411055915.1224902-2-bestswngs@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277696-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B7E33DFDD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 22:59:16 -0700
Weiming Shi <bestswngs@gmail.com> wrote:

> The vport netlink reply helpers allocate a fixed-size skb with
> nlmsg_new(NLMSG_DEFAULT_SIZE, ...) but serialize the full upcall PID
> array via ovs_vport_get_upcall_portids(). Since
> ovs_vport_set_upcall_portids() accepts any non-zero multiple of
> sizeof(u32) with no upper bound, a CAP_NET_ADMIN user can install a
> PID array large enough to overflow the reply buffer. When the
> subsequent nla_put() fails with -EMSGSIZE, five BUG_ON(err < 0) sites
> fire and panic the kernel. On systems with unprivileged user namespaces
> enabled (e.g., Ubuntu default), this is reachable via unshare -Urn.
> 
>  kernel BUG at net/openvswitch/datapath.c:2414!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  CPU: 1 UID: 0 PID: 65 Comm: poc Not tainted 7.0.0-rc7-00195-geb216e422044 #1
>  RIP: 0010:ovs_vport_cmd_set (net/openvswitch/datapath.c:2414 (discriminator 1))
>  Call Trace:
>   <TASK>
>   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1116)
>   genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
>   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>   genl_rcv (net/netlink/genetlink.c:1219)
>   netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
>   netlink_sendmsg (net/netlink/af_netlink.c:1894)
>   __sys_sendto (net/socket.c:2206 (discriminator 1))
>   __x64_sys_sendto (net/socket.c:2209)
>   do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1))
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>   </TASK>
>  Kernel panic - not syncing: Fatal exception
> 
> Dynamically compute the reply skb size based on the vport's actual PID
> array length instead of using a fixed NLMSG_DEFAULT_SIZE, and replace
> the BUG_ON() calls with WARN_ON_ONCE() plus graceful error returns.

IIRC WARN_ON_ONCE() will still panic all the systems with panic-on_warn set.

	David

