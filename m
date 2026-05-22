Return-Path: <netdev+bounces-290865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KxIIZFuEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:56:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83015B68E3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 440DA3010273
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369230674A;
	Fri, 22 May 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXcQ3UgL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2YAfEPG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D830B514
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461404; cv=none; b=Y4eMfQ7NZhxoPruSTMevrSXSoZit6rzCMAuOyCg2vlKjkzRcLs7f4NXspBJXG8ntUbFTk89fPJs8heMvLO8yXfSmDcJLGStVs+slDzT/rHxjiEq5s3gSoGYOcblurG2M3UMdA4JAuhbl7LeoZDeystiJxKvcqrU8mdE/KznH0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461404; c=relaxed/simple;
	bh=osSVGvniZC08T0HTRZ8sCJTU1WglJJErT0RUqQO0xQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcEHKA9eve3sEIaY0PDKvz1ROtkXNHNQovJ71HKWSpkafbanC5pj3oavszUzJnUWMooW7pZM/boi6CQQQP3UJSkxz6lx/0wa4eOx9/y57rocaiAmqfU+p/YQMXxLm5cVRSfKJ74rA5W1lQm4wl/yHhKNOzq40J2gf3l4TrNHICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXcQ3UgL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2YAfEPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779461402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vwXhqcxDo5K0DmQf7mm7Hg+BCrkjN2mVwJwGTFbfho=;
	b=IXcQ3UgL0ptCqX+BRbBho3Uceq3lg+UonrqOZo4zZM/ZribcdkSu3dkO2inUqDoBLl3qWa
	53CM8yEnam/fMA8lie8UXRcrkKP3zUCRk/VIP2eBMAG8DQ3+vmy+hKSDqcgq7Fq/TTkSCt
	r7hOgl4PAnevNQtbQJehrV7B58x+Tf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-8QX9PQ9fPCy6RAOUjmCBoA-1; Fri, 22 May 2026 10:50:00 -0400
X-MC-Unique: 8QX9PQ9fPCy6RAOUjmCBoA-1
X-Mimecast-MFC-AGG-ID: 8QX9PQ9fPCy6RAOUjmCBoA_1779461399
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd3dbd16aso59620845e9.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779461399; x=1780066199; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1vwXhqcxDo5K0DmQf7mm7Hg+BCrkjN2mVwJwGTFbfho=;
        b=C2YAfEPG3Y6UTTUbniWZeovA3Kd33WQq2zZdQR+rQb5OCQs7tt6XB0QVwSH4dO8oPT
         kQHt9cbZrq5CFiqFyLMjML2FBQyosgUEpQXAoy96pva9WkicchPVjedrw02S8aeU58qf
         XNLulPB80Hko+APHQXz+JEZw/BBCLxo3yZPrStKYMpnlPtFbT1TkEg/rE3iIRV/s3Hih
         klDeoy/eURH4cSy0kscyitXyDjFGf+q+xrMz1dBNBEK0g8vSZgiLbs9Opdz2DieFSwiY
         Dqu8WoSXgfBqhcmTVcpuF5oKv0BZIelmoX6bXYMYx+ptzbeLWT3pydMpDTnavwWqKY3e
         tnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779461399; x=1780066199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vwXhqcxDo5K0DmQf7mm7Hg+BCrkjN2mVwJwGTFbfho=;
        b=cH1QQZvo6auv0TI+4zO2MeFDkJl5ORF+QelM2L407SGT3Gz657CNmESOPqBI+XpNXS
         aTfMuaH96mB8VBESryB4MnVwgQ0yr+ClXAGOlCBYHo/yYjbgmI9wEBm4mnBIhZVce+u0
         sgW2nJSt5HZIX8oI6F+7rUTXJROJrHpCnH4Tw06UtO+h44WXuESw/tQPl8ygKcJveSW8
         SNUdzRk0Te9Xcj73BnPfZki/aYX8NWVElZkIMlvJHee0IqxefKMg0fqEtxJQTR+t2XNf
         etALeL331jmUPDnNLiygg8tA6KtO0XnkS4wGT+AvCWPdVz3TM5+etjYFLhY8/1IPgWTx
         DU/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OrMhmRzhiyVac+kHCY9Rcx/RBUfB3/dfRs11ZWvmu3SaXzvv69co7sN7bWSop7+vjmMl2qHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik9gF3IrAug0W0MXG4dd+VGnr75BXG4/EgeYo93kaI+MEJEo6
	jLCz+UQ8STypv8fLgIks82W21z6leNzIghmM6G5UmZ7tGRskAwPZ8btxt8hb5axJ93wZOtxz+5l
	22aBy/WKTd2IzhsO7ZaP53kAJV/2wEb34Ksc2U6kgL3oPWA9nzvXgUD/PhA==
X-Gm-Gg: Acq92OHfhPbbE98EUQN9DVLXN1+SM0uiYiGBd80n4k6r0QE/V9i+BAbeIR62HLGdFN9
	yar9UOkJdvTI7M/G1x0mxuZXfiFqmR4oqop97xCs1OzFXiXYxULnV0DH0OJegxVDs6S8vPRV85+
	IjCn4V7Dr1HAJ8L9Fv0qZ6DruNOnV50K/1bM99WyReK/s0Uh1E8fXPCWrSdbF5uDI5U7D6a6IWf
	QgVkp56VxGz9E8oq8B+XLLTfdiGUKtWCEyj886w0FlB5cEyXDW8vB9hNu9bUEZPjMbKdbA7KSL4
	VRQhHNaiZ5V+kC5CBdTQQp6uNQ+5/bxGU5OkyH6Trelg3VGGabhUhPDVl9GrdBPoQqCjHLxXDdv
	m0PH6tmfpjC0aQzm1JTWQF2ITE9sfifA=
X-Received: by 2002:a05:600c:c4a3:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-490426ceed2mr56211945e9.21.1779461399171;
        Fri, 22 May 2026 07:49:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a3:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-490426ceed2mr56211075e9.21.1779461398519;
        Fri, 22 May 2026 07:49:58 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490426d9b36sm25398355e9.6.2026.05.22.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:49:57 -0700 (PDT)
Date: Fri, 22 May 2026 16:49:56 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <ahBtFPOwSfVAQ-vi@dcaratti.users.ipa.redhat.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
 <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org>
 <CAKa-r6soz=iMBiYG0Grhhc12yhdw9vMNV+XjjEPCmtgKK6+rhA@mail.gmail.com>
 <CAM0EoMkANSFw7AxAX3opcnJhzd_qchosW8nFVfWV8wEkdL9R9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkANSFw7AxAX3opcnJhzd_qchosW8nFVfWV8wEkdL9R9Q@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com,toke.dk];
	TAGGED_FROM(0.00)[bounces-290865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E83015B68E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 07:49:59AM -0400, Jamal Hadi Salim wrote:
> On Thu, May 21, 2026 at 11:51 AM Davide Caratti <dcaratti@redhat.com> wrote:
> >
> > On Thu, May 21, 2026 at 4:59 PM Jakub Kicinski <kuba@kernel.org> wrote:

[...]

> > > > To be precise, something like attached (untested, uncompiled)
> >
> > hi Jamal,
> >
> > I tested Rajat's patch with your latest addition; it compiles and passes with the same subset of tests ran earlier by Toke.
> > Agree some follow-ups can be done (e.g. removing the hint, and maybe another smaller thing not yet detected by Sashiko) but AFAICT you can add my Reviewed-by: when sending v2.
> >
> 
> Thanks Davide. And a Tested-by as well? I guess the same goes for Toke.

yes,

Tssted-by: Davide Caratti <dcaratti@redhat.com>

(for the patch with Jamal's addition for negative offsets)

thanks a lot !!!
-- 
davide 


