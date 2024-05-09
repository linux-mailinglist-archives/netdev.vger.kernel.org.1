Return-Path: <netdev+bounces-95010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C970C8C13AC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FF1F21D87
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE4101DE;
	Thu,  9 May 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K0UToPLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA1DDDF
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275134; cv=none; b=d4sF0svuxmNKov22LF4w1Gy6PTJrYG43NBlJeJQL/dxf7WYAwhWGOg7KibBUoFA8OgnHkmMsFFyz4pwPSo9MrXHCcq8ZN5WOYPZwT/8TeHdbKjDTvBAuUQyL+Em0z/thVXXyZMPHf2wKIO2gz8MRHVn2HZbS24rw7N8nU06/K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275134; c=relaxed/simple;
	bh=klwN98vJikcInciKoqR7+Zevlt7k5sKPxKHnS9DyGBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPH7A1K/Mmzpjzzw5Po8qvL+abfL12dV4qS+0Mge7tTa/jcFE32+f4k/lLj3YYhCpo7Fvo+fbpvCcYVVKIc2rS6haFeF+yPwxJ5APOUnHCua/ckY7mmiRYXXc7Tlx6x2rCiTL5QAHBYQTLR7fpM+0XISXP98uDzRl9h5vjBtyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K0UToPLC; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c7ee71ebaso4691345ab.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715275131; x=1715879931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt+QW2UCYL57wBL46v9XH17e6fjbKh5ox8Y+dS7MDxQ=;
        b=K0UToPLCSAYxIKe26CGv9nksBzDiZoo/7vdSHvmhnTPDlBTbHE05I6W6+5l31SEorQ
         BttUmgaSV+405JO7pWUuiCnN2j9JugPB9npLtXClFaJVjsgwY+OGBPR186zCo8d3+0Xu
         dVmMpAIPjwVa6Qp0esdd9Rtqx3NSYvELvKwGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275131; x=1715879931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt+QW2UCYL57wBL46v9XH17e6fjbKh5ox8Y+dS7MDxQ=;
        b=gW+/Z764ARqvDz+1ujFnKqFMdXblN5/l6dD9nKlDBSk+wWLw+R1/3W4dgEbxKU6bTa
         XvN/dpZJAUjqWLFjgaQTNSLQA4IFEErCfoREAQIySEs29r6aI9j9D5ZZFcyrvVSCbmDt
         +5Pysjk4MNWA+EkaMPW6pei/l0SEGIZL7FlSwOQ2QgUHuepPe0jLnILOZqfH1zHfnjhI
         0LgsINcqL3QXWkONFw0corBld1YZzn6HOklqp5tYFFCQOwyaVyxtcSuN+AoyGsqkLy79
         u5ZjeNquSZn0tMgnVD68gFAOAuNY8XarynASSbxrgqFIwftWUVBX0RtRfFVcswGGgIY1
         DkwQ==
X-Gm-Message-State: AOJu0YycIyAPJ4ZY5ENBLqWylR3vhUlOyCaPE4rtl+VyxFikVtS/hfKV
	yWd6OWCG8x98gKIVS5HD767TMVkAAD4rTYfjlVqmdc/nD3++DYxM0ZMb/ycGPhm8FcgZJxrWVi4
	DE0ZYqBuDNSg0NMkYmvP9qX/gZqdBhRXjNysO7IPt/V7QJ9b3ex2XOjcmdtWkQocG9PntUNmemQ
	Ov4tVmpFnwExupqzdquw==
X-Google-Smtp-Source: AGHT+IGYud45nusk59N0VhmiriD9iC4GrOQnmfNVWIdmq2ZMpFrkTPcsD75xuFQ6w7JAut8hfagQXQ0/AB+dQ8mSlNM=
X-Received: by 2002:a92:cd87:0:b0:36c:4c03:b0d5 with SMTP id
 e9e14a558f8ab-36cc14f87f6mr3264685ab.24.1715275131066; Thu, 09 May 2024
 10:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509094228.1035477-1-i.maximets@ovn.org>
In-Reply-To: <20240509094228.1035477-1-i.maximets@ovn.org>
From: Antonin Bas <antonin.bas@broadcom.com>
Date: Thu, 9 May 2024 10:18:39 -0700
Message-ID: <CAPq9N24QMvBzAfcemq0PCRGW50MGDwhHEWwwQaEmHqZkiyjV2A@mail.gmail.com>
Subject: Re: [PATCH net] net: openvswitch: fix overwriting ct original tuple
 for ICMPv6
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joe Stringer <joe@ovn.org>, 
	Jarno Rajahalme <jarno@ovn.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch by applying it to 6.8.9, and it addresses the
issue I observed.


On Thu, May 9, 2024 at 2:41=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> OVS_PACKET_CMD_EXECUTE has 3 main attributes:
>  - OVS_PACKET_ATTR_KEY - Packet metadata in a netlink format.
>  - OVS_PACKET_ATTR_PACKET - Binary packet content.
>  - OVS_PACKET_ATTR_ACTIONS - Actions to execute on the packet.
>
> OVS_PACKET_ATTR_KEY is parsed first to populate sw_flow_key structure
> with the metadata like conntrack state, input port, recirculation id,
> etc.  Then the packet itself gets parsed to populate the rest of the
> keys from the packet headers.
>
> Whenever the packet parsing code starts parsing the ICMPv6 header, it
> first zeroes out fields in the key corresponding to Neighbor Discovery
> information even if it is not an ND packet.
>
> It is an 'ipv6.nd' field.  However, the 'ipv6' is a union that shares
> the space between 'nd' and 'ct_orig' that holds the original tuple
> conntrack metadata parsed from the OVS_PACKET_ATTR_KEY.
>
> ND packets should not normally have conntrack state, so it's fine to
> share the space, but normal ICMPv6 Echo packets or maybe other types of
> ICMPv6 can have the state attached and it should not be overwritten.
>
> The issue results in all but the last 4 bytes of the destination
> address being wiped from the original conntrack tuple leading to
> incorrect packet matching and potentially executing wrong actions
> in case this packet recirculates within the datapath or goes back
> to userspace.
>
> ND fields should not be accessed in non-ND packets, so not clearing
> them should be fine.  Executing memset() only for actual ND packets to
> avoid the issue.
>
> Initializing the whole thing before parsing is needed because ND packet
> may not contain all the options.
>
> The issue only affects the OVS_PACKET_CMD_EXECUTE path and doesn't
> affect packets entering OVS datapath from network interfaces, because
> in this case CT metadata is populated from skb after the packet is
> already parsed.
>
> Fixes: 9dd7f8907c37 ("openvswitch: Add original direction conntrack tuple=
 to sw_flow_key.")
> Reported-by: Antonin Bas <antonin.bas@broadcom.com>
> Closes: https://github.com/openvswitch/ovs-issues/issues/327
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>
> Note: I'm working on a selftest for this issue, but it requires some
> ground work first to add support for OVS_PACKET_CMD_EXECUTE into
> opnevswitch selftests as well as parsing of ct tuples.  So it is going
> to be a separate patch set.
>
>  net/openvswitch/flow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> index 33b21a0c0548..8a848ce72e29 100644
> --- a/net/openvswitch/flow.c
> +++ b/net/openvswitch/flow.c
> @@ -561,7 +561,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct s=
w_flow_key *key,
>          */
>         key->tp.src =3D htons(icmp->icmp6_type);
>         key->tp.dst =3D htons(icmp->icmp6_code);
> -       memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
>
>         if (icmp->icmp6_code =3D=3D 0 &&
>             (icmp->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION ||
> @@ -570,6 +569,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct s=
w_flow_key *key,
>                 struct nd_msg *nd;
>                 int offset;
>
> +               memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
> +
>                 /* In order to process neighbor discovery options, we nee=
d the
>                  * entire packet.
>                  */
> --
> 2.44.0
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

