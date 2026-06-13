Return-Path: <netdev+bounces-298985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rzWiDreLLWplhQQAu9opvQ
	(envelope-from <netdev+bounces-298985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459E67F17C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jSWq2vfS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298985-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298985-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF1E3015E25
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B2324B22;
	Sat, 13 Jun 2026 16:56:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60A2E739C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369779; cv=none; b=Owy2xPAIuNbYmbKyxw7XPF0d6Iduj2bucvFiDJvmuGB2LhxfVgT16R/jP0RP0hCygJWXJuwuuOeYSBIX7yBif55iq9bbWYqLPYKtt7jz76gNzIcfrrpPf22iujLU20KqCSGm4vDV8XAQ4EWT2wY5ZakJacKkkZJjX8WWOKb3NSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369779; c=relaxed/simple;
	bh=OcRN0dvhVExCc1iPYl8Woo3eNzb6MQ73PbDp0N3ASFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srPQOGvkP0qBZFZ1d34O+O5RLNx5A4HUHrIHFf7a/LKnK+OQ+wZDGhuHNoN4qjvbDHeQ/cmk5nTrjm8g0jn18S56PCxtocIT0TV9gxwdJUY1zYeRYHjBY4jTM76hDaWOfSwghlFQWLohrp4UvxaXUvlbnPdb7hAFp/9thbMk+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSWq2vfS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840F71F00ACF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369777;
	bh=avvoubDk8e2nEzytqEEY9wzCGRRl3gWpOCEVLy9LPTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jSWq2vfSOH3OD3+kPhbqObbgVIoQHiTgmExtOBeUOZ7Wckxga5uUtgSjYGbrtWSBj
	 mQ8cKkLS27F112vVEazmm38dBjIlunboxcjaf4y9sqnmCdHtfAtIoCepMrPDS51DJz
	 vL1BPS9/7Iw4CHhz1EFX1G9OLwWm9401qFSSi3nnCC6C807U7QHHbrvv8Kr12ZBaAn
	 ag/oYL8POWUzKcF26qOqVcapI16+1qJl6Iaz8MuibsvfUSFVJHQaW5t/xeJLGYum9J
	 D3HV1xRJ1OH2V0upTwAUXaUtvaSu1ST0aIWyiwyqWjEweMd48cBORGw4oP5oEtq4c4
	 121bfdqKVsEiQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso1788663e87.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 09:56:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rJJ37okERTUvX2MmlFDQz/niRY47CktCXT6/kXw4s/G487S93UKcFxnKoU8MJ9kIOQ785WgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeIPco4fw1bdehtvUcQGJXXny9gKH9z2CGTJEPGE5qqC7kc+o
	7MPiLwdepD4H5rGkEyDED5+IgvoaJ6eXhHycek6uxs0kKDK1ZmTh6rkjg6Tclju/mUlJcRDQ8Vl
	akewnyKYFBZbt9NTepXEbzVCgGT4BXRM=
X-Received: by 2002:a05:6512:3a8e:b0:5ad:3035:b354 with SMTP id
 2adb3069b0e04-5ad3035b435mr1275726e87.50.1781369776245; Sat, 13 Jun 2026
 09:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ks8995-to-ksz8-v6-3-d91eb43edcc5@kernel.org> <20260610153952.1685895-1-kuba@kernel.org>
In-Reply-To: <20260610153952.1685895-1-kuba@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 13 Jun 2026 18:56:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
X-Gm-Features: AVVi8CcSz1LnYjEMoGP9ovn6PJQ7Jx899RmuvpmsbrwLVGIm2j-Qib0G7UNm2GY
Message-ID: <CAD++jLnuBv97nUW-EdZXiLmgsUSiVLgkB0R=gKB0zYtr8JN7xg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/5] net: dsa: tag_ks8995: Add the KS8995 tag handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298985-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:nb@tipi-net.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,denx.de,armlinux.org.uk,vger.kernel.org,tipi-net.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8459E67F17C

DSA maintainers, look into this analysis a bit below,
the conclusion is that taggers can't re-use vlan_* helpers
because they free the SKB:s on error, so maybe I need
to create new derivative functions to reuse these.

On Wed, Jun 10, 2026 at 5:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Fair enough.

> > +static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
> > +{
> > +     struct vlan_ethhdr *hdr =3D vlan_eth_hdr(skb);
> > +     bool have_hwaccel_tag =3D false;
> > +     u16 tci =3D 0, portmask;
> > +
> > +     /* Prepare the special KS8995 tags */
> > +     portmask =3D dsa_xmit_port_mask(skb, dev);
> > +
> > +     if (skb_vlan_tag_present(skb) && skb->vlan_proto =3D=3D htons(ETH=
_P_8021Q)) {
> > +             tci =3D skb_vlan_tag_get(skb);
> > +             __vlan_hwaccel_clear_tag(skb);
> > +             have_hwaccel_tag =3D true;
> > +     }
>
> [Low]
> What is intended to happen if the skb arrives with both a hwaccel VLAN
> tag and an in-head 0x8100 tag, or with a hwaccel tag whose vlan_proto
> is something other than 0x8100 (for example 0x88a8 service tag)?
>
> In those cases this branch leaves the hwaccel tag alone or only consumes
> it conditionally, and the second branch below either inserts a fresh
> in-head tag while keeping a pre-existing in-head 0x8100, or modifies the
> in-head 0x8100 while a non-8021Q hwaccel tag is still attached. Should
> this path either reject such frames or normalise them first?

I have no idea what "normalise" means in this context.

What happens to e.g. a 88a8 service tag is that it gets forwarded
to the target port using the modified vlan tag added by vlan_insert_tag()
below, I think part of the AI confusion here is coming from the
fact that we are using modified "vlan tags" and the semantics
does not fit the common pattern, and the statistics that are used
in the training data become irrelevant.

The whole point of the code is to modify pre-existing
ETH_P_8021Q tags in-place rather than adding a second one,
which means that everything else will get a second tag, the sole
function of which is to direct the packet to the right port, where it
will be stripped by the hardware.

> > +     if (have_hwaccel_tag || hdr->h_vlan_proto !=3D htons(ETH_P_8021Q)=
) {
> > +             skb =3D vlan_insert_tag(skb, KS8995M_STPID(portmask), tci=
);
> > +             if (!skb)
> > +                     return NULL;
>
> [High]
> Is returning NULL here safe?
>
> include/linux/if_vlan.h documents that vlan_insert_tag() calls
> dev_kfree_skb_any(skb) on failure (e.g. when skb_cow_head() fails under
> memory pressure) and returns NULL. The caller in net/dsa/user.c does:
>
>     nskb =3D p->xmit(skb, dev);
>     if (!nskb) {
>         kfree_skb(skb);
>         return NETDEV_TX_OK;
>     }
>
> so on the NULL return dsa_user_xmit() runs kfree_skb() on its local
> pointer that vlan_insert_tag() has already freed.

vlan_insert_tag()
    vlan_insert_inner_tag() <- returns NULL on error
        __vlan_insert_inner_tag()

> Doesn't that produce a
> use-after-free on skb->users plus a double free?
>
> Should this path swallow the free done by vlan_insert_tag() (e.g. by
> returning a sentinel handled by the caller) so dsa_user_xmit() does not
> re-free the skb?

I looked into this.

The fact that several taggers do this in ->xmit() such as here in tag_8021q=
.c:

struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netd=
ev,
                   u16 tpid, u16 tci)
{
    /* skb->data points at the MAC header, which is fine
     * for vlan_insert_tag().
     */
    return vlan_insert_tag(skb, htons(tpid), tci);
}

should be a sign that this is OK in xmit:

    return vlan_insert_tag(skb,...);

which is equivalent to:

    skb =3D vlan_insert_tag(skb,...);
    if (!skb)
        return skb;

which is equivalent to:

    skb =3D vlan_insert_tag(skb,...);
    if (!skb)
        return NULL;

Which is what I do.

So yeah. skb_free() will be free:ed twice. The code in tag_8021q.c will
also do that. But what do you expect ->xmit() to return on error if
not NULL?

When user.c does this:

    /* Transmit function may have to reallocate the original SKB,
     * in which case it must have freed it. Only free it here on error.
     */
    nskb =3D p->xmit(skb, dev);
    if (!nskb) {
        kfree_skb(skb);
        return NETDEV_TX_OK;
    }

    return dsa_enqueue_skb(nskb, dev);

The only way to get clean out of this branch if you run
into an error in ->xmit() is to return NULL!

Now let's look at ->rcv():


> > +     /* Move the custom DSA+VLAN tag into the hwaccel area and strip
> > +      * it from the skb head
> > +      */
> > +     skb =3D skb_vlan_untag(skb);
> > +     if (!skb) {
> > +             netdev_err(dev, "%s: unable to untag skb\n", __func__);
> > +             return NULL;
> > +     }
>
> [High]
> Is the NULL return here compatible with the cpu_dp->rcv contract?
>
> skb_vlan_untag() can take its err_free path (e.g. when the
> pskb_may_pull(VLAN_HLEN + sizeof(unsigned short)) inside it fails, or
> skb_reorder_vlan_header() fails) which calls kfree_skb(skb) and returns
> NULL.
>
> The caller in net/dsa/tag.c is:
>
>     skb =3D skb_unshare(skb, GFP_ATOMIC);
>     ...
>     nskb =3D cpu_dp->rcv(skb, dev);
>     ...
>     if (!nskb) {
>         kfree_skb(skb);
>         return 0;
>     }
>
> so when ks8995_rcv() returns NULL after skb_vlan_untag() has already
> freed its argument, dsa_switch_rcv() ends up calling kfree_skb() on a
> freed skb. Wouldn't that be a use-after-free on skb->users plus a
> double free?
>
> Other cpu_dp->rcv handlers appear to assume that returning NULL means
> the skb was not freed. Should this handler do something equivalent so
> the contract still holds?

Yes skb_vlan_untag() will free the skb on error and then this will
free the tag again.

But how do you signal to the caller in net/dsa/tag.c
that "things went sidewise and the SKB is already free:ed"?

So these semantics around ->xmit() and ->rcv() free:in the skb on
a NULL return basically challenges Vladimir's request that I
reuse these functions in the first place. They are not made
for this kind of reuse.

What I *CAN* do is go and create wrappers in skbuff.h/c
that will not free the skb on error just return NULL anyway,
intended for this one user (to begin with), such as

vlan_insert_tag_no_free_skb_on_error();
skb_vlan_untag_no_free_skb_on_errror()

I honestly think these are good names because there is
no risk to misunderstand them...

But then I want some buy-in from the maintainers that this is the
way to go.

Yours,
Linus Walleij

