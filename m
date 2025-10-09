Return-Path: <netdev+bounces-229106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD257BD83B0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 344504EB0D2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BB30F940;
	Tue, 14 Oct 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTLIt68X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678E30F937
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431299; cv=none; b=cqSB0kC4nQgI6CuiOvUVijpVRqG0spz0Seof7vvf0nUIIEe5tV1/rck1VS2bAjD9a8nB8QYDExo62pqIm86wMAY3UfGFizaG9BMpN2g65rhrjs8BMJAdOuSDE64q6NHjG3xTCxTRRgB0AB5y4Shrb8Y7P78njBYsSNmXvetV1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431299; c=relaxed/simple;
	bh=VQQ0cSA27uMDgoOksZ9nAA8/qTPIu0hBMexqjmJ6kwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezoagAntnbXM7wJeh7XdVs6hNTuZ8K1mHfk9NN3lYwdMZja30sh+ALtAMAGr2D47uVMG2IUiFzh1LsNQCt9BDhl4snFyf7vKeJG2DlrjTRYSNIAvrnglQwwiy2pJKIFjCthx+9QCLVROORkiEI+ctj+Gv7y+h61TklIz5T1K4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTLIt68X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760431296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g+5bhDzSA+Udc5qJjyVCOEZAN6FwwM9bAyimGF6b+f0=;
	b=VTLIt68XJFcBGoOk4QiOID1QEZMojU6n7D0dfRWMOGrH2BDk6XWOzF/ICGwmRRlb7Ksbu4
	5Sqd7E1nqIc93od/wJ0NFt6ItGSBUhzgdz4YnbiZAwFfiQfSMuZaE2NlQecDWmsFNQdLfs
	5kIOpTcWM44v2/gEJWOSRs/SyOhVAms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-iFG2ai3bNhGcMraI2mrl1A-1; Tue,
 14 Oct 2025 04:41:32 -0400
X-MC-Unique: iFG2ai3bNhGcMraI2mrl1A-1
X-Mimecast-MFC-AGG-ID: iFG2ai3bNhGcMraI2mrl1A_1760431291
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95EE1180057B;
	Tue, 14 Oct 2025 08:41:31 +0000 (UTC)
Received: from fedora (unknown [10.44.34.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85A601800577;
	Tue, 14 Oct 2025 08:41:29 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jan Vaclav <jvaclav@redhat.com>
Subject: [PATCH v3 net-next] net/hsr: add protocol version to fill_info output
Date: Thu,  9 Oct 2025 23:09:08 +0200
Message-ID: <20251009210903.1055187-6-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, it is possible to configure IFLA_HSR_VERSION, but
there is no way to check in userspace what the currently
configured HSR protocol version is.

Add it to the output of hsr_fill_info(), when the interface
is using the HSR protocol. Let's not expose it when using
the PRP protocol, since it only has one version and it's
not possible to set it from userspace.

This info could then be used by e.g. ip(8), like so:
$ ip -d link show hsr0
12: hsr0: <BROADCAST,MULTICAST> mtu ...
    ...
    hsr slave1 veth0 slave2 veth1 ... proto 0 version 1
---
v3: Changed after discussion so that IFLA_HSR_VERSION is filled
    only when the protocol is HSR (and not PRP, since setting
    the version is prohibited if the protocol is PRP).

v2: https://lore.kernel.org/netdev/20250922093743.1347351-3-jvaclav@redhat.com/

v1: https://lore.kernel.org/netdev/20250918125337.111641-2-jvaclav@redhat.com/

 net/hsr/hsr_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b12047024..4461adf69 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -166,6 +166,8 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
+	else if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
+		goto nla_put_failure;
 	if (nla_put_u8(skb, IFLA_HSR_PROTOCOL, proto))
 		goto nla_put_failure;
 
-- 
2.51.0


