Return-Path: <netdev+bounces-240409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5312C74860
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 100424ED96B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DF348466;
	Thu, 20 Nov 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/Rugs2d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB333B6CF
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648142; cv=none; b=KTtBQNDAN2iPVScQjhvSAKelSB2fNznw1r09Y63dVefNbDlShWzti4a/2qCTMwpVW3jcKjTBfh994jpj5CI2rrIlYfH/9quZxoSbrNadNf3+lAXh8/QPROmXWPIGYClM7siLjySL7yGBAGGEyWQmhAzBx+vZifljhGpHUfxd6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648142; c=relaxed/simple;
	bh=URcRCRZc27ATehNsnD5wCfBb0enqn8YbmGPfjxgsNAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NlitLRKmBWGufY0mRHNslHKJNZ7ySX6lfBiOJ4ZA7zoRmP0nTox3VTX7f8OwEV39d8Xua64VTg9JIf04NanulqI6YS7U0DynisfW0O4azagTH8D3y2hYGJFv1ve9C4PCeIhpLC9MxMzkCJbxabEdzHWSZa8YZUeXdYOjH5h/hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/Rugs2d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297ef378069so8979035ad.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 06:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648140; x=1764252940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w0vRPTrSQYB1FNs5Alcq6MmQhD4iwCtva78BRmz+fY=;
        b=b/Rugs2dmreXmWWA/nrhZkSDi2gSJzQRxYkcNsMH8NNXyx/5afZaJwYKYg8zYvsp8d
         83rCzTcpwFNmxEKMSoMATdYc8eAnOxfctaox1wpYj7H4b05qeiyClV3T70C2yBEp0an+
         9ddbOx3vuYhfi3onPsZC8FJGfgqzoL6puRzWML2np7ZJb4DQE5cRjADPVyu0CI0p8waa
         vUjcGz4EIVgPpd0aeQuqj+OunjyTXrTvF4m6JektgPppchzkzQ2N3QIvCXMh/UZF7ZxT
         wBX/YV+S5B7m8Zlvb2vAVhSOfAWcM6cWOculid20zYL2vY1NX0nWctrijKVX5zFuVwaW
         aH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648140; x=1764252940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1w0vRPTrSQYB1FNs5Alcq6MmQhD4iwCtva78BRmz+fY=;
        b=wADagNO3NCfe0loxx27Cha8mz+Ysq8K+Tw8e0YGiMuKLFhw8Zje7xOA7ywyEiXzHFe
         za0UQVOfcbCcirL85Eo7wDSONeYBhNhsRH284kYunc3SegZ9GNycitKDUSQS7++q+650
         mn52KB1BAd3JUd1OxjN/4w+vkVTkieKsmozfoan6KB61LzJHNdmkJ4qlEvL7dmojCVDx
         F5E4ctWl3txCNNxNNPk4EJv7pPSb+qbdXwZqqRmswKWrZo92Q5CNSyW8bu6DWA8KMypH
         tSrvh1Yqx5GvvpNl7FitfnaL4tDWLeTMMXpUEWWi+Qvbwxp2leDVd1bKTlBkXOdO4wZ3
         hYYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmXBw4Qg97i6xhINGeMltIbqRYO1PLDLCbl1MZkOach0xrIOik4vHJRjrqRznCtFWSgmUphnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzdVwKLPRv/HzFfLTU0xH4jLjBpTV7RAru0Jybe8pch54+y/Q
	aeBlwBhTBtkP/cCruXstOnx0tgwwwBdxdqSbCYcNCHqNe34DN4dkHGNe
X-Gm-Gg: ASbGncsG6nTzdCel3rA0Rf8aTUGllWpIT/viXrQIt0BFjjt4DqSKbkgBqWkDdyriIR5
	TmEHTUTfZlZLtRwV6w8U9LjjYuvE/4Hq6AzrXh633PXTbdS5xA33HXbkdq5323rhIBzKr7k38ga
	NCqOZb/wxvibsvfFNX3c/Hyf+E5zQu3n+r7PlVaLZR6NI3Z7p2p+qZ/dYXbz02KlEIXZfBcjfRW
	wMUkDcTJueyG9FpzNtYOWDFiW8WDB8ss1St24Z/PQ5raSTLy7v4IjJkkHigfzvgAQ+N3TLNgkPH
	RLWYux78ZoAq0wpLvNsdTaOJIKVDH+xnbQb80TLdO4fpF2DMjEZm91Dh7ZVME3UvPH9zVAa3+u0
	0gHEuWhyP3hSAZYTfx+l0K2uo7EO3oCjybDDw2/XZzWQ5hFJNQPc95GXynrfSyCBdigS526ZEt0
	NbaHue1WrWNm3hW4TPQdR43jPB84W/AC0=
X-Google-Smtp-Source: AGHT+IHNdc6f9RQwfAmaKFzQBgZ1LixjzxJRn7eguePAU93WE2AGCr17VZU7UMlryHgGAufaRcg0Eg==
X-Received: by 2002:a17:903:1b03:b0:295:9627:8cbd with SMTP id d9443c01a7336-29b5b0f760cmr43206965ad.33.1763648140012;
        Thu, 20 Nov 2025 06:15:40 -0800 (PST)
Received: from COB-LTR7HP24-497.. ([223.185.131.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bcbsm28442915ad.29.2025.11.20.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:15:39 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v5 0/2] net: Split ndo_set_rx_mode into snapshot
Date: Thu, 20 Nov 2025 19:43:52 +0530
Message-Id: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep. 

To address this, this series proposes dividing the concept of setting
rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
reinterpret set_rx_mode and add create a new ndo write_rx_mode as
explained below:

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow looks something like:

prepare_rx_mode():
    ndo_set_rx_mode();
    ready_snapshot();

write_rx_mode():
    commit_and_use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode before its execution.

2. If a prepare_rx_mode call happens during execution of write_rx_mode,
    write_rx_mode should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
    schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
    has been implemented in core for this.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_rx_mode_schedule_work

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
Questions I have:

1) Would there ever be a situation in which you will have to wait for I/O 
to complete in a call to set_rx_mode before proceeding further? That is, 
Does netif_rx_mode_schedule_work need the flush argument?

2) Does priv_ptr in netif_rx_mode_config make sense? For virtio_net, I 
can get the vi pointer by doing netdev_priv(dev) and am wondering 
if this would be a common thing

3) From a previous discussion: 
https://lore.kernel.org/netdev/417c677f-268a-4163-b07e-deea8f9b9b40@intel.com/

On Thu, 23 Oct 2025 at 05:16, Jacob Keller  wrote:
> Is there any mechanism to make this guarantee either implemented or at
> least verified by the core? If not that, what about some sort of way to
> lint driver code and make sure its correct?

I am not sure how to automate this but basically we need warnings to be 
generated when the the set_rx_mode implementations are called statically in 
code (From my understanding, usually in the open callback or the timeout function) 
but not when they are called through ops->set_rx_mode. 
Can Coccinelle do something like this?

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag

Here’s an enumeration of all the cases I have tested that should be exhaustive:

RX behaviour verification:

1) Dest is UC/MC addr X in UC/MC list:
	no mode: Recv
	allmulti: Recv
	promisc: Recv	

2) Dest is UC addr X not in UC list:
	no_mode: Drop
	allmulti: Drop
	promisc: Recv

3) Dest is MC addr X not in MC list:
	no_mode: Drop
	allmulti: Recv
	promisc: Recv

Packets injected from host using scapy on a TAP device as follows:
sendp(Ether(src=tap0_mac, dst=X) / IP() / UDP() / "test", iface="tap0")

And on the VM side, rx was checked via cat /proc/net/dev

Teardown path:

Relevant as they flush the work item. ens4 is the virtio-net interface.

virtnet_remove:
ip maddr add 01:00:5e:00:03:02 dev ens4; echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove

virtnet_freeze_down:
ip maddr add 01:00:5e:00:03:02 dev ens4; echo mem > /sys/power/state

---

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  58 +++++------
 include/linux/netdevice.h | 104 ++++++++++++++++++-
 net/core/dev.c            | 208 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 330 insertions(+), 40 deletions(-)

-- 
2.34.1


