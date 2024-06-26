Return-Path: <netdev+bounces-107063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756099199A3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD821C213AB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1B193061;
	Wed, 26 Jun 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4kjWEgL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7314D6EB
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436267; cv=none; b=qpK0dME/qECjvVbX854fRxxllPerMKNT2W+gEQvn+DG6ZzIUwH0MYQTvOw+hvpoPRuHE2rGjS1/CdKofmCN8v2XO96+jGi2BZJwwU8vCgoJ4gZnHRfb5R26xB4N1MtqY6DRoLIvDdNz4lexrtTi6Nn7yIMMSpI+8Nt6ItFzCN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436267; c=relaxed/simple;
	bh=13Rp9MaLh2+GJEtsIiriMpNw8i+N2M8Kb7TgRHxLpic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQ5M4Qwk5efGJugQb7hZvw1E2VSZIf0ChM8dBn7EV493/ZfLntZnMqvo6Z2VXy8v/HzjSQ8+Eb34iAeWKuvinLb5sttnmbq2WJL4ZPWNN8nu978xUoZtJgABR4mcq2Xs3k1+r5YgzecCCCfqEXz2VTMnYxEegVN0Nqx1iNoShP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4kjWEgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719436265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=13Rp9MaLh2+GJEtsIiriMpNw8i+N2M8Kb7TgRHxLpic=;
	b=f4kjWEgL1+M73QdkDcZpQvWu+ikm91VYrIKTjbiBiQElkr+1tkgl38DbCPeQGftUpKgHJ2
	iFHwS0h2zMbXB+93JnGbEWV2OZAU9ouHNf2OM1OKXjo2daJ86g9bBU4keioNsj91KlCoWD
	UvAPdfUqGrssCTR43PLRNWn9+odTe2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-gTBCCYtWNvWUtGKiumgfhQ-1; Wed, 26 Jun 2024 17:11:03 -0400
X-MC-Unique: gTBCCYtWNvWUtGKiumgfhQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217f4b7355so8089915e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719436262; x=1720041062;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13Rp9MaLh2+GJEtsIiriMpNw8i+N2M8Kb7TgRHxLpic=;
        b=pNp1+4USwMzbb+T0v8yMWaOy/jpnu8udahv/BgqcomPIaIrjCdJ2Ror4hfTOc6QpEC
         8Rb3i76CK67w7i52BWcKzVKd3E2MTEOU+ppfvP90ingsrFvsZTWmP6w6azMNX9zcVZHL
         hUJVvkl4Rox8k2241Sgl/3NFBEkmON6xVPedX+pebxHJ8CIuv4TX6zmupYxK13F9F40l
         dnu6LaFdtEQHEXS+/ufqDImh1+pKUmTOJqzSEvPTeRtd881O58dAZKNMxhRGPRxX3ZRO
         sHVGhx1pHcLK8DCp05GrPIdUNuoMDD9SyKMWUU5yN+J9xQrpVTNYxHryHr/AsDpUgw9n
         C7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaABP9C+CuMWk+qd8i19F3XfdFrDPbRT1t3wZr6ueYP1RwvmTx/IbGK8BAhT8LkSttF0tjDPd5k2JkgdWpXoQF/8CV8h9/
X-Gm-Message-State: AOJu0YycZZMMehJbQprhxQK39Co6oWUYKzGuX1sIReOx4x8or+5OH95H
	/AwqQ4OwDhjI943aBA9zUoCxqdglhGluaW4KK72wa9/CYX8Dgcp0HVc+KecFxwf2GQWFo6sPoYK
	rDicyRJW7HcV6AL/27zwarM1LeUSV3C0GzSyQVUV/xiTqUs1g3WGE5A==
X-Received: by 2002:a05:600c:3c9d:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42491783f09mr70158445e9.3.1719436262468;
        Wed, 26 Jun 2024 14:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpGTJ4ZgN1opzTmMDVu43mQP+Px+64zt8PGKmxUonBbPic4ZA23wSHzAGrhclvYcXpZbYYpQ==
X-Received: by 2002:a05:600c:3c9d:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-42491783f09mr70149845e9.3.1719436241749;
        Wed, 26 Jun 2024 14:10:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-12-248.dyn.eolo.it. [146.241.12.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725b092fc4sm306522666b.35.2024.06.26.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:10:41 -0700 (PDT)
Message-ID: <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
Subject: Re: [PATCH v1 net 03/11] af_unix: Stop recv(MSG_PEEK) at consumed
 OOB skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Rao Shoaib <Rao.Shoaib@oracle.com>
Date: Wed, 26 Jun 2024 23:10:40 +0200
In-Reply-To: <014f053032241c56a0f76ea897caa6a08d3b3f7b.camel@redhat.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
	 <20240625013645.45034-4-kuniyu@amazon.com>
	 <014f053032241c56a0f76ea897caa6a08d3b3f7b.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 18:56 +0200, Paolo Abeni wrote:
> On Mon, 2024-06-24 at 18:36 -0700, Kuniyuki Iwashima wrote:
> > After consuming OOB data, recv() reading the preceding data must break =
at
> > the OOB skb regardless of MSG_PEEK.
> >=20
> > Currently, MSG_PEEK does not stop recv() for AF_UNIX, and the behaviour=
 is
> > not compliant with TCP.
>=20
> I'm unsure we can change the MSG_PEEK behavior at this point: existing
> application(s?) could relay on that, regardless of how inconsistent
> such behavior is.
>=20
> I think we need at least an explicit ack from Rao, as the main known
> user.

I see Rao stated that the unix OoB implementation was designed to mimic
the tcp one:

https://lore.kernel.org/netdev/c5f6abbe-de43-48b8-856a-36ded227e94f@oracle.=
com/

so the series should be ok.

Still given the size of the changes and the behavior change I'm
wondering if the series should target net-next instead.
That would offer some time cushion to deal with eventual regression.
WDYT?

Thanks,

Paolo


