Return-Path: <netdev+bounces-231896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F05BFE5CB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9063C19C5853
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A547B281509;
	Wed, 22 Oct 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXIxQtCw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2211DF75C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170433; cv=none; b=sNPHP7TvdKkoDZUUOHzizxir6lunioxb56UimL0Zz+Lddcg6P0738U5DX6h+iikmRWIvpMmW5EG7reKhAMsql01rVwiOYoV/lVyT6RS9SJ+MYgeM2WIREGx2hiLX7GGyGdZv0h3NgtxD1LdQ1uIkVaZc0TRq1UKI5uTbXKPxBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170433; c=relaxed/simple;
	bh=KjUTwzLegGyA27d+zj6u1aO4TYls2gvRsZp3P/KiDjE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HIOraBddCVAM1rRLC21bIonITI+UBPrhwEUjxMBdhoeF/kpaOIukMduIQYT4LlkZajQMMA26jvInnEcrDt7FqoBPK/VBas+gudkxre2eSuLptFHUKM9J0Sy2VE6/0kMSeX5XUW7rgza0CE+Tgcj6TN97q9+4QURGuSo+kamoLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXIxQtCw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e88a1bbf5fso1167361cf.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170430; x=1761775230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH911uqj+0I+7iz2xNDDllsY0u40vI6Xc4Z6xKDaxho=;
        b=QXIxQtCwD0Vgw2og6AR4Ro8Yf9GCYVBYY6ZBAg05MGg0Wwc1zqBpFLq0CoRBS6aGwC
         wmd84vutNi5CpJaJbiC5/Ill/t7QhnMEUjgGwrkCX511gy/qYrcDZRgNPGkhAtM/8T7K
         2AI44wLy+5G1U3eR4KThI+0UEM/Akr7EQrNYtW4Xa+3zh/9J6MOmh3uZy9CRyx1U+GtH
         pTWiN0xkED84EpJ0v4luSXX1mF5Zx+dD6euh4ZlzL0pBrFajqB8/UMqToCok65zb2BT9
         LYH21pV5l1a3w3FC6tMShHRkMtznQ1igQbtmB7zA7fzDFU1J6J55NVgldsU2LVEzlnED
         j0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170430; x=1761775230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YH911uqj+0I+7iz2xNDDllsY0u40vI6Xc4Z6xKDaxho=;
        b=gu7bdir8+wDYDKMTT/ogfYFDHG6dhKJSN3IeoeHh1zZ3l+d704+sMfj6k7p0FU7npY
         Dnfmhai4ymoJzBA5kqn1GmjUsCcGG5/Ebf0r86xEmll1iiHvOyKUCF8bsc6WjNmOLWIS
         qBTdgRifqUScFeQHyg8o8nc7JJtKVpgvUfEf1WUwH0Tik61X3IcOtc6dOMpa6zq+zwfI
         Psnw+2GxrwN41btPdfp5OETiHRgTQxHqjgseW3ud+1gnFGerz0DCXLKZjrUSQ3dxiHjO
         zWXE7kNgQjCQfuF4TKfW6UWtDV9H+M23+1h6ISb7sv+s0RXIoH4LOmZ9FqEeb2Qevv+m
         p43w==
X-Forwarded-Encrypted: i=1; AJvYcCWKW+DTcsPw7OHnBZ+pdc2Jq7Eu5F/u+cpvTLERZC52g0mpe0l9n9XRLqsBwE30XodZ9XxDb4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87VoqJX7EqughZZUpGLP53kQbP6Z0KOi+Va8kmE2Fx/bVqnSM
	9VCALdr4eYDLTSSZJUD00xEA6pfpnjT3/ED8QJChRdt10WpPNI5Z+xf2
X-Gm-Gg: ASbGncvVGSXWTWN8dOn7Kke30+4ciPaYWmF8BC9sUxlWzG+4EGI8UU7a9KnwCx9jtVy
	OXhR5r/4YA330T6RJk+3kA/o5XqtT8Xvz7lfcE4Cl0uP41pPEU4VZ9a1QNgt8LHVWsTSX7OmT8O
	DtZ8nO7Ic2dDm/tjagyHeP5mJnzDw9iKX+umOZ0siB4netVGF8JCMz13o3PunqgRYvMo5XRKnY2
	5gT++W1mgrzl0mILhWcVYbkm93PdsC8L0pAXPpF7xR2NJ9CLtkAMx7KJK42Qil1Zj4x1dniSFqs
	qz2Lr9oE7GU+O9uiGFpTJ9chAx/NIeE3ALzXSaDvqJ3xPEc7YveqpdomJsGRg95wXcegjIPHrv1
	19hOLm/7WCn7Avzm65zjXVkR40IarfXltWPn5jNBvBQ5hDlh2MQ1pr6W/4qijb2qYOE7bWbr2IX
	p4yXluw4MlsF5+Tk7h7TGteOz7TOVUowcIndFZj4Ai3ZIj1/gjS4Nz
X-Google-Smtp-Source: AGHT+IG+nKYf/EjkO5lnqcDQHn7j4mrQZbNPP24qoBXzuZjqI87WOrew4R8AAVz+KCmVAwKDKzTpnw==
X-Received: by 2002:ac8:5907:0:b0:4e8:a4f1:b2d9 with SMTP id d75a77b69052e-4e8a4f1b3ecmr244871561cf.24.1761170430386;
        Wed, 22 Oct 2025 15:00:30 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4eb805d0b89sm1644961cf.4.2025.10.22.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:00:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:00:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 daniel@iogearbox.net, 
 fw@strlen.de, 
 ishaangandhi@gmail.com, 
 rbonica@juniper.net, 
 tom@herbertland.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <willemdebruijn.kernel.2e842c8c31670@gmail.com>
In-Reply-To: <20251022065349.434123-2-idosch@nvidia.com>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-2-idosch@nvidia.com>
Subject: Re: [PATCH net-next 1/3] ipv4: icmp: Add RFC 5837 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
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
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  17 +++
>  include/linux/icmp.h                   |  32 +++++
>  include/net/netns/ipv4.h               |   1 +
>  net/ipv4/icmp.c                        | 190 ++++++++++++++++++++++++-
>  net/ipv4/sysctl_net_ipv4.c             |  11 ++
>  5 files changed, 250 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index a06cb99d66dc..ece1187ba0f1 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1796,6 +1796,23 @@ icmp_errors_use_inbound_ifaddr - BOOLEAN
>  
>  	Default: 0 (disabled)
>  
> +icmp_errors_extension_mask - UNSIGNED INTEGER
> +	Bitmask of ICMP extensions to append to ICMPv4 error messages
> +	("Destination Unreachable", "Time Exceeded" and "Parameter Problem").
> +	The original datagram is trimmed / padded to 128 bytes in order to be
> +	compatible with applications that do not comply with RFC 4884.
> +
> +	Possible extensions are:
> +
> +	==== ==============================================================
> +	0x01 Incoming IP interface information according to RFC 5837.
> +	     Extension will include the index, IPv4 address (if present),
> +	     name and MTU of the IP interface that received the datagram
> +	     which elicited the ICMP error.
> +	==== ==============================================================
> +
> +	Default: 0x00 (no extensions)
> +
>  igmp_max_memberships - INTEGER
>  	Change the maximum number of multicast groups we can subscribe to.
>  	Default: 20
> diff --git a/include/linux/icmp.h b/include/linux/icmp.h
> index 0af4d210ee31..043ec5d9c882 100644
> --- a/include/linux/icmp.h
> +++ b/include/linux/icmp.h
> @@ -40,4 +40,36 @@ void ip_icmp_error_rfc4884(const struct sk_buff *skb,
>  			   struct sock_ee_data_rfc4884 *out,
>  			   int thlen, int off);
>  
> +/* RFC 4884 */
> +#define ICMP_EXT_ORIG_DGRAM_MIN_LEN	128
> +#define ICMP_EXT_VERSION_2		2
> +
> +/* ICMP Extension Object Classes */
> +#define ICMP_EXT_OBJ_CLASS_IIO		2	/* RFC 5837 */
> +
> +/* Interface Information Object - RFC 5837 */
> +enum {
> +	ICMP_EXT_CTYPE_IIO_ROLE_IIF,
> +};
> +
> +#define ICMP_EXT_CTYPE_IIO_ROLE(ROLE)	((ROLE) << 6)
> +#define ICMP_EXT_CTYPE_IIO_MTU		BIT(0)
> +#define ICMP_EXT_CTYPE_IIO_NAME		BIT(1)
> +#define ICMP_EXT_CTYPE_IIO_IPADDR	BIT(2)
> +#define ICMP_EXT_CTYPE_IIO_IFINDEX	BIT(3)
> +
> +struct icmp_ext_iio_name_subobj {
> +	u8 len;
> +	char name[IFNAMSIZ];
> +};
> +
> +enum {
> +	/* RFC 5837 - Incoming IP Interface Role */
> +	ICMP_ERR_EXT_IIO_IIF,
> +	/* Add new constants above. Used by "icmp_errors_extension_mask"
> +	 * sysctl.
> +	 */
> +	ICMP_ERR_EXT_COUNT,
> +};
> +
>  #endif	/* _LINUX_ICMP_H */
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 34eb3aecb3f2..0e96c90e56c6 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -135,6 +135,7 @@ struct netns_ipv4 {
>  	u8 sysctl_icmp_echo_ignore_broadcasts;
>  	u8 sysctl_icmp_ignore_bogus_error_responses;
>  	u8 sysctl_icmp_errors_use_inbound_ifaddr;
> +	u8 sysctl_icmp_errors_extension_mask;
>  	int sysctl_icmp_ratelimit;
>  	int sysctl_icmp_ratemask;
>  	int sysctl_icmp_msgs_per_sec;
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 1b7fb5d935ed..44c4deb9d9da 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -582,6 +582,184 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  	return ERR_PTR(err);
>  }
>  
> +struct icmp_ext_iio_addr4_subobj {
> +	__be16 afi;
> +	__be16 reserved;
> +	__be32 addr4;
> +};
> +
> +static unsigned int icmp_ext_iio_len(void)
> +{
> +	return sizeof(struct icmp_extobj_hdr) +
> +		/* ifIndex */
> +		sizeof(__be32) +
> +		/* Interface Address Sub-Object */
> +		sizeof(struct icmp_ext_iio_addr4_subobj) +
> +		/* Interface Name Sub-Object. Length must be a multiple of 4
> +		 * bytes.
> +		 */
> +		ALIGN(sizeof(struct icmp_ext_iio_name_subobj), 4) +
> +		/* MTU */
> +		sizeof(__be32);
> +}
> +
> +static unsigned int icmp_ext_max_len(u8 ext_objs)
> +{
> +	unsigned int ext_max_len;
> +
> +	ext_max_len = sizeof(struct icmp_ext_hdr);
> +
> +	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
> +		ext_max_len += icmp_ext_iio_len();
> +
> +	return ext_max_len;
> +}
> +
> +static __be32 icmp_ext_iio_addr4_find(const struct net_device *dev)
> +{
> +	struct in_device *in_dev;
> +	struct in_ifaddr *ifa;
> +
> +	in_dev = __in_dev_get_rcu(dev);
> +	if (!in_dev)
> +		return 0;
> +
> +	/* It is unclear from RFC 5837 which IP address should be chosen, but
> +	 * it makes sense to choose a global unicast address.

Is it possible for no such address to exist, and in that case should
one of the backup options be considered?

> +	 */
> +	in_dev_for_each_ifa_rcu(ifa, in_dev) {
> +		if (READ_ONCE(ifa->ifa_flags) & IFA_F_SECONDARY)
> +			continue;
> +		if (ifa->ifa_scope != RT_SCOPE_UNIVERSE ||
> +		    ipv4_is_multicast(ifa->ifa_address))
> +			continue;
> +		return ifa->ifa_address;
> +	}
> +
> +	return 0;
> +}
> +
> +static void icmp_ext_iio_iif_append(struct net *net, struct sk_buff *skb,
> +				    int iif)
> +{
> +	struct icmp_ext_iio_name_subobj *name_subobj;
> +	struct icmp_extobj_hdr *objh;
> +	struct net_device *dev;
> +	__be32 data;
> +
> +	if (!iif)
> +		return;
> +

Might be good to add a comment that field order is prescribed by the RFC.

> +	objh = skb_put(skb, sizeof(*objh));
> +	objh->class_num = ICMP_EXT_OBJ_CLASS_IIO;
> +	objh->class_type = ICMP_EXT_CTYPE_IIO_ROLE(ICMP_EXT_CTYPE_IIO_ROLE_IIF);
> +
> +	data = htonl(iif);
> +	skb_put_data(skb, &data, sizeof(__be32));
> +	objh->class_type |= ICMP_EXT_CTYPE_IIO_IFINDEX;
> +
> +	rcu_read_lock();
> +
> +	dev = dev_get_by_index_rcu(net, iif);
> +	if (!dev)
> +		goto out;
> +
> +	data = icmp_ext_iio_addr4_find(dev);
> +	if (data) {
> +		struct icmp_ext_iio_addr4_subobj *addr4_subobj;
> +
> +		addr4_subobj = skb_put_zero(skb, sizeof(*addr4_subobj));
> +		addr4_subobj->afi = htons(ICMP_AFI_IP);
> +		addr4_subobj->addr4 = data;
> +		objh->class_type |= ICMP_EXT_CTYPE_IIO_IPADDR;
> +	}
> +
> +	name_subobj = skb_put_zero(skb, ALIGN(sizeof(*name_subobj), 4));
> +	name_subobj->len = ALIGN(sizeof(*name_subobj), 4);
> +	netdev_copy_name(dev, name_subobj->name);
> +	objh->class_type |= ICMP_EXT_CTYPE_IIO_NAME;
> +
> +	data = htonl(READ_ONCE(dev->mtu));
> +	skb_put_data(skb, &data, sizeof(__be32));
> +	objh->class_type |= ICMP_EXT_CTYPE_IIO_MTU;
> +
> +out:
> +	rcu_read_unlock();
> +	objh->length = htons(skb_tail_pointer(skb) - (unsigned char *)objh);
> +}
> +
> +static void icmp_ext_objs_append(struct net *net, struct sk_buff *skb,
> +				 u8 ext_objs, int iif)
> +{
> +	if (ext_objs & BIT(ICMP_ERR_EXT_IIO_IIF))
> +		icmp_ext_iio_iif_append(net, skb, iif);
> +}
> +
> +static struct sk_buff *
> +icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
> +		unsigned int room, int iif)
> +{
> +	unsigned int payload_len, ext_max_len, ext_len;
> +	struct icmp_ext_hdr *ext_hdr;
> +	struct sk_buff *skb;
> +	u8 ext_objs;
> +	int nhoff;
> +
> +	switch (icmph->type) {
> +	case ICMP_DEST_UNREACH:
> +	case ICMP_TIME_EXCEEDED:
> +	case ICMP_PARAMETERPROB:
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	ext_objs = READ_ONCE(net->ipv4.sysctl_icmp_errors_extension_mask);
> +	if (!ext_objs)
> +		return NULL;
> +
> +	ext_max_len = icmp_ext_max_len(ext_objs);
> +	if (ICMP_EXT_ORIG_DGRAM_MIN_LEN + ext_max_len > room)
> +		return NULL;
> +
> +	skb = skb_clone(skb_in, GFP_ATOMIC);
> +	if (!skb)
> +		return NULL;
> +
> +	nhoff = skb_network_offset(skb);
> +	payload_len = min(skb->len - nhoff, ICMP_EXT_ORIG_DGRAM_MIN_LEN);
> +
> +	if (!pskb_network_may_pull(skb, payload_len))
> +		goto free_skb;
> +
> +	if (pskb_trim(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN) ||
> +	    __skb_put_padto(skb, nhoff + ICMP_EXT_ORIG_DGRAM_MIN_LEN, false))
> +		goto free_skb;
> +
> +	if (pskb_expand_head(skb, 0, ext_max_len, GFP_ATOMIC))
> +		goto free_skb;
> +
> +	ext_hdr = skb_put_zero(skb, sizeof(*ext_hdr));
> +	ext_hdr->version = ICMP_EXT_VERSION_2;
> +
> +	icmp_ext_objs_append(net, skb, ext_objs, iif);
> +
> +	/* Do not send an empty extension structure. */
> +	ext_len = skb_tail_pointer(skb) - (unsigned char *)ext_hdr;
> +	if (ext_len == sizeof(*ext_hdr))
> +		goto free_skb;
> +
> +	ext_hdr->checksum = ip_compute_csum(ext_hdr, ext_len);
> +	/* The length of the original datagram in 32-bit words (RFC 4884). */
> +	icmph->un.reserved[1] = ICMP_EXT_ORIG_DGRAM_MIN_LEN / sizeof(u32);
> +
> +	return skb;
> +
> +free_skb:
> +	consume_skb(skb);
> +	return NULL;
> +}
> +
>  /*
>   *	Send an ICMP message in response to a situation
>   *
> @@ -601,6 +779,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  	struct icmp_bxm icmp_param;
>  	struct rtable *rt = skb_rtable(skb_in);
>  	bool apply_ratelimit = false;
> +	struct sk_buff *ext_skb;
>  	struct ipcm_cookie ipc;
>  	struct flowi4 fl4;
>  	__be32 saddr;
> @@ -770,7 +949,12 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  	if (room <= (int)sizeof(struct iphdr))
>  		goto ende;
>  
> -	icmp_param.data_len = skb_in->len - icmp_param.offset;
> +	ext_skb = icmp_ext_append(net, skb_in, &icmp_param.data.icmph, room,
> +				  parm->iif);
> +	if (ext_skb)
> +		icmp_param.skb = ext_skb;
> +
> +	icmp_param.data_len = icmp_param.skb->len - icmp_param.offset;
>  	if (icmp_param.data_len > room)
>  		icmp_param.data_len = room;
>  	icmp_param.head_len = sizeof(struct icmphdr);
> @@ -785,6 +969,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  	trace_icmp_send(skb_in, type, code);
>  
>  	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> +
> +	if (ext_skb)
> +		consume_skb(ext_skb);
>  ende:
>  	ip_rt_put(rt);
>  out_unlock:
> @@ -1502,6 +1689,7 @@ static int __net_init icmp_sk_init(struct net *net)
>  	net->ipv4.sysctl_icmp_ratelimit = 1 * HZ;
>  	net->ipv4.sysctl_icmp_ratemask = 0x1818;
>  	net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr = 0;
> +	net->ipv4.sysctl_icmp_errors_extension_mask = 0;
>  	net->ipv4.sysctl_icmp_msgs_per_sec = 1000;
>  	net->ipv4.sysctl_icmp_msgs_burst = 50;
>  
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 24dbc603cc44..0c7c8f9041cb 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -48,6 +48,8 @@ static int tcp_plb_max_rounds = 31;
>  static int tcp_plb_max_cong_thresh = 256;
>  static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
>  static int tcp_ecn_mode_max = 2;
> +static u32 icmp_errors_extension_mask_all =
> +	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
>  
>  /* obsolete */
>  static int sysctl_tcp_low_latency __read_mostly;
> @@ -674,6 +676,15 @@ static struct ctl_table ipv4_net_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE
>  	},
> +	{
> +		.procname	= "icmp_errors_extension_mask",
> +		.data		= &init_net.ipv4.sysctl_icmp_errors_extension_mask,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &icmp_errors_extension_mask_all,
> +	},
>  	{
>  		.procname	= "icmp_ratelimit",
>  		.data		= &init_net.ipv4.sysctl_icmp_ratelimit,
> -- 
> 2.51.0
> 



