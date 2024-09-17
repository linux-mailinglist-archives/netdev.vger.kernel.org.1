Return-Path: <netdev+bounces-128689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43CB97AFC4
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127761C220F7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2C165EE4;
	Tue, 17 Sep 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhwOnf9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903515F308;
	Tue, 17 Sep 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573201; cv=none; b=X47dOoVlSJQmv9V19mCjtwzOR3Q7w8eYoDczZuAi+RZFUtjNQvy7qMXgdfFkbQMbCSP41ODlBz6zHnJuMRljAmDKUwEjhwrz3MhRrxhqtyzDxt5vLTqakIIPIUIEiMAYGc+eZNIU7RhzGOnAEhOMYS+7xaOT6ehAK6k1pkC9nD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573201; c=relaxed/simple;
	bh=ecEGHgyhHCw7IfP+WwTd7Ywh0L4XyrtJjcE9jri8+XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6IHOs9T65oySPyUenAMJM8PWKsQ+uKyAeqfls16m4wFtUxacKMO5u4qi/s30GWdEZUXnACidWx4z+bcoZT+p2GZYhKYz5QLX5zGUExllW5SDsfginSdLa6r4Bp+A/TF32jTCmF28ablAss2BnyHCNL7kPUe653Tl5hYeWYX5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhwOnf9Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7191f58054aso4514408b3a.0;
        Tue, 17 Sep 2024 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726573200; x=1727178000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ecEGHgyhHCw7IfP+WwTd7Ywh0L4XyrtJjcE9jri8+XY=;
        b=jhwOnf9QJn6ibWg3ispil1MnMmSjK8pak/Zg1WZbzBSn3BZJOx8Ws2/EO8TZwqamsY
         Q863aFpp/LkiNSfESGM/4G0hIuApQkvKR1B3Da1uFLXO8QewHdJ04rqI3wpKT89pSXiW
         Unh6reoS70mlgN09adnwHqjJpawTi/5uB3vpe5vR0PDpWGLMNAG0Y1USde1QGTm1ZHoo
         UIcrbilKUdBhDRaANF2UcU73T2onwlSaHMXbr5oDzQqx5wRqudAIRs3+6eT8Yo3SjPqT
         LbMJs/L2D+H3CxB/C6VFnqhR7WODn/+71l2Qq/TaG4vFgkUVCNXu4uKCB9BMMelWITp8
         XgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726573200; x=1727178000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecEGHgyhHCw7IfP+WwTd7Ywh0L4XyrtJjcE9jri8+XY=;
        b=oJNXFtTGt1xgEcGS1bgA9iJYWJ+/vjPmrK8us7/nu3SPGOLC8kCVdf5QXcqkPeOlyl
         e3l0+GZFFreoyRDZfP+zvOjzHJFz1BKQKhyqal21Yq0rhCDAYcvhTVHKpPwR2xKin1W4
         c/n87T+lcsstRH9FgedJzs0F1Kya2NyNeuDTwElVsdzLgzaKgjoguObKwZ818nC42SL2
         SPQQDVGucmjq9iqUqY9I7ttBRHkyBNo3dnHbqEgvWPCWmgAtWZhQx3GbPHZQgK/e1MrU
         zF3+KearvqcFvRrjO4zqwGbZeoExoglosM6mKZ5Hr7QVFqxz7aHvymeD2BsrHYYy2sOh
         KiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoBoeImy+BdwLZRRrTBCezQQpgSPGYEPvC1M00x7kHps+3A9f1UpFemLo4tNAUzL3MDDXdd5xQ6U2Xw7E=@vger.kernel.org, AJvYcCVigD8b7INBU8ByVJwVXAZdDekHfdyMbnBQlXFke2qFyX8HB+nWSR4qc+M1c9rg1wP4gcurVJy6@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRFDBUQF1g/QAFmpUWlNtp1e4txnmow2fDX4qkqbp7FEK75Dw
	pIgXATeMRoNeUPoOudclMzUMfMMbmuWEnyxFCoNGCG5tiYQqcNhlNgTKZUUE8b9YoPZLQools6F
	qWhMhy60luzWBFLBb5IvvfJzE1Sk=
X-Google-Smtp-Source: AGHT+IHCMSs5WXFsoCgcNfwmckmR2l9g1Zpnl0GggwToNMhM5h5CcrQFTEe88Wn/ywZnZoFeosxT6h5vlyJjHf6q9GU=
X-Received: by 2002:a05:6a00:2d15:b0:717:8dd1:c309 with SMTP id
 d2e1a72fcca58-7192606d3c1mr24904345b3a.9.1726573199759; Tue, 17 Sep 2024
 04:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmfFt1oP=r28DDYNWm3Xx5CEkzeu7NEstXPUV+BmG3F1_A@mail.gmail.com>
 <CAHaCkmddrR+sx7wQeKh_8WhiYc0ymTyX5j1FB5kk__qTKe2z3Q@mail.gmail.com>
 <20240912083746.34a7cd3b@kernel.org> <CAHaCkmekKtgdVhm7RFp0jo_mfjsJgAMY738wG0LPdgLZN6kq4A@mail.gmail.com>
 <656a4613-9b31-d64b-fc78-32f6dfdc96e9@intel.com> <CAHaCkmfkD0GkT6OczjMVZ9x-Ucr9tS0Eo8t_edDgrrPk-ZNc-A@mail.gmail.com>
 <534406c8-80d3-4978-702a-afa2f33573f7@intel.com>
In-Reply-To: <534406c8-80d3-4978-702a-afa2f33573f7@intel.com>
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Tue, 17 Sep 2024 13:39:23 +0200
Message-ID: <CAHaCkmcZ6tqj8zJjLERO6Ze4SrKNHBpGL8aOLwt6CsX8b4TSFA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] igc: Network failure, reboot required: igc:
 Failed to read reg 0xc030!
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 09:03, Lifshits, Vitaly
<vitaly.lifshits@intel.com> wrote:
>
> >
> >> 2. What is the NVM version that your NIC has? (ethtool -i eno1)
> > $ sudo ethtool -i eno1
> > driver: igc
> > version: 6.10.9-arch1-2
> > firmware-version: 1082:8770
> > expansion-rom-version:
> > bus-info: 0000:0c:00.0
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
>
> I see that you have an old NVM version, 1.82.
>
> In the recent versions, some power and stability bug fixes were
> introduced to the NVM.
>
> These fixes in the NVM might resolve completely your issue.
>
> Therefore, I'd like to ask you to contact your board vendor, Asus, to
> update the NVM to the latest version.
>
I'll get in touch with them and see if I can manage to get the
firmware updated. I'll reply back what happens and whether or not it
seems to fix the issue (after a while) - thank you for the
information.

- Jesper Juhl

