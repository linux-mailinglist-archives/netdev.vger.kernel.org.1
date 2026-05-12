Return-Path: <netdev+bounces-286985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIlbJRjYAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:34:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9651BEE9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D8AA303ACCC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE436F8EC;
	Tue, 12 May 2026 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H80sUoPs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZD51iBi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF747DD43
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571231; cv=pass; b=aK4uBSoy0md1AQu/ISxaxle+irAzyGMA5gjTE75zH02FP8r5cBqpheii8xuivFWLGECsVTH6VYdENNBy8jR1Lo0ShDuiniw6OoClDJrcn6APnFfYjMvzFl2SwAOBBd3anM+J1r69P3yuufPoHwI98o7GNqtH3lZ9FLo9/XtDdNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571231; c=relaxed/simple;
	bh=kCN78Te4XRGbHrCkS5X9/zjDZZCsBAy3Y+sNHlXGbPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQhQdasZM/+rvavk9JeQURsx+/E2H0fsOGQgAex5mRopebYkbm0SGmXELMLOjcBRECBp57XWKdTcY17W+LZw3FTgS/T/zp19cUpBKGmPkHqUb6qypVdr+wnxcwlEJWhWZDR7viSB5bhlPjJsPT4ZhctOn+HOuMUuCHWeGVRQqro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H80sUoPs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZD51iBi; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778571225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCN78Te4XRGbHrCkS5X9/zjDZZCsBAy3Y+sNHlXGbPI=;
	b=H80sUoPsoJYqwkOcjkcIdd6kF4EcuHVsS/NH/4SVYPS2Pd23XaWis+Azpp6C4D6Ma36s1C
	OvRwZa9UYWes/tLf4eMPLh+59D6uSCB34FuCkYcS3yv9SBpcFAXvJxXotegknMU9Vd51uA
	WGxPrguZdrmBPrcTpzwJr6cbp6tmMEw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249--qogMO-iMnavFg-hoduShw-1; Tue, 12 May 2026 03:33:44 -0400
X-MC-Unique: -qogMO-iMnavFg-hoduShw-1
X-Mimecast-MFC-AGG-ID: -qogMO-iMnavFg-hoduShw_1778571223
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a86f4deccdso4123015e87.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778571222; cv=none;
        d=google.com; s=arc-20240605;
        b=T9FXg67+60LLRUCyvsINCk9QU2s7d04ncKJLJDBH1SEr2aC+kDHCvtogmaRdS6zEUb
         T20ZFN3pKOXH1MqJo33kJWwWQTQRDSN5k0+cZ6bXaN7FRfmX2nCRbhNkoeBNWQJZhltj
         Q8I2xp4G/BkzZx1DsMUakfmdl/qoPDNGWgoueSAD783MokVw4JAqovWWpaurWaCRxPCG
         G+Q62JTCMsvIFZmVEImSW3NejBVzm7lbNu7L+c1si/4Or4Ut3wwIU8IGSiEoSjW3aJ/E
         Tjmwtu9fVUl3qdzyulptnz4y8EEJIT7vvgRzny5vXG1aKNItO7J5ZxZ/u2C5564KOVen
         qNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kCN78Te4XRGbHrCkS5X9/zjDZZCsBAy3Y+sNHlXGbPI=;
        fh=YRQmGyIOUuMvjfbFYoXz6Wa1DvJ/2DvULz0oYJ7mQS0=;
        b=Z/vp60NifKa3ka3Ih3IwC65go1RryUAM5FCNQmQCJHyhktQeSkmaz4+rfuhgo1h2ON
         0NY524aSr2ImBbAx8D5OyE1DO3JP9QmaYhPwHn3jKbM3my5gqTJEOkTFQ/1k4+SywGSn
         Pytcru2w1jMbA85sFUAt/gb7lmgURhpQP4z7pEear+n9JDD3F5FNMQ+A66ZUPgiWwIPy
         Yui+EPDIzodAZZoOEVYa1D9IpGR0oJYaLXufzAb6F5VEInO8jxnoX08xT8h+dMo1dE2j
         wolaHsqY5NELRL3F7sNyksMyTZZ6bg4tDqbkQNSHt1CQ8mCtAgsG8rBzpVkDlFDLAc1b
         cXkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778571222; x=1779176022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCN78Te4XRGbHrCkS5X9/zjDZZCsBAy3Y+sNHlXGbPI=;
        b=ZZD51iBimXpskUqaJSgh0+czTLjuGZenrqqbFOWsHY8+hG9lAG+TAg3kQtrf6aRVg8
         KWWIrowk5DkgPQhZ86JvGwxihNFi1ujYH1+HFQf0/8AFb4jRP8I73ySLeAbZIM2anmYC
         vlzqm64TzKBJN7mBqA1HM5t48ktIYkPcrWQziz/06k5PKd4fHdIl1uDwU5cky5cMCClf
         PJP0G6zWJ7MdMl+icQqxawVT1GvDhJw61goZzi8cA93Na9zIVaYUAH6VHNe/pVREsp07
         sKS32E6ugNZJ7sRWf8hzY5WknU3PkXO3b6diuAQL1DWrfP0iuEPPxW8i76DLTIkNX5Md
         QWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571222; x=1779176022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCN78Te4XRGbHrCkS5X9/zjDZZCsBAy3Y+sNHlXGbPI=;
        b=fWJQyBAsNLzdbZheRqcCnRdhG1axJ8JkvUMXDAFbM4WbchzEoQx1usuXGNjKP82w9t
         Fpsv7l9ygwX5q8KF4Oc3rQpIGRQwvBa8ti9jf4UhbOYCUJQQqCtQnrLJDmtL8ilwMcsx
         0yQD0LEfPtdo/hw/rQmctFXde8/1ZcaUQEhR3t12mlRXAeYcNk2ErBbD65QA2gPvrq2W
         fiHy+75xXMWJ0sDjt33M/JkuAHdkTcFbnle8uPTShN9Vm21Xg80rPG0cxP9P0LU8lFUY
         n70dzegTCK1M9+6ly/LMSutM3yNY8Bf2/sA7Fzeqw0Ys57GONmP/e5QtHBK3RMBTixcn
         ar7A==
X-Forwarded-Encrypted: i=1; AFNElJ9bs6XidJDjj+I00kcwHb7Oj4qRVXS/8vSCn5Thujt1zSVCxDEEe9f9qGRAmXHpWIB0t7SYv5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOc56FJ5Th4PngafI6ATq0PKCrNclltUWI3as1LzwVIgt5POR
	qBLo1yX2EUoeW3RutszN/yRzrocxzFFGLkebgN1LWGdRhCV8a0aVUjZ94+gZj9japocVJ0KZszI
	hkoZGCL1Wv17ZHgyOXdrCTnC2SfxsfuQ5Jaw2Wqv2vGydu/ESNBIJlCKOfgON3R52YIHARuCmwl
	JDwmxTvIFJzPE4nK8EGHhwevp5+9Pans0A
X-Gm-Gg: Acq92OGVywd6TQUwGz2STFnnDhjwXnYqitkutGzqJ8g1CwPvTSQSe/wJdUS815RWHTZ
	wgz2Qv7ay6pWTpyCtB3h2X/gBUOhMzLJwmVplSMKok2+pMx52QsKyOp4B16wPNdaFfGzy7nXZpS
	ZSb0Zyy+fZz6Yvw0WPF2MflhpWPSp83Hmvo7Bo63YoKEvbzmzCQZ9UUWAsGLYX4oyrudbtok0wv
	1vXTg==
X-Received: by 2002:a05:6512:3e14:b0:5a7:4699:d851 with SMTP id 2adb3069b0e04-5a8b6c9c530mr3819263e87.7.1778571222565;
        Tue, 12 May 2026 00:33:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3e14:b0:5a7:4699:d851 with SMTP id
 2adb3069b0e04-5a8b6c9c530mr3819246e87.7.1778571222057; Tue, 12 May 2026
 00:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510164337.7611-1-ihuguet@riseup.net> <20260510095246.5c8f6d0b@kernel.org>
 <CACT4oucitAa05V11KD0d2mQYc7h1L36zDGumnRYXn6+6XUa=QA@mail.gmail.com> <20260511165930.14c7b6b9@kernel.org>
In-Reply-To: <20260511165930.14c7b6b9@kernel.org>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Tue, 12 May 2026 09:33:30 +0200
X-Gm-Features: AVHnY4LJ9gBoBs06nD7X2x1M-eVmft0egAfn-rJZSwPDCundiOCtFj5Rm7UJOdk
Message-ID: <CACT4oucOVK+CBBvushvzX7RdVJctQBMbcWuz0+hv1Y-wTmrMmg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] netdevsim: get link via ethtool, set via sysfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Filip Pokryvka <fpokryvk@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 25D9651BEE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286985-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 1:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> All code require maintenance. I'm trying to push back on netdevsim use
> across the board. It was essentially a workaround for us not having any
> real HW CI upstream. But that's no longer the case. Well, we still don't
> have any crypto-capable HW :/ I think you'd be better off implementing
> whatever you need in a small OOT module instead adding fake tests
> upstream.

OK, we'll continue with our current approach of maintaining some OOT
patches and recompile netdevsim with them.

However, just as an opinion to consider: I don't think that pushing back on
netdevsim is good. Even if you (upstream Linux) have available hardware
now, small distributions may not have it. And userspace projects that
interact with the Linux uAPI may not have it. But they can still benefit fr=
om a
mocked Ethernet device like netdevsim to have a decent CI coverage, which
benefits the entire Linux ecosystem's quality.

For these userspace projects, saying that they should create their own OOT
module (basically reinventing part of netdevsim) is not reasonable. They ma=
y
not have enough kernel knowledge, and the effort is absolutely not worth it=
.
They will just probably leave some parts without testing coverage.

A better alternative would be to have a common OOT module that many
projects can share and use. But that common module already exists: netdevsi=
m.
And it's hosted in its natural place: upstream kernel.

Those are my 2 cents. Thanks for your time and feedback, OTOH I totally
understand your concerns about the effort required to maintain any piece of
code.

--=20
=C3=8D=C3=B1igo Huguet


