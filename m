Return-Path: <netdev+bounces-132471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA6991CCD
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E325282B9F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB241684A3;
	Sun,  6 Oct 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVCpO1Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D9249F9;
	Sun,  6 Oct 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197820; cv=none; b=o/OOiOA6ISSWHquXxoBHdoFw6Vw8x7CJH1Ck3KqOtx9P1PhnFtKf2FYkI0sv87ptclvj3496/8p/BkpL5Zex9dATW5xUjkl5r2EDj0JEzzLFoQKpCxwumO3DkRD3DTbTxaUJNxBNhd7de1WroVdrMl3TZ6UI7X3tQ3QbL2BE5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197820; c=relaxed/simple;
	bh=xmSEGfXWYYnrxahV/hxdM2xvbpsGMckUIHbpupwQeoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eA2O0ZsDoqOYlBv1LbUy0OJ/cOMO6Tl/DOV+NCXo3Z2sl9JaQNEzHI1YCNCDYWjooxTgqGI6PDOiTilMRWw4+U3oL82c5krY73xa36C+Yo3KI0MfFhfUJs1Ysr9f6++W3XUZ1UixWs01NhpwmRfEicxrdk9m+dGs9NCxbm8YOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVCpO1Ci; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b9b35c7c7so24199255ad.1;
        Sat, 05 Oct 2024 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197818; x=1728802618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=XVCpO1CiVx+jgyK9Sx3WOL3kD9QT+3D8k/zShPXQAsoH7zOfhsrOmIng7Tb9bYo5M6
         /zw+tn+ijhI1o/gw+tymdQ5Lg0Cu+9l069fj2az4C0PWoelAz6NhyMYqqWfewOi+G+Zs
         sJ42fdVcn7xG0pxO6BiB+66LxJx3ROL5tGAr5GOEOi+Kkz0BadwRBo1S8gw+NC8fQdpa
         MXSdbZlegJIe6DXoTEhI2kRsw6TSTkLu67JqSK+2wL8QLo/qnAjwYBZVuWCTx0QOZgPg
         JB5/NBmv7qRzBTvW2Oj2OtOwUFeUo7eZsOaXHSBxNA3XoOSHB4VInEPXl0z2phiH89YG
         otCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197818; x=1728802618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=CXFbFa09toaKOewRMO4xzhyWDiJiVUnMSQ9CeNXNy+gT2TiKIbSfgCpELcLhgBf8iy
         1VXZl04MeA2YrsZnCOPQBZkzUgrLGPoSr6dH4mEYk1Pl5nRfXnUfm/EqTGuBAb3jMwDj
         ESQqwWTXMhscMWWuxynpeeD6X9h4meiJInLXw9IChw9MGzz60TyZyfcHPgkUBrvMttmh
         gAAotJq5179T6pAbFaav6+bKlGZPwqpmNmXuT+Vt8omOsHDnEO6ti+ubW2ZMYtWYimza
         jbEw3WSLDN/rvFoJQ6/Rgo8q4ijHuMvDc3LCSCit0mW9IwpyqaNoJN7xmOTPBjlTVNaF
         lMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJR7SIMHTZ09PoxWnNaKEf4EYNP4dObzmhZE+2/IZamOaSGxukjgasyPiz9oerkb42pnNlbH+n@vger.kernel.org, AJvYcCW8KJdU5YkqgPJrHAnBgyAMd4a2MbaMuKYvNpjGlZp8w1pq0ZZIPo1PHGNxm3zHjjaJPArbzf2OQp4vB/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx1LG35nJrh6VSD22pj68z5mZSALjPild6CocxMcqFpzZyY+A
	F3puAOhnEcFajvCYHKXrZ+5NFGYGqC9nftEdAa17T+4kEsYkHlwi
X-Google-Smtp-Source: AGHT+IHRxM/eFfj7oV4FYggeajJH62XqNTw09SnTgpexKuFVTDOT95I0ZcVEeCQmRAFW2BKsoafDpQ==
X-Received: by 2002:a17:903:2450:b0:20b:2eb3:97ac with SMTP id d9443c01a7336-20bfdfe26e4mr103883825ad.24.1728197818333;
        Sat, 05 Oct 2024 23:56:58 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:56:57 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 02/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Sun,  6 Oct 2024 14:56:06 +0800
Message-Id: <20241006065616.2563243-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_inet_may_pull_reason() and make
pskb_inet_may_pull a simple inline call to it. The drop reasons of it just
come from pskb_may_pull_reason().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 include/net/ip_tunnels.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6194fbb564c6..7fc2f7bf837a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -439,7 +439,8 @@ int ip_tunnel_encap_del_ops(const struct ip_tunnel_encap_ops *op,
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
-static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+static inline enum skb_drop_reason
+pskb_inet_may_pull_reason(struct sk_buff *skb)
 {
 	int nhlen;
 
@@ -456,7 +457,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 		nhlen = 0;
 	}
 
-	return pskb_network_may_pull(skb, nhlen);
+	return pskb_network_may_pull_reason(skb, nhlen);
+}
+
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
 /* Variant of pskb_inet_may_pull().
-- 
2.39.5


