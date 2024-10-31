Return-Path: <netdev+bounces-140576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C59B7130
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A089B1F21AC8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597CC2FD;
	Thu, 31 Oct 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4V5Qp12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF7360;
	Thu, 31 Oct 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334714; cv=none; b=hxdvvkq7dTElTDQFrIw4917wqSt+yPXc7thcGTUOW/7dqwZFfpwHWE4rgZN6uF9XPN0GMZam+nbwIISAtYW/B66lD1tSWhlnlN0G1J0c855kikA+GWZwDJj7FEeGgSXiyM0ihGHTO9rsqSyRCKJQ0pWK4NjxomzCX6jtl2D4l74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334714; c=relaxed/simple;
	bh=A4dRY4eH4YbXkwbpbPcRMGQgIKn3Mq9XborynAEqih4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6HIn6zfJXd32evUFz+xSYN4m8SiCu9qHAzUe9wy+ijcEiwwIzYcilY3uq0gQ/pOoCqh77BUu5IJDhJRiXVzIEsL07J0zl9UgP8qfpXeQtklQMlC0d1Vw58+jkP/nAub5NeMqQ3sl3gYjaHnlUbJ8H37JQEncfDzmiE3UR2dR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4V5Qp12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29394C4CECE;
	Thu, 31 Oct 2024 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730334714;
	bh=A4dRY4eH4YbXkwbpbPcRMGQgIKn3Mq9XborynAEqih4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4V5Qp12LY5EeOcgR0buUcw72ZwRGWsulAbVYjtJtpNpcAfefeNEOjOwIGd9T+c+N
	 kOp5GNxGL8C5ruWRPeTaljv4JWHN0XcNBsS7v/5LcQx9q5CU1HJzSh3q7x5mhrmTmy
	 PqNFDiwbcUNVA3HJmeSVWsuBVAtVloqwqomQmFNsgS6xDhriobUC0XrwmNAIU4B2ck
	 /uzCcxKc8uwYmWmpPng1togWANntCnbBqlNhkT3l4xc/LuGXrUACE6nyykORIocjrr
	 LCLmh5h9RKgqZXcNMjpAOWN2eDpERQTmX6IiypxFhJCK8jyOeZfKZrtlARrCdct5NI
	 NyqXxIpLS0oJQ==
Date: Wed, 30 Oct 2024 17:31:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, kernel-team@meta.com, Thomas Huth
 <thuth@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 Xiongwei Song <xiongwei.song@windriver.com>, Mina Almasry
 <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list),
 netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: Re: [PATCH net-next v4] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241030173152.0349b466@kernel.org>
In-Reply-To: <20241023113819.3395078-1-leitao@debian.org>
References: <20241023113819.3395078-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 04:38:01 -0700 Breno Leitao wrote:
> +- fail_skb_realloc
> +
> +  inject skb (socket buffer) reallocation events into the network path. The
> +  primary goal is to identify and prevent issues related to pointer
> +  mismanagement in the network subsystem.  By forcing skb reallocation at
> +  strategic points, this feature creates scenarios where existing pointers to
> +  skb headers become invalid.
> +
> +  When the fault is injected and the reallocation is triggered, these pointers

s/these pointers/cached pointers to skb headers and data/

> +  no longer reference valid memory locations. This deliberate invalidation
> +  helps expose code paths where proper pointer updating is neglected after a
> +  reallocation event.
> +
> +  By creating these controlled fault scenarios, the system can catch instances
> +  where stale pointers are used, potentially leading to memory corruption or
> +  system instability.
> +
> +  To select the interface to act on, write the network name to the following file:
> +  `/sys/kernel/debug/fail_skb_realloc/devname`
> +  If this field is left empty (which is the default value), skb reallocation
> +  will be forced on all network interfaces.

Should we mention here that KASAN or some such is needed to catch 
the bugs? Chances are the resulting UAF will not crash and go unnoticed
without KASAN.

>  - NVMe fault injection
>  
>    inject NVMe status code and retry flag on devices permitted by setting
> @@ -216,6 +238,19 @@ configuration of fault-injection capabilities.
>  	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
>  	$ printf %#x -12 > retval
>  
> +- /sys/kernel/debug/fail_skb_realloc/devname:
> +
> +        Specifies the network interface on which to force SKB reallocation.  If
> +        left empty, SKB reallocation will be applied to all network interfaces.
> +
> +        Example usage::
> +
> +          # Force skb reallocation on eth0
> +          echo "eth0" > /sys/kernel/debug/fail_skb_realloc/devname
> +
> +          # Clear the selection and force skb reallocation on all interfaces
> +          echo "" > /sys/kernel/debug/fail_skb_realloc/devname
> +
>  Boot option
>  ^^^^^^^^^^^
>  
> @@ -227,6 +262,7 @@ use the boot option::
>  	fail_usercopy=
>  	fail_make_request=
>  	fail_futex=
> +	fail_skb_realloc=
>  	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
>  
>  proc entries
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 48f1e0fa2a13..285e36a5e5d7 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2681,6 +2681,12 @@ static inline void skb_assert_len(struct sk_buff *skb)
>  #endif /* CONFIG_DEBUG_NET */
>  }
>  
> +#if defined(CONFIG_FAIL_SKB_REALLOC)
> +void skb_might_realloc(struct sk_buff *skb);
> +#else
> +static inline void skb_might_realloc(struct sk_buff *skb) {}
> +#endif
> +
>  /*
>   *	Add data to an sk_buff
>   */
> @@ -2781,6 +2787,7 @@ static inline enum skb_drop_reason
>  pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
>  {
>  	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
> +	skb_might_realloc(skb);
>  
>  	if (likely(len <= skb_headlen(skb)))
>  		return SKB_NOT_DROPPED_YET;
> @@ -3216,6 +3223,7 @@ static inline int __pskb_trim(struct sk_buff *skb, unsigned int len)
>  
>  static inline int pskb_trim(struct sk_buff *skb, unsigned int len)
>  {
> +	skb_might_realloc(skb);
>  	return (len < skb->len) ? __pskb_trim(skb, len) : 0;
>  }
>  
> @@ -3970,6 +3978,7 @@ int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
>  
>  static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
>  {
> +	skb_might_realloc(skb);
>  	if (likely(len >= skb->len))
>  		return 0;
>  	return pskb_trim_rcsum_slow(skb, len);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7315f643817a..52bb27115185 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2115,6 +2115,16 @@ config FAIL_SUNRPC
>  	  Provide fault-injection capability for SunRPC and
>  	  its consumers.
>  
> +config FAIL_SKB_REALLOC
> +	bool "Fault-injection capability forcing skb to reallocate"
> +	depends on FAULT_INJECTION_DEBUG_FS
> +	help
> +	  Provide fault-injection capability that forces the skb to be
> +	  reallocated, caughting possible invalid pointers to the skb.

catching

> +	  For more information, check
> +	  Documentation/dev-tools/fault-injection/fault-injection.rst
> +
>  config FAULT_INJECTION_CONFIGFS
>  	bool "Configfs interface for fault-injection capabilities"
>  	depends on FAULT_INJECTION
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 5a72a87ee0f1..d9326600e289 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_OF)	+= of_net.o
>  obj-$(CONFIG_NET_TEST) += net_test.o
>  obj-$(CONFIG_NET_DEVMEM) += devmem.o
>  obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
> +obj-$(CONFIG_FAIL_SKB_REALLOC) += skb_fault_injection.o
> diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
> new file mode 100644
> index 000000000000..21b0ea48c139
> --- /dev/null
> +++ b/net/core/skb_fault_injection.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/fault-inject.h>
> +#include <linux/netdevice.h>
> +#include <linux/debugfs.h>
> +#include <linux/skbuff.h>

alphabetic sort, please?

> +static struct {
> +	struct fault_attr attr;
> +	char devname[IFNAMSIZ];
> +	bool filtered;
> +} skb_realloc = {
> +	.attr = FAULT_ATTR_INITIALIZER,
> +	.filtered = false,
> +};
> +
> +static bool should_fail_net_realloc_skb(struct sk_buff *skb)
> +{
> +	struct net_device *net = skb->dev;
> +
> +	if (skb_realloc.filtered &&
> +	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
> +		/* device name filter set, but names do not match */
> +		return false;
> +
> +	if (!should_fail(&skb_realloc.attr, 1))
> +		return false;
> +
> +	return true;
> +}
> +ALLOW_ERROR_INJECTION(should_fail_net_realloc_skb, TRUE);
> +
> +void skb_might_realloc(struct sk_buff *skb)
> +{
> +	if (!should_fail_net_realloc_skb(skb))
> +		return;
> +
> +	pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
> +}
> +EXPORT_SYMBOL(skb_might_realloc);
> +
> +static int __init fail_skb_realloc_setup(char *str)
> +{
> +	return setup_fault_attr(&skb_realloc.attr, str);
> +}
> +__setup("fail_skb_realloc=", fail_skb_realloc_setup);
> +
> +static void reset_settings(void)
> +{
> +	skb_realloc.filtered = false;
> +	memzero_explicit(&skb_realloc.devname, IFNAMSIZ);

why _explicit ?

> +}
> +
> +static ssize_t devname_write(struct file *file, const char __user *buffer,
> +			     size_t count, loff_t *ppos)
> +{
> +	ssize_t ret;
> +
> +	reset_settings();
> +	ret = simple_write_to_buffer(&skb_realloc.devname, IFNAMSIZ,
> +				     ppos, buffer, count);
> +	if (ret < 0)
> +		return ret;

the buffer needs to be null terminated, like:

skb_realloc.devname[IFNAMSIZ - 1] = '\0';

no?

> +	strim(skb_realloc.devname);
> +
> +	if (strnlen(skb_realloc.devname, IFNAMSIZ))
> +		skb_realloc.filtered = true;
> +
> +	return count;
> +}
> +
> +static ssize_t devname_read(struct file *file,
> +			    char __user *buffer,
> +			    size_t size, loff_t *ppos)
> +{
> +	if (!skb_realloc.filtered)
> +		return 0;
> +
> +	return simple_read_from_buffer(buffer, size, ppos, &skb_realloc.devname,
> +				       strlen(skb_realloc.devname));
> +}
> +
> +static const struct file_operations devname_ops = {
> +	.write = devname_write,
> +	.read = devname_read,
> +};
> +
> +static int __init fail_skb_realloc_debugfs(void)
> +{
> +	umode_t mode = S_IFREG | 0600;
> +	struct dentry *dir;
> +
> +	dir = fault_create_debugfs_attr("fail_skb_realloc", NULL,
> +					&skb_realloc.attr);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);
> +
> +	debugfs_create_file("devname", mode, dir, NULL, &devname_ops);
> +
> +	return 0;
> +}
> +
> +late_initcall(fail_skb_realloc_debugfs);
-- 
pw-bot: cr

