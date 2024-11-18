Return-Path: <netdev+bounces-145907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA79D14C0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723A61F20F66
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2750013D251;
	Mon, 18 Nov 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtwcKtdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082B1DFFB
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945163; cv=none; b=m6bReXaHdC7Y/y9UmAP0U7oJfi1wmFSY25D++HlbDlJ08Gyaqpx0BY5dyvBhgdYDqjocIB4viJh8KhdaLl9Wd6WCMhb9QXCuCbyqTlBwfC17BwIlkIjlam7DXK2sEaZK2Peoxe+zhzPY5oqDpSx7Bq9g7fe6jGSwHN3JnfNjN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945163; c=relaxed/simple;
	bh=Nw7Bl0jnWy2S102aAL2f/ceR00j9KAKmRDhwu5ImL6k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ok93saTBk/0FVI7nlmmR21GoQiy91MyMEE0wFXPmGo5vEii7TSGHGBgJB/hG9QSLD8yRXrBtLDKXdWu0VDGUszMm2a+MtSXXimPvvuz0K0sOaeKBc271yjZEeMqnZxQhFWd5jpkjJkdA+p7O2OdO82xFHTZYAIrm1m4fCfJKfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtwcKtdL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d40d77aa97so19742846d6.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945159; x=1732549959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm+C0p0+NEx6sZBd6t21wk9DRNbJRRNTd+mxaToGBlE=;
        b=TtwcKtdLYxl3OutjTGSOo4LRXNC7WPoHnNbzdd2b9AtcnQeMJvHBQBGG2PT5aj7EVr
         IL2fBbF4f4r6U0dIx+euEM7jJmT2CUR6GFEqtH/DPO56Wjokt1rCUrDzCdr6u8l35nsk
         KzLd0NeFMpzIa/TdYUA+MGVkRvhVSTjIm3lxgWmgqhz8r8eEHE1sKDSKXxSMN3M5AuQF
         bkmjvvbWdNN9iiya6jluHNO612aOlpGLHvt9PNcP0AQQFezquQKZ5XFALiPessXsySat
         hcvnmTWT/f2IdfUnm/jCzQm124y+zDCUmHhvTi+TOc8PdtGbhtrfSXwBIWiIGphbXtE3
         7o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945159; x=1732549959;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hm+C0p0+NEx6sZBd6t21wk9DRNbJRRNTd+mxaToGBlE=;
        b=UPH47jm5sOtfenrVmCyzw3tgw+xiCucXtcRr6cmRI8PNmawNI9pebmag/nSmZ1LDK1
         tKUojN0qy9W+X/phRjXbDf1pqDXhGC7VLN+L8/u9CJQolpV6M7nq1blugm9bZw927+XW
         ckVcidlEcqamGnSPHvgWpb8p+IeDgeoXW179qiwRFVGpPrHjO7prH+AH+MgE61R7wh04
         96vWy8NPWpp1Fd2IJpFhXqDiR1QuI+nZXJhVqmiKAmBs0HTZVQm/ubDA+BGCaCxT+0w/
         QZvwWeZ9tudFZULFEpshwBJ4PHpdDrwFRokbmk3g3A04cnfnEOt/CUXLsHD06nPA812b
         XS2g==
X-Gm-Message-State: AOJu0YwGOzNBQObd/tzn+y8KeM+Lo8FZiaKs3YA4o0seLI7scLQw02aR
	agvpeizl1g+nal+GT1nuM4AjmoGEt/2vyUxIw3pmKEy49vcpSs4g
X-Google-Smtp-Source: AGHT+IHeF2LPc6QXijq8hu8wlxZK+87iT9rDyAwuWAj0WFayc3Rgpm0ItYBXtPr5rm3wxbykP8q31A==
X-Received: by 2002:a05:6214:3389:b0:6d3:f39a:9135 with SMTP id 6a1803df08f44-6d3fb86e2e1mr180375656d6.38.1731945159470;
        Mon, 18 Nov 2024 07:52:39 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd1f6desm37145786d6.92.2024.11.18.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:52:39 -0800 (PST)
Date: Mon, 18 Nov 2024 10:52:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Olech, Milena" <milena.olech@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Hay, Joshua A" <joshua.a.hay@intel.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Message-ID: <673b62c6ab8a2_1d6524294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <PH7PR11MB5885EB42ABAE3CA8023CFC038E272@PH7PR11MB5885.namprd11.prod.outlook.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-9-milena.olech@intel.com>
 <673685bc9ef98_3379ce2948@willemb.c.googlers.com.notmuch>
 <PH7PR11MB5885EB42ABAE3CA8023CFC038E272@PH7PR11MB5885.namprd11.prod.outlook.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 08/10] idpf: add Tx timestamp
 flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Olech, Milena wrote:
> On 11/15/2024 12:20 AM, Willem de Bruijn wrote:
> 
> > Milena Olech wrote:
> > > Add functions to request Tx timestamp for the PTP packets, read the Tx
> > > timestamp when the completion tag for that packet is being received,
> > > extend the Tx timestamp value and set the supported timestamping modes.
> > > 
> > > Tx timestamp is requested for the PTP packets by setting a TSYN bit and
> > > index value in the Tx context descriptor. The driver assumption is that
> > > the Tx timestamp value is ready to be read when the completion tag is
> > > received. Then the driver schedules delayed work and the Tx timestamp
> > > value read is requested through virtchnl message. At the end, the Tx
> > > timestamp value is extended to 64-bit and provided back to the skb.
> > > 
> > > Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> > > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Signed-off-by: Milena Olech <milena.olech@intel.com>

> > > +/**
> > > + * idpf_ptp_tstamp_extend_32b_to_64b - Convert a 32b nanoseconds Tx timestamp
> > > + *				       to 64b.
> > > + * @cached_phc_time: recently cached copy of PHC time
> > > + * @in_timestamp: Ingress/egress 32b nanoseconds timestamp value
> > > + *
> > > + * Hardware captures timestamps which contain only 32 bits of nominal
> > > + * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> > > + *
> > > + * Return: Tx timestamp value extended to 64 bits based on cached PHC time.
> > > + */
> > > +u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp)
> > > +{
> > > +	u32 delta, phc_lo;
> > > +	u64 ns;
> > > +
> > > +	phc_lo = lower_32_bits(cached_phc_time);
> > > +	delta = in_timestamp - phc_lo;
> > > +
> > > +	if (delta > S32_MAX) {
> > > +		delta = phc_lo - in_timestamp;
> > > +		ns = cached_phc_time - delta;
> > > +	} else {
> > > +		ns = cached_phc_time + delta;
> > > +	}
> > > +
> > > +	return ns;
> > > +}
> > 
> > Consider a standard timecounter to estimate a device clock.
> 
> You mean to rely on standard timecounter instead of cached PHC time?
> Can you please clarify?

Yes. To clarify: this is a suggestion to consider. Feel free to skip.

A timecounter/cyclecounter maintains an estimate on a clock. That
is more precise than just using the last cached value, and preferable
over open coding such an estimation algorithm.

Other drivers already use such a struct, I assume to estimate their
PTP device clock.

