Return-Path: <netdev+bounces-161386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78205A20DDA
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57FA3A7A6C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356A1304BA;
	Tue, 28 Jan 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxoQ3niS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02566567D
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080107; cv=none; b=bySeaWdLvRBIxF1/NI4j2JyHdBX/hywIWk4c8ssi+0gWK5xuW0HSiuXMPTzrowrjMS2LdLGN+x5rK95VXXhYRDuaLawteO4pj21SxOhXND9p07+KOOJafE5dV5cRTtF7r6bG4wmiCHF7o4H3PjTPGJxxs5BOCyHfVDGTZRmQy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080107; c=relaxed/simple;
	bh=QnUjuFZcpa95jeF5yRTF0Bk6ms8xO57cXrUKutIGfc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POnJIXbWQYiWvojXuwkkxS+OWMJtjJ3i4HesaZZj7TFcO4pCJJ0VksvllzKx0s2P6ISR+MNVMYygepwvwDLAsxghCcfGn7/e7zHschReuuMjvMRC/daxc+AvnUQ0D4znZRdaDLdJ0vfRW/4vBMavostRRTazw/iO1mO/2Q75gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxoQ3niS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so11102562a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738080104; x=1738684904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0k3fBlEMZejYNUo/PPRw/ypPzHY0k4b5+Q0BCJEkhc=;
        b=xxoQ3niSkiwePGUJYl8P+lluT+uwIo1fXJqA8QNbrehBB3FOQKqWgK+Qy4ECOheotW
         NiJp+ym5kqT1QyWm+71ydu4NLoTx1NGGCGF8VQHY5Ni4AUjy60LHxWyX4DPIBJ+bnwz3
         Z9AlEeZH0mog1CgXJTbCll28FmY4dLnDFkvdC90ghuCRr4//cBrIzCakBtP8wzH/kffb
         xfJNH8aTkCxZrPinp1J2EGSO0CmyKAg1l8MOZQYon2lLX/H9wIvBvocE/obxzSyRzKc/
         Pi4IPHDANZlzx8g5BaQeCJonKWD9lvOIzXDByZ3pzUXSgmHCTfU/8v6wpLLcnspUPaFe
         P4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738080104; x=1738684904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0k3fBlEMZejYNUo/PPRw/ypPzHY0k4b5+Q0BCJEkhc=;
        b=P4C6qhrqweoi+NuBsTzAyx4h/hpOUjnAYrK68U++i9PxfbcJaqNX3yqZAhL7Cei/LE
         iWfQgMSWYhh2uIZ+Gk44w1ZAAU1vLw9Y8I5B7xyvP9xWH1F/3ps5GkgumNvs9rcsTAQE
         DVKDd9VZLP0tedJPUcw1p3H1BYm68rCxvEtPf4vCQ7enJ3lxxJv6RpLIr7UGUrRlAiWm
         IMkX/HLQhKLLmSWFtGjOn3k4w8UiaTlC/Qvd57y/o0AVkRRejq93Ku/bWghez8B00t6y
         htmGj67rc3weWvu0y8P3FPvDp889IhjxMJppqQKiEYseQgPuAb1Qxb+wIlUqYNv/9gJP
         Xf3g==
X-Forwarded-Encrypted: i=1; AJvYcCUjDLIyfPI23OGXLZeMAxhouPBMDn4Gcb+gsdB9xGA9rzfSHFk219wt/vnIXNGSQO9sljG7uwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bYUbS6fa5OSkIPF/eubwG1lIXhiIz2vTBXL7ZpJtmZfz/LRw
	rdNeZpadzqlUCUz/YDD6QmUrbQoLpthA7El5wYfnk0YbhiWxwd9MHAFJ5FEO+vjgxG0rpaeLhLg
	SMeg7yFCJHNCR1Cy3S45HZZoEH6eDLsAdcizN
X-Gm-Gg: ASbGnctHGe4we+JBOgHMWO3xmlZ7X2Yjp6I3HbmZxWAkhdGXe7LRYckxdGg/rauLf26
	g6PdhNtdd3H/Lk48LJF/65MUpvQ+YN5Hq2Y92y4Sg7g0mGwH4YSHmugOCh53DgxHPE+1RKLY9
X-Google-Smtp-Source: AGHT+IFKI9slu2MU1h5NPeLyxkc7rX7pm6YCOAXMlWPER9QnOkgaz0yoN+LppPpdVLAP4kKt9WlHfaHJiPi32hi8Se8=
X-Received: by 2002:a05:6402:50cb:b0:5da:d16:7388 with SMTP id
 4fb4d7f45d1cf-5db7d30063emr46797233a12.17.1738080102468; Tue, 28 Jan 2025
 08:01:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127231304.1465565-1-jmaloy@redhat.com> <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
 <CADVnQyn7afmGhuUOEzvFV099476pxrAUHE+FVnmiwwbo1tu1oA@mail.gmail.com>
In-Reply-To: <CADVnQyn7afmGhuUOEzvFV099476pxrAUHE+FVnmiwwbo1tu1oA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 17:01:30 +0100
X-Gm-Features: AWEUYZnfRndrMm8DRxFHfmxsqyAbX4so8UYPqtYML_WF08_XVDHZvkww10r0usA
Message-ID: <CANn89iLufFGyW0V-RJRhp928HV4+2JF=8BCPQJvTgpagn_OpOQ@mail.gmail.com>
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: Neal Cardwell <ncardwell@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 4:57=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:

>
> Yes, thanks for the fix. LGTM as well.
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>
>
> BTW, IMHO it would be nice to have some sort of NET_INC_STATS() of an
> SNMP stat for this case, since we have SNMP stat increases for other
> 0-window cases. That could help debugging performance problems from
> memory pressure and zero windows. But that can be in a separate patch
> for net-next once this fix is in net-next.

This is LINUX_MIB_TCPRCVQDROP  ( TCPRcvQDrop )

