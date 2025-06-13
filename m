Return-Path: <netdev+bounces-197328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1AAD820A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB31898227
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 04:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A811F4CB5;
	Fri, 13 Jun 2025 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o9EJL1b/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D461F16B
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749787527; cv=none; b=HgZAh5jEDqkJKhZ72COwbU/wqxt+h4da+lF4FtYi9zaKN+xEIkOzdnz7QBO1NzU+DkK+pBrjbE5b751O4tIuKS82Q9ukgvmY1fGksIm+P6UD7qTiaGzQWfG/SgRpxmCvYplu75SBL3ADi+lR8X93WwkYGoZr/phtTvtIgeae8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749787527; c=relaxed/simple;
	bh=RS1QN8dDZg9GoFTP2NyqdcsEWn+y1hIeX3VX3C8oJHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrBAXBiIwyywqDIfsREfeATKgyv++ieDu93Mj2Mk4MHhiaRgMQAuUkmXI0FkvBu2IlKg08pg7zs/83cEThKdUyB4r5N2prAP0IvMl+b+C6Jh2vkZ0uyJzGt+etrzI49D6ZPHoDw6lwYkyaXuQOKLkQq4uEQuUce5cui57Jzlu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o9EJL1b/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553246e975fso1879276e87.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749787524; x=1750392324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS1QN8dDZg9GoFTP2NyqdcsEWn+y1hIeX3VX3C8oJHQ=;
        b=o9EJL1b/+MKRjZWxTj3VqZU36v0t/66/NFDhp5FVv4zEEYGX/lCCQiekueABSx7aPE
         IvKu1GI6oWW6OU/tP9b2CUiWqCoYSavSKUKHexa7qz7v3weCjJiq1x7zaKbnKrMp97eK
         fgiX6vy8r6TaGzSm+F05GBTR6F+P+2Of96Whb5eP5KlVoSSWiTlBw2CEo7ccWc08jMpZ
         e192637qlOSHLGbFPMisPGMFU5hYZAg+MEBLNP0XjjvrRvIFnZc0I9PsRkCHrLWCwSrF
         bO/bvq5Pfl8lYUguGm2zwZp7qt66bWCpTDWK5TdWrxmBycJOCkmDmdVSlkn1qO7uO6p3
         84qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749787524; x=1750392324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS1QN8dDZg9GoFTP2NyqdcsEWn+y1hIeX3VX3C8oJHQ=;
        b=XWJSEra7lS+S2KQkeD2165TDQKc3kGYH3htfKIbi4CTk8OkQ/aswWGNYx5US1rcq5+
         DboeeDKR2//Iwx6e5uWvEWMnGbsmaHvHXoArVfa0H8F5Upz1I7n56Honl07hcnCcawc8
         7szMyiilxABJhV74/qQs3yQdhjb1n3xu4D7hU4/9MRPI87eWfcxcS86i547uRfYNCjhq
         Z/FGy8u52Kh7vxCSbzExfbgIcCMDSsrbNqRXYGVeRKLmdyeYehxD1DxjC09GQn4F/rf/
         i/pMqx8TsTxZkTD6P+9q9ZhnXv1D+LekSab/lWmZ8otuGnVlUteKhpOGmA6q6bheMk+w
         t2RA==
X-Forwarded-Encrypted: i=1; AJvYcCWAaS0n/hKk/SME7jZ4lUSHPCmF90MrGioL94FZkvackLX2+T0no+k9wv7mFq6k2+mf3jlE56A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGKEFGMGp5qvt+d3cgZSp39GWo478I1genHOxFc8Ds/l9EFBG
	n3+NDXBAFGy94WDZes5wc/A4ib5GSYQRNbKOFVaTSeEH4y6R5JiYukquTb1zsn1E6JM0QFurCy3
	zN1TmlCbIu26mRtGAMhCjGP6SIPj1st+gxYxSt3Y=
X-Gm-Gg: ASbGnct67U6kVTBTCzt9DTfoBjWbUgysh695SHacjF9NJwOGv7xbUgA9+Clt4jJrjET
	MR2qSnSLrAiZwa2LjgWKo3tvUlvCTUiqlgjs+i9WuWiLJsLCr8MAvAVeVZUes5kksFW8JULiG9b
	qduyPVy6qu8V3m3nMgGWMB78V5u2TQrlvd6aIsW+PZJZJtTf/hWyk4PfcVDLah6zLPPOfp4g8c
X-Google-Smtp-Source: AGHT+IG767EyeS4WvZ+kyHjZGSNrzbYgSsrpRpXfIEvuAxnBT8xJcNKmtdcC3AtcrJUKKBI3A1Ac7JF9k+yDC2okg54=
X-Received: by 2002:a05:6512:1287:b0:553:2420:7c41 with SMTP id
 2adb3069b0e04-553af98fd52mr299889e87.26.1749787523877; Thu, 12 Jun 2025
 21:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.287145536@linutronix.de>
In-Reply-To: <20250519083026.287145536@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 21:05:11 -0700
X-Gm-Features: AX0GCFsZSBvcbuXa8-uyXGwLeDdlB8p9k4M9RUR7qJL5VHafbWQ8hbPnOEsH2SE
Message-ID: <CANDhNCoYJUWReC-vUgSYo+3ie1rvCefoKEfr7CBXW93nTT1EOw@mail.gmail.com>
Subject: Re: [patch V2 11/26] timekeeping: Add clock_valid flag to timekeeper
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

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> In preparation for supporting independent auxiliary timekeepers, add a
> clock valid field and set it to true for the system timekeeper.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

