Return-Path: <netdev+bounces-241983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EACC8B5C9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94FF3A2C7D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDE20DD72;
	Wed, 26 Nov 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DTCqk4om"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BA4207A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179897; cv=none; b=h5qtm120AAdYX6x5ib74aFllvXI/B/xQdH62l4B2KahIL/RXYyyJuG9hokS5vmKpt6Vz6ODWYYy35thRUL+APGb5b00xrj9ySOB1cYFveQ/NCaUU2OtDyWoQBZ4RKtJmHHIUQQWkYUn1r5vLbfNEkE+z2kO1OqJSEmmzmGojMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179897; c=relaxed/simple;
	bh=nk9iQUV0XsLI6d4//k6AYsJtSmW0aX1ARpzLYKj/qY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj5uUmOTD9/pfwXq4n42ZehgkMxCaJJLIsDDzL19K55R7i7/OTfaCLF755yU8l4+Sg82pZkDCg+eIRmVIw+p+k4P4YEvalqgaPvgMH3z5pLRBTy7UHqz1WUIdRFVTbJ8Y8xV2kxovDAHf5+HwddwQoj9iMtS1aRLt2F20C3b7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DTCqk4om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912A0C4CEF7
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DTCqk4om"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764179894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nk9iQUV0XsLI6d4//k6AYsJtSmW0aX1ARpzLYKj/qY0=;
	b=DTCqk4omXMj2cWOY0qmFomZdtktz5bhvzvMUYlO+Ty6TP8jdPuJ7pzeGUhloLx3+Lo4WgK
	9ceavxfabYJnqVAHR5Cyix2QoLNGrabSVTuIJb9b0h4T7k7nBq5mkdC2BJUde8+3aeOGWf
	bwxbbmQxCvhU1Jzbj8c2I1I6m9exP2Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f80aa236 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Wed, 26 Nov 2025 17:58:14 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44fff8c46bbso2315b6e.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:58:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMOBIPVb6cDO4l2iVLJx7XDimRNayPnDlc0qQ0+5a87ekLEPIohY6Idf1eEHuyteT5Isn7QWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEabr3u6GiHF3YgX4/9ySOZDNDG4faHG1hS64W6Y8/aQqCoZvQ
	1KT5NG/pLkNBp6gxr4OrfwEF2s61XrxME9TTPzX2BBX0KSRyTJaaDO/1pMXHNphDQIqyL3Z7Q4a
	I9bmloEN7HhUJKL6qiBUFEbGz9Lqa6Ms=
X-Google-Smtp-Source: AGHT+IFTtQij18X9rcId8/xM3J3CLodhdl0o6d2Ojf4LIqtOBzWRLO3KWhny/Isr7a2DmvXJwy9ays14CPzzN+VmW4k=
X-Received: by 2002:a05:6808:4f67:b0:450:c58d:8c3a with SMTP id
 5614622812f47-45112d13fd4mr5903134b6e.46.1764179892530; Wed, 26 Nov 2025
 09:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126173546.57681-1-ast@fiberby.net>
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 26 Nov 2025 18:58:01 +0100
X-Gmail-Original-Message-ID: <CAHmME9ptkYkEygY-BmCduqySToOL1mvZnrCrgFM2bBQrNmh71g@mail.gmail.com>
X-Gm-Features: AWmQ_bn4ajbqmMw4PaZ5c9-r1uz0ZNO5-beD-38rcNCG5zkfeRd9Ch8PwgaqHr8
Message-ID: <CAHmME9ptkYkEygY-BmCduqySToOL1mvZnrCrgFM2bBQrNmh71g@mail.gmail.com>
Subject: Re: [PATCH wireguard v4 00/10] wireguard: netlink: ynl conversion
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"

Hi Asbjorn,

Thank you for this! I've merged this to the wireguard devel tree, and
I'll send this up to net-next after letting it cook there for a little
while.

I really appreciate all the work you've put into this and the large
amounts of feedback you've incorporated.

Jason

