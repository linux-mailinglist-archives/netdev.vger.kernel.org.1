Return-Path: <netdev+bounces-307727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VjehAaVfV2qSKgEAu9opvQ
	(envelope-from <netdev+bounces-307727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0475CF0F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:23:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=CZxq1ET2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ABF73011A62
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C343F8C7;
	Wed, 15 Jul 2026 10:22:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26943F8AB
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 10:22:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110979; cv=pass; b=ZuHSFRn0q/TVxJw7HfeBE1FfAOWZtVV0SbvrIgluDV0WvIM5r3cOqoc4SECqKrQukiLGkiAxMCwGq5Aw7cU8i1zyOrroOCR49zbJy9K+pz3L6eWkbpBlMvJ/KVBLkDFnvAovIsvx6yUubzvsayaJ7nhZCP5gPl+CkhedxqRwYy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110979; c=relaxed/simple;
	bh=2Bc8wdh2fo7HegHxnOQ5YULYEYQtyN8WVrxPFLUtBbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnS4R25RCz+dqiYdHkRNHyxDyNdLyAZbmMpNbBHvxUeMCzRG9ytyuQ3/NODDPBALA1W9SZuPvAHnQFOI0Wr9sMb2nCZ7ary0pBFWN0/8X59Mtq+cAtLdXI3fV5pSkz/wxaLK79eV7HNnn9baU9RAIaoalM/xSN6RXz0ykKh+YD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CZxq1ET2; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7660A3F60A
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784110974;
	bh=fZC27ShXa7hl4qW+78jwKRMiG2RSdKURS3G8/4lCd3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CZxq1ET2dVhqq/XR1QaV/aivsbZrJ2rGEVNzhH0BJg5KQ64ZJUMvKedw7xOkQtKaq
	 /k4XyOaG2wwSbBfx0NrqGhsKy7HurviDDzFbPNhpHEO1HgIZ5vWOsr+V+m8IzWqoCp
	 3aVKmTKkLkGmH0qbBvCPxbkmlS3Hg4mdYTNymgiudb8/6CncLLk5Lmk1nquJ9x2JiH
	 XxI521rJM2MVzprGrJR+0dWzIZnKTKNTD+3UGHSUe2zmyPv2cxqQBqXZV4IH34bocv
	 fOAlIOoDKrlwwDMdWsV69sf1TAM4uXrccshg4B/r27OzGnfcc6M6AKs7kID5A+kmlm
	 BSL/RbwM7UdP9iyWgYIOCWXkgh9b+3WmkxF2amNadmyIGwRRUayEDa6RkBr7AJgrns
	 gtYmXtpUhpUSlPxMOO2BKZ9P/UIw7DtcY+e8f/XvYG8S2S2B/X+EIAXxhQuyTJSSid
	 SlTJmlR82b/tt+bEnnAxu9tDV7rJVyILodhKfBlH364rffj52fRfhsl/RnZn6w2wNn
	 ZzcR3iVh1MpILtcOJLX1qP0oVT+f/5yj5hSP6EWmefEJ/G3bPMYlWGRXxt1QzTthax
	 F6qVvQrCeyBQrlYjzRLC74cZKEvQSzqwDdNEoSsK3OXxvuMtBGouR7W9SqLhtG6p4C
	 RlSSikZlxAiKC2se/vuqlH18=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ddb61f13so579075066b.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 03:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110974; cv=none;
        d=google.com; s=arc-20260327;
        b=ltGVfK4wpYM7xOCepPBVGFtMrvtNyl7LNJkNhUXjko+vQzsBsjpn3UyVGJDal9hMg7
         xj9DIePPmjGuTDS5E1Ll+2zFR7Vnry2ACC6K0UBxHMQuFuEplf9gCKxQ3KSh63AQoA9S
         HPO7FXCgtCzRsOQL2Hib9rJNGE+LVLqo2cPlrNW/VCIFSkRLGtLH1oKVc03uuiITtX0g
         HWWlg7iYgiVozMG4bm+HOdWb+H2RbFNsHj+6VnJova9FXNK6DwZbfVIHrVUel2U34uEA
         q4lVL7l5yZpkGl7lkOwadeAyqxXkAnCo3OGGho9+d4HniaN/PixrmMf77ndkiAngwvUa
         9J6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fZC27ShXa7hl4qW+78jwKRMiG2RSdKURS3G8/4lCd3w=;
        fh=F8Tn5PTIshcOtL+5JUsHjH0LI4ihkX4ZpC8zEnfXwXg=;
        b=gItFym4mvciI4R+rCp3e+EZApJOk9c9cdkFX7GdcJbFvuZ0yD/LnE57ppw9x/EUmmf
         8gcJTf7tv3jb+YtaKm1F3ZoS+G5zv9USi7Bq0NSf+NIMi89q0AecMkvTJAvmQfV6dJSf
         ziyb0mUdmb5Z4Q+8RIZTqisANH488qELiG90iBGL0m/fcOmsPZzcQti5UpM6CI8W1BJe
         lJ0HRKxaSa2VZsDU5KU7VKmUPimGgMKL+AUjxTiHKvJcphqBi0lhiVu0Gptli0dYWNg1
         qsxxf7INkVw13vDDEFrjwQ/AUcNYOhqNw/6z26piBtO0CR+a8b/IkxToxuJCGgWJWXiq
         MKsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110974; x=1784715774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZC27ShXa7hl4qW+78jwKRMiG2RSdKURS3G8/4lCd3w=;
        b=CP4EqjTfBX85lPvvJV5a+PZCVQVeAbw2f3CuWsv0Af4XBRKU28XH/nXG89hdR0a19J
         El7lj+NZPFVN55jLseZHvthf+CMA0UdeeEzp8C1l4DO4afXT4HHhFBTu/hgHVhZ2hIAS
         IJxu4dlTsMDyv3HUmcfyqm8qwBB/s/DFi9/lqxtqG3D7mbUmhGxbb5lQ1/P0goSHd9Cm
         SFKYi6oMhrv/DIUMX3fGeUe81DCeXKWQVXpxl87bJ56MGzJwtVeOpory71hRFdT4oJ9e
         9FKqnvXZ9naPEtBreNECwJFurIG7CB1hSeaji7TOvrO52rH+o/x9mYVCqN4yazpkowsu
         QNRA==
X-Forwarded-Encrypted: i=1; AHgh+RoA+4a32cDBFb5dpANv6l8wlUMVbs08xvhbtKxYfSmRNt9SB8yiran53vsSuOpaj8BgR8GccJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+kuuxch68l5rQBPt5yteNMGCeU2YyqjlDB90/TSV46l/a9bT
	2HriMUS4Ltw9Zi59EY/6ANhq3qfRKEByyA11w4Pw9NZHDKphrNZKe9MJTf/QyAG6QterQH8/sBb
	cC1OSxPMuK1fZMJ7FvDqc7RoS8l4j3apnCSDknC3EYJFW9qizb6D1pE4xjEeerqBE9kD9ZFGPC4
	3HxowcD9XjAkaW2kVz57zGyM5e0kxLkMtmiSXhevSTOvFiDLKb
X-Gm-Gg: AfdE7cmzEGcTicB7F7eeVODxu1ZQLAUiiAbxIrlTP7TgzsN5rpkhKFWQ0AqKF4MlCf4
	JeWiYgHY9cLBabWPPFUWESW0xp1QVIKBptD+EcY3hoo7jnX2Hfe4kCbXge1wJSFQL6xgR7hdv/i
	wyH6NieI4twBnkmvqOV+vGQH3PffhYZbZzduuvTaMqOHckyZKBpUBKSRBOFdwT1txBAYef
X-Received: by 2002:a17:907:6d26:b0:c12:713b:e199 with SMTP id a640c23a62f3a-c16616a3b18mr421708366b.25.1784110974065;
        Wed, 15 Jul 2026 03:22:54 -0700 (PDT)
X-Received: by 2002:a17:907:6d26:b0:c12:713b:e199 with SMTP id
 a640c23a62f3a-c16616a3b18mr421705666b.25.1784110973609; Wed, 15 Jul 2026
 03:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703103245.374800-1-robert.malz@canonical.com> <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
In-Reply-To: <bc89cccb-3f22-42c9-9f96-382586d12fcf@intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Wed, 15 Jul 2026 12:22:42 +0200
X-Gm-Features: AUfX_myIE6AiN9iz-hnLIP40Cqa9z96HpTUcSSSXEmslFfKlKzSUSBFpuMLkV9w
Message-ID: <CADcc-bxLMg1NujF+jE2rOXGc38quv_XqZfv5K+yGQFfhc03avA@mail.gmail.com>
Subject: Re: [PATCH iwl] ice: acquire NVM lock around each flash read
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jesse Brandeburg <jbrandeb@kernel.org>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-307727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:jacob.e.keller@intel.com,m:jbrandeb@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:from_mime,canonical.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67C0475CF0F

Hey Tony,
Thanks for the review.

On Wed, Jul 15, 2026 at 1:47=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
>
>
> On 7/3/2026 3:32 AM, Robert Malz wrote:
>
> ...
>
> > @@ -92,12 +98,28 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u3=
2 *length, u8 *data,
> >
> >               last_cmd =3D !(bytes_read + read_size < inlen);
> >
> > +             status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +             if (status)
> > +                     break;
> > +
> >               status =3D ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
> >                                        offset, read_size,
> >                                        data + bytes_read, last_cmd,
> >                                        read_shadow_ram, NULL);
>
> Sashiko says:
>
> If this chunk has last_cmd =3D false, doesn't releasing the NVM lock
> immediately
> after ice_aq_read_nvm() allow other entities to acquire the lock and issu=
e
> their own NVM commands in the middle of our open read sequence?

[RM] I do think that is intended behavior. Reads should not be
stateful and there is no open read sequence to interrupt.
Each ice_aq_read_nvm call takes an absolute offset from the starting point.

> Also, if ice_acquire_nvm() fails on the next loop iteration, the loop bre=
aks
> and we never send a command with last_cmd =3D true. Will this permanently=
 leak
> the sequence state in the firmware?

[RM] I don't think there is a leak as there is no FW read sequence
state. As far as I know, lack of last_cmd does not leave anything
dangling in the FW.

>
> [TN] I'm seeing conflicting documentation on whether this bit matters
> for the read command. I'm working on getting clarification. If it does
> matter, we'll likely need to adjust this.

[RM] I'm happy to adjust the patch once you have more details on it.

>
> > -             if (status)
> > +             if (status) {
> > +                     /* ice_release_nvm() issues an AQ command that wo=
uld
> > +                      * overwrite sq_last_status, which some callers
> > +                      * inspect after a failed read. Preserve the read=
's
> > +                      * AQ error across the release.
> > +                      */
> > +                     aq_err =3D hw->adminq.sq_last_status;
> > +
> > +                     ice_release_nvm(hw);
> > +                     hw->adminq.sq_last_status =3D aq_err;
>
> Does restoring hw->adminq.sq_last_status here without holding the Admin
> Queue
> lock risk overwriting the status of a concurrent AdminQ command?
> If another thread acquires the lock and sends a command immediately after
> ice_release_nvm(hw), this lockless write could corrupt its error status.
>
> [TN] I don't believe the AQ lock will work as desired we can't guarantee
> that we will have the lock directly following the release in order to
> restore the AQ error. Similar to the NVM lock issue, I think this is a
> small window but wanted to bring this here in case others had
> thoughts/comments on this.

[RM] Agree, this can cause issues. We can't drop sq_last_status as
ice_discover_flash_size depends on it.
Proposed fix: drop the save/restore sq_last_status and propagate the
read AQ error through a real return path instead of the shared global.
I could add optional enum libie_aq_err *read_aq_err out param to
ice_read_flat_nvm(), capture sq_last_status before the
ice_release_nvm, and have ice_discover_flash_size() test that instead.
The log-only callers (devlink/ethtool) don't care about it.
Let me know what you think about it.

>
> Thanks,
> Tony
>
> >                       break;
> > +             }
> > +
> > +             ice_release_nvm(hw);
> >
> >               bytes_read +=3D read_size;
> >               offset +=3D read_size;
>
>

Regards,
Robert

