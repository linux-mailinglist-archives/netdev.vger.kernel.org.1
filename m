Return-Path: <netdev+bounces-244886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2568CC0DAD
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED61309F4B2
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC1340DA7;
	Tue, 16 Dec 2025 04:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C532AAA1;
	Tue, 16 Dec 2025 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858072; cv=none; b=YOjYIMjggmGq2vByt7iLfRwLLQj60rZCoGkPm0GqeOYrkCsAxOwjuajgri/5TMr9r+DxtpeU9VHqF10aPQfrQloUxW7YAynOA/tt/OUDxOkKPuKebk7RII5awy2X/JGkdvC+4suAfQW6A5O0niqX6RGQdVfcAIdRsZMUbxhhCtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858072; c=relaxed/simple;
	bh=EZvTkRAjdIU/IPJv/vgWAi0ok3tdnH4oFkvjfN1JuJE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iWe/r58YPOK2U44CWUeCua0ThL/33kgtNBeOQLfTel7xy6V7dId/bxa8XQ+8XtOhWihfQGjg9Ge6CGXeZzZ7RYuRsMYqpUJ5E1mgRRm1sU13l6Y5HuqF99BVIlf/fhrneU9ELNexhk2jH/Au0yBqGZrSd8XEXnTc2+LbR+SaCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-a9-6940db05c48f
From: Byungchul Park <byungchul@sk.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	david@redhat.com,
	willy@infradead.org,
	toke@redhat.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next] ice: access @pp through netmem_desc instead of page
Date: Tue, 16 Dec 2025 13:07:23 +0900
Message-Id: <20251216040723.10545-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsXC9ZZnoS7rbYdMg9Z/xharf1RYLH+wg9Vi
	94UfTBZzVm1jtJhzvoXF4uv6X8wWT489Yre4v+wZi8X/W79ZLS5s62O1uLxrDpvFsQViFt9O
	v2G0uL30KpPFpcOPWCx+/5jD5iDgsWXlTSaPnbPusnss2FTqsXmFlsfiPS+ZPDat6mTzONlc
	6rFzx2cmj49Pb7F4vN93lc3j8ya5AO4oLpuU1JzMstQifbsEroxN09gKHrBXTF8zgaWB8TBb
	FyMnh4SAicS6TSfYYeyue//B4mwC6hI3bvxkBrFFBHQltnZNYe1i5OJgFmhmlrhw4SILSEJY
	wFfi2q+ZrCA2i4CqxP1lX5lAbF4BU4nZZ+5BLZCXWL3hADNIs4TAETaJuUf+MUEkJCUOrrjB
	MoGRewEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwFBdVvsnegfjpwvBhxgFOBiVeHg9/ttn
	CrEmlhVX5h5ilOBgVhLh7bhhlynEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2
	ampBahFMlomDU6qB0feBfeNkwd5HaknSB48W8ByeMHfXm80X853Ntb2WS09UW1JnzMa5uGbJ
	qzl2N2fvXfZjOXvAE6OqFu67BdO1t1ur9afxr+ZluM3/jr10Q7lBm+Gh3eqhOscYEk98PbFc
	61f85TvZN5dkf2VIZT0+KXN33RbXf2H/PebyPmDz7elaGeDqMtVfR4mlOCPRUIu5qDgRAPBj
	3QhRAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsXC5WfdrMt62yHTYEK/isXqHxUWyx/sYLXY
	feEHk8WcVdsYLeacb2Gx+Lr+F7PF02OP2C3uL3vGYvH/1m9Wi8NzT7JaXNjWx2pxedccNotj
	C8Qsvp1+w2hxe+lVJotLhx+xWPz+MYfNQdBjy8qbTB47Z91l91iwqdRj8wotj8V7XjJ5bFrV
	yeZxsrnUY+eOz0weH5/eYvF4v+8qm8fiFx+YPD5vkgvgieKySUnNySxLLdK3S+DK2DSNreAB
	e8X0NRNYGhgPs3UxcnJICJhIdN37D2azCahL3LjxkxnEFhHQldjaNYW1i5GLg1mgmVniwoWL
	LCAJYQFfiWu/ZrKC2CwCqhL3l31lArF5BUwlZp+5BzVUXmL1hgPMExg5FjAyrGIUycwry03M
	zDHVK87OqMzLrNBLzs/dxAgMvGW1fybuYPxy2f0QowAHoxIPr8d/+0wh1sSy4srcQ4wSHMxK
	IrwdN+wyhXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhhT
	dy7Oe12Sp29kNVH1nt/rptPKWpn+Kof9P9Y8rg7Ze+S/+keWxP1PlzdZCAtOEArmkA6aUyVl
	8830ZYrPxmuF3E1OLxc2Wm5b1XTB4/CkFRx/lG68u8e356tnQmEB65Rru91u7w38UHUo9sKr
	g0JyuaVJJ9bfXK/8/UFLbOWTq19/bfmROTNXiaU4I9FQi7moOBEAsyumdzgCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make ice driver access @pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 969d4f8f9c02..ae8a4e35cb10 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
 		rx_buf = &rx_ring->rx_fqes[i];
 		page = __netmem_to_page(rx_buf->netmem);
 		received_buf = page_address(page) + rx_buf->offset +
-			       page->pp->p.offset;
+			       pp_page_to_nmdesc(page)->pp->p.offset;
 
 		if (ice_lbtest_check_frame(received_buf))
 			valid_frames++;
-- 
2.17.1


