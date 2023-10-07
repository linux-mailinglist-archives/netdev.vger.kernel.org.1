Return-Path: <netdev+bounces-38714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AF7BC332
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A0B2820D6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAB639D;
	Sat,  7 Oct 2023 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeXpa38z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927191360
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BF9C433C8;
	Sat,  7 Oct 2023 00:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696636928;
	bh=TSyZF1el4fQqqyKx5ezefBBFhuaXDKqzOCpQk/WLZ3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VeXpa38zhFlo3JZopb0hlipmns1p+o4vVGyx8RninGi9OHFiMk4QHlB25BRmjM7km
	 fcm1MxJOF8leecJ4w2rLQgS9miAZqRmH+wYCCL/OdDfDbSlxAEWru0NbSEYJFAMvnO
	 X8Mr2a5CLhZeCYrW17l0KXVFzKhE9GwnjCK1KA9RwgpAeGOPscio1kjAFHIZd/OXDI
	 fipMty7K+VviOcUAhfFmEmsuvB6J2F5KPO9lXYtQ/ibQykA8TW3iNziz2XsBnnQ6TT
	 6Hk+69cXRMCK3L8Ajb1xmC/a9t7hqz3rSYNjmAq38NDoSgzpt+0QNKXJdwDH8aB/D2
	 v5VJz9Sl0rzog==
Date: Fri, 6 Oct 2023 17:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, jacob.e.keller@intel.com,
 vaishnavi.tipireddy@intel.com, horms@kernel.org, leon@kernel.org, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
Message-ID: <20231006170206.297687e2@kernel.org>
In-Reply-To: <20231005170110.3221306-3-anthony.l.nguyen@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
	<20231005170110.3221306-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 10:01:07 -0700 Tony Nguyen wrote:
> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
> +					  char ***argv, int *argc)
> +{
> +	char *cmd_buf, *cmd_buf_tmp;
> +
> +	cmd_buf = memdup_user(src, len + 1);

memdup() with len + 1 is quite suspicious, the buffer has length 
of len you shouldn't copy more than that

> +	if (IS_ERR(cmd_buf))
> +		return PTR_ERR(cmd_buf);
> +	cmd_buf[len] = '\0';
> +
> +	/* the cmd_buf has a newline at the end of the command so
> +	 * remove it
> +	 */
> +	cmd_buf_tmp = strchr(cmd_buf, '\n');
> +	if (cmd_buf_tmp) {
> +		*cmd_buf_tmp = '\0';
> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf + 1;
> +	}
> +
> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
> +	if (!*argv)
> +		return -ENOMEM;
> +
> +	kfree(cmd_buf);
> +	return 0;

> +static ssize_t
> +ice_debugfs_module_write(struct file *filp, const char __user *buf,
> +			 size_t count, loff_t *ppos)
> +{
> +	struct ice_pf *pf = filp->private_data;
> +	struct device *dev = ice_pf_to_dev(pf);
> +	ssize_t ret;
> +	char **argv;
> +	int argc;
> +
> +	/* don't allow commands if the FW doesn't support it */
> +	if (!ice_fwlog_supported(&pf->hw))
> +		return -EOPNOTSUPP;
> +
> +	/* don't allow partial writes */
> +	if (*ppos != 0)
> +		return 0;
> +
> +	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
> +	if (ret)
> +		goto err_copy_from_user;
> +
> +	if (argc == 2) {
> +		int module, log_level;
> +
> +		module = sysfs_match_string(ice_fwlog_module_string, argv[0]);
> +		if (module < 0) {
> +			dev_info(dev, "unknown module '%s'\n", argv[0]);
> +			ret = -EINVAL;
> +			goto module_write_error;
> +		}
> +
> +		log_level = sysfs_match_string(ice_fwlog_level_string, argv[1]);
> +		if (log_level < 0) {
> +			dev_info(dev, "unknown log level '%s'\n", argv[1]);
> +			ret = -EINVAL;
> +			goto module_write_error;
> +		}

The parsing looks pretty over-engineered.

You can group the entries into structs like this:

struct something {
	const char *name;
	size_t sz;
	enum whatever value;
};
#define FILL_IN_STH(thing) \
	{ .name = thing, sz = sizeof(thing) - 1, value = ICE_..##thing,}

struct something[] = {
  FILL_IN_STH(ALL),
  FILL_IN_STH(MNG),
  ...
};

but with nicer names

Then just:

for entry in array(..) {
  if !strncmp(input, entry->name, entry->sz) {
    str += entry->sz + 1
    found = entry;
    break
  }
}

> +static ssize_t ice_debugfs_resolution_read(struct file *filp,
> +					   char __user *buffer, size_t count,
> +					   loff_t *ppos)
> +{
> +	struct ice_pf *pf = filp->private_data;
> +	struct ice_hw *hw = &pf->hw;
> +	char buff[32] = {};
> +	int status;
> +
> +	/* don't allow commands if the FW doesn't support it */
> +	if (!ice_fwlog_supported(&pf->hw))
> +		return -EOPNOTSUPP;
> +
> +	snprintf(buff, sizeof(buff), "%d\n",
> +		 hw->fwlog_cfg.log_resolution);
> +
> +	status = simple_read_from_buffer(buffer, count, ppos, buff,
> +					 strlen(buff));
> +
> +	return status;
> +}

> +static ssize_t
> +ice_debugfs_resolution_write(struct file *filp, const char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct ice_pf *pf = filp->private_data;
> +	struct device *dev = ice_pf_to_dev(pf);
> +	struct ice_hw *hw = &pf->hw;
> +	ssize_t ret;
> +	char **argv;
> +	int argc;
> +
> +	/* don't allow commands if the FW doesn't support it */
> +	if (!ice_fwlog_supported(hw))
> +		return -EOPNOTSUPP;
> +
> +	/* don't allow partial writes */
> +	if (*ppos != 0)
> +		return 0;
> +
> +	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
> +	if (ret)
> +		goto err_copy_from_user;

And for the simple params can you try to reuse existing debugfs
helpers? They can already read and write scalars, all you need
is to inject yourself on the write path to update the config
in the device.

