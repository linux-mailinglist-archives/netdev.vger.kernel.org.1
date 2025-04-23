Return-Path: <netdev+bounces-185288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C460AA99AC8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E523A5A79DD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32F26FA5C;
	Wed, 23 Apr 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpmCZKDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F1826E17A
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443763; cv=none; b=h36AwwZZ0zWyo08sufJcxSmg9LWo2zypXUH3FSo8hEM4v8xgEJo6HRdtMUDNbbuggqdpCNUNMZRGTfy32kNgoq2Iu21oKhyGooSlTSC7Xekl7yWT7SFS9JFVSs1teL7Rx5paZQiEW8Y+6Km9ICuz/c4kWTODnEXcHOFXwXvN1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443763; c=relaxed/simple;
	bh=yBh/RmRUs+K6AiGD+JaXuuHDWVr09llB6PD0qB7GPN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq3YPWQtEIcUHAb56frODfdKmr6+mN0hOxO+/5bE4EkgiYNhEu0pMmDHOsjFd7T3ntAaTKqG93FdIJUg6B0gyjES08x7AsujSZW6cQ44vpJy5H3u80MEPhmeQled4iG1UdIsUN5nz4GdcYmO5OabImEy2i0ALiq8P54krNhMfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpmCZKDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E0C4CEE2;
	Wed, 23 Apr 2025 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745443762;
	bh=yBh/RmRUs+K6AiGD+JaXuuHDWVr09llB6PD0qB7GPN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cpmCZKDUXNgF0AD75tAOs5jiWgHPXF8fQdFL3NlkwsAah6HVlVXqR9lsf7H5jTboZ
	 rzO1TOTO+M8VZ2OQXD/RU0kV5gIeNjZjcb9vr0lJxKgFNNWpenKQ5bMKAMf/7mFzc+
	 ZshSrT9HehrtFa55ox9RHanckMSxjAKExMzIQYkidLYOGWuZzSUSjfv5u7GcVkbt5S
	 UyI9DsAYMKVP2m7l2esdPsFYO+x1tgo94oPNoWxOjHgHqX1J0Ba02lCPG2kcR5oDX1
	 GHJvm4OSouTUqS7sX+XjqsPAshPZNjDIKyUNiAmx/8OU/F5k3TyaAPSNfpn6ZxXuli
	 D7UtqpsyRAoqQ==
Date: Wed, 23 Apr 2025 14:29:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <andrew+netdev@lunn.ch>, <razor@blackwall.org>,
 <petrm@nvidia.com>, <roopa@nvidia.com>
Subject: Re: [PATCH net] vxlan: vnifilter: Fix unlocked deletion of default
 FDB entry
Message-ID: <20250423142921.089e58cf@kernel.org>
In-Reply-To: <20250423145131.513029-1-idosch@nvidia.com>
References: <20250423145131.513029-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:51:31 +0300 Ido Schimmel wrote:
> I'm sorry, but I only noticed this issue after the recent VXLAN patches
> were applied to net-next. There will be a conflict when merging net into
> net-next, but resolution is trivial. Reference:
> https://github.com/idosch/linux/commit/ed95370ec89cccbf784d5ef5ea4b6fb6fa0daf47.patch

Thanks! I guess this shouldn't happen often but FWIW for conflict-less
build breakage a patch on top of the merge would be more convenient
than the net-next version of the patch. Like this:

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 81d088c2f8dc..39b446a4bad7 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -628,7 +628,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
 						vninode->vni);
 
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		spin_lock_bh(&vxlan->hash_lock);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
@@ -636,7 +636,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+		spin_unlock_bh(&vxlan->hash_lock);
 	}
 
 	if (vxlan->dev->flags & IFF_UP) {
-- 
2.49.0


