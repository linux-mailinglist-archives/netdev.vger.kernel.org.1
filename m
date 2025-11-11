Return-Path: <netdev+bounces-237695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA3C4F09A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF014E1CF5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7C257835;
	Tue, 11 Nov 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR9fUrmG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F71D6195
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878633; cv=none; b=rt0OlafFGGXXL6VlFHPMEwdQAISsRGWDnKhINu0ueDHXyG2yUzgB3DERaHZ3ZUxQ727C76B75DsUIZtPomOmDVqQS7TBm3iMY+9fi1HFSJvqb6/5KO+0/go4eD3EkoH8FuB1eEwrJzsX0onny/n6aHqRoNtvoiGgHp4Mn/PBSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878633; c=relaxed/simple;
	bh=sG7DrgZcENOFt8EEbeYmwh2il8wBSWaUlko7ut4lyvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhsTs4jKxw9Xy5R54NwEQLsyaArI9pWgu2m4sPbB5gMBTCFLdqH0aMxZzK6VmJMzS+Z7xBMUPZdSJqYIKhOW2TscOm60C12JBz4zzWDW/NSrBflo8aHNLZDPusX/hisQAPVns2iCUopijwi64rxhqjUHy6BZZH+0YVBhDxGEJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XR9fUrmG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762878630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNzMmSJFeBzKQS3kiZ8oturS936DtL1rzHsLdw2rOgY=;
	b=XR9fUrmG8jaXxoYZZqTul4X72XkFsUNknXyq7sy8Z6TUKIcouKlaJHQ1kJoiCrKl23/1Cr
	0lnAQV/kW9dsThptLhKHuZRqSoeZyvUIueXgaEYh1OATbA0kaV3MYBeYQbRUcg+R6F4jNs
	WvY4qpmUZzLciYCX9n1cK8AB6a45DBw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-AEAjUyvpMvmv4jcrqTl0eA-1; Tue,
 11 Nov 2025 11:30:26 -0500
X-MC-Unique: AEAjUyvpMvmv4jcrqTl0eA-1
X-Mimecast-MFC-AGG-ID: AEAjUyvpMvmv4jcrqTl0eA_1762878622
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 667941955D42;
	Tue, 11 Nov 2025 16:30:22 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44A851800297;
	Tue, 11 Nov 2025 16:30:19 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: liuhangbin@gmail.com,
	m-karicheri2@ti.com,
	arvid.brodin@alten.se,
	bigeasy@linutronix.de
Subject: [PATCH net 1/2] hsr: Fix supervision frame sending on HSRv0
Date: Tue, 11 Nov 2025 17:29:32 +0100
Message-ID: <4354114fea9a642fe71f49aeeb6c6159d1d61840.1762876095.git.fmaurer@redhat.com>
In-Reply-To: <cover.1762876095.git.fmaurer@redhat.com>
References: <cover.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On HSRv0, no supervision frames were sent. The supervison frames were
generated successfully, but failed the check for a sufficiently long mac
header, i.e., at least sizeof(struct hsr_ethhdr), in hsr_fill_frame_info()
because the mac header only contained the ethernet header.

Fix this by including the HSR header in the mac header when generating HSR
supervision frames. Note that the mac header now also includes the TLV
fields. This matches how we set the headers on rx and also the size of
struct hsrv0_ethhdr_sp.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Closes: https://lore.kernel.org/netdev/aMONxDXkzBZZRfE5@fedora/
Fixes: 9cfb5e7f0ded ("net: hsr: fix hsr_init_sk() vs network/transport headers.")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index fbbc3ccf9df6..1235abb2d79f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -320,6 +320,9 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	}
 
 	hsr_stag = skb_put(skb, sizeof(struct hsr_sup_tag));
+	skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	skb_reset_mac_len(skb);
+
 	set_hsr_stag_path(hsr_stag, (hsr->prot_version ? 0x0 : 0xf));
 	set_hsr_stag_HSR_ver(hsr_stag, hsr->prot_version);
 
-- 
2.51.0


