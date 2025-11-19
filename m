Return-Path: <netdev+bounces-239771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BDC6C4F9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 378A929894
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEB72566E9;
	Wed, 19 Nov 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErZroqxr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLwO5FHj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CF24A05D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517270; cv=none; b=JPxqAm9WfBxPBTWZwWH9b3MmzekOrpQNOesfVIDgAU34EeeAE7oOAukYXsmS9rGYtjOyaIumeNzVUO8eA1yT/6pP4PQWH1j8d21p+cpGXWNjZEE+2pfst5I2dWiAy7uKLu34Gc79XkWDURm3ICkzPmxuHzSzJRpjlBYV4Q80g2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517270; c=relaxed/simple;
	bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQhotoIlZxUDML8HHuNZkNVkfiS2wUUEetlBAalURGDNRXujAajLTQCoz/llzwP/JEszqC25J4HDEGSFB/L6vYyanqGWzWddJ48qIp0BBbS7dFdh3z1lZtBg0BNFQmBcq9veSncfQsRR0RClAhBXsOhKyMPaGqtbgWJ1nI76TtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErZroqxr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLwO5FHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
	b=ErZroqxrIv2AayT2MIVbLGtUpVgzAXdCtDf14Px4yzrqc4SI6nxSROCAbQZ53xX5LRGI8S
	M8MG5mgp2QDXmh+nsk3hu6+8HY2rRP6h8+nIpsDH1YY+fn6TaxEtSyMs6APjIVvFGI5KMn
	vVyaegLSSXcp27fgVI5frC9+Mcajzgg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-B6rZDFUIMNS2Ww8av-0UTg-1; Tue, 18 Nov 2025 20:54:23 -0500
X-MC-Unique: B6rZDFUIMNS2Ww8av-0UTg-1
X-Mimecast-MFC-AGG-ID: B6rZDFUIMNS2Ww8av-0UTg_1763517263
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3438744f12fso18459217a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763517262; x=1764122062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
        b=QLwO5FHjWWouWoYSkXvG+8/L+mOr2t3mCd+cT1XNqWEx/jlB/OWJ/FG6Mbkyrsm2DZ
         1LoBiFAx9cGSTEu0dd3HzlEfcH+eYQ51eWZObqCdyGly57TFmFqzq3VE2u/wEwlNWHWJ
         HZQ2irYMLUYpizHuycOETyAREVIAqaQ2BPNMXWUQQtTXDUXy8BTJrVRuCskTfIgKwc4P
         cA2NRgIByP4YBN8T/TN984dHZDw/xFJ85j3xFIVkbsvIQxIJcuZCk0rtQNJ6M270j3+A
         qC55u/cKYWOR5S3ugOyweOAu/g4JG78+IHXDO7CxiWiIomSO+HC4GwFORm6wAg3ENsOR
         tsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517262; x=1764122062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ti4if+e0vZ3+Heb4vsKFgYIQ8JY3byZZQGyu2jg9Z6A=;
        b=oCyEOvqfLeEdrkO16IWtSWEgVpIo7RY6J4mRhxEr4hw4UqgcQmtuK/TAld+qgCEdV1
         dRH1ACD4376EDB3ez+89R+CegyNg/Yg8xqMH77WGLJ1w42Ym+FJAbg3LtawrA0mNcr8U
         v5vWwoBLEzlBLUXkxXMDU+nBdbwYrbkiBUjolpGFJeFasq/EThTulLT2Y1ec5YO7MFGm
         za0KoMuMecl+AikodHHD7hwyTHP1DTKgKTlls6pF+ZBZC9lEQOMjy5GE12zu5tRYx+nB
         Oh0eUsQtlCoRenxG1rGyisXJKbwtzYOlSnw9qlSk+2WjN52KbaELE48HW3JB1jcY/X1T
         V0og==
X-Forwarded-Encrypted: i=1; AJvYcCWCjrtEpV6pXHwXMKUbvxJfafPg1dRVp2P6Jh9mn6I2t2fH6cQICdiY7bREd7xl0KVHgwz0+MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekE/u9zqbCpzLDuCTykAuqQZTQsPDxL13Aj6M0Sj98ib+pyhJ
	PIGLc+tsNYQ2siXUtAZCIdt4bDzKJwOuT69d61zIJjqi4aX7UxyezY6oiWV35gc/yNThd5m/s+I
	9w6bec93rSqeXUhHSFYiGz2WRclm0+kP4TGeC+VU86JqKZgdIkPVHGQ4pTTmfPGVYr574/FHeBw
	6/YZI+xFIznAaoQLIATuoqb5LnUqPRL5N6
X-Gm-Gg: ASbGnctzC6aAhiTn3zF1o7qNcEiI9wCuAMYIQsnGz9uye+Pn1/cwq3iU52ptzyXqAKU
	XjM5oNsdYxoy/X8apwlq8bvRe32eZTJLLHCtkDel0Vn9Yd9qvwHHAc8utBhJgSIa7l251BItM1O
	MjbO7V3Yih+lpjONuPrCLE0JQz/Cs3ZZbHwyscBNbFyKrwTxcL54tsXlaKXHTPbtg=
X-Received: by 2002:a17:90b:3847:b0:340:e103:bfdd with SMTP id 98e67ed59e1d1-343fa73278cmr18556657a91.25.1763517262749;
        Tue, 18 Nov 2025 17:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5GXGkEHQ50wOVjXeybBNs1hI+lnVX7iORT/ZASpo0ztu6fbH4EioPP1/R57VRfBgN1e8GgzjV0oQvyiZ1tT0=
X-Received: by 2002:a17:90b:3847:b0:340:e103:bfdd with SMTP id
 98e67ed59e1d1-343fa73278cmr18556631a91.25.1763517262213; Tue, 18 Nov 2025
 17:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763278904.git.mst@redhat.com> <dde7267a688904e4304bebfdbc420877cca70891.1763278904.git.mst@redhat.com>
In-Reply-To: <dde7267a688904e4304bebfdbc420877cca70891.1763278904.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 09:54:10 +0800
X-Gm-Features: AWmQ_bmKidj7jFUERWFCVnMYooo3WyTNjYb-AYGW49thc84xS2-48DV1m8Bt6Ms
Message-ID: <CACGkMEsnS9GCYCq-QVqv7W0Em76KKyFeWXOhkHNJmUWh4bsG=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] virtio: clean up features qword/dword terms
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio pci uses word to mean "16 bits". mmio uses it to mean
> "32 bits".
>
> To avoid confusion, let's avoid the term in core virtio
> altogether. Just say U64 to mean "64 bit".
>
> Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
> Cc: "Paolo Abeni" <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@=
redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


