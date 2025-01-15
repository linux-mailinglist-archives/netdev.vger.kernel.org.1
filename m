Return-Path: <netdev+bounces-158501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D48A1234D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E2F16CE8C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B42419FA;
	Wed, 15 Jan 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRJAAsPc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5C1E98FD
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942043; cv=none; b=ljkHg+gguWMaLWJn3x8e9Fr7MQNhogYOfzv0pPFLUoyP2owp87/M4tL3BmVFI51y2622eArTUqvPVaR9/mpPk7SWxJv7cNzEaI1zAM7tGmFDyQME5QxyCRSunzqXBldm3EBXPkw/lnb2/919G9GbmHxlg/zE3qvFOZoa6kXhx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942043; c=relaxed/simple;
	bh=dyuUmwPdkO/IPGx/w0UaJSriSepRxjHFONWHfYegitc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MqxnDSx3kKW9N2YM8hpFgzvzjCQp7QRGSR3jbJotupWARJHC0CK35GzzUKyxD+ulJ6J87gkpGpdu7PqKd8STAiygQGs2GYeQtamaGR6YEAmJssJu9yi9FHT+6ycI99nid8bd5BipPs2N59xFeLtpTWv22w+fvr50jOGV67PlHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRJAAsPc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736942040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EfdoBFtDZPuEJifano5RfvRXD7S+di6BDao6fLrY7qE=;
	b=dRJAAsPcFQ8jD+6WepaA7LhhNQGGFxDRDKjTKpr4dVBSvVK3Sk1V7SzEMRGOveaT5vVs1q
	r8Nuk1wL9iVckQUNs4WesptS9W7CMwWeH598HTkeB6LCwi+TzI+Zgqd0IHGNBuAdjrRMM+
	eD3/8nqUhzqGe7qD15SQm54Ue0GRwsw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-lw_oBRKxNByUkJOx_pV4Cg-1; Wed, 15 Jan 2025 06:53:59 -0500
X-MC-Unique: lw_oBRKxNByUkJOx_pV4Cg-1
X-Mimecast-MFC-AGG-ID: lw_oBRKxNByUkJOx_pV4Cg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43628594d34so36945705e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942038; x=1737546838;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfdoBFtDZPuEJifano5RfvRXD7S+di6BDao6fLrY7qE=;
        b=hJiWOVkcBBLeXRBvmx0n09tYXNiVAOIJ8puMoGcild4MHyPTZkY+aeJtVQm2I5fJq9
         A2zLGJu7mv/EFJ9qVpHOSOUgwv/aPJrvfrx76AuxGYvhIx/lmANoFVFKiRmzQ+DXY1GW
         XNtOQ1gnxSiEbfCotkSzT1UoPgE4TZnl3wsOkvIDGnTzC1g4TQ+rq/uvoWeQJvXLYLxy
         ZNqCDjX8Ay543T5HuAiL4YDYXH9Q8Ng/5f8uYNmwORIecU97we6UXMNYhxONrJZ10Dcr
         7dHoOIIvPgqRiNba5tRfaEsJjUDGE+VZ2ZVCOhoSw+LQgHKqsT2SyyIKjkfFs3gjac2t
         RjXQ==
X-Gm-Message-State: AOJu0YzKqkX/pWRFPQZAWSbW4BXv5Cw3fhasJuGY3IwHK7AR6LAg8HdR
	+8C9Enu8tHT2bVkN010baPy0RWNQPI8P9AWkBJuM/nLbVthLXaWId4n/H3vem3dbShYaSf4USfH
	CIhuXJm013kBahYzcAGU9c9f8VFiyy1Y7i3dFSYyTcYvluaPnCXkukg==
X-Gm-Gg: ASbGncto7aZW/4CeUklEiJsE2qlFGzBOQYPdLxkMRaHQXmuCXJhbgyN7rXkFj8S5xv6
	heDtH/sRtBPcgKB4zfC1fF+PnwrKE3gqITIvRMVcJFHYJfl7XB33plK1sp/VZzP7VRHbQmO5CLr
	Ji/HUpcKdwvao85mWOMPRJN1UcnWOMWpDyZpoTnOVuKgp/22bW2PvQ7Tx4c1cRoLz4676R1e2Tb
	43XdMP2WPuRaV6szKok7Mg6qu3gZyLgoPgsSWZTO2cfpJLu6kSvgULCeMGB5p3pIIGPzDQgVQOQ
	d3gpT5OfU7DjyrWQNrXCWB+2iM3nUF7rXJEq
X-Received: by 2002:a05:600c:450d:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-436e26932dfmr294150645e9.11.1736942038130;
        Wed, 15 Jan 2025 03:53:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPuoYgVTfuomr1i+xeeYwLkZlUkaNwX+RK0m6r9n+PgW5XZnw1Q1qw0n3rJ+o9irUw6S4Kjw==
X-Received: by 2002:a05:600c:450d:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-436e26932dfmr294150405e9.11.1736942037822;
        Wed, 15 Jan 2025 03:53:57 -0800 (PST)
Received: from debian (2a01cb058d23d6009e7a50f94171b2f9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9e7a:50f9:4171:b2f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c73e370fsm21064295e9.0.2025.01.15.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:53:57 -0800 (PST)
Date: Wed, 15 Jan 2025 12:53:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] gre: Prepare ipgre_open() to .flowi4_tos conversion.
Message-ID: <6c05a11afdc61530f1a4505147e0909ad51feb15.1736941806.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use ip4h_dscp() to get the tunnel DSCP option as dscp_t, instead of
manually masking the raw tos field with INET_DSCP_MASK. This will ease
the conversion of fl4->flowi4_tos to dscp_t, which just becomes a
matter of dropping the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/ip_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index a020342f618d..ed1b6b44faf8 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -926,7 +926,7 @@ static int ipgre_open(struct net_device *dev)
 	if (ipv4_is_multicast(t->parms.iph.daddr)) {
 		struct flowi4 fl4 = {
 			.flowi4_oif = t->parms.link,
-			.flowi4_tos = t->parms.iph.tos & INET_DSCP_MASK,
+			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(&t->parms.iph)),
 			.flowi4_scope = RT_SCOPE_UNIVERSE,
 			.flowi4_proto = IPPROTO_GRE,
 			.saddr = t->parms.iph.saddr,
-- 
2.39.2


