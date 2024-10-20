Return-Path: <netdev+bounces-137269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9879A5404
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764E2825E8
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B30191F60;
	Sun, 20 Oct 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7OxQxO+"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265961F5FD;
	Sun, 20 Oct 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729427368; cv=none; b=mrr14WHo1Q5PCERUKf/VTXxzk58Fz5ENRK5vK7YLePNyu7bqwKbdzc2qI7D8bH+JcnwCKWVlMxc8BVYtje9X4jsoyskSWvKN25E0+dwpgikACffWHntZ+Wh0CbehP7CZL7bUBTtj0/dmFCKnlIoXgdyd6l1jERC2AM7Gl62Q+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729427368; c=relaxed/simple;
	bh=oK7VZ748YZzPlvjiEAflfk6kW/AiZBAXdWoti14V2vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEtQE9hEOAb2lV8Iv6JyHKTVFHIKSGJC9zeDibISEigKt3Hy2F0DcobHoLON+ZmLdqTlLJwgUKAF4kggZij2QeeqcDmiXx5Q1QeJWLgIH6jZm32yg9W0ikvKH0YSTn0pey2PZP74p0JVL/uHULlsr63C6amekYaZFVrZUlLc5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7OxQxO+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C59A13801ED;
	Sun, 20 Oct 2024 08:29:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 20 Oct 2024 08:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729427365; x=1729513765; bh=7c9ju46R6QyN1443WbFxMita+e/d
	5Edr3KeaNQmPjnE=; b=W7OxQxO+xOboy1uFXuZt2v+1seC0HNg3SRuRcZNc36jq
	5d6mnAKCmacchvOl/4B72UcDq04TK9SVJ1CgPCAeAGb6LoVGYLCIzEhLynbRqQk3
	tm+7vZZoRvGQ1raM8oweINlbXX/mEW3ZDJ0yJDZIWdleRPXT0b3zp2lsnd04ty+L
	fYtYVo6LaXqwpqbTgD6qqJbGkgZhqO8QTYedYOgZnERHBcBM3sOugkVGnSMz5JNY
	+nT0sziXuGQGsYgtV5hps7d+4vLkOuwboUytdhCE6DywMJIl+YOw5duODT9zxgEJ
	YKJLRkigN6qy7y1y9LMN+FZoB2RXpeGiXDSSlfA3uw==
X-ME-Sender: <xms:pPcUZ2ohHBgPVbNDkRas89oib3d_T5avJbotJYTEXCFPDQHstJlQlQ>
    <xme:pPcUZ0qSrYukrOGqhSPBzqu8NdY8VVYOwrVa8qX5yuY5GTxtD4UANJIuBYxt17t7H
    tz1LkVwmyvOplg>
X-ME-Received: <xmr:pPcUZ7Md7mlMwrUXvBdK2hHF9RD1aK22deRLMH02guxXqro315hIQY8nWUq_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephigrjhhunhdruggvnhhgse
    hlihhnuhigrdguvghvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:pPcUZ17j-OjwnTlDTEARwMnKh6-kwLfbxEYMd4cql93xeiKC3rCaNg>
    <xmx:pPcUZ14HKylRg_RrD98elqCKoyC_waYN1l-p-HU3RNDHQsxPxCj12g>
    <xmx:pPcUZ1gzf__nwf3M1zHVIzZ2i3iBjSaIWyftKr9JLNsdLAg6zyUDqw>
    <xmx:pPcUZ_59Bylivw0nDTWr2J_jtHQa_OZm0487qguo9rfgnGHNCFMcfg>
    <xmx:pfcUZyu13OZx96y9wyeYADZCbf5HXTagqdd6OOn22WzJtv-It-3IY3-1>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 08:29:23 -0400 (EDT)
Date: Sun, 20 Oct 2024 15:29:21 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
Message-ID: <ZxT3oVQ27erIoTVz@shredder.mtl.com>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018141233.2568-1-yajun.deng@linux.dev>

On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
> The vlan_qos member is used to save the vlan qos, but we only save the
> priority. Also, we will get the priority in vlan netlink and proc.
> We can just save the vlan priority using vlan_prio, so we can use vlan_prio
> to get the priority directly.
> 
> For flexibility, we introduced vlan_dev_get_egress_priority() helper
> function. After this patch, we will call vlan_dev_get_egress_priority()
> instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.ko.
> Because we don't need the shift and mask operations anymore.
> 
> There is no functional changes.

Not sure I understand the motivation.

IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shifted
and masked in the control path (vlan_dev_set_egress_priority) so that
these calculations would not need to be performed in the data path where
the VLAN header is constructed (vlan_dev_hard_header /
vlan_dev_hard_start_xmit).

This patch seems to move these calculations to the data path so that
they would not need to be performed in the control path when dumping the
priority mapping via netlink / proc.

Why is it a good trade-off?

