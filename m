Return-Path: <netdev+bounces-198664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6714ADCFEC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD9B404C17
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6C2E54A6;
	Tue, 17 Jun 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LZl04bOv"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E832EF645
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170100; cv=none; b=C9WpobriuH3It52z6oO4/4hc5ABKFcMGc3NoEdR6ssh29zFx+lvzwwy2fqz3u5K5mjH0rDGAxNUt75mKH/EFLg8C3UMXkFa2rGR/DDIyfbFnHgf98nXZoOsjxzZk1HwssU7wWchKJjQFzu43n8FKd9QkUAnjsf1Jl5rvBEWFOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170100; c=relaxed/simple;
	bh=AZWXB/ykdamlHFDC/7V/qHTPDvoDehZI0upeuZoPV8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0dn0UQyAN3KCYUNOhpqxpggor+xRwWis+gEq2tFylRZDCQNsY7JjZojhsatxzMTlwND3FhQQE13ZWD+du0e6wyILVAT3CCMiUFqa4y8C9CI7WA0dDW84ICIwfuKmeFWGqgy9uH3CwiYLjPXQ3RpTv5Zsj/zKoF0aTRT/UtyJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LZl04bOv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7B3DOktzYovJCmPUCVseKxm7t31LjvpopexPRu1iesg=; b=LZl04bOvuW9U/rmIAuGS/eVdUQ
	3nLpAOT+6VVdbyoBDfYMoI35zzYyXFYc+OXHTIEXqQbwBukRCKnGq1JVTEnrfDZTAxIOUJzgX/Zpb
	Dt4s0DRUFIY/XimqU+KYYKa6Efmr2StUB4NngqCBgIKOlHS2LBWAhWZfCIcgbzfEfo90L5npYsoJ9
	JXL+wafbyXKf+77PuSBMwakpViMGz7lnPUAX0TAL2PepbNGb23yfwlJBBcctuC3wu8zJ8sStmV05F
	E9Q8pE4UUz200KgJNXrPdUc+zZ0QxavFULg4QzikPA//uWdUslBiR2hcPm4BZVcO9YpuXAAcsXPMR
	yX6f8k9Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uRXBf-000Gcc-2h;
	Tue, 17 Jun 2025 16:21:19 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uRXBf-00034Z-06;
	Tue, 17 Jun 2025 16:21:19 +0200
Message-ID: <cc84011a-0170-42c6-8e85-d789551beab6@iogearbox.net>
Date: Tue, 17 Jun 2025 16:21:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] neighbor: Add NTF_EXT_VALIDATED flag for
 externally validated entries
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 donald.hunter@gmail.com, petrm@nvidia.com, razor@blackwall.org
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-2-idosch@nvidia.com>
 <08c51b7a-0e6d-45b4-81a3-cb3062eb855d@iogearbox.net>
 <aFF3IkVNCPANpSM7@shredder>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aFF3IkVNCPANpSM7@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27671/Tue Jun 17 10:47:08 2025)

Hi Ido,

On 6/17/25 4:09 PM, Ido Schimmel wrote:
> On Fri, Jun 13, 2025 at 10:23:26AM +0200, Daniel Borkmann wrote:
>> On 6/11/25 4:15 PM, Ido Schimmel wrote:
>>> In the above scheme, when the control plane (e.g., FRR) advertises a
>>> neighbor entry with a proxy indication, it expects the corresponding
>>> entry in the data plane (i.e., the kernel) to remain valid and not be
>>> removed due to garbage collection. The control plane also expects the
>>> kernel to notify it if the entry was learned locally (i.e., became
>>> "reachable") so that it will remove the proxy indication from the EVPN
>>> MAC/IP advertisement route. That is why these entries cannot be
>>> programmed with dummy states such as "permanent" or "noarp".
>>
>> Meaning, in contrast to "permanent" the initial user-provided lladdr
>> can still be updated by the kernel if it learned that there was a
>> migration, right?
> 
> Yes. In addition, user space will be notified when the kernel locally
> learns the entry. FRR installs such entries as "stale" and a
> notification will be emitted when they transition to "reachable".

Thanks for clarifying, perhaps makes sense to mention this bit in the
commit message also in v2.

>>> Instead, add a new neighbor flag ("extern_valid") which indicates that
>>> the entry was learned and determined to be valid externally and should
>>> not be removed or invalidated by the kernel. The kernel can probe the
>>> entry and notify user space when it becomes "reachable". However, if the
>>> kernel does not receive a confirmation, have it return the entry to the
>>> "stale" state instead of the "failed" state.
>>>
>>> In other words, an entry marked with the "extern_valid" flag behaves
>>> like any other dynamically learned entry other than the fact that the
>>> kernel cannot remove or invalidate it.
>>
>> How is the expected neigh_flush_dev() behavior? I presume in that case if
>> the neigh entry is in use and was NUD_STALE then we go into NUD_NONE state
>> right? (Asking as NUD_PERMANENT skips all that and whether that should be
>> similar or not for NTF_EXT_VALIDATED?)
> 
> Currently, unlike "permanent" entries, such entries will be flushed when
> the interface loses its carrier. Given the description of "[...] behaves
> like any other dynamically learned entry other than the fact that the
> kernel cannot remove or invalidate it" I think it makes sense to not
> flush such entries when the carrier goes down.

Yeah agree given the user intent that would make sense imho otherwise
you'd need some additional watcher to then reinstall if that happens.

> Like "permanent" entries, such entries will be flushed when the
> interface is put administratively down or when its MAC changes, both of
> which are user initiated actions.
> 
> IOW, I will squash the following diff and add test cases.

lgtm!

>   static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
> -                           bool skip_perm)
> +                           bool skip_perm_ext_valid)
>   {
>          struct hlist_head *dev_head;
>          struct hlist_node *tmp;
> @@ -378,7 +388,9 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>          dev_head = neigh_get_dev_table(dev, tbl->family);
>   
>          hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
> -               if (skip_perm && n->nud_state & NUD_PERMANENT)
> +               if (skip_perm_ext_valid &&
> +                   (n->nud_state & NUD_PERMANENT ||
> +                    n->flags & NTF_EXT_VALIDATED))
>                          continue;
>   
>                  hlist_del_rcu(&n->hash);
> @@ -419,10 +431,10 @@ void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev)
>   EXPORT_SYMBOL(neigh_changeaddr);
>   
>   static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
> -                         bool skip_perm)
> +                         bool skip_perm_ext_valid)
>   {
>          write_lock_bh(&tbl->lock);
> -       neigh_flush_dev(tbl, dev, skip_perm);
> +       neigh_flush_dev(tbl, dev, skip_perm_ext_valid);
>          pneigh_ifdown_and_unlock(tbl, dev);
>          pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
>                             tbl->family);

Thanks,
Daniel

