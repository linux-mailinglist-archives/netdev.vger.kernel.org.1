Return-Path: <netdev+bounces-69924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF384D100
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159581F22CA5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AF82D82;
	Wed,  7 Feb 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UPBO+P9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827C7FBD2;
	Wed,  7 Feb 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329804; cv=none; b=Z2Q09m3xqkk15wZfJy5GvasMHgA9epDa0zBl3e3Yl4xNmRZnoyninxXA2bXIPi5QuJbRtnGpV+24FW7WrlQVGg8f/N5x7fuln24fBu8w9z5uOXTFfJ/AlatqZybS2mvR1rlYy9KYIdzoloNMvZp8Gy+gz04WG5cTt2iKodcpVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329804; c=relaxed/simple;
	bh=lTn9YJyyJbMbuYXQt6xvyrqd4qV+c/o1xDikj/Y7eNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohu2YFiNGazFex32QavHdPsmwXthzECLB5J6dv0/bhRVfM6xTEB9SRMoA89UmrHgCNJOJKNkx0Rhx+gt4mAyTY9IM7PZ4vNG/t4DehYQjjMP+iaWmLkS39NE13L7zLsqUx+6RBzHzk++w+s9jqrPj6AAFlrLQ6M5mUaCz3a7LT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UPBO+P9m; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BA3540E01F7;
	Wed,  7 Feb 2024 18:16:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XwEu8As-sH61; Wed,  7 Feb 2024 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707329796; bh=cF/Z75FRESL/9093tIkb8FBZyiCbHtfUBM3PklHfN0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPBO+P9mkxVMcbbwM+vNiStCdiFBBibjUkiPhHw7il56IhF2GN2ATS41jC86zOvsT
	 Urb4XRKf/ruCX/TTyM6pFuJBAc1VbCbzk46G+9h2UYvzFSPGYtsS1KDnNXcQXz/vwE
	 vmGzNcY8lkeWcWbCl7VGlVxXuJj9vCwMQGG8Pz+WEik0Hn+NSbFCJBHUlUP6IvuMnQ
	 IKe8Py+0kFLa7SK8g8mNQSs4I/+QRprUgkqGycWTHi2TBRGaq16RpMqibfSPEDYsA5
	 QPl8IeIrIUxLJ5j1Qv61quUuhwzZ5kbxhHdVV3f6228c6RcBbA/7l9/0Y3Fy5oHGW/
	 EuGev+t51N49jUwGHKP0YHyo6Lh1wPOWUQ+X7JHcRdv/Lo2xZ51yLq3nH8X+ms7fv2
	 5GZ07aE31JA4PLgmGqOQume/5B7yF/bpkN6GX0gypn5Vj79dbQgO9+G9fGNfwRFPev
	 PQncCQKJKRvYeMBtfIO8V0jQfatJLEA3S0KVXv6FDHcvh//ANyBfoVegexPiaKPLen
	 0DrqlSxfuD4qypD774tMdhXFe2N42TxSd2IwbOrg3yE6qrrkqRd9lIDbNbFuhDsGdJ
	 esGMq2msz8Ej7Dnr4yK1ViQ9WuKUmIkibenAlypYlOgn8zGq0jwJAmS7NHYxfkb5qJ
	 x4WEGXABhGDfj/UxPlSA0Syk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5E8D40E0192;
	Wed,  7 Feb 2024 18:16:26 +0000 (UTC)
Date: Wed, 7 Feb 2024 19:16:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marco Elver <elver@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KFENCE: included in x86 defconfig?
Message-ID: <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>

On Wed, Feb 07, 2024 at 07:05:31PM +0100, Marco Elver wrote:
> I think this would belong into some "hardening" config - while KFENCE
> is not a mitigation (due to sampling) it has the performance
> characteristics of unintrusive hardening techniques, so I think it
> would be a good fit. I think that'd be
> "kernel/configs/hardening.config".

Instead of doing a special config for all the parties out there, why
don't parties simply automate their testing efforts by merging config
snippets into the default configs using

scripts/kconfig/merge_config.sh

before they run their specialized tests?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

