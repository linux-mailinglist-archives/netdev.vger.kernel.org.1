Return-Path: <netdev+bounces-157137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA9A08FBB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B413A7AFC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E020A5D0;
	Fri, 10 Jan 2025 11:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8820ADC3;
	Fri, 10 Jan 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509850; cv=none; b=HzvyzM00zNM2Ff5IaDYzkyVpps5rbtZtYzgi1m0upGi08C8qsd4Ar02s4AyCbwdgZQHko5lUfR63haCHlptLKdZxbQ1UW0bkiDAc2efb6TmU0HJvBlPGJe27VahO8orCf6QeZOEzl1NMkQggXOo3UV4QBICJwG7h/9atPcyOCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509850; c=relaxed/simple;
	bh=H+I9WuSCmkoW3OSUxjg8dHl/jaDJasJmlfxUpGRx7aY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MsNwhR8Auo48gmsev8RhsvQt5JUpojWcXWtn5tnkgVA9eRijHeBNkLlaBi9fQgKko4c5glTa5Qs0ShPanArJOwrPmSWL8uyeWV8r5QPF6YiYa5G54JhBLdfl1Vo3Vy1InwW9hs1w86VPgyqW0jKgfbiA/j9eQM4qSuutRIzn9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9CAB848FC1;
	Fri, 10 Jan 2025 12:50:45 +0100 (CET)
Message-ID: <8ae86a4b-1c4b-48cc-b584-f61f4e13ac4b@proxmox.com>
Date: Fri, 10 Jan 2025 12:50:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Friedrich Weber <f.weber@proxmox.com>
Subject: Re: [ovs-dev] [PATCH net] openvswitch: fix lockup on tx to
 unregistering netdev with carrier
To: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 Luca Czesla <luca.czesla@mail.schwarz>, linux-kernel@vger.kernel.org,
 Felix Huettner <felix.huettner@mail.schwarz>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20250109122225.4034688-1-i.maximets@ovn.org>
 <f7to70fq5n4.fsf@redhat.com>
Content-Language: en-US
In-Reply-To: <f7to70fq5n4.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2025 18:05, Aaron Conole wrote:
> [...]
> 
> I tried on with my VMs to reproduce the issue as described in the email
> report, but I probably didn't give enough resources (or gave too many
> resources) to get the race condition to bubble up.  I was using kernel
> 6.13-rc5 (0bc21e701a6f) also.

Thanks for trying the reproducer! Sounds plausible that the resources
assigned to the VM make the issue more/less likely to trigger, and I
didn't describe them very well. Just in case it helps, I've just posted
a reply [1] with the QEMU command line I've been using.

[1]
https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053426.html


