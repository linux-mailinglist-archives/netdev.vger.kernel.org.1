Return-Path: <netdev+bounces-226487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788ABA0FD6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029821C231D3
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DD3168E3;
	Thu, 25 Sep 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6CSHUXe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95E31690A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824279; cv=none; b=jZsqBaUyCi9UwlpqlwbMU32FmeyKjHExazSD1uUnGiWJs6ED/hXskJwsqcR1DO5xgvDTUWDee/cZum88SflXZtE1iH6wxbDE9YFKkASAtPvH9/MGM9DmlpelGrRddV8Xd4Eu2Y2ZCGiDYphvklkZExTe+tAZbvbQ+HPUnQY2ihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824279; c=relaxed/simple;
	bh=Xd62hDKIjxqYgSv1AwKnfcmQ541BGpDwXKAzqWsUsWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jc1jS9CPZ/5mjCky+OASOKGfZ0RWUcB/zoEmM6t/Yio0HpGoBzn3PQv7j62Q85YTWb0DVf0soiwtKXHNLzKDdUu0F9l8enwuZFhWWt8iXsg5UWuifAv9VqOjXt7kPJ+K/s3npZk2nNUNEYT4zaJphAVrBnVX66cxpaWmKdZEg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6CSHUXe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758824277; x=1790360277;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Xd62hDKIjxqYgSv1AwKnfcmQ541BGpDwXKAzqWsUsWI=;
  b=f6CSHUXewJKuYXKDjyLjLp1pkeWKbXaGrBdVFF8OO58hqOX5oiNFrRzS
   BQJgp0qcKWDOqNDf7xzlN1gxrtC2cWTeDCHL4mGGFxUS90TLiUmaKgqgo
   lk2wc8iNQubYkauOylIx90cGr1Mmo5SfiTABIpmfqBTzzdIcWueMJqwDt
   XCLvDNXQlV7g1TkZihiS2u+hHxNtTGjuDSZ7x40nP61P/AiWlD9wIDxO3
   zeRdY6dd23Jt6Z5arRI5ahVX1SwhTmgZu3rKwntvRZMrym9AmzQGSuYU8
   s/1pbzRvkr10f7pqnpUHYgYq13gpPd1ZfwtsCWxSop9vTkXTyN6eWqZdD
   g==;
X-CSE-ConnectionGUID: EjwAOphUQjauV50u4W1rzQ==
X-CSE-MsgGUID: Gca5e/TmSSWDssuUyn4iUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61065794"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61065794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 11:17:57 -0700
X-CSE-ConnectionGUID: pIeTUe5FRBiic2wOqKCTNA==
X-CSE-MsgGUID: GtfJ/LXzR9enOup0kJj3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="208132386"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 11:17:57 -0700
Message-ID: <05958f83-b703-4ce7-a526-c6d0bc3fb81e@intel.com>
Date: Thu, 25 Sep 2025 11:17:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
From: Dave Jiang <dave.jiang@intel.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com,
 Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net,
 edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com>
 <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
 <CALs4sv0GMBZvhocPr4DTUu0ECFCazEb8Db6ms9SwO9CVPzBNVw@mail.gmail.com>
 <74540a81-a7af-4a50-b832-679e7873cfe0@intel.com>
Content-Language: en-US
In-Reply-To: <74540a81-a7af-4a50-b832-679e7873cfe0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/25/25 8:46 AM, Dave Jiang wrote:
> 
> 
> On 9/24/25 9:31 PM, Pavan Chebbi wrote:
>> On Thu, Sep 25, 2025 at 4:02 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>>
>>
>>>> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
>>>> +                         enum fwctl_rpc_scope scope,
>>>> +                         void *in, size_t in_len, size_t *out_len)
>>>> +{
>>>> +     struct bnxtctl_dev *bnxtctl =
>>>> +             container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
>>>> +     struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
>>>> +     struct fwctl_dma_info_bnxt *dma_buf = NULL;
>>>> +     struct device *dev = &uctx->fwctl->dev;
>>>> +     struct fwctl_rpc_bnxt *msg = in;
>>>> +     struct bnxt_fw_msg rpc_in;
>>>> +     int i, rc, err = 0;
>>>> +     int dma_buf_size;
>>>> +
>>>> +     rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
>>>
>>> I think if you use __free(kfree) for all the allocations in the function, you can be rid of the gotos.
>>>
>> Thanks Dave for the review. Would you be fine if I defer using scope
>> based cleanup for later?
>> I need some time to understand the mechanism better and correctly
>> define the macros as some
>> pointers holding the memory are members within a stack variable. I
>> will fix the goto/free issues
>> you highlighted in the next revision. I hope that is going to be OK?
> 
> Sure that is fine. The way things are done in this function makes things a bit tricky to do cleanup properly via the scope based cleanup. I might play with it a bit and see if I can come up with something. It looks like it needs a bit of refactoring to split some things out. Probably not a bad thing in the long run. 
> 

Here's a potential template for doing it with scoped based cleanup. It applies on top of this current patch. I only compile tested. There probably will be errors in the conversion. Feel free to use it.

---

diff --git a/drivers/fwctl/bnxt/main.c b/drivers/fwctl/bnxt/main.c
index 1bec4567e35c..714106fd1033 100644
--- a/drivers/fwctl/bnxt/main.c
+++ b/drivers/fwctl/bnxt/main.c
@@ -22,8 +22,6 @@ struct bnxtctl_uctx {
 struct bnxtctl_dev {
 	struct fwctl_device fwctl;
 	struct bnxt_aux_priv *aux_priv;
-	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
-	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
 };
 
 DEFINE_FREE(bnxtctl, struct bnxtctl_dev *, if (_T) fwctl_put(&_T->fwctl))
@@ -76,61 +74,133 @@ static bool bnxtctl_validate_rpc(struct bnxt_en_dev *edev,
 	return false;
 }
 
-static int bnxt_fw_setup_input_dma(struct bnxtctl_dev *bnxt_dev,
-				   struct device *dev,
-				   int num_dma,
-				   struct fwctl_dma_info_bnxt *msg,
-				   struct bnxt_fw_msg *fw_msg)
+struct bnxtctl_dma {
+	struct device *dev;
+	int num_dma;
+	void *dma_virt_addr[MAX_NUM_DMA_INDICATIONS];
+	dma_addr_t dma_addr[MAX_NUM_DMA_INDICATIONS];
+};
+
+struct dma_context {
+	struct bnxtctl_dma *dma;
+	struct fwctl_dma_info_bnxt *dma_info;
+};
+
+static void free_dma(struct bnxtctl_dma *dma)
+{
+	int i;
+
+	for (i = 0; i < dma->num_dma; i++) {
+		if (dma->dma_virt_addr[i])
+			dma_free_coherent(dma->dev, 0, dma->dma_virt_addr[i],
+					  dma->dma_addr[i]);
+	}
+	kfree(dma);
+}
+DEFINE_FREE(free_dma, struct bnxtctl_dma *, if (_T) free_dma(_T))
+
+static struct bnxtctl_dma *
+allocate_and_setup_dma_bufs(struct device *dev,
+			    struct fwctl_dma_info_bnxt *dma_info,
+			    int num_dma,
+			    struct bnxt_fw_msg *fw_msg)
 {
-	u8 i, num_allocated = 0;
 	void *dma_ptr;
-	int rc = 0;
+	int i;
 
+	struct bnxtctl_dma *dma __free(free_dma) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return ERR_PTR(-ENOMEM);
+
+	dma->dev = dev->parent;
 	for (i = 0; i < num_dma; i++) {
-		if (msg->len == 0 || msg->len > MAX_DMA_MEM_SIZE) {
-			rc = -EINVAL;
-			goto err;
-		}
-		bnxt_dev->dma_virt_addr[i] = dma_alloc_coherent(dev->parent,
-								msg->len,
-								&bnxt_dev->dma_addr[i],
-								GFP_KERNEL);
-		if (!bnxt_dev->dma_virt_addr[i]) {
-			rc = -ENOMEM;
-			goto err;
-		}
-		num_allocated++;
-		if (!(msg->read_from_device)) {
-			if (copy_from_user(bnxt_dev->dma_virt_addr[i],
-					   u64_to_user_ptr(msg->data),
-					   msg->len)) {
-				rc = -EFAULT;
-				goto err;
-			}
-		}
-		dma_ptr = fw_msg->msg + msg->offset;
+		__le64 *dmap;
 
-		if ((PTR_ALIGN(dma_ptr, 8) == dma_ptr) &&
-		    msg->offset < fw_msg->msg_len) {
-			__le64 *dmap = dma_ptr;
+		if (dma_info->len == 0 || dma_info->len > MAX_DMA_MEM_SIZE)
+			return ERR_PTR(-EINVAL);
 
-			*dmap = cpu_to_le64(bnxt_dev->dma_addr[i]);
-		} else {
-			rc = -EINVAL;
-			goto err;
+		dma->dma_virt_addr[i] =
+			dma_alloc_coherent(dma->dev, dma_info->len,
+					   &dma->dma_addr[i], GFP_KERNEL);
+		if (!dma->dma_virt_addr[i])
+			return ERR_PTR(-ENOMEM);
+
+		dma->num_dma++;
+		if (!(dma_info->read_from_device)) {
+			if (copy_from_user(dma->dma_virt_addr[i],
+					   u64_to_user_ptr(dma_info->data),
+					   dma_info->len))
+				return ERR_PTR(-EFAULT);
 		}
-		msg += 1;
+		dma_ptr = fw_msg->msg + dma_info->offset;
+
+		if (PTR_ALIGN(dma_ptr, 8) != dma_ptr ||
+		    dma_info->offset >= fw_msg->msg_len)
+			return ERR_PTR(-EINVAL);
+
+		dmap = dma_ptr;
+		*dmap = cpu_to_le64(dma->dma_addr[i]);
+		dma_info += 1;
+	}
+
+	return no_free_ptr(dma);
+}
+
+static void free_dma_context(struct dma_context *dma_ctx)
+{
+	if (dma_ctx->dma)
+		free_dma(dma_ctx->dma);
+	if (dma_ctx->dma_info)
+		kfree(dma_ctx->dma_info);
+	kfree(dma_ctx);
+}
+DEFINE_FREE(free_dma_ctx, struct dma_context *, if (_T) free_dma_context(_T))
+
+static struct dma_context *
+allocate_and_setup_dma_context(struct device *dev,
+			       struct fwctl_rpc_bnxt *rpc_msg,
+			       struct bnxt_fw_msg *fw_msg)
+{
+	int num_dma = rpc_msg->num_dma;
+	int dma_buf_size;
+
+	if (!num_dma)
+		return NULL;
+
+	struct dma_context *dma_ctx __free(free_dma_ctx) =
+		kzalloc(sizeof(*dma_ctx), GFP_KERNEL);
+	if (!dma_ctx)
+		return ERR_PTR(-ENOMEM);
+
+	if (num_dma > MAX_NUM_DMA_INDICATIONS) {
+		dev_err(dev, "DMA buffers exceed the number supported\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	return rc;
-err:
-	for (i = 0; i < num_allocated; i++)
-		dma_free_coherent(dev->parent,
-				  msg->len,
-				  bnxt_dev->dma_virt_addr[i],
-				  bnxt_dev->dma_addr[i]);
+	dma_buf_size = num_dma * sizeof(struct fwctl_dma_info_bnxt);
+	struct fwctl_dma_info_bnxt *dma_info __free(kfree)
+		= kzalloc(dma_buf_size, GFP_KERNEL);
+	if (!dma_info) {
+		dev_err(dev, "Failed to allocate dma buffers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (copy_from_user(dma_info, u64_to_user_ptr(rpc_msg->payload),
+			   dma_buf_size)) {
+		dev_dbg(dev, "Failed to copy payload from user\n");
+		return ERR_PTR(-EFAULT);
+	}
+
+	struct bnxtctl_dma *dma __free(free_dma) =
+		allocate_and_setup_dma_bufs(dev, dma_info, num_dma, fw_msg);
+	if (IS_ERR(dma))
+		return ERR_CAST(dma);
+
+	dma_ctx->dma_info = no_free_ptr(dma_info);
+	dma_ctx->dma = no_free_ptr(dma);
 
-	return rc;
+	return no_free_ptr(dma_ctx);
 }
 
 static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
@@ -140,34 +210,28 @@ static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
 	struct bnxtctl_dev *bnxtctl =
 		container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
 	struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
-	struct fwctl_dma_info_bnxt *dma_buf = NULL;
 	struct device *dev = &uctx->fwctl->dev;
 	struct fwctl_rpc_bnxt *msg = in;
 	struct bnxt_fw_msg rpc_in;
-	int i, rc, err = 0;
-	int dma_buf_size;
+	int i, rc;
+
+	void *rpc_in_msg __free(kfree) = kzalloc(msg->req_len, GFP_KERNEL);
+	if (!rpc_in_msg)
+		return ERR_PTR(-ENOMEM);
 
-	rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
-	if (!rpc_in.msg) {
-		err = -ENOMEM;
-		goto err_out;
-	}
 	if (copy_from_user(rpc_in.msg, u64_to_user_ptr(msg->req),
 			   msg->req_len)) {
 		dev_dbg(dev, "Failed to copy in_payload from user\n");
-		err = -EFAULT;
-		goto err_out;
+		return ERR_PTR(-EFAULT);
 	}
 
 	if (!bnxtctl_validate_rpc(bnxt_aux_priv->edev, &rpc_in))
 		return ERR_PTR(-EPERM);
 
 	rpc_in.msg_len = msg->req_len;
-	rpc_in.resp = kzalloc(*out_len, GFP_KERNEL);
-	if (!rpc_in.resp) {
-		err = -ENOMEM;
-		goto err_out;
-	}
+	void *rpc_in_resp __free(kfree) = kzalloc(*out_len, GFP_KERNEL);
+	if (!rpc_in_resp)
+		return ERR_PTR(-ENOMEM);
 
 	rpc_in.resp_max_len = *out_len;
 	if (!msg->timeout)
@@ -175,64 +239,37 @@ static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
 	else
 		rpc_in.timeout = msg->timeout;
 
-	if (msg->num_dma) {
-		if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
-			dev_err(dev, "DMA buffers exceed the number supported\n");
-			err = -EINVAL;
-			goto err_out;
-		}
-		dma_buf_size = msg->num_dma * sizeof(*dma_buf);
-		dma_buf = kzalloc(dma_buf_size, GFP_KERNEL);
-		if (!dma_buf) {
-			dev_err(dev, "Failed to allocate dma buffers\n");
-			err = -ENOMEM;
-			goto err_out;
-		}
-
-		if (copy_from_user(dma_buf, u64_to_user_ptr(msg->payload),
-				   dma_buf_size)) {
-			dev_dbg(dev, "Failed to copy payload from user\n");
-			err = -EFAULT;
-			goto err_out;
-		}
-
-		rc = bnxt_fw_setup_input_dma(bnxtctl, dev, msg->num_dma,
-					     dma_buf, &rpc_in);
-		if (rc) {
-			err = -EIO;
-			goto err_out;
-		}
-	}
+	struct dma_context *dma_ctx __free(free_dma_ctx) =
+		allocate_and_setup_dma_context(dev, msg, &rpc_in);
+	if (IS_ERR(dma_ctx))
+		return ERR_CAST(dma_ctx);
 
+	rpc_in.msg = rpc_in_msg;
+	rpc_in.resp = rpc_in_resp;
 	rc = bnxt_send_msg(bnxt_aux_priv->edev, &rpc_in);
-	if (rc) {
-		err = -EIO;
-		goto err_out;
-	}
+	if (rc)
+		return ERR_PTR(rc);
+
+	if (!dma_ctx)
+		return no_free_ptr(rpc_in_resp);
 
 	for (i = 0; i < msg->num_dma; i++) {
-		if (dma_buf[i].read_from_device) {
-			if (copy_to_user(u64_to_user_ptr(dma_buf[i].data),
-					 bnxtctl->dma_virt_addr[i],
-					 dma_buf[i].len)) {
-				dev_dbg(dev, "Failed to copy resp to user\n");
-				err = -EFAULT;
-			}
+		struct fwctl_dma_info_bnxt *dma_info =
+			&dma_ctx->dma_info[i];
+		struct bnxtctl_dma *dma = dma_ctx->dma;
+
+		if (!dma_info->read_from_device)
+			continue;
+
+		if (copy_to_user(u64_to_user_ptr(dma_info->data),
+				 dma->dma_virt_addr[i],
+				 dma_info->len)) {
+			dev_dbg(dev, "Failed to copy resp to user\n");
+			return ERR_PTR(-EFAULT);
 		}
 	}
-	for (i = 0; i < msg->num_dma; i++)
-		dma_free_coherent(dev->parent, dma_buf[i].len,
-				  bnxtctl->dma_virt_addr[i],
-				  bnxtctl->dma_addr[i]);
 
-err_out:
-	kfree(dma_buf);
-	kfree(rpc_in.msg);
-
-	if (err)
-		return ERR_PTR(err);
-
-	return rpc_in.resp;
+	return no_free_ptr(rpc_in_resp);
 }
 
 static const struct fwctl_ops bnxtctl_ops = {


