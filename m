Return-Path: <netdev+bounces-176719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2CA6BA2A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7B2188FAC5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C021C9F4;
	Fri, 21 Mar 2025 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbAHt5Rf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BF1F91CD
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558040; cv=none; b=bthtjmgXRb3QdwhPEeDikzO64fhR4MqL8E8ob0vCUQS/yYjDHkpHy8KRoU/MWdoicrdZkrNSXDDRsx/+aPooW4WTG+Shkkf8IwBbv9ldflzqPudMXBmobeG5H40YsBsVERyAE6NhlhP68r36i+Gj2nzuxmNG6LuCA6IB5Hp+jZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558040; c=relaxed/simple;
	bh=C4DfuplG+QaUBoCfJtWluPTSb9soa9lq/2rOv6Z7LHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSlEwIlRWuiDG3kpoqLn8GsX/4ifNztBHhqiowJQGsWGQMU1pYo/jSVSMo0Ir8mnRzT2FJ+y57e3WP9+WP2msGRrzgUdHh7N3fhxHgRWOmhoPXnZxzeC1yGSB8MeSg38hOaSzVZPDlrumFSP93xk826QOkaV/QtaLd6ga1bHl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbAHt5Rf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jbWKOwn3ua+s5q0HkslFl9YIXMKQietnctinFs1CPS0=;
	b=RbAHt5RfIyqSBFzVAkS0AgSq24ZrQwDcSSAiym4YqHTwvmWD+tCYcml/hxOj2ounOjrsMR
	dFEcuA+OpKEbKy7U7Nt0/iqmXRAJ0kiQNa+I5xgBXcVF/SUCVoiqM3ZESRbXp6FnYuRghY
	GDFygofXV942eDTSdxkDnMinEG+ig2A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-Op_KIcOxP_68wZZxn0MWkQ-1; Fri,
 21 Mar 2025 07:53:52 -0400
X-MC-Unique: Op_KIcOxP_68wZZxn0MWkQ-1
X-Mimecast-MFC-AGG-ID: Op_KIcOxP_68wZZxn0MWkQ_1742558031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDE6919560AF;
	Fri, 21 Mar 2025 11:53:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86A43180175A;
	Fri, 21 Mar 2025 11:53:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 0/5] udp_tunnel: GRO optimization follow-up
Date: Fri, 21 Mar 2025 12:52:51 +0100
Message-ID: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Syzkaller and Nathan reported a few issues on the reference changeset.
This series tries to address them all and additionally does some little
cleanup.

See the individual patches for the details.
---
Should this prove to be too invasive, too late or ineffective, I'll be
ok with a revert before the upcoming net-next PR.

Paolo Abeni (5):
  udp_tunnel: properly deal with xfrm gro encap.
  udp_tunnel: fix compile warning
  udp_tunnel: fix UaF in GRO accounting
  udp_tunnel: avoid inconsistent local variables usage
  udp_tunnel: prevent GRO lookup optimization for user-space sockets

 include/net/udp_tunnel.h   | 4 ----
 net/ipv4/udp.c             | 5 +++++
 net/ipv4/udp_offload.c     | 9 ++++++---
 net/ipv4/udp_tunnel_core.c | 7 ++++---
 4 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.48.1


