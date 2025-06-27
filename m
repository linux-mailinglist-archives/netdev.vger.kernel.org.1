Return-Path: <netdev+bounces-202048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF46AEC1AF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9741E1C413A6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2F2EE260;
	Fri, 27 Jun 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdP/Zvxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32861E8322
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058301; cv=none; b=gCi+4M6OfBXoWlFm8fqWAhGLfpWVgTEo+8TuFfJZrgKimjh2h5rxz8l/7zJm6KG7Xob+CKmbuXnYyxYK/tAgJLd0vQ0c3BWf3FO8OV91sc3o+83DvKzH4BrHlN6cd7Fc7vm75irMk15QU8k+/xN1iEk5Y+gZEb3j7swGNKkMAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058301; c=relaxed/simple;
	bh=6Vx+mQs7H/hQH8fPHvdzbZ3OlJW7XKVflNPyIHnZFZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzJS0p+CAs7KDix8T7cAWHRjpH0GdNb52bJ1Nn5dqwODyJmisb3vKcuXG70RDGhYMP6C/G5fitjxAtQJD18fUC153PSp8Jh7sMU05WLn381+MfuCLQM/MTkZsObCeFxEsR4sZQg3OHVtq+KelHIR+TeuXSARgJdoNQZbXUN1ubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdP/Zvxp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313154270bbso16660a91.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751058299; x=1751663099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vx+mQs7H/hQH8fPHvdzbZ3OlJW7XKVflNPyIHnZFZ8=;
        b=HdP/ZvxpgM3db1EK0GrQAQcCzpE+XCXBIf0MFWzsE5q8px+T6fThgpJPg0T77YK8RA
         jZM3+qMLiu+8geX+h/E8q82s1u+2ukOAiWWfw/rfaimIFBAsFPsuEVEXVdY+HPQ2Akcs
         /4z7+bnHgx13u+qB6KtI8xekTWrZ3aAnhQCOn/JkTnB3IMzFZ6Ct/ZIjCOdtGN+O1Hu0
         bJAHzmZ6SywdQaMKTo83ZC4HBJO+DHui/ffUww43G6rlmYQz4TZKSitBooK0m2RshZFK
         P2psynXz+TGxgNYq1+co8dQCvtfzB4bqwS0PPqZCDRyULisXveSj1ihLd+gkrmRgM9xe
         f61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751058299; x=1751663099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Vx+mQs7H/hQH8fPHvdzbZ3OlJW7XKVflNPyIHnZFZ8=;
        b=FOkx0hT1EoUcTqsV7oyQ69CvCMVpAHXNbU+cCdTuwNzWp8hMPM9CRlePh23sAuQpac
         VMfKFJYsIC2cHf4iVlL6TwG/We6a5r5kJ9nNSolJTS0pGhEExWCAqlltEoalM4YyT9fp
         9cXD5ul+NzrSG/lelZKIQbILc7sDR6GZgGCgkfX6uuHSEOgeBwfF1PoMDCi0J+s58vIe
         0bZi2+7+22gKZ1Ht9UFnuiYm2WsDG2CjyszJiLIkuUd9TBNm2/HeGQb6ajeaoOBJlao9
         uLheAiEFMIBfp+gP2wums8/jJdn73RsEv2yeH0hHvZoRrxag2XBMS0SQfxZ7sjBQDwqd
         TgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUueCxYAflX6wOqdk32eV9bIS9zlHP0GvPISB8/Huwp0TKv3cZ51Nbz9VTENsuKVJRr0awRSNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HN2cXrA6L/lOZKFGfRjTYFf1LZOBKHezcegejn1EhuPXI7zn
	arCA+i9nAKD/1w0IrwKvBFMrKM11miLekJ7aLz/5FdbiiP7CByVBykh+7uGqW9ZvI/lC/pbjKJ/
	G8R7Ya/RDbFg0475dQZoMLzbjRG9U1kvBOpmm1nN5b29okFGTXwzPpcZzms0=
X-Gm-Gg: ASbGncvRD9YTj0doX4Ue8s+WHsiRQqW4a3adrvnMKXd/qy/wk1e42YMa85hRVCdRzCr
	J3xg3rEB9vRL9tDCtZM7o1my76f7hH5Y3F+zQG2jUN+dM7ObNUh+czmVHOWQ/RAvNNytgJRfKmm
	2Nm0jdsxRu2SKOS0IO+F0b2kWCNa4MIOLM3BQBVxxilELrAQNy8GyXIx7SzwBtQ/wWBOyI6IQKQ
	1Lw
X-Google-Smtp-Source: AGHT+IEDKZptaqlJdka+W+VbF4Wd3gctpgXFlMQuZkAuRH4IxrpHP7qZP0JKUHFnoULuu5LXZ7ZPvhzEZVGKdUgMzm4=
X-Received: by 2002:a17:90b:38d0:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-318c8ff33e5mr7268432a91.14.1751058299021; Fri, 27 Jun 2025
 14:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-9-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:04:47 -0700
X-Gm-Features: Ac12FXyJ0G3p8lmywJJFJjxYu5GFyPAxaEGxk4sg2GjAzgvZoziZDZsUz90zQfM
Message-ID: <CAAVpQUBtrsYJ1kBxb4J5kgY2rncDPDSubixoBCSjub32g4k2JQ@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] ipv6: adopt dst_dev() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helper as a step to deal with potential dst->dev races.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

