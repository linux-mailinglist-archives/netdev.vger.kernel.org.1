Return-Path: <netdev+bounces-276422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOdmKgMp1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:08:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243B43BA537
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE853094B45
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4E3B6BF9;
	Wed,  8 Apr 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uC9n03h6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413D3AF64D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642696; cv=fail; b=Ogsj1eCnJ7b63JVswaD0bvFzxyKKjFdvPDlGAk2u0QTKYbgkurxxgpIhhv0xhZdz2oMV7e4vhmzZmm+XsgzhNFg/BGbZtNkxQF/HQynHoGG8Gjv44wmF3uQ5Uo6VI5A0fW1Zet49FF/V7psx8J0ruDjxOMNPgmJfK1eu11EuIGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642696; c=relaxed/simple;
	bh=LImdsS4EBJCH+IoSQme0lgHzwK8ltPIxsfZLeJ2o6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2AzuSTV2f3duqWlwce6uPSjQlkfV62HhT6IF7ByjZTJCjmFUdxjx/4mMTMVRUkHigwSSFqy0wsKpwbHfx68C8kNYg3H+noHg85iEGAxZpivdlD+3qekm9fx2f7Ut/sJrJrR1hnBkG/7/eU5dIqG3rdNUGnFRk2AMk4+d9C8DEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uC9n03h6; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6383MSOK2312152
	for <netdev@vger.kernel.org>; Wed, 8 Apr 2026 03:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=LImdsS4EBJCH+IoSQme0lgHzwK8ltPIxsfZLeJ2o6mA=; b=uC9n03h6SVUe
	hWAfrascRtYfkoAsbcv3RtUH/fcDchxFuVDA3y2rArFOctax/Ss4OuaQQYTZykNK
	Uw1tDh1AjRsTfkFVKZ9UZIwoV12RYx7l39uKq5p173qJLVpjhHR/5hnorUrUCGz8
	RPG/d+615E0rEiUP94X7VSHrx6aKNKQttfvtR46AEQgIc5PaLGrj1/My/+/W44gN
	M2JyF02wLLMfsULZ72G1UT/eQdq0JL0qHol4AQrW5QAuMHDbIoKrSt88kJLc3KLv
	1bjxQ7BU8j3J58+CCY7z5Mbe8VxdE8ocsG8uTsx5XkrXI1IZv/TgV4dtP/jZEqtS
	umavwRejJQ==
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcmts23r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 03:04:46 -0700 (PDT)
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5a12514a844so4400431e87.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 03:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775642685; cv=none;
        d=google.com; s=arc-20240605;
        b=KrBbhWimeTSKEmtao0YAw+xgklzve5d1SthhvDloTTLxCKfOE3653SkZAlGGeK3nQE
         FngC6cNS0TDyqm9Zj9gOOLWOlkDdasArzfBm2cYmn+ydWCcKzXoob0EREOuaZydvsG8T
         9NWCEri8jlw370WV+o9SMAh05YBoBajJxnk918dz9FhsTeYTf/s5wyEeV+Lb60J7rnfA
         bTeyF0QxAhZUoXtPqwDG7dkwdgoCcM5iGEsjoHL3TSfyBuwlqJ2xYud8WSK36CJvQtMT
         d+XDq0O81F64hFzCZLYUu4cMjZaQqYazLdEgVNz9F62M3KoWXPsl95xwReE891MEbg86
         FsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=xjIuCParSu9CSR5m55xubcB5M2VEMdE3nmLeLU8GNS0=;
        fh=5MRgcsbFk11AWLcoAqAiClJGRbF42WXogBAAP9yMDMc=;
        b=AuHoCiWsjhpA6dAh2EiiXLDNDjxxPgmxzbWAJ8fybuPF+BHjExEof8opDo6uSLvU+/
         iWtfbGiv20RxLN4VmpNWaORRmwwx8jjESt2ZOdFXuntbZLGgmBZYnHzIDWp+9ueZ1/ba
         Yoq7d1uNcOv6WlqQQKKbsnnO5IcSa5TIUc0hDrWxS/DVLUoByZ90MfuFO/4YKG+wReXh
         DENl4tznZhTox6CB9qveSZnX7GJocD/SPMuSgVRxY0J1Oz7HiM7Uq43kyN3GFVSRe5mC
         E7jJP31eDw+/RFp7FubGqJXvBt0gHBMnUGJxpidXPY0hjyqLXs8+SSOuq7u+o2K1xWrg
         QpwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642685; x=1776247485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjIuCParSu9CSR5m55xubcB5M2VEMdE3nmLeLU8GNS0=;
        b=n5BhAAe4rWLWE1Iz7cFmiSu2U7JDpXmdIXHFbBNUgSP+n0XyIR8FK42wJE+AFLSGMf
         u4J3ASge4jc95Np/BWklVw///8HoRSyOOrOSRWJb1E1XBYalcvcbopH0eGQ80NqorzLS
         sSU9EqyvHSEBHAToyLfpLuWblVkIvphaPDUxByo1RPYDGLpsEl1CnFvhWAuzN+ycVSGj
         RWIeLH1tAwTyDIbVtZ/0fr6hugdUVP47QL4TlL2cEgFNDu08Y/2UFseGaa8QfX9FZhSl
         VCN45tfWItpjqR51vLe+wLJ9MKJYq8u03H54k+30d4v86nmRW9s93vrO9IDkzMZq6X56
         +hkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9R/Cg+SNDkh6hVzP/yA5Kc9E+VNdu+M/077KH3cMY3P4zzcf0YO5mOwtPi7sjVF7A3dwKJ6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hnCGvCFBXjoBrmyCZRwY7flVnbtE0i71x3er48peAK5N+T+2
	4YngLajl0P6tdSbT4hZXBYQWUIc2SvZJ4zgSgfVpfDOF1fETVZy8ry+IQBxGvtEKSdPEMlHJut3
	pjJrJ3nPidI1evXkmgoElz4jiX01hbJy2361jMvwWo7OCnTWUoosxgopE0cEZ6AezHVrMIUbhkA
	imHscC13/dTSpNXDOOLSwz+9gtIr5DOcQ=
X-Gm-Gg: AeBDietcIBcMsWt9tnkzOq7b/YoCIs9OUXWdUEM/6DSFj+IpSMg9FuAJNS3ZDf2UQFz
	4F9WK6P1GHq8ExnZr4cu8zl6ppS9zIeSCZ+V873r91+XOLY9e7suV4osmzTcDniktykc5dYBTg0
	1X2sOVrsnk/1jML6l06ycyGWfrUFbAVx/urGBPbowoO8H1Ll/xo/EHu7sx/T0Aqdz87JEmgSrPb
	Hsl
X-Received: by 2002:a05:6512:31ce:b0:5a2:b3dd:7a63 with SMTP id 2adb3069b0e04-5a33755a340mr7058203e87.10.1775642684720;
        Wed, 08 Apr 2026 03:04:44 -0700 (PDT)
X-Received: by 2002:a05:6512:31ce:b0:5a2:b3dd:7a63 with SMTP id
 2adb3069b0e04-5a33755a340mr7058192e87.10.1775642684193; Wed, 08 Apr 2026
 03:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408042345.1011-1-hataegu0826@gmail.com> <59d11588-0af2-42e6-a030-83240a0a5512@linux.dev>
In-Reply-To: <59d11588-0af2-42e6-a030-83240a0a5512@linux.dev>
From: Matteo Croce <teknoraver@meta.com>
Date: Wed, 8 Apr 2026 12:04:08 +0200
X-Gm-Features: AQROBzAFK9EWsSUTTo0J4NshMGXs5dGf1gLa7-P3Q4BqcYcPdeddvYSXGmPFGQc
Message-ID: <CALnesNoaASYCS-6EJZ8UmJb6VsnKKis2uWQP333Fx_RJmrjD+w@mail.gmail.com>
Subject: Re: [PATCH] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Taegu Ha <hataegu0826@gmail.com>, netdev@vger.kernel.org,
        linux-ppp@vger.kernel.org, gnault@redhat.com, jaco@uls.co.za,
        richardbgobert@gmail.com, ericwouds@gmail.com,
        Cyrill Gorcunov <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=N4gZ0W9B c=1 sm=1 tr=0 ts=69d6283e cx=c_pps
 a=Ek2CW/51tKQgDdzxJl6u8g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=Ol1KDzRFfyqdv8hK7gAA:9 a=QEXdDO2ut3YA:10 a=5D7b1r8g3QutN-whcLxs:22
X-Proofpoint-GUID: NUrSQMxk4ZSL9hivfku5vf_YBiaNNUbo
X-Proofpoint-ORIG-GUID: NUrSQMxk4ZSL9hivfku5vf_YBiaNNUbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5MiBTYWx0ZWRfX7k+NIXYjZgSO
 C9NLs9j2tHa4fFPxPHLx4a4tnwBBsh0HKi8CtKMRBjI2EnQVVmBvx17w9KsmLyYmtRr9y4H66Mt
 jEl8fhBSwLE8Mdel24zyPmfQHbUcAt8nSyhlXK4Nw1nkQw838XWoFgq8QGV9K04iYhw3zBJuA19
 qYEQ5IpheanRAneTE2kqkBEHVap0ULoDgHWDEiH4afAMHO53w08iKUDBX5kNyk0zkGh7gClvHyQ
 4qFFnyRWlez1cT0QdivoryQx9WHC85p95saxJ/MPXCMd9beaajKmKqy5BHGzBMahLawKygnz84Q
 HtdnQKoaBwbzbtsIKWEcRxRlOlQROkYxCJxf/LsVgaQxVGfVifoMEu5Fz6cK6dkqx8PFn+8gCvW
 oNMhFk0Mvd4C6hzVnETxl9DdJmHVAFERcL3iPAaeSLjKCElvW7Cqon/SPIyLT1YcDps/vPpqgW5
 E1oz6gSoe7zEi/PE4Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,uls.co.za];
	TAGGED_FROM(0.00)[bounces-276422-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teknoraver@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 243B43BA537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 8:28=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.d=
ev> wrote:
>
> >
> Hi,
>
> Added Cc: Cyrill, and Matteo
>
> On 2026/4/8 12:23, Taegu Ha wrote:
> > /dev/ppp open is currently authorized against file->f_cred->user_ns,
> > while unattached administrative ioctls operate on current->nsproxy->net=
_ns.
> >
> > As a result, a local unprivileged user can create a new user namespace
> > with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
> > and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
> > an inherited network namespace.
> >
> > Require CAP_NET_ADMIN in the user namespace that owns the target network
> > namespace before handling these unattached PPP administrative ioctls.
> >
> > This preserves normal pppd operation in the network namespace it is
> > actually privileged in, while rejecting the userns-only inherited-netns
> > case.
> >
> > Fixes: 273ec51dd7ce ("net: ppp_generic - introduce net-namespace functi=
onality v2")
>
> For fixes, you should set the target tree to "net" in the patch subject,
> using:
>

LGTM as long as it's still possible to start a pppd from within a user
an network namespace.

Regards,
--=20
Matteo Croce

