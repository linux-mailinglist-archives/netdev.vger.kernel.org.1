Return-Path: <netdev+bounces-24572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFB770A1C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE92282705
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5C1DA3D;
	Fri,  4 Aug 2023 20:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30019891
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:53:18 +0000 (UTC)
Received: from out-103.mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BD4EC4
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:53:15 -0700 (PDT)
Message-ID: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691182393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZL/Zfz+ulrtV+p+UIKOwsglDo56pQvjadHQdqAJUcn0=;
	b=JPUQAgcQ0PZJ+XFAl0EtbUGUO45TktXdQyDbd71Wm9uLPy0joN4Q1FX4HC/qy4c2Gkd4wH
	I5XoWHzy0TgZBCuUvDeUy6zqUfuMQbjNEET++ijXqOisg3T3D+MNCAmbq7kRhYVtzHgW9F
	OrjU9WYF3ECgdZZF7wu8+ja/QoPCUH4=
Date: Fri, 4 Aug 2023 21:53:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx5: Devcom, only use devcom after NULL
 check in mlx5_devcom_send_event()
Content-Language: en-US
To: Li Zetao <lizetao1@huawei.com>, saeedm@nvidia.com, leon@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: pabeni@redhat.com, shayd@nvidia.com, roid@nvidia.com, mbloch@nvidia.com,
 vladbu@nvidia.com, elic@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20230804092636.91357-1-lizetao1@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230804092636.91357-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 10:26, Li Zetao wrote:
> There is a warning reported by kernel test robot:
> 
> smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
>      mlx5_devcom_send_event() warn: variable dereferenced before
> 	IS_ERR check devcom (see line 259)
> 
> The reason for the warning is that the pointer is used before check, put
> the assignment to comp after devcom check to silence the warning.
> 
> Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> index feb62d952643..2bc18274858c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> @@ -256,7 +256,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>   			   int event, int rollback_event,
>   			   void *event_data)
>   {
> -	struct mlx5_devcom_comp *comp = devcom->comp;
> +	struct mlx5_devcom_comp *comp;
>   	struct mlx5_devcom_comp_dev *pos;

The code should end up with reverse x-mas tree order.
The change itself LGTM.

>   	int err = 0;
>   	void *data;
> @@ -264,6 +264,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>   	if (IS_ERR_OR_NULL(devcom))
>   		return -ENODEV;
>   
> +	comp = devcom->comp;
>   	down_write(&comp->sem);
>   	list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
>   		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));


