Return-Path: <netdev+bounces-223679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98885B5A068
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B701B2605D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13B275B0F;
	Tue, 16 Sep 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg/Uxajr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BA1397
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046624; cv=none; b=G0E97Wfd8T/omX3QwdSmH5/QyhnSqM1Ti9iCxfTMWS0MwwdCvk4jMi9D796wkS+kIbTdsZbOf0wg2imLYqUiH4idVYd9eA4rs52e1PvsM24zk2Je4Bbc8C6wPlEFe5N0dF8iS1hnENJti+ywaz9q38rUQxBAc6sGLLPydmH/Yls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046624; c=relaxed/simple;
	bh=MVPzMTONaBJT5N+hHaYmRy0C3P3AER6E6H5SQzBvo3E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eVqORomHTXqt9JYk0nanRDulJXt7htMdAOXSm/Izo6IxBplbf6EZczBht4kyt4PDpsP0lrMoNwiG4GQ7pUS0BjjxOpX/HhgzO51eW8sNebqci5W+HgKiQQJROblS+kX8/GJ5e7WVSl0GnQ+I65gYUmRwRO5DF5lxNRTY54YbqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg/Uxajr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758046621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiJbWUk9iK3Va6WQUOfyxO/yZVMoTNTnNrKsRMOKeVQ=;
	b=Xg/Uxajr1qxpvGnuuvzQIKkjiWSoEZZOB4ZeDyCirRDVqCXJDvmRzb77tasO67RJjH8Hs1
	/ohX/CAAQMDuxhBnCBXNoZUFzw+QbwOo76inys5E6TcSRoNYDCJoDt6YnGJx2ryEGNigj6
	KHDfMTxCKlLwgcdEBUe5f2DFUzfwqDE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-n1vFqW46N8KXgQZKhe-bng-1; Tue, 16 Sep 2025 14:17:00 -0400
X-MC-Unique: n1vFqW46N8KXgQZKhe-bng-1
X-Mimecast-MFC-AGG-ID: n1vFqW46N8KXgQZKhe-bng_1758046619
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b046bb6caa0so137887066b.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046619; x=1758651419;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiJbWUk9iK3Va6WQUOfyxO/yZVMoTNTnNrKsRMOKeVQ=;
        b=LvfFMiNb4kLRm27NaW+DL6KWjYLka1gzu4qviDvcfnwax0hYHrPBMwwlGMSlxKrxuq
         1miJmjHmjty4xF34a4bp7VbHVx56rkJNn+wohRDSLrATUy8KU2Dpox1/4LG+CW1/NS32
         bbW21s0M6pGNqlWmtPluhjYImQ6cB36nJRPCe3pZv4FHsY6chjkElhye7uZiHKS23gIQ
         reWuXueIHiIUtUi0Sq7IF0ZMc/rp3QbwrPjJXBUQ0m/1ZrA8GUDtWLjOXKNDfHIRZiD2
         K8iU3NcyI/qxiPIDBHiagTDAX/HN7rNfcdvUwSKIGYI1T/S89DBmbqVsPmhMWnBd8AKL
         4A4w==
X-Gm-Message-State: AOJu0YxS9V3FNXZIX+rSiDAX22oiMEhjGavHJq1VmeRzwpTXrDH4espO
	TjNTmMo/lCqnSNl2cHsdFoBZNjh7bvJrBFJnmUFoAxySteavjApKgLB5BUGyPpUKLjNt8UzvYwp
	ATUUY93QFSAy1QsMlF7UnLbPF3DeGL0a1FB//6VqPTT5n/KtxCHwwqScE8g==
X-Gm-Gg: ASbGnctzRSM7da+mfFjCLjvIoL0jHByviqhB1mgon6+b0EoA3sqk1FDwF9pExE3YW8i
	JHM1pP1Klsm5AGvOW4CWX0jsB0Ei6gzbXNU902ZZ7cMheF+yDMU/WwSQYJ1Xcb7fh8vwmpMy2NP
	78KbmpGQC6gkFlyg8DGhPyVZO9S56SJD8IkbkCxC0btvfJEuLcVOKyi981tqseGotJGDyLQRNnV
	Bcb8LEvjl77f4FlBJm4ocdlPPENkH0dRHdBB49T228vP68+Lf3e1wi8N7GB5e1hAosQVwKBNTSo
	RtCz0Pl2jjy36ge12kS1KWhz3V7RuX16Qa+EzByRYfNPs+a7
X-Received: by 2002:a17:906:dc91:b0:b04:37ca:77e7 with SMTP id a640c23a62f3a-b07c365da98mr1673683466b.44.1758046618696;
        Tue, 16 Sep 2025 11:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIt2e9AJy51nO/jH/HTJfy0/9Ihn7bnnuR/FCs8J9Z85sjlp5JxyE81WyYIgw5qXRrUm+sBA==
X-Received: by 2002:a17:906:dc91:b0:b04:37ca:77e7 with SMTP id a640c23a62f3a-b07c365da98mr1673681666b.44.1758046618304;
        Tue, 16 Sep 2025 11:16:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:ad04:3f07:f046:aa35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b6fsm1217873466b.111.2025.09.16.11.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 11:16:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 20:16:57 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2=5D_dpll=3A_zl3073x=3A_Allow?=
 =?US-ASCII?Q?_to_use_custom_phase_measure_averaging_factor?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250915164641.0131f7ed@kernel.org>
References: <20250911072302.527024-1-ivecera@redhat.com> <20250915164641.0131f7ed@kernel.org>
Message-ID: <FA93EFB9-954B-421E-97B2-AE9E0A0A4216@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 16, 2025 1:46:41 AM GMT+02:00, Jakub Kicinski <kuba@kernel=2E=
org> wrote:
>cc: Arkadiusz
>
>On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>=20
>>                        2^N - 1                1
>> curr_avg =3D prev_avg * --------- + new_val * -----
>>                          2^N                 2^N
>>=20
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference=2E
>>=20
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower)=2E
>>=20
>> The driver currently uses the averaging factor N=3D2 which prioritizes
>> a fast response time to track dynamic changes in the phase=2E But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate=2E
>>=20
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface=2E
>
>Is averaging phase offset normal for DPLL devices?

I don't know=2E=2E=2E I expect that DPLL chips support phase offset
measurement but probably implementation specific=2E

>If it is we should probably add this to the official API=2E

The problem in case of this Microchip DPLL devices is that this
parameter is per ASIC=2E It is common for all DPLL channels
(devices) inside the chip=2E That's why I chose devlink=2E

>If it isn't we should probably default to smallest possible history?

Do you mean the default value?

Ivan 


