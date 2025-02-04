Return-Path: <netdev+bounces-162697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48077A27A20
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EA11658DE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7F2185A8;
	Tue,  4 Feb 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQAyxdNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94516218580
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694301; cv=none; b=DWNj08LAbOKQqAohVosydjHlQc3v6PiMBnanoNVp/ejtQoXU2IothnBZWtqPP/aMnZvyGTQtUSMX0KSlSI/puOye+V0gRi0/Cw6Vg7XMmbHXloBcAIyYwRaOcC9FV0/0+Dbp75OJ0E8s10pOb5+fmpsSBUhsNfaAmaTUCYNjDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694301; c=relaxed/simple;
	bh=VWpYyC5BU37vNckaIcwdTn1dk75YBwDKTVHbH1aG/+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCrXp8bbQ/WldNIsJ1bXeUAk7s2/Yvn0i5rRxZfSC+Wmng2pcECs8mhCxE2Wv/jbdaerXkAfp9owg1qWvgJUeWVkV8ez77AUtL2NUo8abWf297NGVsBcmMB5rc4BwE9hkRcw4aOcfN1Tdmlitx5sr4HhPpWM054zll1SeHuT/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQAyxdNv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f032484d4so169345ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738694299; x=1739299099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWpYyC5BU37vNckaIcwdTn1dk75YBwDKTVHbH1aG/+U=;
        b=SQAyxdNvX/9D3n6s0aJHETIxGi0qlQMfYCRxYwzqiHmBg19camk4s3iXBnVJV1E/iR
         aU0pUHnI1L+8hXq7YgBKpt9Q2St8x15ii8wpoFhkeYBr0vdMuPi8x4JZywoBuIZ6YClh
         fxriK0tdk16fnLH+88RRvuLyc6AVrgG9psqu+KcbyuRBAQ9C3iT8p/z2akhnQOUYsXdv
         DjcDDfF/7iIxZzOMDXyNvWqDF1XraOQfOzOxlWtGrn4MWa+qj70VWQzfmxHh3Wb5ilcz
         SAdl4EOB7AROczUTHODS5yEkK519sxe7mMd8dzD8deFHEQip1VYy3R9kd3dPtEyji319
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694299; x=1739299099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWpYyC5BU37vNckaIcwdTn1dk75YBwDKTVHbH1aG/+U=;
        b=Jvw9cyhwTFgXrC1QBBWxAj/nKoSOqxiS5FWFEYkKOUMfQZdMUL2T8k9gAln/rBx7eq
         5lJL406qif920qPGBIbiknOJp9vFQtQ4yYOoByN821rpHdADGlVmwj+nJSNb9ZUonwUe
         Tvd3KUG1DTsRYcsClgb5VhVUjVQCWDYW5Tefjii7TU59tRs2L2/e0LCmJLP+kEvmQcTn
         Ptlj4Aa8quHR2y04i9FdvN2mLn604GF+S6JMq82WILzoPBu6IKyWYrD9p5js2rTDGueg
         46RkLzskOrVQQ241tqUJ9+o1OBATKkVBduF+R5IiTj111swV1pi+L7R7/oWQnEN07M9N
         FwNw==
X-Forwarded-Encrypted: i=1; AJvYcCVdW5cwK4GxzzTERIxRWAcg494twqUtTD15BvdGgHQqq9SP4Xh7gSrMwiltOASdAOy332XiT6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVB5qPUxmzPU/YxTm8i5zQ9aYSN/PMm9Stiq3X+lwNVI2sp4o
	N9vhC4M7/dZUdLqstEGtGi1nj2/8LHTVKBAe9br3XVTPtIPEIpOs9Ppm/yj6ouasVpXcAb4HP+X
	/kQrvr+L7xxNjHy+Z8wxPMhSfo2potExm9F1f
X-Gm-Gg: ASbGncvwmukVOSdVNaZPHMTD7eGVYnJAKkrbzOb0G2RXBnmbz619+GQusu6nkrJhI2E
	3u0hYXPRWaosvBJpQsTwQhJdqxATuhUofKxgefB4qzKL1eoCe0yVnX1KonS9ftktvnyecRob2
X-Google-Smtp-Source: AGHT+IFMTGKEbMUy5X/wrxqKuhiOwxvTYxxRi6wgw8OFhexTlZ37aXHNFfZcZ7HGBbaPcBnhWuc/sZRQ9XK6HaeH87U=
X-Received: by 2002:a17:902:b7c2:b0:216:201e:1b4c with SMTP id
 d9443c01a7336-21f03b3c699mr3066345ad.9.1738694298421; Tue, 04 Feb 2025
 10:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com> <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch>
In-Reply-To: <Z6JXFRUobi-w73D0@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 10:38:05 -0800
X-Gm-Features: AWEUYZkWWji_vJg7EQ7KO6_P-US-dmF1BLoKiALNV67hc1IBmcJTgjtC3Y2cAtM
Message-ID: <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:06=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/04, Mina Almasry wrote:
> > On Tue, Feb 4, 2025 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > > The TX path had been dropped from the Device Memory TCP patch serie=
s
> > > > post RFCv1 [1], to make that series slightly easier to review. This
> > > > series rebases the implementation of the TX path on top of the
> > > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > > the feature is thoroughly described in the docs & cover letter of t=
he
> > > > original proposal, so I don't repeat the lengthy descriptions here,=
 but
> > > > they are available in [1].
> > > >
> > > > Sending this series as RFC as the winder closure is immenient. I pl=
an on
> > > > reposting as non-RFC once the tree re-opens, addressing any feedbac=
k
> > > > I receive in the meantime.
> > >
> > > I guess you should drop this paragraph.
> > >
> > > > Full outline on usage of the TX path is detailed in the documentati=
on
> > > > added in the first patch.
> > > >
> > > > Test example is available via the kselftest included in the series =
as well.
> > > >
> > > > The series is relatively small, as the TX path for this feature lar=
gely
> > > > piggybacks on the existing MSG_ZEROCOPY implementation.
> > >
> > > It looks like no additional device level support is required. That is
> > > IMHO so good up to suspicious level :)
> > >
> >
> > It is correct no additional device level support is required. I don't
> > have any local changes to my driver to make this work. I think Stan
> > on-list was able to run the TX path (he commented on fixes to the test
> > but didn't say it doesn't work :D) and one other person was able to
> > run it offlist.
>
> For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F=
31@mini-arch/
> I have similar internal patch for mlx5 (will share after RX part gets
> in). I agree that it seems like gve_unmap_packet needs some work to be mo=
re
> careful to not unmap NIOVs (if you were testing against gve).

Hmm. I think you're right. We ran into a similar issue with the RX
path. The RX path worked 'fine' on initial merge, but it was passing
dmabuf dma-addrs to the dma-mapping API which Jason later called out
to be unsafe. The dma-mapping API calls with dmabuf dma-addrs will
boil down into no-ops for a lot of setups I think which is why I'm not
running into any issues in testing, but upon closer look, I think yes,
we need to make sure the driver doesn't end up passing these niov
dma-addrs to functions like dma_unmap_*() and dma_sync_*().

Stan, do you run into issues (crashes/warnings/bugs) in your setup
when the driver tries to unmap niovs? Or did you implement these
changes purely for safety?

Let me take a deeper look here and suggest something for the next
version. I think we may indeed need the driver to declare that it can
handle niovs in the TX path correctly (i.e. not accidentally pass niov
dma-addrs to the dma-mapping API).

--
Thanks,
Mina

