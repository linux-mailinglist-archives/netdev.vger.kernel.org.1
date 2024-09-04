Return-Path: <netdev+bounces-125225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C396C553
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B06B1F2727B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC01DA2E0;
	Wed,  4 Sep 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJTnu4SX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56D824A1;
	Wed,  4 Sep 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470520; cv=none; b=mq2q0a/mQhK8GMtWM5yW9rosF25wzBt7o6lDY3SiQJxu4fMxaFUWIlWDAfVNCmBuJVtlAzREt82DGXjav1jxFkOu+gNwclbrnFT5CCLQJVQBE0bcaGqmBDSTc9VZaFH4zEuNSpkFkTzOlsZb9UmgB2iSqC6vEHKrLIKBfEbn8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470520; c=relaxed/simple;
	bh=WjbnGq1vzsqKMGd29MtiaioUtB4BYtpn9Bt5zlm4WgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XphhFWPSeA6OKBJ4ADnytGOIEntZyd8IXJ6LYMVbFqCENoM47PYLPmH62RDTq2IxrEv7EdgUUFUt7JizhQY3yc+hl31amHswQrSZG3BK5DRavy/GjeJ6aV6hXVz65lq/NRRxwFhHnsiQzcVmE3n/vKpX5uMElefhFP7pavIcRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJTnu4SX; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277e6be2ef6so1994159fac.0;
        Wed, 04 Sep 2024 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725470517; x=1726075317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUzfxGio1jAYqVfMH//HXxgau+jH1IPiPN8s0PtRNw0=;
        b=EJTnu4SXUZGCUT6IgHVLAXcD8ftq9jU9JO+CyL5eVZTisRpy+zfz0aO8nQsoLRf+QO
         ii5B/KO3TqaAyBeTffZ8k8CqkTr10Tg5QJ1H8JQ6a+HiUmTSYiLUeThIcN3s3TXYYN7u
         hoqaXGEaYotXCZbUGz0fd4Biu2kT5/2Iwlw6P9rD5k8qJhAy5E2kUd0CK1pnkgmmuLCf
         qukMxjxCj6trIsGOC83DckGovjn6HqVavjBFYNzx4TWBia8xwYf6YmJhGa3bik7vqfIr
         oHr5G7sf1S5+nm/7Qv1Zp4RS7AIKm3ui1EFovkPnMos/0hoWwQ5b00KdjMzP9kAyN1/F
         Sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725470517; x=1726075317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUzfxGio1jAYqVfMH//HXxgau+jH1IPiPN8s0PtRNw0=;
        b=Y+r5vEOUbXQ68RqosyFx+q6xPFiOxQU7mycXu0u8dR4pCEzbD/SeluJaJJtqauAfk4
         a/yNlZK4Tqw41JCzpKuGVKeSehc/NooZv8D1AVX76U9XkeryEdrNrumkCA22iFHBLyfv
         we6UvyY6vUkimse2yjEVcl7KJy4CqCrV7N/T6uYVmMlo2mUfKz/HLfkDRUCgLEcPd//w
         dHjMB1Sh9OUAgip3l/exERz4i49qAfcLmD3784HcWjSR/F/5v+EHhv6axptwel7o03XH
         WwZe08KKyImw7+s71PArrEoMhsY+1kH+3+txcL156YcUECaqR26UjmX1Lrudj+6CV7a/
         Jcow==
X-Forwarded-Encrypted: i=1; AJvYcCUlW/tS51YpficqFx60VHnQRFxS5YWza9YrA4qW1g8CHPACRCKgn/el8/Y2XLL+HT8UaTvss5BNcpH+IKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0Le8QYnPRqb1RnrMlqnKUE4LAPIVMsaEYpyMT2Xgl9DjIFIM
	k1ifHvNmNiJS6TtvFw4PIII3yKBI2jWCHIVHS7V9jy9b0NaLurKqC/kpx6YmfA9iB1cJSyjBXGv
	0HKwGOMRtjmQEJNWMBA83N1AD0sk=
X-Google-Smtp-Source: AGHT+IHv3U/0ZG1pP7Ck5tFLhSVF1iuVF6tDnao5LVoH265LxF3TxksbXp1hB+hWoDdPuHkD1f0ac8iM+/Kp7a8nrr8=
X-Received: by 2002:a05:6870:b48e:b0:25e:23b4:cf3e with SMTP id
 586e51a60fabf-2780054de42mr11368624fac.44.1725470517118; Wed, 04 Sep 2024
 10:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904135034.316033-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20240904135034.316033-1-arkadiusz.kubalewski@intel.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 4 Sep 2024 18:21:45 +0100
Message-ID: <CAD4GDZwZ1WW-L_+yvj7QHnGRTv0M6QpP3KpL38SbUSMt8dqwMQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tools/net/ynl: fix cli.py --subscribe feature
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us, 
	jacob.e.keller@intel.com, liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 14:55, Arkadiusz Kubalewski
<arkadiusz.kubalewski@intel.com> wrote:
>
> Execution of command:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml /
>         --subscribe "monitor" --sleep 10
> fails with:
>   File "/repo/./tools/net/ynl/cli.py", line 109, in main
>     ynl.check_ntf()
>   File "/repo/tools/net/ynl/lib/ynl.py", line 924, in check_ntf
>     op = self.rsp_by_value[nl_msg.cmd()]
> KeyError: 19
>
> Parsing Generic Netlink notification messages performs lookup for op in
> the message. The message was not yet decoded, and is not yet considered
> GenlMsg, thus msg.cmd() returns Generic Netlink family id (19) instead of
> proper notification command id (i.e.: DPLL_CMD_PIN_CHANGE_NTF=13).
>
> Allow the op to be obtained within NetlinkProtocol.decode(..) itself if the
> op was not passed to the decode function, thus allow parsing of Generic
> Netlink notifications without causing the failure.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Link: https://lore.kernel.org/netdev/m2le0n5xpn.fsf@gmail.com/
> Fixes: 0a966d606c68 ("tools/net/ynl: Fix extack decoding for directional ops")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

