Return-Path: <netdev+bounces-248855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0600D0FF15
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 22:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FDEF3028D61
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F3274B2B;
	Sun, 11 Jan 2026 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhXfo7hH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FD26A1AF
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768166609; cv=none; b=Onk4o5S5BRg23RTZLumHGuxpHPQnCyOQKjdxiuVCeK5wTagWbd+BMVGkTuKK7YjpWTyhTcCPKPXLkxkg8EWiYXSFBxKC3XzTEgRRhrA+Z1ESrXkO7p2Dk1tDKpLboJ1fTyuYuZxYQRQB0golwglHAOCdpxNGqS4m0wl+zBY+XaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768166609; c=relaxed/simple;
	bh=hrNZpWUScS3zOWmXDW/r1WSv0E6W8BnDA5eInYBnEjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa/KUt9qxM+KngGhQAUvSF/++tOZk2z5uDNnrPmla3Vz7mDf6AF/LZNNlvTw7MSSypVV4gSBJtLw3oaEzc4nKx6EE2vvW31mz7ebWdyKPPnJI2KCyzz/A3i51AfAOdOZlt0/LxB+zZ6lZZk89g4JbB59d57xJ1pxIHJE658jDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhXfo7hH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7277324204so885150766b.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768166603; x=1768771403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQ0Q1EyOWWVCDl/r3tyDScTjDzaDhclLQJzdDcIL3qk=;
        b=lhXfo7hHKWQJkyumuBKSDXCxp5kQjBXqNUr6gsAP1vR/bSo9c0ukfCK6vrH8xugP4b
         0QNGK0JPrUG7SC9z1TQYID0zeBbdb7JLdc7O98UEb6N3uoJEu9LvNt6RM8ZWVstnCETw
         9WmQDvHWfaidZFLNOFvd4Q3wsTievABrsGsXHo0rjEHXIlgE/9tqXgVdcsQkoWBJH2iz
         8oBHgkE84K7hv5X5+0rqA6PRfGYPFwBS83sLL1dR4/5WaH6CIFNHBaRp8hx/EATU/Uez
         oREESSp0wcK5C3itaYtAw9abWditoQcCfH444VOBAlH8mFVzr+uPoM3iYXIKMV8nLOXA
         5d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768166603; x=1768771403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQ0Q1EyOWWVCDl/r3tyDScTjDzaDhclLQJzdDcIL3qk=;
        b=OE0PR89c3JQdzURoM8aXhgzM929FzLZBEsP12YV5Tgtia26UoV5N4kvnLs/u+qxoeY
         b+joQ5Xfykr4q7z/Jqz9ogUv6FaefFI5UZpFfoyiTXAEFQlvUWP4R5KbQcO1RwXEAx+G
         5Ceet+Pao4gfB/TUw0DucubP+4dHZfpgbRE4ARzci5wcymiLAwXpkaJSXJblI/fMN6g4
         ZQYoJSKQmC1iEPYK+Ogp21RNOR6I0d5j3kjDyoe+ImvhCFn9XWiOTAzaqElHMduHXRct
         pRPkOKPuGs1WQP6AIpTYezdv4P+O6C6JT59JYQnV5siBWW1Qey1QyDpILRh8tcGccCWs
         gjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWje7AtzICy4A+EC+S/Naqe2P+wTHrUQxFPIZD8ghcsgWe7vfDD7LxXABNIiERdPA6/w4dJPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p9sUFVDpR8JeDC0Rja5XZTLTBboMcaKioyplu4z/D1uJYldk
	zedodPFwux6q13b20I3HqDY0RfC3lx0ceIcPbT5IavNUzw4h8/levkEw
X-Gm-Gg: AY/fxX7Bw5362z31vKcaR/ZVohP1PQxxMLXanuHHvoq2+nYYoajKDnEqy2aQVSjL598
	7I2pWqIfhRHSpKTD6zbSbpjJfuLt3H1rFCDcY/ltk56mMaqfi8g65L0dHw1Qn0b2SI4XZ64CrYF
	8zLPZMlReThyh5xAT+pX06L2gG74z9KbHLIApSamKVvOW4KRao0Wqn5aOB5+x5IpzSi6slssrow
	HvJLfpwP/37idkKKvcgGy75wXzbKzBiQ3Jpn6mqCMLVLcYN5VBUkDB67h0Hc1OuAJdkcXRQKyYk
	WzBmjShsrDbojfPBzgCryCcsdQWB2m/3l/xhjp50Xzf0RH3BI7nt3GyTanKI2crJxmQm58UjOaT
	CIBisfwHyqN/T1vwQTuHXOX0P8CmG1mJE6jaVM8ky+VUngpKDSPaxIy7sx5xdby3ivfJdd3H2GD
	S6ub9sd/etj0KoQO/5cpKtNDmUJF6Ps6k3dIR2
X-Google-Smtp-Source: AGHT+IE4SD9Js6DcJylwHTqTIwS2RPmaKH1MF2UkoFYIeU8uSCLX6DhVncOA5ljCMLRYi9Fc9iaxNQ==
X-Received: by 2002:a17:907:96a1:b0:b80:6ddc:7dcd with SMTP id a640c23a62f3a-b84453a123amr1554539466b.31.1768166603103;
        Sun, 11 Jan 2026 13:23:23 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f1e95273sm512889966b.62.2026.01.11.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 13:23:22 -0800 (PST)
Date: Sun, 11 Jan 2026 22:23:16 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/8] landlock: Add UDP access control support
Message-ID: <20260111.f025d6aefcf4@gnoack.org>
References: <20251212163704.142301-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212163704.142301-1-matthieu@buffet.re>

Hello Matthieu!

On Fri, Dec 12, 2025 at 05:36:56PM +0100, Matthieu Buffet wrote:
> Here is v3 of UDP support for Landlock. My apologies for the delay, I've
> had to deal with unrelated problems. All feedback from v1/v2 should be
> merged, thanks again for taking the time to review them.

Good to see the patch again. :)

Apologies for review delay as well.  There are many Landlock reviews
in flight at the moment, it might take some time to catch up with all
of them.

FYI: In [1], I have been sending a patch for controlling UNIX socket
lookup, which is restricting connect() and sendmsg() operations for
UNIX domain sockets of types SOCK_STREAM, SOCK_DGRAM and
SOCK_SEQPACKET.  I am bringing it up because it feels that the
semantics for the UDP and UNIX datagram access rights hook in similar
places and therefore should work similarly?

In the current UNIX socket patch set (v2), there is only one Landlock
access right which controls both connect() and sendmsg() when they are
done on a UNIX datagram socket.  This feels natural to be, because you
can reach the same recipient address whether that is done with
connect() or with sendmsg()...?

(Was there a previous discussion where it was decided that these
should be two different access rights for UDP sockets and UNIX dgram
sockets?)

[1] https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/

Thanks,
–Günther

