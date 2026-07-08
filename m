Return-Path: <netdev+bounces-305682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqL9DLQMTmoDCQIAu9opvQ
	(envelope-from <netdev+bounces-305682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:39:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6D7233FD
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 10:39:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=SS000QVm;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305682-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305682-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 386823084695
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14640149F;
	Wed,  8 Jul 2026 08:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E5398902
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 08:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499703; cv=none; b=tM9n27DmQd+ubHCPTwy3/h2HVNiF/U2mH6UX668ht5vsx5xJbKlVrtRrwj0Bq0cTpaCvtFBqw98OHB/9rJWWrb8d4rOgXVxPr1K7AUevMGWAWz9rNSV7p8Pq/PxF7/DxsxeENel/dWswsTesULLcS6EV4l28HRSaUSkI4B0iGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499703; c=relaxed/simple;
	bh=i8NUcW/oTATrxmS6+QrhnDTWblS1EuQ+OATB9E3pmdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChE/dscT69yn6bPAgKByOBQJlyJGDQLDTMRMbpxdpeo7PQ12UoulxBkqRQ7CmKKsffw6pqD1INjjRbJczH6Yw96O+c1oF0xRs2PjS/Zfx3ChMlRr/dg/RQHF+0Y8r1pD37tX8VFucjvZlT50+LLrwOV8puiUBt5+2/lSvi0Q9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=SS000QVm; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b7612475so2852975e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783499698; x=1784104498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d65vlscf3MRlCdV5SPB30z4zAVCml2R2BL0nflKn+XI=;
        b=SS000QVmxWWkm0E2IwPRChuI4Jrwye4c14r18/hTPNnyc8J9csQxLTMNKw4GORlHxV
         Rgw8bXpbGXcZsKbpTVYabF/b0Ag5w6gSVTgY60HsyuJsjHDcn7ENn8MfsMdE84jW4A2v
         2f655a9u+N6xXeU5nY2NpenbxRQ7yiWfG9ld6LfGgDq+L6zF0/m+pFPUNnYwUDPL1CvC
         weUBeSTfZI1GOyxqrEQNoDNM9NS2C7d/ERUYQObPceIk9EHjFJTQFhqe3FWt54/OjULu
         0JLP8vAYCzfJADPAxhH8p1Gr+aaxtbhwchNnGSwQbS27OMhYU4llfa2er3B9FbSMlQwG
         9USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499698; x=1784104498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d65vlscf3MRlCdV5SPB30z4zAVCml2R2BL0nflKn+XI=;
        b=kGSZ/YDDOlutDKqgclqxbqlcbDG1CgJPdWnVMvrc1ncjDLAVy87ILrFs/IDO6at3rX
         svURiCvFCJXh9lfsPFHz1JLYdYHSY6FrJybIEbV8XE5NV4pouQ5x0iV6GYvGANpisGK2
         ZO+CrBgNJhWmaxs+EI1kGzbhei3rjvtuon3JU89YCFW8Tl2MiiYFPUqKj3YStBO68jh2
         2Rb6bQX8W3OoFZlgtg1hzrY/L7MKLmJJEjkxMHVhtxK7rjpEUt+QqHyGWQDessrGs3oS
         Qp6hWHBnnpI6SN0Pb4ojFBmrqslBlUMm6lOqFRYu+sfK07vyk2bFJQWXq13BOnGO79ei
         xOEg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9mce3Xblyhp5UQ8tOqSkVrH9kGVRAClj1Qb2bbwCgr5brnPSNAZzrIy+IQtXt0yO6yN1TurQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2uqYne7AdPDcHDxD6vAQCe717o13SI45OtFMY5svh6l7VIEK
	Qn2COW4/CFG13oa26Ql5FVPdMepg378kxAC9/1R08oKfjDgtoVA95xCHgzpd4Eba63atH3fETZy
	qbVQ9
X-Gm-Gg: AfdE7cnvJa9W+w0ne1l3dC7kUNJVcXUfsfwfZJcpMjpJoU2s6g3udsL6e4tYKWN9VJe
	5IVod3iwShq7sraOY+fk+E41vAyGzbYjszdbnQBGb7vcjaaHOIpyMRegZOPjePuG2c0vUofaMNm
	6Y7md50pITS/bAFnKSTeUjqHuvLJ4jIu22tXHNkfEaV4VTBJbK5smkPRsmieu9m50PkshUA79pQ
	LXxGgbqu2stsFD5m1Ov6GDRD2udFtr8IqHgWp6ANNSKLJSqVDEmH3/Z+FGv4ECBEfIR15o8b/gw
	heyw4HWhljldHMppuIbAe2/CmZWruCB+l4VJOHlhTDOycQhBPEzVJqoBuV42Pujc41wAp0DzCV6
	k3yXBG7U5OOwujTMgqajTh5rc7dzPuDl4AEb6Ju8IWtID3lhFjN5Cso5EvAgGKaZw7sxMC8fi7u
	Q18N1xlRRZnJFCd7Y+Cbx/
X-Received: by 2002:a05:600c:82c3:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-493e683c514mr13471085e9.5.1783499698217;
        Wed, 08 Jul 2026 01:34:58 -0700 (PDT)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm40791770f8f.27.2026.07.08.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:34:57 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:34:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V5 6/6] net/mlx5: Apply devlink eswitch mode
 boot default on probe
Message-ID: <ak4LVcyKofmtrWcU@FV6GYCPJ69>
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-7-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707174527.425134-7-mbloch@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-305682-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[FV6GYCPJ69:mid,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF6D7233FD

Tue, Jul 07, 2026 at 07:45:27PM +0200, mbloch@nvidia.com wrote:
>Apply devlink_eswitch_mode= boot defaults for mlx5 after the initial
>probe finishes device initialization while holding the devlink instance
>lock.
>
>At this point the devlink instance is registered and mlx5 can perform an
>eswitch mode change. Calling devl_apply_default_esw_mode() also clears
>any pending default apply work queued by devl_register(), so the queued
>work will not apply the same default again.
>
>Keep this call in mlx5_init_one() rather than the lower-level
>devl-locked init helper. That helper is also used by devlink reload, and
>devlink core already applies the boot default after a successful
>DRIVER_REINIT reload.
>
>Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/main.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>index 643b4aac2033..0712efea74cc 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>@@ -1392,6 +1392,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
> }
> 
>+static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>+{
>+	struct devlink *devlink = priv_to_devlink(dev);
>+
>+	if (!MLX5_ESWITCH_MANAGER(dev))
>+		return;
>+
>+	devl_assert_locked(devlink);
>+	devl_apply_default_esw_mode(devlink);
>+}
>+
> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
> {
> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>@@ -1471,6 +1482,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
> 	err = mlx5_init_one_devl_locked(dev);
> 	if (err)
> 		devl_unregister(devlink);
>+	else
>+		mlx5_devl_apply_default_esw_mode(dev);

I don't understand why this patch is needed at all. Just leave the job
to the devlink core, no? That was the point to not pollute drivers with
code like this. Is it some kind of leftover?



> unlock:
> 	devl_unlock(devlink);
> 	return err;
>-- 
>2.43.0
>

