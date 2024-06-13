Return-Path: <netdev+bounces-103347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C328D907AF3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA95C1C22DA8
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4814A623;
	Thu, 13 Jun 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N+ZqosIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658D1304AB
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302695; cv=none; b=oieyM0FE7Rva5EhRdcaQ5QXjhdmXehr5AkVw2QeIvp7dQP/WirCJjTMSRnqs6wHcyDQa2Lh2DYtlzPlJQCEoLfcjtg1+c9cvnK5d8Xr7hVAoh307WvTB2t+wiB6fEldhdDy5lAFf8To3tqAofZnXuqUt64MXji6YFZC4Is3blGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302695; c=relaxed/simple;
	bh=VmpvWSzugIB9sHC+Poxu1Uf7slG8yypxWRCwzH/6k54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moor+z6VwYQKHZJ7wIX43BuzfGL6XhWgphhMW+tD64n3PsuQdk9lvt56xg8S7ZD+4ZTAaHOXfgBwKSs8EkM5UeJhdO0mvLgGrEfTOpwGKKDYrA2O5IppZw15jxFvZcHU/pBO0co4yqVRbSXXjuV6raK1dllhPP793Bk102nTqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N+ZqosIY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so14560801fa.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718302691; x=1718907491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U32F52trfP/t5Glv8Me8l9/yxhLD4fCfQobPR+5mCxw=;
        b=N+ZqosIYQRBpwNBvO0WpKhEwRUO2RzwvI9d4SFdLeUeA907dPngkkJpBI30yODrlqQ
         BQTSK7fsOBab42H3DOFes00qdUdrMevsCAYATRLqjF5rAWtHRQfeVBY00t0iyuQIaS0S
         Vf2s6MS+t7szcUY5VBLByvPO/O4bfhJewfZdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302691; x=1718907491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U32F52trfP/t5Glv8Me8l9/yxhLD4fCfQobPR+5mCxw=;
        b=eITdPKM0xbRznua0PCPxLBeJT844FQiTztScNS98wcj1bzr+McDrU1YNSXPpRgOeCw
         Uqifhdl+Kqja+vL4mFfSEo4mx5EjwcwoSKTFIALYZ5w+oOOSrGSfMEKqTevrsDGxaflL
         7CSv+Ph33zd/wRomtRH43Ml7CKQaLPrCI7tcbzvxyw/EZd8UnlicmjsO2OMNLDmmu1Dw
         QPRDRA4M0NTXCqMVOpL2mqxK0ef6KTGg7yaFR4HCOQU/HMgnAchNHLkq0LiPtvUIhzHd
         5KjtnmHVAtsazvJV9xLKOLVE+JHDU4+SaRWVPqoluldhfhXy7l4Xjsne6XgGzoZzJxK+
         /m9g==
X-Gm-Message-State: AOJu0YyKwRC1gckkhZBLQVqf4YcTFz6fxG3PMqz1aQOwP8Xfwk8u1GLy
	02xuqGVv51yWIObpGhXHCGmisEVmJUwkooRVZoA3jDla5J9BAiitCTFFhVOVFMBIUOqOcIoSa3b
	Xq+reHQ==
X-Google-Smtp-Source: AGHT+IEMJYduikU4h5BJzIpBZTCSOWskp7z0kOPAXC/MaTzO7tKT1Twb8i/8+OIFCbZRDWGtJKlVnA==
X-Received: by 2002:a2e:3505:0:b0:2e9:4c17:9c83 with SMTP id 38308e7fff4ca-2ec0e60e9a8mr4277281fa.47.1718302691058;
        Thu, 13 Jun 2024 11:18:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e79asm1187994a12.74.2024.06.13.11.18.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:18:09 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so1961102a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:18:09 -0700 (PDT)
X-Received: by 2002:a50:96c3:0:b0:57c:9c5d:d18e with SMTP id
 4fb4d7f45d1cf-57cbd6a85e1mr446474a12.36.1718302689163; Thu, 13 Jun 2024
 11:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613163542.130374-1-kuba@kernel.org>
In-Reply-To: <20240613163542.130374-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:17:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
Message-ID: <CAHk-=wiNgwEpfTpz0c9NXvZvLFPVs15LeFfmhAUO_XhQTXfahQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10-rc4
To: Jakub Kicinski <kuba@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 09:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4

Your key had expired, and the kernel.org repo doesn't have the updated key.

But for once, the key servers actually did update and a refresh fixed
it for me.  Whee! Is the pgp key infrastructure starting to work
again?

                            Linus

