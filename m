Return-Path: <netdev+bounces-167717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6AA3BE5F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64394161DFD
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3E1DF974;
	Wed, 19 Feb 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4mGM4l6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27D1C8618
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969079; cv=none; b=TWH4PJ7VJaHxVaI0x6xyDjYbanbWdWeoub1X1p4RWgeOcg4zIkpiv7yqDk/wAOJCHvAmNUzEbVCWmiF9rWdxK2GhEcOUdewMGCJ/6dzuM+4EG+vNNEJHGd77SMJLXXeS1+OBTwLnays+crY6L+5RDaYiBN4P3HuB9tj6QokTLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969079; c=relaxed/simple;
	bh=uC/gbmuIbz9CfDD9QTJ9GPLub88c8NeckYlYWDb5Nj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj1uPDIMBAPrxHXrChW+3UiZG+9jIsZgJ/3NY3+wa5eLx3zZgzxfh79Dh2nxAlvlzpgP/h3KxFEkrz8aY4vPJs0L3sRlZ3VkTDXH1Es37rvRgRzqqpfD0xKW75vc1AjqJooxXqPGx/Jd4oeynlBEO3wAgwEm9EHtP7Xea9iWjXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4mGM4l6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22128b7d587so60981305ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 04:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969077; x=1740573877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veqQrnLC1vkTB8v0fR7bFysmPAsyll090YrIwI/WyGg=;
        b=D4mGM4l6REJ9vZw61rQ8n0PNeNBIneB0bosFOO6YUEuFI0XRRQ4B1+JPAhXJqtNosu
         OOu3z40VE15CpwdiH/Pc7ccJzP1JHWrm++M/PPpmVOwNn/bTanv1kQfUSS4Eg1fbU68B
         Dy7KTCz9wcDNqapH76mEzgxRKRxpN2RKSMaWmRvzEatEIs/VFZr7JmcM2QHjBbSmMTMQ
         paIwHF95m7t9gxspUcfZ3ibH6MpazfU1LLSGiFT53AKgdtKHG/bpX/N8+dy9bXUhwy8+
         H45cpc3EXCB5ZA3T1sHqRY0gRo7Hl/R3pZCbWs0L3QrYtSRcvE8z9FFUY3I5EmfAF/RT
         j34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969077; x=1740573877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veqQrnLC1vkTB8v0fR7bFysmPAsyll090YrIwI/WyGg=;
        b=HJs6HneiKH863J3sWlOYiU/ElQRyQ8eA5e3Z9YN927oNcn46daR2CGQu8wi2R+wYlu
         R/7KEX7nbMLkZJa7jwFBOfSp6AARN4q/E33IO9HI+V4z76gJV4j8lZzg9pL7ec7fHlcn
         9jydxNLcWPtqhyHx/dvCJYmC35qTvSgCdYj5PiTHypi4D/oNxQtz9Lif2jxtCpaU1zpF
         Gq3nlEmXZoIvkywyWPBKdMqMhNkv8W67UN7denVwQMAObrvLJJY4DQhp/yhrmx1hdULc
         f6FNBk/FxfzOgWTRK+mhIIqDspIpEsG4pyFlh3iuoT5zdDZ0EcPfjR79aGFPA26Qu5wj
         SjZg==
X-Gm-Message-State: AOJu0Yy5xilQFGvMcoQ1rq8NUg1KUDGCbZ6ZAoqe9aoLOPHdObja31MU
	K+CL/8U2q/DumsowqkftJ3hH2Nb1on7SWONZ0RGT/xY5K5KN4sCP
X-Gm-Gg: ASbGncsJLBSe5+z1cgaoyiA44NAZyQLzrHigMzWqZzijV46Jg/QUKtcNradT8DIHBEv
	z/b4fvsbnAzgfW0gyzy7mXYNbGTzxxecO6dvHIrQLT528GqBAKfB4dAbu5gExIRKJ71ooR0z5LE
	PGN/UcEv/rWsLTlS2jV8lNLj2Rjp1k7GOGl9OfIqPQ4zZjSuZZgajVfR3QNuufTuzOAUOdtq61w
	Y6ouW4ayegKJHLDFgOdvrBPgXP/v7mOsPTPzfASk57fd8DX6RdxE33rwWEq2N5O//hejwW+Zr5K
	rHJhiK9O3aKiC/8rlli+
X-Google-Smtp-Source: AGHT+IHOJTf5JjkMoAiF9726cdvTyRKLl9leBPJ0deGourTeYMJV4PJn9/RJkzDp8I7Ioy0Cx3sYJg==
X-Received: by 2002:a17:903:1d0:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-22170773856mr44879085ad.13.1739969076990;
        Wed, 19 Feb 2025 04:44:36 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556c857sm103517565ad.161.2025.02.19.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:44:36 -0800 (PST)
Date: Wed, 19 Feb 2025 12:44:29 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [Bridge question] Issue with removing MDB entry after enabling
 VLAN filtering
Message-ID: <Z7XSLZQWm-_B3zqT@fedora>
References: <Z7WnyC2eSFeb8CA_@fedora>
 <25fbccf1-38e9-455a-b114-da723041e413@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25fbccf1-38e9-455a-b114-da723041e413@blackwall.org>

On Wed, Feb 19, 2025 at 11:56:08AM +0200, Nikolay Aleksandrov wrote:
> On 2/19/25 11:43, Hangbin Liu wrote:
> > Hi everyone,
> > 
> > Our QE team reported that after adding an MDB entry, enabling VLAN filtering,
> > and then removing the MDB entry, the removal fails. e.g.
> > 
> > + ip link add dev br0 type bridge
> > + ip link add dev vethin type veth peer name vethout
> > + ip link add dev vethin1 type veth peer name vethout1
> > + ip link set vethout up && ip link set vethout1 up && ip link set vethin up  && ip link set vethin1 up && ip link set br0 up
> > + ip link set vethout master br0
> > + ip link set vethout1 master br0
> > + echo 1 > /sys/class/net/br0/bridge/multicast_snooping
> > + echo 1 > /sys/class/net/br0/bridge/multicast_querier
> > + bridge mdb add dev br0 port vethout1 grp 225.1.1.10 src 192.168.2.1
> > + echo 1 > /sys/class/net/br0/bridge/vlan_filtering
> > + bridge mdb del dev br0 port vethout1 grp  225.1.1.10  src 192.168.2.1
> > RTNETLINK answers: Invalid argument
> > 
> > From reviewing the code in br_mdb_del(), I noticed that it sets the VLAN tag
> > if VLAN filtering is enabled and the VLAN is not specified.
> > 
> > I'm not sure if the QE’s operation is valid under these circumstances.
> > Do we need to disable VLAN filtering before removing the MDB entry if
> > it was added without VLAN filtering?
> > 
> > Thanks
> > Hangbin
> 
> Hi,
> It seems you did not specify a vlan when trying to delete the entry after enabling vlan filtering
> so the bridge code tries to delete it from all vlans on the port and some of them don't have
> that mdb entry so you get the -EINVAL, but it should delete it from any vlans that have
> the entry.
> 
> In this case since the entry was added before vlan filtering was enabled it won't have any
> vlan set making it unreachable for a delete after filtering was enabled. It is a corner case
> for sure and TBH I don't see any value in adding more logic to resolve it (it would require
> some special way to signal the kernel that we want to delete an entry that doesn't have a
> vlan after filtering was enabled), instead you can just disable vlan filtering and
> delete the entry. So IMO it is just wrong config and not worth the extra complexity to be
> able to delete such entries.

Thanks, I agree this is a config issue and does not worth to fix.

Regards
Hangbin

