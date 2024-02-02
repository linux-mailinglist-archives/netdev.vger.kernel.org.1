Return-Path: <netdev+bounces-68533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814378471EB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B5A1F2A3F1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E6145341;
	Fri,  2 Feb 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Ya78oc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C76145335
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884155; cv=none; b=sxTpi4NLSMJcGTId3JjNdLMIHHMzsxkxzjrzZsq9vM0qOG+Ea04wYeq4TXLr9OiV+x/1wPM4cghBXoMeNE9EZmvZhWZuNhSygTyQfDK5yiEbaG+J5T53E2H721KnQxVwUZcDrN389wJ5xhhGsUfHABu9f8gevAVBZj8piFHpMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884155; c=relaxed/simple;
	bh=MVm3sxQaB+kju6vX+SE8RQ+FcDHG5ayNIQGwOXQbeaw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NEH9gP+tRWjjbAdU2G/5l7T+ItJSNwdA4D4NzhWlF/SaJxiku4HHnP+8SaL+wk93OvYA/JVbvV8hKf2hdHyNk6VqnteaOREKUXWXeGj+4uez1iB0nGlp1I1x4l8gJlZ7wt3lbX44uGhWVIiJmoGRzWo2JuY7eXaEiL5Zz7J4UgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Ya78oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0E4C433C7;
	Fri,  2 Feb 2024 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706884154;
	bh=MVm3sxQaB+kju6vX+SE8RQ+FcDHG5ayNIQGwOXQbeaw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G0Ya78ocdE7Xdj60ecEgfwApxRtiKMcI7kOmRZvxPUFaIdGF1qnbWmx+yri1d3UXX
	 jW1q7IoCckjj8OcpdGzdrXqBX7zaDIbNkSFuFiX7gyL923fH8lfT8moW9eblLJaXEX
	 YVLJTTQkz6iXw+iT65S0ZakGEzrAiEYyasqEFYE8cyd05GDM0n22oWfT1X4MHR+ut6
	 25zqDFsdEqXpgSWktVDXrFR230+9T3CMNPr1LOYfS3GKhXnwW6Gy5jDHtcGJOm3Gs7
	 NVoe41C2ukcjPOHR3UT1Qp06eL9HklyQTKlbMJ55s6X/lOS2aiTsVJ6vFSmiE9+JK3
	 xWSpxaFHvN4/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240201170937.3549878-6-edumazet@google.com>
References: <20240201170937.3549878-1-edumazet@google.com> <20240201170937.3549878-6-edumazet@google.com>
Subject: Re: [PATCH net-next 05/16] bonding: use exit_batch_rtnl() method
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
To: David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Fri, 02 Feb 2024 15:29:11 +0100
Message-ID: <170688415193.5216.10499830272732622816@kwain>

Hello,

Quoting Eric Dumazet (2024-02-01 18:09:26)
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 4e0600c7b050f21c82a8862e224bb055e95d5039..181da7ea389312d7c851ca51c=
35b871c07144b6b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6419,34 +6419,34 @@ static void __net_exit bond_net_exit_batch(struct=
 list_head *net_list)
>  {
>         struct bond_net *bn;
>         struct net *net;
> -       LIST_HEAD(list);
> =20
>         list_for_each_entry(net, net_list, exit_list) {
>                 bn =3D net_generic(net, bond_net_id);
>                 bond_destroy_sysfs(bn);
> +               bond_destroy_proc_dir(bn);
>         }
> +}
> +
> +static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_li=
st,
> +                                               struct list_head *dev_kil=
l_list)
> +{
> +       struct bond_net *bn;
> +       struct net *net;
> =20
>         /* Kill off any bonds created after unregistering bond rtnl ops */
> -       rtnl_lock();
>         list_for_each_entry(net, net_list, exit_list) {
>                 struct bonding *bond, *tmp_bond;
> =20
>                 bn =3D net_generic(net, bond_net_id);
>                 list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, b=
ond_list)
> -                       unregister_netdevice_queue(bond->dev, &list);
> -       }
> -       unregister_netdevice_many(&list);
> -       rtnl_unlock();
> -
> -       list_for_each_entry(net, net_list, exit_list) {
> -               bn =3D net_generic(net, bond_net_id);
> -               bond_destroy_proc_dir(bn);
> +                       unregister_netdevice_queue(bond->dev, dev_kill_li=
st);
>         }
>  }

This changes the logic of how bond net & devices are destroyed. Before
this patch the logic was:

1. bond_destroy_sysfs; called first so no new bond devices can be
   registered later.
2. unregister_netdevice; cleans up any new bond device added before 1.

This now is:
1. unregister_netdevice
// Here new bond devices can still be registered.
2. bond_destroy_sysfs

Looking briefly at the history, the above is done on purpose to avoid
issues when unloading the bonding module. See 23fa5c2caae0 and
especially 69b0216ac255.

Thanks,
Antoine

