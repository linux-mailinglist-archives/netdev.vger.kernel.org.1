Return-Path: <netdev+bounces-225242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A282BB90703
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82DF3ADF7D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681E2EC54B;
	Mon, 22 Sep 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JdA/jBH2"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B62877DF
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541045; cv=none; b=AZm5D7BeOMJY+foHJDjxywZDOlgYFExdN2wD1j1q6lnBNOqP4EcwyKdjv1iUJC2N5hIKb4BJPHBhflTvaXGEohxD3Ka2Q2zeoATtIlOEnhRV+BWQDINQK38TlvNu/nV5jh84/MrbXbeGv54WJifYtWyxJmQbc/+WzN67dGveJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541045; c=relaxed/simple;
	bh=8VTTPnn7tl6CrzHjrNE/YfE/snFy7eeAQw3NhIIBq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=hob1+Jy5jQ4IBs9QxsIRWUk3bZZYF5kFnD2PB+qE+Vw11nxaYWmmE7cnQ2UPAFk7b6KJRpN8mxdozVKvphuB04IIa6Ct5bVDT9xtnPKyavxmS9hHcR6BALK3SV2Hvd+/NWs/0VECpHzlV9313U99yGICY9YazLTSU0fczGDcNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JdA/jBH2; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758541043; bh=ehl5+t27O7RCiJKa2RedcznDCrR7yc1A+gVkxEZAdXA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=JdA/jBH2OsmejKkTZymh5LkocDETk7I15cp25VAqsfy/bK0yTcZ5u94O0DYxA3QsVIWHp4PfWraymv6yrmFQMzj0HvyEPfa5Yabv5oXM6MhKl1v7atJdiHSzc97xo0oh7VVOac8MV8fD66NBae88ha9CXJB/+mXLu8cDDhYMneKLglE3mcCSki0sx3p3sEqR2CDQYnLsAFOZ7ddfDRGh141BC3WYQRS6ylkSCs07HU576YVe0vkh63AFDHN4FgJ/wlSjzwTUZroLWt3xj+XKLD3VphX4N/bNDYwglDd1GWjDth1qYEzamu1MLxlHLk++jvCm1bHRklul/bMgQMCBZg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758541043; bh=+pyl8NfUicADw9xz6ZfgOEWbmITBrg1M8fknqWnOGqJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LQRui7Q2eM6SgdKbbzknO3tiIyi6BtJbXrAYW4A735BYAsZk6+XClPz0flP5rK/0RWPzHxdwc019XK7IJGvt1R+sZhC6lJs6u77bjNAMp36qyvf4W1w1sjCQb3IgDKPo9ZFmoRsNtw8iAre6Cf9i58J622DmJ8vAg5soZtHLy0og9FmBoVOYP8/xGyeqJbP2bd/4A44ucn5Jl5ixw3GdX8lU46gW1X9ebSabGM6ZDpQSaFMZ4ndajBSmHJvI2r+Lp6rUczceAhpiwzwuaVaW1qIKJ5abZiP3v7NUElLBmApjNa6fDEe9K5hfFEKMLp9Fvi3IXBEQOPDCSR99ocJwPQ==
X-YMail-OSG: 3_FkBaYVM1ntPo7M4p.ZwUyeK4hYl8cj31_q4220ukT.bLOO_ooNZCexvD_jLPA
 Lk6gd5iScStLaCkrcvImjUUOpoLmbAmq7jKEV84kx9OtIZqDph2uvacsMMYM7jPcDDIfjq12H.ui
 eN.3x_5EXNMzxRhV1zpbI4JguYCYMk2FOwObLhHLC8z7LMrVTbaimeH.04lfNQ4yDGt0JexVp4bv
 RCEao9YvwL9We4jlGkJKVcX0LYFus27J9AyMTK2NyUZFddJpaUECbqoOsX5DFppwe0T_dP1iwq0M
 y8l.6VUCUh0Lr3SCzsU9MmwmaUSWRD_qdWSFy3U27_qPcj8PietgpinsOcyeVraGYWouyASz1hr6
 ZXNcxBgwBMaDgVzd9WoYtFD16.ZoI4Kg4yFmQpIvWo8mmV16P49HekhR8S4sfaqW4WIcbDssgSqR
 khcQPIEZF.xUVqBbGmDGEMBWlt3M4uGQA_GMydWbHWK03jygirADhzFn5O5wDMwRu0LxnGroHRHp
 bc9Ped46gD8OLl4z4Fyrplz0qzKA4fHIqz4gVNlZpmhxPEg2uQFxE80M04bPN_5jUiMUA5tntfxI
 ZPLPHG06f1ogS9cx0gHdZJBs0POV0zJHx5XOalAj_jPJx6aIyZ8QALsNXlQTtS.OrhIuLxCk6ZgY
 oRqZkyIdmzfTbNItCAUrDkL9sS.oiWVcN_VL80wPk28PImntRlrtBxvc.5jqd3Q.5aLtMOMow1py
 cid.8QMx43ihorvcJPXe9dz_q4X1.94A.4wBZBJ_6rObHQ9HV3d7wYVYSFdOSPWrv.vqGPew7A8a
 Q1HS3Onx6uhaaK4oB7GY7IWZnl6sYsKewU8EFacj_GMae9gIy1cggZNyHcxr1D78qiFdts6qJMud
 0ZRp6Umftx4aoIw8z19Xz8.85Gl_emDKjgZVkccO68xlWKoWXxV9k8f1ecQz7B9hbPEsBe570Ve9
 pumUZuRuSM5YMuQ45SBA_NrGXBUTuRUY1KdxZj_iQ19owjhf_HYcQVCPb_YG2G5Taz4xFR_yGw_5
 83oomDkVWWJhBhZZiQA39rAFeSvCZB.kFqwfbxzrgLNu7kd.IkJVqe0vMurWLi0m32_xCxYYZHKJ
 Xb8b_n758oAmvuzPYmSD1dlYJTNEXPLtmLDPzf3c6TDg4f4XqlYyU_FAxvuIy0d9MF.Kz_OrsJKK
 ptaHGzexDP2JL0dMIwO6NYqANUNFhZRM1fDimDIndyHu1nNG8Wp9eluCmTi_Iicdb6J.RoNLmNqE
 Y_zNZU6Uzr6gRNWJWVsORYWmp5uBGIB9YbPDKVa1iXPLeYgHAhlyimBVuz3LDTtAYLUnhL7nazn9
 K_HWfynfmNxQVqebC1G9_j7Xq77JPuYwuh7upSxonH6byeAME67cYyavifEbOGQW260ZEFR_Zdna
 LLTK3sPhoNdqQSQzfC0oaPPNp61frkZz1vRqq6qpajNInhUWSdDuziMRQyopjLgKqejjQIs6gIf8
 iDqW9_XkiOVWBOKupkM8EcmV4tq_luk_rPHNv18Of4VSCY8WMu243VU5gTTl0ZgUozqIC4Ois.eo
 OuAeEQayEnwfrVjJmOq_Ie.NwkTKhCZGxRq4gSjJL5mis7AVH5f0ZNvoYcIwe6xzynunHh92Ezxk
 lopvlV63.6SLaNQ_Af8eAq7jWmGJejyPFm69pe8BpVEQQL2NsqHLJ_TFkT8V1zSqBr2hR3FigYJB
 Gk7n2oVVoV3H9BpxUnW8_s1H1YBHHJ.2wKll6m1HTgwv41jfNG2kI9om7_309TGtfGDa2OtsGWV9
 q6P0NSlG6ZZateLU5nrH.Uz1c4d.dQ_LJVuEezKIMF5_mI2hRGgFut1.zo6Hx8EYUlXophnGKyl4
 uJHGQ9BOH6S9gg25yy1RLG71wOQVPBqNHQ0eZDQWcaRKzXETfSD5WLdbzR54hvyl1OYG.cVluHCB
 vDlEfQrPQ1Y3qKg5mc4cEnQQkQR0tWT85YGQoXT3pG2ANmalt0JXPbkbK.i..afWyV.wKjFBLzU8
 WSqePYstphhj.l1QYj0EgLubpaUje9Hn0H_mdCB2MRUwacf.G8MVWNOs7fwyzFB9._MSevW_mTJb
 ed_qg.NwADP5FxZwFmBnUYm1V3EZs.eItpwRPigixcHMSejKkiZhuoVgWb0QmNDllJEx.JpGnKuc
 ziiQpAanyEfg0nic8f6qcfj7Aw9n5Qv1Lp7Nekw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: b005ffc3-6b19-4577-b996-14f1f683284c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Sep 2025 11:37:23 +0000
Received: by hermes--production-ir2-74585cff4f-4sjhz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca5bfbd718d89396be3325d48d68935b;
          Mon, 22 Sep 2025 11:06:53 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net
Subject: [PATCH net-next v3 0/3] net: tunnel: introduce noref xmit flows for tunnels
Date: Mon, 22 Sep 2025 13:06:19 +0200
Message-ID: <20250922110622.10368-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250922110622.10368-1-mmietus97.ref@yahoo.com>

Currently, all xmit flows use dst_cache in a way that references
its dst_entry for each xmitted packet. These atomic operations
are redundant in some flows.

This patchset introduces new noref xmit helpers and incorporates
them in the OpenVPN driver. A similar improvement can also be
applied to other tunnel code in the future. The implementation
for OpenVPN is a good starting point as it doesn't use the
udp_tunnel_dst_lookup helper which adds some complexity.

There are already noref optimizations in both ipv4 and ip6 
(See __ip_queue_xmit, inet6_csk_xmit). This patchset allows for
similar optimizations in udp tunnels. Referencing the dst_entry
is now redundant, as the entire flow is protected under RCU, so
it is removed.

With this patchset, I was able to observe a 4% decrease in the total
time for ovpn_udp_send_skb using perf.

Changes in v3:
 - Added implementation for ip6
 - Updated cover letter and commit messages

Link to v2: https://lore.kernel.org/netdev/20250912112420.4394-1-mmietus97@yahoo.com/
-- 
2.51.0

