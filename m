Return-Path: <netdev+bounces-54726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D47807F57
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7643D281280
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF44A5387;
	Thu,  7 Dec 2023 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/tGkLRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF0185A
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 03:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759FC433C7;
	Thu,  7 Dec 2023 03:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701921186;
	bh=kP5s8dJo3I5YXtaVyXFjAWF2jh90w4jxPLcWDxmMefw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c/tGkLRn5j6bNuivFyAtLjZDqAvU+yl5Vu7Mt2WiRvrN9j7gMkaturF97axlt+Te5
	 wYTam5VzNtnLn+xXGjPDEzUhAeqk4yI78qW7a0JadTaX7UpS5V/CG05xcFPki2HWSl
	 DimBU0QE4q1snsNX9iUb6WVAgKgSO7ncJcRhuxyhcCg48xOjGfaxjqmiq76d0tKKS2
	 PBHFgyeTLndi1irHgdWFEXeY7y12apqhzkiWRAauj4Fidajw/Dt6vKD5ZWP/lttNDr
	 /LBciwE+vWZ4nT3hAAAtymuHqKcfAdTDJPpqzIVWs9u6Hncm0P0Qpfq0C5dAGDDRQq
	 fLKL5PRLfrB4Q==
Date: Wed, 6 Dec 2023 19:53:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Paul M Stillwell Jr
 <paul.m.stillwell.jr@intel.com>, jacob.e.keller@intel.com,
 vaishnavi.tipireddy@intel.com, horms@kernel.org, leon@kernel.org, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
Message-ID: <20231206195304.6226771d@kernel.org>
In-Reply-To: <20231205211251.2122874-3-anthony.l.nguyen@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
	<20231205211251.2122874-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 13:12:45 -0800 Tony Nguyen wrote:
> +/**
> + * ice_debugfs_parse_cmd_line - Parse the command line that was passed in
> + * @src: pointer to a buffer holding the command line
> + * @len: size of the buffer in bytes
> + * @argv: pointer to store the command line items
> + * @argc: pointer to store the number of command line items
> + */
> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
> +					  char ***argv, int *argc)
> +{
> +	char *cmd_buf, *cmd_buf_tmp;
> +
> +	cmd_buf = memdup_user(src, len);
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
> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf;
> +	}
> +
> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
> +	kfree(cmd_buf);
> +	if (!*argv)
> +		return -ENOMEM;

I haven't spotted a single caller wanting this full argc/argv parsing.
Can we please not add this complexity until its really needed?

> +/**
> + * ice_debugfs_module_read - read from 'module' file
> + * @filp: the opened file
> + * @buffer: where to write the data for the user to read
> + * @count: the size of the user's buffer
> + * @ppos: file position offset
> + */
> +static ssize_t ice_debugfs_module_read(struct file *filp, char __user *buffer,
> +				       size_t count, loff_t *ppos)
> +{
> +	struct dentry *dentry = filp->f_path.dentry;
> +	struct ice_pf *pf = filp->private_data;
> +	int status, module;
> +	char *data = NULL;
> +
> +	/* don't allow commands if the FW doesn't support it */
> +	if (!ice_fwlog_supported(&pf->hw))
> +		return -EOPNOTSUPP;
> +
> +	module = ice_find_module_by_dentry(pf, dentry);
> +	if (module < 0) {
> +		dev_info(ice_pf_to_dev(pf), "unknown module\n");
> +		return -EINVAL;
> +	}
> +
> +	data = vzalloc(ICE_AQ_MAX_BUF_LEN);
> +	if (!data) {
> +		dev_warn(ice_pf_to_dev(pf), "Unable to allocate memory for FW configuration!\n");
> +		return -ENOMEM;

Can we use seq_print() here? It should simplify the reading quite a bit,
not sure how well it works with files that can also be written, tho.

> +/**
> + * ice_debugfs_fwlog_init - setup the debugfs directory
> + * @pf: the ice that is starting up
> + */
> +void ice_debugfs_fwlog_init(struct ice_pf *pf)
> +{
> +	const char *name = pci_name(pf->pdev);
> +	struct dentry *fw_modules_dir;
> +	struct dentry **fw_modules;
> +	int i;
> +
> +	/* only support fw log commands on PF 0 */
> +	if (pf->hw.bus.func)
> +		return;
> +
> +	/* allocate space for this first because if it fails then we don't
> +	 * need to unwind
> +	 */
> +	fw_modules = kcalloc(ICE_NR_FW_LOG_MODULES, sizeof(*fw_modules),
> +			     GFP_KERNEL);
> +

nit: no new line between call and error check

> +	if (!fw_modules) {
> +		pr_info("Unable to allocate space for modules\n");

no warnings on allocation failures, there will be a splat for GFP_KERNEL
(checkpatch should catch this)

> +		return;
> +	}
> +
> +	pf->ice_debugfs_pf = debugfs_create_dir(name, ice_debugfs_root);
> +	if (IS_ERR(pf->ice_debugfs_pf)) {
> +		pr_info("init of debugfs PCI dir failed\n");
> +		kfree(fw_modules);
> +		return;
> +	}
> +
> +	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
> +						      pf->ice_debugfs_pf);
> +	if (IS_ERR(pf->ice_debugfs_pf)) {
> +		pr_info("init of debugfs fwlog dir failed\n");

If GregKH sees all the info message on debugfs failures he may
complain, DebugFS is supposed to be completely optional.

Also - free fw_modules ?

You probably want to use goto on all error paths here
> +/**
> + * ice_fwlog_get - Get the firmware logging settings
> + * @hw: pointer to the HW structure
> + * @cfg: config to populate based on current firmware logging settings
> + */
> +int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg)
> +{
> +	if (!ice_fwlog_supported(hw))
> +		return -EOPNOTSUPP;
> +
> +	if (!cfg)
> +		return -EINVAL;

can't be, let's avoid defensive programming

> +	return ice_aq_fwlog_get(hw, cfg);


> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
> +{
> +	struct ice_fwlog_module_entry *entries;
> +	struct ice_hw *hw = &pf->hw;
> +
> +	entries = (struct ice_fwlog_module_entry *)hw->fwlog_cfg.module_entries;
> +
> +	entries[module].log_level = log_level;
> +}

Isn't this just 

	hw->fwlog_cfg.module_entries[module].log_level = log_level;

? The cast specifically look alarming but unnecessary.

