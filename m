Return-Path: <netdev+bounces-40508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F67C78C6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB28F282B2F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06C3F4BA;
	Thu, 12 Oct 2023 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/jEV5WE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2C3D989
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D344C433C7;
	Thu, 12 Oct 2023 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697147210;
	bh=Xv66oJ4nEolU1+bXJBHIbGZ5FPpPKbQasImlezyHyL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/jEV5WE7yspWA5dG2wDvZQr069r23fGUVQoaJu4fH2i3HteL1ITg2gpfCs984Nkt
	 uHQnqDmgd+994RiYaTjAXHI/IlYsbC69D9WkRZgga0N2nh2DbPVCjqp1TpJha0iIq2
	 PpE8/l9pvzBDXN5/fay9hSpJc+P7Kk3K5S/F+5U7XxPWrtAAY9u5q2dYRmJwbHEQCW
	 JdQRFE5s3a0MMdBWIS5nB8Io6gIeNQ13JsiItZP4oeDsFgRadvanlGybPD+FiORUc9
	 gUeIiICRtAOv7a9MPqZE450WK0cXtQkykAqK66KXsL3Udf63FQ2a4yrrumJDr/hwOF
	 eijfGYM5Cg5Xw==
Date: Thu, 12 Oct 2023 14:46:49 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [net-next V2 04/15] net/mlx5: Refactor LAG peer device lookout
 bus logic to mlx5 devcom
Message-ID: <ZShpScwHoLV/2Bi2@x130>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-5-saeed@kernel.org>
 <ff42e84c-0859-4e7f-b8e7-1b4e1f7d1c8f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff42e84c-0859-4e7f-b8e7-1b4e1f7d1c8f@intel.com>

On 12 Oct 14:26, Jacob Keller wrote:
>
>
>On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
>> From: Shay Drory <shayd@nvidia.com>
>>
>> LAG peer device lookout bus logic required the usage of global lock,
>> mlx5_intf_mutex.
>> As part of the effort to remove this global lock, refactor LAG peer
>> device lookout to use mlx5 devcom layer.
>>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/dev.c | 68 -------------------
>>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++--
>>  .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 14 ++++
>>  .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  4 ++
>>  .../net/ethernet/mellanox/mlx5/core/main.c    | 25 +++++++
>>  .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 -
>>  include/linux/mlx5/driver.h                   |  1 +
>>  7 files changed, 52 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
>> index 1fc03480c2ff..6e3a8c22881f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
>> @@ -566,74 +566,6 @@ bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev
>>  	return (fsystem_guid && psystem_guid && fsystem_guid == psystem_guid);
>>  }
>>
>> -static u32 mlx5_gen_pci_id(const struct mlx5_core_dev *dev)
>> -{
>> -	return (u32)((pci_domain_nr(dev->pdev->bus) << 16) |
>> -		     (dev->pdev->bus->number << 8) |
>> -		     PCI_SLOT(dev->pdev->devfn));
>> -}
>> -
>> -static int _next_phys_dev(struct mlx5_core_dev *mdev,
>> -			  const struct mlx5_core_dev *curr)
>> -{
>> -	if (!mlx5_core_is_pf(mdev))
>> -		return 0;
>> -
>> -	if (mdev == curr)
>> -		return 0;
>> -
>> -	if (!mlx5_same_hw_devs(mdev, (struct mlx5_core_dev *)curr) &&
>> -	    mlx5_gen_pci_id(mdev) != mlx5_gen_pci_id(curr))
>> -		return 0;
>> -
>> -	return 1;
>> -}
>> -
>> -static void *pci_get_other_drvdata(struct device *this, struct device *other)
>> -{
>> -	if (this->driver != other->driver)
>> -		return NULL;
>> -
>> -	return pci_get_drvdata(to_pci_dev(other));
>> -}
>> -
>> -static int next_phys_dev_lag(struct device *dev, const void *data)
>> -{
>> -	struct mlx5_core_dev *mdev, *this = (struct mlx5_core_dev *)data;
>> -
>> -	mdev = pci_get_other_drvdata(this->device, dev);
>> -	if (!mdev)
>> -		return 0;
>> -
>> -	if (!mlx5_lag_is_supported(mdev))
>> -		return 0;
>> -
>> -	return _next_phys_dev(mdev, data);
>> -}
>> -
>> -static struct mlx5_core_dev *mlx5_get_next_dev(struct mlx5_core_dev *dev,
>> -					       int (*match)(struct device *dev, const void *data))
>> -{
>> -	struct device *next;
>> -
>> -	if (!mlx5_core_is_pf(dev))
>> -		return NULL;
>> -
>> -	next = bus_find_device(&pci_bus_type, NULL, dev, match);
>> -	if (!next)
>> -		return NULL;
>> -
>> -	put_device(next);
>> -	return pci_get_drvdata(to_pci_dev(next));
>> -}
>> -
>> -/* Must be called with intf_mutex held */
>> -struct mlx5_core_dev *mlx5_get_next_phys_dev_lag(struct mlx5_core_dev *dev)
>> -{
>> -	lockdep_assert_held(&mlx5_intf_mutex);
>
>The old flow had a lockdep_assert_held
>
>> -	return mlx5_get_next_dev(dev, &next_phys_dev_lag);
>> -}
>> -
>>  void mlx5_dev_list_lock(void)
>>  {
>>  	mutex_lock(&mlx5_intf_mutex);
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> index af3fac090b82..f0b57f97739f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> @@ -1212,13 +1212,14 @@ static void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev,
>>  	dev->priv.lag = NULL;
>>  }
>>
>> -/* Must be called with intf_mutex held */
>> +/* Must be called with HCA devcom component lock held */
>>  static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>>  {
>> +	struct mlx5_devcom_comp_dev *pos = NULL;
>>  	struct mlx5_lag *ldev = NULL;
>>  	struct mlx5_core_dev *tmp_dev;
>>
>> -	tmp_dev = mlx5_get_next_phys_dev_lag(dev);
>> +	tmp_dev = mlx5_devcom_get_next_peer_data(dev->priv.hca_devcom_comp, &pos);
>>  	if (tmp_dev)
>>  		ldev = mlx5_lag_dev(tmp_dev);
>>
>
>But you didn't bother to add one here? Does
>mlx5_devcom_get_next_peer_data already do that?
>

The global mutex isn't required anymore after this refactoring,
and devcom has own locking and sync mechanism.

>Not a big deal either way to me.
>
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

