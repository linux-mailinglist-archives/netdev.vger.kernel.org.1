Return-Path: <netdev+bounces-179073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66611A7A5E9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EBF3A580B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9F24C080;
	Thu,  3 Apr 2025 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pfuotEMN"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A2288A2
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692606; cv=none; b=UT7a9/9a1XnS31qz4Cwut1g3ec5Cjbvg+enDDTH24ywD4fj0UmgX0iF+U07LAxUBQpnx6BqriYY0AfixWkVSbL3ejDW7bgpR7ET7NY8GURQSsI5nU6ITgcGShdHxzI/ZJhzu1o+VBNDwX2YXI+ZhIIAQP1fmPrpe/d/CdYnB7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692606; c=relaxed/simple;
	bh=wk65qn9p9GsX3oqQC/NBKSw2IOJdFq463ncKexh3iFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdfDRshP3NQfalLpicMurdvehhoE1ZvT6OyaSC5QqCTMshdsOL2IhNwHXJd+uElK8dNVmiZZNzpIIuZEU3HSdrSN3VCGAuTM+tAqJolF1k+HwhMLK3LB5hxuPBV5ABPzpFNPB/tzG1r1WDj/fZ+U3JPJ7BwQlbHVuAEbDJyho0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pfuotEMN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B3A8D13801B6;
	Thu,  3 Apr 2025 11:03:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743692603; x=1743779003; bh=EQFvJwkP6VeAQja9Q6v64hTg45t1biUr7d2
	vxNGzNus=; b=pfuotEMNiDFwq0qdiALf8JTr/HTzDzLyI72TSysdqQREpFNKA5W
	jrWWxDNzQzl8N5O7M/ap1v8hvGyLJrbRX069ltT0GQG6rqaLsrQ0MD43iCfR1ymN
	6jT9oDUj4WUTg4ogGptt/wudw5URNDe+faTojWMd0M2X28K36hMwywLs6r2pCri7
	k5HrQX4WWbdy2gneQ4aRVSzMgFsX2Gmuc0/zpPXBj5Gp55KjgviTTsmdFApcz85c
	CfToR5wLgZZMH+DagiLBfzeIr0M8xTD3QxYJf+SrxNNUuJzemA5gVpE87wyPzUeW
	K4kffi+TQ78I4iezsT+qK9AJFY66Eop94nQ==
X-ME-Sender: <xms:O6PuZ1FqrycCE-lF3qv9SmObciP5RUAYRZwxsyqcNmwXMaBLYNA2tA>
    <xme:O6PuZ6Um1wchPOP68A7a-IqywYYD7weAbYhfCC4MTzSXazI1u0tx_U-WUhJWU7KkQ
    Rd-VeXnqRfNgcU>
X-ME-Received: <xmr:O6PuZ3IK0FDXCeqljg7U6GVSCSMu1r5KVvIcYohyeXAgYcan-RA9-_X5qJr9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvghlrd
    gthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghllh
    gvrhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:O6PuZ7FK8hP9bH9MQIyyZwyT465H_ezYg35iqoRRrf_lV1BGsWdygw>
    <xmx:O6PuZ7WXtMKDlwZ0SOnOa4nyy6IYxzPG42OJpsXw9I3yTh8k0g1J8Q>
    <xmx:O6PuZ2PS83jp7ilnToox4ph7Hklq8axxydnElKa8XJ6BACVqE9eMRg>
    <xmx:O6PuZ60Xt851v2eQeSjoIozLYxunN72p5UQaBnfqhLYd6P09oS5NKw>
    <xmx:O6PuZ1s3yB1fqXEYeTFr0yuGLJ2byCN7MfowyFWafhw5nvEqIapokFfi>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 11:03:22 -0400 (EDT)
Date: Thu, 3 Apr 2025 18:03:19 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	horms@kernel.org, danieller@nvidia.com,
	damodharam.ammepalli@broadcom.com, andrew.gospodarek@broadcom.com,
	petrm@nvidia.com
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated
 read_write_len_ext
Message-ID: <Z-6jN7aA8ZnYRH6j@shredder>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402183123.321036-3-michael.chan@broadcom.com>

Adding Petr given Danielle is away

On Wed, Apr 02, 2025 at 11:31:23AM -0700, Michael Chan wrote:
> From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> For EPL (Extended Payload), the maximum calculated size returned by
> ethtool_cmis_get_max_epl_size() is 2048, so the read_write_len_ext
> field in struct ethtool_cmis_cdb_cmd_args needs to be changed to u16
> to hold the value.
> 
> To avoid confusion with other u8 read_write_len_ext fields defined
> by the CMIS spec, change the field name to calc_read_write_len_ext.
> 
> Without this change, module flashing can fail:
> 
> Transceiver module firmware flashing started for device enp177s0np0
> Transceiver module firmware flashing in progress for device enp177s0np0
> Progress: 0%
> Transceiver module firmware flashing encountered an error for device enp177s0np0
> Status message: Write FW block EPL command failed, LPL length is longer
> 	than CDB read write length extension allows.
> 
> Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  net/ethtool/cmis.h     | 7 ++++---
>  net/ethtool/cmis_cdb.c | 8 ++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> index 1e790413db0e..51f5d5439e2a 100644
> --- a/net/ethtool/cmis.h
> +++ b/net/ethtool/cmis.h
> @@ -63,8 +63,9 @@ struct ethtool_cmis_cdb_request {
>   * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
>   * @req: CDB command fields as described in the CMIS standard.
>   * @max_duration: Maximum duration time for command completion in msec.
> - * @read_write_len_ext: Allowable additional number of byte octets to the LPL
> - *			in a READ or a WRITE commands.
> + * @calc_read_write_len_ext: Calculated allowable additional number of byte
> + *			     octets to the LPL or EPL in a READ or WRITE CDB
> + *			     command.
>   * @msleep_pre_rpl: Waiting time before checking reply in msec.
>   * @rpl_exp_len: Expected reply length in bytes.
>   * @flags: Validation flags for CDB commands.
> @@ -73,7 +74,7 @@ struct ethtool_cmis_cdb_request {
>  struct ethtool_cmis_cdb_cmd_args {
>  	struct ethtool_cmis_cdb_request req;
>  	u16				max_duration;
> -	u8				read_write_len_ext;
> +	u16				calc_read_write_len_ext;
>  	u8				msleep_pre_rpl;
>  	u8                              rpl_exp_len;
>  	u8				flags;
> diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> index dba3aa909a95..1f487e1a6347 100644
> --- a/net/ethtool/cmis_cdb.c
> +++ b/net/ethtool/cmis_cdb.c
> @@ -35,13 +35,13 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
>  	args->req.lpl_len = lpl_len;
>  	if (lpl) {
>  		memcpy(args->req.payload, lpl, args->req.lpl_len);
> -		args->read_write_len_ext =
> +		args->calc_read_write_len_ext =
>  			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
>  	}
>  	if (epl) {
>  		args->req.epl_len = cpu_to_be16(epl_len);
>  		args->req.epl = epl;
> -		args->read_write_len_ext =
> +		args->calc_read_write_len_ext =
>  			ethtool_cmis_get_max_epl_size(read_write_len_ext);

AFAIU, a size larger than a page (128 bytes) is only useful when auto
paging is supported which is something the kernel doesn't currently
support. Therefore, I think it's misleading to initialize this field to
a value larger than 128.

How about deleting ethtool_cmis_get_max_epl_size() and moving the
initialization of 'args->read_write_len_ext' outside of the if block as
it was before 9a3b0d078bd82?

>  	}
>  
> @@ -590,7 +590,7 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
>  			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
>  			bytes_to_write = min_t(u16, bytes_left,
>  					       min_t(u16, space_left,
> -						     args->read_write_len_ext));
> +						     args->calc_read_write_len_ext));
>  
>  			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
>  							     page, offset,
> @@ -631,7 +631,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
>  				       offsetof(struct ethtool_cmis_cdb_request,
>  						epl));
>  
> -	if (args->req.lpl_len > args->read_write_len_ext) {
> +	if (args->req.lpl_len > args->calc_read_write_len_ext) {
>  		args->err_msg = "LPL length is longer than CDB read write length extension allows";
>  		return -EINVAL;
>  	}
> -- 
> 2.30.1
> 
> 

