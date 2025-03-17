Return-Path: <netdev+bounces-175262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF4A64AA6
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059211640B5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990122CBE3;
	Mon, 17 Mar 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH33LMWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAC1C6FF0
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208382; cv=none; b=YzuNU3cHznN6k5sgUF+38YHJnCuTUrN/8+jvu5cByPscSnSp04mE9+eG/hFfSj8kldSmIDEMvwLL/spAfqSKKrm97CkcysBBgBVup9RZvkHCLHc/94R9PQe8FACO+pVR5fm0oVFIAWj4iDsJrSOdFr+TRh2ZTH5aLX/oFIgbOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208382; c=relaxed/simple;
	bh=r+9f6F00qUsPNiJN5NbKLcaAOz3gs9lW/pUoh1oreKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIRUL99RLKSDD16aQwRsTV5EWgosDiLxIsQDPmXqcMuYYAivdVVyUTG7sDM7+P7KZP/A4yPhifkRL3b4VjnxbseyANBmzxMoUDZY9WyWRTrxzBm4opIwHP8DUoRgYJLRNyM0y3u5YDwzUKRQLq0eV3wP3XasVJ2WkFPfbT5aKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH33LMWa; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474f0c1e1c6so35339631cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742208379; x=1742813179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+9f6F00qUsPNiJN5NbKLcaAOz3gs9lW/pUoh1oreKA=;
        b=dH33LMWahikk6biojovs42FJvW8VutmB5R/ckMQhgqucyNrzn6h0GOrkxiZGBrZ5JV
         btKXx/Y78d0rDLNQ+orBFs8euxiUR2d81CRE1csK9O8VtR9h8mEjK1y0dH9MPiK6JVn6
         YUK3rRctatCuqR4CivN5Udu43ux2ArVENeFYJUWD1A/f9PbFt/RFQETCdhKQikdprUjz
         FqoL8ukkwCPJlGOCAHdxoFNHwZL7rRhCq+lcBbiMR5czZynkYSE3bA7Wm8+u79yz8lgt
         lRmj4HCZVeJgFc+7XIXgJ1kmH9b0VqwiPFY1jPrazSalIdjSwW/AvqI7enuCljpfO7e9
         rHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208379; x=1742813179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+9f6F00qUsPNiJN5NbKLcaAOz3gs9lW/pUoh1oreKA=;
        b=jYQ4jKwuecM0LVIP2VPqZeovjcFfbrWuIDKrByDvlHkeCZQaNcWbOvqTUUxh/rq00R
         EOy1DjVW3n/sADNFPi0y8EUQ6vmIuhT4zPLfw4tfw7nHvAFe52yOPnH+sx3AF9MAI/yX
         8taF5ui+Z/GCvk8CsN5cBif2Dt9yFtsGa9/lMiNYPbb/Eo8TogwThvvWJV72c++nsK6t
         dZPlPMHuFrj8VieJAnx3sGd0uwqkR3StIUi87T8lyWK7xtX5CDpalkUZCW3xFDOoklrq
         iNSF96MK9Oqzr9NUj13O+zphwRqtROjRuCSIy1K55glOI74qtuK44FopgMm8ZQ0Dw3k8
         HWJA==
X-Forwarded-Encrypted: i=1; AJvYcCVrMaQ9/ZkD04fHL+BtW0c1ZBFR3UnfuMz7j7EoU6wQsIuM7ntngPFPwtbmj7vu1Q4JJLGbFog=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGKSorC14EN5Cyc60+bAWjauXEh7+BSs3amfY8TDiFvyTW7MA
	haYzgG7lEoTVVBoGENeOT2UKsPye3kJdlRpk287TzgyWGmzoHWxRvPRH2b7j+29sjf2g4ZInGrE
	zkRiadfFWVgEVHGbHnZzFmSf0pulg61xs7L9FX4OlpKuM7wS15KKK
X-Gm-Gg: ASbGnctLgqZjQjCG06FtSfnQ9uejk4KCyWZuQD9v1F94JyMj/07EgJSTATeK1lvkwy2
	kqHCo3u/I3zGU8DYqGz0seDjIs/7NgtQZhhlffv6pt6KBk/r0p2AfFbNRclhVWPTABMHSK2bysT
	W08g/J4/GNa9+bwzz2RaozJOYAF0A=
X-Google-Smtp-Source: AGHT+IEyz9P9eQgTyh1j+Jep7BUS3KCDhXUEM/E6TIadyx6f4FrH6BQ6oPgyICwn9OqAKcU+1hIS1DfaF05HGoIH3EY=
X-Received: by 2002:ac8:5a8a:0:b0:476:923a:ca7b with SMTP id
 d75a77b69052e-476c812401fmr189822961cf.1.1742208379350; Mon, 17 Mar 2025
 03:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741957452.git.pabeni@redhat.com> <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
 <Z9Su1r_EE51ErT3w@krikkit> <df7644e4-bb09-4627-9b73-07aeff6b6cd9@redhat.com>
 <CANn89iJZHok-JHiu3bSZQaNSbu4r+yJkXhZ8eoTtk1EaHsR56w@mail.gmail.com> <cf04be0e-eeaa-45ea-9a06-3870e65a977a@redhat.com>
In-Reply-To: <cf04be0e-eeaa-45ea-9a06-3870e65a977a@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 11:46:07 +0100
X-Gm-Features: AQ5f1JrsMQRVYCmjwMcg-14KpwsJiENe9gnMMhHsWn0ltWOnaLDi7DF61UK7xro
Message-ID: <CANn89iKUYCXaUV3FS_2Ws2PU3Z+OimmaJGWLZNop9D+085pb2A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 3/17/25 9:43 AM, Eric Dumazet wrote:
> > On Mon, Mar 17, 2025 at 9:40=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >>
> >> Thanks Sabrina! I'll try to address the above in the next revision.
> >
> > Could you use dev_net_rcu() instead of dev_net() ?
>
> Indeed all the call site are under rcu - except the one in
> dev_queue_xmit_nit() that will need a little adjustment. I'll do in the
> next revision, thanks!

I think this patch makes a lot of sense, I would submit it as a standalone =
one ?

Second patch I honestly don't know yet :)

