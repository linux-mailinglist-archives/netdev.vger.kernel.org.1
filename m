Return-Path: <netdev+bounces-181899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B384A86D50
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8538C2FD7
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B71E835C;
	Sat, 12 Apr 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R14Mxm9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF41E2852;
	Sat, 12 Apr 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464870; cv=none; b=CkYpKG25Gk/0EUZa3BmuR9DCe8P8mP+y2o4EvlLcKgl/FkaLfQpTrX7jwqyXqPTesXOFfr4FjAs/RQUd1j5GV3391txUgNGaVzQWuce3IEXR8Ltj6nN73wBBb4RK76zW9LTN/aDVXQwmXJoORvn/z5JqBm1GgaqxJ3d1UZ59Dog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464870; c=relaxed/simple;
	bh=NO3DxyBYoznn4Joy7NjNSpMDaDjRCQbpBwtMJpvWSGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToP0GtQjMtB1nnGuxYmnYrLhSNCjB76yNq4lLAisJY1r81LE+azUkhqWoHxkmex8fCgOKvQMxE92eXImtIDNXRIrdLOjNQavT1364/Fuw1G5TNt6RRCzKT8hk1RVUrHhpmZ7zu3AcuP1bQyIdPKpCQkYHRaaE0BKt5my16SVQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R14Mxm9f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c2688e2bbso280687f8f.1;
        Sat, 12 Apr 2025 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744464867; x=1745069667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WfJoT6PRSs94k/+btljFzIPdD4QWmfmkTqVitM7k/U4=;
        b=R14Mxm9fTuR2WMSYuG5b8qqwxD1uSEY8PpPkodcKr1qcRUBLfe4NEZPeRkBpTZFczd
         O9HR2Z397vVyIvOmSYCI6QfcGnydtxRS3FG/hGhHZ1kpHdJzap0xyn4yTGS9T3LCNR6C
         stPiLr8C6Pb7zb9dlHJlirJARGw4EuDK/K8sj2yy65i0Hm2HSSlTQP0/VU1ou//MZq6b
         jVCBZ4QBvO57thirvLMSFq1MiawtAW0lxO5sg9kXS4PQP5q0N7JYIMoVkDmwc7wh18pz
         kDfzX0gCTVnDycg3pH+2UZrLYmAIEneIL6y2wS+HRtyyTf2uagC4jkVu8H/CXGQyA7tu
         +vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744464867; x=1745069667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfJoT6PRSs94k/+btljFzIPdD4QWmfmkTqVitM7k/U4=;
        b=EvAYqTMskceUo/ulpZUzizx6EyQxJLwj4XV6mfaligoYAEEeBU0+NetTSbWn1GeUXd
         1J+hrhlaYufBIIyTp/VdXFIf0nZo/rEqqelVtrHFq6caesZajrgDXFs2B0+Qw/oMPFvf
         nXxvvGpSNFMb+6+urHBn+iSvkzN7QUb09Ojz7CDm76SoxZqNJJUDMmm3JXOlAs02BQmz
         jNsyTO+UdI0fNcFG+DOgIU8Wq7da3rQ07M+PQiv1bKCxeM3Gu+midvxc8jtD0fH9eahk
         loCe+Xlb7n7kFwf2jVAF738ZDfGFWZggnvfqd6wZnUmOtA9yK2H/Sjhpwo2T9drkvuMw
         0XKg==
X-Forwarded-Encrypted: i=1; AJvYcCXPuoEkKUdawhPvoOENEt0Vs61VInK8hd34MJ/rCwqsUtVoH82c6dFxZNCOCcHTGBLN9SMLb5gyDjbAbA4=@vger.kernel.org, AJvYcCXrI67sErk0sA2meGMs8Cnl6RlbLTCyAYdbYZ09xDBtzmgSK+SLSPk+frI3uLTBD3kkqROWUK5n@vger.kernel.org
X-Gm-Message-State: AOJu0YxquSZTSAjW7BbiWReIyZjSmQzi/IrCfO3mSiRwgOpK73z7O26O
	/XsZIcm3ihMsUvgVARzVFza55hNyfZ+1kG0UvW6Q7gWxH2hOeBBP
X-Gm-Gg: ASbGncuVnXug+UTz5H5Mvfso9eIa6itS9jIe6KJ5Tbgc0oxh6DBBfW7BIGfo1pVQx5K
	jKw6wyABXLQe5fVdClkbDyuHqI+pkCzLFmOuD0BTJ5mAAsDAzvmHlaoe5574BFJMpXqnm4i4WC3
	C41DQDLLAy8jxeFHQwgoP8BT4ZOLRqcSUEF3eHVN2e1qG9ULblrE4dKuaRTH1v94L/D/+2V4ILt
	lImiz83dI3lpylMMGQwGdPg3k+9k/LnSsdI0SD+DP9KAOI7EHDHQDRWY9qz1GtrgsyRU4AlzXi8
	4JLtJrc2xnTYe3d1haSkNk6r9nIU
X-Google-Smtp-Source: AGHT+IFbgobwEpxneS25gPpj0QOmulKDiFpAZ+O7Q8yZ2Fwz44EBlrgCDGaOiI2rP+iH4TAaMMJGlw==
X-Received: by 2002:a05:6000:1867:b0:386:3a50:8c52 with SMTP id ffacd0b85a97d-39ea521d69amr1869543f8f.7.1744464866659;
        Sat, 12 Apr 2025 06:34:26 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm123160565e9.32.2025.04.12.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:34:25 -0700 (PDT)
Date: Sat, 12 Apr 2025 16:34:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with
 flags
Message-ID: <20250412133422.xtkd3pxoc7nwprrb@skbuf>
References: <20250412122428.108029-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412122428.108029-1-jonas.gorski@gmail.com>

On Sat, Apr 12, 2025 at 02:24:26PM +0200, Jonas Gorski wrote:
> While trying to figure out the hardware behavior of a DSA supported
> switch chip and printing various internal vlan state changes, I noticed
> that some flows never triggered adding the cpu port to vlans, preventing
> it from receiving any of the VLANs traffic.
> 
> E.g. the following sequence would cause the cpu port not being member of
> the vlan, despite the bridge vlan output looking correct:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> $ ip link set lan1 master swbridge

At this step, dsa_port_bridge_join() -> switchdev_bridge_port_offload()
-> ... -> br_switchdev_port_offload() -> nbp_switchdev_sync_objs() ->
br_switchdev_vlan_replay() -> br_switchdev_vlan_replay_group(br_vlan_group(br))
-> br_switchdev_vlan_replay_one() should have notified DSA, with changed=false.
It should be processed by dsa_user_host_vlan_add() -> dsa_port_host_vlan_add().

You make it sound like that doesn't happen.

I notice you didn't mention which "DSA supported chip" you are using.
By any chance, does its driver set ds->configure_vlan_while_not_filtering = false?
That would be my prime suspect, making dsa_port_skip_vlan_configuration() ignore
the code path above, because the bridge port is not yet VLAN filtering.
It becomes VLAN filtering only a bit later in dsa_port_bridge_join(),
with the dsa_port_switchdev_sync_attrs() -> dsa_port_vlan_filtering(br_vlan_enabled(br))
call.

If that is the case, the only thing that is slightly confusing to me is
why you haven't seen the "skipping configuration of VLAN" extack message.
But anyway, if the theory above is true, you should instead be looking
at adding proper VLAN support to said driver, and drop this set instead,
because VLAN replay isn't working properly.

> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Adding more printk debugging, I traced it br_vlan_add_existing() setting
> changed to true (since the vlan "gained" the pvid untagged flags), and
> then the dsa code ignoring the vlan notification, since it is a vlan for
> the cpu port that is updated.

Yes, this part and everything that follows should be correct.

