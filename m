Return-Path: <netdev+bounces-195526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E654AD0F37
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCAC16B4AB
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF791F1905;
	Sat,  7 Jun 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdRor+Y+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FA1C5485
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749325872; cv=none; b=fZrAzZ7K5ZF/syeC7l90LIRAwJzWZUWOp1kCKsa+Ps2TnNKRZaTi5UTpWIv/jE2g3cYveMoIt4+RqpG41zwNzp9e8DYW8HM5rEzJ0dhzcICrFkX/mGSn65O75XhScvWGjPIf/ukNpxklDggNkyfHfSnQ5TD2xmmZWvU5EsXVAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749325872; c=relaxed/simple;
	bh=PJtI3u3w43f+Q/AwxyRIbrUFwg/SgiiaB7YubIhVZM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjK/lwQcvP0YGc6aJFyFfzTstIxNG/Y1Me5TH8cQFsvEhNuIk0GjJKCbpE7mE6h+gxn1lWOBpnVs0OPWilXt3+He8mQkZFkJUoND1G92EiEwZ5Xmy18MY4yW0W7tDaeakVKMVeVQtPTT1JCoYKS5ThvHq1BTto/pxRUN9C1u7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdRor+Y+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749325869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJtI3u3w43f+Q/AwxyRIbrUFwg/SgiiaB7YubIhVZM0=;
	b=AdRor+Y+9k45sbRD6MfDbext+Pup8HmQFp4oC37Jk76IET5q79fw0uMDUyCLL5yIpO+P5e
	n9TzUZbVCz24vckMkGpW3cdazgvybZeMKBbtF9Nu8qPQZXs3hUHvu5ab0Ew9L909W5LLn3
	cbFIhJxknXMm0zp0NRWQMT6R3LodwM0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-luOgcjZgPEKvLnz89eHL3g-1; Sat, 07 Jun 2025 15:51:07 -0400
X-MC-Unique: luOgcjZgPEKvLnz89eHL3g-1
X-Mimecast-MFC-AGG-ID: luOgcjZgPEKvLnz89eHL3g_1749325866
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553339aff5dso1304340e87.1
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749325866; x=1749930666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJtI3u3w43f+Q/AwxyRIbrUFwg/SgiiaB7YubIhVZM0=;
        b=mXnOFY6HtIF4XbZ2jN5rR/c+GYhMAGkP8ductztRITXPi1j+k++SN+/pxxwFPew7mK
         1aB7uxpDMmCsqNvS519R+rW3NJgCMjVolz3a+kKD69iXVhzK5lHZaNMORTjdap9/F3wv
         hv/uNNNcNFJBIdM4b8j8qv94Z2EJ1QA0VVVIZBjVuI17SWq4as42YTQ2qdbr0bn6tZQZ
         gkp5tcDRUpdW9abrv+aRPe+yC5nMyGyjnFYz+nC1E0PaU2wLtj7BYvmLFw6POMU5IEdr
         ifj70Uf9hJtEDpBUh57bpiJCwdBpYzdcbS42qKPlhjTCt71C8ySYPXeWASC4hBzs6LHL
         w1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCULOp0qUF/ehqqg3bcO0aiNrw4FG5jSVF4Q31scSwIBR85Wny5S+XZjk7zpqYqWMic2DXWSY6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCPD3au3yYTBVatUgrs2Q/wjVEPgwLmD1OHMW+6rAOdcvVdnt
	KzM3f+4OOs233wL4GsywCG0e4wXPKQ+R+0UdKZr9EeBD8oJ4A/7URfBIMvCmADI/MUEIGuSMrBE
	HGMC7YZKCxMgIcS+JuRtRRQew15EoPcb1HyCHYX64Np8mJn57/5Qud9B2VaZDaArtHjNhA+SNQC
	QQDVXe/0Tdr6XBw9KnzaQsZ685GwdNnrXJ
X-Gm-Gg: ASbGncvVC4fPpu5bGnksBvdhtWGFbsZ86rI155YkormlVnGXPTsc0T2VFFVe7JkiGRF
	J+syCKFmvLQuHusUy8Y4PZ6XSbqzt4kQQXBdaQ6zDwtqmhnqg3xHj9TWroLAkrhC86TDosGFMhx
	VebCrhliVCHjtGdPoxIsy5LfUwwSs=
X-Received: by 2002:a05:6512:3ba7:b0:553:3422:c39d with SMTP id 2adb3069b0e04-55366c3054emr1930635e87.37.1749325865826;
        Sat, 07 Jun 2025 12:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKvLoXtMqhW4ZBMny/mnilpsNHazF9HLWqQIhcv6NXvC2zdfIpJorfvGyknZskavyU3dfkGaNLkGaM9DulGCQ=
X-Received: by 2002:a05:6512:3ba7:b0:553:3422:c39d with SMTP id
 2adb3069b0e04-55366c3054emr1930631e87.37.1749325865349; Sat, 07 Jun 2025
 12:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
 <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com> <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
In-Reply-To: <CAK8U23a2mF5Q5vW8waB3bRyWjLp9wSAOXFZA1YpC+oSeycTBRA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sat, 7 Jun 2025 15:50:53 -0400
X-Gm-Features: AX0GCFtl1MAZki7j4uB-yOTTn9Jm63I96e8hVeG3yKGcL8Zpb2cD7i-nody9YSw
Message-ID: <CAK-6q+iY02szz_EdxESDZDEaCfSjF0e3BTskZr1YWhXpei+qHg@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 7, 2025 at 1:47=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> Hi Alex, thanks for the feedback!
>
> You're right, using AF_PACKET raw sockets on a monitor-mode wpan_dev
> is indeed sufficient for user-space access to the raw PHY, and we=E2=80=
=99ve
> also tested that setup successfully for basic communication.
>
> However, if the use case focuses on evaluating realistic wireless
> scenarios, where connectivity and interference vary across links. For
> that, we rely on wmediumd, which integrates at the PHY level
> (mac802154_hwsim) and controls per-link delivery based on configurable
> SNR values and propagation models (e.g., log-distance, shadowing).
> This allows us to emulate asymmetric topologies and partial
> connectivity, something raw sockets alone cannot provide (or can?),
> since all virtual radios are fully connected by default.
>

It sounds to me like you want to do some specific 802.15.4 things and
the raw socket interface is too generic to do your tests.

> In this context, wmediumd becomes essential for simulating:
>
> - Packet loss due to weak signal or distance;

There is a generic way by using netem qdisc and using AF_PACKET
without PACKET_QDISC_BYPASS, should do something like that.
If you really want to do something else there or only act on 802.15.4
fields and you hit the limitations of netem then this is something
netem needs to be extended.

> - Asymmetric links (e.g., node A hears B, but not vice versa);

You can do that already with mac802154_hwsim, it is a directed network
graph. A->B and B<-A need to be there so that A<->B can talk to each
other, you can drop one of the edges and it is asymmetric.

> - Controlled interference between nodes;

netem again? Or any kind of tc egress action with a ebpf script.

> - Link-specific behaviors needed for higher-layer protocol evaluation.
>

That can mean anything. I need more information.

> Additionally, by inducing realistic transmission failures, wmediumd
> allows us to test MAC-layer features like retransmission (ARET) and
> ACK handling (AACK) in a meaningful way, which would not be triggered
> in a fully-connected environment.
>

There is no ACK handling in mac802154 as it needs to be handled by the
hardware, but I agree that there can be something similar like netem
in 802.15.4 that only fake reports about missing acks, or failed
retransmission to the upper layer. (whoever the user currently is and
there is only one I know that is MLME association).

> Let me know if you'd like me to elaborate further or clarify anything
> about this.
>

I am not sure about this as there exists generic network hooks which I
believe can be used to reach your use cases in e.g. tc. In combination
with a ebpf program you can do a lot of specific 802.15.4 frame
handling and do whatever you want. If you hit some limitations in
those generic hooks then the right way is to extend those areas.

Maybe the "fake" ack reporting is something that hwsim needs to
support as this is usually implemented by the driver to ask the
hardware for.

With that being said, however there are so few users of 802.15.4 in
Linux and adding your specific stuff, I might add it if this helps you
currently... but I think there are better ways to accomplish your use
cases by using existing generic infrastructure and don't add handling
for that into hwsim.

- Alex


