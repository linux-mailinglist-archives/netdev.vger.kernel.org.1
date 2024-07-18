Return-Path: <netdev+bounces-112128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F2935246
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EF283820
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177F1459FA;
	Thu, 18 Jul 2024 19:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001343172;
	Thu, 18 Jul 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332448; cv=none; b=KJrPJswt7UBEx5DdqTK2RGM0BH4Lgdx8Kbk139j9El6YFqIbzKuz4nugnlWJLC3cDKTFLLbiIlsy58WM0O5pCXbDZ9k6DqmsVhF19f2mDEvWnllm2a9UhXtWcJxRAXqpSIT0zGbOududWZiBASSTy42uQg8V7h2C5MxHFJzi4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332448; c=relaxed/simple;
	bh=O23ygQLxGQTzVrgon/8V03VQV8n2XPv4x+9//GGBvL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2jogPFQ8QR+g2gkvu0Y7WmbtTlsrT0666uRhSg6OP8Ql4zlyck4KS9ifvj8Ay7raigik9Ci0mYi99lLvZdgVfPbc017D1SyiW08+fT7sbbTN3gLNQOUG0KFD3k3OYE1kzKkpA5ypn2rYEEipHKZ8dmFosHd1L0pA/mL3DFu2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sUXCN-000000000Jf-07Zq;
	Thu, 18 Jul 2024 15:53:55 -0400
Message-ID: <5145c46c47d98d917c8ef1401cdac15fc5f8b638.camel@surriel.com>
Subject: Re: [RFC PATCH 2/2] netconsole: Defer netpoll cleanup to avoid lock
 release during list traversal
From: Rik van Riel <riel@surriel.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
Cc: thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paulmck@kernel.org, davej@codemonkey.org.uk
Date: Thu, 18 Jul 2024 15:53:54 -0400
In-Reply-To: <20240718184311.3950526-3-leitao@debian.org>
References: <20240718184311.3950526-1-leitao@debian.org>
	 <20240718184311.3950526-3-leitao@debian.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-07-18 at 11:43 -0700, Breno Leitao wrote:
>=20
> +/* Clean up every target in the cleanup_list and move the clean
> targets back to the
> + * main target_list.
> + */
> +static void netconsole_process_cleanups_core(void)
> +{
> +	struct netconsole_target *nt, *tmp;
> +	unsigned long flags;
> +
> +	/* The cleanup needs RTNL locked */
> +	ASSERT_RTNL();
> +
> +	mutex_lock(&target_cleanup_list_lock);
> +	list_for_each_entry_safe(nt, tmp, &target_cleanup_list,
> list) {
> +		/* all entries in the cleanup_list needs to be
> disabled */
> +		WARN_ON_ONCE(nt->enabled);
> +		do_netpoll_cleanup(&nt->np);
> +		/* moved the cleaned target to target_list. Need to
> hold both locks */
> +		spin_lock_irqsave(&target_list_lock, flags);
> +		list_move(&nt->list, &target_list);
> +		spin_unlock_irqrestore(&target_list_lock, flags);
> +	}
> +	WARN_ON_ONCE(!list_empty(&target_cleanup_list));
> +	mutex_unlock(&target_cleanup_list_lock);
> +}
> +
> +/* Do the list cleanup with the rtnl lock hold */
> +static void netconsole_process_cleanups(void)
> +{
> +	rtnl_lock();
> +	netconsole_process_cleanups_core();
> +	rtnl_unlock();
> +}
>=20
I've got what may be a dumb question.

If the traversal of the target_cleanup_list happens under
the rtnl_lock, why do you need a new lock, and why is there
a wrapper function that only takes this one lock, and then
calls the other function?

Are you planning a user of netconsole_process_cleanups_core()
that already holds the rtnl_lock and should not use this
wrapper?

Also, the comment does not explain why the rtnl_lock is held.
We can see that it grabs it, but not why. It would be nice to
have that in the comment.



--=20
All Rights Reversed.

