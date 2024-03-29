Return-Path: <netdev+bounces-83646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DD8933DC
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530981C21DC1
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33F156665;
	Sun, 31 Mar 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af3tEf4r"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8128015574E
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903212; cv=fail; b=c5Lx0JlmWsA0gvRq2w+j1L8gtAzfg8pNE05k7KkfyLWf6eyHI6S0nUh2w229nKs/UD/UbVCph3MlLOz42WmMWyi8jhDCnnkeHa5K0gpM6ckRKLllYbuOxF58EXPN402QEwlTxUlGr9E10yR1/ZGRhe34xUDIf7rjjptXB3yLNYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903212; c=relaxed/simple;
	bh=YclD2gFKAd0KYU/nqrMwp6tntz6Bp0xkpGNnD7iuj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+CTf2WGpOEve3GgLvzL9rvCUEDz2FXrJBJkLWrLulbf/C88ptLdUBao2uAZtriZqCg0/aQRiR5nc+KxEajZx3fRlU9s5R3LAnZZpI2Mq/B1fl6c3kh9SgwdycgbBxkZjR2TKmW88mveF3gYbMkqwt0sYqr6v8WaBf5TKdQAMKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af3tEf4r; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0D7CF208A2;
	Sun, 31 Mar 2024 18:40:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xJvMyPpH9Zv2; Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 859562087B;
	Sun, 31 Mar 2024 18:40:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 859562087B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 773B8800050;
	Sun, 31 Mar 2024 18:40:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83478-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoA+kimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 12659
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83478-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9E6D320883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751395; cv=none; b=r8+B1IFFag2HuI6zBBZXeH+ixu4+v7LcY5wOF3/6wgJ223E0kn3xcKcwo+b9S0QAED6F64X45+Ly5CTR1T3QpysOskVw+gmCEHA7C6kqyn9w3eNJ9i4Hl/Myvb/UKIYrlUrLJA2ZIcn/zPzyZPRsgS1BxBM9vsbq2bHqgBZeDjM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751395; c=relaxed/simple;
	bh=YclD2gFKAd0KYU/nqrMwp6tntz6Bp0xkpGNnD7iuj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ7Bn5B+eJPtxb4RNqsOXTzMjoxUUJ5pI/JOpQlNhT4ZcDDv6O01CZ1g3k27TriDuD2V9f4K/PGRphgNiz/gM/TFCcH5mAojrujO3pTOIJTI+aIIUz1rLn0diYOJV7K7HUs8cBglYDPH5ri6aPJNGmrNMWJbh0ZerjwDrcQhuoc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af3tEf4r; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711751395;
	bh=YclD2gFKAd0KYU/nqrMwp6tntz6Bp0xkpGNnD7iuj3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=af3tEf4riCb4f2NQ149pjvDrIXXmmP43YUOkyHbXZ+M94QTqDI0JCGEF6C9SwDi2v
	 UbNo6lur4NhXefe9RSrYlvWkEgyygoEXlsnzAgBuwTthmMcxP2nKYOexYi7y8EYgAU
	 s+LYfSGZY1szJRSJJk68i3GvMqw/Vxj3slvg7t75/MisPpwS+jb6RoyLsnYv0RKoVL
	 12qu5ji4XYH50ruUZsUfcfxQseOwTzwtSilm9SNsMlGhgFPnOmb3sh5+EZ9kkw1axQ
	 GhY5mxcMFxbnq+OPRpafTOvZpCjxq7fMQ4RgncWl/e6+tXnFeaTluLTysE2h8/dy/H
	 aDL1nOLZRHWXA==
Date: Fri, 29 Mar 2024 15:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, anthony.l.nguyen@intel.com, edumazet@google.com,
 pabeni@redhat.com, idosch@nvidia.com, przemyslaw.kitszel@intel.com,
 marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
Message-ID: <20240329152954.26a7ce75@kernel.org>
In-Reply-To: <20240329092321.16843-3-wojciech.drewek@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
	<20240329092321.16843-3-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 10:23:20 +0100 Wojciech Drewek wrote:
> Some modules use nonstandard power levels. Adjust ethtool
> module implementation to support new attributes that will allow user
> to change maximum power.
> 
> Add three new get attributes:
> ETHTOOL_A_MODULE_MAX_POWER_SET (used for set as well) - currently set
>   maximum power in the cage

1) I'd keep the ETHTOOL_A_MODULE_POWER_ prefix, consistently.

2) The _SET makes it sound like an action. Can we go with
   ETHTOOL_A_MODULE_POWER_MAX ? Or ETHTOOL_A_MODULE_POWER_LIMIT?
   Yes, ETHTOOL_A_MODULE_POWER_LIMIT
        ETHTOOL_A_MODULE_POWER_MAX
        ETHTOOL_A_MODULE_POWER_MIN
   would sound pretty good to me.

> ETHTOOL_A_MODULE_MIN_POWER_ALLOWED - minimum power allowed in the
>   cage reported by device
> ETHTOOL_A_MODULE_MAX_POWER_ALLOWED - maximum power allowed in the
>   cage reported by device
> 
> Add two new set attributes:
> ETHTOOL_A_MODULE_MAX_POWER_SET (used for get as well) - change
>   maximum power in the cage to the given value (milliwatts)
> ETHTOOL_A_MODULE_MAX_POWER_RESET - reset maximum power setting to the
>   default value
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  include/linux/ethtool.h              | 17 +++++--
>  include/uapi/linux/ethtool_netlink.h |  4 ++
>  net/ethtool/module.c                 | 74 ++++++++++++++++++++++++++--
>  net/ethtool/netlink.h                |  2 +-
>  4 files changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index f3af6b31c9f1..74ed8997443a 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -510,10 +510,18 @@ struct ethtool_module_eeprom {
>   * @policy: The power mode policy enforced by the host for the plug-in module.
>   * @mode: The operational power mode of the plug-in module. Should be filled by
>   *	device drivers on get operations.
> + * @min_pwr_allowed: minimum power allowed in the cage reported by device
> + * @max_pwr_allowed: maximum power allowed in the cage reported by device
> + * @max_pwr_set: maximum power currently set in the cage
> + * @max_pwr_reset: restore default minimum power
>   */
>  struct ethtool_module_power_params {
>  	enum ethtool_module_power_mode_policy policy;
>  	enum ethtool_module_power_mode mode;
> +	u32 min_pwr_allowed;
> +	u32 max_pwr_allowed;
> +	u32 max_pwr_set;
> +	u8 max_pwr_reset;

bool ?

> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index 3f89074aa06c..f7cd446b2a83 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -882,6 +882,10 @@ enum {
>  	ETHTOOL_A_MODULE_HEADER,		/* nest - _A_HEADER_* */
>  	ETHTOOL_A_MODULE_POWER_MODE_POLICY,	/* u8 */
>  	ETHTOOL_A_MODULE_POWER_MODE,		/* u8 */
> +	ETHTOOL_A_MODULE_MAX_POWER_SET,		/* u32 */
> +	ETHTOOL_A_MODULE_MIN_POWER_ALLOWED,	/* u32 */
> +	ETHTOOL_A_MODULE_MAX_POWER_ALLOWED,	/* u32 */
> +	ETHTOOL_A_MODULE_MAX_POWER_RESET,	/* u8 */

flag ?

> @@ -77,6 +86,7 @@ static int module_fill_reply(struct sk_buff *skb,
>  			     const struct ethnl_reply_data *reply_base)
>  {
>  	const struct module_reply_data *data = MODULE_REPDATA(reply_base);
> +	u32 temp;

tmp ? temp sounds too much like temperature in context of power

>  static int
>  ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
>  {
>  	struct ethtool_module_power_params power = {};
>  	struct ethtool_module_power_params power_new;
> -	const struct ethtool_ops *ops;
>  	struct net_device *dev = req_info->dev;
>  	struct nlattr **tb = info->attrs;
> +	const struct ethtool_ops *ops;
>  	int ret;
> +	bool mod;
>  
>  	ops = dev->ethtool_ops;
>  
> -	power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
>  	ret = ops->get_module_power_cfg(dev, &power, info->extack);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (power_new.policy == power.policy)
> +	power_new.max_pwr_set = power.max_pwr_set;
> +	power_new.policy = power.policy;
> +
> +	ethnl_update_u32(&power_new.max_pwr_set,
> +			 tb[ETHTOOL_A_MODULE_MAX_POWER_SET], &mod);
> +	if (mod) {

I think we can use if (tb[ETHTOOL_A_MODULE_MAX_POWER_SET]) here
Less error prone for future additions.

> +		if (power_new.max_pwr_set > power.max_pwr_allowed) {
> +			NL_SET_ERR_MSG(info->extack, "Provided value is higher than maximum allowed");

NL_SET_ERR_MSG_ATTR() to point at the bad attribute.

> +			return -EINVAL;

ERANGE?

> +		} else if (power_new.max_pwr_set < power.min_pwr_allowed) {
> +			NL_SET_ERR_MSG(info->extack, "Provided value is lower than minimum allowed");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ethnl_update_policy(&power_new.policy,
> +			    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY], &mod);
> +	ethnl_update_u8(&power_new.max_pwr_reset,
> +			tb[ETHTOOL_A_MODULE_MAX_POWER_RESET], &mod);

I reckon reset should not be allowed if none of the max_pwr values 
are set (i.e. most likely driver doesn't support the config)?

> +	if (!mod)
>  		return 0;
>  
> +	if (power_new.max_pwr_reset && power_new.max_pwr_set) {

Mmm. How is that gonna work? The driver is going to set max_pwr_set
to what's currently configured. So the user is expected to send
ETHTOOL_A_MODULE_MAX_POWER_SET = 0
ETHTOOL_A_MODULE_MAX_POWER_RESET = 1
to reset?

Just:

	if (tb[ETHTOOL_A_MODULE_MAX_POWER_RESET] &&
	    tb[ETHTOOL_A_MODULE_MAX_POWER_SET])

And you can validate this before doing any real work.

> +		NL_SET_ERR_MSG(info->extack, "Maximum power set and reset cannot be used at the same time");
> +		return 0;
> +	}
> +
>  	ret = ops->set_module_power_cfg(dev, &power_new, info->extack);
>  	return ret < 0 ? ret : 1;
>  }
-- 
pw-bot: cr


