Return-Path: <netdev+bounces-281802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BW/Dsam8GlAWgEAu9opvQ
	(envelope-from <netdev+bounces-281802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4A484C93
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15EF131C5FF0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B03FF8B0;
	Tue, 28 Apr 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="0mkWO+3P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53A3F0ABA
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374615; cv=none; b=uWV8+NN7j+Jww4XJ2azdcEUVe2bZj6bdVAutmdPasHJNynu68anxtdPuPf4JE9oAkiN/U1+8f0vxwWnh8CMARO8LizEjatqBThP6q9mDryRewDt+YhaXH2IaCkkMs/wdomE8M2NrihlkwNWdKkCwp3YRKMellmp5HUMsOUODtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374615; c=relaxed/simple;
	bh=3XqS4aA1y9roSOcUi6mHTs40VlyveF0LeaRBE2YSip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0TISRpxYEtMzIxLlz1QMGPtP58nS4cje/lcAIkPd3ulw3ubPHbnEOF7/Ku8FMacxbfdDgGCmolfXf6D9ckUV0GYclti6nRNKgZeLWzS721EWo28Du1OBGjut+wrt1m4bslawYerTI5LZFsbwAtyxkp19AvhdCSyy8wJ0I6ovAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=0mkWO+3P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso77459655e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777374607; x=1777979407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1AkPynYqIymYpL+Gq8gW6WV8NTbD1Q/jdfJ1I78mNE=;
        b=0mkWO+3P71FoAkvpobSCLqJbVKVgFbNVU/4NuRVFQDf4n2v1edZRRKELmT6Ar5Dwgu
         6WPF6y3rHN+e7sMdr48PJWq624H1suSigbc0mfFbCeHmB5QV+7Ydp/iMRQvqaSzYKwQB
         ejelJG5UML1fcfEWDtWNPGgj22iq8Q+7pK1zayjWQf55Ph7wxyZn+NJCETp2ovNVIFT7
         2eBnTh1D/Wz6W6Ktdp8zFQMvOeLSC5KMBtPfEFZjbr9TdhFCRVIZ29yRZfjm7ChqDOU3
         rO6IZpM5P6x9BbYkBEnYqmvvHGCvkpIBxaBLnTdmQhUHcd/hUBKCZDqVKUYQ9F31PSCt
         buaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374607; x=1777979407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1AkPynYqIymYpL+Gq8gW6WV8NTbD1Q/jdfJ1I78mNE=;
        b=rS73QAgFeJ1/Vn4hvPnfDSxVpS48R9w/OXBf0SXHxUXc13/c7U6AFM2NegWjRFCdAl
         3p+C6a+feYzbAVeQ4TScjQVwsJB9avpIeA3FBJ94YnnzZpdorZK4Ch4Vc7MUCHmoK6MV
         tuctAmi3QCiU4L7+1gcJB5BJrJsIXoo2h6Uvakp1TCzeB4TnfGMT0aCBZzrYek2fLFgB
         SpwvmOVuCoEuEavHS1BEoXZr5LNA6Q2OrBL1FyFnyqrdZStFv3GRpX5OL3vbtcYesDFZ
         77T1ipdBQVVaT8eRwoCkNhSClTtQuJJ3fkmIYu9WBHdrC7stjP5Z9wu5/J4w8qrgxAQ3
         2UAg==
X-Gm-Message-State: AOJu0YxUbO3LvlwNmnW640nQ1bHCsCUOXg+R0VvUExiRgfcZmmELvV1u
	T9BfXPpY2Xz9QJxlAfPTCvEff69EfCr2yzYj8NTR0BtdUgniv+ic2XBHvoYNlAAZpqk=
X-Gm-Gg: AeBDiev5SVaVWrZwASJIZLhcHO4U3haTPTa4g5Q5fjgcI3Ay811w/eU/P72xVqOSSA9
	DG0zPYaU0Uf1iIvN4VSy91bnEaYImJSoopVxyF07kfiNZw5SxNOvvoPwBXe0di9c/B717WiOKXZ
	HBdYe6+8XalHhTM8UlgRWdPFr1LKHO7TgEH30SLyfYLRai42h3ft33A2DLVsIqYKfuVkp0q7hGE
	o96CYAPByDkq9XX3mJa5R2h6kEQRIPBG/L4/WzZkr2kQr5tRbAgVGuiGOSPPv18qywvoqgw2e3D
	q+98L2Q5PazUiIs4bX1sKSt3yAHDZvxkxAlSJJcTDbRuC8TIOmFNPVWslhhWvMyggEIlzXAXkb1
	aUXkjDGcZGkgjG028cQylkOEy0ui5vYn1DysTeculAv3sZZiOq9438X2RkZ5kT1zQ0PnWoar994
	XFwRPJwlQJX8+8ACmMUqjA27VmGEoJjD/6jImKduHJyQ==
X-Received: by 2002:a05:600c:3208:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48a77e64f4cmr23425765e9.20.1777374606361;
        Tue, 28 Apr 2026 04:10:06 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773aeb49sm48738645e9.4.2026.04.28.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:10:05 -0700 (PDT)
Date: Tue, 28 Apr 2026 13:10:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 1/2] devlink, mlx5: add init/fini ops for shared
 devlink
Message-ID: <afCU-3Xmole6v4X4@FV6GYCPJ69>
References: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
 <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
X-Rspamd-Queue-Id: 13A4A484C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281802-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,resnulli-us.20251104.gappssmtp.com:dkim]

Tue, Apr 28, 2026 at 11:09:11AM +0200, przemyslaw.kitszel@intel.com wrote:
>Add .shd_init() and .shd_fini() ops, that will be called for the first
>devlink_shd_get() (to initialize driver' priv data) and on the last
>devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>
>.shd_init() could return an error, which will stop creation of shd
>instance. The initializer also gets an additional, optional param,
>that driver could use for any needs.
>
>If any of the callbacks will need to get devlink instance, it could
>be accessed by shd_priv_to_devlink().
>
>Both callbacks are called with devl_lock held and devlink registered.
>
>Next commit will make use of the callbacks, another one will make use also
>of the non-null additional param (outside of this series).
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>first discussed at:
>https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
>
>Sashiko suggested to convert devlink_shd_create() to return ERR_PTR(),
>and propagate that up to the driver. It think it will just make code more
>verbose for not much benefit. And drivers could just store err if they
>want in the passed @init_param.
>
>---
> include/net/devlink.h                         | 26 +++++++++++++
> .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
> net/devlink/sh_dev.c                          | 39 ++++++++++++++++++-
> 3 files changed, 64 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index bcd31de1f890..5d3a1337bfa1 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -1586,6 +1586,30 @@ struct devlink_ops {
> 				    struct devlink_rate *parent,
> 				    void *priv_child, void *priv_parent,
> 				    struct netlink_ext_ack *extack);
>+
>+	/**
>+	 * shd_init: Shared devlink instance initializer
>+	 * @priv: shd_devlink' priv
>+	 * @init_param: additional param to pass to driver callback
>+	 *
>+	 * Called once when the shared instance is first created (by the first
>+	 * devlink_shd_get() call).
>+	 * Should initialize the driver's private data embedded in the shared
>+	 * devlink. May be NULL.
>+	 *
>+	 * Return: 0 on success, negative to prevent shared instance usage.
>+	 */
>+	int (*shd_init)(void *priv, void *init_param);

1. "param" has specific meaning in devlink context
2. You don't use the arg in driver

Care to drop it?

Otherwise, this looks fine to me. Thanks! (small nitpick below)


>+	/**
>+	 * shd_fini: Shared devlink instance finalizer
>+	 * @priv: shd_devlink' priv
>+	 *
>+	 * Called once when the last reference is dropped and the shared
>+	 * instance is destroyed. Should clean up the driver's private data.
>+	 * May be NULL.
>+	 */
>+	void (*shd_fini)(void *priv);
>+
> 	/**
> 	 * selftests_check() - queries if selftest is supported
> 	 * @devlink: devlink instance
>@@ -1651,9 +1675,11 @@ void devlink_free(struct devlink *devlink);
> struct devlink *devlink_shd_get(const char *id,
> 				const struct devlink_ops *ops,
> 				size_t priv_size,
>+				void *init_param,
> 				const struct device_driver *driver);
> void devlink_shd_put(struct devlink *devlink);
> void *devlink_shd_get_priv(struct devlink *devlink);
>+struct devlink *shd_priv_to_devlink(void *priv);
> 
> /**
>  * struct devlink_port_ops - Port operations
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>index b925364765ac..1b8b1ce7e72d 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>@@ -43,7 +43,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
> 	*end = '\0';
> 
> 	/* Get or create shared devlink instance */
>-	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
>+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, NULL, pdev->dev.driver);
> 	kfree(sn);
> 	if (!devlink)
> 		return -ENOMEM;
>diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
>index 85acce97e788..048a2a6adc9e 100644
>--- a/net/devlink/sh_dev.c
>+++ b/net/devlink/sh_dev.c
>@@ -34,6 +34,7 @@ static struct devlink_shd *devlink_shd_lookup(const char *id)
> static struct devlink_shd *devlink_shd_create(const char *id,
> 					      const struct devlink_ops *ops,
> 					      size_t priv_size,
>+					      void *init_param,
> 					      const struct device_driver *driver)
> {
> 	struct devlink_shd *shd;
>@@ -49,16 +50,30 @@ static struct devlink_shd *devlink_shd_create(const char *id,
> 	if (!shd->id)
> 		goto err_devlink_free;
> 	shd->priv_size = priv_size;
>-	refcount_set(&shd->refcount, 1);
> 
> 	devl_lock(devlink);
> 	devl_register(devlink);
>+
>+	if (ops->shd_init) {
>+		int err;
>+
>+		err = ops->shd_init(shd->priv, init_param);
>+		if (err)
>+			goto err_unregister;
>+	}
>+
> 	devl_unlock(devlink);
> 
>+	refcount_set(&shd->refcount, 1);
> 	list_add_tail(&shd->list, &shd_list);
> 
> 	return shd;
> 
>+err_unregister:
>+	devl_unregister(devlink);
>+	devl_unlock(devlink);
>+	kfree(shd->id);
>+
> err_devlink_free:
> 	devlink_free(devlink);
> 	return NULL;
>@@ -69,7 +84,12 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
> 	struct devlink *devlink = priv_to_devlink(shd);
> 
> 	list_del(&shd->list);
>+

Not sure why to add empty line here.


> 	devl_lock(devlink);
>+
>+	if (devlink->ops->shd_fini)
>+		devlink->ops->shd_fini(shd->priv);
>+
> 	devl_unregister(devlink);
> 	devl_unlock(devlink);
> 	kfree(shd->id);
>@@ -81,6 +101,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
>  * @id: Identifier string (e.g., serial number) for the shared instance
>  * @ops: Devlink operations structure
>  * @priv_size: Size of private data structure
>+ * @init_param: Passed to .shd_init() callback alongside driver's priv
>  * @driver: Driver associated with the shared devlink instance
>  *
>  * Get an existing shared devlink instance identified by @id, or create
>@@ -96,16 +117,17 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
> struct devlink *devlink_shd_get(const char *id,
> 				const struct devlink_ops *ops,
> 				size_t priv_size,
>+				void *init_param,
> 				const struct device_driver *driver)
> {
> 	struct devlink *devlink;
> 	struct devlink_shd *shd;
> 
> 	mutex_lock(&shd_mutex);
> 
> 	shd = devlink_shd_lookup(id);
> 	if (!shd) {
>-		shd = devlink_shd_create(id, ops, priv_size, driver);
>+		shd = devlink_shd_create(id, ops, priv_size, init_param, driver);
> 		goto unlock;
> 	}
> 
>@@ -159,3 +181,16 @@ void *devlink_shd_get_priv(struct devlink *devlink)
> 	return shd->priv;
> }
> EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
>+
>+/** shd_priv_to_devlink - Get devlink instance from shd_devlink's priv
>+ * @priv: Driver's priv data
>+ *
>+ * Return: pointer to shared devlink instance the @priv belongs to.
>+ */
>+struct devlink *shd_priv_to_devlink(void *priv)
>+{
>+	struct devlink_shd *shd = container_of(priv, struct devlink_shd, priv);
>+
>+	return priv_to_devlink(shd);
>+}
>+EXPORT_SYMBOL_GPL(shd_priv_to_devlink);
>-- 
>2.39.3
>

