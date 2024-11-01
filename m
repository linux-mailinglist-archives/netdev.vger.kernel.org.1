Return-Path: <netdev+bounces-140867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAB29B8840
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAECA1F220E7
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537D3A1BA;
	Fri,  1 Nov 2024 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="o/bTmDQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED14436E
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423983; cv=none; b=ryXOG1VpeaCKadpbExx9LVaWgEmyKz3oQi/OLMaV1CrsNjemNVq3KEmScVGRMFjBQ9PQIFjxeGDOxy8RpCTGumssW2ko8YceS9skxMjCOZYSXfoF/YIEwge7cdc73QAzAD8NfMn5c1TjvEL1WcGuoQVujrybvVjEPrRrfWoZMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423983; c=relaxed/simple;
	bh=7hpn8HcLcK05uF7RJHNz2gNqdIUXbsjJMB13axZo1vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFFXpVh9lRy7c3ZE8PD0g2UKOqEnLnZ+KLwQdQWB3HBhaySwdzGT/pgYiSpNRMv1wsmcBjFS6HJRIZpxS3FlsuiWKy1BjfSS3okT1guedUKNZrrbhKkrRAqhJEpXpqctTCiQPeZP4+1enfjxv2yleMHaa/aKp6dlrJFXif6EC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=o/bTmDQ5; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84fdb038aaaso371605241.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1730423977; x=1731028777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsPpxtjxBpROy0U81sgj+9OcCVp8X5Atrm3j2hCZcyg=;
        b=o/bTmDQ5P0vvSbri58pq5NdNzWGzDVWbPdG0+jNIDAu+sedjglQOrSX3g1M0d/utzS
         AI6iZtaFDOQYhrbfP3ydI13ZdrsZ4OjjNtfAKOvEwcGECiiVh1WR+EM/LxAhmwGf/Aot
         a3tGMtgCZg3EDL0e718b8YrXexj8MxGEZ4aAncQG9Xs1lIBzBlc/x/Ec5EEQ/4ugP1aE
         GC5+ZlDkvmapQ9XN517AW62SL7atm7mnA9sWRCJLYREa3X8ELGWETm0db13aFSa/PKy+
         24czXYaA2gwRBiD7Uj9JFwrQMLMstaHbFQpUYXp5rh4pr88RSoJCmQ/jaK+yYzb2NHlI
         kG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730423977; x=1731028777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsPpxtjxBpROy0U81sgj+9OcCVp8X5Atrm3j2hCZcyg=;
        b=mCPYmY6B8rBUXdWM/9rsTNKc/T14ugax83Se5CxJw5CYAka16Al+TfJ/P0v7Y3TFZI
         M2mKXwVLWaKG1Dcjze+kMVMLb59thuZTzSNFjcrxH9KLiWDR697Z6FYXbw5vRkybWZs5
         eBPPNMwqFJvrPLZ4JB+6+pu4TCKenyalaubcMNrytIawi7n4Cuh4sxnAssXISDWqZ1Q1
         yN9nX2Vd2oOmkMaiPOcJs3WUTS7JDJsRhNNA8HtldWbvUiiPwVT2UJ8OaSvYKrfjmPj+
         AwOeUIuv1DF3ypKy3Fx1uMhDSZABjH7NtDMbpcvql92RW65WKJVVNOPl/pojXii3hQH4
         7xcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP8KPmui7FmG0QKMNrhEatxfZDMYU9aSrlx+Fp2ShnkwtrVccxL46TrT5tcgWrw5jhcpchcWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBxxAHlITSA0CJcCMoweqsyIHl8A1qge6OuroVdmbZ0MflubU
	eizPuMJcnMOcSifdQcGaHTtD9kKGOLGfjm1bXbN03yJYA9zmeCq7zObelG/GNCgYb1yOJkuvra3
	jROGLfiDJXerPUJ1KwrNO8ScMmfOXAOx0di9tFw==
X-Google-Smtp-Source: AGHT+IGhk6bzoauf+z3OsS/ViFnTwLQWVpzU9hrCB5ELls4IaWjKV5gGae/XfLi9TWNsk4NIPgkGjz8ZMlCRQ5tazqg=
X-Received: by 2002:a05:6102:3f0d:b0:4a4:6098:1fec with SMTP id
 ada2fe7eead31-4a962d6cbc9mr2047720137.2.1730423976771; Thu, 31 Oct 2024
 18:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
 <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-2-a8065a43c897@kutsevol.com>
 <20241030184928.3273f76d@kernel.org>
In-Reply-To: <20241030184928.3273f76d@kernel.org>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Thu, 31 Oct 2024 21:19:26 -0400
Message-ID: <CAO6EAnW4LwZax-UJf8s1uNS=V7FYJ6e1N3MekNjzaoyVDCO_Tg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] netcons: Add udp send fail statistics to netconsole
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 9:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 27 Oct 2024 12:59:42 -0700 Maksym Kutsevol wrote:
> > +struct netconsole_target_stats  {
> > +     u64_stats_t xmit_drop_count;
> > +     u64_stats_t enomem_count;
> > +     struct u64_stats_sync syncp;
> > +} __aligned(2 * sizeof(u64));
>
> Why the alignment?
Hi Jakub,

Thanks for looking into this!

Parroting examples, e.g.
struct pcpu_lstats {
u64_stats_t packets;
u64_stats_t bytes;
struct u64_stats_sync syncp;
} __aligned(2 * sizeof(u64));

in netdevice.h https://github.com/torvalds/linux/blob/master/include/linux/=
netdevice.h#L2743-L2747
I don't have any strongly held opinion about this. I'd appreciate an
explanation (a link would suffice) why this is a bad idea.


> > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt,
> > +                                     const char *msg, int len)
>
> This is defined in the netconsole driver, it should not use the
> netpoll_ prefix for the function name.'

netconsole_send_udp_count_errs sounds better?

Regards,
Maksym

