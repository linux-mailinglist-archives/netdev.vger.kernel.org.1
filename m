Return-Path: <netdev+bounces-199944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8EAE27AA
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 08:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C391617BD2F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA0199FB2;
	Sat, 21 Jun 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgrHcWKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287E2AE8D
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750489107; cv=none; b=lPiJ8B3D/d0MQ/f5kInUGWcGMjBkD/Yy7D+guMdoQD52iesvORqR+6IHnGppRueHficoBtVBSsuoEewg74Ytq1zPkAQ4532ftvmrLNOnE6OvLmMArM72XoIXqljz2l0uRvnz34+sFiGaLzpRA92u2a/KYuFFG1aC+OfelLZ/734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750489107; c=relaxed/simple;
	bh=bUNdx/2ldmooF+wfGIUFoptMG2S7gkeOO/JL2A6zVvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHlJXjTKXbSmQhgDGMQcoJ764PYuYsFsmkWm6qNrk0BWqtIl4gZC04anHKPKK+TdhthPEQj6QV2K7ZPiJuMZndCIWteGDqVF7Pvb4aBaVfpNal0qqPlQO1mgP0cL+NxmKgyPGWWd7rXBiYR9ZUzscgkU1h3apTJncsWYtx9DAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgrHcWKs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d21f21baf7so295188785a.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750489105; x=1751093905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUNdx/2ldmooF+wfGIUFoptMG2S7gkeOO/JL2A6zVvE=;
        b=XgrHcWKsXOXcN9ClWAG7NHF/Ts1fYscQ+LrGvxsB4jZVRNhKAGRw3CEczmQ9FdXvSt
         Ttj5oBrxlzRIL1RMcEyQBbE/ycDGzEaSpKi1sn8sqIuT/a5y0kQUvPzKygddgOaNqlXq
         T3VIMmMHeguDhISW1VW6DfzEVMKJYME+bf39cAzGdjiO9MSI2EnIZVEESUaXLqhIynk8
         F/UqnWx9/XLuTVKHvXJvjsUzw1aziMapJBQzpupMBQGM9UzDrpHZki3KxKtmkgYmvS6B
         bXuS1wbYIIpv5Kis2ioTan0X9sx/1915VZaHBJI8iYnJ/R39Hy+1Ii36bk3Drvu6ZHLm
         U5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750489105; x=1751093905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUNdx/2ldmooF+wfGIUFoptMG2S7gkeOO/JL2A6zVvE=;
        b=d5+XAQyg7iOglfDoN3R9VCrfzW9fWSlOAFwjXSkod2Ukw4ePI8MSG6I2p6j34GvUyY
         2aWYx0WwI4cvR2npL9q1p0Q6QEcIJ1Hw/T3l/HFGV3E7XpbzIbkIa3KuXos+93iYGISe
         +iZ88Lh5nazLqizyhPMsZgdmuQEOSVkfQmBJC0oAjGzo0DgF5Q6/vU5DscBUvFQy1k6z
         GME2Xq80W+zKvkx600lS7+yTDkKM0EWth3XO/p6uQYWlQ8tvqp3arsJ9Yrx7JeLvGyKV
         Xy9dRJ5Hekxmmd/NjAFTBFUPphhfZrCNTVTCd6xOy8twbfnp1BEHKRIQkd6NagZYvbp7
         hi1w==
X-Forwarded-Encrypted: i=1; AJvYcCUWUl+v/Y2Mt0YEexSYU265/RWWnAqQs0MQxuKdKGXuh2lM6zoLEwUI+S2A2SEfydMjYgS3ZSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7bH8ezqtytA8shhgjGs4BXn2wsfjV5SO4xMW42brfiY9jT+T
	9YhQFf0icXVsEgi8usGf7qS6t/PlhXOIDwubQfawEQFaUB1Rjz+d6iia8GLtD0FO6BlnjdZw+YG
	cQYdE6XZ6iGUFvEmnILG8fuophgpJAp+lb3t5AFm6
X-Gm-Gg: ASbGnctE1vw75QDPD+Cuc1tZbbrHSCB1LcczOb/1SwmzbZ/nDQ1AEQ5Ane7qcNyjAFF
	+3CT5fqwg018MR5HPfiRIjJiIFyR67+HcMSFZ6quq+SqvXokWeyL2E07Gj2sYBMyw58GcTzRC5v
	ViIHx5V3ODNNfqvKEhL4zGaOKmI1btx9DC1+1FkfHChQ==
X-Google-Smtp-Source: AGHT+IEHz/JR7YYi2lViA2o0Sn5CmXAFfiTDbM+tNqv2elv69zznKvkvAvdBvr86Y6n0SdUPLLuoC5Osau5RVKtSEw4=
X-Received: by 2002:a05:620a:3185:b0:7d0:97b1:bfa with SMTP id
 af79cd13be357-7d3f98c769amr837848985a.8.1750489104823; Fri, 20 Jun 2025
 23:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org> <20250619171339.1bf28dc7@kernel.org>
In-Reply-To: <20250619171339.1bf28dc7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Jun 2025 23:58:14 -0700
X-Gm-Features: AX0GCFsu87MFC7EBTBMwXAysv70gmAeinWhBQnHzTvKtmqPLtPM0HB23PPllhK0
Message-ID: <CANn89iLX9XTk96=mU7pSmNkyFfj0DpMe_mTfOc+TYArLkwYXLg@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Krzysztof Karas <krzysztof.karas@intel.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Jun 2025 10:24:13 -0400 Jeff Layton wrote:
> > For those just joining in, this series adds a new top-level
> > "ref_tracker" debugfs directory, and has each ref_tracker_dir register =
a
> > file in there as part of its initialization. It also adds the ability t=
o
> > register a symlink with a more human-usable name that points to the
> > file, and does some general cleanup of how the ref_tracker object names
> > are handled.
>
> Thanks Jeff!
>
> I'm going to apply this based on v6.16-rc2 and merge to net-next.
> If anyone would like to also pull into their trees the hash will
> be 707bd05be75f. Happy to create a branch if necessary, too.

Nice work Jeff, thanks a lot !

