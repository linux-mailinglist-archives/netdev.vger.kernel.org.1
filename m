Return-Path: <netdev+bounces-301616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kuH7HG+8O2r8bwgAu9opvQ
	(envelope-from <netdev+bounces-301616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF196BD931
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:15:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=HggYnSNb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ACA130091E8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BB367F31;
	Wed, 24 Jun 2026 11:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44B3451CE
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:15:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299752; cv=pass; b=g7IXsUr5vogb5md4wM7o1SRgOoKZKQQtBvIaWvfdpVJjkNOnmWtjFpjP1eYbCdybwN2Qq9EQ52GMwHKJTFf6e6Pb3vNBBcXwe4hUduXLhbeZzKlL5pM1VB/5gckE/A/QohD8GbpbNkulqbAcrp2fXQxvszacw11c8m6oy92/Rkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299752; c=relaxed/simple;
	bh=4VvRrbYJxxa+7L4BEoASqDuezCmo9F7uIYc4FfIvTvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMu7zMgSxAtOrG5kN5LNGLBbFzICpNsX7VZ34GMTb4aFCSvjnapWyCpnbis6EvGozwwc734DyDqsqPSUnutiZJvE7A4+3gpiQ0d6Bhh+WG7Q644XQ16ZHN6zsDDYUDFikS/ZiGau+zXzCo/SOYsCY5w85gptymk9LI4A9G8iaiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=HggYnSNb; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 550C33F620
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782299746;
	bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HggYnSNbyT/ALIR/DbxiXgDnYCSgMg7ASSu+fAg8VjDQInSne4HTwyVqHQMx4hEe5
	 XeejBQdM5bgVR/4IXC0h4FXG9o9I5T5C15yU8fwjCTzZjtrdWbKDKamguCydd10fn4
	 +20D7sK6KC/g91XhUgjrm10aNH88iS/Ac3hBXdF63SiZXHSC2N2C6WNrL5ji5ZI0ut
	 /W/xyRdfFldeMQpaGC5Hh0Qojs5VnsKx8f1LKJmo7abnQcTgyGnAlVWhg2TBCKbYuo
	 M7j3VhbkuLfKXR8f0L0XKn2ePihDVRv9Tb6eYjStLBlsRhnugsSVZ5Vq+49tEfEP40
	 H9tXE9D0C6NlwMpUp0oJH0H0p+AtACeZYnkplxGInDOcxtnM0O9Bd1CtAJlJ84icM5
	 8cM36KSX8SvVDKHcDav7aQAfEz11smOuX8nOggMKAwRQyvL+K+pPa1sudgVZMV9ZSk
	 1dlbQq0aNp3aDOEdf53z9v4r31ArjwNcuohejM1Asog7EphN65Me8jFpw1OBw7QKBs
	 gruunSwunzcKdQ8qsbedaqo7qE2Ot1jyXobsbR8BbvTWEhCx0NXdt46Efsgi4vXUEz
	 jMrmdv2tuGYa1uF84kb0dTrP+o3HuFFqQtrOWu3KCmvCE3a1WFIOcK3cvkNnGNTGZZ
	 TOitr83zDTChKb5kASx8tcIU=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bf481a6e4e6so72267066b.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 04:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782299746; cv=none;
        d=google.com; s=arc-20240605;
        b=R6ziq9ljyHkBU9n7EEraXL6Whk7eUndblKLk301TwW6KxyTtdkTDinL6vxVTTrP82p
         GEFRHlzKkGqd2ReDoxBQ5RVbm5nHSdVnOlVqu3c32nCOg+HKPKuunFtdo9OTYPI0XKtL
         /iJIpXlHdNDA+pDxDaOcUoz3pDLDHesPgjTDvp7jcQBg4DOkGV5dbkjIXiqjP7rNCf0J
         DW9WkrwDScfFrozD/yioncklR/JY+4z4tY2HpfPrV/byiWCA3+ETLjYmUTLnbdAcTYnw
         5csmBSeh+CQ2a5SmmHB5WFh98cWXcPSfYtJGwuQbM0NbNEJcEwHpQlijR7ylvsdLbTkM
         rhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
        fh=nrmN68eLBDnygL6opINiWk0wcN1SlZ4xRW2vIa+mt5w=;
        b=DsVR8VpgZPz5k/K7IgFLke5oV/CHjbvGcHKQH/UAwOqnFGpNwrc02y+WI5+pbWomJv
         r4n8kvLxN0UZX6HM7Ifckia/IofaLNGN21U+p+DTKdTFeCMg2lcveX6Ysil9Bbu9f3i3
         CsZplo1ZMq9I0FtzcTwqh9/9zhXtj780q95GXSj0ZEM4Va9iGAVgqVbi7zwWdZbqKkzQ
         FKusOdgWQkgtRQ5qgcM8r0RazaTAl5fFZwCQyZivNYMe5i5kYhjpPQcAxMfWsEjT7kpL
         aMKOLQOlowO+lDg/QTypnOLgN4L5o03F3Fq1YG20+CZeEcGo7zWEfM3tAfEWNec+ML8q
         LX5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782299746; x=1782904546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2wRzTtwTw8E7bv4kplv+lYY13gFv6IXu2a/9u/VPY8=;
        b=guJ5EimGTkvTGvwNmrbUBKgzZg6EoePXHihXYqAp2dUnmoVQrit41KMWNdIQuEbimX
         p3qdpshgbQqeXsh5rtnQ+Q83EqFARsrFV741yy/Pq9HcvyBMj0E+WNN+9fXyVQ1JiBS/
         K0b6c8x9vXhXi4dbFBPuPE0x7Dz5RgfQUwu76oj/fV7CF0R48DvE0dPsSqbOyFGHAW4o
         NlV3uL88wm4OlJG+gepBhZJFbC8ELVhUIE4j33/IgeldvfyGmufT2oYQh3kT1Gr2teQM
         1t2H6tRSVwTMGpGj7QFgWoM4ziHKU9u3SpzNuf6ZIAGBgxpNxHYvsIzjVB1GJ7qBWP/F
         Tr4A==
X-Forwarded-Encrypted: i=1; AFNElJ8KW748P+YW5xDSjopSFV55D6wdX6MdPbiN1d+MeCLjL8Q1GCnF7Yyut1j764OtxzF3mjSux2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUoWtacb+WUpQtSxiQmjTLo9WAlasZ9HK8TiwtTqrTl7fYnjh
	y+/0a5ViUmeMLLi97Tbfj0PLsmo18mvDIzB9QvvuRWSC3GkV27sY/gfwUESK7WYbYgy3iFwwqnB
	tx7jPyipFu6rfu/jmcQgRH9QYY87xrxBuScNCsYCmOM3ENn1I+nFixjZf5MuWeQguoUkNPeB2gb
	Z0bTZZ2/eGIpaM/G0ozin6HxTKcdSyIhgFj3fKNOt5oSLj67GumEc2ZLuRqYo=
X-Gm-Gg: AfdE7ckqn7xHCq0uUeNYoQKZ/44AGM8OF88QIuzMfAoBlVzoC/M63U2XnhtPhrJ+RJY
	dp25I/ZobEpwbE8xEwh3i6hgXU8nOuib6ydOBkm8S6UfpxLrFODGPYVof3Vw3r7Ugd0WiR8X54K
	AC2hDuGDY+lF1O/UJTjQCQwyowEeCnLAEeNZhPDRnBjG56jmEckAz9Y7AySq6A6xr8Kg==
X-Received: by 2002:a17:907:a2c8:b0:c06:58a5:c003 with SMTP id a640c23a62f3a-c119dd59ec0mr148197566b.17.1782299745731;
        Wed, 24 Jun 2026 04:15:45 -0700 (PDT)
X-Received: by 2002:a17:907:a2c8:b0:c06:58a5:c003 with SMTP id
 a640c23a62f3a-c119dd59ec0mr148193866b.17.1782299745248; Wed, 24 Jun 2026
 04:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617120753.1785565-1-robert.malz@canonical.com> <20260618152003.909400-1-horms@kernel.org>
In-Reply-To: <20260618152003.909400-1-horms@kernel.org>
From: Robert Malz <robert.malz@canonical.com>
Date: Wed, 24 Jun 2026 13:15:33 +0200
X-Gm-Features: AVVi8Ceodfn4RQrfhCjGJl6E_BGItBwT_10N9QBv-jSfXtjZY1nLtVQxYDxjOXw
Message-ID: <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
Subject: Re: [PATCH iwl v3] ice: retry reading NVM if admin queue returns EBUSY
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-301616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,canonical.com:dkim,canonical.com:from_mime,vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FF196BD931

Hey Simon,
Thanks for the review. I'll try to address these comments one by one.

On Thu, Jun 18, 2026 at 5:20=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> ice: retry reading NVM if admin queue returns EBUSY
>
> When the admin queue command to read NVM returns EBUSY, the driver
> currently treats it as a fatal error and aborts the entire read operation=
.
> This patch adds retry logic to handle this condition.
>
> > diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/eth=
ernet/intel/ice/ice_nvm.c
> > --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
>
> [ ... ]
>
> > @@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u3=
2 *length, u8 *data,
> >                                        offset, read_size,
> >                                        data + bytes_read, last_cmd,
> >                                        read_shadow_ram, NULL);
> > -             if (status)
> > -                     break;
> > -
> > -             bytes_read +=3D read_size;
> > -             offset +=3D read_size;
> > +             if (status) {
> > +                     if (hw->adminq.sq_last_status !=3D LIBIE_AQ_RC_EB=
USY ||
> > +                         retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
>
> [Severity: Low]
> Does this check allow an extra retry execution? Since retry_cnt starts at=
 0,
> using a strictly greater-than check allows the loop to retry 4 times
> (5 total executions) instead of the 3 executions intended by
> ICE_SQ_SEND_MAX_EXECUTE.
>
> > +                             break;
> > +                     ice_debug(hw, ICE_DBG_NVM,
> > +                               "NVM read EBUSY error, retry %d\n",
> > +                               retry_cnt + 1);
> > +                     last_cmd =3D false;
> > +                     ice_release_nvm(hw);
> > +                     msleep(ICE_SQ_SEND_DELAY_TIME_MS);
>
The review is correct that this allows one extra execution. However, I
intentionally kept this verbatim from the OOT driver (1.15.4) to
retain the significant test exposure it has there. The absolute worst
case is one harmless extra retry before giving up. If you strongly
prefer strict adherence to ICE_SQ_SEND_MAX_EXECUTE, I can update the
condition in a v4.

> [Severity: High]
> Does dropping the NVM lock here violate the caller's assumption of mutual
> exclusion?
>
> Callers of ice_read_flat_nvm() typically acquire the NVM lock beforehand =
to
> ensure an atomic read of multiple sectors without interleaved writes. By
> explicitly dropping the lock during the msleep() window, another thread, =
VF,
> or PF could acquire the NVM lock and modify the NVM before the read resum=
es,
> potentially resulting in reading torn or inconsistent NVM data.
>
> > +                     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +                     if (status)
> > +                             break;
>

I don't think this is an issue. The NVM resource (req_res 0x0008) is
an ownership lease, not a content snapshot. The FW grants it with a
hold timeout (see the timeout field handling in ice_aq_req_res). It
never guaranteed a point-in-time view of the flash.
Very similar behavior already exists in ice_devlink_nvm_snapshot(),
which reads the NVM in chunks via ice_read_flat_nvm() and deliberately
acquires/releases the lock between chunks (with a comment explaining
the FW reclaim).
Additionally, the lock is only dropped on the failure path, where
neither bytes_read nor offset have been advanced. The driver simply
re-reads the failed chunk after re-acquiring. So no data that is
returned to the caller is committed across the drop window.
Overall the lock drop does not weaken any guarantee callers actually
have. If we wanted to introduce a true snapshot guarantee, that would
probably require different approach and separate patch.


> [Severity: High]
> Can this lead to an unbalanced NVM resource lock release and potential da=
ta
> corruption?
>
> If ice_acquire_nvm() fails here, the loop breaks and returns an error wit=
h the
> lock currently unheld. However, callers like ice_read_flash_module() are
> unaware of this internal lock state change and will unconditionally call
> ice_release_nvm() upon failure:
>
> drivers/net/ethernet/intel/ice/ice_nvm.c:ice_read_flash_module() {
>         status =3D ice_acquire_nvm(hw, ICE_RES_READ);
>         if (status)
>                 return status;
>
>         status =3D ice_read_flat_nvm(hw, start + offset, &length, data, f=
alse);
>
>         ice_release_nvm(hw);
>     ...
>
> Because firmware tracks resource locks per-PF rather than per-OS-thread, =
this
> errant second release could forcefully strip the lock from another thread=
 on
> the same PF that successfully acquired it, exposing the NVM to concurrent
> modification.
>

Agreed, this might be a real bug, and the one of the three I think is
worth investigating.
If ice_acquire_nvm() fails after the drop, ice_read_flat_nvm() returns
with the lock unheld while callers unconditionally call
ice_release_nvm(), so a stray release is issued.

On probability, though, the window is very small. Reaching it requires
sustained EBUSY across the retry budget plus a failed re-acquire
(which itself polls up to ICE_NVM_TIMEOUT), and concurrently another
requester taking the lock. Most reads happen during init (ice_probe,
and reset/rebuild via ice_init_nvm), and NVM writes only happen on an
already initialized driver. The devlink/ethtool nvm_read paths are
also exposed, but hitting this race would require precise timing
against a concurrent NVM owner on the device.

I'd prefer to keep the scope of this patch limited to the EBUSY retry
path and not take on the unbalanced-release fix here. A proper fix
should change the lock-ownership contract of ice_read_flat_nvm() (on
error, the lock must be released by ice_read_flat_nvm(), callers
release only on success) and update all callers. Code change sould be
simple for all callers but ice_discover_flash_size(), it intentionally
holds one lease across a read loop and would need to re-acquire after
each expected boundary failure.

Given how small the original window is, I'd rather not trade tested
OOT behavior for the risk of a complex unbalanced NVM lock fix. I
actually have a patch mostly ready that fixes the lock-ownership
contract, but I really don't like it. It changes the design of
ice_read_flat_nvm(), making it less intuitive for callers. More
importantly, I just don't have the resources or test coverage right
now to properly verify such change.

However, I can modify the failure path for ice_acquire_nvm inside
ice_read_flat_nvm. Instead of bailing out immediately, we can just
retry it within the existing retry budget. In this case, the
probability of leaving ice_read_flat_nvm without holding the lock is
reduced even further without needing a refactor.

Please let me know what you think about my thought process on this.



> > +                     retry_cnt++;
> > +             } else {
> > +                     bytes_read +=3D read_size;
> > +                     offset +=3D read_size;
> > +                     retry_cnt =3D 0;
> > +             }
> >       } while (!last_cmd);
> >
> >       *length =3D bytes_read;

Thanks,
Robert

