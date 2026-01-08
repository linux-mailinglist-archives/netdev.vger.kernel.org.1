Return-Path: <netdev+bounces-248251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67671D05D81
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72BFF30184C9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13428347DD;
	Thu,  8 Jan 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b="fwWMK1wQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2E1B4223
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899980; cv=none; b=mUmBJe4+k6fwkvV3sKEU1Wbn6rksXdNSDhCjpB4S69Ui0x1b09x1DjCI7O7LGs+tu2/8iGhJy+gitqzf7hNyyDclAISYNw9/5DJObAmtbEtrvYrLZuWEjiQcZ6RZA0+IDzPkkH/i2PPBjQUCyay+8lHc9sdinILarG3GGGd+v70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899980; c=relaxed/simple;
	bh=bpWrID2Re41bDmfKLe6xj+L0jccJqONNAxfffqyNPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8dTSpZKNAf5ONukNhJTdwnEW9DQ7avomK1/zQJjwEtoN5+Fg+Y/2viUbX7MQHtYmHaAfgLsjBJdSB7zDw5/I/F4aZyHBSBXxHOrkwpLFZzxHObeiw5De5xyoA/lzQAAQvgE5U85KIdVjLFC3eK0J6zmsS4bkDcdfr+0dhflJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com; spf=none smtp.mailfrom=delta-utec.com; dkim=pass (2048-bit key) header.d=delta-utec-com.20230601.gappssmtp.com header.i=@delta-utec-com.20230601.gappssmtp.com header.b=fwWMK1wQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delta-utec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=delta-utec.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso5285822a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=delta-utec-com.20230601.gappssmtp.com; s=20230601; t=1767899977; x=1768504777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i7tFv9y2oac4fTzyNwEkxTudPfwmgFKCIcXeeF6b9U=;
        b=fwWMK1wQC9saV0jTfT7iuJ9BaebGel65sYBaeaAdJ8RYvUEMlIknzXxIIUsmx5tj6K
         y1DbzWxbyCj4xvGyQM98MKIAJKzAaBxWISLP/LNWpG0NdZXJTAlWySJd5uHHsKtqmdG5
         Y0rSV6u1IVvAAnTfRNRt22TUB35DIE3B/INNZGvD4GOITEtzbxKokbKf3RMDRsH6Csoh
         2RZMeEuGMRLriQxGQ3ov4EJuU9QKwn+phSHjHPOeJog2rEr2FhvaTIXQPvXAayQMo68G
         KJCdUgN29kakAM9Q4dLYjGB/Tetaw5bAY3KR349tztUWnRpb9REIrLpGaekgmfL/41bv
         dxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899977; x=1768504777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5i7tFv9y2oac4fTzyNwEkxTudPfwmgFKCIcXeeF6b9U=;
        b=PvH3Hn2tf+btSLiugq7v05MRYHL7FZAQS0+eatBib0NkSjW2bAPf+Gi66uhtLq7wAS
         rV3Z1tCxZpfzOMvQx1QZfzcmTZmKLheS494RiwxUsr2MhUGociyQjJsTWW1aU/3vx9N0
         Qcu/Izfa67A1U+bv5xs4VIQvX3Rq9ZWMT26PO4Xe5u8ZdQ2WTqrvOgpE3tJHHEp/Ch06
         75F6gSjnYoxJ8I0pgYptoAD+k1tLcp0duxBh26pM58+hNBVQasbYP0uDCAZeZAA0ruIf
         AEbwfhmm5qTsJyIX/CC3oyyZ85FHE4fLofnf6vLqKL3nYN+6L+s5yn35xNbDflpomj6a
         PQ0g==
X-Gm-Message-State: AOJu0YzrfXbtvpilIDn2vVkBu+Y7QTVFgGL3WLs9RyNW57QSjGtx4ecf
	YMkysYRJfeO0rzlHBHd7QWpK96LdIW2mF9bhol3Ziki3Hw7xtk+ic5DTxbkn+WkaFA==
X-Gm-Gg: AY/fxX4DjkPIPTkCDp7LjcvSxl4XT9iugA8BPELxvg07Som44YZnwgvEnUsYPOY1fJX
	ZXHqp81w4jclgyWYu0xR/ZBYHmYir8314H7ay0UQTUnOjikQ2Rh/9o1p0ufJj7CHFaJQxvPW3lC
	f8BTjFhCLFydiIJZUVmZhc4GyJoiJE1fEOf4+iKgXH53cO4O8m2obMaiDiqY1PIhiNfDV5qubds
	fL8N+94wJsT1l4F8Va4ohyGvtZ6Pwew0urNKTe7kCqz0AP6hMSbCk7yCG2mw6E2yaQxnO1nsirF
	QLmSnr+zXbDiR2U06wdYY5PPJM708sG2UC99YJ7do5FmW915gmkI9SHS78VaRBbvzqXoSr9HwNC
	fQkzAsoMsj+xlpfSkvsq+rceO6w2wDS+YpCEAIxpRPvIaWbZFxN/eZFM3/YgwNtI9q1jLBt/Ggp
	mt7Eh51DbTA/vFmXCWrEoJ7P0QY0xJ/xk14L6OHe58WXp1ETNbPjR8NeQuB5J1tDtDZBAbiIdJc
	gR/iOXxZ4VNgPvPgd+6y+D8moazIiPLs5HvYw==
X-Google-Smtp-Source: AGHT+IH2KkMyLwxhvAAly+EQ6uJEXPP3cmILGGd5FtUl/OGDGwPpEHXeaUIcFRH8NC6qtVL0de3D+A==
X-Received: by 2002:a05:6402:270a:b0:64d:23ac:6c96 with SMTP id 4fb4d7f45d1cf-65097dc6302mr6146101a12.7.1767899976641;
        Thu, 08 Jan 2026 11:19:36 -0800 (PST)
Received: from localhost.localdomain (2001-1c00-3405-d100-83e5-0d54-1593-059c.cable.dynamic.v6.ziggo.nl. [2001:1c00:3405:d100:83e5:d54:1593:59c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4ed5sm8126844a12.11.2026.01.08.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:19:36 -0800 (PST)
From: Boudewijn van der Heide <boudewijn@delta-utec.com>
To: edumazet@google.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Subject: Re: [PATCH net] macvlan: Fix use-after-free in macvlan_common_newlink
Date: Thu,  8 Jan 2026 20:19:30 +0100
Message-ID: <20260108191930.145655-1-boudewijn@delta-utec.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANn89i+x2LGnBJES1y0HWQC2xVo__53_QHFYjuSs7s6+ShNBtw@mail.gmail.com>
References: <CANn89i+x2LGnBJES1y0HWQC2xVo__53_QHFYjuSs7s6+ShNBtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Thanks for the patch, I agree it improves safety for source-entry deletion.

However, I believe it does not fix the specific KASAN report from syzbot, 
which indicates a UAF on the struct macvlan_port itself, not a source entry.

The report shows the freed object is in kmalloc-cg-4k (size 4096):

The buggy address belongs to the object at ffff888030eda000
which belongs to the cache kmalloc-cg-4k of size 4096

struct macvlan_port fits this size (due to the large hash tables), 
whereas struct macvlan_source_entry is much smaller. 
The crash happens at offset 3580, which corresponds to the vlan_source_hash array inside the port:

The race occurs in the register_netdevice() error path in macvlan_common_newlink():

1. netdev_rx_handler_register() succeeds 
2. register_netdevice() fails.
3. macvlan_port_destroy() is called, performing a synchronous kfree(port).

If a packet arrives during step 3, 
macvlan_handle_frame() accesses port->vlan_source_hash (via macvlan_forward_source),
after it is freed.

My patch restores the kfree_rcu behavior for the port (removed in 2016). 
I believe both fixes are needed: yours for the source entries, and mine for the port itself.

Thanks,
Boudewijn

