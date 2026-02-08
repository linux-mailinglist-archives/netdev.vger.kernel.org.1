Return-Path: <netdev+bounces-257850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gdkiFgu5iGnLvAQAu9opvQ
	(envelope-from <netdev+bounces-257850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:25:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F08E1096CE
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4774300A8DB
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5EC34D4EC;
	Sun,  8 Feb 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMtnOTma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0E346ADE
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567942; cv=none; b=QiqeaRxxsFogKFiry5cPeNOWrYmjc5xcL/TftawqSuUnXS6vVUHGzDM7pXk3rWqI5eKmLpEelksDjuZO8BKSBo8i2EbLGJlkfm5+qjTnAklIU7618JsmzWiBZr9DCqdqNzTxSR0cznBX7/Agc2T2e6d7gyh41Sg2wuPIzUw0LJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567942; c=relaxed/simple;
	bh=gYJHp2AKkiikWxkde6LvTz6NpVp4MFyOmDirl7s3n+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WNapmRe3GxbjsKS6SQEUcwj7LMUp+92ZmGmCanavKDes5nNdGhj4bKZxZ7y4jISJGK0ESQLtgtzmylumjPUh+hgB3cXOsvMqx8sCouSQ5bvIE74ZFVX0NzHthHHfBcO69fZn3Z24Fz1uW4vt712p4nlsQXhcZ7YWOY6MySdT+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMtnOTma; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7963af509f0so5665487b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770567941; x=1771172741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYJHp2AKkiikWxkde6LvTz6NpVp4MFyOmDirl7s3n+I=;
        b=kMtnOTmagNPQFtefArqo9Uza67sVnK8sV0QMUb89MxcAVPZU1YKAFhfYvjbbQQDQN6
         U1waXhLU+d2UKcob9qpjI8Nq6AUBh/ygMJ1OsGsMsyDxhcQUg0aE2juAHCugT+of1swH
         vJkOccHIucKZCBuNlTlD8zNLrRpcbaMTGngDmfWyUJGll0mXaTUNFZaMfCNZHNLV6kh6
         EegvBhoPPxX5WGjLPv9vVfVi0vFkYmNjqioNaWKffIUy1JXDYCmTOfppU2E+xM2WWEep
         zlTuiK70h9csMp8r7RIjYl7wKPKYD6Tn2SbVDKglSahICsuRQQsQ6F08S73tp8Qavd4r
         5jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770567941; x=1771172741;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYJHp2AKkiikWxkde6LvTz6NpVp4MFyOmDirl7s3n+I=;
        b=ju5yhhgf2khwjiL0N34V43EjKF2JUZs2Refata3l/ThoFHySUEDAkKNzZoYPqp5B06
         V967yhkXxUBZFHPEPYDACwZ2MvWW9zs5JR7HX8A3UXnI0eHJ/sDFQHVrUV+Svjv6jKGC
         xdR1lhIK7hJNj0mbiHCMvOMWi/aoXLIbO0P++ZOwU2fYEYRXfFTHlVuBd9MEsvGfHjKV
         z2mj3Nh4d73buIQOvWqkfmoqHmg4LGHyTFYvN8sgVmu5+nUErGdAmhQU97o11oO012E3
         6DU3XRbZ7YQiBoJEqx82CLd3CcQkwIsC4A9/bd+juSW7Bb06ySs6/Wfp3YhO2klUJ5L0
         IM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXwAY1PnBCm+FCdr5FTO4p39Or3e0URV1qkDpllZ5E5k54ZfEly9a7fECHWCtq0AeUijnRab88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7jmCDUep1wF6UCpMAfiOuh2qtNbc9x7ZNJ/t0L2JfoKDetyu
	+/4j/GcZOojPxpgLiwWdK+N96xjoC6gh5eLA5ODc10SKuqcPuM0c1b5+
X-Gm-Gg: AZuq6aJuPOGZGYq3WO0YNgBDNKdMTjePVJIRp7DZ1C6OKsaFv7zmiIKT9/P66lCCWL3
	comkWoxW+HTqCwv5+0OW4h/iTKQFgPWUQkBOEBBLsYPezfZAwWxmDOLTEZk6sxeaMT/4jX9MxU+
	Oc2Lj/94nvhevoNTt2Ux2/k2EWCSdIDXxduDAVc0mAMYTJ+egQHUS207S+gQCfL4jp9vbulAQnA
	W1BV0aZ4nG8LkJGfuDFxVJvhI9W7V/3KKE8oggFxUJ2Tw4QpZ0voQpZk7hqKkEvdI/KkEWa4wk4
	BxB4hNb9/fkezZMvAwAmdJ4e4QWzxSjZufrofdgjTLs9/G0nRW+gpmWlWym24AV0wxIKPKY4u25
	q3HPR45stRnCjJzWSnLFSmilG7priCW4j48jlUNgCoLm8LYI3gtHIRFt91WVwanguX514auWyWn
	fo8OsjsoNkJEZlPLTJRxwElXkritPbAlhXMCgJ42htJNLu0Zf9nSzgHKBvUjc=
X-Received: by 2002:a05:690c:3584:b0:795:19c9:4389 with SMTP id 00721157ae682-7952aa72ddfmr83159157b3.25.1770567941578;
        Sun, 08 Feb 2026 08:25:41 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7952a085999sm70633397b3.25.2026.02.08.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 08:25:40 -0800 (PST)
Date: Sun, 08 Feb 2026 11:25:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
In-Reply-To: <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-257850-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,linutronix.de,google.com,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9F08E1096CE
X-Rspamd-Action: no action

Vadim Fedorenko wrote:
> On 05.02.2026 21:41, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
> >>> On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
> >>>>> So the only thing that bothers me is the read_lock_bh() in
> >>>>> skb_may_tx_timestamp() which deadlocks if the socket is write-loc=
ked on
> >>>>> the same CPU.
> >>>>
> >>>> Alright. Now you make me think whether we should enforce OPT_TSONL=
Y
> >>>> option on socket which doesn't have CAP_NET_RAW? Then we can get r=
id of this
> >>>> check, and in case sysctl was flipped off - drop TX timestamps as
> >>>> it's done now?
> >>>
> >>> This would "fix" this problem for all users which do deliver the
> >>> timestamp from their IRQ handler instead of napi. There are a few o=
f
> >>> those=E2=80=A6
> >>> This would be considered stable material, right? (despite the fact =
that
> >>> we have it for quite some time and nobody complained so far).
> >>
> >> cc: Willem as he is the author of the check introduced back in 2015.=

> >>
> >> But it's more like a question to maintainers whether it is acceptabl=
e
> >> way of "fixing" drivers or it's no-go solution
> > =

> > Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
> =

> Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW=
 all TX
> timestamps are silently dropped.

Are you referring to sysctl_tstamp_allow_data?

That is enabled by default.

> To receive these timestamps users have to get
> CAP_NET_RAW permission, and it will work with the updated logic as well=
...

