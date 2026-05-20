Return-Path: <netdev+bounces-289824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLFjAmZtDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F84589815
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0AF030BF7D6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CB3A7F45;
	Wed, 20 May 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbWnDmQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29F3A872D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264634; cv=none; b=YxQGikD/71tmC26yXn93hq6Im27KI8wVtmlGvr/AtDwEK/sfSMuuflEFbECn3dPHkFXHZgQt9MpjHUzNk4anYmIQ/AZ5wyz2Jdhhi8biB3yBh1RJiUwG+4Tt5R1huNDRqEBt2RD4CVtxUzyp/za9zw6tT0HvC2MT04Sw06IbSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264634; c=relaxed/simple;
	bh=oQK00aTYLUCPZk7LjkLs573X2Q/yJqcD48CEsM0ghWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmGI2lwbjF/towIRDiIp/vJw2Xf3yPJDZuwNQO5ko68fo0wtkMnvUw8SwGV9o9KMSaixiqepRif69VvUH92GCfoPVULrUOnvd0vBET9m4u26K+rI/RguQWOm2OXucnLBCge9b1nyArCHzGaWMpiv+PxUSRtnnFDK/6yeDTHsqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbWnDmQ5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd80b3aa13so28658985ad.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779264632; x=1779869432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQMvPggW1JJLFBNYh7U2UPVPXWL1+VWscKlQEhLFbKo=;
        b=nbWnDmQ5oE9CJtgHRe0NWV4NJp4XjN2AoEAPGLdZTGsOe5wMWecr/9tkbyjuYCPhkj
         fDMLaQ74eFGVY2etKPpz05g82qMnNDtIKoUw6ej71tTmFpNr5Wj18iJASlLPEwuPSeo8
         U7LAierwjvxydVuDV1bE9OdHoB2pLp7HOguf5pPsl6fBQEYCvfMbnUGkKHJl7OhRr71V
         UvqSBYZ+UODPB4qNiBVuW/g7KNdpvGcYg8OIPWhAkDM/K4TSqDuJLqNAXeqZvRl47Xq5
         4rnfQEIuja69CDgPA5MEi8xKGXq8x7G1RILKiJ9ZLPzizWddFAqS/kLDdYfDkDiQU2Yv
         Gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264632; x=1779869432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQMvPggW1JJLFBNYh7U2UPVPXWL1+VWscKlQEhLFbKo=;
        b=lhZ63JdstkszrWAAuPZF7FoXBrfqOKc/kPrYV/dLHriK5fv8rg3etFbesVRpA3/BJR
         lfYU0zTb7GTXJMOHU3dlRI4FZKe/6ALDiDp5XWwmqaKQaT3l6y49v1O4S2Y62dYIU3rB
         95MgesFuVyfH9vzjBp1nlxgeNP1oz8DrP/0Hgf9R8s4A48JJ5di7MO4Uvwq+MKUAzRxs
         q6KrmK7aUeR8IzvvwrUmxCvuGxEB7MpObKhCK7IGVdIW651BO1rEZ9/VOayH1WLF6t+L
         ARwaeuQbJKBysFEThdYUMBZdk9N89On6mEpqWF77vSmUSsk8CHqb3bb2B+9k3nQ6p/2u
         zejw==
X-Gm-Message-State: AOJu0Yxq/gDvU/RwvhZ4oFF5eKqTEu/AAin4Up79jEV74hJvOMYHTCVd
	sa292zN/re8REoriDUOvuIxrr/Cnji0nVzj4/HHDI268oaBpb68pZ5yWFJwTIxLb
X-Gm-Gg: Acq92OFhCfLt748mR269uEhe/TFFAAJsQ5pZrtmML8uZzFlDJPu4q0qSiiL/cEQ3Jic
	JIikMVLdahFeiEz/eI7IcsbV0NjP1BkM+PMtF/W2Rq0jLWkwsnhxOfWOcweYlppegTHVd4eObqF
	gteAuP3l6jUwOMYGT/3eVQkTp+DmZLWVhwKwPbVgF2T3NzL3Q4Z/Fcsf2GazKcZU/3aYA2H3uvy
	SxGNPtSVUVi+PjSz3ZNtNiEyM8+Ygt7o/NyujcA/D/dnG6hVFN2+ERafm0wo1MU/sIjyWPrkrp1
	fg7ZErDdC+S8kC+A9AkWIphBL0cmis4NVsftlK+tIQuQYqLbZN3zaeiYmUo9m8SMsA+maAr8Y6p
	2/Xt6TcwnuMVy+ebtOOLw0OjvOHZe3ipIHNP5iWpZHskOXRUijirDqDX90JHZD7c6VH32hwcDw5
	Oq6rMcgz9VftqeAISy8AWr
X-Received: by 2002:a17:902:eccf:b0:2be:3626:dd42 with SMTP id d9443c01a7336-2be3626e03cmr51404125ad.6.1779264631463;
        Wed, 20 May 2026 01:10:31 -0700 (PDT)
Received: from mincom1 ([14.67.155.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm211632735ad.68.2026.05.20.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:10:31 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH RFC net-next 2/4] bonding: replicate XFRM offload state across LAG slaves
Date: Wed, 20 May 2026 17:10:02 +0900
Message-ID: <20260520081004.2232091-3-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520081004.2232091-1-hurryman2212@gmail.com>
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289824-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 76F84589815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LAG bonds need to install the same IPsec/XFRM state on every eligible
lower device, but each lower device may return a different hardware
handle. Add a replicated bonding-private XFRM state object that stores
per-lower-device instances and handles.

Use the replicated model for 802.3ad and balance-xor with layer3+4
hashing. Install the state on every eligible running slave, capture each
lower handle, and roll back in reverse order on failure. Keep
active-backup on the existing single-lower path and expose a bonding
resolver for lower drivers that call xfrm_dev_state_lower_handle().

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/bonding/bond_main.c | 578 +++++++++++++++++++++++++++++++-
 include/net/bonding.h           |  29 +-
 2 files changed, 595 insertions(+), 12 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index af82a3df2c5d..66435de852e9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -455,6 +455,432 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
 	return slave->dev;
 }
 
+static void bond_ipsec_inst_rcu_free(struct rcu_head *rcu)
+{
+	struct bond_ipsec_inst *inst;
+
+	inst = container_of(rcu, struct bond_ipsec_inst, rcu);
+	netdev_put(inst->real_dev, &inst->dev_tracker);
+	kfree(inst);
+}
+
+static void bond_ipsec_rcu_free(struct rcu_head *rcu)
+{
+	struct bond_ipsec *ipsec;
+
+	ipsec = container_of(rcu, struct bond_ipsec, rcu);
+	kfree(ipsec);
+}
+
+static bool bond_ipsec_slave_has_xfrm_ops(struct net_device *real_dev)
+{
+	const struct xfrmdev_ops *ops;
+
+	if (!real_dev || netif_is_bond_master(real_dev))
+		return false;
+
+	ops = real_dev->xfrmdev_ops;
+	if (!ops)
+		return false;
+
+	return ops->xdo_dev_state_add && ops->xdo_dev_state_delete;
+}
+
+static bool bond_ipsec_lag_slave_has_ops(struct net_device *real_dev)
+{
+	return bond_ipsec_slave_has_xfrm_ops(real_dev) &&
+	       real_dev->xfrmdev_ops->flags & XFRMDEV_OPS_F_LOWER_HANDLE;
+}
+
+static bool bond_ipsec_lag_slave_ok(struct net_device *real_dev)
+{
+	return (real_dev->features & NETIF_F_HW_ESP) &&
+	       bond_ipsec_lag_slave_has_ops(real_dev);
+}
+
+static void bond_ipsec_lag_free_instances(struct bond_ipsec *ipsec)
+{
+	struct bond_ipsec_inst *inst, *tmp;
+
+	list_for_each_entry_safe(inst, tmp, &ipsec->inst_list, list) {
+		list_del_rcu(&inst->list);
+		call_rcu(&inst->rcu, bond_ipsec_inst_rcu_free);
+	}
+}
+
+static void bond_ipsec_lag_call_inst(struct xfrm_state *xs,
+				     struct bond_ipsec_inst *inst,
+				     bool delete_state,
+				     bool free_state)
+{
+	unsigned long bond_handle = xs->xso.offload_handle;
+	struct net_device *bond_real_dev = xs->xso.real_dev;
+	const struct xfrmdev_ops *ops = inst->real_dev->xfrmdev_ops;
+
+	if (!inst->lower_handle)
+		return;
+
+	if (!ops)
+		return;
+
+	xs->xso.real_dev = inst->real_dev;
+	xs->xso.offload_handle = inst->lower_handle;
+	if (delete_state) {
+		WRITE_ONCE(inst->added, false);
+		if (!inst->deleted && ops->xdo_dev_state_delete) {
+			ops->xdo_dev_state_delete(inst->real_dev, xs);
+			xs->xso.offload_handle = inst->lower_handle;
+			inst->deleted = true;
+		}
+	}
+	if (free_state && ops->xdo_dev_state_free)
+		ops->xdo_dev_state_free(inst->real_dev, xs);
+	if (free_state)
+		inst->lower_handle = 0;
+
+	xs->xso.real_dev = bond_real_dev;
+	xs->xso.offload_handle = bond_handle;
+}
+
+static void bond_ipsec_lag_call_state(struct xfrm_state *xs,
+				      struct bond_ipsec *ipsec,
+				      bool delete_state,
+				      bool free_state)
+{
+	struct bond_ipsec_inst *inst;
+
+	list_for_each_entry_reverse(inst, &ipsec->inst_list, list) {
+		bond_ipsec_lag_call_inst(xs, inst, delete_state, free_state);
+	}
+}
+
+static int bond_ipsec_lag_add_inst(struct xfrm_state *xs,
+				   struct bond_ipsec_inst *inst,
+				   struct netlink_ext_ack *extack)
+{
+	unsigned long bond_handle = xs->xso.offload_handle;
+	struct net_device *bond_real_dev = xs->xso.real_dev;
+	const struct xfrmdev_ops *ops;
+	int err;
+
+	if (!bond_ipsec_lag_slave_ok(inst->real_dev))
+		return -EOPNOTSUPP;
+
+	ops = inst->real_dev->xfrmdev_ops;
+	xs->xso.real_dev = inst->real_dev;
+	xs->xso.offload_handle = 0;
+	err = ops->xdo_dev_state_add(inst->real_dev, xs, extack);
+	if (err)
+		goto out;
+
+	inst->lower_handle = xs->xso.offload_handle;
+	if (!inst->lower_handle) {
+		err = -EINVAL;
+		NL_SET_ERR_MSG_MOD(extack, "Slave did not return an IPsec offload handle");
+		if (ops->xdo_dev_state_delete)
+			ops->xdo_dev_state_delete(inst->real_dev, xs);
+		if (ops->xdo_dev_state_free)
+			ops->xdo_dev_state_free(inst->real_dev, xs);
+		goto out;
+	}
+
+	inst->deleted = false;
+	inst->added = true;
+
+out:
+	xs->xso.real_dev = bond_real_dev;
+	xs->xso.offload_handle = bond_handle;
+	return err;
+}
+
+static int bond_ipsec_lag_add_sa(struct net_device *bond_dev,
+				 struct xfrm_state *xs,
+				 struct netlink_ext_ack *extack)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_ipsec_inst *inst;
+	struct bond_ipsec *ipsec;
+	struct list_head *iter;
+	struct slave *slave;
+	int err = 0;
+	int count = 0;
+
+	if (xs->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
+		NL_SET_ERR_MSG_MOD(extack, "LAG supports only XFRM crypto offload");
+		return -EOPNOTSUPP;
+	}
+
+	if (xs->props.flags & XFRM_STATE_ESN) {
+		NL_SET_ERR_MSG_MOD(extack, "LAG does not support XFRM ESN offload");
+		return -EOPNOTSUPP;
+	}
+
+	ipsec = kmalloc_obj(*ipsec);
+	if (!ipsec)
+		return -ENOMEM;
+
+	ipsec->xs = xs;
+	ipsec->replicated = true;
+	INIT_LIST_HEAD(&ipsec->list);
+	INIT_LIST_HEAD(&ipsec->inst_list);
+
+	/* Serialize with slave down/remove and LAG eligibility changes so they
+	 * cannot miss lower SAs installed before this state is published.
+	 */
+	mutex_lock(&bond->ipsec_lock);
+	if (bond->ipsec_lag_blocked) {
+		err = -EAGAIN;
+		NL_SET_ERR_MSG_MOD(extack, "Bond LAG XFRM state add is blocked");
+		goto err_free_unlock;
+	}
+	if (!(bond_dev->features & NETIF_F_HW_ESP)) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG_MOD(extack, "Bond IPsec offload is disabled");
+		goto err_free_unlock;
+	}
+	if (!bond_mode_can_use_lag_xfrm(bond)) {
+		err = -EAGAIN;
+		NL_SET_ERR_MSG_MOD(extack, "Bond LAG XFRM eligibility changed");
+		goto err_free_unlock;
+	}
+	rcu_read_lock();
+	bond_for_each_slave_rcu(bond, slave, iter) {
+		struct net_device *real_dev = slave->dev;
+
+		if (!netif_running(real_dev))
+			continue;
+
+		if (!bond_ipsec_lag_slave_ok(real_dev)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		inst = kzalloc_obj(*inst, GFP_ATOMIC);
+		if (!inst) {
+			err = -ENOMEM;
+			break;
+		}
+
+		inst->real_dev = real_dev;
+		netdev_hold(real_dev, &inst->dev_tracker, GFP_ATOMIC);
+		list_add_tail(&inst->list, &ipsec->inst_list);
+		count++;
+	}
+	rcu_read_unlock();
+
+	if (!err && !count)
+		err = -ENODEV;
+	if (err) {
+		if (err == -EOPNOTSUPP)
+			NL_SET_ERR_MSG_MOD(extack, "Not all slaves support IPsec offload");
+		goto err_free_unlock;
+	}
+
+	list_for_each_entry(inst, &ipsec->inst_list, list) {
+		err = bond_ipsec_lag_add_inst(xs, inst, extack);
+		if (err)
+			goto err_delete;
+	}
+
+	xs->xso.real_dev = NULL;
+	xs->xso.offload_handle = 0;
+	if (!bond_mode_can_use_lag_xfrm(bond)) {
+		err = -EAGAIN;
+		NL_SET_ERR_MSG_MOD(extack, "Bond LAG XFRM eligibility changed");
+		goto err_delete;
+	}
+	rcu_assign_pointer(xs->xso.upper_priv, ipsec);
+	list_add(&ipsec->list, &bond->ipsec_list);
+	mutex_unlock(&bond->ipsec_lock);
+
+	return 0;
+
+err_delete:
+	bond_ipsec_lag_call_state(xs, ipsec, true, true);
+	xs->xso.real_dev = NULL;
+	xs->xso.offload_handle = 0;
+	RCU_INIT_POINTER(xs->xso.upper_priv, NULL);
+err_free_unlock:
+	mutex_unlock(&bond->ipsec_lock);
+	bond_ipsec_lag_free_instances(ipsec);
+	kfree(ipsec);
+	return err;
+}
+
+static void bond_ipsec_lag_flush_pending(struct bonding *bond)
+{
+	struct bond_ipsec *ipsec, *tmp;
+
+	/* Caller must hold ipsec_lock to serialize with LAG SA add. */
+	list_for_each_entry_safe(ipsec, tmp, &bond->ipsec_list, list) {
+		struct xfrm_dev_offload *xso;
+		struct xfrm_state *xs;
+		struct net *net;
+		bool pending;
+
+		if (!ipsec->replicated)
+			continue;
+
+		xs = ipsec->xs;
+		net = xs_net(xs);
+		spin_lock_bh(&net->xfrm.xfrm_state_lock);
+		pending = hlist_unhashed(&xs->bydst) &&
+			  xs->km.state != XFRM_STATE_DEAD;
+		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+		if (!pending)
+			continue;
+
+		xso = &xs->xso;
+		list_del(&ipsec->list);
+		RCU_INIT_POINTER(xso->upper_priv, NULL);
+		bond_ipsec_lag_call_state(xs, ipsec, true, true);
+		bond_ipsec_lag_free_instances(ipsec);
+		call_rcu(&ipsec->rcu, bond_ipsec_rcu_free);
+
+		xso->real_dev = NULL;
+		xso->offload_handle = 0;
+		if (xso->dev == bond->dev) {
+			WRITE_ONCE(xso->dev, NULL);
+			xso->dir = 0;
+			xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
+			netdev_put(bond->dev, &xso->dev_tracker);
+			xfrm_unset_type_offload(xs);
+		}
+	}
+}
+
+void bond_ipsec_lag_begin_flush(struct bonding *bond)
+{
+	mutex_lock(&bond->ipsec_lock);
+	bond->ipsec_lag_blocked = true;
+	bond_ipsec_lag_flush_pending(bond);
+	mutex_unlock(&bond->ipsec_lock);
+}
+
+void bond_ipsec_lag_end_flush(struct bonding *bond)
+{
+	mutex_lock(&bond->ipsec_lock);
+	bond->ipsec_lag_blocked = false;
+	mutex_unlock(&bond->ipsec_lock);
+}
+
+static void bond_ipsec_lag_remove_slave(struct bonding *bond,
+					struct net_device *real_dev)
+{
+	struct bond_ipsec_inst *inst, *tmp;
+	struct bond_ipsec *ipsec;
+	bool removed = false;
+
+	if (!bond_mode_can_use_lag_xfrm(bond))
+		return;
+
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (!ipsec->replicated)
+			continue;
+
+		list_for_each_entry(inst, &ipsec->inst_list, list) {
+			if (inst->real_dev != real_dev)
+				continue;
+
+			WRITE_ONCE(inst->added, false);
+			removed = true;
+		}
+	}
+	if (!removed)
+		goto out;
+
+	synchronize_net();
+
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (!ipsec->replicated)
+			continue;
+
+		list_for_each_entry_safe(inst, tmp, &ipsec->inst_list, list) {
+			if (inst->real_dev != real_dev)
+				continue;
+
+			bond_ipsec_lag_call_inst(ipsec->xs, inst, true, true);
+			list_del_rcu(&inst->list);
+			call_rcu(&inst->rcu, bond_ipsec_inst_rcu_free);
+		}
+	}
+out:
+	mutex_unlock(&bond->ipsec_lock);
+}
+
+static int bond_ipsec_lag_add_slave(struct bonding *bond,
+				    struct slave *slave,
+				    struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev = slave->dev;
+	struct bond_ipsec_inst *inst;
+	struct bond_ipsec *ipsec;
+	bool have_states = false;
+	bool slave_ok;
+	int err = 0;
+
+	if (!bond_mode_can_use_lag_xfrm(bond) || !netif_running(real_dev))
+		return 0;
+
+	slave_ok = bond_ipsec_lag_slave_ok(real_dev);
+
+	mutex_lock(&bond->ipsec_lock);
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		bool found = false;
+
+		if (!ipsec->replicated)
+			continue;
+		have_states = true;
+
+		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
+			continue;
+
+		if (!slave_ok) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		list_for_each_entry(inst, &ipsec->inst_list, list) {
+			if (inst->real_dev == real_dev) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			continue;
+
+		inst = kzalloc_obj(*inst, GFP_KERNEL);
+		if (!inst) {
+			err = -ENOMEM;
+			break;
+		}
+
+		inst->real_dev = real_dev;
+		netdev_hold(real_dev, &inst->dev_tracker, GFP_KERNEL);
+
+		err = bond_ipsec_lag_add_inst(ipsec->xs, inst, extack);
+		if (err) {
+			netdev_put(real_dev, &inst->dev_tracker);
+			kfree(inst);
+			break;
+		}
+
+		list_add_tail_rcu(&inst->list, &ipsec->inst_list);
+	}
+	mutex_unlock(&bond->ipsec_lock);
+
+	if (err && have_states) {
+		slave_warn(bond->dev, real_dev,
+			   "failed to replicate IPsec SA, flushing bond states\n");
+		bond_ipsec_lag_begin_flush(bond);
+		xfrm_dev_state_flush(dev_net(bond->dev), bond->dev, true);
+		bond_ipsec_lag_end_flush(bond);
+	}
+
+	return err;
+}
+
 /**
  * bond_ipsec_add_sa - program device with a security association
  * @bond_dev: pointer to the bond net device
@@ -475,8 +901,15 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	if (!bond_dev)
 		return -EINVAL;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
+	if (bond_mode_can_use_lag_xfrm(bond))
+		return bond_ipsec_lag_add_sa(bond_dev, xs, extack);
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
+		NL_SET_ERR_MSG_MOD(extack, "Bond mode does not support IPsec offload");
+		return -EOPNOTSUPP;
+	}
+
+	rcu_read_lock();
 	slave = rcu_dereference(bond->curr_active_slave);
 	real_dev = slave ? slave->dev : NULL;
 	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
@@ -504,7 +937,9 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	if (!err) {
 		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
+		ipsec->replicated = false;
 		INIT_LIST_HEAD(&ipsec->list);
+		INIT_LIST_HEAD(&ipsec->inst_list);
 		mutex_lock(&bond->ipsec_lock);
 		list_add(&ipsec->list, &bond->ipsec_list);
 		mutex_unlock(&bond->ipsec_lock);
@@ -523,6 +958,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
+		return;
+
 	slave = rtnl_dereference(bond->curr_active_slave);
 	real_dev = slave ? slave->dev : NULL;
 	if (!real_dev)
@@ -540,6 +978,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	}
 
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->replicated)
+			continue;
+
 		/* If new state is added before ipsec_lock acquired */
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
@@ -568,6 +1009,19 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	mutex_unlock(&bond->ipsec_lock);
 }
 
+static struct bond_ipsec *bond_ipsec_find(struct bonding *bond,
+					  struct xfrm_state *xs)
+{
+	struct bond_ipsec *ipsec;
+
+	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->xs == xs)
+			return ipsec;
+	}
+
+	return NULL;
+}
+
 /**
  * bond_ipsec_del_sa - clear out this specific SA
  * @bond_dev: pointer to the bond net device
@@ -577,8 +1031,24 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 			      struct xfrm_state *xs)
 {
 	struct net_device *real_dev;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+
+	if (!bond_dev)
+		return;
+
+	bond = netdev_priv(bond_dev);
 
-	if (!bond_dev || !xs->xso.real_dev)
+	mutex_lock(&bond->ipsec_lock);
+	ipsec = bond_ipsec_find(bond, xs);
+	if (ipsec && ipsec->replicated) {
+		bond_ipsec_lag_call_state(xs, ipsec, true, false);
+		mutex_unlock(&bond->ipsec_lock);
+		return;
+	}
+	mutex_unlock(&bond->ipsec_lock);
+
+	if (!xs->xso.real_dev)
 		return;
 
 	real_dev = xs->xso.real_dev;
@@ -600,6 +1070,9 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
+	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
+		return;
+
 	slave = rtnl_dereference(bond->curr_active_slave);
 	real_dev = slave ? slave->dev : NULL;
 	if (!real_dev)
@@ -607,6 +1080,9 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		if (ipsec->replicated)
+			continue;
+
 		if (!ipsec->xs->xso.real_dev)
 			continue;
 
@@ -647,23 +1123,33 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
 	bond = netdev_priv(bond_dev);
 
 	mutex_lock(&bond->ipsec_lock);
-	if (!xs->xso.real_dev)
+	ipsec = bond_ipsec_find(bond, xs);
+	if (ipsec && ipsec->replicated) {
+		list_del(&ipsec->list);
+		RCU_INIT_POINTER(xs->xso.upper_priv, NULL);
+		bond_ipsec_lag_call_state(xs, ipsec, false, true);
+		bond_ipsec_lag_free_instances(ipsec);
+		call_rcu(&ipsec->rcu, bond_ipsec_rcu_free);
+		xs->xso.real_dev = NULL;
+		xs->xso.offload_handle = 0;
 		goto out;
+	}
 
 	real_dev = xs->xso.real_dev;
+	if (!real_dev)
+		goto free_ipsec;
 
 	xs->xso.real_dev = NULL;
 	if (real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev, xs);
-out:
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (ipsec->xs == xs) {
-			list_del(&ipsec->list);
-			kfree(ipsec);
-			break;
-		}
+
+free_ipsec:
+	if (ipsec) {
+		list_del(&ipsec->list);
+		kfree(ipsec);
 	}
+out:
 	mutex_unlock(&bond->ipsec_lock);
 }
 
@@ -674,7 +1160,17 @@ static void bond_ipsec_free_sa(struct net_device *bond_dev,
  **/
 static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 {
+	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
+	struct bonding *bond;
+
+	if (!bond_dev)
+		return false;
+
+	bond = netdev_priv(bond_dev);
+	if (bond_mode_can_use_lag_xfrm(bond))
+		return xs->xso.type == XFRM_DEV_OFFLOAD_CRYPTO &&
+		       rcu_access_pointer(xs->xso.upper_priv);
 
 	rcu_read_lock();
 	real_dev = bond_ipsec_dev(xs);
@@ -735,6 +1231,47 @@ static void bond_xfrm_update_stats(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/*
+ * xdo_dev_state_lower_handle implementation for bond-owned XFRM states.
+ * lower_dev is the slave selected by the lower driver datapath. Replicated LAG
+ * state is resolved from the bond private instance list. Single-lower
+ * active-backup state is resolved from xso.real_dev/offload_handle here because
+ * xfrm_dev_state_lower_handle() delegates all bond-owned lookups to bonding.
+ */
+static unsigned long bond_ipsec_lower_handle(struct net_device *bond_dev,
+					     struct xfrm_state *xs,
+					     struct net_device *lower_dev)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	struct bond_ipsec_inst *inst;
+	struct bond_ipsec *ipsec;
+	unsigned long handle = 0;
+
+	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
+		struct net_device *real_dev = READ_ONCE(xs->xso.real_dev);
+
+		return real_dev == lower_dev ? READ_ONCE(xs->xso.offload_handle) : 0;
+	}
+	if (!bond_mode_can_use_lag_xfrm(bond))
+		return 0;
+
+	rcu_read_lock();
+	ipsec = rcu_dereference(xs->xso.upper_priv);
+	if (!ipsec || !ipsec->replicated || ipsec->xs != xs)
+		goto out;
+
+	list_for_each_entry_rcu(inst, &ipsec->inst_list, list) {
+		if (READ_ONCE(inst->added) && inst->real_dev == lower_dev) {
+			handle = inst->lower_handle;
+			break;
+		}
+	}
+
+out:
+	rcu_read_unlock();
+	return handle;
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
@@ -742,7 +1279,25 @@ static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
+	.xdo_dev_state_lower_handle = bond_ipsec_lower_handle,
 };
+#else
+static void bond_ipsec_lag_remove_slave(struct bonding *bond,
+					struct net_device *real_dev)
+{
+}
+
+static int bond_ipsec_lag_add_slave(struct bonding *bond,
+				    struct slave *slave,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void bond_sync_slave_xfrm_features(struct bonding *bond,
+					  struct slave *slave)
+{
+}
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 /*------------------------------- Link status -------------------------------*/
@@ -6006,10 +6561,11 @@ void bond_setup(struct net_device *bond_dev)
 	bond_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
 
 #ifdef CONFIG_XFRM_OFFLOAD
-	/* set up xfrm device ops (only supported in active-backup right now) */
+	/* set up xfrm device ops */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
 	mutex_init(&bond->ipsec_lock);
+	bond->ipsec_lag_blocked = false;
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
diff --git a/include/net/bonding.h b/include/net/bonding.h
index edd1942dcd73..a581252b5b06 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -203,9 +203,24 @@ struct bond_up_slave {
  */
 #define BOND_LINK_NOCHANGE -1
 
+/* XFRM offload state tracked by bonding for one xfrm_state. */
 struct bond_ipsec {
 	struct list_head list;
 	struct xfrm_state *xs;
+	struct list_head inst_list;
+	struct rcu_head rcu;
+	bool replicated;
+};
+
+/* Per-lower-device instance of a replicated LAG XFRM state. */
+struct bond_ipsec_inst {
+	struct list_head list;
+	struct net_device *real_dev;
+	netdevice_tracker dev_tracker;
+	unsigned long lower_handle;
+	struct rcu_head rcu;
+	bool added;
+	bool deleted;
 };
 
 /*
@@ -259,8 +274,9 @@ struct bonding {
 	struct rtnl_link_stats64 bond_stats;
 #ifdef CONFIG_XFRM_OFFLOAD
 	struct list_head ipsec_list;
-	/* protecting ipsec_list */
+	/* protecting ipsec_list and ipsec_lag_blocked */
 	struct mutex ipsec_lock;
+	bool ipsec_lag_blocked;
 #endif /* CONFIG_XFRM_OFFLOAD */
 	struct bpf_prog *xdp_prog;
 };
@@ -325,6 +341,13 @@ static inline bool bond_mode_can_use_xmit_hash(const struct bonding *bond)
 		BOND_MODE(bond) == BOND_MODE_ALB);
 }
 
+static inline bool bond_mode_can_use_lag_xfrm(const struct bonding *bond)
+{
+	return (BOND_MODE(bond) == BOND_MODE_8023AD ||
+		BOND_MODE(bond) == BOND_MODE_XOR) &&
+	       bond->params.xmit_policy == BOND_XMIT_POLICY_LAYER34;
+}
+
 static inline bool bond_mode_uses_xmit_hash(const struct bonding *bond)
 {
 	return (BOND_MODE(bond) == BOND_MODE_8023AD ||
@@ -712,6 +735,10 @@ void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
 void bond_work_cancel_all(struct bonding *bond);
+#if IS_ENABLED(CONFIG_XFRM_OFFLOAD)
+void bond_ipsec_lag_begin_flush(struct bonding *bond);
+void bond_ipsec_lag_end_flush(struct bonding *bond);
+#endif
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.53.0

