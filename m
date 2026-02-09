Return-Path: <netdev+bounces-257939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HQrDoXXiWlUCQAAu9opvQ
	(envelope-from <netdev+bounces-257939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:48:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4810EFA6
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9FF301AB96
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE16220F2D;
	Mon,  9 Feb 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctvlRnJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACA205E02
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641165; cv=none; b=Sb7skGBThxLdIZTYgAmLX+VAJlW7xFZyoklOOACUtUgHpygaFsn1199AX/PCFnc00TYehRwoNROnj3aCkl+owKJQ0DU5NzHE8nQROZ+oaNItN4AdSi7vdnW9keodBr8C/r69JgOJT4J6yTqvDHhN4tdLCutW0bbEoB8OCceGmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641165; c=relaxed/simple;
	bh=QlrEMA6U+xP0E3BuDUykUYlfoN4reTbUOv4b0PXeCW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aDeJt2haPBHrtK8J5CbkJJgoVSUfwj/RoZ2Qo4l2MV2Mv3gyrXsN6VB8C7HIlUitn7bqIhI8saxf4sEkTCP/HX8xBzB1DJiLgoU7skefW8hfh2+zwWk7ZHanSgv2t5ZLjS76NUmAdNBFrW6VPF4Z2VpPKGt9y9AS1sFjcA/1OiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctvlRnJa; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7964f1405a0so6093327b3.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770641164; x=1771245964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlrEMA6U+xP0E3BuDUykUYlfoN4reTbUOv4b0PXeCW4=;
        b=ctvlRnJaBGTYyijkPspIA3jpfq040CcQLWRngSawv4YWnk0P6zZ787ykQ2f4jeyiIs
         /2IqAMffIvSuZiTKVDPwQBCyG1eV5lrCuB1CkxTmWbfG7nYsTlkl8aEms1/H3q5t59OG
         ydXB9QClnvk2WacTsmdnz46cMRi1RzQRgYK6Yoqp4S2oI1CFVY6maNvCY09ly+ra7hH6
         kfsGd3iSjc+Pi3DzGzvkH0X6aSl1tJFq0SAwbQU8UZs1BWojWXNtQCzrfOd1ZFIZYLIZ
         yE8Wzx7mgK5lSGKo38lt1RR7jmQWH39HZAuWoBdD0zHW7DsgSjq/NuBjy0Fwqqx1pXJJ
         L8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770641164; x=1771245964;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlrEMA6U+xP0E3BuDUykUYlfoN4reTbUOv4b0PXeCW4=;
        b=oOQsJDOteCD2x2GrVaRtVAIArB8NFuZPlHUl56wVETuDEqwE5x8mj/7dGxQRORWpyr
         9ptJ4sEM7O48t7oQY0dOuYxzQW9pfK8j1a68hwCfuOm7Ujfmi6o2uyY9obl3kaJi7Cnq
         nPkyRYkJkbYkdrUHS3EN40diJojiMWLyNwgdlVBhRep65jPgrkEvAjwm066IOfaJABR7
         a8WUz1PD0/rdOJcsBXT/DQ7f+Z9fAwkFv3TOrlS9C3Qkk3eG9vXHM90+mfN9b35y/gXZ
         v/IRgPLGdPh+MgSnGuOhZtY90oE5j+xqAlA2vHzgij70ocvpyee1dI3mqeNNK7M+OEw2
         vhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3bRHZAr/B7Aqmd0UOm3IK6Z1dD2aEaqwmHJsdkGnMejDmr1zcCvnpAU7wMTGPHbMfx2xy268=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMuWSfS9mUMHsWBlubxmXhENSVDI9Xq0suKKX0qOp0/qhV8Ot
	+/pu18m+XcJZ5JhnOZWwBrT39BpfJPRr+v0j0ZXT38KRHZ/u2stwKpAl
X-Gm-Gg: AZuq6aJ5/ljxWst8VEEaLBMBatLrvM5a0FiiRGa1CaC8xXDwRmjAHypRYILmgeG1V5Y
	i7wevUpWDZ0jEqAugKTGh8vFgY5PN3ybzue1yrfYTQjdq0lgI4DeMb+2VXbGu6z9Oy8a/5PXu7M
	VPlA670UW9RcfnWUO3N/yk+RtMqwbS1hTpAqSxe0cvhoW11kvb64SzK2FDYE/zHR0HZtq5fNb88
	4NjPdpnnQI8i1gk9pY+U8ukn9TJH2iTl9/dhUBRCJ2f89Fnf17lW3W9BNwKSmGyh3iNl3KQXyx0
	JPIbgRs/NQ+XPOMPwPn7V/XirqeJV1d6ZXag8szIWrVVM6CkBUoTGFvpKsMra+t06pJdlrqXIqa
	nwD7F/B3IJ2Cd2C4PCis/LrKOAofZXlln75hJAzrJWI9BU4aGGkxsEw3p27GaG+vnid4AhUQBfn
	LZZSC85CVwrlGXSyh1DSkI8cEFHxXZOjt4KjRVbr1RsS5rLgA5zUQEnH6j0B7fpVegpiIIEQ==
X-Received: by 2002:a05:690c:9b0a:b0:794:a165:1c3b with SMTP id 00721157ae682-7952aab650dmr91143427b3.30.1770641163990;
        Mon, 09 Feb 2026 04:46:03 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79529e45621sm91555017b3.0.2026.02.09.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 04:46:03 -0800 (PST)
Date: Mon, 09 Feb 2026 07:46:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
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
Message-ID: <willemdebruijn.kernel.2e6213a98660b@gmail.com>
In-Reply-To: <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
References: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257939-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAA4810EFA6
X-Rspamd-Action: no action

Vadim Fedorenko wrote:
> On 09/02/2026 11:48, Sebastian Andrzej Siewior wrote:
> > On 2026-02-09 10:43:55 [+0000], Vadim Fedorenko wrote:
> >> On 09/02/2026 09:06, Sebastian Andrzej Siewior wrote:
> >>> On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
> >>>>>>> But it's more like a question to maintainers whether it is acce=
ptable
> >>>>>>> way of "fixing" drivers or it's no-go solution
> >>>>>>
> >>>>>> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users=
.
> >>>>>
> >>>>> Well, they are kinda broken already. Without OPT_TSONLY and CAP_N=
ET_RAW all TX
> >>>>> timestamps are silently dropped.
> >>>>
> >>>> Are you referring to sysctl_tstamp_allow_data?
> >>>>
> >>>> That is enabled by default.
> >>>
> >>> Yes. If so, then we don't need the check below which requires
> >>> sk_callback_lock.
> >>>
> >>> Are SIOCSHWTSTAMP the legacy users or the ones which do not set
> >>> OPT_TSONLY?
> >>>
> >>> I would suggest to move the CAP_NET_RAW check to the point where
> >>> timestamping is getting enabled.
> >>> Also if ndo_hwtstamp_set is the preferred method of getting things =
done,
> >>> I could check how many old ones are can be easily converted=E2=80=A6=

> >>
> >> Looks like you are mixing things. SIOCSHWTSTAMP/ndo_hwtstamp_set are=
 HW
> >> configuration calls while OPT_TSONLY is socket option, which is setu=
p via
> >> setsockopt, you can find points searching for
> >> SOF_TIMESTAMPING_OPT_TSONLY in the sources, basically
> >> sock_set_timestamping() is the function to check
> > =

> > Yeah, but what is the legacy user here? If you enable HW-timestamps b=
ut
> > never set OPT_TSONLY and the sysctl is also 0 then you reply on the
> > CAP_NET_RAW later on. Right?
> =

> Legacy users here means users of HW TX timestamps expecting full skb to=
 =

> be returned back with the TX timestamp. Legacy here means that skb will=
 =

> be returned with headers modified by stack, which is kind of exposure o=
f
> data, which requires CAP_NET_RAW...
> =

> > I just try to justify the CAP_NET_RAW check and if it is required to
> > move it earlier (where HW timestamps are enabled). And if the sysctl
> > check is enough then maybe it is not needed.
> =

> Capabilities should not change during lifetime of the process, should b=
e
> fine to move. On the other, sysctl can be changed system-wide which may=
 =

> affect users.

Ignore the hardware configuration. That is entirely optional. Some
devices will timestamp every packet.

The capability check here is per-socket, independent from the system
hardware configuration.

I don't see how it could be moved.

Before OPT_TSONLY was introduced packets were always queued with their
payload. The sysctl check was added to optionally disallow this. The
check could arguably be moved earlier in the socket lifecycle and the
decision cached in the socket. But then flipping the sysctl would not
affect existing sockets, so that is a change in ABI behavior.


