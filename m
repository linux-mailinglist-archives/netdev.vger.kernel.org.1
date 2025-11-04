Return-Path: <netdev+bounces-235531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F98C321EE
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58824E242A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22013335554;
	Tue,  4 Nov 2025 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToPNPUJp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5A335566
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274651; cv=none; b=KCmVDj/5mEfFLIifC2QaIWv3L33Ty6ukWJu1JStJlrvHiGHAUzmKAc9Ur+lEqJlpGkzMe1gaFBHL0PVyYzvNZUttZE5JF0lA3PDmT1kUduM3X7j9bnUwuMsZzmQkKKylG+01T+TgO0pPqZQwxUSNbnoo9MzYfjpbxH3SRYMPzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274651; c=relaxed/simple;
	bh=+6f8Az2YKgzFu/1Z87heVILzg2DKfZEbBe/3yhgUVjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFTL9RU7B7zUbW1nqpT67R1WH4m33omE61YngzAW3oMhctGvvPKez6j40A2IQYQQxlN6OzzU19HjfsvPFsUTo9b+QqkfEU8KdQCQW16bDV1X5f5a73lRc5OQX+/iWPO9xBA0fMHTOFpeQJQtVq976cdhwbPbJLyVf2kAj5f3b2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToPNPUJp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3927001a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274646; x=1762879446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNBFrCMvQ0mThH8RnIZnBD+qXuvr6aMextqQVAw5+04=;
        b=ToPNPUJp2Rs9m0LhRfO2tOdPfb301XtdplVuKe/idtkl+A57r3F3HStgUeL2/FfEKR
         c+IDrRpcqcB9Okh1BboxlCLd+deYo3Nf6SdriZSP82juPzKRXpRoPUAqhOP6B03IJZgC
         JzBFX6XE871Lo3L8CZ/7vmTJSuk+8+7mVNKwZZqNOpXnpTok2UdErl7bvRUu6y66RkM7
         9cnHABGyKJRNUZ8BRb65m+zFAEThzeBEkwXAgOeP81uUDmx1eQ8XOEGlYgUSS7H92QNV
         bAK6dhf/gKaSiFETvqzvNFDUB9Wp34PXMO6KHYtUuMvGtuT9SAi4zaD7FA3ngSNDigYr
         /ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274646; x=1762879446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNBFrCMvQ0mThH8RnIZnBD+qXuvr6aMextqQVAw5+04=;
        b=wK2S0csQTNXjPb3KorjuE8tZo43TSFSw26oYOi88c0rSVZGiX7QJvlhEBoeeWtihJq
         9JaUOKY4vRW8z6HYRwxwwXRrNGaBQXB80RIUncVPhjfZOAuQLrjyQkq9orXS5fklvvoO
         DWVjS7bWTyy/ET5q6HytImn28yzSBKkjZIzsMIxjdmjgWirBeClx2fYBTzdpzqLFrsQu
         eiO0gPwwf2ZaYg0jbIrWuatosOvMYAPyW/x1FDKG/2uRI9O7ntAErxJ5ZFCWsXaF8u+r
         skQvO0NzNGE0hXfPoImih9TlqRqZAi8A68g3Ydr1/2kPYJ2YVIMwYs50RgoKOtW81ltU
         JQYg==
X-Forwarded-Encrypted: i=1; AJvYcCVqFTpjuZ9VK5sCVClKH728AxzrCs8DwU3750L5I4vbJfjbtciEfDhjo0MYXWHhRK2lnUQa82I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52Kr22JC6a9tD7HHnVZ2/W/gi79gWD+wyz3hN7XxV1RZhQ2eg
	PJhICV82z9JrMEhOtx5bn9Rkhz5FgqWI0Ig9jisPiQqQ8yjiLkdkCeshN9uzd5aPdO8R+LTS/bd
	fGD9LZTw5byRkoB1id6lD2nQjt1GVRlQ=
X-Gm-Gg: ASbGncvNzLhotvxKGnHaxbxseZRTOXE32E2eSUJ8VJFT8b7X2nGTUkWPKZ3n/QKTg9d
	5WpF3DjpKYzhIT0ZfIThykSD2SDlEDTINeGkvHUxAmMvrJBKSmMgDW/1MR26aeEyB7lhCCbA5Wb
	YBIojV3JWzmYq0faHlrhx5cnu6+QZfpKgwokpvYzHbUsl49fb//v2PM/TDejIO0n+djjt92VU8N
	zFwHj/imRCdb1FugxDQzxvC38rq2CgIN9O/RYvnmwQ7dqBGpAf/nVQpMGAyIAdY6dNB6xa7MdHK
	4hBSff31j1Li7dJlzdQQmUXP/YWLIS3KtJlJ7GijHeyZ
X-Google-Smtp-Source: AGHT+IHjKRUqUHXHludDe/1mTMPgI/bE/8w3FFf+wR3Yq2t0BQji2y5lXCG1ALms3jIeNLLaYlQ5zmmYHpd4jhJyH70=
X-Received: by 2002:a05:6402:90e:b0:640:cc76:ae35 with SMTP id
 4fb4d7f45d1cf-640cc76b080mr5601496a12.21.1762274646019; Tue, 04 Nov 2025
 08:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
 <20251028174222.1739954-2-viswanathiyyappan@gmail.com> <20251030192018.28dcd830@kernel.org>
In-Reply-To: <20251030192018.28dcd830@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 4 Nov 2025 22:13:49 +0530
X-Gm-Features: AWmQ_bmHt-lYY7oXmHpmE0c8MQd7N05CNjm8AaKyi8JrjM3k7rUlxmiFrNq3wMI
Message-ID: <CAPrAcgPD0ZPNPOivpX=69qC88-AAeW+Jy=oy-6+PP8jDxzNabA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 1/2] net: Add ndo_write_rx_config and
 helper structs and functions:
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 07:50, Jakub Kicinski <kuba@kernel.org> wrote:

> pls make sure to prefix names of types and functions with netif,
> netdev or net

I think netif is the prefix that makes the most sense here. I will do that

> The driver you picked is relatively trivial, advanced drivers need
> to sync longer lists of mcast / ucast addresses. Bulk of the complexity
> is in keeping those lists. Simple
>
>         *rx_config = *(config_ptr);
>
> assignment is not enough.

Apologies, I had the wrong mental model of the snapshot.

From what I understand, the snapshot should look something like

struct netif_rx_config {
    char *uc_addrs; // of size uc_count * dev->addr_len
    char *mc_addrs; // of size mc_count * dev->addr_len
    int uc_count;
    int mc_count;
    bool multi_en, promisc_en, vlan_en;
    void *device_specific_config;
}
Correct me if I have missed anything

Does the following pseudocode/skeleton make sense?

update_config() will be called at end of set_rx_mode()

read_config() is execute_write_rx_config() and do_io() is
dev->netdev_ops->ndo_write_rx_config() named that way
for consistency (since read/update)

atomic_t cfg_in_use = ATOMIC_INIT(false);
atomic_t cfg_update_pending = ATOMIC_INIT(false);

struct netif_rx_config *active, *staged;

void update_config()
{
    int was_config_pending = atomic_xchg(&cfg_update_pending, false);

    // If prepare_config fails, it leaves staged untouched
    // So, we check for and apply if pending update
    int rc = prepare_config(&staged);
    if (rc && !was_config_pending)
        return;

    if (atomic_read(&cfg_in_use)) {
        atomic_set(&cfg_update_pending, true);
        return;
    }
    swap(active, staged);
}

void read_config()
{
    atomic_set(&cfg_in_use, true);
    do_io(active);
    atomic_set(&cfg_in_use, false);

    // To account for the edge case where update_config() is called
    // during the execution of read_config() and there are no subsequent
    // calls to update_config()
    if (atomic_xchg(&cfg_update_pending, false))
        swap(active, staged);
}

>The driver needs to know old and new entries
> and send ADD/DEL commands to FW. Converting virtio_net would be better,
> but it does one huge dump which is also not representative of most
> advanced NICs.

We can definitely do this in prepare_config()
Speaking of which, How big can uc_count and mc_count be?

Would krealloc(buffer, uc_count * dev->addr_len, GFP_ATOMIC) be a good idea?

Well, virtio-net does kmalloc((uc_count + mc_count) * ETH_ALEN) + ...,
GFP_ATOMIC),
so this shouldn't introduce any new failures for virtio-net

> Let's only allocate any extra state if driver has the NDO
> We need to shut down sooner, some time between ndo_stop and ndo_uninit

Would it make sense to move init (if ndo exists) and cleanup to
__dev_open and __dev_close?

