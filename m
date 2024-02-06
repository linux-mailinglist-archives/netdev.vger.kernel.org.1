Return-Path: <netdev+bounces-69500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2984B7EC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66691B23FC5
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F91DDEB;
	Tue,  6 Feb 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmOuuvPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57509111BD
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229867; cv=none; b=a8WuN9PCG2wPj6gqm380xrYm4RCXiYmby8sU/TVRXdxnq05CEBOrhMc0Lcsfxx2jU4k711LXSkPmYhVoMMBD+/dyVyV4IExsrWJDCajho4qbixRTd2wJHMzikr05E8Rq7Ue0hdyHFUJAbKBBicf2j6xlTpu0siSqTYEPniKD6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229867; c=relaxed/simple;
	bh=oljXDG/QtLKkK/O2Kl/Rg1ZwR2GLo5SsxCUjGdGyzEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkCPyn77XWCvncD11LBX+mPvMCx/6scc2zjuyWedncdNtP0hiPZCtDfnequxqNh4tA6hW7490sNgo63qGWFP9vDRur7vv7scf1MlkAezENLaVLm2ne97rtK1lRTJyeo3p30uyxpjlt0z9m/Ix6DkG+BEZTuKKO9S93ToR5o7qeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmOuuvPG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so14629a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707229863; x=1707834663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I1He9LtHg3nxwza35UxQu0fux76Lc+5TE9iAPj+oGM=;
        b=JmOuuvPGWdQOGGl+00HweXzUITP1KXngtcXC0EkDQR3leHoH8FSj9fb3M9P1MAUZFt
         1MwR9u02eEHFk9PhqzQyK7YqxXZxzY2Ou2S8fTj4nE6s4bvSsKqZkT0+hIg7nXXquDWi
         sBkXbgrjp8+qDd2aw7xtjnh483Ea973BVEXbIFYHQT+2SijWCXUfGXxl/04XeKR91pft
         V9yrgPAurUwmEf0fA19LAn6Eb1JgwJFcW5DN/cx4zXVgW02/11nFhTu4Pwg76KT+qFvH
         JDaASCNyn/GQNO4ACPYxVGkZr5EWLA7WMAM8mythTWN1kagFBOyOv0BORE7tlcVuqLw4
         zxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229863; x=1707834663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I1He9LtHg3nxwza35UxQu0fux76Lc+5TE9iAPj+oGM=;
        b=VX7cHETdX78/rNqoZT9F8HwuaaUi8p6wQJdRy6vFEFZBPFNaN7QZaxVMb9vfMtJ29f
         /9m6HMAGT/HrXDrO5XvNbcyFvlKqUCAqg4KrhuoLKTOxQsR3NAFJhd0w3fRM7htRA0Bt
         jU7ZNljxVYAcjlqAw16fl2AvlnFkWMgNHRPVmF7fI7Uwh3QAlrks6nUUImaZXnj7uwt4
         0Z9ShiUH4vLcThG+PwkvWyH9NADhfxtffu3WwTIhxttA9GaE/jJdRZv/1mbbfWxG0rnc
         wP5LZ+H1n0j0a10B9+VrtTm3XiOMxW8NXgx5+OMe8klPOE3KtWjrR+8ZQHtyvkSoPq6F
         Y2sw==
X-Gm-Message-State: AOJu0Yw94B31iUcY3bDHSz+KRCBfjmxJBbT8uw5FP/W0MnSSzxvDDkji
	WdvJl6/FwGIJJEfGhfKnMvOO2jRdNgK79rC2MrRbAMZrFKFZddFkOCuCEzD7dvbE9+RJKl4oEYk
	Fb6stB8zloTU5Cu7/GnNC+UzgdKxk2+C778bQrhfD3C0LaDv9SQ==
X-Google-Smtp-Source: AGHT+IHMZBEI6fJNelBcO7+9rp0yg53pifrDwmmEYa/8x+26tbAsEHmpEjGxwtQfH0AQsynnUn9iuh3qYX7XQ98q+QU=
X-Received: by 2002:a50:8e1c:0:b0:55f:cb23:1f1b with SMTP id
 28-20020a508e1c000000b0055fcb231f1bmr212675edw.0.1707229863240; Tue, 06 Feb
 2024 06:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206131147.1286530-1-aconole@redhat.com> <20240206131147.1286530-2-aconole@redhat.com>
In-Reply-To: <20240206131147.1286530-2-aconole@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Feb 2024 15:30:47 +0100
Message-ID: <CANn89iLeKwk3Pc796V7Vgvm8-GLifbwimPJsDTudBZG-1kVAMg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: openvswitch: limit the number of recursions
 from action sets
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, 
	dev@openvswitch.org, Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@ovn.org>, 
	Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:11=E2=80=AFPM Aaron Conole <aconole@redhat.com> wr=
ote:
>
> The ovs module allows for some actions to recursively contain an action
> list for complex scenarios, such as sampling, checking lengths, etc.
> When these actions are copied into the internal flow table, they are
> evaluated to validate that such actions make sense, and these calls
> happen recursively.
>
> The ovs-vswitchd userspace won't emit more than 16 recursion levels
> deep.  However, the module has no such limit and will happily accept
> limits larger than 16 levels nested.  Prevent this by tracking the
> number of recursions happening and manually limiting it to 16 levels
> nested.
>
> The initial implementation of the sample action would track this depth
> and prevent more than 3 levels of recursion, but this was removed to
> support the clone use case, rather than limited at the current userspace
> limit.
>
> Fixes: 798c166173ff ("openvswitch: Optimize sample action for the clone u=
se cases")
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  net/openvswitch/flow_netlink.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlin=
k.c
> index 88965e2068ac..ba5cfa67a720 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -48,6 +48,9 @@ struct ovs_len_tbl {
>
>  #define OVS_ATTR_NESTED -1
>  #define OVS_ATTR_VARIABLE -2
> +#define OVS_COPY_ACTIONS_MAX_DEPTH 16
> +
> +static DEFINE_PER_CPU(int, copy_actions_depth);
>
>  static bool actions_may_change_flow(const struct nlattr *actions)
>  {
> @@ -3148,11 +3151,11 @@ static int copy_action(const struct nlattr *from,
>         return 0;
>  }
>
> -static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *=
attr,
> -                                 const struct sw_flow_key *key,
> -                                 struct sw_flow_actions **sfa,
> -                                 __be16 eth_type, __be16 vlan_tci,
> -                                 u32 mpls_label_count, bool log)
> +static int ___ovs_nla_copy_actions(struct net *net, const struct nlattr =
*attr,
> +                                  const struct sw_flow_key *key,
> +                                  struct sw_flow_actions **sfa,
> +                                  __be16 eth_type, __be16 vlan_tci,
> +                                  u32 mpls_label_count, bool log)
>  {
>         u8 mac_proto =3D ovs_key_mac_proto(key);
>         const struct nlattr *a;
> @@ -3478,6 +3481,26 @@ static int __ovs_nla_copy_actions(struct net *net,=
 const struct nlattr *attr,
>         return 0;
>  }
>
> +static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *=
attr,
> +                                 const struct sw_flow_key *key,
> +                                 struct sw_flow_actions **sfa,
> +                                 __be16 eth_type, __be16 vlan_tci,
> +                                 u32 mpls_label_count, bool log)
> +{
> +       int level =3D this_cpu_read(copy_actions_depth);
> +       int ret;
> +
> +       if (level > OVS_COPY_ACTIONS_MAX_DEPTH)
> +               return -EOVERFLOW;
> +

This code seems to run in process context.

Using per cpu limit would not work, unless you disabled migration ?

> +       __this_cpu_inc(copy_actions_depth);
> +       ret =3D ___ovs_nla_copy_actions(net, attr, key, sfa, eth_type,
> +                                     vlan_tci, mpls_label_count, log);
> +       __this_cpu_dec(copy_actions_depth);
> +
> +       return ret;
> +}
> +
>  /* 'key' must be the masked key. */
>  int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
>                          const struct sw_flow_key *key,
> --
> 2.41.0
>

