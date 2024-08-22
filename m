Return-Path: <netdev+bounces-120855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8495B0A0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A18B27426
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1429185930;
	Thu, 22 Aug 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1CWFo0q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032317C7C8
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315625; cv=none; b=DyGsOCU6EM3eqqW+cnb6UDl7q0IR5gpIZHVjRwwzVnEiOoXJ7wMiSd9VUx1Rpsp/eyKEtVv+PmoZaKJcvZdylpVeWno5LvdZoNOt+WkPf4hSmakgw2xuIDUqDQXlZmuePqycNM+9LdoVjBBiRKG4yy+cZnL/xCHce8FJ6/GGE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315625; c=relaxed/simple;
	bh=Piq8X1uxWBJoeRivlCvKlfowfveNcsWWjVSwL+Um1Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4PHSlJmK0n3h7LHNh5RWjoUipyH084ys99gTvz6fM0U7RB2Hq/vwjrL6r0cga/H/aAVHZw4qcfjAn3x+96OLiWx5mxYzFxZgIjygDejnBfd2Z9OVw0ItGrZX1Y/ANcpe4Izu1a+qpwjI1vDgntxGAJUgqELCTP/4LYr6DUhb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1CWFo0q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-713edc53429so440425b3a.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724315623; x=1724920423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x6VkPAyU+cM/zEz1Pt2FTlfA4XlEA9ZsvYvCrUqUCE=;
        b=g1CWFo0qy1NVLo7CmXccurS/lAoSlqUvHSDjXy+Eq42oItWKAv/6XGd+6JDDMd7Xcd
         Yn8aSkHYMFKCnkCLNU4hvLAgJL2CEPwjdo8pX5Z+UYlLFXrkbOMrETPp6/m4rYybMsUc
         AFJabBVBPN6HR980c0uId7FDZmYHsjDUraXuSvbDHU19xv4RTV23SdzQPEb8chzi3aaf
         8uQMzzIvDn8oFhRcDw0uM3lOQNUj0pc3yFId9TFqngnw0wybLy+DSDdj4Ifir7a1JzQ2
         +iXS9kQOjbFlvaONyED8ZVeLwtODttUBhpvX/C9Cb0ga5NyyUfScX/cW/g7z+g3GUnCR
         CWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315623; x=1724920423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x6VkPAyU+cM/zEz1Pt2FTlfA4XlEA9ZsvYvCrUqUCE=;
        b=nbtsJlrBXKfoc3zFFTC1KP3v5H0tpDdUHbXAG2YWlNKPaIw4dEG/R9Lk71mfsDqEl7
         L+AxfR+GvM3qwN/66a4OPDWDzF076xkTc98QzsDgqVt24msxLKhHPgThF4MhOaTF8Hdv
         rRe7B6Y7wMhDB7p+xmDAJ1P7Qn/t84UMXq/ZIb6Krp5hYbjyO49bJXpyPgGUlBlIN2je
         c3wH+n6InRLs+PIr+hiwIKki4NqQ4MeGZqoJy/Hjhb2/kPMMuRBOjITtgIHJzMSKov6n
         /rm3HuAsysdWsECC3Wxc1pkmKhLiPoKBYY/c3Qw1TZOZlweYrpITuFz+ll1g1S4hLV3/
         qjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Rd4xdIWJIV9e1Ual9xXw97vmlcjlMiK+2rqiMZN0LoOK5yfYnTEFRZj0gnWCoEtxHLKsCoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2713Sqv90zr3mW6RZ8OaYsFAhwl87bPlLT2ToGPx9tU65Fsri
	3kPT3E0+67M+ghQ6TpJS/XIOhVA+GZ/gdlE+Ot06JaQSaawKges97GYjUzg7xZA5Dg==
X-Google-Smtp-Source: AGHT+IH8cwRNObidsFL4p3NVBneIkE+1Oj4W8ZX7UPMDDoB1Z+gC7ciVmp/dGgvMUD+mgdjQN1cpVw==
X-Received: by 2002:a05:6a21:6282:b0:1c4:8293:76db with SMTP id adf61e73a8af0-1cad80f3f35mr5561316637.29.1724315622934;
        Thu, 22 Aug 2024 01:33:42 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61393fbcbsm1116789a91.22.2024.08.22.01.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:33:42 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:33:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <Zsb34DsLwVrDI-w5@Laptop-X1>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
 <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>

Hi Steffen,
On Thu, Aug 22, 2024 at 09:10:47AM +0200, Steffen Klassert wrote:
> > Yes, thanks for the clarification. The SA is not changed, we just delete it
> > on old active slave
> > 
> > slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> > 
> > And add to now one.
> > 
> > ipsec->xs->xso.real_dev = slave->dev;
> > slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)
> 
> Using the same key on two different devices is very dangerous.
> Counter mode algorithms have the requirement that the IV
> must not repeat. If you use the same key on two devices,
> you can't guarantee that. If both devices use an internal
> counter (initialized to one) to generate the IV, then the
> IV repeats for the mumber of packets that were already
> sent on the old device. The algorithm is cryptographically
> broken in that case.
> 
> Instead of moving the existing state, it is better to
> request a rekey. Maybe by setting the old state to
> 'expired' and then send a km_state_expired() message.

Thanks for your comments. I'm not familiar with IPsec state.
Do you mean something like

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f74bacf071fc..8a51d0812564 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -477,6 +477,7 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	struct net_device *bond_dev = bond->dev;
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
+	struct km_event c;
 
 	rcu_read_lock();
 	slave = rcu_dereference(bond->curr_active_slave);
@@ -498,6 +499,13 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	spin_lock_bh(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		ipsec->xs->xso.real_dev = slave->dev;
+
+		ipsec->xs->km.state = XFRM_STATE_VALID;
+		c.data.hard = 1;
+		c.portid = 0;
+		c.event = XFRM_MSG_NEWSA;
+		km_state_notify(x, &c);
+
 		if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
@@ -580,6 +588,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
 		} else {
+			ipsec->xs->km.state = XFRM_STATE_EXPIRED;
+			km_state_expired(ipsec->xs, 1, 0);
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
 		}
 	}

