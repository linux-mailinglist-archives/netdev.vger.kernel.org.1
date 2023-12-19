Return-Path: <netdev+bounces-58913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB58189C7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B97281C82
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889E1BDCE;
	Tue, 19 Dec 2023 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIWyliap";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQvuLWV0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED71D525
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702995965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T+BVsISZ4M4K107mOguc7pWHjx5PSIHJSlTULmNLWI=;
	b=aIWyliapHoaRQBo0pQnSNU5xcdSrOQL4IezqOiISRVFLcb52AuSsXxTBxmXY/1SZ5GuV06
	UOo8OGcTWRjASfIuWj512S28KAAAUkeknrSIRwTQJwRiON0LGZxjDU8V3/V39Wz9YcCm8F
	bJHOuNEpI24b7+DthZAttPTe1t6hMESTBk2vdu6kCRcrn0wQMEwGobDE9sQZSJiQQA/jHH
	em5E33m8lJmzVrWwSq1KR1ayMvtUmdaBS8EPYtrs6/EkToSa1Q2RNINS2f8Etq2UazihTn
	KJWqrFO7StiMVDx/DWcfdROLtH2Ix7Q03Wblw9JDT8AbU14qlpexJVpCyMpSEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702995965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T+BVsISZ4M4K107mOguc7pWHjx5PSIHJSlTULmNLWI=;
	b=nQvuLWV04nLYxVFnZQ69kgSHL4M9M9msDAJJbUlSUuhYFnfPNskCyqV1b3zVPsa4FWkMW2
	MyDGThVm9Xg+QTBA==
To: Martin Zaharinov <micron10@gmail.com>
Cc: peterz@infradead.org, netdev <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org, dsahern@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
In-Reply-To: <6D816814-1334-4F22-AFF8-B5E42254038E@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
 <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com> <87r0jrp9qi.ffs@tglx>
 <6D816814-1334-4F22-AFF8-B5E42254038E@gmail.com>
Date: Tue, 19 Dec 2023 15:26:04 +0100
Message-ID: <87v88ul14z.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19 2023 at 11:25, Martin Zaharinov wrote:
>> On 12 Dec 2023, at 20:16, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Btw, how easy is this to reproduce?
>
> Its not easy this report is generate on machine with 5-6k users , with
> traffic and one time is show on 1 day , other show after 4-5 days=E2=80=A6

I love those bugs ...

> Apply this patch and will upload image on one machine as fast as
> possible and when get any reports will send you.

Let's see how that goes!

Thanks,

        tglx

