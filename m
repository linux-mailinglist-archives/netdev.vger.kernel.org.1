Return-Path: <netdev+bounces-73032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B42985AA87
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FD8282E5F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B647F52;
	Mon, 19 Feb 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T+CSx5PO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B844C88
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365871; cv=none; b=R1Jqdg9fbi+zcAPC111x3wa5wMX0Jrx0DTrnzJmmGS/klWd4ElUTlzsqa2i23fm1OG0emMAsVvpiDLUmPCovT1nhMfA5hsW2zHdSEitdj1vi9T1UOK42/Ytm5WIymx1C5jaMgoKD249kD6Y07hijHImCKsyAPWGEabvw2OWjcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365871; c=relaxed/simple;
	bh=pQV2zsLQPG1gT0RdxllS8v1H/CwFTLSCmr7rzhAeXAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvzwbywmFO+l6gWNn8pqVLxTD6bA6GpsXXPVu9qeY2Vl6Orx8RoX0mA8gONc7csnJPHmZKG1z5EeHYg+J7P/rAGkEYUq+9qwmi8kYVkcNKTZk0JqM8SwYqtLXgbjUBcaS2PcO5aWSSPqooBHXx2QJtHrjJHU0pQd2vGozcp2LOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T+CSx5PO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso203094266b.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708365867; x=1708970667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KcibY9B33x9A3p9ng7g+OGI65hW4vtz2QUeCLlWjJ8=;
        b=T+CSx5PObIWCF/nSpctm5Gc266IqpLXCLu8RMkrnbZIvQ/8Yq3zxe22vBOt3dCUzWD
         8qPpY9ndOzQdfAciIlQkuXemL87Fog73Wk7+6enbHoipNqnvcMlbQMlm3qAKuKsdk4cm
         VHqGHaeA+r9rftN9YpJRDY6yaCdzZkiP5Q7apIUKeX+jdpg6Rc4SwpY8C4ckTmhZyMoT
         z9Wd8iTbS7KLj8P/C1oi207Au1N4d5Tpzkkm2dGPRa5X60dI6Y4YMOS/Zmq6UfBMJ4h2
         LUGcsqkk9VoR6L7V0Z8mDWcFiCRbgsP5LYPOSuFaLAQnkb/g/VLzgzYRGqc3Q+KBZA6F
         9y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708365867; x=1708970667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KcibY9B33x9A3p9ng7g+OGI65hW4vtz2QUeCLlWjJ8=;
        b=Umwb7b/9jE5Kt1uAiiiJun0vqeBSamCt7Vtq22Z9j2NZsTs+Vk4ukaZ+vCX/KKvphX
         +YZ7g1nmcBjKVUAmQxSNsN/2UxJSQzJS/Z2sbrvPKI0p3QySxBP8bKpT3N8RRoRCvThK
         CXgbwBCXZkBVByVMT8+zCZwEOcSYzOScPlt8JpU1fHXwsBTZAnfEzQexEf0D1hATWex9
         UVeN/l/U119qOeFBfFjI6jqgK9YXB6AaYHWWtFAy3U7Thf/HTFDuA9/pjZ4Wwo0I58hk
         o+f8L8GafxY053uXAkPI7fyWlFqw7KcOX/8gQlBLHv9k6mYPmB2ukY8TruYfXpLx0Tha
         u6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXKokxmLImiU8B9Lgo+X0aPudcIuL47B6K1V2B/S/I4650W99ZXKl4E3HWySE4I1wwXqlzqNAxKiyKC9eGkDX9wlhhyH6HD
X-Gm-Message-State: AOJu0Yw42UcWaglyw9yUz1XPCapu4ZjeREL2cjMXpib4rhaH4BGDVXaq
	R+r4il3CZInzXKe2k0hXsFk6HYd348NmPWMyv8HeQKQyaMZLYNjVLW+Mc/2CdRo=
X-Google-Smtp-Source: AGHT+IFd9YZ4vajgLgqM10QspO8u90esmUQ2B7E08v3zLiic5kP/3lk1roHi8itxye3iHYmtR+Rt+Q==
X-Received: by 2002:a17:906:f258:b0:a3e:d20a:f1d9 with SMTP id gy24-20020a170906f25800b00a3ed20af1d9mr1160674ejb.11.1708365866631;
        Mon, 19 Feb 2024 10:04:26 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906c19000b00a3cee88ddc7sm3217827ejz.147.2024.02.19.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 10:04:26 -0800 (PST)
Date: Mon, 19 Feb 2024 19:04:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZdOYJ5UBYXfJ52-e@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215030814.451812-16-saeed@kernel.org>

Thu, Feb 15, 2024 at 04:08:14AM CET, saeed@kernel.org wrote:
>From: Tariq Toukan <tariqt@nvidia.com>
>
>Add documentation for the multi-pf netdev feature.
>Describe the mlx5 implementation and design decisions.
>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>---
> Documentation/networking/index.rst           |   1 +
> Documentation/networking/multi-pf-netdev.rst | 157 +++++++++++++++++++
> 2 files changed, 158 insertions(+)
> create mode 100644 Documentation/networking/multi-pf-netdev.rst
>
>diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
>index 69f3d6dcd9fd..473d72c36d61 100644
>--- a/Documentation/networking/index.rst
>+++ b/Documentation/networking/index.rst
>@@ -74,6 +74,7 @@ Contents:
>    mpls-sysctl
>    mptcp-sysctl
>    multiqueue
>+   multi-pf-netdev
>    napi
>    net_cachelines/index
>    netconsole
>diff --git a/Documentation/networking/multi-pf-netdev.rst b/Documentation/networking/multi-pf-netdev.rst
>new file mode 100644
>index 000000000000..6ef2ac448d1e
>--- /dev/null
>+++ b/Documentation/networking/multi-pf-netdev.rst
>@@ -0,0 +1,157 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+.. include:: <isonum.txt>
>+
>+===============
>+Multi-PF Netdev
>+===============
>+
>+Contents
>+========
>+
>+- `Background`_
>+- `Overview`_
>+- `mlx5 implementation`_
>+- `Channels distribution`_
>+- `Topology`_
>+- `Steering`_
>+- `Mutually exclusive features`_
>+
>+Background
>+==========
>+
>+The advanced Multi-PF NIC technology enables several CPUs within a multi-socket server to
>+connect directly to the network, each through its own dedicated PCIe interface. Through either a
>+connection harness that splits the PCIe lanes between two cards or by bifurcating a PCIe slot for a
>+single card. This results in eliminating the network traffic traversing over the internal bus
>+between the sockets, significantly reducing overhead and latency, in addition to reducing CPU
>+utilization and increasing network throughput.
>+
>+Overview
>+========
>+
>+This feature adds support for combining multiple devices (PFs) of the same port in a Multi-PF
>+environment under one netdev instance. Passing traffic through different devices belonging to
>+different NUMA sockets saves cross-numa traffic and allows apps running on the same netdev from
>+different numas to still feel a sense of proximity to the device and achieve improved performance.
>+
>+mlx5 implementation
>+===================
>+
>+Multi-PF or Socket-direct in mlx5 is achieved by grouping PFs together which belong to the same
>+NIC and has the socket-direct property enabled, once all PFS are probed, we create a single netdev

How do you enable this property?


>+to represent all of them, symmetrically, we destroy the netdev whenever any of the PFs is removed.
>+
>+The netdev network channels are distributed between all devices, a proper configuration would utilize
>+the correct close numa node when working on a certain app/cpu.
>+
>+We pick one PF to be a primary (leader), and it fills a special role. The other devices
>+(secondaries) are disconnected from the network at the chip level (set to silent mode). In silent
>+mode, no south <-> north traffic flowing directly through a secondary PF. It needs the assistance of
>+the leader PF (east <-> west traffic) to function. All RX/TX traffic is steered through the primary
>+to/from the secondaries.
>+
>+Currently, we limit the support to PFs only, and up to two PFs (sockets).

For the record, could you please describe why exactly you didn't use
drivers/base/component.c infrastructure for this? I know you told me,
but I don't recall. Better to have this written down, I believe.


>+
>+Channels distribution
>+=====================
>+
>+We distribute the channels between the different PFs to achieve local NUMA node performance
>+on multiple NUMA nodes.
>+
>+Each combined channel works against one specific PF, creating all its datapath queues against it. We distribute
>+channels to PFs in a round-robin policy.
>+
>+::
>+
>+        Example for 2 PFs and 6 channels:
>+        +--------+--------+
>+        | ch idx | PF idx |
>+        +--------+--------+
>+        |    0   |    0   |
>+        |    1   |    1   |
>+        |    2   |    0   |
>+        |    3   |    1   |
>+        |    4   |    0   |
>+        |    5   |    1   |
>+        +--------+--------+
>+
>+
>+We prefer this round-robin distribution policy over another suggested intuitive distribution, in
>+which we first distribute one half of the channels to PF0 and then the second half to PF1.
>+
>+The reason we prefer round-robin is, it is less influenced by changes in the number of channels. The
>+mapping between a channel index and a PF is fixed, no matter how many channels the user configures.
>+As the channel stats are persistent across channel's closure, changing the mapping every single time
>+would turn the accumulative stats less representing of the channel's history.
>+
>+This is achieved by using the correct core device instance (mdev) in each channel, instead of them
>+all using the same instance under "priv->mdev".
>+
>+Topology
>+========
>+Currently the sysfs is kept untouched, letting the netdev sysfs point to its primary PF.
>+Enhancing sysfs to reflect the actual topology is to be discussed and contributed separately.
>+For now, debugfs is being used to reflect the topology:
>+
>+.. code-block:: bash
>+
>+        $ grep -H . /sys/kernel/debug/mlx5/0000\:08\:00.0/sd/*
>+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/group_id:0x00000101
>+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/primary:0000:08:00.0 vhca 0x0
>+        /sys/kernel/debug/mlx5/0000:08:00.0/sd/secondary_0:0000:09:00.0 vhca 0x2

Ugh :/

SD is something that is likely going to stay with us for some time.
Can't we have some proper UAPI instead of this? IDK.


>+
>+Steering
>+========
>+Secondary PFs are set to "silent" mode, meaning they are disconnected from the network.
>+
>+In RX, the steering tables belong to the primary PF only, and it is its role to distribute incoming
>+traffic to other PFs, via cross-vhca steering capabilities. Nothing special about the RSS table
>+content, except that it needs a capable device to point to the receive queues of a different PF.
>+
>+In TX, the primary PF creates a new TX flow table, which is aliased by the secondaries, so they can
>+go out to the network through it.
>+
>+In addition, we set default XPS configuration that, based on the cpu, selects an SQ belonging to the
>+PF on the same node as the cpu.
>+
>+XPS default config example:
>+
>+NUMA node(s):          2
>+NUMA node0 CPU(s):     0-11
>+NUMA node1 CPU(s):     12-23

How can user know which queue is bound to which cpu?


>+
>+PF0 on node0, PF1 on node1.
>+
>+- /sys/class/net/eth2/queues/tx-0/xps_cpus:000001
>+- /sys/class/net/eth2/queues/tx-1/xps_cpus:001000
>+- /sys/class/net/eth2/queues/tx-2/xps_cpus:000002
>+- /sys/class/net/eth2/queues/tx-3/xps_cpus:002000
>+- /sys/class/net/eth2/queues/tx-4/xps_cpus:000004
>+- /sys/class/net/eth2/queues/tx-5/xps_cpus:004000
>+- /sys/class/net/eth2/queues/tx-6/xps_cpus:000008
>+- /sys/class/net/eth2/queues/tx-7/xps_cpus:008000
>+- /sys/class/net/eth2/queues/tx-8/xps_cpus:000010
>+- /sys/class/net/eth2/queues/tx-9/xps_cpus:010000
>+- /sys/class/net/eth2/queues/tx-10/xps_cpus:000020
>+- /sys/class/net/eth2/queues/tx-11/xps_cpus:020000
>+- /sys/class/net/eth2/queues/tx-12/xps_cpus:000040
>+- /sys/class/net/eth2/queues/tx-13/xps_cpus:040000
>+- /sys/class/net/eth2/queues/tx-14/xps_cpus:000080
>+- /sys/class/net/eth2/queues/tx-15/xps_cpus:080000
>+- /sys/class/net/eth2/queues/tx-16/xps_cpus:000100
>+- /sys/class/net/eth2/queues/tx-17/xps_cpus:100000
>+- /sys/class/net/eth2/queues/tx-18/xps_cpus:000200
>+- /sys/class/net/eth2/queues/tx-19/xps_cpus:200000
>+- /sys/class/net/eth2/queues/tx-20/xps_cpus:000400
>+- /sys/class/net/eth2/queues/tx-21/xps_cpus:400000
>+- /sys/class/net/eth2/queues/tx-22/xps_cpus:000800
>+- /sys/class/net/eth2/queues/tx-23/xps_cpus:800000
>+
>+Mutually exclusive features
>+===========================
>+
>+The nature of Multi-PF, where different channels work with different PFs, conflicts with
>+stateful features where the state is maintained in one of the PFs.
>+For example, in the TLS device-offload feature, special context objects are created per connection
>+and maintained in the PF.  Transitioning between different RQs/SQs would break the feature. Hence,
>+we disable this combination for now.
>-- 
>2.43.0
>
>

