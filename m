Return-Path: <netdev+bounces-69951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938384D1FB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C910E286DAB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7A84FDE;
	Wed,  7 Feb 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aM3YhTH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD483CCB;
	Wed,  7 Feb 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332706; cv=none; b=IVxl7JrQmg/w8zyiImVOoNBYldaNqbBW5O6ZYPIhy3G8VaT6/+nTyogNCZ1/HPZKoXAbqVEUKvNy0bjkzOK5cOrxPZ02jvn91OUK1gbDRuYLSCmC7o6wrpEeHPjNYUpaJQpoyh6XOefn+2RCl0olJKsF2aEksKf5AIUf5Mpr+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332706; c=relaxed/simple;
	bh=RLZTh/ZZqW86T77kBNKA0lpk7bdqqvs3d4i3od01oVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx2gK17L3aNMEfhtCcqWsdQE0xfwO9un6DErnPN+nuvxbe7ZBGqgRMmVLh3NFeQYcjFmG0DFIhHjK3972CX9FbWCOlKmFGjLO9YGcNQHmId9vVKIK3wvOA7kwLo9OlaECXaVR3/JLRE8MX0EmZc56c5FRHh8/CSxnLyduLjRYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aM3YhTH1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 617FE40E016D;
	Wed,  7 Feb 2024 19:05:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GYY7a-CEVzov; Wed,  7 Feb 2024 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707332700; bh=UG6LZTZwY5niTQVNIUufiW7MyxpaNkRl1LYv98YsuyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aM3YhTH1WT6/9nZT3x6c0L+OYH8SUcNuH8jCtHZFKiHRTVJ3oPTcQdWe2MdF03mOc
	 D6S8qh6EhPDgL7duLOi/S79tB/Bpbf6I0trTjIbglK/32nk2PxyLcpKyC9lv+yVORn
	 Hjn8o4ouDyXAkfGxzo0HHnxYUo4YYaX4bgSlKQljWyb0fCb0VLIvDxXz1SHjibfJOo
	 iHvzrDyEAYVGWif/wMHWzi35C0iknVPXUnhiwGjNxC10PuhRvUVmLm2fCxmH3fnrCY
	 Glcjdz+QQ13kJfiFMTeGD2RNXWScGyCbIstzywMAd0j0aa9+/JJEw0CMulrPDmZWXN
	 1I4Lbs+QJLvUbAq0DOyYnxykbYtSjmnBKkvhR/7qlQ0apsSi6p0CZC80fiRtSvxsNU
	 8C0AHAxK4c8ejEpvQo6dCpD+UfvI8ct0jDtNtEIZ0UPjdbSUKQ71XgWXv6lGvc64GR
	 JSHGz+sVb5fbORwOqFe4j6gDnx9mcLIRihEO23ocjxLL4K8sBNUS8wtp7UwIABwC6f
	 PMHdmX2kgVMP8hESAQD/fIY45zNJM9cllQvITpY6wpkhnziR5EPQj5VP4Ltd1yIHyz
	 Nluhh/X+Slf9ByQo63samA8sEz3B6nmFQbbkwnqOXQ8HsvCcjeIr8bF/SsJ/YHBtll
	 pSANkEoz7/CaYH8i1xus5cfQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A3D240E01BB;
	Wed,  7 Feb 2024 19:04:50 +0000 (UTC)
Date: Wed, 7 Feb 2024 20:04:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KFENCE: included in x86 defconfig?
Message-ID: <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local>
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local>
 <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>

On Wed, Feb 07, 2024 at 07:35:53PM +0100, Matthieu Baerts wrote:
> Sorry, I'm sure I understand your suggestion: do you mean not including
> KFENCE in hardening.config either, but in another one?
> 
> For the networking tests, we are already merging .config files, e.g. the
> debug.config one. We are not pushing to have KFENCE in x86 defconfig, it
> can be elsewhere, and we don't mind merging other .config files if they
> are maintained.

Well, depends on where should KFENCE be enabled? Do you want people to
run their tests with it too, or only the networking tests? If so, then
hardening.config probably makes sense. 

Judging by what Documentation/dev-tools/kfence.rst says:

"KFENCE is designed to be enabled in production kernels, and has near zero
performance overhead."

this reads like it should be enabled *everywhere* - not only in some
hardening config.

But then again I've never played with it so I don't really know.

If only the networking tests should enable it, then it should be a local
.config snippet which is not part of the kernel.

Makes more sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

