Return-Path: <netdev+bounces-194766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807DACC514
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A701737A6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36822FE11;
	Tue,  3 Jun 2025 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WWejroh5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654B22F770
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949092; cv=none; b=maF7FzkTfduSWDF6lJnQ8WkSiKX+mBfg1e0EOQf6Nty1W5M7bhex2mobgq2lao6EDzvqVBqAc6EDBwD54sE/3W5mg0HKLzW2Cn5gXjmd3CWtZ8UVcgq8WHSM80ytvUd28Nefya7wlDLxc84uOvAPxgo+b9kAJn0kunLJzZXNwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949092; c=relaxed/simple;
	bh=gqLh+52oqi7gDnbmD2FbirtszvzAGsx5weaNNtnqBXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdLVL8khUsFryT6aF3EW2oZxcA1QazjHXkqYc/THapL8fzFFSdm1y9pfBxvyT0d9W07puY+UnIGA321eTmRiKjjcxIJIYbIruFJZV9fDrVa2mKXw0sK3EkHsR0wLvQEO5pFb3YLNpEaBjl5KQbwO2BcSVvFrd4j83fVmnUdUZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WWejroh5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so59957555e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748949089; x=1749553889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju9RtzOV72M1Fc5a6ppChOlnmzIFef6EhZo82EdUrxU=;
        b=WWejroh5vID/9bKQjU7j+ZvJ5telBuZe1FNA1nnUb8D5E5ZWOKHJk8JUiMfhPTScXm
         6rtcOrkPjeLjIaocCGdncOubGJhT4IMCFfvGrxJoZvz3SlwFSf/ht7idJNdqGtyXKLR4
         taBlELklqF6/BHRDh3zKfqS7c/81s4f6OE0zdW0lNl1Bsqe1PWUZZTwO6JbPleCOe3/2
         pNqHdrQ2V1BdVeqJgSHMMUcV69ZM79AdcC/rfuZI/2N0A3371bK35e4RjUBBu7kHFaAo
         LuIy4y8GFbxUorsPIk0I4kHrzM8FPmwAOZGAW/5+USo7arMhCboqlPC1yQ6Yco5KOueN
         OyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949089; x=1749553889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju9RtzOV72M1Fc5a6ppChOlnmzIFef6EhZo82EdUrxU=;
        b=M/5OkiZJHXh1NBO5izb/r2RgdBRBGl8V9jQxwjXHTLt4vrHlK8HohpHkXTZ+A2kGEV
         v7f9xDepwpabpGTx2aP6J33fEsCc9XOXuxddperYlEsaJd6je9zBnJljPHlrKeRjcirp
         Xexte+6Q+I0VMmpJPp082f5jXa7Daec25QGsLAQLWAQV9vHJ4G81hvtpDN6li++QfPv/
         Kv4eriaBJhl1GVsV/8OX1PVtasEmZyJ6KxUOoKYkygjrA9znITyDa4l/VyTUU3dehMJ8
         cnDlWuzpcY7GejNHixPvWTsYs1qagAxDMxzpBDD1C7EM9lqBkQd9gXuX+HEVj+MJtVO7
         OjoA==
X-Gm-Message-State: AOJu0Yz6jm9R+tSUY2BJdzFgCZCKkEqp+num0csnZzJ811qm89LmFZbi
	q+VNzdh0gJFQuUEymaU1VnSxIRnzFcjZTC8CPGwCL4iW6jlQROTpCUQd4jpR58zBy+oEl1PrKMv
	flExPkY47SS2Vx/GTcxPH0Mq+//BQ/NAj8cZ2mBdPNxBTx2lJdoZXra4Ssis/ctsC
X-Gm-Gg: ASbGncsdx+hBqZ4ENaIbrymgPpeMscQOdE1rnYznnRbxfmZsnwcutgT9Xp/ZJGQXh1L
	VHqGGcl78i2b04V5EEhlO6I5aanRy+9DqqMQT3C7ocef3qRUPNgSPHtK7lYCUqwYMt76OJmrcUx
	GPkSEEbj2pIpYHe2ASETx0LMHUq4pEMxfgplF1/FIgL5IvvPCU7gV3KQXu466E4l5e7yl5ECo6G
	f4ctF6kofHW9Xfpqmjfvon/wvaef/eLIG2U2x3nKg/DsO6ZUlI3VdAF8shEe97/Gwr/4eIu3Y0S
	gajZ8VRWimYbhPAvpDvcdSS0eVePSgaZ78hNVDxG/iss3tUQ92XnTGEs01LBBvPhdXEM8sHlb14
	=
X-Google-Smtp-Source: AGHT+IHSgl3QRATPXApsbsBOtpaz6Xcigz9JUivWQA2r9PFwnOZkJLX3/IseSsBtTPlabmlupRZyKA==
X-Received: by 2002:a05:600c:1d85:b0:450:d012:df7a with SMTP id 5b1f17b1804b1-450d658f5b5mr110098475e9.28.1748949088665;
        Tue, 03 Jun 2025 04:11:28 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm163244525e9.13.2025.06.03.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:11:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
Date: Tue,  3 Jun 2025 13:11:06 +0200
Message-ID: <20250603111110.4575-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
References: <20250603111110.4575-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When deconfiguring a UDP-tunnel from a socket, we cannot
call setup_udp_tunnel_sock() with an empty config, because
this helper is expected to be invoked only during setup.

Get rid of the call to setup_udp_tunnel_sock() and just
revert what it did during socket initialization..

Note that the global udp_encap_needed_key and the GRO state
are left untouched: udp_destroy_socket() will eventually
take care of them.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index aef8c0406ec9..f4d3bd070f11 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
  */
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
 {
-	struct udp_tunnel_sock_cfg cfg = { };
+	struct sock *sk = ovpn_sock->sock->sk;
 
-	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
-			      &cfg);
+	/* Re-enable multicast loopback */
+	inet_set_bit(MC_LOOP, sk);
+	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
+	inet_dec_convert_csum(sk);
+
+	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
+	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
+	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
+
+	rcu_assign_sk_user_data(sk, NULL);
 }
-- 
2.49.0


