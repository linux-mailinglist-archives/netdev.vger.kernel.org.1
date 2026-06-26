Return-Path: <netdev+bounces-302120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3gfEnE5Pmr4BgkAu9opvQ
	(envelope-from <netdev+bounces-302120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA606CB614
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:33:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=RlPf++VJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CBF030AF545
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C143E6DFF;
	Fri, 26 Jun 2026 08:24:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774383E5A3B
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:24:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462248; cv=pass; b=V1R8MioakUiScvC/hCH+9hvQgTmS9u8hxbKtHLczws2cic0z98fML/MSjcpUmKdTB+DaavVdPnT2rL0icJMGoWMms8N5lw36gB9LPVObEbjti6NmKKUITEhZ+ZrUs+uZp6IPqMOyzlqa+0migw9SRFXL4v/nSH9QsLGOi6ev2Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462248; c=relaxed/simple;
	bh=/05R8D8Gj8PvLHvW7M8Nu0pFycvuXBG8B7/H+W9qCcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKGmomWvpGP07+xf0fK/5GooyTVVSd0B9mI+FG8zv+SHM1t3UvvF4Vtl37l9HJd8ZQXRCWC60JIUqC24wq8m/JogmiKJwRO0hlUB09/nrkLPKx+oBC+jWYedx0PVzL1o+WqtH5uUiMzB2ypjtXAZB3fgU05A8EoesZD/i7zz7pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=RlPf++VJ; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 80B5A3F984
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782461743;
	bh=OgQYhnBPA9xSingLmEVDWnoZ9cbftBXdPmeGfHhGAH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RlPf++VJd/ixzaA2SQzpY8aiFX1GsRn/rDe+AFrWxZZRCV3BbaYaRAgPhI+GAnacv
	 70JTBaBCHv1uTXd0Ybcdbo98tCy0vhgOHAiAc1cBxp/+5S/rIY8wleDbCDrKhStE2G
	 ouQdLSThEpYa/yIHAwefEuiqN3aUue+Xcp99O6hS7AKAt37+cVfpliyuFjYfWtnDtl
	 YqcTAdm7suz+Z+B0TnTJlS+QTtCnoYCn+fD7/fBSkHCnzGy2OInbrOtLGoi2D6rsM3
	 l3weTOctJUHuGrSuslzLIjwaLMfpHFCGQZo0sEAw1wjaBCT4M2UtaOr2FM5VtBqp+i
	 ZIQPmm+APCogHMuK2vF0JI2sm89mRpadionM3EBneZvZwFvE1+qa6QG4L3DljwOerW
	 kv2hSQ5k+BfC9EpaUZAadMVWUO6S15KzDcp7qixsNZIf7KuGyEeflomQi3wRKyxJxj
	 1t2DVO4fbB3uHy/ATJgVVEDu73XYmt/YDQiFiT4B/T+oyRq5vDbC2rEATY+qalTRQR
	 WE0ztUZZsjeMnslbv5xo3nGmHFdE4IanV348PmXrHf5LxkSiNBC96h4+P/93bB7C1h
	 XsmFy4LdfMTqNePQ3PJblHUe5XDel2yjnADjVuMK8k7zahHH+33BkN9C8ZAY+Ndjz3
	 9PLjUn3IYwVvOHQBxWJD+9Fc=
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39ad2e6474dso2801931fa.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 01:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782461742; cv=none;
        d=google.com; s=arc-20260327;
        b=InV8xBOqBkGHZkKgrxcolJRHKa3Kt73ip4FZ+ifHaORicLQrtl6Wc7ATmW+7fxi0Ar
         zOcYNocD7NApxEjIoWKLgAlVCdXsxR6GV9oieH8vDqe0+ZKOlyNhQKwjjCuL+3ruHeSV
         DjFmp+dMawvnphbamFyT+3Le/vZ98XZM1ijZkHHfw1lFh4igAanR3yNVbizdQ3jqXVJx
         XcgemQ3ku2XMGvgc2bFjM1CNHPD0Wnb1psWipUak9K6BsYFPhHmyLaraYZs68nhDv/Bw
         HbemVziZ/rth0VHX9BVr9VyAvfnv7Bg2fP6MDwv8YBzwPSIqAJFUVsgQaZNEJP8j6cWc
         +4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=OgQYhnBPA9xSingLmEVDWnoZ9cbftBXdPmeGfHhGAH0=;
        fh=bASxa9Xhgx4ottF9eDxJ3f7CHBQN5UTppsgX7dxJfyE=;
        b=Ay7yuKBlH7HAxmJPtqq7+TWguIbOhOMGiR24CDxKjFlz2xHOYqPk/HysBHW/pERvla
         AXOTYDh7lgJVDzakanXhSGitCWsktE7plPXiqxaq6ot2qA0kWQANCJ34YIsvZ73Jkjrz
         zv5NPLOZfy7yse3t8pTMXTYUDyHY0tQrBimMxD/bKL2h99J6SbHwop+DLkpgxvk8jmEJ
         8vJoLZnojEFJADAmoIwh7aOKNaRoIKG8WgJMnWOTGvV94Tn/OubGrGRGx3wUg7qGp30Z
         qF2LhQHdcsbIzWiP/LCYdaHNyxTX2fr5t5JuRGCDA6OLUMVCcr2RdojW0w7v7mO5V6zG
         Y3ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782461742; x=1783066542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OgQYhnBPA9xSingLmEVDWnoZ9cbftBXdPmeGfHhGAH0=;
        b=ZRVcAAk4o1O+ev8T5/kHhfpBOw3eeRYRmeZU+jWakQ354Ptzb/e+ndv/D9ahZ3fP4l
         U+62X0QNHZJ1ggBGdMvbnAxxow8aQs1UAytnzIfE7tkFbmP9hOadb78HwSDXtaLOMGP9
         9QiELOBII3siA8oivR9LHRvk6sHogsWBdeo2gvD5puWRI8LYu+RblCSb8RW/YqjDZjbE
         DQRfB1q58XYCJofqVQfGAd7HkA6GVnCmqofi8X0L/iThu5SLgnmNFyIGl1jhy9TNhj7j
         KXKPsQT/kGhQBDDu/1ux0R55ibWUCgQddIWDJoUZLlSSn+XYk3ZJtrh9U/FutgMjRdXN
         N1dw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6vpQ3sCK2/ORGJG9J+S6NUPT6vcF9cvDjlWGHTIWjLt8Of+M5AutgBjX85joUZMwXb5d/O3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMJMfFjtWVF/nfC6YzHag7TzZfmkC0I2f1QLMUSxELPkN5zjq
	/gjrtIcNpQ5Wimk9yYo706kNxDPpvWszcWyVtxBRO6IZmYZdIlBn8R4ohj8BfCjWl9iyZ9U3udp
	LBZOPoeuESsyXgeYtpcwlYmT+DLoE/yFpIILt03eq8yfZ7LL1J6eQxOwWy3CN3iuZNCcbbtidzk
	wH3Y/9gd07LGLYlWYnU3zAB+SphGFo1nDngqtP7wNnYLJ99Beuzw9HpxVgxR8=
X-Gm-Gg: AfdE7cmy9UBmOAdVCr1isJFeXsuCa/NwLt6OxdEulQ5YXkXY7c+Abl++K63L/eFr99w
	oFdj5Ht6aeRhAVbp8uMAJTqdZ9f9KanK7CJsU/MTviZrzYkGL6r253+5ajiQlw2KeGHuk+ig/Wi
	APiv0QX4w31AaiwOze6yI+H8KWwYn61xre26GlWHWw0TwPAsPuGzPYSCbqo9pmRazTjA==
X-Received: by 2002:a05:651c:212a:b0:396:76f9:ac7e with SMTP id 38308e7fff4ca-39acb9235b0mr18271351fa.18.1782461742235;
        Fri, 26 Jun 2026 01:15:42 -0700 (PDT)
X-Received: by 2002:a05:651c:212a:b0:396:76f9:ac7e with SMTP id
 38308e7fff4ca-39acb9235b0mr18271151fa.18.1782461741730; Fri, 26 Jun 2026
 01:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617120753.1785565-1-robert.malz@canonical.com>
 <20260618152003.909400-1-horms@kernel.org> <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
 <5658849b-0425-4132-ba32-5801e2907c60@intel.com> <CADcc-bwd2CcWJ1AFDm1GR1HBzo2OOh=Xr3moNS+-RVuai6yVBA@mail.gmail.com>
In-Reply-To: <CADcc-bwd2CcWJ1AFDm1GR1HBzo2OOh=Xr3moNS+-RVuai6yVBA@mail.gmail.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Fri, 26 Jun 2026 10:15:30 +0200
X-Gm-Features: AVVi8CdsJw9dyW9R50Ina3FFrRwP7Eb30UB2Bd0WBDmOtq6je4hSoJyp5G--v_4
Message-ID: <CADcc-bwC4FGQSGyRcnj2ZpGT5+0Q6mjQd-FTCB-mCmmwYrC8Qw@mail.gmail.com>
Subject: Re: [PATCH iwl v3] ice: retry reading NVM if admin queue returns EBUSY
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Simon Horman <horms@kernel.org>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302120-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:grzegorz.nitka@intel.com,m:anthony.l.nguyen@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,canonical.com:dkim,canonical.com:email,canonical.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DA606CB614

Hey Przemek,
I ran some tests and unfortunately, the following sentence from the
datasheet is true:
"For specific resources, such as Change Lock (0x0003) and Global Config Loc=
k
(0x0004), this field is used by software to override the default timeout fo=
r the
operation, and also to specify the timeout used for this operation."

This means we can only change a default timeout for 0x0003 and 0x0004
but not for 0x0001 (NVM resource).
Whatever timeout I provide FW defaults to 0xB88
Input:
[ 2209.656758] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
datalen 0x0000, retval 0x0000
[ 2209.656760] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000000
[ 2209.656761] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000BB9
Output:
[ 2209.656927] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2003,
datalen 0x0000, retval 0x0000
[ 2209.656929] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000000
[ 2209.656931] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000BB8

Correct me If I'm wrong, but the only way to properly handle it is to
ensure the resource is locked and released between every
ice_acquire_nvm call.
I'll start working on this.

Regards,
Robert


On Thu, Jun 25, 2026 at 12:14=E2=80=AFPM Robert Malz <robert.malz@canonical=
.com> wrote:
>
> Hey Przemek,
> Thanks a lot for the feedback.
> I was sure that we use ICE_NVM_TIMEOUT (180s) as a timeout every time
> (ice_acquire_nvm) but your proposal made me rethink it a little.
> First of all, the datasheet for E810 specifies the timeout as: "As an
> input, the software might specify timeout longer than the default
> taken for this resource, and up to one minute."
> 180s is greater than one minute so I took a look into AQC logs:
> [  110.698471] ice 0000:05:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
> datalen 0x0000, retval 0x0000
> [  110.698474] ice 0000:05:00.0:        cookie (h,l) 0x00000000 0x0000000=
0
> [  110.698477] ice 0000:05:00.0:        param (0,1)  0x00010001 0x0002BF2=
0
> [  110.698480] ice 0000:05:00.0:        addr (h,l)   0x00000000 0x0000000=
0
> [  110.698645] ice 0000:05:00.0: ATQ: desc and buffer writeback:
> [  110.698648] ice 0000:05:00.0: CQ CMD: opcode 0x0008, flags 0x2003,
> datalen 0x0000, retval 0x0000
> [  110.698651] ice 0000:05:00.0:        cookie (h,l) 0x00000000 0x0000000=
0
> [  110.698654] ice 0000:05:00.0:        param (0,1)  0x00010001 0x00000BB=
8
> [  110.698657] ice 0000:05:00.0:        addr (h,l)   0x00000000 0x0000000=
0
> Based on the above, the driver requested a 0x0002BF20 timeout (180 000
> ms) but the FW returned only 0x00000BB8 (3s).
> I'm assuming this is expected behavior since the maximum timeout for
> NVM read should be 60,000 ms.
>
> If changing the timeout requested by the driver to 60s for read ops is
> handled correctly by the FW and the FW respects that lock, the retry
> patch submitted in this email thread might not be required at all.
> Let me quickly prepare a new patch and test it. I'll update this
> thread once I have a results.
>
> Regards,
> Robert
>
>
> On Thu, Jun 25, 2026 at 9:51=E2=80=AFAM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
> >
> > >> This is an AI-generated review of your patch. The human sending this
> >
> >
> > >> [Severity: Low]
> > >> Does this check allow an extra retry execution? Since retry_cnt star=
ts at 0,
> > >> using a strictly greater-than check allows the loop to retry 4 times
> > >> (5 total executions) instead of the 3 executions intended by
> > >> ICE_SQ_SEND_MAX_EXECUTE.
> > >>
> > >>> +                             break;
> > >>> +                     ice_debug(hw, ICE_DBG_NVM,
> > >>> +                               "NVM read EBUSY error, retry %d\n",
> > >>> +                               retry_cnt + 1);
> > >>> +                     last_cmd =3D false;
> > >>> +                     ice_release_nvm(hw);
> > >>> +                     msleep(ICE_SQ_SEND_DELAY_TIME_MS);
> > >>
> > > The review is correct that this allows one extra execution. However, =
I
> > > intentionally kept this verbatim from the OOT driver (1.15.4) to
> >
> > This OOT change was made entirely by Grzegorz, for E825C. Would be grea=
t
> > to acknowledge his authorship (+ SoB ofc, below).
> > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> >
> > What was the platform that you have encountered the bug on?
> >
> > > retain the significant test exposure it has there. The absolute worst
> > > case is one harmless extra retry before giving up. If you strongly
> > > prefer strict adherence to ICE_SQ_SEND_MAX_EXECUTE, I can update the
> > > condition in a v4.
> >
> > Please update (to have one attempt less).
> >
> > >
> > >> [Severity: High]
> > >> Does dropping the NVM lock here violate the caller's assumption of m=
utual
> > >> exclusion?
> > >>
> > >> Callers of ice_read_flat_nvm() typically acquire the NVM lock before=
hand to
> > >> ensure an atomic read of multiple sectors without interleaved writes=
. By
> > >> explicitly dropping the lock during the msleep() window, another thr=
ead, VF,
> > >> or PF could acquire the NVM lock and modify the NVM before the read =
resumes,
> > >> potentially resulting in reading torn or inconsistent NVM data.
> > >>
> > >>> +                     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > >>> +                     if (status)
> > >>> +                             break;
> > >>
> > >
> > > I don't think this is an issue. The NVM resource (req_res 0x0008) is
> > > an ownership lease, not a content snapshot. The FW grants it with a
> > > hold timeout (see the timeout field handling in ice_aq_req_res). It
> > > never guaranteed a point-in-time view of the flash.
> > > Very similar behavior already exists in ice_devlink_nvm_snapshot(),
> > > which reads the NVM in chunks via ice_read_flat_nvm() and deliberatel=
y
> > > acquires/releases the lock between chunks (with a comment explaining
> > > the FW reclaim).
> > > Additionally, the lock is only dropped on the failure path, where
> > > neither bytes_read nor offset have been advanced. The driver simply
> > > re-reads the failed chunk after re-acquiring. So no data that is
> > > returned to the caller is committed across the drop window.
> > > Overall the lock drop does not weaken any guarantee callers actually
> > > have. If we wanted to introduce a true snapshot guarantee, that would
> > > probably require different approach and separate patch.
> > >
> > >
> > >> [Severity: High]
> > >> Can this lead to an unbalanced NVM resource lock release and potenti=
al data
> > >> corruption?
> > >>
> > >> If ice_acquire_nvm() fails here, the loop breaks and returns an erro=
r with the
> > >> lock currently unheld. However, callers like ice_read_flash_module()=
 are
> > >> unaware of this internal lock state change and will unconditionally =
call
> > >> ice_release_nvm() upon failure:
> > >>
> > >> drivers/net/ethernet/intel/ice/ice_nvm.c:ice_read_flash_module() {
> > >>          status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > >>          if (status)
> > >>                  return status;
> > >>
> > >>          status =3D ice_read_flat_nvm(hw, start + offset, &length, d=
ata, false);
> > >>
> > >>          ice_release_nvm(hw);
> > >>      ...
> > >>
> > >> Because firmware tracks resource locks per-PF rather than per-OS-thr=
ead, this
> > >> errant second release could forcefully strip the lock from another t=
hread on
> > >> the same PF that successfully acquired it, exposing the NVM to concu=
rrent
> > >> modification.
> > >>
> > >
> > > Agreed, this might be a real bug, and the one of the three I think is
> > > worth investigating.
> > > If ice_acquire_nvm() fails after the drop, ice_read_flat_nvm() return=
s
> > > with the lock unheld while callers unconditionally call
> > > ice_release_nvm(), so a stray release is issued.
> > >
> > > On probability, though, the window is very small. Reaching it require=
s
> > > sustained EBUSY across the retry budget plus a failed re-acquire
> > > (which itself polls up to ICE_NVM_TIMEOUT), and concurrently another
> > > requester taking the lock. Most reads happen during init (ice_probe,
> > > and reset/rebuild via ice_init_nvm), and NVM writes only happen on an
> > > already initialized driver. The devlink/ethtool nvm_read paths are
> > > also exposed, but hitting this race would require precise timing
> > > against a concurrent NVM owner on the device.
> > >
> > > I'd prefer to keep the scope of this patch limited to the EBUSY retry
> > > path and not take on the unbalanced-release fix here. A proper fix
> > > should change the lock-ownership contract of ice_read_flat_nvm() (on
> > > error, the lock must be released by ice_read_flat_nvm(), callers
> > > release only on success) and update all callers. Code change sould be
> > > simple for all callers but ice_discover_flash_size(), it intentionall=
y
> > > holds one lease across a read loop and would need to re-acquire after
> > > each expected boundary failure.
> > >
> > > Given how small the original window is, I'd rather not trade tested
> > > OOT behavior for the risk of a complex unbalanced NVM lock fix. I
> > > actually have a patch mostly ready that fixes the lock-ownership
> > > contract, but I really don't like it. It changes the design of
> > > ice_read_flat_nvm(), making it less intuitive for callers. More
> > > importantly, I just don't have the resources or test coverage right
> > > now to properly verify such change.
> > >
> > > However, I can modify the failure path for ice_acquire_nvm inside
> > > ice_read_flat_nvm. Instead of bailing out immediately, we can just
> > > retry it within the existing retry budget. In this case, the
> > > probability of leaving ice_read_flat_nvm without holding the lock is
> > > reduced even further without needing a refactor.
> > >
> > > Please let me know what you think about my thought process on this.
> >
> > I think that both AI-reported issues against the lock are valid
> > concerns.
> >
> > I think that sleep was the actual fix, and re-locking were merely
> > a necessity due to their expiration (as you said).
> >
> > A proper fix would be to just increase lock-timeout to accommodate all
> > attempts (and still do the retries&sleep, but without unlocking).
> >
> >
> > >
> > >
> > >
> > >>> +                     retry_cnt++;
> > >>> +             } else {
> > >>> +                     bytes_read +=3D read_size;
> > >>> +                     offset +=3D read_size;
> > >>> +                     retry_cnt =3D 0;
> > >>> +             }
> > >>>        } while (!last_cmd);
> > >>>
> > >>>        *length =3D bytes_read;
> > >
> > > Thanks,
> > > Robert
> >

