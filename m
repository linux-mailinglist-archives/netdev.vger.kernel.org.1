Return-Path: <netdev+bounces-233104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20AC0C53D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2894E58D6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235E1E51EB;
	Mon, 27 Oct 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NO75qzRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06671C6A3
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554158; cv=none; b=Ah5GlOd/RZbFpLL6hiuxXngP/JYJx3wVcgi709MnAtJD1z3HQhBvwTSgvhGCO2oe0vB3DEALBTquJ6qsSI9gV8tQhG6sjiByvG8oBENpsUcCzM3yCQydHIaZVoqsEJPOpKQR/EqMMdOOxc9lSKjgVqipRsloatUQC8dAtWZZCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554158; c=relaxed/simple;
	bh=hdOv3SkzQ9VfmPlWIlevS+L/0sbaFxgTKZLNVQDk3go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fp61jyIOW555ov/ibhyqTgyj2At1kniaiQQub8GVzF38C2phnkjNA0RgBVw+ClYF37V9l624lI0999KfUEFL10s9YeZkr0nVkdavBuKgzJpgsOBDFNgI289eEF2Tm1lfcc/ujVnED8ghkWjPkuluqcO/quOJapMzB27RpSAJOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NO75qzRe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eceef055fbso26109441cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761554156; x=1762158956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvXa4rNuo7xaahT/wKUZoGz9/g6nOVpn8EsIPl0e07Y=;
        b=NO75qzReSAKYlKtyVWrRrha2Y4RZR7mhJcIpiG3h8gFThcGZ7oG0wZdXW1Ef048i9J
         vA5rDGZpjZc3jw0KcjHRwdtpPimgQ7rWPBMTkkbzi7cj3wYYqp9WoIueswYKl/zgl0+e
         WGBGVt86wKxjlmtVS6MnI+z6+87jgG2tYXlFB8OMQgkyypD3NKVTjRQvSY6IjdcjalRi
         yv2WrCVJJtLvu/IgC16/4fHDRse0jrR5ZpZTlK5E8sCnBnad2qavUosgLzCRyVpWmWgP
         7u/7E5W3hAzjbgYwwpv7J1S5ZrLsw11MbXwxpldsf/3eLHz1/0tuBHRrZmJsmxqDkYJV
         tWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554156; x=1762158956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvXa4rNuo7xaahT/wKUZoGz9/g6nOVpn8EsIPl0e07Y=;
        b=sy3Qa5hcrKphTDwowdqxUd69KmmCYiXKShTUz5FTvAe7YW3mJQ232n3joGSVxleIxO
         hjDbXnKuXg+CLuU/qBVsqhQQsEhdDbJHAgMg2PPhR2hb7dM8fDzIgpHASiRhkcD1A42e
         MzLNnyAnXatcWfznGpZkPZB6AphULP5gegqQRakLLUBPrR0NrtmYBlDh6fJFop3Un0Z9
         4X1DqbmvQk3OoiTk4tm/KOTF5B0K6vs1ODTdujA9iekRtzyjyS107b9KdUuaRl86B+bc
         W2CWSScqh966o8c/rY3P77L8k3k/0WbMW9x+/bAFaizT+bXSRPy+J6WqhuMsc0KD5aC9
         65/Q==
X-Gm-Message-State: AOJu0YxN4IC0aK15EzKpsGuqyJoX8YDmQ9szUqbWOPTwBNAnFHTzIusK
	EDCZNg4WLg05V6MBVAi5XHFHEc1yFDU1u2dSH9KGy1d9FVAH6ToNQKM6SpsZ3Q/K5Mt8pzvjlPD
	GL57BBfQD7DhnNLdrhW0qlf4LgEkc1LFdXr5HSATj
X-Gm-Gg: ASbGncuYyf/tUn0qwBx76gjVtr53QmOlqwBTtSACwCBzs6BhGbBHbqeb2wlZxOwv06/
	xsC4xksqloruZFVp+9TgVILV5ldgCCDvEvbfcomjqglpPJFfsT2bAtWAY0H6rjS+eG+9NcJeRgv
	ddE+ZUCeTRy8UVYwV2LjgbCTfGJ4YTTjj98451JAXkoO/rAKuUc/pMmr2YgyDk4fXT6ZbeCY2gK
	M0Qwz7CD0jMNBdASC7XomKdc54fQTSRhtgdntARqNlDkAhGHb0dVi66SVT4/TH54f0eDxo=
X-Google-Smtp-Source: AGHT+IHvQ8aZbRoq/8ABVt+4UJKxmJTKEDAzKn6DuiW2s6Xl5HiwiVRa96ORm+D8nNJwaqztk1Ph1QOl4F9Vf1pgr5I=
X-Received: by 2002:ac8:5f93:0:b0:4e7:216e:1fcd with SMTP id
 d75a77b69052e-4e89d35c9ebmr463440341cf.54.1761554155338; Mon, 27 Oct 2025
 01:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027082232.232571-1-idosch@nvidia.com> <20251027082232.232571-2-idosch@nvidia.com>
In-Reply-To: <20251027082232.232571-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 01:35:44 -0700
X-Gm-Features: AWmQ_bkrnHnd5fdf8fKPdNODNykxdGP_g9qF-EpPysj6dyfE-9npxTpCku4rLVU
Message-ID: <CANn89iL0y+0axq5RtshyLrZcJ8cJBqJ=OzCH3BW8qUjfqkdG7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: icmp: Add RFC 5837 support
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, petrm@nvidia.com, 
	willemb@google.com, daniel@iogearbox.net, fw@strlen.de, 
	ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:24=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Add the ability to append the incoming IP interface information to
> ICMPv4 error messages in accordance with RFC 5837 and RFC 4884. This is
> required for more meaningful traceroute results in unnumbered networks.
>
> The feature is disabled by default and controlled via a new sysctl
> ("net.ipv4.icmp_errors_extension_mask") which accepts a bitmask of ICMP
> extensions to append to ICMP error messages. Currently, only a single
> value is supported, but the interface and the implementation should be
> able to support more extensions, if needed.
>
> Clone the skb and copy the relevant data portions before modifying the
> skb as the caller of __icmp_send() still owns the skb after the function
> returns. This should be fine since by default ICMP error messages are
> rate limited to 1000 per second and no more than 1 per second per
> specific host.
>
> Trim or pad the packet to 128 bytes before appending the ICMP extension
> structure in order to be compatible with legacy applications that assume
> that the ICMP extension structure always starts at this offset (the
> minimum length specified by RFC 4884).
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>
> Notes:
>     v2:
>     * Add a comment about field ordering.
>
>  Documentation/networking/ip-sysctl.rst |  17 +++
>  include/linux/icmp.h                   |  32 +++++
>  include/net/netns/ipv4.h               |   1 +
>  net/ipv4/icmp.c                        | 191 ++++++++++++++++++++++++-
>  net/ipv4/sysctl_net_ipv4.c             |  11 ++
>  5 files changed, 251 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index a06cb99d66dc..ece1187ba0f1 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1796,6 +1796,23 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
>
>         Default: 0 (disabled)
>
> +icmp_errors_extension_mask - UNSIGNED INTEGER
> +       Bitmask of ICMP extensions to append to ICMPv4 error messages
> +       ("Destination Unreachable", "Time Exceeded" and "Parameter Proble=
m").
> +       The original datagram is trimmed / padded to 128 bytes in order t=
o be
> +       compatible with applications that do not comply with RFC 4884.
> +
> +       Possible extensions are:
> +
> +       =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +       0x01 Incoming IP interface information according to RFC 5837.
> +            Extension will include the index, IPv4 address (if present),
> +            name and MTU of the IP interface that received the datagram
> +            which elicited the ICMP error.
> +       =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +       Default: 0x00 (no extensions)
> +
>  igmp_max_memberships - INTEGER
>         Change the maximum number of multicast groups we can subscribe to=
.
>         Default: 20
> diff --git a/include/linux/icmp.h b/include/linux/icmp.h
> index 0af4d210ee31..043ec5d9c882 100644
> --- a/include/linux/icmp.h
> +++ b/include/linux/icmp.h
> @@ -40,4 +40,36 @@ void ip_icmp_error_rfc4884(const struct sk_buff *skb,
>                            struct sock_ee_data_rfc4884 *out,
>                            int thlen, int off);
>
> +/* RFC 4884 */
> +#define ICMP_EXT_ORIG_DGRAM_MIN_LEN    128
> +#define ICMP_EXT_VERSION_2             2
> +
> +/* ICMP Extension Object Classes */
> +#define ICMP_EXT_OBJ_CLASS_IIO         2       /* RFC 5837 */
> +
> +/* Interface Information Object - RFC 5837 */
> +enum {
> +       ICMP_EXT_CTYPE_IIO_ROLE_IIF,
> +};
> +
> +#define ICMP_EXT_CTYPE_IIO_ROLE(ROLE)  ((ROLE) << 6)
> +#define ICMP_EXT_CTYPE_IIO_MTU         BIT(0)
> +#define ICMP_EXT_CTYPE_IIO_NAME                BIT(1)
> +#define ICMP_EXT_CTYPE_IIO_IPADDR      BIT(2)
> +#define ICMP_EXT_CTYPE_IIO_IFINDEX     BIT(3)
> +
> +struct icmp_ext_iio_name_subobj {
> +       u8 len;
> +       char name[IFNAMSIZ];
> +};
> +
> +enum {
> +       /* RFC 5837 - Incoming IP Interface Role */
> +       ICMP_ERR_EXT_IIO_IIF,
> +       /* Add new constants above. Used by "icmp_errors_extension_mask"
> +        * sysctl.
> +        */
> +       ICMP_ERR_EXT_COUNT,
> +};
> +
>  #endif /* _LINUX_ICMP_H */
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 34eb3aecb3f2..0e96c90e56c6 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -135,6 +135,7 @@ struct netns_ipv4 {
>         u8 sysctl_icmp_echo_ignore_broadcasts;
>         u8 sysctl_icmp_ignore_bogus_error_responses;
>         u8 sysctl_icmp_errors_use_inbound_ifaddr;
> +       u8 sysctl_icmp_errors_extension_mask;
>         int sysctl_icmp_ratelimit;
>         int sysctl_icmp_ratemask;
>         int sysctl_icmp_msgs_per_sec;
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 1b7fb5d935ed..4abbec2f47ef 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -582,6 +582,185 @@ static struct rtable *icmp_route_lookup(struct net =
*net, struct flowi4 *fl4,
>         return ERR_PTR(err);
>  }
>
> +struct icmp_ext_iio_addr4_subobj {
> +       __be16 afi;
> +       __be16 reserved;
> +       __be32 addr4;
> +};
> +
> +static unsigned int icmp_ext_iio_len(void)
> +{
> +       return sizeof(struct icmp_extobj_hdr) +
> +               /* ifIndex */
> +               sizeof(__be32) +
> +               /* Interface Address Sub-Object */
> +               sizeof(struct icmp_ext_iio_addr4_subobj) +
> +               /* Interface Name Sub-Object. Length must be a multiple o=
f 4
> +                * bytes.
> +                */
> +               ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
> +               /* MTU */
> +               sizeof(__be32);
> +}
> +
> +static unsigned int icmp_ext_max_len(u8 ext_objs)
> +{
> +       unsigned int ext_max_len;
> +
> +       ext_max_len =3D sizeof(struct icmp_ext_hdr);
> +
> +       if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
> +               ext_max_len +=3D icmp_ext_iio_len();
> +
> +       return ext_max_len;
> +}
> +
> +static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
> +{
> +       struct in_device *in_dev;
> +       struct in_ifaddr *ifa;
> +
> +       in_dev =3D __in_dev_get_rcu(dev);
> +       if (!in_dev)
> +               return 0;
> +
> +       /* It is unclear from RFC 5837 which IP address should be chosen,=
 but
> +        * it makes sense to choose a global unicast address.
> +        */
> +       in_dev_for_each_ifa_rcu(ifa, in_dev) {
> +               if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
> +                       continue;
> +               if (ifa->ifa_scope !=3D RT_SCOPE_UNIVERSE ||
> +                   ipv4_is_multicast(ifa->ifa_address))
> +                       continue;
> +               return ifa->ifa_address;
> +       }
> +
> +       return 0;
> +}
> +
> +static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb=
,
> +                                   int iif)
> +{
> +       struct icmp_ext_iio_name_subobj *name_subobj;
> +       struct icmp_extobj_hdr *objh;
> +       struct net_device *dev;
> +       __be32 data;
> +
> +       if (!iif)
> +               return;
> +
> +       /* Add the fields in the order specified by RFC 5837. */
> +       objh =3D skb_put(skb, sizeof(*objh));
> +       objh->class_num =3D ICMP_EXT_OBJ_CLASS_IIO;
> +       objh->class_type =3D ICMP_EXT_CTYPE_IIO_ROLE(ICMP_EXT_CTYPE_IIO_R=
OLE_IIF);
> +
> +       data =3D htonl(iif);
> +       skb_put_data(skb, &data, sizeof(__be32));
> +       objh->class_type |=3D ICMP_EXT_CTYPE_IIO_IFINDEX;
> +
> +       rcu_read_lock();
> +
> +       dev =3D dev_get_by_index_rcu(net, iif);
> +       if (!dev)
> +               goto out;
> +
> +       data =3D icmp_ext_iio_addr4_find(dev);
> +       if (data) {
> +               struct icmp_ext_iio_addr4_subobj *addr4_subobj;
> +
> +               addr4_subobj =3D skb_put_zero(skb, sizeof(*addr4_subobj))=
;
> +               addr4_subobj->afi =3D htons(ICMP_AFI_IP);
> +               addr4_subobj->addr4 =3D data;
> +               objh->class_type |=3D ICMP_EXT_CTYPE_IIO_IPADDR;
> +       }
> +
> +       name_subobj =3D skb_put_zero(skb, ALIGN(sizeof(*name_subobj), 4))=
;
> +       name_subobj->len =3D ALIGN(sizeof(*name_subobj), 4);
> +       netdev_copy_name(dev, name_subobj->name);
> +       objh->class_type |=3D ICMP_EXT_CTYPE_IIO_NAME;
> +
> +       data =3D htonl(READ_ONCE(dev->mtu));
> +       skb_put_data(skb, &data, sizeof(__be32));
> +       objh->class_type |=3D ICMP_EXT_CTYPE_IIO_MTU;
> +
> +out:
> +       rcu_read_unlock();
> +       objh->length =3D htons(skb_tail_pointer(skb) - (unsigned char *)o=
bjh);
> +}
> +
> +static void icmp_ext_objs_append(struct net *net, struct sk_buff *skb,
> +                                u8 ext_objs, int iif)
> +{
> +       if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
> +               icmp_ext_iio_iif_append(net, skb, iif);
> +}
> +
> +static struct sk_buff *
> +icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr =
*icmph,
> +               unsigned int room, int iif)
> +{
> +       unsigned int payload_len, ext_max_len, ext_len;
> +       struct icmp_ext_hdr *ext_hdr;
> +       struct sk_buff *skb;
> +       u8 ext_objs;
> +       int nhoff;
> +
> +       switch (icmph->type) {
> +       case ICMP_DEST_UNREACH:
> +       case ICMP_TIME_EXCEEDED:
> +       case ICMP_PARAMETERPROB:
> +               break;
> +       default:
> +               return NULL;
> +       }
> +
> +       ext_objs =3D READ_ONCE(net->ipv4.sysctl_icmp_errors_extension_mas=
k);
> +       if (!ext_objs)
> +               return NULL;
> +
> +       ext_max_len =3D icmp_ext_max_len(ext_objs);
> +       if (ICMP_EXT_ORIG_DGRAM_MIN_LEN + ext_max_len > room)
> +               return NULL;
> +
> +       skb =3D skb_clone(skb_in, GFP_ATOMIC);
> +       if (!skb)
> +               return NULL;
> +
> +       nhoff =3D skb_network_offset(skb);
> +       payload_len =3D min(skb->len - nhoff, ICMP_EXT_ORIG_DGRAM_MIN_LEN=
);
> +
> +       if (!pskb_network_may_pull(skb, payload_len))
> +               goto free_skb;
> +
> +       if (pskb_trim(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN) ||
> +           __skb_put_padto(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN, fal=
se))
> +               goto free_skb;
> +
> +       if (pskb_expand_head(skb, 0, ext_max_len, GFP_ATOMIC))
> +               goto free_skb;
> +
> +       ext_hdr =3D skb_put_zero(skb, sizeof(*ext_hdr));
> +       ext_hdr->version =3D ICMP_EXT_VERSION_2;
> +
> +       icmp_ext_objs_append(net, skb, ext_objs, iif);
> +
> +       /* Do not send an empty extension structure. */
> +       ext_len =3D skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
> +       if (ext_len =3D=3D sizeof(*ext_hdr))
> +               goto free_skb;
> +
> +       ext_hdr->checksum =3D ip_compute_csum(ext_hdr, ext_len);
> +       /* The length of the original datagram in 32-bit words (RFC 4884)=
. */
> +       icmph->un.reserved[1] =3D ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u3=
2);
> +
> +       return skb;
> +
> +free_skb:
> +       consume_skb(skb);
> +       return NULL;
> +}
> +
>  /*
>   *     Send an ICMP message in response to a situation
>   *
> @@ -601,6 +780,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
t code, __be32 info,
>         struct icmp_bxm icmp_param;
>         struct rtable *rt =3D skb_rtable(skb_in);
>         bool apply_ratelimit =3D false;
> +       struct sk_buff *ext_skb;
>         struct ipcm_cookie ipc;
>         struct flowi4 fl4;
>         __be32 saddr;
> @@ -770,7 +950,12 @@ void __icmp_send(struct sk_buff *skb_in, int type, i=
nt code, __be32 info,
>         if (room <=3D (int)sizeof(struct iphdr))
>                 goto ende;
>
> -       icmp_param.data_len =3D skb_in->len - icmp_param.offset;
> +       ext_skb =3D icmp_ext_append(net, skb_in, &icmp_param.data.icmph, =
room,
> +                                 parm->iif);
> +       if (ext_skb)
> +               icmp_param.skb =3D ext_skb;
> +
> +       icmp_param.data_len =3D icmp_param.skb->len - icmp_param.offset;
>         if (icmp_param.data_len > room)
>                 icmp_param.data_len =3D room;
>         icmp_param.head_len =3D sizeof(struct icmphdr);
> @@ -785,6 +970,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, in=
t code, __be32 info,
>         trace_icmp_send(skb_in, type, code);
>
>         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> +
> +       if (ext_skb)
> +               consume_skb(ext_skb);

nit : if (ext_skb) is not needed, consume_skb(NULL) is ok.

No need to resend.

Reviewed-by: Eric Dumazet <edumazet@google.com>

