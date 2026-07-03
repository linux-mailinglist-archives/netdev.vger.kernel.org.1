Return-Path: <netdev+bounces-304506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nXa0FUeWR2qvbgAAu9opvQ
	(envelope-from <netdev+bounces-304506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BA67018A2
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=T8LbvGFw;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304506-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304506-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A563108218
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A03BBFDA;
	Fri,  3 Jul 2026 10:46:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A934041E
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:46:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075598; cv=pass; b=bS+jDgMfexoIuWsLRhCqEr0NoyD7YEt0OAcKceLRrlNIdvbfIWtUnq+FpugNzUHaLrtOXXbwLSaO8GcJk7qZRgS+bNfWmnLo5vcUwtOwjR8YzDQE2FW97LbUqHvwwAXuHA/szE6OES4gd5vJs85wg//PWDPEOoccM+Cw916bCsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075598; c=relaxed/simple;
	bh=IpWUMxYd8CFKcag/2NH+IUKQoE2vQjVqdD6eUuurFIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdMUF0hF19/83EUHImZNr9yLaM7s7bUrzfGk6Nak6F+3T4jdGOWuC/pJGdiPQFB9FAttK28E1DKe3WCak3B7fD4wHUjROPsJ9ob/XEmGDMTcx3Dcrumvdn79L/77FYlzLjiNdueqdSX93Vtk2211PgZfAfbpZ27MmzFC4AiPk7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=T8LbvGFw; arc=pass smtp.client-ip=185.125.188.122
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 705993F1C0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783075593;
	bh=4epk5w1esZe4maLqLH3hcvb3jGEQbCU8XPkEVfv0wsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=T8LbvGFwjHKUSZxCdMDTOlvPDMI9r0rne2vIL9tly7fpiLKjrOKi92OrHB3+KG+dE
	 0uiaz+eL6Cb/z9jhaQf6fzAugrz/aRfTMlcMwG+OQ+DINogjdOZMux1bYiucyARZq4
	 JVhICpwCcZp4QsnO+eMsVBb46JcpgR6G+u0NQaETF5fORfSbV9Wt5HlTKpzfhV+5V5
	 OmKDwBqJkyJxDdSyXx9eIDDDUraU1AFDcA+KtosyyLchVklcVrYxrUhOba257ZiuXS
	 UlIv8VNSthXJcfSBjy6ChXeowcPUhwHLDyTfMnrTj6rWeHCfKUuG2rpFG50Y2MyvWX
	 hzrs0k+0DmEJGGsd8lpt3K0RFECwBbLGHp6qYRIplpDEjABpJ8LTcNoGF6WQLLgYlL
	 zaderGOHoAAU/TGG5ZVngjaRCqmVO6wbjdhl4j/5oq4WOCIxGZBmJQ8Fcd8D+CTCS5
	 X3hhLLHvOrAKLr5GUFp5Hd9T3dBRyzE+ovoWLoPLb88ltPRKpT9NVn4VOIX7hCgtOb
	 kY3Y70h7L/AMCQUNumzyPD4m/FG+2xkgC8m0OncLYJKUnjGk85uaf6l0mG8z31j6ix
	 D/f28iH2AH3+dLtRSgEzs+kc2HxA6kBSRtGrmHqzA6pWkhh44WayTYhedxv4fDET2N
	 ELSmJ15+X2/SgRMJjU9BAZfs=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1280d28bf5so48966766b.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 03:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783075593; cv=none;
        d=google.com; s=arc-20260327;
        b=nXiAHrNrBUZUkNRUoZXggKLnrnTL1vBgj5zRPwJOahHXw0S6hUtv4jsuz1CMxd7ZCS
         1DX0QUo7CLGc5d57/02Y9QPtylU2Fn1immQo1TVWI6NRVQht07TlB3hYX7Nz7anPh8zJ
         i3p5AAIga0xPlJ1P1cPN/oR50JSExAVAfS0oLo8LJH1tTzXO+juMZCIGfEFR6vAK0vFh
         ji0HI/1E0IRBCiJMzjMTIVfEMoJFK9mC7NoBILY6Sj0FUaXtYyMLCXTANNAuPkFRUQzI
         hxiVkT0iU+ODJ1mlLXR/4B/Kg0OtBLyrmvgiIQDaAhwXC+7eCvhN4KE/NcILMTFNHvuP
         48OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=4epk5w1esZe4maLqLH3hcvb3jGEQbCU8XPkEVfv0wsQ=;
        fh=9cnpE5Oe7O7McYeIdHBYBrZjq838ZjgFg/mUGYQSIRo=;
        b=pJtDS7J/O5XW96BmyA0b5cekO/CP8jU5R9Uax/kxoeSh7XVlP9MnfWBc9XChfSwKmK
         fn/O6h3Cn+tBg4Gk7RzV4UUSx0CQFK00malAiY1hG5DODMb+P5VOp21yHL0jTgB35qG4
         ltl+EKypRD6MsQQ+aiQIj7QZAkTXnoAJVSuGYGzH1BRjKhFO5y/xgSVVUrYt5hdDc95s
         7uDP1FaEBT24ft08kGMBN3CNHyG10TPszQDgQKYxR3OIotWnjACltZejhCemM9OI1TV5
         m2R9/HC/h4nh8DlxKI15PgUzZEuunwY+SQju2HFFCK4/VSxVzOkPzGdX/uMBNIgy/cQN
         PL0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783075593; x=1783680393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4epk5w1esZe4maLqLH3hcvb3jGEQbCU8XPkEVfv0wsQ=;
        b=Hic8YgBf15FRF63JTNZP0a/xCv1L8/LcVv+kZNNYLOhK8/Bkn0x1v8kmwTflG7qTcs
         BqqRYyQeZUinGJ3CqK3HuBG5WXcdZxTy8ljsYhx/yKVe25V/7Y61u3C0TwEXTC4+E3xd
         MrEaJg66JAaLH7A9XDeVrCK946Dzjg9rH5iYySzWvciFT36/GUD5UeE/0NiVyZPeXLPo
         /Pf7QnqHHX6p/BssXyK2kB5adEJe6rmqntLQzMSgqcLU3rRW+18Pc97N22y4nXTbQbZO
         WRD4hvGH5Z+rtrluucBsZO4SX3L6NRHY074MQTL19omhNAX47s9n+91MGh9UuC/bb5Mt
         6iJA==
X-Forwarded-Encrypted: i=1; AHgh+RpGKv2oPMUemXltCIByzuHTBMj4fBoiJoDCWyzbwVwGOoNxSU9XCfJlmb/FekUnaZEW0X2Jcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd14AppkaQEpWP3MnTxtladR2cFZcaRL9M2yRuAzlMoEyCUDxH
	Jbj64Y0GK/jyX1crtu7Hk9zquJSc6+0Urdg3SACCsZQdar6skKx7cLUY/wkMFNoXxtzKabZfe9c
	WISvbbXww34fRGoprtpHGN+LVz8APpKJJFFs0Vn+IqbNTalpa6f9FQcpr0b1+GAqY82MHNipa+s
	mSGqc8l6pZuQEdcy4gReYqIiERQe5jSM7aVtcQeESN/Nz4vc+o
X-Gm-Gg: AfdE7cmJSUUoYJ3i8klkgp0lnqquKL/VaYa+JRcZHA6nYG/T0ogiVF5ZFxuNMtV7TtO
	LG+yLn9jwUuPfwlcI8qaKONsCJ6DpgT2Q3p1PJRUBj7BwxeN8QV6SyS4yfstiv/EpFfN2frXOw0
	ej7pb6Sgucrf3/9NvbbzXuWkGcInBeYIdHjlkSWSRYSgKapK6yiM0quMC5DjKtmlcdaQ==
X-Received: by 2002:a17:907:c205:b0:c12:15b5:876a with SMTP id a640c23a62f3a-c12a9efd3b2mr412864666b.17.1783075592941;
        Fri, 03 Jul 2026 03:46:32 -0700 (PDT)
X-Received: by 2002:a17:907:c205:b0:c12:15b5:876a with SMTP id
 a640c23a62f3a-c12a9efd3b2mr412862966b.17.1783075592453; Fri, 03 Jul 2026
 03:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617120753.1785565-1-robert.malz@canonical.com>
 <20260618152003.909400-1-horms@kernel.org> <CADcc-bydFL4KNDQEznStE41NFXuCey9S+kyXg0usbonwyWpiAQ@mail.gmail.com>
 <5658849b-0425-4132-ba32-5801e2907c60@intel.com> <CADcc-bwd2CcWJ1AFDm1GR1HBzo2OOh=Xr3moNS+-RVuai6yVBA@mail.gmail.com>
 <CADcc-bwC4FGQSGyRcnj2ZpGT5+0Q6mjQd-FTCB-mCmmwYrC8Qw@mail.gmail.com> <abe7fbc3-522c-4eb4-989d-21270f1ef2af@intel.com>
In-Reply-To: <abe7fbc3-522c-4eb4-989d-21270f1ef2af@intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Fri, 3 Jul 2026 12:46:20 +0200
X-Gm-Features: AVVi8CdT0MhvGIVXGg5KjVEJtXlAzPLAX9gHi81brHAzWLdEyecittxMY28qi9o
Message-ID: <CADcc-bysA531q2Wh=TD_oFqxivLLdnCRNY5jy7mkZuO0cwJwvg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304506-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,canonical.com:from_mime,canonical.com:dkim,osuosl.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5BA67018A2

Hey Przemek,
I have submitted a new patch to solve the current issue:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260629/055=
891.html
I ran numerous tests on it and also verified it against the setup
which initially triggered the issue.
This system had a problem where ice_discover_flash_size read time was
greater that 3 seconds and as a result failed with EBUSY status (FW at
asome point releases the lock).
With new patch issue was not reproduced even when the read time was
much higher than normally expected:
[   75.999353] ice 0000:05:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
datalen 0x0000, retval 0x0000 <- First lock acquisition
[   82.152231] ice 0000:05:00.0: Predicted flash size is 10485760
bytes <- ice_discover_flash_size finished reading (7 seconds).
In this case, the driver properly read the NVM contents without
needing any retries.

I also analyzed the overhead of adding an acquire/release lock between
each 0x0701 call and based on my observations it did not negatively
impact the driver in any way.
Execution time for ice_discover_flash_size in normal scenario
increased from around 0,02s to 0,05s which should still be acceptable.

Regards,
Robert


On Fri, Jun 26, 2026 at 1:46=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 6/26/26 10:15, Robert Malz wrote:
> > Hey Przemek,
> > I ran some tests and unfortunately, the following sentence from the
> > datasheet is true:
> > "For specific resources, such as Change Lock (0x0003) and Global Config=
 Lock
> > (0x0004), this field is used by software to override the default timeou=
t for the
> > operation, and also to specify the timeout used for this operation."
> >
> > This means we can only change a default timeout for 0x0003 and 0x0004
> > but not for 0x0001 (NVM resource).
> > Whatever timeout I provide FW defaults to 0xB88
> > Input:
> > [ 2209.656758] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2000,
> > datalen 0x0000, retval 0x0000
> > [ 2209.656760] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000=
000
> > [ 2209.656761] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000=
BB9
> > Output:
> > [ 2209.656927] ice 0000:31:00.0: CQ CMD: opcode 0x0008, flags 0x2003,
> > datalen 0x0000, retval 0x0000
> > [ 2209.656929] ice 0000:31:00.0:        cookie (h,l) 0x00000000 0x00000=
000
> > [ 2209.656931] ice 0000:31:00.0:        param (0,1)  0x00010001 0x00000=
BB8
> >
> > Correct me If I'm wrong, but the only way to properly handle it is to
> > ensure the resource is locked and released between every
> > ice_acquire_nvm call.
> > I'll start working on this.
>
> thank you for checking out!
>
> I agree that simple retries with improved (refactored) locking will be
> good solution.
> Failure to lock should count as an unsuccessful attempt, with possible
> retry after a sleep.
>
> >
> > Regards,
> > Robert
>
>

