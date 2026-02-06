Return-Path: <netdev+bounces-257460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO5yBPJnhWknBQQAu9opvQ
	(envelope-from <netdev+bounces-257460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:02:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37DF9E4E
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C99430193BF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3F334C1D;
	Fri,  6 Feb 2026 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tY1eF7H6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE596331202
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350574; cv=none; b=Cj99aaJkAhYAT3JRzNFhcV/JdyFSXfuGLQ9IjyRMHSFxSoWgkkltHi8+/abbDPxM+pU8+GdsS0bPsrvFIef8AOKYKNDcaZZLDHlM7H55nlgeXFZKoRzQmBofQYZVR+h3FBMocbyKNkKToViBmGDGDUgbifgQ4CCIW2dbn+KR9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350574; c=relaxed/simple;
	bh=9+KXIch+w7cmyL2QfLkxHmSOG9n2ggsJDqbBM6hWcQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyZ9vpWv80oPJKdLV+WOKkduk+bfppueYPO8setnD8O82Jg+v+FsAZCNaE1ux3aChOWihjeC03PeWcc7HiHLWFbB23X9f/+xi1bXTIy2a+10O+6eNF5uYPhZN97OEgMD0gIqBNgpVdrb41KRdee+Z9O3d92oJXkNsS3lGbZbtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tY1eF7H6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c337cde7e40so1048317a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 20:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770350573; x=1770955373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3SY+Px+LVTcC5Q9HVW9psxTZ/KS5kLE52yVC2XqNPM=;
        b=tY1eF7H6WzTAuW0gSx3YxXHEwzzTi5uFuLDnDqeYPs+wU1fQpKgLV52egrxckOn/3A
         Psgi3ZUrnDUPaE96BtVIOM9Qx8jaYr9yfYljaIzLvkePftZQCL5GB7fipzUj7unh4IyM
         mXcDNYjePCYPEu7YWDe1eZn2D2S3u8gXFp3SujNsEJCr3Dn20/VXb/ftLlbNlFaAgv/B
         8dmZC6TxxvR4p5I0hlADUKQZpYAj6jjOnxVxCwLtFqKhqMiJBFrwSQlYoWaQxTkoqCZ/
         oPnfoT1RtQ+XoayC7nuhDIPs4Z4ou2wPp/MWr/NClnEUOnxGmycSr5XU4yrzeCcis+lr
         OLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770350573; x=1770955373;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M3SY+Px+LVTcC5Q9HVW9psxTZ/KS5kLE52yVC2XqNPM=;
        b=b17APpsIii1VxmSsqtCNtCONpBhxaVrUSbc+Pu+378gmrmf6MAmxNQD4fm7uVfD4t0
         ZUJp0kaAGKE7L33jQZbulm3Qesp605W0pIOBhi32Qr4j2b4znWHt6q+1bXDVHSxJ3ivX
         uPwud19h95gO1BxXBEyTHlm/UI8BtkOm3IAoilZzlLdtTE7NTkyhjh/aEUc11r2oeLqg
         Kz3oZroiWpa/rm9OGBv2iWMqk9YvieqTuJMV2kRIvfE2mb75xJFKpKh5bsjdRjgBVU5J
         v1t/6ugjAC+LOk35VT3ifsNgxZHRlymYTvSNZGcAvBowe9OUleAfMotiiJOEBHgvh3kD
         LNXg==
X-Forwarded-Encrypted: i=1; AJvYcCUigatj9Gtjv2VVEW8J3HGSPkr8+/9czLWCqoDLRUzzuHL7FbODutnPPTLZC17hTXAJ6k8TmKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5txmg/Bb9eID/O3tp15IsTN9QMJLuzAI/qdJcT10M7K1W1VKn
	tGNAakW6daq6clLUfBhocldw5X55cqFnOCv/r7IxuH8NIPQRw9V6x1GjoR7BXICfOUuZpoBHRhg
	8E1leaA==
X-Received: from pjbsk11.prod.google.com ([2002:a17:90b:2dcb:b0:34c:2124:a2b0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1505:b0:35d:d477:a7e9
 with SMTP id adf61e73a8af0-393ad02cd11mr1639125637.35.1770350573237; Thu, 05
 Feb 2026 20:02:53 -0800 (PST)
Date: Fri,  6 Feb 2026 03:57:54 +0000
In-Reply-To: <CAA3_Gno0c6uGwuxBcsDgZt2a_VriABPek31-1w-R8c9CdJw5Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAA3_Gno0c6uGwuxBcsDgZt2a_VriABPek31-1w-R8c9CdJw5Ow@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206040251.292605-1-kuniyu@google.com>
Subject: Re: [PATCH net 1/2] net: bonding: fix type-confusion in bonding header_ops
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kota.toda@gmo-cybersecurity.com
Cc: edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, yuki.koike@gmo-cybersecurity.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-257460-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 7C37DF9E4E
X-Rspamd-Action: no action

Hi,

Looks like patches were copy-and-pasted to email client since
diff is corrupted (\t is replaced with \s, line is wrapped, etc).

You may want to check your email client config or simply use
git send-email like

 $ git send-email --annotate --cover-letter --thread --no-chain-reply-to \
   --subject-prefix "PATCH v3 net" \
   --to "NAME <EMAIL@ADDRESS>" \
   --cc "NAME <EMAIL@ADDRESS>" \
   --cc netdev@vger.kernel.org \
   --dry-run HEAD~2

Then, make sure to CC maintainers listed by ./scripts/get_maintainer.pl

There are a few more rules to follow, so please read these doc
for next submission.

  Documentation/process/submitting-patches.rst
  Documentation/process/maintainer-netdev.rst


From: =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=AA <kota.toda@gmo-cybersecurity.com=
>
Date: Thu, 5 Feb 2026 19:57:00 +0900
> Add two members to struct bonding, bond_header_ops and
> header_slave_dev, to avoid type-confusion while keeping track of the
> slave's header_ops.
>=20
> Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>

nit: Reported-by is not needed when it's identical with the author.


> ---
>  drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
>  include/net/bonding.h           |  5 +++
>  2 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index f17a170d1..5ecc64e38 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1616,14 +1616,70 @@ static void bond_compute_features(struct bonding =
*bond)
>      netdev_change_features(bond_dev);
>  }
>=20
> +static int bond_hard_header(struct sk_buff *skb, struct net_device *dev,
> +        unsigned short type, const void *daddr,
> +        const void *saddr, unsigned int len)
> +{
> +    struct bonding *bond =3D netdev_priv(dev);
> +    struct net_device *slave_dev;
> +
> +    slave_dev =3D bond->header_slave_dev;
> +
> +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
> +}
> +
> +static void bond_header_cache_update(struct hh_cache *hh, const
> +struct net_device *dev,
> +        const unsigned char *haddr)
> +{
> +    const struct bonding *bond =3D netdev_priv(dev);
> +    void (*cache_update)(struct hh_cache *hh,
> +        const struct net_device *dev,
> +        const unsigned char *haddr);
> +    struct net_device *slave_dev;
> +
> +    slave_dev =3D bond->header_slave_dev;
> +
> +    if (!slave_dev->header_ops

Is slave_dev always non-NULL ?


> || !(cache_update =3D
> READ_ONCE(slave_dev->header_ops->cache_update)))

READ_ONCE() seems necessary for header_ops.

and please run ./scripts/checkpatch.pl, which will
complain about the coding style setting var in if().


> +        return;
> +
> +    cache_update(hh, slave_dev, haddr);
> +}
> +
> +
>  static void bond_setup_by_slave(struct net_device *bond_dev,
>                  struct net_device *slave_dev)
>  {
> +    struct bonding *bond =3D netdev_priv(bond_dev);
>      bool was_up =3D !!(bond_dev->flags & IFF_UP);
>=20
>      dev_close(bond_dev);
>=20
> -    bond_dev->header_ops        =3D slave_dev->header_ops;
> +    /* Some functions are given dev as an argument
> +    * while others not. When dev is not given, we cannot
> +    * find out what is the slave device through struct bonding
> +    * (the private data of bond_dev). Therefore, we need a raw
> +    * header_ops variable instead of its pointer to const header_ops
> +    * and assign slave's functions directly.
> +    * For the other case, we set the wrapper functions that pass
> +    * slave_dev to the wrapped functions.
> +    */
> +    bond->bond_header_ops.create =3D bond_hard_header;
> +    bond->bond_header_ops.cache_update =3D bond_header_cache_update;
> +    if (slave_dev->header_ops) {
> +        WRITE_ONCE(bond->bond_header_ops.parse, slave_dev->header_ops->p=
arse);

Are WRITE_ONCE()s needed ?

RCU readers will see NULL bond_dev->header_ops at this
point, no ?

If they see non-NULL header_ops, then it will not be changed
because only bond_release_and_destroy() clears it and
we wait one RCU grace period after issuing NETDEV_UNREGISTER.


> +        WRITE_ONCE(bond->bond_header_ops.cache, slave_dev->header_ops->c=
ache);
> +        WRITE_ONCE(bond->bond_header_ops.validate,
> slave_dev->header_ops->validate);
> +        WRITE_ONCE(bond->bond_header_ops.parse_protocol,
> slave_dev->header_ops->parse_protocol);
> +    } else {
> +        WRITE_ONCE(bond->bond_header_ops.parse, NULL);
> +        WRITE_ONCE(bond->bond_header_ops.cache, NULL);
> +        WRITE_ONCE(bond->bond_header_ops.validate, NULL);
> +        WRITE_ONCE(bond->bond_header_ops.parse_protocol, NULL);
> +    }
> +
> +    bond->header_slave_dev      =3D slave_dev;
> +    bond_dev->header_ops        =3D &bond->bond_header_ops;

Rather WRITE_ONCE() seems necessary here.


>=20
>      bond_dev->type            =3D slave_dev->type;
>      bond_dev->hard_header_len   =3D slave_dev->hard_header_len;
> @@ -2682,6 +2738,14 @@ static int bond_release_and_destroy(struct
> net_device *bond_dev,
>      struct bonding *bond =3D netdev_priv(bond_dev);
>      int ret;
>=20
> +    /* If slave_dev is the earliest registered one, we must clear
> +    * the variables related to header_ops to avoid dangling pointer.
> +    */
> +    if (bond->header_slave_dev =3D=3D slave_dev) {
> +        bond->header_slave_dev =3D NULL;
> +        bond_dev->header_ops =3D NULL;

Ditto.

Also, before clearing header_ops, there would be a small (race)
window where

  bond->header_slave_dev =3D=3D NULL &&
  bond_dev->header_ops =3D=3D &bond->bond_header_ops

is true and this would trigger null-deref in bond_header_cache_update().

This is Eric's point, I think.


> +    }
> +
>      ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
>      if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
>          bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 95f67b308..c37800e17 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -215,6 +215,11 @@ struct bond_ipsec {
>   */
>  struct bonding {
>      struct   net_device *dev; /* first - useful for panic debug */
> +    struct   net_device *header_slave_dev;  /* slave net_device for
> header_ops */
> +    /* maintained as a non-const variable
> +    * because bond's header_ops should change depending on slaves.
> +    */
> +    struct   header_ops bond_header_ops;
>      struct   slave __rcu *curr_active_slave;
>      struct   slave __rcu *current_arp_slave;
>      struct   slave __rcu *primary_slave;
> --

