Return-Path: <netdev+bounces-205612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC85AFF69C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7AA4A5CCB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7942737E4;
	Thu, 10 Jul 2025 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD8YardS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A411A23BE
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113437; cv=none; b=q4c9T+WA19zo2G4mZBBL/12ccou550elgh+/ERNDnWzjkm0HX/oh3N7xxbiRW9A/su/o3HEGiWGKcqClH9lWAmBCTxq/o991/kdND9IdGHdUzP8Awtj5NHy+2gTHe+otPrtZ+ceQsMNeSQz4SEtODBnGsr3tYrK0qXOoQwvYd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113437; c=relaxed/simple;
	bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+tTiEjQHIThMaNDQAsXKzWx1ioxqzgLBUZ9N5dvZnQFrzFir0aa3B6RC9PtnMEE669IbQhp1pp0tgGJgJJFOuw2ZfON2gekZKdgctbn1r/gXbGOS7i0J3gnelzBkQ0qWPaloNxBsoEvKejHMqHmrYElGUzzm9GAu4ssdTjy9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD8YardS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-558f7fda97eso245195e87.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752113434; x=1752718234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
        b=fD8YardSTYDjVtKZNh3hTIOOnFivQwAXxl/Agtnc3vOdT34MPKxoF7m2q1bVJq77ch
         SZsLgiwtWfogI85r07egUZD0LKvqvgclCDMJRtnF8N29Ln8ArrArbf4IOTOWatYnx36m
         L0iWoWaEvBUl462EI3a3IzWpQcVzprXImRfaHq2Zozep+CpgcMoc8PUGq2FcozNE7mfB
         lsFaUBCIuYNVpj63agoAgEL0AeslIuMDPexVF6QuDPyGoqvb+5Mawsvh2GQxklDF4Z8R
         NGfPz79ctqLf4Rdyt8mr0U3s8UiQSFKKwu7NK3LhSP//qCSTRQZTTxeUTW2dPQTSjz39
         47Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752113434; x=1752718234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr9GbybC/w2sH7/MIXF4I5fw9NjZp0rHNpJWYgnlE+o=;
        b=ezevo6DpH0Jzl1PdEJGGAYhcio6lyIxgPrAmqSFdfksLFlIKMcbnDmxvtfLYsU8WMc
         21or/aFpKwSuYGtexbXPPXI0mAXk3GmA7u3rjr2KMXAh91n8FjnqcMJkpuXQoKHaF6ej
         VSZxS0P4PPYI0gyu69mdfopF2dnOFxfxfnS0Za+Qm9AxY4pr75+FLr3E/wj8vfDsIGsq
         yVL9L1U2LfHcGkgAqBjwgmEeOGkxufMh+BXvXbR+0rzWLFLBZtLzQow24lXEMp93e0Gf
         yFPtUvCQz55/hksV16/EThcN2pgRzeN1G6BDwrwWC9iPQhZvWygmnFKQhKAhHOBzZkxD
         Nnxw==
X-Forwarded-Encrypted: i=1; AJvYcCW0onYkY3ocWcCUIHLhoUZ1zHot40RkykVN4EHmzfJ36nfmAW7OQK/YvfU6C6mp9guA7VcOlZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOdQvwIGOYSPaFiiwD1OBhY2Q94Ydwo6cUBA3YwdR68HZybLC
	NrYIcDkeUXSh1qc2rarx2WKdWMiJwqzBHa70Q5QmMrlCQdkA6zc7oU+WCH2MOTq8JZAMM80olbH
	gegU5kVvPs/QO1gEqmxuK2lhlVUefYvdg8t9Pu8E=
X-Gm-Gg: ASbGncvzuVeKX/H0miq8wdQXxCIwkBloYserX+GeAN2qQdXsKfcsUGz/9ItTNzteYZ/
	IRb8YR/qXKDueJqJd+g5FRCe2l9e/klR4f924m8AJVVVXBlC5mleySYem7fYFHDvtAp5YLTqxLm
	ITuZv/3mBIoaQZl5nRp4DiGSsLRHL3kNt4bV1fTH05TAnxd7cCEbNNblQNDRg7thaI+Jz8k2n2
X-Google-Smtp-Source: AGHT+IF7CSRMfXUjWAwZfGydsjg8g4cFnxch3Xoi14AEJwAmrBxN3hebeIFO3GyVLoADPLLKkeaVoOM8ZqUO+Qdos3Y=
X-Received: by 2002:a05:6512:74e:b0:553:263d:ab97 with SMTP id
 2adb3069b0e04-5592e2ebbf9mr191604e87.1.1752113433736; Wed, 09 Jul 2025
 19:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
In-Reply-To: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Jul 2025 19:10:21 -0700
X-Gm-Features: Ac12FXyw_-ZFqOEmEG4gp9Vh5ErvO2eH8QSE_aH1c-f2EfnXicZgK4MYIbiWaVc
Message-ID: <CANDhNCqQ0JgCN+5sThMT3nnNxVHR351LM75eUMqMaHucGyhneg@mail.gmail.com>
Subject: Re: [PATCH] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
To: =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, markus.bloechl@ipetronik.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 7:34=E2=80=AFAM Markus Bl=C3=B6chl <markus@blochl.de=
> wrote:
>
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
>
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
>
> Assign the entire struct again.
>
> Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
> Cc: stable@vger.kernel.org

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

