Return-Path: <netdev+bounces-300064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gEzbBbtWMmpMywUAu9opvQ
	(envelope-from <netdev+bounces-300064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6F697742
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:11:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b="DHuZ/qzg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300064-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300064-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77281300E3F7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58F3B3C15;
	Wed, 17 Jun 2026 08:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFF3BBFB4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:11:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683896; cv=pass; b=XK6o0Et0VrYk90ZMhEczrToFywT467XT1ZW72B+tKugOY/SzCK3Q+QzA4YtDwAr0UUR3rN3KaCbgdke54TEsUuicsmei11yojo8rGcQSqn9EWg3+JkJ7CNlcv8doCyudOIa1pTXqVwOAah/ejFXDW9V6dowyf0hHaB+Y/3zSngQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683896; c=relaxed/simple;
	bh=kf0DRLyNChKi5D+asgxSdwNYBi+4mzeA4mh7cya81Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r34O/vGl4E1ssbWzWKYA9vxEHQmbdGQ63c9BY7lnwclypfEAEtAMb4ouRBgDibSwjcyYJaqg1yWkGfFPKF19Bz6EcyECE96mLkLs25/QYIDIKwU9qPn8HknbfEVnOX0aLma8118o0R746gAKrZM2GCrOaTvERRqZTUxnWZMQId4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=DHuZ/qzg; arc=pass smtp.client-ip=185.125.188.122
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 79EBF3F63D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781683891;
	bh=/nCGBwD162szJNn9Qs6BTAgC+93fO08EX9M68ZjPe5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=DHuZ/qzgWme8hZ39CIFu8hBHPVDXeE/CesbwTsVXyY8rKDj74RtohDgPGfOyj9Px3
	 tQ6+/fVQWW/YDAH8Mxs4QI+TLLXo1HWyVseMoH6BI/j31jGaUAdylLSxYzFUIqe8iI
	 jJGw4vDbd7Y4KkplJikzUshZu+LA6UzsJ55djToSZtsF47PBKwS44f26B3P/P2pYNB
	 WpyRlSA4jOmwI7kw9g33DOG+ggvSuAnEeWkEI4rbEmdEWC2tTQbgxQAeAwOxKsszA5
	 FqjuOscVuYnDrlho9EM4HHq1WGlF9DuBaW3Y8ICz4eOvvcT1qrZz7hovBeZQJL5BaV
	 hVyd1MMwPANx4rZPC4smgiFc5Z/9Q5JFLDHX8Hqv1ThSdGu3jX7gyDe5Gr/DO+49U7
	 wdFHEW6rOK70jtCINsSAssO9TsS95HKoxz6M07Xe18iS1xKVN0lb/8xMprUl4/9yXj
	 I/dwqNyHlIMpnOIIxMVIC+v4fBNIPP8OG9yhS5at6S4gMPorN9TCXyF7TIdnCCseVt
	 ku3zDHnBhi9WZpRgAH+e4StS8YevcTQiIl3c+Iqh27McFa9KnuTACOtASWWt/atiOK
	 Tr7wibkS/NbFnF+A+9ACdJziG5DQlPbtdZdPU9A3jTiNkIll1LZKOCNl8JxN7JYMI8
	 xWxPpXe7pKlZhX0rJf0pqdG0=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c02d992ac32so99652066b.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781683891; cv=none;
        d=google.com; s=arc-20240605;
        b=P/7zVTovuhXPeXWqT+5MrD/B3cqFRDNdAZSTXMYCDgBDX7X8UAxtqX9gIt4n5+a63o
         AYJJQQMDL8OgAqLPcAs0w1uGSYhmsIw1CyXz6Xd2UmqOI1XEkwqy6QgBUjQrdG0KIqsQ
         ZAJn5GBt+Xuh9JyVx6xgN3qnbDodLq4EmWjaWu0sEtehi0x+aK1ZggpS9Vl1xmHfF9tG
         JARjTCwQCpkqeXF7ZmME2mv6KvwxvEPjy+IhyyXnj8Es3e8QXWTvtNAPPfBeeSf/OcXr
         NrXRuLlohSKcWbqd1KUZyeOuh+MAY7hSMsJ2n0iqQRapzCIz2exkXxU+Q7CAsTTVPeuw
         X6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=/nCGBwD162szJNn9Qs6BTAgC+93fO08EX9M68ZjPe5Y=;
        fh=jijQY9XVtK5U4wljg/eqDTalABG30TC7Ezge8bD6QuQ=;
        b=NkO20HtsLgWRTYl2+eytvB0J8Zbjpk51sl2BHsnIMwAiYCnRTbCOMUWgkd2rJW9bBa
         hDDCrab5vfx7wLlJ7igvoAyRZgP2lM4PMBfUJqF4M1Hg8uaY2VQtMj/7UsLGH0YnMRbM
         04HCgJCOEBs1QB76LSYH0BzVIXu/rXnoykz+W6vrOs7VhszQR9WHUE51V9wIzPFvIOrJ
         W8e/aSArG70yL+zXmjcDdV2J7nb7s3EkHMQ4Sa/TvW/oNJ0YfQkDB9XiUNSZwP7tIUa0
         qUAq6ZeU98PKJMCIxTksK2oq8Zr1T/Q364hzOPzK9L48l8Ct8+RYzx4aRg9XqKZJCcGT
         outg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683891; x=1782288691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/nCGBwD162szJNn9Qs6BTAgC+93fO08EX9M68ZjPe5Y=;
        b=Khg8r8q4ixvlsdV3ejXOA98s8KIXfDFx5fOlk/9VuWz1JEmBZ9nSYlpqWZj9XyrBTd
         cSIlhzgNvZSAev9j+8PXEz+jxhGHYjL/DQUDdciJxa1QW4qOejM4iFtuvUZpJIq4ciaQ
         mw7A0Omk9yf13UlOu4jb5ilnWuozTSxIkj/Rja9gfHg6xoNRZS2IAYKIHQC+nb+hq2lk
         sd7g6TwXz5BhtesVBY3o6KPhiv5KldaGlVpDRnSU4OMJanmXLQOmCxUuYjSj7CEkXoDk
         duZiYqcZFaP+/ue9tb4UXc6bu5vZEC+nTsqWbMblX5b76Kv8p7LX3jok/XbNVxW7iM/O
         NMTw==
X-Forwarded-Encrypted: i=1; AFNElJ/HBS6B8rCpniWTldJW4XjY1YrfdezWFaNXHH36z5lM3Ncl/5u+sH1FD7g9oT55PMSHorvauJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsMr0kzQmm9Yq7ctXDkgv3eSfZ8V3O554LSAFZzgdZ2vDVInl
	V4Ab/lKmtcfv2lntjyY18hpHLUhfvCvk4R4rGYfnSLhsRh87plFowAMPz+ucjmtSEZwoOIZ8mBV
	bKe/brbJiQ5RSb9ATutsfIRdQq71uLkNnwCjGkqIv3MdhIsIq2DuISTKjv0FZP/AQUZxtues7v3
	Vwqp6MOmxmN+tKtjjqq0GGKarIaJ1aGnSUcPvL8eJLn5fa5HQzY78V0fCnk/M=
X-Gm-Gg: AfdE7ckRqhrU+75AwO5nsHoZ1sx2joJkZo4/5eDv4AqCWA9rU1PStk9SFVAi2zne8W2
	+jEQqVaCU3hX0wjI/Mvk0FJGu8AO+E57/teIpZ8nMIoABLE7yGvWpPaYz1Jjpk4/RJnWFAkRLOv
	1PjDsknJilKF491zcTpAqmQrL1rcFMpZs0VYBrxsIHATE6iqoMPUFJrTMI3rGa3tpW/g==
X-Received: by 2002:a17:907:b598:b0:bee:1e36:876c with SMTP id a640c23a62f3a-c05a4c1703cmr127658166b.41.1781683890993;
        Wed, 17 Jun 2026 01:11:30 -0700 (PDT)
X-Received: by 2002:a17:907:b598:b0:bee:1e36:876c with SMTP id
 a640c23a62f3a-c05a4c1703cmr127657366b.41.1781683890615; Wed, 17 Jun 2026
 01:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616220827.1647052-1-robert.malz@canonical.com> <IA3PR11MB8986729EE79F3F3FBAAC68C9E5E42@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986729EE79F3F3FBAAC68C9E5E42@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Wed, 17 Jun 2026 10:11:19 +0200
X-Gm-Features: AVVi8CermetHG1NdOVU95fywiNV30CBfr7FnKauDUwLoMzw0Bom8jxXphJvrdgA
Message-ID: <CADcc-bzhOdYshOJAZidJys4SckKjGRgq=i+wCHDgdYHrPXn8cg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: retry reading NVM if admin
 queue returns EBUSY
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300064-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,canonical.com:dkim,canonical.com:email,canonical.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76F6F697742

(resend)
Hey Aleksandr,
Thanks for taking a look at this.
exit loop, just like in OOT, happens during:
> if (hw->adminq.sq_last_status !=3D LIBIE_AQ_RC_EBUSY ||
>    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
> break;
And by the way, I have v3 ready, which I plan to send 24 hours after
the initial submission, it doesn't change any code but I want to keep
the netdev bots happy.

Thanks,
Robert


On Wed, Jun 17, 2026 at 9:47=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Robert Malz via Intel-wired-lan
> > Sent: Wednesday, June 17, 2026 12:08 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH v2] ice: retry reading NVM if
> > admin queue returns EBUSY
> >
> > When the admin queue command to read NVM returns EBUSY, the driver
> > currently treats it as a fatal error and aborts the entire read
> > operation. This can cause spurious NVM read failures during periods
> > of high firmware activity.
> >
> > Add retry logic to ice_read_flat_nvm() that handles EBUSY responses
> > from the admin queue. When an EBUSY error is encountered, release
> > the NVM resource lock, wait for ICE_SQ_SEND_DELAY_TIME_MS, re-
> > acquire it, and retry the failed read. The retry is attempted up to
> > ICE_SQ_SEND_MAX_EXECUTE times before giving up.
> >
> > Code was extracted from OOT ice driver 1.15.4 release. Additional
> > change was made to reset last_cmd in case of retry to make sure that
> > all commands are retried properly.
> >
> > Fixes: e94509906d6b ("ice: create function to read a section of the
> > NVM and Shadow RAM")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> > Changes in v2:
> > - change ICE_AQ_RC_EBUSY -> LIBIE_AQ_RC_EBUSY
> >
> >  drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++--
> > ---
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c
> > b/drivers/net/ethernet/intel/ice/ice_nvm.c
> > index 7e187a804dfa..b3120605d66f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> > @@ -67,6 +67,7 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> > u32 *length, u8 *data,  {
> >       u32 inlen =3D *length;
> >       u32 bytes_read =3D 0;
> > +     int retry_cnt =3D 0;
> >       bool last_cmd;
> >       int status;
> >
> > @@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> > u32 *length, u8 *data,
> >                                        offset, read_size,
> >                                        data + bytes_read, last_cmd,
> >                                        read_shadow_ram, NULL);
> > -             if (status)
> > -                     break;
> > -
> > -             bytes_read +=3D read_size;
> > -             offset +=3D read_size;
> > +             if (status) {
> > +                     if (hw->adminq.sq_last_status !=3D
> > LIBIE_AQ_RC_EBUSY ||
> > +                         retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
> > +                             break;
> > +                     ice_debug(hw, ICE_DBG_NVM,
> > +                               "NVM read EBUSY error, retry %d\n",
> > +                               retry_cnt + 1);
> > +                     last_cmd =3D false;
> > +                     ice_release_nvm(hw);
> > +                     msleep(ICE_SQ_SEND_DELAY_TIME_MS);
> > +                     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +                     if (status)
> > +                             break;
> > +                     retry_cnt++;
> It looks like you added the retry_cnt increment but you didn't add it int=
o the loop exit condition.
>
>
> > +             } else {
> > +                     bytes_read +=3D read_size;
> > +                     offset +=3D read_size;
> > +                     retry_cnt =3D 0;
> > +             }
> >       } while (!last_cmd);
> >
> >       *length =3D bytes_read;
> > --
> > 2.34.1
>

