Return-Path: <netdev+bounces-128465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86248979A41
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF28282DBA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A851BF58;
	Mon, 16 Sep 2024 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FGgNkFY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630706FDC
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459908; cv=none; b=X4N7Twimz/tyB5ZP5MJYde2HHz+03OIsxnGpYdn3yRmqdXzsR/0m3+rXLfGa7bcovGH7jtQZqhIziydVegXNRYOPVMa0Q9uke2FIpi+iTWfid4cRceLA5qL8WsMSK8ZxXviP5cKEFk/SXSW13zcqEw/s6k96YwgIc8QkRwedrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459908; c=relaxed/simple;
	bh=rEzHBfkIgARZXBg+FaOBgTkxXmN8tjgDr6YvtGgsa/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE0QWdeS1IOJSfb8wzH54WLSVghEvoyHJ0XPWBu1BhJk9Bf5mEcPZOwwzYf7ONX+FpcXWoW2fghsu97k1PCGn041cc38V07Nx6UZ22epOUIdGWgOQFB/xpHWouu55jaCqvvDhoqDRwCQCJ/zGpG3yvoWnh12oH9s+eUNDJDbegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FGgNkFY6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d60e23b33so521446666b.0
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726459904; x=1727064704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2H9PzIEom/WoKCt0glTh+xZzRbo7UeyPTwBpxSe3q2g=;
        b=FGgNkFY67W4k/cUMItWC5rX9OuvuUvsAfr/Sbhg1kGwwfs7tC3TvbgfCszho/2T8xh
         Z+C9hXUksi2w8YtfSRlw4spbsWlz45IpByxPzOtQK2CG++I5TkUj231XvYC+Zi7coALf
         qL/tDX+Iz/1rcsTe+PHCnaNd7EO5hbglSDmwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726459904; x=1727064704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H9PzIEom/WoKCt0glTh+xZzRbo7UeyPTwBpxSe3q2g=;
        b=NVz+gcLtw299fNFKj9ZJcfk3z8ggg91E4/gPiXRZ1B0c/EsiC6TqP+uvmiUTiDUpQb
         0HH1jHR6+idwlYSRiPCTxa5cCa9hMEeNBeWm6/GssSQNYCX485TSwI1LappFlYXf64/n
         P4wpACACE7quXqn5xECsb4v+Z/VNMPozNN7/QxBnN5A5lwHjZwTjGgjGpK5vo90hkESp
         /eZmRk1FI6oWlDiRqLYqKgjxjvhriJosDis9MRXrX5E/orxfK55lRQINhA7q9licl9K0
         KBKIpS7zektyThKnFrfCyqzxc8ca9byfowRZPnk39VHrDHyevaJLjQXcn81tPS3UlDuP
         ZPTA==
X-Forwarded-Encrypted: i=1; AJvYcCX1mcMDivb2L397JbG31kmSVILrV0qHRwULvBbfv1qXnWhligz9Oxr4rdIS6dkM0/+ow5FaL40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCRN2e+gmP1CblHLejauv18avE6YlD/G3t4ZgdoX4532iCAnC
	8FVEOj10nb4ueRc4iGAb2I9XknJKT5NpGZ6/siNn01Zorga/cO52lmXiVNcTRRJyA/JniTErPMu
	ONm8Cmg==
X-Google-Smtp-Source: AGHT+IEIBnAWda5I5gduf+WdlUZGmUZco8l8mq5wYQoZDyPmWOr4kvhazEz5wJaY3cJiuDstCmT2eg==
X-Received: by 2002:a17:906:c14c:b0:a8a:9054:83b8 with SMTP id a640c23a62f3a-a9029619a16mr1598997566b.46.1726459903778;
        Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096896sm261469666b.23.2024.09.15.21.11.43
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4418750a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 21:11:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXS4FP52k8DmMJH+hwpU/XyXZuu8b7yr0XjNf/O6/an2taX4v49/GezutZVOhQ6phFNTIjNnmg=@vger.kernel.org
X-Received: by 2002:a50:aad8:0:b0:5c2:6d58:4e1f with SMTP id
 4fb4d7f45d1cf-5c413e57af1mr10106270a12.33.1726459902835; Sun, 15 Sep 2024
 21:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915172730.2697972-1-kuba@kernel.org>
In-Reply-To: <20240915172730.2697972-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 06:11:25 +0200
X-Gmail-Original-Message-ID: <CAHk-=whHoTURtgOC6ceHeFVhW40T5MKJRJMHvyMJXA0ko3S4rw@mail.gmail.com>
Message-ID: <CAHk-=whHoTURtgOC6ceHeFVhW40T5MKJRJMHvyMJXA0ko3S4rw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.12
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 19:27, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Unideal, not sure if you'll be willing to pull without that fix but
> since we caught this recently I figured we'll defer to you during
> the MW instead of trying to fix it cross-tree.

I think just dealing with it during the merge window is fine, since it
doesn't seem to be a mis-compilation issue as much as a "doesn't build
due to incorrect asm constraints".

So it's not going to cause any _subtle_ issues, and the build fix is
known and pending and won't affect most people.

              Linus

