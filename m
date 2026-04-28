Return-Path: <netdev+bounces-281701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIXJHNxn8GlyTAEAu9opvQ
	(envelope-from <netdev+bounces-281701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:55:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3B47F5D0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9B273013C6E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9EA2F12AF;
	Tue, 28 Apr 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pdAxTo9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730A2DD5E2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362833; cv=pass; b=a/qQOoB15+61Wm15NqLucogLMKoUTruzjO1fuAlbT+nOrigu/1ksD786XzsB9ygrFe7+nb86Sl77lU1vuVNJjyqsRfhq4ye5ivEhVlD4/jMtN103Z3l7eC/AV5hRdTluuETKePsNtZNG0nWbMU4FDxmBn9Za+aED1JHyTtTbqRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362833; c=relaxed/simple;
	bh=ebothyur4qrPKKM9P91h6dnfQnwwGUjd/9tHet0NmPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqtbgupyiyFoMjSaUFDIQQVoiV8hj1NVhA6erl5xpneYC6E9siG7qxVNKBlGh7++9gCcZMVmpSasUtnRlOjMoGxWqzEQMbbU1VpomI4uLYUvnLuj0krKSIRuGbGDv5gog2FJCNkLJ4pzusUZPHVe7LiirPB321upXuMFQTG0rvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pdAxTo9h; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 889063F29B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1777362829;
	bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pdAxTo9hr0YG/1FIug5ujtqEVIwBMWjqlT5zb3Rp5Z5tAG0hp/hU5lA06IguW3HgH
	 ee7DQoC+EQIW+oNRHrn2f09pf6oGWFN4tlVhbpZDYux/v4+JeKbsv5ijzkNYRgq5nq
	 TAw+F8Iy7BBxGxhaqBkZBIKVqbXN1fOw+1ivHMmmOIt5AgO16eJNTNKpMDtaUJLC/0
	 eRlNc2+1laVQQ3R1kW5DPvoCgDUao3cY0ao8OO/Z50NvVj9Zw2C8Kvcf/xTcxxJlUT
	 XkkHnFJcNmDEZTYKspeAcorexxk3RWML7VXPAyPA/p1uaWLk3GTVZ/VDjaiakbCv/Q
	 z3/ilAzgtfbeNA8dbAdlaaQt1UG/pEI9e092OI8l11ea7oD4tugQ/SXZybWyC+NTPY
	 jvbK9ouuFfQGU7h3WsmwhEctWVimxgRlbtSpOA2jMZEPfCOe4jfRXS6fww/FYDLD6f
	 2q0SLwbDiwD2yXH2WBm5MGswpXCIInwpDJvPSI8L1vzbcgOKxqxOOxjRATLtAGRz56
	 ADIWmK4JUI4pNG1d6exHcgWdVRMjv7X6utid6VAPhG2x8p1blQrO+HGm7AUSb6ohs2
	 FlASlR6zNZ+Ypkp/CepGbtbNA0zeCx2gowhUf0J+zMPCeRCEUTJBVW1m08qB8/1ylA
	 6s+5PJNkdE9eOjq8xuyAR3UU=
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c66fdd4aeso16673518c88.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777362828; cv=none;
        d=google.com; s=arc-20240605;
        b=lCNuUATMiUjG+inrCZpGjgd9NPN5gkuJOMl/bLarWimfvwtypLYdIN3iiBqpM9JXnw
         U82BktD3Ziu/iada/GOOAgZDnHqn1q8LhoxYJQA1HTQYrKzgd+Hx/C7ctgZ8tqPHOa//
         yOQKk1OrOuYYzlY82tjBL7h3g31Nx/wI1FhL95zznMk+e82aPxKIwEdrj1uQhNDR+IjX
         JIIt/C/BtRzLVYtYrPBTvh8/5YaHDUle3Xdgl/E9l5x6D6nb+04fJr9N07A5UZbFD+AT
         rP/WwIvphV1jHuZhYr9NddN0vab8W4nURNLqL7dpF5zKq+aThh9cckaPcztHxTSsNWqe
         uZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
        fh=L/U+B4ffpC7VK0va//1xjm0eN0OsLAKk8/12h9bHDPM=;
        b=LlWyokGQoH8p+QRbrrmFrAghkv9cRMxhV+YlU7OV/nSIg0GAk1k/gIdQszgZrIIBOG
         FvpMxdO/fgnAR8bJGgcTmHDLropSxrJFo+pcsMEYrqzkHojuvaCt2XxpTSaQ6GdDol6J
         AJSCoIUUXTv6B/kRA8HttnIwnTt75X4Fx3sEA9O8P9YTCMkSBhcI6KZuoKRWb8+I+pGA
         hMokmC0fJMsQZh7jJ+ie9F5Z0uWHv1Sbm5daQ8TpJ37EJAYfSsxx/HIszLGWQGimH6aO
         QtzJoU3F+MMcuQu13AMNxm4Dzf+KJQkOJq8jpCddwxQCucbTLsyWKnh6zrBTvze1nrRX
         Xm/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777362828; x=1777967628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G08MvlEyJpwyQ4ydkn2UD3MgLMhtby1OzIsIy0Akkk=;
        b=KtuwrYKD8bDZrv/q9wrfC7xqiKnQWtXBNiH5Q1SY68anRHaY3o+KP6tzWvrhoZghRf
         KWVFhnaWeRlwQfvXUgGe4mWO0tNveDiTFr9CM8kKu2lOft3lNJVYwr4bDE00dzsOtJ1I
         zPcfRd6I0A+XjjF+VofxVwccQea2BAKBlvSVCHLhi95w3TOItzuTw0HkMJCiYbVLpN2j
         6urib8IAXo10fgzjulhBD5E47eaYBQ1CxN9LWtVvDpm2Qs5E6/foxsQj0BRA2oJrt1/B
         C8MXSvD+/X6ni78LhKAiLmZe+kV4IHRY7kYwYbKwmLWS4kUJHc7q5zKi0KhBirDpjulk
         aCaw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZG/bIloejWxQXYGRegix6n/NwOODW6i6gqKhu+/Lfv3imqypGbmhvNcGm7rKHwmoLIERUwCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZY0pSWWVGOYK+bkHJeiicksldEbEMp3KxXx5gvwRAG+Ab0x2
	JU84Umn235ybzjYdlOpHkn+zV+tPyZTa5iT/DkbpoxdKiAlpWN1h2th4NPt4qkWBHHZYVZufEHL
	W4TKmwviQMQms/UbyG/aRzvXDIGDXwTwfEwd4a4VFuQy8GRPb2soPhNcH1pLCteYIz/oSf5gSGv
	XXBACtb2cTDtf/Mbr73hs8odPalCMBvNYl6KVFml2678Qqc/9a
X-Gm-Gg: AeBDievG82KO66pfTuLUOo8gjhUQHu8egvCmX8b08wh5EGuKFf01M6S5Bai735vc7f2
	RDO5Mr0OiiFuB0S1W+WoQjeNAwQOTy/UH50475axL7odC2YtqN3fAxpIEvkn0ZaXU2Z3DcezcQb
	d3ZhCX4ndPtq1ekrlkiULulg1WkVqy/v8PKmdWGr5K9lLsIu5Aolg+2tqaqbBBmAYZwMGvHxhVt
	KVgheNJ9phLvfLJ/eXg7TFhx/wqkUvUhzPOSzefm1lhXkaFPn1GRE9jdGrpL+IgfN2GTrWl4A==
X-Received: by 2002:a05:7022:526:b0:12c:66fd:6595 with SMTP id a92af1059eb24-12ddd9f3022mr878796c88.34.1777362827793;
        Tue, 28 Apr 2026 00:53:47 -0700 (PDT)
X-Received: by 2002:a05:7022:526:b0:12c:66fd:6595 with SMTP id
 a92af1059eb24-12ddd9f3022mr878784c88.34.1777362827376; Tue, 28 Apr 2026
 00:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424030345.1140665-1-aaron.ma@canonical.com> <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
In-Reply-To: <0d1ef57c-7ab6-4ed1-bc11-323aeeb12eac@molgen.mpg.de>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 28 Apr 2026 15:53:36 +0800
X-Gm-Features: AVHnY4J-wg3tR_hPisWtunBUI27BB6t7zZFvy3Lps3d64t--As3DVEcC_39U67M
Message-ID: <CAJ6xRxUEcbadApMg0i7ngcqYMUacrGNvCrUZ96sqkW22TsC7iA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in ice_resume()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Akeem G Abodunrin <akeem.g.abodunrin@intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Kohei Enju <kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94A3B47F5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mpg.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email]

On Mon, Apr 27, 2026 at 6:13=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Aaron,
>
>
> Thank you for your patch.
>
> Am 24.04.26 um 05:03 schrieb Aaron Ma via Intel-wired-lan:
> > ice_resume() schedules an asynchronous PF reset and returns
> > immediately. The reset runs later in ice_service_task(). If
> > userspace tries to bring up the net device before the reset
> > finishes, ice_open() fails with -EBUSY:
> >
> >    ice_resume()
> >      ice_schedule_reset()          # sets ICE_PFR_REQ, returns
> >    ...
> >    ice_open()
> >      ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
> >    ...
> >    ice_service_task()
> >      ice_do_reset()
> >        ice_rebuild()               # clears ICE_PFR_REQ, too late
> >
> > Reproduced on E800 series NICs during suspend/resume with irdma
> > enabled, where the aux device probe widens the race window.
>
> Please document, how you reproduced it, and also paste possible messages
> by Linux or NetworkManager, so that people can easily search for the comm=
it.
>

The error message is "can't open net device while reset is in progress"
I can add it in v3 if you like.

 > > Wait for the reset to complete before returning from ice_resume().
>
> Please mention the delay length in the commit message.

The timeout is 10 * HZ (10 seconds), matching the existing usage in
ice_devlink_info_get() for the same ice_wait_for_reset() call. In
practice the wait completes in ~300ms.

>
> > Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> > v2: reword comment to clarify best-effort semantics (Kohei Enju)
> >
> >   drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index 5f92377d4dfc2..a81eb21ea87c1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
> >       /* Restart the service task */
> >       mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_per=
iod));
> >
> > +     /* Best-effort wait for the scheduled reset to finish so that the
> > +      * device is operational before returning. Without this, userspac=
e
> > +      * (e.g. NetworkManager) may try to open the net device while the
> > +      * asynchronous reset is still in progress, hitting -EBUSY.
> > +      */
> > +     ret =3D ice_wait_for_reset(pf, 10 * HZ);
>
> Why not pass a delay in micro/milliseconds?

ice_wait_for_reset() takes jiffies =E2=80=94 that's the existing API.

>
> > +     if (ret)
> > +             dev_err(dev, "Wait for reset failed during resume: %d\n",=
 ret);
>
> Mention the delay?

Good point. I'll include the timeout in the error message in v3.

Thanks,
Aaron


>
> > +
> >       return 0;
> >   }
> >
>
>
> Kind regards,
>
> Paul

