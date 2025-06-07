Return-Path: <netdev+bounces-195519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7CAD0EB9
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310D43AE23D
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D21E8326;
	Sat,  7 Jun 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVQKsZVX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2451D5CFE
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749317278; cv=none; b=j/0+RZQbDzMaaxpu3f6+GG/sjM3C3OLuK0sUTFMcbVEUJNWZcyDH5W9NeB6s8LdQwHuM7dnNUDFdANje34MeHXQLU6fmdw0BJ45GUCyBILMuWO+su3zqt+6TQV2jo5Wy1/vNJLpBwzmINERKchW2EGeevyueMzGFMk/tqcQ4rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749317278; c=relaxed/simple;
	bh=cD2FhQ14affurROU12rOLT/My6dz8ifCZ0xwnHu0jPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOMFIoNWujsIlHOoHjEh8nxKICvt4/Iy3BpLy/rcZtelcYEWmErHf3aCsB7XxO7mXPDLV7dfb9pIpUHJ2KT6Eb+KqGovVWKV/yjfVmUeFFx67FmGZkv+nyZYq5bJOaLqGFMgpw7COJ8QRXMSE9vKbPF4S4DddZQagDMD9AxMB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVQKsZVX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749317275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD2FhQ14affurROU12rOLT/My6dz8ifCZ0xwnHu0jPw=;
	b=UVQKsZVXLAGj9MbyGiuTBFgM9BvkB87dbkGw4whU3uS6csDKcbCjIt9FDULokH9vjEV5vm
	oF/Y2H5aPtcF0vMtPlqYimzo07SZO69P8uHQfZ3EG7igj6wZEQypBbQ98nh88XNROtrFrP
	SriDKj+9zSNPnjgX897YQcDbZYZicHc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-8uaOhYa8NcWZvfUBzuPLHg-1; Sat, 07 Jun 2025 13:27:54 -0400
X-MC-Unique: 8uaOhYa8NcWZvfUBzuPLHg-1
X-Mimecast-MFC-AGG-ID: 8uaOhYa8NcWZvfUBzuPLHg_1749317272
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32a64f93c68so19945831fa.0
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 10:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749317272; x=1749922072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD2FhQ14affurROU12rOLT/My6dz8ifCZ0xwnHu0jPw=;
        b=hb74lkV4U/97T91SYniP5Ett2oiOArmxli55Ysa26G0z+vsZ9NMimk4fW3121rKglV
         hSWW4jFRF9nC0SGDvL2PfAGrRt0poFl+YYQdp2dzTbZ4GqUjhMeQ7PtCB2OBhbMdECiA
         CH2INi3u+Xr3ZMDoRM5t3HTENc5yWoMABFMPvOOqW1DfOqDhhiD4Y6vONMu0TdpY4q6L
         ftlrSc3p6BNiXZK5C17wmVY3+O2iJ6espsTsD+LzEMuYyMHB24H3X16xHCUyVA54mGZF
         52PKy9JM62FdbEScT1wlhLupF+PtzC8qCGE3aHdsApS+nRNP4OuuZPjxxYRjzKJXeruZ
         Tkkw==
X-Forwarded-Encrypted: i=1; AJvYcCVCPWJMl+wUw8wBQXJgmREF9SU/Ndw6I1uoL8diAaCmYilYX47jfdEul3gJB/3sWL9wDGmkGtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy895nTiNO1J/Yn/vG8Vw1frJ7hruYyG8ALCR4JHr0Y11KGpZ3j
	vqGYoQ9WeWcp3OeOhgBraadg/N81xaL9UekDngRDIPfXCDL0ndn2GLfE4epUgrxSMIhXHrkZByD
	cAAM/n0DcUL3s9MuBp9Le+PrF/bBT3j9vEqRXcwrN6qeY6mKAqif/E05G+uDDXt91krg6a/4Xmr
	mVmzrIm5rlCwfvzM00FQg7nB788bfELiJi
X-Gm-Gg: ASbGncvi1a10B6L/qOMVR37LncDPI95x/swsJlb1BWt/5h8swVA0J/md8f11LHmfGnZ
	bxFBrFzlDd1Tc286KaQD/i/pA6hb9H0OlS8bJEgKV2yLfpM650NVc64/H6yGtygLuSqo6K2yJBm
	L8eDVINDcHhtEuMs1Y/bYUtu8KLe4XqpnwpJ2KqA==
X-Received: by 2002:a2e:a7c1:0:b0:30b:f0dd:9096 with SMTP id 38308e7fff4ca-32ad11c45eamr32017231fa.12.1749317272357;
        Sat, 07 Jun 2025 10:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zpwj9G1edp2Bsl1ab3woHoEWm+jazmDLnjVVK6XqpM0EucVPM8pz8yU8LxGQzUjl1q7U2w6L/fGRgVTbAAg=
X-Received: by 2002:a2e:a7c1:0:b0:30b:f0dd:9096 with SMTP id
 38308e7fff4ca-32ad11c45eamr32017141fa.12.1749317271950; Sat, 07 Jun 2025
 10:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603190506.6382-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250603190506.6382-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sat, 7 Jun 2025 13:27:40 -0400
X-Gm-Features: AX0GCFsGLLw1WundbTAUWIBMgZmvFwkloh8KHcWuqaZA4MvUrjqbJ5laC3-Fwmo
Message-ID: <CAK-6q+hLqQcVSqW7NOxS8hQbM1Az-De11-vGvxXT1+RNcUZx0g@mail.gmail.com>
Subject: Re: [PATCH] Integration with the user space
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 3, 2025 at 3:05=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> This PR introduces support for use space tools such as wmediumd in the ma=
c802154_hwsim kernel module, similar to the existing support for Wi-Fi simu=
lations via mac80211_hwsim. With this addition, it becomes possible to simu=
late interference and control transmission behavior in IEEE 802.15.4 networ=
ks using a userspace backend.
>

that is already being possible by using raw sockets, what is the
difference here? Depending on your use case it might depend on what
kind of mac instance "wpan_dev" is created on top of your phy. If you
just want to have bare phy access you are looking into monitor wpan
dev types and using AF_PACKET raw sockets. I already connected user
space stacks (only for development) with it.

If you want to have ARET/AACK support, the answer is more complicated.

- Alex


