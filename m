Return-Path: <netdev+bounces-113076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359E93C95B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962991C21B82
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8E8121B;
	Thu, 25 Jul 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VGGJpc9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0C11711
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938309; cv=none; b=Dq74bQG+/tUnGW541wQidlZO5UyHTPdp8tEBVbVE6sKGY3sf6PQIigaLEAeYCIjeKbX7A+/K8eGaEBpwG53d+dxShoDJZT8O9Tb8EeBR8YaWKWE9uZE1KiEwBkhC/rbUGfMpxuxFGkhygujWONA8J3Zf+SZHmVjECUsTk/EEiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938309; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah0q5X74ivT80Je0iU+hG0U+pHzDfFkGSX10GZXWPc/PsRDdZEw6bJv1yvKlhCUl+49WPgKynDjafzydMQ5wrUDvlX1DZ+bncFI1dkRSa4u38242qOKm/ex4Mlsh8C8INJZREkLpu0zjLDlQoFPwP43gJhX4OaIQq9pRaXieH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VGGJpc9z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1718406a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938306; x=1722543106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=VGGJpc9zDN+mkjvHijUbdgW3//dooXZcuMo645a1xri5k48VE1AQuIbTGr9azz1xnQ
         mUhlZMOj1qSMYJYlVdttSq/JTONsicPW1ho5S1GHxC2nPVMvXLJxTKH64P+X/1BtC5ks
         ZNNTyxSR3pCAijP16sHF2EwMekMt33xW8Nmu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938306; x=1722543106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=kLp4NjMCImS5tT8kOWmoC1YzLA6LsNZAhBmcbQlg8UsUWyL6q/jHVpprceAE6zCjH1
         jGTf8RSVTlAuDcRux0rs1hwJOwm2k9Rise+Q9sf8PuoC2ZDWUXPl3JIloOPrtjeqgYKa
         MBCwix/EwSOB/xg24/V9Qgx5BNEC/rBG0kQp1IMnsStRnxa5sH1qOFTYcWQ/DZwDMlU+
         Qm1kO29iS4ueQyMHypqB7hsw7QiwJ4RiamH1djPCoboKvZ8jQwLD+OAz9UPo2wAitVdS
         zZy8209SFiArLi0X7SQES66ealiePMjfXMwpf2KdIa/bbYpCy5xDNNrg7lLmWwBOPI3F
         iUzg==
X-Forwarded-Encrypted: i=1; AJvYcCXKpx7XncTKxZ/8IIru3q+5GyLVfIF/tytUaRBTV9TAz/hzOSo6mHsQVUrinE9ysaJbKxZ1AF9WXMEfba6fCxrWwWaTazWI
X-Gm-Message-State: AOJu0Ywc3h6fuT7Tho6LV7bAGbxsdsGfHlcv6rDlxndu8c5DmrokqvUd
	/Euc18XlAQnq0PkBY/GUDwcMdayWERM3YMxyQ9I0BaBVUUzNtN12xTjlW9wlGrGSf//pOXeamVE
	argQ=
X-Google-Smtp-Source: AGHT+IHexR6PJWPYYFtKwwZppxNwu/fXlM9NuAC4hO8pGzDBxJ9yjERqvkfNfjwU8T2iB8lAzzdZrw==
X-Received: by 2002:a17:907:d17:b0:a7a:c083:8571 with SMTP id a640c23a62f3a-a7acb823316mr238756966b.52.1721938305734;
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9819sm103275166b.205.2024.07.25.13.11.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so1635791a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXDSFqqOCTAUAIlDE0IBr+9N0W0Xj71d2GahKEPvNzmr2dIYjHtze9dSJYVglP0Y9DikNQ0BF1v0jRRTLHCU1twOnznw+i
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

