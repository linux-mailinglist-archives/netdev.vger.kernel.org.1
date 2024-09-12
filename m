Return-Path: <netdev+bounces-127811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBE976A31
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139F6B20E13
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C401AB6DC;
	Thu, 12 Sep 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdwqLfYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B091A7061
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146851; cv=none; b=JRhOYJppWIW3dzELjYVBAJwcM5EISi+ShKaA/4/JUaaJ4QqAhvlhENsHU5t47eomPSuGmOz53Mqjfh7UDx9IIfUe4JD/mEX+cZoVkaUtCkUpFqq3B0TRWNdh8LRzCTcDqfL3GkUvTaLBIVZtQWUPUpEa1+zl3Mk7XhbAnDkItxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146851; c=relaxed/simple;
	bh=EahhHOZt8keeU4ar/K3KrCm52yfxkzfLyfHmsF6kR3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRRUT0uYt+yw6epxFr/buEOvsbTyPmAQUN8GWzXtTUL8l6q59EW9qMV3v4f6ydjeUeA3Oxn9zhmRlC9joHHxJfh9wjqb0Z98IYUcKnuG2vBiI7nfScDvoetRD7wASivbdrmlhxUZlXZ9vp7MMmgbBjD000ErEON/rdBE3lcnyNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdwqLfYt; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db67400db4so9132367b3.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726146849; x=1726751649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqZthTFDmLUBDICo0tY9ep01KRkPGioFv1nuqT38niQ=;
        b=BdwqLfYtVFWVw9pOzr80hvnMV1wkEhIp1+7W88IjrY1XrbTVFK9nz5aKEGDXGpAFF4
         UudSSMSkDE+pen8CFuJ0QE9n9rBr/gbFl+hg3Ge/KtLCqTGhaHqyUo6YeSZFE3jdFKId
         oh7O/CF4Xd7t4JFYj5vefMp2XqZOVjJYc+Gv3Qvm2UMmc1nmmqgesAqsV9G17cfmO/c8
         YkGCXJ7qaTzFiLXaRuI0G3J2P5ulHaEWi+WHZItoa074afJpVN2lAnm9Wu5g/5C6mcux
         IfgoDu6b/47Ffyq0Sr7jYGqEY+Su6uvMWuDtLj9uB32TGsxc8RSetTuidZ2Z/Ek5W+Tj
         gFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146849; x=1726751649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqZthTFDmLUBDICo0tY9ep01KRkPGioFv1nuqT38niQ=;
        b=WOXBbRwtWzlH8b237UL1iKc6hmpsuu2A3rMOApIEGUHWoCfbTRR2s6saca0IhkDFm1
         t4oYuL1cQ8E5hYGlbyu7tEWOD+U35evOqTvlfY4uyyA+Dm/BpW5CYhW2uLZwzEUvIhLP
         VU+GWcE2EjP39HZUCJwnbqYkgWRPUOi27Nfj/gJOosYHbH2j6T00YI7xwMPpBSLT301t
         hQkOBpBdnU78oIbvNIiBl/khraKJt+Dw6PH0xo56UnbPZ96E8m79zDYpOIOM9k1BWmPv
         Jac2uLwHNPVTAJnd23DfXYxiTcrYkXZg3eA3aZk+GvXfcU9OrNSDVU8GX0KrgeSzE5JC
         csmg==
X-Forwarded-Encrypted: i=1; AJvYcCXc1PasNitN8QUcC7Vz3nc5kZ6P7l4ezvzq3uxZQ7QWFHNF8K+RI/O1KiBmtsL9diLI9BWdbA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyNmxzuJ4ILSMBmhmiiuQ5s95nle5FXoh4mV9tC0wUmFx9+dy
	7jEG7FVd3J3ap+VuOUF8Fijk51q7GxriVtevExQDxiegHdgAX5JWpwrvo16/e5NIG4BO9zgxiyz
	ms2SxXKSumWc4Fon/a2JZEG9paSHg3bfgbw+/
X-Google-Smtp-Source: AGHT+IH1d8eCzkBWXAFxzhfG/a0ZEazgbphcGtDN1lb8mUPmfqNakNE04uuDzX1r3b0WC+e6GWV0vC/FOmDvoreDt3Q=
X-Received: by 2002:a05:690c:4442:b0:6af:8662:ff43 with SMTP id
 00721157ae682-6dbb6b9da3amr26148847b3.37.1726146848448; Thu, 12 Sep 2024
 06:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
In-Reply-To: <20240912063119.1277322-1-anders.roxell@linaro.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 12 Sep 2024 09:13:30 -0400
Message-ID: <CA+FuTSeFg5AcSxdp4AKi4iPROF8r2dy2BhaMKpCrFD8FM3G=Ug@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Network Development <netdev@vger.kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:31=E2=80=AFAM Anders Roxell <anders.roxell@linaro=
.org> wrote:
>
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

This target is automatically built for targets that depend on it.

See the commit that introduced it, b86761ff6374.

+++ b/tools/testing/selftests/Makefile
@@ -116,6 +116,13 @@ TARGETS +=3D zram
 TARGETS_HOTPLUG =3D cpu-hotplug
 TARGETS_HOTPLUG +=3D memory-hotplug

+# Networking tests want the net/lib target, include it automatically
+ifneq ($(filter net,$(TARGETS)),)
+ifeq ($(filter net/lib,$(TARGETS)),)
+       INSTALL_DEP_TARGETS :=3D net/lib
+endif
+endif

If you believe that it needs to be included directly, please expand
the commit message with the reasoning.

