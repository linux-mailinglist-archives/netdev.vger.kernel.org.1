Return-Path: <netdev+bounces-70562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FC84F89A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B256C1C20D58
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA176022;
	Fri,  9 Feb 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgbAkphE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4374E2F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492672; cv=none; b=J8N+dB/bwm+yRLLUrfycKRwu4s8sZqU/3l+8Ein9q5Bepxczn325jNwm2zODrSS9cKXjvgqzD/psYmt0HTb6qJ7z7UAx785ZY8fP6iAS43/b8FcVCp8CTJLXaYgZMRuuXLf+TSNDHlPKEq966yba64YJOBrruuFH/T5HxChIkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492672; c=relaxed/simple;
	bh=yqRZfaT/aFmHVE1C+mzohUpMCUmkqoM1dibTvbrSo1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxGuhpiiL94JO/CrVam8XDVg2F0T+8fbZmZ5OTIwdPd9vs1NYvYlS/ZF44pD/MjJr68ZkuUxmQumSzNIjwIlCQAfYvzwwD8s8bkOj+I7CJjMPdO1qHs64Rp5GyyowGptgg+byTTdM43BboXx6niY4fFh6cRxaavhH1UeK8IHB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgbAkphE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fc6463b0edso20987957b3.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707492670; x=1708097470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMQdeEI3cXZj9UDcbfVad9lPmYRqUHP5P87kBplWeDk=;
        b=lgbAkphELc2eFRTqNKDvt+5sm/GG0WtPTHyS0Tef8s4kyi9M3wFKyi4QBw91ISIYHa
         KRAIyrUbF+Db7CI4cMiw+lr3Llnv+vjPW1MpoAf50KFYkFX0kndV4MGFjARSMbffXWwb
         BCmSmgYQUzoJAN7YyBbMLW3wpt3z5Nv8eFW9WVrQuA6RvBcvcCroxN1CiS3dTwXiy52U
         k4C4/breY5wbqbuK0zUKVksBocYnR3mqkVr/UTOjMf7qemGpRvsvioG+ObUXhMmbC3Uc
         1ePMg3TTBPS7J2tOkt3YagnPES9Ku9c8MXdHxymj/GbkEZ5vY+p4ceBoLo+FiGCp9TuV
         0vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492670; x=1708097470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMQdeEI3cXZj9UDcbfVad9lPmYRqUHP5P87kBplWeDk=;
        b=g0nP8mS/6DK556Q2RjeqEduSyDvgGRAHwtHOGiKn8ouSCRGjwXVl6hChD/KkkWObpT
         ovZg8PAuxDnCpSrewIs0y0CwL74SXoCjPyU5adaf9aQ4Y218/yxtFPzQt25vx+t/m1Te
         qQAGXXDwiXAlM22VQckLLUZ4QmXfL2umvhPUVpIIevebcUf2xMvdoI2bpywZDjoGszJ/
         E+IxJH5EeIFCfMmcMaxwqkUc0++QZnNUptsKsWxufbWrMwclZVxxPucyWms0Utnm90I1
         2MRkIrxGp3lDbWvJayeDvTl4wh+xzKknG6U/nrZee9xGMoi/qBg19I01g41Mri+N5bsU
         jEBg==
X-Gm-Message-State: AOJu0YyimXvpAzg3WSUL22Ehjh07BeHT24cYEINOo1HKU/aW7a8oGWUC
	JFlnmYrUgTehO/9I025ciluskKRG4urhXA1FU+ORf4mOfvueSak3YUm2/OCsnf6D7N5R/Bsw5ag
	QSDSd+XL9mQ==
X-Google-Smtp-Source: AGHT+IHfy6kYGex1nybim4EIIHaayJDB+SNKO0E4AS+Eaxt+NYs81MwQYifbuuLT6XtV54FSYHJhCxvvQtqf5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:72a:b0:dbd:73bd:e55a with SMTP
 id l10-20020a056902072a00b00dbd73bde55amr56939ybt.4.1707492669958; Fri, 09
 Feb 2024 07:31:09 -0800 (PST)
Date: Fri,  9 Feb 2024 15:30:58 +0000
In-Reply-To: <20240209153101.3824155-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209153101.3824155-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209153101.3824155-4-edumazet@google.com>
Subject: [PATCH net-next 3/6] bridge: vlan: use synchronize_net() when holding RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

br_vlan_flush() and nbp_vlan_flush() should use synchronize_net()
instead of syncronize_rcu() to release RTNL sooner.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_vlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 15f44d026e75a8818f958703c5ec054eaafc4d94..9c2fffb827ab195cf9a01281e4790361e0b14bfe 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -841,7 +841,7 @@ void br_vlan_flush(struct net_bridge *br)
 	vg = br_vlan_group(br);
 	__vlan_flush(br, NULL, vg);
 	RCU_INIT_POINTER(br->vlgrp, NULL);
-	synchronize_rcu();
+	synchronize_net();
 	__vlan_group_free(vg);
 }
 
@@ -1372,7 +1372,7 @@ void nbp_vlan_flush(struct net_bridge_port *port)
 	vg = nbp_vlan_group(port);
 	__vlan_flush(port->br, port, vg);
 	RCU_INIT_POINTER(port->vlgrp, NULL);
-	synchronize_rcu();
+	synchronize_net();
 	__vlan_group_free(vg);
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


