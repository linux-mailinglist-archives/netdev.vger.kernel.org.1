Return-Path: <netdev+bounces-263743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD7gM2wLqGn2nQAAu9opvQ
	(envelope-from <netdev+bounces-263743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:37:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626B1FE748
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA03301A7D2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EC3A2554;
	Wed,  4 Mar 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NZrzeH2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8939FCD8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620648; cv=pass; b=H1IfM3ureDTKEAoMk+m8UEiRS6EPKDZNkONFFZV2dHmHLjQqN+nn5LVqHXRAl9C3ydIWLP/oomsjlfgTqhtg2JUpC39rW97tWbQvwe5aiqrSXN6ZRgtuCJnxZLHOF8yzqm0mbCcAtgiDyDBmgPfeNUYhE8C2zhB29XwVIJ4XmeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620648; c=relaxed/simple;
	bh=XIi5xf8KuZW5QiKYZpqHfhhdIC+7uLVGMrHwp9wqq/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcOJdrCFpuG3nN9oi4IEBBMN2wguH4Ys4sqyRoyMpFciPwDFf0Nk4iIqxTwym/d3YdTPgZ1G3yrfHQcqcXAK5zG6MJ4fyVtmCO0Y6nI5pstLBRAJDOv5eeYgC+ZJgB3SpGPaPhFrtoiPMf3XYoEHNyd2a8LT0gsJlVNpKAW3qs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NZrzeH2w; arc=pass smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79868cde1eeso74144817b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 02:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620646; x=1773225446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uva4ZLViWqYJ2nL522aOTvjOEasJWaw4k8XfYKRrbU=;
        b=cnxfTNUD6JTBZjmsM2ur8zyb+01WJI+hJhlNAYzzV6oSLiwwaWeSDULJIXoVcOLK7g
         eMPtJc8HiSYhV129pbsXJV6fvy68njosJ61OF/eFE6HhCG2laEdGW290HmMw+BBPYdk0
         5B33S51ILH/icMsRJPL8HdP/bYnGoxXz6cBPXVnymjqgYLKwb4vt7xguFjrLbjAG/fgn
         LLNFKuvkl2Mul1V9xCuf2mA48fwiQzBS0eqorzJRKIGMr5XdLIv9rWuNgCxsNaL7P55A
         G3wKXkZJyCd3fg/Us1/3IsUOSEAAe8/myf14V5ks0R17rSr7QWuFvLX+ElJYD576L+rS
         x8Tw==
X-Forwarded-Encrypted: i=2; AJvYcCWwiecYFmD/DINE3rT0pdMBMqhqbnjZbMoPAkF1qBOg3cf2zLdkuP0jTzO+CGEtAb81h5JuJ74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcyu006jD6gaTASeItF/19YqNqbwfs6xPexIODAi4pt7yyW+SM
	y3m2txcBA3DchUGxWXA9Pm5nnyAtNjFjm7UKiWyEn6G/ahJXoRPAtnbqyRgHsFE3FW2wmVnBSqB
	RiALSgTPsSBuIsI8YSkMnRgFzV1dj4Jh1BZi0YUUcVqbqYaUq4bQZVBeI8r6pMMe9+lAu/grX9p
	8CHJGH36wuRTCi/ur1YAVDwdTvuE1MZf/BcYnB1wg9x6KP4QB8pmgNF5goEHlg0f95MoSZBGFZZ
	ot2KYCtrDKoRZIyhg==
X-Gm-Gg: ATEYQzxtKCjj3xsPcGGQxSJxm7ONybPk6Cc+2RLSXJKxgnsAQlwGArawbraThQolTHu
	8hmX9P6TUgS+IvhNYo5g1Cav8fNBFKhVp1/EhKIBNSOzNL6nWcJZvKtYrgWyAaqTG72tSuiGNpQ
	5nPLwyWHuq/mQG0nKI0dkDcY5UyVAWqArLM3GdR7vK9Hnud8D8OgccoXPoJwI9n/i1Wpnq1ba02
	aF9S0ngZk2L+zYenJi6CCHcQjqLbfYRyVs1xxLd4UxplCvyjlPtJeN+sGeYJDqsk7RBgQ6AV7/P
	Kpajr0C3tSZISbphWSY8oSSZfLK3Xuz08UwRfx15zZFrsNX9B9xGoI4u/pa/ZJ/hQ6uPyatgpA5
	HokbzJx9rjK/W96cZeyCmhOOnbxdS2hNGlyQYCjQGGvbORD7VaWLqol5kNU0D8TAQwP8RHH5mcw
	Vce86yEA0XKkYLiEp0oGvkjbhMIp/L4w7BCIviVXm1/UXeelsA9g2a1/B8Kji9hRb6Lw==
X-Received: by 2002:a05:690e:130e:b0:645:443d:10a2 with SMTP id 956f58d0204a3-64cf9b5d8femr1206870d50.26.1772620645647;
        Wed, 04 Mar 2026 02:37:25 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb74b7fb8sm1870768d50.0.2026.03.04.02.37.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 02:37:25 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be07cafe1cso46360795eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 02:37:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772620644; cv=none;
        d=google.com; s=arc-20240605;
        b=iOGoCLvemzsCjyJpNs4sMbZaxUIACB9WAdpYmOVxZjQDMEGyYV5a7bZ0+Ti73lq9WK
         HV7J1sbDZhShDjfnBt7mQ5yA4UVl0vecRHTEXIBfofhM6JwD429+fNv7tPwRolS1/KDF
         wBecWGyjuRDpGbfmvJz/XHoR9UaA3hxml1EQ1wQU4+AGrmXb6+XVXPmNMP1TuEFeG283
         RRwNSKraEpy35JKLq5lNTlWfDCLbOlD9gM9y4tQBpTMSCtZ9dpbvMZB4Aias+JktfvON
         f61+q5RyTM4EwNvdPRvTOfKZPyxiYz2MtLZjW660fT26UEfEJs24lL1m/wojOjAhU1oz
         OyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+uva4ZLViWqYJ2nL522aOTvjOEasJWaw4k8XfYKRrbU=;
        fh=KG+9dIZy7TGzXqeiUszOPL9smREAhxzrTeC9D4EbQlw=;
        b=WZhjWDKyHZNRGVuS+OQ/R6ped/1X/vF37SFRq1plQvWvvbYT8detlh2hdgLk2oL++k
         sDFQ55YHjhe668ZLMb83B+2XvvDkMaR4hRis5ha+Sph5XqmbEicXrOhYZRDfISOTUkNG
         a9totu/xzz0mIt25UdoVwUAA61lOgy7i8ahapnQmsOw46CBGVYElOAPcOMmdeA14eB3/
         eEEudCfDWveNZgqKW7Lp0MzhCb+LdssL8vm1O8au4Dni2jMWFbj22ROXNm1xht3vsBum
         fL/bkdMLKbY+zSgYES4tjPKgf6rRLNOKXMsqvovuC0vzv2exlXSFvzsWNO7J8Q9VgSmw
         g5pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772620644; x=1773225444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uva4ZLViWqYJ2nL522aOTvjOEasJWaw4k8XfYKRrbU=;
        b=NZrzeH2w5eERQI7R0Y7JdqLWDmIGMKYNDoK/l1msZSJ+DQu4C5LKLDK7AskOVeN1AT
         BHJUDaBldtATZqmCUxbm3r0KOrJZWuIo0i6f+vuPi6dhvVEXKtQCRbQwn/12vbtgFutR
         oK8I/e4o3kW1g5qBmjrKEr0KVqjp+3IwV8uUo=
X-Forwarded-Encrypted: i=1; AJvYcCX1Doo+b4ttZlTFSJfH+w8+UTBmDaXAWeh403gtJRhUdLKh7XZ83LCGI+LM39mjwQVJKmjwMcs=@vger.kernel.org
X-Received: by 2002:a05:7300:6422:b0:2be:2e4c:20b2 with SMTP id 5a478bee46e88-2be311df68emr561392eec.36.1772620643960;
        Wed, 04 Mar 2026 02:37:23 -0800 (PST)
X-Received: by 2002:a05:7300:6422:b0:2be:2e4c:20b2 with SMTP id
 5a478bee46e88-2be311df68emr561376eec.36.1772620643373; Wed, 04 Mar 2026
 02:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228072715.1632280-4-bhargava.marreddy@broadcom.com> <20260303030029.1884718-1-kuba@kernel.org>
In-Reply-To: <20260303030029.1884718-1-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 4 Mar 2026 16:07:09 +0530
X-Gm-Features: AaiRm51y_xBhQCdPcVVnVkhFHiwhap5JHcfyAl5kY-txf2Jz2DbiJefc3T5ZiqM
Message-ID: <CANXQDtZZTmh1axG3AnM0WH4FgDh0b9Mm5JqdUd+41CqdMg7Zjg@mail.gmail.com>
Subject: Re: [net-next,v3,3/8] bng_en: add ethtool link settings, get_link,
 and nway_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com, 
	horms@kernel.org, pabeni@redhat.com, michael.chan@broadcom.com, 
	linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	davem@davemloft.net, netdev@vger.kernel.org, rajashekar.hudumula@broadcom.com, 
	vikas.gupta@broadcom.com, pavan.chebbi@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d5b9aa064c306785"
X-Rspamd-Queue-Id: 4626B1FE748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263743-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url,broadcom.com:dkim]
X-Rspamd-Action: no action

--000000000000d5b9aa064c306785
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: add ethtool link settings, get_link, and nway_reset
>
> This commit adds get/set_link_ksettings, get_link, and nway_reset support
> to the bnge driver. It implements speed reporting across NRZ, PAM4, and
> PAM4-112 signaling modes and enables lane count reporting.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/et=
hernet/broadcom/bnge/bnge.h
> > index 83ee4749cc70..e9b83c0c64b6 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_link.c
> > index d96fe662bba0..c2b3511fc913 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
>
> [ ... ]
>
> > @@ -458,3 +503,755 @@ void bnge_report_link(struct bnge_dev *bd)
> >               netdev_err(bd->netdev, "NIC Link is Down\n");
> >       }
> >  }
> > +
> > +static const u16 bnge_nrz_speed_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEED_MSK_100GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_pam4_speed_masks[] =3D {
> > +     [BNGE_LINK_SPEED_50GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_50GB,
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_100GB,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_200GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_nrz_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_pam4_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_50GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
> > +     [BNGE_LINK_SPEED_400GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_pam4_112_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_400GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_800GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_=
112,
> > +};
>
> The bnge_pam4_112_speeds2_masks array is missing the sentinel entry
> that all other speed mask arrays have. Jakub Kicinski's AI review in v1
> identified a potential out-of-bounds array access in this array.
>
> The v2 changelog claims to have fixed this by 'adding the missing sentine=
l',
> but only bnge_pam4_speeds2_masks[] was fixed. All other speed mask arrays
> include '[__BNGE_LINK_SPEED_END - 1] =3D 0' to ensure any legal speed is =
a
> valid index, but bnge_pam4_112_speeds2_masks[] still lacks this.
>
> While the array currently has an entry at the highest accessed index
> ([5] =3D 800GB), the missing sentinel makes it inconsistent with the othe=
r
> arrays and may cause issues if the loop or access patterns change.
>
> Looking at bnge_set_ethtool_speeds():
>
> drivers/net/ethernet/broadcom/bnge/bnge_link.c:bnge_set_ethtool_speeds() =
{
>         for (i =3D 1; i < __BNGE_LINK_SPEED_END; i++) {
>                 for (m =3D 1; m < __BNGE_MEDIA_END; m++) {
>                         ...
>                         bnge_update_speed(&delta_pam4_112, m =3D=3D media=
,
>                                           adv_pam4_112, sp_pam4_112_msks[=
i],
>                                           et_mask,
>                                           bnge_link_modes[i][BNGE_SIG_MOD=
E_PAM4_112][m]);
>                 }
>         }
> }
>
> Should this array follow the same pattern as the other speed mask arrays?
>
> Reference: https://lore.kernel.org/netdev/20260224001201.146384-2-kuba@ke=
rnel.org/

Thanks, Jakub.

The code was functionally safe, but I agree the inconsistency in the
array patterns was not ideal.

I will address this in the next spin by explicitly defining all speed
mask array sizes as [__BNGE_LINK_SPEED_END]. This ensures a uniform
structure and removes the need for manual sentinel entries.

Ex:
For example:
    static const u16 bnge_nrz_speeds2_masks[__BNGE_LINK_SPEED_END] =3D {
            [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB,
    };

Thanks,
Bhargava Marreddy

The code was functionally safe, but I agree the inconsistency in the
array patterns was not ideal. I will address this in the next spin by
explicitly defining all speed mask array sizes as
[__BNGE_LINK_SPEED_END]. This ensures a uniform structure and removes
the need for manual sentinel entries.
>
> [ ... ]
> --
> pw-bot: cr

--000000000000d5b9aa064c306785
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDQscgI443hMwmaJiPbg6XWHl/OgxUhtrRcmoTwpj0yLzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDQxMDM3MjRaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA9ICJ1
bE3TNpPUrNFYVpBCNxWmsnLvk5/MuVSAzRyq1/Zlh746O0hvM0lzUJu4Z27q6rt+BnrabPnPNKcc
cHKPC7Y8zSfmNq9FCPXOeq3/eNbFSvkxr6bjdbevpugS9vY0m6sAUsYd4ur3BTxJeI+AR4kSQAft
3crPQE7dbonsnKFSXLsUNlin0QrZ9gHU/k1kXl3GnSurvH8lLpMPKYRLdvrjAO+I20EkAeFON72J
3LJsv9tixssRSEqRzIa0JEEjiF3pKbMG1IG3sqEXskEBgUvfR6EZ5xrKjU3/zJE0SFu9dYcOMnzv
H17OG7UhPIiXs8CdBdZx6WAbsvtYM/pf
--000000000000d5b9aa064c306785--

