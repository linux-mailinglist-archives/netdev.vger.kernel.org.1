Return-Path: <netdev+bounces-112745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8193AF82
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED34B21BE9
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA9155A25;
	Wed, 24 Jul 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpehK8mE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E5155732
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815206; cv=none; b=NV2EYFMPFee3WzSateH56U48YgO+w7FLZ6hYgkZ8zmVErB0IlftP/i38I9Y5zjAHDx4C+L7Wa2ZQ28XwJ/9Q249p/zN0zfG39szqkEyaPzPPp0XHCRuGpApI9ifsUQpEkirV5NjCPcW93fFRId6z221gdX14A1fAdH0iXzUdtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815206; c=relaxed/simple;
	bh=voS3uNvl56NCYSUlhGPy8XcZuSh94VmcTEkjx2N77dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chAmZvBDp+jXAipbbO1jujt9TPj/4zrjku1ziqOX/WCmpsznz/73hbUDy2GkP0ls6GC7zNnfHlVIlamhYkqnt6UdA0nJooaNiClDWcjudVgCGGXk8CdOx5K1iNdE0qrqeyX0KHBLwl4t59AOq3gEzILn2zWT5wzAZE3obbmfk9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpehK8mE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso17197a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721815202; x=1722420002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INN+/7ol+4UcKDli2RZMWn9KSPmuVqeNTfU/yaIvGm4=;
        b=MpehK8mEvnzI6KVfdj8APC63f/nDvgVjr+BcfneL9IofsX/peBaN3g4VHI5eL3ZFPT
         3+MwCzsZILxoLBVr40897CKEr/vImerztAfbdy8wj4WhWzgUjqCNJp+sUZOze6BJ42Xn
         OOVGxw20m+4WzrMc8VFzriEn9hUYSwqNI62PUeSrEV0LR+GzxgOp9c3ZdBFPkxN/mn2N
         WH7TcAk24yCSCobyel7rX/pfETcw0VM6/3ZbPC+sI97rwydvXfKY35MAjWcX3wkAVwhm
         qPEf93mpxQ3Qk2/BGPCRRYl1z/XLvrNEpqC/A0kXgBCIVjeNNoV4ZOd1h4KOVMdSebpA
         KxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815202; x=1722420002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INN+/7ol+4UcKDli2RZMWn9KSPmuVqeNTfU/yaIvGm4=;
        b=d/suyKYjQyXM69S2vXtXIUCsU35ubS8QMcPTGzJmF/eVbkkdlk46iWj9kzLFPEX12m
         CyQs/bq4oVFl9CcOYkyrsf9rrWixDMJh0U131LkYqdcihVLIdJ9rCI0xbMdVNNFgm3+E
         V0B6WELITAQS/VKWF9KJFvYPEFJFGnXq0MgSrIOLuQd9StJmXIsYKIBdmly6HEQ5an8p
         ah3NL6TKYNaQJEc4RkbH9rzUoGR8zYrheby8J4f4q31YGq/RBZMKGq84i/v1MadfGuPg
         D3Z7HOxUyq0cBGWE2fEDijNwQecWdgFLGkd8GDzPMfRk+21j5BfQH93WxC1MlTMokT50
         ozNA==
X-Forwarded-Encrypted: i=1; AJvYcCXbDJxTfQ0Ir0FfyJ8CzfM/MYMs6A76zS/iV6fK2l72KnMjFleZUJJtdGuuwO0jQaN6ECiZ9nzu+9xaskWrY0hfUOufiFKo
X-Gm-Message-State: AOJu0YzPy40lg/r70JDyAkDMa0bLK0aJP3XBXTXRpvljBYcBnKgVcXgG
	q9YjbQu2rF/yRSKbXUjJxBTVROcSj6KqHMklj9LRjWMGSeaxsCCl6IqiI6SS1MtOEYw25KDPmxN
	EbmDPpfGIZUst9Fe95iiEPAu+km9A5tQOSLn/
X-Google-Smtp-Source: AGHT+IHI95yV4pAlEHA4qjFR9K/I32m2cB7EzqtaLIX49oidJ2ab5Nno2laDRlfX6l+QkZH7oJdXT80JC1aqIHfItps=
X-Received: by 2002:a05:6402:26ce:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5aacb8e1b52mr246793a12.4.1721815201221; Wed, 24 Jul 2024
 03:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
In-Reply-To: <202407241403542217WOxM8U3ABv-nWZT068xe@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 11:59:49 +0200
Message-ID: <CANn89i+vYp22bUjfB21V_Rqmo9ZAKAmJxyarFWngq=cCmBQUrQ@mail.gmail.com>
Subject: Re: [PATCH] net: Provide sysctl to tune local port range to IANA specification
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn, 
	zhang.yunkai@zte.com.cn, tu.qiang35@zte.com.cn, he.peilin@zte.com.cn, 
	yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:04=E2=80=AFAM <jiang.kun2@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> The Importance of Following IANA Standards
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> IANA specifies User ports as 1024-49151, and it just so happens
> that my application uses port 33060 (reserved for MySQL Database Extended=
),
> which conflicts with the Linux default dynamic port range (32768-60999)[1=
].
>
> In fact, IANA assigns numbers in port range from 32768 to 49151,
> which is uniformly accepted by the industry. To do this,
> it is necessary for the kernel to follow the IANA specification.
>
> Drawbacks of existing implementations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> In past discussions, follow the IANA specification by modifying the
> system defaults has been discouraged, which would greatly affect
> existing users[2].
>
> Theoretically, this can be done by tuning net.ipv4.local_port_range,
> but there are inconveniences such as:
> (1) For cloud-native scenarios, each container is expected to follow
> the IANA specification uniformly, so it is necessary to do sysctl
> configuration in each container individually, which increases the user's
> resource management costs.
> (2) For new applications, since sysctl(net.ipv4.local_port_range) is
> isolated across namespaces, the container cannot inherit the host's value=
,
> so after startup, it remains at the kernel default value of 32768-60999,
> which reduces the ease of use of the system.
>
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> In order to maintain compatibility, we provide a sysctl interface in
> host namespace, which makes it easy to tune local port range to
> IANA specification.
>
> When ip_local_port_range_use_iana=3D1, the local port range of all networ=
k
> namespaces is tuned to IANA specification (49152-60999), and IANA
> specification is also used for newly created network namespaces. Therefor=
e,
> each container does not need to do sysctl settings separately, which
> improves the convenience of configuration.
> When ip_local_port_range_use_iana=3D0, the local port range of all networ=
k
> namespaces are tuned to the original kernel defaults (32768-60999).
> For example:
>         # cat /proc/sys/net/ipv4/ip_local_port_range
>         32768   60999
>         # echo 1 > /proc/sys/net/ipv4/ip_local_port_range_use_iana
>         # cat /proc/sys/net/ipv4/ip_local_port_range
>         49152   60999
>
>         # unshare -n
>         # cat /proc/sys/net/ipv4/ip_local_port_range
>         49152   60999
>
> Notes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The lower value(49152), consistent with IANA dynamic port lower limit.
> The upper limit value(60999), which differs from the IANA dynamic upper
> limit due to the fact that Linux will use 61000-65535 as masquarading/NAT=
,
> but this does not conflict with the IANA specification[3].
>
> Note that following the above specification reduces the number of ephemer=
al
> ports by half, increasing the risk of port exhaustion[2].
>
> [1]:https://www.iana.org/assignments/service-names-port-numbers/service-n=
ames-port-numbers.txt
> [2]:https://lore.kernel.org/all/bf42f6fd-cd06-02d6-d7b6-233a0602c437@gmai=
l.com/
> [3]:https://lore.kernel.org/all/20070512210830.514c7709@the-village.bc.nu=
/
>
> Co-developed-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
> Reviewed-by: Peilin He<he.peilin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
>  net/ipv4/af_inet.c                     |  7 ++++++-
>  net/ipv4/sysctl_net_ipv4.c             | 31 ++++++++++++++++++++++++++++=
+++
>  3 files changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index bd50df6a5a42..27f4928c2a1d 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1320,6 +1320,19 @@ ip_local_port_range - 2 INTEGERS
>         Must be greater than or equal to ip_unprivileged_port_start.
>         The default values are 32768 and 60999 respectively.
>
> +ip_local_port_range_use_iana - BOOLEAN
> +       Tune ip_local_port_range to IANA specification easily.
> +       When ip_local_port_range_use_iana=3D1, the local port range of
> +       all network namespaces is tuned to IANA specification (49152-6099=
9),
> +       and IANA specification is also used for newly created network nam=
espaces.
> +       Therefore, each container does not need to do sysctl settings sep=
arately,
> +       which improves the convenience of configuration.
> +       When ip_local_port_range_use_iana=3D0, the local port range of
> +       all network namespaces are tuned to the original kernel
> +       defaults (32768-60999).
> +

IANA means : Internet Assigned Numbers Authority

It is very possible a future RFC changes the actual ranges.

I would have used rfc 6335, because when a new rfc comes in 2030, we
will have to add a new sysctl, right ?

> +       Default: 0
> +
>  ip_local_reserved_ports - list of comma separated ranges
>         Specify the ports which are reserved for known third-party
>         applications. These ports will not be used by automatic port
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..42b6bc58dc45 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -123,6 +123,8 @@
>
>  #include <trace/events/sock.h>
>
> +extern u8 sysctl_ip_local_port_range_use_iana;
> +
>  /* The inetsw table contains everything that inet_create needs to
>   * build a new socket.
>   */
> @@ -1802,7 +1804,10 @@ static __net_init int inet_init_net(struct net *ne=
t)
>         /*
>          * Set defaults for local port range
>          */
> -       net->ipv4.ip_local_ports.range =3D 60999u << 16 | 32768u;
> +       if (sysctl_ip_local_port_range_use_iana)
> +               net->ipv4.ip_local_ports.range =3D 60999u << 16 | 49152u;
> +       else
> +               net->ipv4.ip_local_ports.range =3D 60999u << 16 | 32768u;
>
>         seqlock_init(&net->ipv4.ping_group_range.lock);
>         /*
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 162a0a3b6ba5..a38447889072 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -45,6 +45,8 @@ static unsigned int tcp_child_ehash_entries_max =3D 16 =
* 1024 * 1024;
>  static unsigned int udp_child_hash_entries_max =3D UDP_HTABLE_SIZE_MAX;
>  static int tcp_plb_max_rounds =3D 31;
>  static int tcp_plb_max_cong_thresh =3D 256;
> +u8 sysctl_ip_local_port_range_use_iana;
> +EXPORT_SYMBOL(sysctl_ip_local_port_range_use_iana);
>
>  /* obsolete */
>  static int sysctl_tcp_low_latency __read_mostly;
> @@ -95,6 +97,26 @@ static int ipv4_local_port_range(struct ctl_table *tab=
le, int write,
>         return ret;
>  }
>
> +static int ipv4_local_port_range_use_iana(struct ctl_table *table, int w=
rite,
> +                                         void *buffer, size_t *lenp, lof=
f_t *ppos)
> +{
> +       struct net *net;
> +       int ret;
> +
> +       ret =3D proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
> +
> +       if (write && ret =3D=3D 0) {
> +               for_each_net(net) {

This is quite buggy.

for_each_net() can only be used with care, otherwise list can be
corrupted, netns can disappear under you.

