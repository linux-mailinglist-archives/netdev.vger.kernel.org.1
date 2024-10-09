Return-Path: <netdev+bounces-133943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E6997884
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D5D1C21074
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8577A185949;
	Wed,  9 Oct 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="C+pdU2PR"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCC145B2C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513207; cv=none; b=hnQGkUy8fWjbE+ol2ZHcDZPQenZfVOxBVdMVwv5YGcLLY0aoNBVeonM+GWTt/F4HdAIfQlU17ZbsWRwRR8x3KTR2gKnL8ZZFPdc/oL14Ao9JD8vzkWtG2o5Rn3dZ+h5udrcCIjjgZQkTazR8vjR7NVI6XEcs6kO+ZXvu0nFlFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513207; c=relaxed/simple;
	bh=y20pFWe5bz8pDWZrc5ifjlBq1aQea51l+Z0BBNA5bLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tPpTkg4Mkwzu7IQ3zR7mOJ+12kj90OPtiV+M98YUOuwHVYeob7h+cOxy52IUMje5kS+kWsESQkIGl3jeDp37tca2gVPXYUqTjJmGRGonEXwssdZpwrsb4mssD+vMg8qqwlrv9YRVXPKlpXwTl/v6sT800P2iH5JjtQUWb1zTKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=C+pdU2PR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sye8c-001i6U-2j; Wed, 09 Oct 2024 23:22:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=KfztzwfvgFK4GfnvzmV2UW/nnlWg1C2EdGrUazrp7Ak=
	; b=C+pdU2PR6ypCphnMxCFZLFUo4qj4BrqsU6J2zObjUfdPK5EaumioPjN9Hv2r4udilr0u3R08l
	VRP24FeicYm8UKR/tKIxeGCW7Lg93EwKwlLY4F1oEJcH0dD+gliqWT9C1Q31oJ314ya4mjAy4NvlN
	oV7GuWh0hymrwljauR1QaSC/nucutNlZfHXOQuhJLwtIFjB18fB0JIkSJlzzwTNU1me90E6qSBBbA
	IYQXwR5I7rsJwnzzRaBPgaQzdvPFy2BXx09DVzgi2+OM8qqDnIw7iFvWETMpFxzx+gjJtWUwZhzK8
	/72b6G9bgKjz5UT+/JDvBs7Od0S+/IQU3OETpg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sye8b-0004gs-Oc; Wed, 09 Oct 2024 23:22:29 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sye8Q-00EL6w-4B; Wed, 09 Oct 2024 23:22:18 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
Date: Wed, 09 Oct 2024 23:20:49 +0200
Message-Id: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHzBmcC/x3LQQqDQAxG4atI1g1kRNT2KqULO/6joeBIAiIM3
 r2Dyw/eK+QwhdOrKWQ41DVvFeHRUFynbQHrXE2ttF0QefLhOf446QnnlI0NsxqP/SADAsYoHdV
 3N9xJXd/03RN9rusPip0H4WwAAAA=
X-Change-ID: 20241009-vsock-fixes-for-redir-86707e1e8c04
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series consists of few fixes for issues uncovered while working on a BPF
sockmap/sockhash redirection selftest.

The last patch is more of a RFC clean up attempt. Patch claims that there's
no functional change, but effectively it removes (never touched?) reference
to sock_map_unhash().

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

 include/net/sock.h                      |  5 +++++
 net/core/sock_map.c                     |  8 ++++++++
 net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++---
 net/vmw_vsock/vsock_bpf.c               |  8 --------
 4 files changed, 24 insertions(+), 11 deletions(-)
---
base-commit: 94e354adf6c210ce79827f5affb0cf69f380d181
change-id: 20241009-vsock-fixes-for-redir-86707e1e8c04

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


