Return-Path: <netdev+bounces-201747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D6AEAE3E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D874E165D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846C1E1E04;
	Fri, 27 Jun 2025 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKs9Izyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1C1E0DBA
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000211; cv=none; b=I2OQmaa74fjVISCgUHByOpxh5IBaOyfFbYAx8jA3fHvj02w+atoCGG8sRScgpZNiZpuNFVEneby64BL+6LR5hJPpIvIEMh+YJBueC694lS3T3zeeyZUdVvygFXPd2vkG3FPrLqEj1OwATQEl/yvkj39BtLGJ+7I/SK/eqhdftFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000211; c=relaxed/simple;
	bh=Zv6mkUr/Euphf/sOKT6hhTVY3yWD7uxMOkBVG4NiSjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI7YaNGjFIYj2++g0mjAETi5pdNPg8oY9FAu5Isc8S4QHR/7I6RWKf3K2svsT0JKJn3Myhunk9beq/Xg8kx4PnPsKzyDk9dQW644bADL2wC4pTFZhQi4ORSbEWEVKqnp6AcBZ8/YRUl1s2XAEnRJvXwxC5V+E5D/UfoAiIyMhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKs9Izyi; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so3171173e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751000207; x=1751605007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv6mkUr/Euphf/sOKT6hhTVY3yWD7uxMOkBVG4NiSjU=;
        b=qKs9IzyiNAOboJEot+SNUHhEzuhHsvA1jIrxFy+w9JpE4J8quvwyKmj0wVXO6vok3p
         A40oWC1L+GLfOn2SEfMN7ogMIC2PZaMu8wIlDMSsZ/HYiPsjAc/LjQvLuT4qNltGGBEq
         1yEF8hF4bt0M18zYjpuZn4RyeaHPROIVQE7K3vk1O0aEUh/MdKAMPy98980Uww5duXUr
         K3+koPksfmFpYccegTg7+GK0+mOtUvIFDhC2YeFlPqoJCafJbFCA8n8urCJ5s9Xu/svM
         EQizxr1YsSovG2+jTQiZ1D6jgyNHu60n7pPkit1lbgJX2EAm5mSfEuK4TSV6uB8lmnzM
         aNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000207; x=1751605007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv6mkUr/Euphf/sOKT6hhTVY3yWD7uxMOkBVG4NiSjU=;
        b=dAnpFQqSpqlFtT0+APoV4iU7CT7NlPG3Iwh5py/WvpzlXWzB5rKL8BFJlK7zzLnXD9
         ChI+J4HGGAVZuo7H2uH95JgpiwMGUOTDj+KDynRdWx33WKq47lB6aW84RtbrqI0LH1e8
         MqvaOUzwf4xs0MB/3RtzmEyNoEPTnMWKwXSsGB9g7QGGdXWZe5MvUGuOTBwG9C13TqMR
         l7jzryRRZRBrOyJe3qXcShWdAoHoceiItHzDx9MbSy6h8lKTIiOTgm5pVId8f1+aaqG0
         FW2odHHpgGTNtwd4C3nlNzErp8LalJlIxTKfKvUYEzqY0YjKa5T5Y8Uoha9/KomF1RFy
         zJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI37y13waFZFyfoGKka24WT/M+xqnkrVVt3YRukIQftbhBAkOVK87cxku23Xsm531TLex6sQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5cbkjDeQIpesyh7JS/NXvLs/u3PfaSUeuk+H4GcpPSKrEezL
	pq1WGr/ptCDG11FwzcjPHfcF5VF46c66OTyINaRJtMKeKiTWp4gAFk8+O7Fbvq0lIRpff8ptQDe
	OuhbxQu70gmBUZ4cDNRT35J0nl+0hiDRg30x2HSY=
X-Gm-Gg: ASbGncsIx8BQ6eQGIxR95KQxR6hsitfilxrgolgDBx1UNO6Pn3JfD2/1TqNCYty6WK6
	67TYKdnvxtYHREWZgUXAyeBuI8/ceNOIXm3AXeUFMqNIGPcSZaA8864kT32hl7ZNaQLiEIZ9dxY
	iuYFznQVkyaPb7B+99SAPAr9EGu8OGqdy/N4faIb52krI68UHCJwuxmFN0xeZXoxgMjgT06bNZ
X-Google-Smtp-Source: AGHT+IG1WjlZkyIbsccktZjNQrYIsbUfTY10eKJpeHSrD2SHzIU3QkMBbhEO25oUaZ630Tmra/pi6PFRBg57ie5hXyM=
X-Received: by 2002:a05:6512:2353:b0:553:2159:8716 with SMTP id
 2adb3069b0e04-5550c35c0famr449258e87.26.1751000207239; Thu, 26 Jun 2025
 21:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182951.587377878@linutronix.de> <20250625183758.187322876@linutronix.de>
In-Reply-To: <20250625183758.187322876@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 26 Jun 2025 21:56:35 -0700
X-Gm-Features: Ac12FXxThCCAUfCE9_7KpBD3nksP3SCcmnqrN5H6dj6J3m5deRuxRVa_3JHc-uY
Message-ID: <CANDhNCqXP-S_ebrHeGMGgE+vqMaAjOzC7p2hzRxff8JrRrpkzg@mail.gmail.com>
Subject: Re: [patch V3 07/11] timekeeping: Make do_adjtimex() reusable
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Split out the actual functionality of adjtimex() and make do_adjtimex() a
> wrapper which feeds the core timekeeper into it and handles the result
> including audit at the call site.
>
> This allows to reuse the actual functionality for auxiliary clocks.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

