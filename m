Return-Path: <netdev+bounces-55147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE780991A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A22D1F210F7
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFB187A;
	Fri,  8 Dec 2023 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgsDChF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA561FA1
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246D6C433C7;
	Fri,  8 Dec 2023 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702001982;
	bh=/lWXkcNsUc0WJFzGR2CBLDIv363YHTbMT2NsqTQvPI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pgsDChF6vMySzLMZLIj1+SpMxxoBhLvgsSQeSuyna6v2yLn5fay0HpC0iSNvW3F/+
	 bkNDS6Iek/H/Du33JH7pwZIyIVNlKMSllTkCJkcZGCifnamNSGSPJgzX+eGD3PUHZt
	 FjoCZQJIFt54bnMXzrGJ5YdJa0yP5Ne8SZdXnpN0bHUAQk+aMayTHmDOUkEgjBzcd8
	 /Lzf/T62lzJBoujvShhIApD8+oy73kSV5HhOOH3HgVqzlOFSz9467aCn7GcQEHk0MQ
	 uuPgyWSXavLsDAfhYcyuM7Lr4kdCxClWjMcElWbKZWLB8LtSj4pQ9Q2AbvmssdpKU2
	 GUR0Wf/uqG5KQ==
Date: Thu, 7 Dec 2023 18:19:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
 <horms@kernel.org>, <leon@kernel.org>, "Pucha Himasekhar Reddy"
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v5 2/5] ice: configure FW logging
Message-ID: <20231207181941.2b16a380@kernel.org>
In-Reply-To: <75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
References: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
	<20231205211251.2122874-3-anthony.l.nguyen@intel.com>
	<20231206195304.6226771d@kernel.org>
	<75bc978a-8184-ffa3-911e-cceacf8adcd0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 16:28:27 -0800 Paul M Stillwell Jr wrote:
> On 12/6/2023 7:53 PM, Jakub Kicinski wrote:
> > On Tue,  5 Dec 2023 13:12:45 -0800 Tony Nguyen wrote:  
> >> +/**
> >> + * ice_debugfs_parse_cmd_line - Parse the command line that was passed in
> >> + * @src: pointer to a buffer holding the command line
> >> + * @len: size of the buffer in bytes
> >> + * @argv: pointer to store the command line items
> >> + * @argc: pointer to store the number of command line items
> >> + */
> >> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
> >> +					  char ***argv, int *argc)
> >> +{
> >> +	char *cmd_buf, *cmd_buf_tmp;
> >> +
> >> +	cmd_buf = memdup_user(src, len);
> >> +	if (IS_ERR(cmd_buf))
> >> +		return PTR_ERR(cmd_buf);
> >> +	cmd_buf[len] = '\0';
> >> +
> >> +	/* the cmd_buf has a newline at the end of the command so
> >> +	 * remove it
> >> +	 */
> >> +	cmd_buf_tmp = strchr(cmd_buf, '\n');
> >> +	if (cmd_buf_tmp) {
> >> +		*cmd_buf_tmp = '\0';
> >> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf;
> >> +	}
> >> +
> >> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
> >> +	kfree(cmd_buf);
> >> +	if (!*argv)
> >> +		return -ENOMEM;  
> > 
> > I haven't spotted a single caller wanting this full argc/argv parsing.
> > Can we please not add this complexity until its really needed?
> >   
> 
> I can remove it, but I use it in all the _write functions. I use the 
> argc to make sure I'm only getting one value to a write and I use 
> argv[0] to deal with the value.
> 
> Honestly I'm not sure how valuable it is to check for a single argument, 
> but I'm fairly certain our validation team will file a bug if they pass 
> more than one argument and something happens :)

Just eyeballing the code - you'd still accept

  echo -e 'val1\0val2' > file

right? :) Perhaps less like that validation would come up with that
but even the standard debugfs implementations don't seem to care too
much (example of bool file in netdevsim):

# cat bpf_bind_accept
Y
# echo 'nbla' > bpf_bind_accept
# echo $?
0
# cat bpf_bind_accept
N

> Examples of using argv are on lines 358 and 466 of ice_debugfs.c
> 
> I'm open to changing it, just not sure to what
> 
> >> +/**
> >> + * ice_debugfs_module_read - read from 'module' file
> >> + * @filp: the opened file
> >> + * @buffer: where to write the data for the user to read
> >> + * @count: the size of the user's buffer
> >> + * @ppos: file position offset
> >> + */
> >> +static ssize_t ice_debugfs_module_read(struct file *filp, char __user *buffer,
> >> +				       size_t count, loff_t *ppos)
> >> +{
> >> +	struct dentry *dentry = filp->f_path.dentry;
> >> +	struct ice_pf *pf = filp->private_data;
> >> +	int status, module;
> >> +	char *data = NULL;
> >> +
> >> +	/* don't allow commands if the FW doesn't support it */
> >> +	if (!ice_fwlog_supported(&pf->hw))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	module = ice_find_module_by_dentry(pf, dentry);
> >> +	if (module < 0) {
> >> +		dev_info(ice_pf_to_dev(pf), "unknown module\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	data = vzalloc(ICE_AQ_MAX_BUF_LEN);
> >> +	if (!data) {
> >> +		dev_warn(ice_pf_to_dev(pf), "Unable to allocate memory for FW configuration!\n");
> >> +		return -ENOMEM;  
> > 
> > Can we use seq_print() here? It should simplify the reading quite a bit,
> > not sure how well it works with files that can also be written, tho.
> >   
> 
> I'm probably missing something here, but how do we get more simple than 
> snprintf? I have a function (ice_fwlog_print_module_cfg) that handles 
> whether the user has passed a single module ID or they want data on all 
> the modules, but it all boils down to snprintf.

You need to vzalloc() and worry about it overflowing.

> I could get rid of ice_fwlog_print_module_cfg() and replace it inline 
> with the if/else code if that would be clearer, but I'm not sure 
> seq_printf() is helpful because each file is a single quantum of 
> information (with the exception of the file that represents all the 
> modules). I created a special file to represent all the modules, but 
> maybe it's more confusing and I should get rid of it and just make the 
> users specify all of the modules in a script.
> 
> Would that be easier? Then there is no if/else it's just a single snprintf.

The value of seq_print() here is the fact it will handle the memory
allocation and copying to user space for you. Ignore the "seq"
in the name.

