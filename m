Return-Path: <netdev+bounces-129527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C677D984509
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C191F240C0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0191A7061;
	Tue, 24 Sep 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKwpgVkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626091A7044
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178096; cv=none; b=mfAdLMOuNPp/KXfNaid8AGgyD7kOO5ZTvflmMPnDrf/d3YzwXVVLxJgLZG3PKT9EMExgwuJ2ZUkQ7IUdVpprK6N0O0Y5w8ox14pBgpazagjD+gKxx8ku8rxyoe8I6jNY2EqU1xRS04OPH7BkH5uf4Cjqi46ETxouneyP0MPYEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178096; c=relaxed/simple;
	bh=9b9AIM0D0WQUMIffHpOBsByjwEElnQ05FKM2vCnaOXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFODMLjsZbp3VgC2Mp0JNCbUFq11GVa0PfNEOzyVKeKcYwW+HmxZ7OPROyewt2cHw14VB7NPe5g9Og6WAQtdvkV1PxLWne3Hqw74EAL5b0ET7VTY0UdyBqIHnZYdOEykMBjrYLU2CvppnB26Fny4Mz7JolzWIwk9fLDQwk+CPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKwpgVkh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53568ffc525so6233188e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727178092; x=1727782892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9fc57nlwLbQdQ2sAc2oCWAZfOvWwEj+gafnpAGtImk=;
        b=lKwpgVkh6wH5S2enMDs0MvorEO9GJnJXbagQ2FiPvfeybOb9f3NOqxPY82UiLrHZBX
         c/V+38u63ZguOWJLkALg7RAlX/iXybdiIRd5ddZnMQwTwOk0lCXR+etWQ3vW1Lizjuj1
         XpW/SKAWR8W32X8ieCW3+xdClhVlEx5nxTxZpv0K0q4ySxPevr0xa4XU2k3laFrfV+zB
         pos/yK45yFad7d4zIdAbpTm46IG4sWJJEG3z/pJmxsLWpjngykA5WpFBB4Dx2nyskga+
         m0Lytac0YAnHF087yo9N9XNJxE6SoiDcsdNS3euyds25sL3ISSliVWFnYl4RRCsb0ZdN
         vatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178092; x=1727782892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9fc57nlwLbQdQ2sAc2oCWAZfOvWwEj+gafnpAGtImk=;
        b=kq+TRrNIV3ZMmALzXhX5jaTfznPsBHi9SrMjEzCgX4WVl3RDFrrcA6eHPDn7q0IgEK
         LIZiD/GJeBiXnxKIq3egwhLxFDVPNkXejPQZnjhEKd9uds3LvmvpBE1PoB+g0jpjaRUS
         fAXbm8QS+PazTDxVKvAwqVTjqufU/fmFAIbMs/aJVUCiqswVOZya6UhHhQBJsbF8XiQl
         v4CkJ/O3ePTjocR0eR8U9A6ac8MMiwwImX/tj6y1YjVdC6/Ei/VBukSN6iQWGbw4SVu/
         bPo+OoMjnhdZRG3opPNRy7S5ylSej5RJWgYg0OyzEouKev9UAHc35XB5HibGguVYQ5XK
         CAqQ==
X-Gm-Message-State: AOJu0YyE/ZfjB8VG/b3VBNiW1gr3nzBSl1HVSzwwyCKuCxEBgM5gpRht
	F5Q1IZSrsQwZy5txAlFFv2H3KvDTrDYbEi4BM99puI1GYcYAWYpoK//NVBUS5U70sG6fSOw+emp
	EodtALJACftlJKE/lsYOfAxI6WaF9oeSD4UtE
X-Google-Smtp-Source: AGHT+IFj8cqiMiY1AXVRvhe8rwF6DcWkYvkXpBkf6ecfSJZUFkRYRRAZL4pwU0vfwWYZ0ZEAuIkQNbltGVrr7/auBdY=
X-Received: by 2002:ac2:4c48:0:b0:536:54df:bffc with SMTP id
 2adb3069b0e04-536ac3201c7mr8557051e87.42.1727178091961; Tue, 24 Sep 2024
 04:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924013039.29200-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240924013039.29200-1-littlesmilingcloud@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 13:41:20 +0200
Message-ID: <CANn89i+Mg56hG_Z4N0KnJ=9c2mTHQAHTQEJ1dbagBpjhijAoxQ@mail.gmail.com>
Subject: Re: [RFC PATCH net v2] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Suman Ghosh <sumang@marvell.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:31=E2=80=AFAM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> Regression Description:
>
> Depending on the GRE tunnel device options, small packets are being
> dropped. This occurs because the pskb_network_may_pull function fails due
> to insufficient space in the network header.

I find this a bit confusing.

Perhaps explain that pskb_network_may_pull() is adding 20 extra bytes,
to the 28 needed bytes (20 for the IPv4 header, 8 bytes for GRE)

So, instead of making sure 28 bytes were present in skb->head, we were
requesting 48
bytes. For small packets, this was failing.

> For example, if only the key
> option is specified for the tunnel device, packets of sizes up to 27
> (including the IPv4 header itself) will be dropped. This affects both
> locally originated and forwarded packets in the DMVPN-like setups.
>
> How to reproduce (for local originated packets):
>
>   ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
>           local <your-ip> remote 0.0.0.0
>
>   ip link set mtu 1400 dev gre1
>   ip link set up dev gre1
>   ip address add 192.168.13.1/24 dev gre1
>   ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
>   ping -s 1374 -c 10 192.168.13.2
>   tcpdump -vni gre1
>   tcpdump -vni <your-ext-iface> 'ip proto 47'
>   ip -s -s -d link show dev gre1
>
> Solution:
>
> Use the pskb_may_pull function instead the pskb_network_may_pull.
>
> Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmi=
t()")
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

Please send a V3 without the RFC tag in the title.

