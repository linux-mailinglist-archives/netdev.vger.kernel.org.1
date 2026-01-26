Return-Path: <netdev+bounces-253371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJlwLTwmd2kUcwEAu9opvQ
	(envelope-from <netdev+bounces-253371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC785787
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64F5A3001388
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC831329E;
	Mon, 26 Jan 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKSwuiiE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qidedAvf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD022538F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416246; cv=pass; b=fHJv5gtoVJTkH8MEF2sng3vDQx6S6Uf+7VNT68UV7HlMu82/X8tf9+5/+6f1qMNj+QZny69kbK4dF4dNIrxneduA9NKWFG4BrgI9lOBI4Gpr+VSWloqz9/y5qRAXCcRaxEYmtNrWmyQBvUSDApRVsTRlNO5p4wIDsy8nhTKrw2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416246; c=relaxed/simple;
	bh=7+83Z+2bc2jz0Pb66Ds3SItCIpsDY6fJKr/iojPxr8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcxHI8/t8zGoJyM7RhpwYnnrAVls3hZe0cE7oKiJ3V58OYjxLovIU2Uw6jgVb1ENS9SgWPcrnur5cpUWavLzWaxHA/KAvQSKfc4Zt1AFT1ido7aVuetBQja5+G1oMtL9S0shIX1GEISAz2P1WaRGHIKwjsrrSIHSo53jD6d6kpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKSwuiiE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qidedAvf; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769416243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoXcx9RJW2MGk9gdqPpQfFLPfh4v79V4Bss6akGxX8U=;
	b=gKSwuiiE7yfYdZJGRxy+deuNbDN89ocLIN8c8WrdahJegS7Xa/C3nuNWS0GSniYEz2Fa92
	7FfDOIKDx6THr+Qv1ZOaGzQb0ycNHb89dnmEP0K90j/zI1omKvKtXuwuCh7+qJ4P4JBV+R
	1tUXCUwyy7ei/qoosa6zgn63I+kXnvY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-lfE89yF2Mp-SjogfoEtHFQ-1; Mon, 26 Jan 2026 03:30:42 -0500
X-MC-Unique: lfE89yF2Mp-SjogfoEtHFQ-1
X-Mimecast-MFC-AGG-ID: lfE89yF2Mp-SjogfoEtHFQ_1769416241
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd4b12d78so1938971a34.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 00:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769416241; cv=none;
        d=google.com; s=arc-20240605;
        b=OBXMVlJQe6Je7Bg9+p8udK0v28kDxX2hgo5D9Yz7Oiwy6HxLGVH077FJ70uP4ASnt7
         i7f2E4AAy1nptU1cEehslVDctgKT4xockwV/mrk3KXSm0Ah2MRJYzxREZAO2nwpg9Pj9
         oYWBc7gPQe7Rk98ihIj/qO+mmzOomZqk5oErqeWdvXUidMx/RVlAFcN3Jc2BTiaRWVlH
         ww0SeA968JfHUsW0sbeMg0ovBzCpAnXqbZ90gs4NT5z4HqSZQZRtXBnIB9fbUqIpv9/z
         CK+YTuLllqVxSAEh6BzF+znq9RaJa0iMaawl0olK5GnaeyCKANdyVnP2PIvyQqQvXnKk
         lh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QoXcx9RJW2MGk9gdqPpQfFLPfh4v79V4Bss6akGxX8U=;
        fh=lDUB37XQ9CbdH5QcIjhuPs/SCd+kYl+5hucBytQ3cPY=;
        b=GXhkiFeh+QCg2Buwn+iHOdXdWcPgdeMUFz8tu3DA27z79028OZRltnO7iFc/JXXBgY
         41ZDaxzaKKLErBibG7Tf7l6vIC7oG3yWw3lb4wUdEWEnuw6rN1bm7kjggg/YmI4oxfG/
         N5chcDILtZ69Tv7rvVQ/1xPnhqvciX0m21mN/yfdSiSXWNmqplkj25r9wqz9V9wFOgzw
         NLAk2tp04z2KRpMdrs4Gmud2zjxq3SPJBRY+B8KKbHn7BaXc867o9KZfbFR+7efkpso7
         bV3nUsPZBtE887vpxkhHOLUEkL2HVQd8HBA/+xg1BnCUYuSdHEm5QI5vWcBS2zUUcPbw
         OVSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769416241; x=1770021041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoXcx9RJW2MGk9gdqPpQfFLPfh4v79V4Bss6akGxX8U=;
        b=qidedAvf5sirG1mGQATw+CmWA0zgIBcQsEBnq2TG+2KTBnkS+dD7ataPZVgXpv3UKx
         2mDgobQmfT6rncQjFioiEawJND1txZd4xazgJXkL+foYQACF4NWsPQDcWAIokr2IM15R
         82VTE/VyuR9z+u5sKHaX8vMIhmJ7V1qgS/oSbG1AqG+fSFTQtVclDHUXaXyK8fsuxVF3
         oC2G3EsveYkD0szJQP29PB6yeKrAFk9gtLnPqG0LF7ZdhDM2QCRU7pLNgW2b1W3/frfi
         P0/m0IwuWsN9jagJeuo77yQqg2p7tpqDkCCdNR75sTUG8CBfcSzpmC/0DoHonpm7kak+
         TOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769416241; x=1770021041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoXcx9RJW2MGk9gdqPpQfFLPfh4v79V4Bss6akGxX8U=;
        b=a1UGesIZ4uHoCftQVih/6jX5HNZZQWj4JS+9TtddqdKzCijiN1eg773y8k6ApZ9+Gk
         whXVDfvZ+bs+Mq+9pAhW8rPk4Q+SIo1yX9LwsXvBo416OfOopkklwcfeW5R30EixoGux
         sA6iQLqFNw4TFaUEJCcIBTQapYOnhTnSW2d74fm4euH31QCvNShkkYe7F+0whfLcH1/h
         EQgO352fbBX+9g1tFvIeOqWC4Z2BSeNwNzktLPV+cYDyFuxQ0zZ/HhEh7LwED0Tnwins
         qg04/O79rqhexH6cz3kLvtRDDt1enHvrzNZTPG57+5kDejGuSpqMfDP8oHk019jeLYX4
         37dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsPA8dV82zr/axkve0gA5QVjkjbeCvdQKSzLY3A4i4mQwFX03Bfp6hqQ/+wSDiz+bYe1Q6IU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJr3/2aszC/VCUzUvrT22uhMz2cf3Bm0UTG0lJdwa6IaZ7NPPK
	7ItNA6sMTFx1ey8t/GfNFLHo7HoL483qZIDW2YfDYrsqfZQP5HycLhTtwKEPQU1iaqH4gxHpiJp
	LDLktflCweCamxllvxlpwODzO5FvrWBSbQE7+C1kw7daixL/DnsX6T+f7PR5eozsUbP2twr+bMB
	vHyiaFUEiP3wXm3ACbgr8jkqt0ZsQaQulg
X-Gm-Gg: AZuq6aKyTpIOWqW2O5YVfWFX/+ia2ZazcarDiXDjhg10QpTsLW3S03q/dG1TQi2c3wZ
	/hcfqT3zkkhaRHjW69VVIa9KdyY5AimcB+jR6xsWwZpV/cBLfUmODBBe0CRdZmkOf5odtEO0HFe
	Qsmu/XHVmv0NaAC6717RCZRrFSB5PJTHBFKV4f3rmWOg2nuHf6vDmrTBf1Al3xivO8wQ==
X-Received: by 2002:a05:6830:4124:b0:7d1:4980:252a with SMTP id 46e09a7af769-7d17025a852mr1636283a34.3.1769416241349;
        Mon, 26 Jan 2026 00:30:41 -0800 (PST)
X-Received: by 2002:a05:6830:4124:b0:7d1:4980:252a with SMTP id
 46e09a7af769-7d17025a852mr1636278a34.3.1769416240934; Mon, 26 Jan 2026
 00:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-jk-e825c-fix-missing-timetamps-v1-1-f090eabfc823@intel.com>
In-Reply-To: <20260121-jk-e825c-fix-missing-timetamps-v1-1-f090eabfc823@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 26 Jan 2026 09:30:29 +0100
X-Gm-Features: AZwV_QjPh_HuYHfu57c4WL9426spChrLIXNrv5MUk5FZfKy-L9r3KFgo-dRant4
Message-ID: <CADEbmW0roa=NKwB2kE7DJ0n_W5=Rqk1LJu3kri4u1Rkc8h-KvA@mail.gmail.com>
Subject: Re: [PATCH iwl-net] ice: PTP: fix missing timestamps on E825 hardware
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
	Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253371-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CABC785787
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 8:01=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> The E825 hardware currently has each PF handle the PFINT_TSYN_TX cause of
> the miscellaneous OICR interrupt vector. The actual interrupt cause
> underlying this is shared by all ports on the same quad:
>
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
>   =E2=94=82                                 =E2=94=82
>   =E2=94=82   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=8C=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90   =E2=94=82
>   =E2=94=82   =E2=94=82PF 0=E2=94=82 =E2=94=82PF 1=E2=94=82 =E2=94=82PF 2=
=E2=94=82 =E2=94=82PF 3=E2=94=82   =E2=94=82
>   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98   =E2=94=82
>   =E2=94=82                                 =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
>                    =E2=94=82
>                    =E2=94=82
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
>   =E2=94=82             PHY QUAD            =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=
=80=E2=94=80=E2=94=98
>       =E2=94=82        =E2=94=82        =E2=94=82        =E2=94=82
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=90
>   =E2=94=82Port 0=E2=94=82 =E2=94=82Port 1=E2=94=82 =E2=94=82Port 2=E2=94=
=82 =E2=94=82Port 3=E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98
>
> If multiple PFs issue Tx timestamp requests near simultaneously, it is
> possible that the correct PF will not be interrupted and will miss its
> timestamp. Understanding why is somewhat complex.
>
> Consider the following sequence of events:
>
>   CPU 0:
>   Send Tx packet on PF 0
>   ...
>   PF 0 enqueues packet with Tx request          CPU 1, PF1:
>   ...                                           Send Tx packet on PF1
>   ...                                           PF 1 enqueues packet with=
 Tx request
>
>   HW:
>   PHY Port 0 sends packet
>   PHY raises Tx timestamp event interrupt
>   MAC raises each PF interrupt
>
>   CPU 0, PF0:                                   CPU 1, PF1:
>   ice_misc_intr() checks for Tx timestamps      ice_misc_intr() checks fo=
r Tx timestamp
>   Sees packet ready bit set                     Sees nothing available
>   ...                                           Exits
>   ...
>   ...
>   HW:
>   PHY port 1 sends packet
>   PHY interrupt ignored because not all packet timestamps read yet.
>   ...
>   Read timestamp, report to stack
>
> Because the interrupt event is shared for all ports on the same quad, the
> PHY will not raise a new interrupt for any PF until all timestamps are
> read.
>
> In the example above, the second timestamp comes in for port 1 before the
> timestamp from port 0 is read. At this point, there is no longer an
> interrupt thread running that will read the timestamps, because each PF h=
as
> checked and found that there was no work to do. Applications such as ptp4=
l
> will timeout after waiting a few milliseconds. Eventually, the watchdog
> service task will re-check for all quads and notice that there are
> outstanding timestamps, and issue a software interrupt to recover. Howeve=
r,
> by this point it is far too late, and applications have already failed.
>
> All of this occurs because of the underlying hardware behavior. The PHY
> cannot raise a new interrupt signal until all outstanding timestamps have
> been read.
>
> As a first step to fix this, switch the E825C hardware to the
> ICE_PTP_TX_INTERRUPT_ALL mode. In this mode, only the clock owner PF will
> respond to the PFINT_TSYN_TX cause. Other PFs disable this cause and will
> not wake. In this mode, the clock owner will iterate over all ports and
> handle timestamps for each connected port.
>
> This matches the E822 behavior, and is a necessary but insufficient step =
to
> resolve the missing timestamps.
>
> Even with use of the ICE_PTP_TX_INTERRUPT_ALL mode, we still sometimes mi=
ss
> a timestamp event. The ice_ptp_tx_tstamp_owner() does re-check the ready
> bitmap, but does so before re-enabling the OICR interrupt vector. It also
> only checks the ready bitmap, but not the software Tx timestamp tracker.
>
> To avoid risk of losing a timestamp, refactor the logic to check both the
> software Tx timestamp tracker bitmap *and* the hardware ready bitmap.
> Additionally, do this outside of ice_ptp_process_ts() after we have alrea=
dy
> re-enabled the OICR interrupt.
>
> Remove the checks from the ice_ptp_tx_tstamp(), ice_ptp_tx_tstamp_owner()=
,
> and the ice_ptp_process_ts() functions. This results in ice_ptp_tx_tstamp=
()
> being nothing more than a wrapper around ice_ptp_process_tx_tstamp() so w=
e
> can remove it.
>
> Add the ice_ptp_tx_tstamps_pending() function which returns a boolean
> indicating if there are any pending Tx timestamps. First, check the
> software timestamp tracker bitmap. In ICE_PTP_TX_INTERRUPT_ALL mode, chec=
k
> *all* ports software trackers. If a tracker has outstanding timestamp
> requests, return true. Additionally, check the PHY ready bitmap to confir=
m
> if the PHY indicates any outstanding timestamps.
>
> In the ice_misc_thread_fn(), call ice_ptp_tx_tstamps_pending() just befor=
e
> returning from the IRQ thread handler. If it returns true, write to
> PFINT_OICR to trigger a PFINT_OICR_TSYN_TX_M software interrupt. This wil=
l
> force the handler to interrupt again and complete the work even if the PH=
Y
> hardware did not interrupt for any reason.
>
> This results in the following new flow for handling Tx timestamps:
>
> 1) send Tx packet
> 2) PHY captures timestamp
> 3) PHY triggers MAC interrupt
> 4) clock owner executes ice_misc_intr() with PFINT_OICR_TSYN_TX flag set
> 5) ice_ptp_ts_irq() returns IRQ_WAKE_THREAD
> 7) The interrupt thread wakes up and kernel calls ice_misc_intr_thread_fn=
()
> 8) ice_ptp_process_ts() is called to handle any outstanding timestamps
> 9) ice_irq_dynamic_ena() is called to re-enable the OICR hardware interru=
pt
>    cause
> 10) ice_ptp_tx_tstamps_pending() is called to check if we missed any more
>     outstanding timestamps, checking both software and hardware indicator=
s.
>
> With this change, it should no longer be possible for new timestamps to
> come in such a way that we lose an interrupt. If a timestamp comes in
> before the ice_ptp_tx_tstamps_pending() call, it will be noticed by at
> least one of the software bitmap check or the hardware bitmap check. If t=
he
> timestamp comes in *after* this check, it should cause a timestamp
> interrupt as we have already read all timestamps from the PHY and the OIC=
R
> vector has been re-enabled.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products"=
)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

I applied this patch to a RHEL 9.6 kernel and my colleague has tested it.
He wrote:
> Tested the build: kernel-5.14.0-570.81.1.iceptpstamps.el9 by running
> G8273.2 noise generation test (7.1) for more than 4 hours -  have not
> observed any issues. Packet rates normal and inter-message intervals
> are regular. No delays, timeouts, failures.

You can add:

Tested-by: Vitaly Grinberg <vgrinber@redhat.com>


