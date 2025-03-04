Return-Path: <netdev+bounces-171761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C732A4E7FF
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEB619C4F8E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F9294F2B;
	Tue,  4 Mar 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJZCeL1G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C0294F1D
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106723; cv=none; b=RwUY01VwF6RJ2Pwfz3QDYXK8bVS9qmv/6h4Gm+yJBS/d91eXWKZ4BXPU9g+yFOJ3Z+TKqBXUSDWJY2hWDEJ0Pg/ZNC2kLfYmwBYEFviwT/66ovAN151IXWBzMAmc03GfYObqofwNqlOXF2C2on9E0hkcohzXrbctH/RLftnxxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106723; c=relaxed/simple;
	bh=STwjzrTgOmkz3q+YXMf2wIG/uUDUMBV2NRbFzBNJoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcAm73xxCpCZr1wy5+XEeEuysQ3RsqPlG3h+mft+0zlyivED4Lyh++x0DJPHoUtjpyLxNKOEPkBN86iOFDihBmkYNCtlXz4DE83Za1sRFt4rCEOHTBLSnx7RuC3mH/gZGNo0L0ATZjn3Nt13XqOAy6QDhWPFkLyWMu5/F6NZmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJZCeL1G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741106721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OvS9YQcWBhXVqQRfK8auIhsAnxdyeQfcszoy4AGwoFs=;
	b=ZJZCeL1GqYU+pEespjp2t3jYrM834KSj8Sh5RW5WU64NIrmaKHWbwmAsKe6HWWtzejAI7/
	k+RN4HeKrLNjJzvVGw6GAiVrYlFR6EDfhUTfrWcush78LmocBn1P7JmniU06jzeJWF3+JD
	KBWzqWUaBK5C6KhTJ59dJUuEF0SEaL4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Th399BzXPlallBuGQFhQfw-1; Tue, 04 Mar 2025 11:45:15 -0500
X-MC-Unique: Th399BzXPlallBuGQFhQfw-1
X-Mimecast-MFC-AGG-ID: Th399BzXPlallBuGQFhQfw_1741106713
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8c58184e9so46651226d6.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106713; x=1741711513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvS9YQcWBhXVqQRfK8auIhsAnxdyeQfcszoy4AGwoFs=;
        b=JaFyfN7O5eP/wx6tG7aX4WVl9CehPGUeqa7FsshPdy9zDmUkNffgviVWpW+IgXPWT+
         nTo/2WHy/Kwqc5PUOj5/fPSb0g7JDi2wlk5K9dCjYGj23Md6UVhCa6KpltSqnuo02tI5
         7KzAy1eHbZrdPGDQn+yv9IKyDNf/XLtnmGQd63a8T0c275DF7PvwthUwDI4h/CCd/syF
         yaawfDwwy3WSKw3NjAe1t8pdlHWfmWAKHRMDk13cvmdxOxqUBWkofrXGXK7NQWhvJFTO
         0ZLrFBJzBYvwcNqObXwpmYSfoAIZsjSY7x3LuTaDFnziUgtQxp7rZI8IQMsFeuXKOqL8
         MW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdhbM7kJB6C1y3bX1uXnnlrK4h8h+I1Up5XXPyLfJyQX4MOhkqH3AB8aQAJZngvqdkglRFjoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrcKXSa2QDEyG+BOFPKP2GvJWNHKo1097oXsmHO/qpidc73z2
	Z+iojkIxrPS92DIvcHSM+dHJZ0COMbI6HynRyTmcmudoY4Y6XcCecz5yE32ZcohzV/8rmJQ9RXB
	wahTP1oucYgEVk+4yBjnO04aUn0iDFbnOL8oETR5lddwgdt9+kZmvsw==
X-Gm-Gg: ASbGncsydenZevPAcJtCKJL/G8kI4+cOhgvtwnA9TxO0mvV65AJalm0nGtxArW2bda8
	1skEHZp3j/zZiJT+5ZE1dnCIW96KNHG+x3sET12gWqUnlRIjLicmEhs3XHA6xf/ZVlJOF+VjCtU
	3wpoPQYhFR74Xuo49hBV1io3yl+bhhMJjtl4MVo608U2uRCSBFe7I1MIh9ISxg/TyHdZREkuASy
	rbnRCk6J9z5MIssMaEooc8/DSEYYZ41cTjoj4xrP94rjkbkm+W/zFVia5yUxCebkOdEIKJHnBJC
	RAAlrq4q
X-Received: by 2002:a05:6214:2462:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e8a0d9990emr268698416d6.39.1741106713349;
        Tue, 04 Mar 2025 08:45:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEk+zP+A1jr1+KTsTFUqLIMhe1LB9YfFixdl2fISFfd3uRPaiW8ogdptdnCA2jd9/TIR++YQ==
X-Received: by 2002:a05:6214:2462:b0:6e4:4331:aae6 with SMTP id 6a1803df08f44-6e8a0d9990emr268697946d6.39.1741106712941;
        Tue, 04 Mar 2025 08:45:12 -0800 (PST)
Received: from fedora-x1 ([142.126.89.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc891sm69856836d6.81.2025.03.04.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:45:12 -0800 (PST)
Date: Tue, 4 Mar 2025 11:45:01 -0500
From: Kamal Heib <kheib@redhat.com>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 05/14] net/mlx5: Implement devlink total_vfs
 parameter
Message-ID: <Z8cuDVYOczIwo1Mw@fedora-x1>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-6-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-6-saeed@kernel.org>

On Thu, Feb 27, 2025 at 06:12:18PM -0800, Saeed Mahameed wrote:
> From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> 
> Some devices support both symmetric (same value for all PFs) and
> asymmetric, while others only support symmetric configuration. This
> implementation prefers asymmetric, since it is closer to the devlink
> model (per function settings), but falls back to symmetric when needed.
> 
> Example usage:
>   devlink dev param set pci/0000:01:00.0 name total_vfs value <u16> cmode permanent
>   devlink dev reload pci/0000:01:00.0 action fw_activate
>   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>   echo 1 >/sys/bus/pci/rescan
>   cat /sys/bus/pci/devices/0000:01:00.0/sriov_totalvfs
> 
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Tested-by: Kamal Heib <kheib@redhat.com>

> ---
>  Documentation/networking/devlink/mlx5.rst     |  22 +++
>  .../mellanox/mlx5/core/lib/nv_param.c         | 125 ++++++++++++++++++
>  2 files changed, 147 insertions(+)
> 
> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> index 587e0200c1cd..00a43324dec2 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -40,6 +40,28 @@ Parameters
>       - Boolean
>       - Applies to each physical function (PF) independently, if the device
>         supports it. Otherwise, it applies symmetrically to all PFs.
> +   * - ``total_vfs``
> +     - permanent
> +     - The range is between 1 and a device-specific max.
> +     - Applies to each physical function (PF) independently, if the device
> +       supports it. Otherwise, it applies symmetrically to all PFs.
> +
> +Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
> +
> +.. code-block:: bash
> +
> +   # setup parameters
> +   devlink dev param set pci/0000:01:00.0 name enable_sriov value true cmode permanent
> +   devlink dev param set pci/0000:01:00.0 name total_vfs value 8 cmode permanent
> +
> +   # Fw reset
> +   devlink dev reload pci/0000:01:00.0 action fw_activate
> +
> +   # for PCI related config such as sriov PCI reset/rescan is required:
> +   echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
> +   echo 1 >/sys/bus/pci/rescan
> +   grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
> +
>  
>  The ``mlx5`` driver also implements the following driver-specific
>  parameters.
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> index 6b63fc110e2d..97d74d890582 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
> @@ -387,10 +387,135 @@ static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
>  	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>  }
>  
> +static int mlx5_devlink_total_vfs_get(struct devlink *devlink, u32 id,
> +				      struct devlink_param_gset_ctx *ctx)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
> +	void *data;
> +	int err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +
> +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
> +		ctx->val.vu32 = 0;
> +		return 0;
> +	}
> +
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
> +		ctx->val.vu32 = MLX5_GET(nv_global_pci_conf, data, total_vfs);
> +		return 0;
> +	}
> +
> +	/* SRIOV is per PF */
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_vf);
> +
> +	return 0;
> +}
> +
> +static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
> +				      struct devlink_param_gset_ctx *ctx,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)];
> +	bool per_pf_support;
> +	void *data;
> +	int err;
> +
> +	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
> +	if (err) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to read global pci cap");
> +		return err;
> +	}
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	per_pf_support = MLX5_GET(nv_global_pci_cap, data, per_pf_total_vf_supported);
> +	memset(mnvda, 0, sizeof(mnvda));
> +
> +	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
> +	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
> +
> +	if (!per_pf_support) {
> +		MLX5_SET(nv_global_pci_conf, data, total_vfs, ctx->val.vu32);
> +		return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +	}
> +
> +	/* SRIOV is per PF */
> +	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	memset(mnvda, 0, sizeof(mnvda));
> +	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
> +	if (err)
> +		return err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
> +	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, 1);
> +	MLX5_SET(nv_pf_pci_conf, data, total_vf, ctx->val.vu32);
> +	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
> +}
> +
> +static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
> +					   union devlink_param_value val,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct mlx5_core_dev *dev = devlink_priv(devlink);
> +	u32 cap[MLX5_ST_SZ_DW(mnvda_reg)];
> +	void *data;
> +	u16 max;
> +	int err;
> +
> +	data = MLX5_ADDR_OF(mnvda_reg, cap, configuration_item_data);
> +
> +	err = mlx5_nv_param_read_global_pci_cap(dev, cap, sizeof(cap));
> +	if (err)
> +		return err;
> +
> +	if (!MLX5_GET(nv_global_pci_cap, data, max_vfs_per_pf_valid))
> +		return 0; /* optimistic, but set might fail later */
> +
> +	max = MLX5_GET(nv_global_pci_cap, data, max_vfs_per_pf);
> +	if (val.vu16 > max) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Max allowed by device is %u", max);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct devlink_param mlx5_nv_param_devlink_params[] = {
>  	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>  			      mlx5_devlink_enable_sriov_get,
>  			      mlx5_devlink_enable_sriov_set, NULL),
> +	DEVLINK_PARAM_GENERIC(TOTAL_VFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> +			      mlx5_devlink_total_vfs_get, mlx5_devlink_total_vfs_set,
> +			      mlx5_devlink_total_vfs_validate),
>  	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
>  			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
>  			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> -- 
> 2.48.1
> 
> 


