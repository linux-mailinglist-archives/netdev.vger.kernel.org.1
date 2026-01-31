Return-Path: <netdev+bounces-255301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOUYNdpbfWm/RgIAu9opvQ
	(envelope-from <netdev+bounces-255301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:33:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDFFC0055
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07FC1301A38D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E968285418;
	Sat, 31 Jan 2026 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNFZO379"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9B21B9FD;
	Sat, 31 Jan 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823167; cv=none; b=bDZaVxoHj60KhWhL9OrpYuXsFh3t5FEWH3bzc1BAD8VDtVCv4Ef2GE53lrFssOV6w6mvpGyHJXhn5u5N+6dsibnYSQszPxcfwKS5ZtUfDEDNcb4HUuqi68hJAmETfGff6jD2kRDF5CTtfeVdxFe9RdoVRfnhK8EC54lCJ7RQ8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823167; c=relaxed/simple;
	bh=XXQJqSMUmcDekc2b8zCEeE/qVvFCL/inaEXIQzA0m/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8WdrFiqUpUXfZSQYdw42fqb/BX7qYbfHu7PwWQPu3+SnL9xf0xhGm4LxnZLWhckxsZV/Y87I74hC03gNuchYk1qHeKgk4bNIZv+8v7rRs8THBosRP37oW1EQ26JVANZ/PL0gGyLyxfeqRzCYgo4uqacva3Jz+594c1iDi8XzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNFZO379; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5277AC4CEF7;
	Sat, 31 Jan 2026 01:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823166;
	bh=XXQJqSMUmcDekc2b8zCEeE/qVvFCL/inaEXIQzA0m/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RNFZO379t4nWSGqS+WRHoxUXHihSAW8O4LLR600e5U7C7wiTiRJot3PxSMn+cvs9n
	 RHiPlgYLcCkddmXv3bg8Jl3E53W8aqOLU096Rvog0HEIMrj4MTV/DQ2s8HobiiuaMY
	 FaxQVvxxkEXlEYz0WtBXb2Hzyc7vtlM2AtR7/5ZbYXxcsTUVToVZ/N+z+X2Ca2TRzu
	 a0d7ZGqnHxDRUIdPkTSH0tIb9M8Qa4uyVb+L1kWkauggtCY1z9bxu89fTCiuK/8PHO
	 3v2PRILXcbz7/lq3ypFaTzpmklHJu0nFm40q2ovL8tgnAHLa32X5buPbOX8uP7Ccqp
	 eLNdSu4wnSJXQ==
Date: Fri, 30 Jan 2026 17:32:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, pmladek@suse.com, john.ogness@linutronix.de, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <20260130173243.4e3fff89@kernel.org>
In-Reply-To: <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
	<20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,suse.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CDFFC0055
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 06:17:37 -0800 Breno Leitao wrote:
> +config CONSOLE_HAS_EXECUTION_CTX
> +	bool
> +	help
> +	  Selected by console drivers that support execution context
> +	  (task name/CPU) in their output. This enables PRINTK_EXECUTION_CTX
> +	  to provide the necessary infrastructure.
> +
> +config PRINTK_EXECUTION_CTX
> +	bool "Include execution context (task/CPU) in printk messages"
> +	depends on PRINTK && CONSOLE_HAS_EXECUTION_CTX
> +	default CONSOLE_HAS_EXECUTION_CTX

AFAIU the double-symbol thing serves no practical purpose?
If none of the console drivers uses the metadata what would be the
point of capturing it?

Conversely if some console driver wants this data there's no option 
for the user to disable it.

AFAICT this patch should only add one invisible symbol for capturing
the context and have netcons enable it. I don't see a reason at this
stage to prompt users with netcons disabled whether they want
PRINTK_EXECUTION_CTX
-- 
pw-bot: cr

