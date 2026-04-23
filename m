Return-Path: <netdev+bounces-280633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PgYJ8DJ6WnAkAIAu9opvQ
	(envelope-from <netdev+bounces-280633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:26:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF744DF53
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 668D43044A4F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995152EA731;
	Thu, 23 Apr 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="AMRS5U9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F02DE6F8;
	Thu, 23 Apr 2026 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928989; cv=none; b=L6Wsg0yXy3pVMrxRAoLF9h9CxMIsixDvr5RbYUjJPIaJS1WzS8WcAYpbDlqILW1sANskQQoS9ZiHHFgRnLOCXB6Gb7Kkgo5nV/eQXS7niCOLmnlNQh4hASkiVSWu8U/BMOi0s/4r8tDtDGU7KYo529Ik1wIAyK/lPbyTxVe4GJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928989; c=relaxed/simple;
	bh=rU5SFRDMxVUocEWkRBaTwnmlMCuQOyRV9Xszlm2djQY=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKiM/5AsxT/NLJr3xYYu9FPsHp9knPTkT22Cubbk4Q70i0Oc7RD9EAUPRPBpxqMpBYto2LHmW8pRKqSeBPlXZUOJXS70MON119En/TziWzVbrd6pyyjYNnT8VT81h5MSCHnYB8PgSoQKbtJOnjGVe0ktZ9YRFZOf0mirlRjqrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=AMRS5U9j; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776928975; x=1777188175;
	bh=YfI4kXOLAwVZfQy4tYll6QMphd3BqRNpbQf/vGRAJ8s=;
	h=Date:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AMRS5U9jSZCsIvAeAH9/lse6bYeUlkF3b+ovW0WuuGMRizrxjD5lY4gQ5w1icUn3y
	 jKjumGf8JSlpeqmHFE3YpOaf58HggBNEmMRbSfpOo+Nqf88ZXQmMB7+VuMkKMECqlI
	 BQbvrQ8C17Tx5vr70ssKpUBL9hglhBAtSKPGLj24uXMW9lUOl4nbLsEiNZZItdGYJd
	 4/489ZwMfUhjSWSh6t8JhdKA94uFncWaIM2zplaEMk8LE6SPbTsZ34XxEVvovLjB1W
	 ZAfD1hEi9Ot4sGZtEY0LefCYshxGTXOLktcdCV609xASaxGTaRytngS6isy63P15nk
	 bzPX23dJJY3pA==
Date: Thu, 23 Apr 2026 07:22:48 +0000
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
Subject: [PATCH RFC net-next 1/4] net: pse-pd: scope pse_control regulator handle to kref lifetime
Message-ID: <20260423-pse-notifier-decouple-v1-1-7d4856f686f6@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: a3ccc6cd4734ba283db894f3fd3911ccfe1c3737
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280633-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leavitt.info:email,leavitt.info:dkim,leavitt.info:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BCF744DF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__pse_control_release() drops psec->ps via devm_regulator_put(), which
only succeeds if the devres entry added by the matching
devm_regulator_get_exclusive() is still present on pcdev->dev at the
time the pse_control's kref hits zero.

In practice that assumption does not hold when the controller is
unbound while any pse_control still has consumers: pcdev->dev's
devres list is released LIFO, so every per-attach regulator-GET
devres runs (and regulator_put()s the underlying regulator) before
pse_controller_unregister() itself is invoked. Any later
pse_control_put() from that unbind path then reads psec->ps as a
dangling pointer inside devm_regulator_put() and WARNs at
drivers/regulator/devres.c:232 (devres_release() fails to find the
already-released match).

The pse_control's consumer handle is logically scoped to the
pse_control's refcount, not to pcdev->dev's devres lifetime. Switch
to the plain regulator_get_exclusive() / regulator_put() pair so
__pse_control_release() does the right put regardless of whether
the controller's devres has already been unwound.

No change to the regulator-framework-visible refcount or lifetime of
the underlying regulator: a single get paired with a single put. The
existing devm_regulator_register() for the per-PI rails is unchanged
(those ARE correctly scoped to the controller's lifetime).

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE frame=
work")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/pse-pd/pse_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f6b94ac7a68a..893ec2185947 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1362,7 +1362,7 @@ static void __pse_control_release(struct kref *kref)
=20
 =09if (psec->pcdev->pi[psec->id].admin_state_enabled)
 =09=09regulator_disable(psec->ps);
-=09devm_regulator_put(psec->ps);
+=09regulator_put(psec->ps);
=20
 =09module_put(psec->pcdev->owner);
=20
@@ -1431,8 +1431,8 @@ pse_control_get_internal(struct pse_controller_dev *p=
cdev, unsigned int index,
 =09=09goto free_psec;
=20
 =09pcdev->pi[index].admin_state_enabled =3D ret;
-=09psec->ps =3D devm_regulator_get_exclusive(pcdev->dev,
-=09=09=09=09=09=09rdev_get_name(pcdev->pi[index].rdev));
+=09psec->ps =3D regulator_get_exclusive(pcdev->dev,
+=09=09=09=09=09   rdev_get_name(pcdev->pi[index].rdev));
 =09if (IS_ERR(psec->ps)) {
 =09=09ret =3D PTR_ERR(psec->ps);
 =09=09goto put_module;

--=20
2.53.0



