Return-Path: <netdev+bounces-245807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8BCD8163
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 06:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BA4830022DA
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8ED2D3A60;
	Tue, 23 Dec 2025 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3tPFnPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFB2F290E
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466228; cv=none; b=QLh8vJXBfTO4OkX39eDpKJ1R2SviJbC/50x3PrPPZHu9qWKkM07XawWBQTcWSWgyIy9bPrPnsv9cxmfIPr2lqLeoRSqixCS+jP+I0Tt1HvjLUvXpDNZP7mmoe/QhZJ6GuCIsX74cx7YtOrvmOSNme6fuffz7yTTWTJSY1xnT4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466228; c=relaxed/simple;
	bh=a6bMG1ygbOgllwQV/xEFnD86doxRXT3uJEPvX1pBaWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfHPlbOUTS7C5G46YCleoQHrsS9sfkBHI4k3L505FgN55/io2jJKwEsl/5oHsJ8Stg5GS6R+JSOF0GS5bARdzXn1lJ6vjzf1yLiA7ufcEAdOS3cWSZZ32opAfvJLI4UoZvrRBwAGJY002VUIVud4iKO5xMjLTu0rotsHZw4pggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3tPFnPA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee13dc0c52so37864231cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766466224; x=1767071024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6bMG1ygbOgllwQV/xEFnD86doxRXT3uJEPvX1pBaWE=;
        b=D3tPFnPAYtkFYloPeyyz5ldSTVG3day4Q2dkoBJ/37EXwsnVetPikYX+J1H5gDpGyl
         M8CJRXv4j7VzsBUJi7vnzEPY/nGisayE5bGutuH9Cgsu+aGucIpuRvN68acX2qenD3ve
         gCRa3oCGTGuby7B1uDCqnAvFKboSd2erffJ9ur/WLInNyVpD9cAT89ZYPwfKiUWezBLg
         fatZER9tnp71hdDNI0lC2yTtZzfhagKTEpmVsmArbh9dkJYbEo+ul/EESWQZNL+hYEyh
         +R12wq8/02FxVJal7yed+xf8LKtxJkNxLZ7H7lFuYrYUcHomFpGrQgIlzXg8aAdiHTDX
         T6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766466224; x=1767071024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a6bMG1ygbOgllwQV/xEFnD86doxRXT3uJEPvX1pBaWE=;
        b=bZ6NRTRr9TKUi43y9U2+xvwMOBzF8IZesot3eEaWpKUrP5PXjxelcZ0anQvxQWGKon
         6IXoym3V/oxUJbWA1rRQ5HcmQMPqb2L1l0wOlYHcRTP7U3p47shHSLvwzoNL8aEOh3Vi
         pmUQTORuxGY2IdkwuNma9lYe6NepAI+twCObO1mIYooSoQ9GyHeDUHdoDniq/YSbP8iN
         CMPpJa/FcdqF3UXpzXsn8334nL/3xd1O0iFrcST7qpb/ARBYmRAXgrPQvb/Cp7x+oixN
         nRRYYwCr/HVj+jKla13Jn3Unzc41mMwAUHmx5GZGPZzeYvrpLjxeyxqZe5ftOthjqeeI
         sj9g==
X-Forwarded-Encrypted: i=1; AJvYcCXcntXWw/tl9x0GMBDxVftSwf471/O+alVwo1wjEXg0dLQDyE8hbDhoy5JucE5w0qhDnj2YJL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/29pRKHfLV3zYEDQhmqjWKvY1I5pqflAytAc4dtfpajjhIpS9
	EdHn58FiNuTiKaDNsWdmK4pifNyHodjqhTnhZmbOE4Q/3f3g8zfXirA8PIUaKY9tJwLfFzIlpMu
	aqWjKERT1qCvNXjEYFjF5j00W0ec0MOUI2fADJm2j
X-Gm-Gg: AY/fxX6PcWDtbEIzhTA0pq2h/g2uyQGmEU/tZg5PmKRjEL0dOKRy02KDMBmge3Quz+R
	0W6cOlauegA1qDzmkCBXDxkWvITOZYgJJ7ybpYTUv0TEUUBmGJa7Cn7QD6Buft2L4jQfN9nRrYZ
	WYDlC51ACY/wTD/tmWm9lYU08iur0VHbFeBTqBDEJVxEpVxraKNN/LAFgd/uHVdNEe4EeFqZkcX
	TfPuovDmab1qsopyZXsFEv8Ijj4Hq/eOC4+WN6+ZgJ9TZusE+SpqJo3KG7FaoeQ/zNYzA==
X-Google-Smtp-Source: AGHT+IHSMQ7km7uj/qZUz88xhjl4F3P8UGddMsjOUsPEO2WzoGX1/e3XfBk5oBbzGpDbHUInyGR0sL13O2o0KVMWJzY=
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id
 d75a77b69052e-4f4abd75629mr185166151cf.39.1766466224170; Mon, 22 Dec 2025
 21:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154545.594580-1-edumazet@google.com> <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
 <CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com> <d97e33e0-0b23-4f58-b1a4-5e171defe732@intel.com>
In-Reply-To: <d97e33e0-0b23-4f58-b1a4-5e171defe732@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Dec 2025 06:03:33 +0100
X-Gm-Features: AQt7F2qJr3YSIDla9HFp4bZYO3Ppr9L-IgvWSUtxSosBHqOjSzPsgIU9KkAx3cs
Message-ID: <CANn89iK6hwMo_i3F8pnCUQmCJ+wWq8HJOu-dGz94REZr+2oSGQ@mail.gmail.com>
Subject: Re: [PATCH] x86_64: inline csum_ipv6_magic()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:40=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/13/25 10:18, Eric Dumazet wrote:
> > So it would seem the patch saves 371 bytes for this config.
> >
> >> Or, is there a discrete, measurable performance gain from doing this?
> > IPv6 incoming TCP/UDP paths call this function twice per packet, which =
is sad...
> > One call per TX packet.
> >
> > Depending on the cpus I can see csum_ipv6_magic() using up to 0.75 %
> > of cpu cycles.
> > Then there is the cost in the callers, harder to measure...
>
> Oh, wow. That's more than I was expecting. But it does make sense.
> Thanks for the info. I'll stick this in the queue to apply in a month or
> so after the next -rc1, unless it needs more urgency.
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Gentle ping, I have not seen this patch reaching the tip tree.

Thanks a lot !

