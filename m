Return-Path: <netdev+bounces-291566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK7vNI1PFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B25D1DAA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF6F301F1B8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22013CC33F;
	Tue, 26 May 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="B62lJTWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81433803F8
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781500; cv=none; b=YcGotAMXohrHC/HYpHyGsPtKwGxWRi+Ok3GR8WEHKbXq5kE0PsJW/HsNYZo5KxVAT5MBCGXNLRwE3/13E15L7HeiOqb+HcGga+LPnen29m6KF63tvI7kkaAJcGAMSRWFW5g/W6vbey0ry09JBT/fYqUShFlBBbXNlN3CLivZs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781500; c=relaxed/simple;
	bh=HOIrj5sgGXq3c+j31QIdduCco4yj8GtAwZ85IMokvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJTqD3aFAjQhdkw77/u4cvY/Xu+gsaO6ge/LtAOlw1MhmQ6OlmLh5bgIgYxiHC+cVmQeLTLyzZe7jqfYaOa67wzN+knmGLQmc3v7zC3svrVWlglLebvS2L/6XTIIPrrKlEhk2T7HtgaAf7yahHyWnSj/MIdHH/HsBNvlExLBnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=B62lJTWu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44e1860558fso6534078f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779781496; x=1780386296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meQXJPGH/eSRep/h9BO6zFwy/e970wDOwhGQTQCudGw=;
        b=B62lJTWuXw+j/rjl9d2vdf1PQlB9LhWCYyJSGP0OmkcmwHP1rhVO+nWHNWBvbNCtYU
         v9A6vmaZFI40/kj4kFl5egR8L8rB583INKQej7us+23x7TyhHxOrGdjUJrkT8SOqpDoI
         4yN4bCFicyf1jr7wOwCt3Gj2RE2peSDCn0wU8a7xy3QpkschwG0StKQW81ho/GMtVqQf
         4DpI38GAl/ezkfJ6FcaOvzC3K2O7S2MYOHYnqq3VNvTsoM3O9A14YhucDRkSJmCQl6Ie
         ExNH4kCGxdcZBqfmfrKzGCWJ570e/WpI2SPUGv5VnJ1t1gl0FtMJsgWRc+EV2bGhkq1Y
         vAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779781496; x=1780386296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meQXJPGH/eSRep/h9BO6zFwy/e970wDOwhGQTQCudGw=;
        b=YTsCe3Qf1XArDC4xF/xL1m5BKdtJ+5kBOWxDtNj9iewy5mcD86fd58geRgWOW2llD2
         MKVEcz7WdMKx/8vREWMRYsRqLG6PgzXrrUd35CEir3kkZlPT5PjuGqpKfFe7FYQAPs4v
         dEu6d1236/JVHwY/M2uSxMMFgq3J1jFJOfIY06tG9exl5qXMJ/meiRq2IQ72TsjnFmgh
         d/sX7twnprDaiewkUDZuXKDYt1mc2Y47git2tPuZBimbrBC3t3QrszkSJ3TSV2sjAzzx
         DWq0HAR1dhcKYyRjqhsSRu1tO0q4K1NOxbNjzTLmua9fHDStGtlyLbaGvcj49tQNNgiR
         FZ5w==
X-Forwarded-Encrypted: i=1; AFNElJ/oAMPHI/g6d5U8Fihb+E6QiX9D7YDcsygAZPz+a57Vdkso23qQKDirubqrAySrXP5UrjiPSrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2qhzkSAStYZY3jUF1jzo9MoQcSAiiCV2gTjK5/rZZhdg0d32
	KkyUm/J17KV9ftEkZMw0MAkhQNCn5KvF8GTPaiw8ASio8H4FTln5fZ/N7cxBFRprOY8=
X-Gm-Gg: Acq92OHRHgzlI8EhxB7ji/xKHf7wyqRYAXj8ZFdKA+iE0SSKjSc9pnZ6av1Lql1IQ93
	xkSKCOBNkMDZe/Ii2KnF59YowBubRplhwBedgc6Px8y3Pepu10ZN+CpLQJK+eSPKAjLKjJByQYz
	nqLl2qajtQwjr8WN/wZLeleGxy8k9143bT4MwfsFHjdDieG+79mDjH8Pn91kxFbTwkD2dB2i475
	4zKEAgM0757ChgiLl5sX4JDTHyempx4raj6/hVVskxzrBPnQHHXwVJnYpC4z+M/033eMoc1eaCd
	quf1mlDr8kexMoDjP1eVqJkbBsG/xXDpV2JVrvHHQyQN/+eydQze+3Aj5EEk3KUUiZYFlvvYllT
	KLcLC65ve2w4VMKnIMmjfOxZg+eW4Ois0QGDAizc6pwwFCfE4Xasrp3Q5jpYW3qVstQmzlCNfNa
	AKakFwmnW9FuXTDpOaWBmBSv0ksHYSvZyH
X-Received: by 2002:a05:6000:1a87:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-45eb38d7d0emr29705304f8f.35.1779781496236;
        Tue, 26 May 2026 00:44:56 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cd151asm32668426f8f.13.2026.05.26.00.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:44:55 -0700 (PDT)
Date: Tue, 26 May 2026 09:44:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Li RongQing <lirongqing@baidu.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch
 mode during init
Message-ID: <ahVPASuh4BZGOfx0@FV6GYCPJ69>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521072434.362624-4-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-291566-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 3C4B25D1DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>From: Mark Bloch <mbloch@nvidia.com>
>
>Apply devlink default eswitch mode for mlx5 devices after successful
>device initialization while holding the devlink instance lock.
>
>At this point the devlink instance is registered and the mlx5 devlink
>operations are available, so the default eswitch mode can be applied to
>the matching PCI devlink handle.
>
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>index 0c6e4efe38c8..4528097f3d84 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>@@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
> }
> 
>+static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>+{
>+	struct devlink *devlink = priv_to_devlink(dev);
>+	int err;
>+
>+	if (!MLX5_ESWITCH_MANAGER(dev))
>+		return;
>+
>+	devl_assert_locked(devlink);
>+	err = devl_apply_default_esw_mode(devlink);
>+	if (err)
>+		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>+			       err);
>+}
>+
> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
> {
> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>@@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
> 
> 	mutex_unlock(&dev->intf_state_mutex);
>+	mlx5_devl_apply_default_esw_mode(dev);

I wonder how we can make this work for all. I mean, other driver would
silently ignore this command like arg, right? Any idea how to make all
drivers follow the arg from very beginning?


> 	return 0;
> 
> err_register:
>@@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
> 		goto err_attach;
> 
> 	mutex_unlock(&dev->intf_state_mutex);
>+	mlx5_devl_apply_default_esw_mode(dev);
> 	return 0;
> 
> err_attach:
>-- 
>2.44.0
>

