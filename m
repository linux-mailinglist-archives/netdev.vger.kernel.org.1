Return-Path: <netdev+bounces-251866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK3DDn3OcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:02:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BA57484
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42471A06857
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0D446AED6;
	Wed, 21 Jan 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LOlQDm8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DD1EEE6
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000014; cv=pass; b=MziddnLH1ZdMmXqOGBYCcQfaWGC9QlPQ18DyogOjnlICwutcBIln03/tWaWzVE3FoPnU+rAtXpa39O2r0BilKst4GwYg3M9RK/eHIeLNtY0V6Hn+FWqruMAfBCPoNmfyf0/EkeS/eD/9WB5+5EAQWKQJ7vlLN+MQbACgqlVkvFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000014; c=relaxed/simple;
	bh=i03AIHZg1lb2Lz+Na5geo85S41XtgjoESShmeDMYh40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn0OYfOarHttAs7l0mebZOYxsmv+Y1R0zTdsWvgTLaaKlmaYAJOcd+VSJhXC05DbKKTE8MBBHpGpYgt7xzR3EiNO0uwPIkusuA7/9qrUOXcKDltTs3E85SVwW51/Xf69WQhKr6xLEYVvEpi0hQrqxovXw/9230t1ZevHsU7GC4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LOlQDm8I; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81df6a302b1so5339818b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769000012; cv=none;
        d=google.com; s=arc-20240605;
        b=HlYqt+LAdV2DIjPTHoTbXqjI6EdYLzhKpM14MaP9ZsidiSVr0RjeheOUF5334AjG8o
         fKP1wh93ypdYJfqp6zqOSy5gbw6DqhkCxMNztandECcRrq/3Ki1Af4RzrU/7SLz5tTKX
         jrDxsqP08/xo1PUJRB8VXbt1LnGH3CLw1OZ3c1ZMKA270n4c8EV/jqewmAhGv1DJbmbI
         UUPPxA2UHTxjPrwwE8SB4Nwvm1oF1SSmRbi2eid0WbhBVGNaiIAsOZgSI6HU5PIEsYWG
         X/WwFVJZF/WXo+TIicGCMZKa/wvSJFk166zfbGksHVZ7GT/FxLQGbpvIqkhjXqml6BRh
         ih8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i03AIHZg1lb2Lz+Na5geo85S41XtgjoESShmeDMYh40=;
        fh=ejbKkkL6QEaZ9go/kAcGDYKjZEkfXULtbD2LSh8gSgA=;
        b=LmeBZxPoBYRLAMuyv3viceevgvrZDMeUEEezhnnq387SDmdXZol5nE5AixEU2nKvMk
         MEj3YoASFu045cSHUfV8sF1e7eir8QW6ZBDn9LfdtkVY3YBDd66n54XHxozflRFHv7Ws
         L6Tc/js0Ki6mRBtzcvdpsz1rsycmuDz1oiT5DrwkWdj5b9wTfxfArlOzM72/cxAb2acp
         DR4gtiJJFhMmvdE3oLS7/bZK4TYnTJop0UpAvzDXQZqJTPEgmDs7FZp2VdU4t0KmdCHG
         0pFEK1TglMab8D25Fduz+buwgZbcxvQy6qAD9+tvkwC8QTWylnRRUB+GkXDLB+11lOCc
         GWvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769000012; x=1769604812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i03AIHZg1lb2Lz+Na5geo85S41XtgjoESShmeDMYh40=;
        b=LOlQDm8Itd7qwVIQ4yJmSllV0ApIJHOLKNaCDK6AWyCTU8ul1tjEhNRx8HuzikDJBG
         cXqvHtlrAPGnhaSdiDIPphfR86YJRnSkTwAT52Mk1ctFqvLyb3MoR+4f53SsEEgZ0phY
         fUBh/jg7AJ99rCyszfh/1CmUTRp0dF7/TRYeMpBeiBOH+zSPdet3UpfvY5mA6Ejz5cKl
         QcMpakB46eygDz34cuXKEJXcKI30fqmaJzbAXgfNBw0geZIVnH5Jr1HJnQ3CMLC37sfC
         RMIwXXrCsrVa9+YSo8NMuE6DFdrbxhBr09P8bdU3lVvhwGsbuCpdOajY04eqEjR7YiAP
         INig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769000012; x=1769604812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i03AIHZg1lb2Lz+Na5geo85S41XtgjoESShmeDMYh40=;
        b=lhUXpFn0Lh3PguhTPhpD1CKVDrIuowAccm5cTBKbsyUB4Dv94AY7PrTJGRQnMs5y10
         ZYdds71oChkZy59sjk1kSj+9kMiU/PSHWlMm2/a+qPVyZf8dSuADUWcgXZhhLiLM16xk
         evD9KPehANVmiVO2gOmg/kkyR9QkiP1aszm7vDtmjhr5MDsYSpb8lAm7Mxftbn6BaaBh
         bpTkC5Yuz7zJmruMIpp7WSEXZN+/YIxQrXSEE8f4lL3k2A9n9z+JQZE6EwSWOPGPUst4
         omGHZ/tszR1cX4XVKwT9F12l3SHNwwNubOdo9zP8KcBvOnldEcjVowboyULYH/K3/GpW
         QEpw==
X-Forwarded-Encrypted: i=1; AJvYcCVR6kH1HRoPXZ/nf1ewmDN+b5lfwyDIaXtKt0NPMQB9LfldST90k4RZ7anBrEizl2pg3IB0uuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxukuxgUoI4U/kxMwwWsuZqFfXL3OSitKSf40bjEDqGE+rfs0mh
	ZWNnkWuN9XGil/bAfMrrP48IGmB8CbklPKNXIwlLRkZzn+VM/s+7pW6kgIkPuwDiWMP7+Z9FObn
	dQHs7rwghCDUZPDdqN+yrOQ9pvA0j9b07eYTY9tpW
X-Gm-Gg: AZuq6aLf7dvVWGNE19q/bxdtcN+ndjypf0aRXbew+cUrG9SdDMyHLzosotdhMU9sCDL
	fKE9DO/JVqy8zXvWl3jTSm1dTUbesUgEuF+h8WeVJN452mcm1o7EEumXlaSrfSXbxaI/RlZT3b8
	q9lkaP/cZSwFqzxsyP0iCtDmwnebZGrqqmD+LS53vF8cCiGGZkCvUOhvKXGD7tnCOSryNoN9dY0
	QsmIxS8yVNYzZ4KPaG09Om237uwAditGDtTdJNOQ1ySTaF5sJkzucb8Wy2qiaLzgaUWCcXrSWef
	7uE=
X-Received: by 2002:a05:6a21:a341:b0:38d:f799:c4d6 with SMTP id
 adf61e73a8af0-38e00d5cbfbmr14429886637.52.1769000011820; Wed, 21 Jan 2026
 04:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN0zt4Mi4NDdUua5HXDexyyvD9naan6CnQV1yB_QT41=aY8LEw@mail.gmail.com>
 <925987de-2685-442b-a185-6ba1230dc6fb@redhat.com>
In-Reply-To: <925987de-2685-442b-a185-6ba1230dc6fb@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 21 Jan 2026 07:53:20 -0500
X-Gm-Features: AZwV_Qj20Ba8WDG-VqWT6qkIsdGKcVq1Y466TO2RLRGArSGPoozJ8QiaGBjQwrI
Message-ID: <CAM0EoM=DmfHD2aPCR5GJUi-Ay2+u+iJWsrQvP7L2xgRwZhXxjA@mail.gmail.com>
Subject: Re: Bug report: CoDel patch
To: Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?B?S2FyZWwgxZhlxZlpY2hh?= <karel@u-n.cz>, xiyou.wangcong@gmail.com, 
	Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251866-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[u-n.cz,gmail.com,resnulli.us,vger.kernel.org,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A09BA57484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 6:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/21/26 12:12 PM, Karel =C5=98e=C5=99icha wrote:
> > please see
> >
> > https://bugzilla.netfilter.org/show_bug.cgi?id=3D1825
> >
> > Apologies for contacting you directly, but it has been a week and
> > nobody noticed it. Maybe the wrong place to report?
>
> Indeed the netfilter bugzilla instance is not the best place to report
> sched issue. Adding the netdev ML and more people.
>

Hi Karel,

Please post this on the netdev mailing list in the future.
The proper commit is 342debc12183b51773b3345ba267e9263bdfaaef
Do you have a simple script to reproduce this issue?

cheers,
jamal
> /P
>

