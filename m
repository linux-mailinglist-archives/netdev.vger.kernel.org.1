Return-Path: <netdev+bounces-163870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22CA2BE27
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B173A6202
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439111C5F3F;
	Fri,  7 Feb 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbcwC0x5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B951662EF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917426; cv=none; b=RhKg/lCLQvncp9SWFUP9e0ODPQTNKU22IqoGvOOlLU0dyFMLHZ9aElJ5VwB2pWIUM1auJu1xaY1j0lfP+J3h6f8o5QWgeCaQAulRwz5GyVK0cqv5wdhEbCDGt1PaqMpG/ZKo0c4irePNxOFhI/F864eJgUcRCytWVbXR2GpRVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917426; c=relaxed/simple;
	bh=OMvJT/c+JghhwpdhE80H1921el5h9aEwpYt7SaIKlf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH/LggxTXugf8LvL8gLmnHb1rRIF8jy/7CkcgI159XKo2qXc+PLRnptXK0C1WAV639dqp3iDi1LflKAdfcB4c2i3oOnQn5V/zmp4mM6VF+HrCF7KtV1ECmexIGUVfDRjS1mIwcGGkyaWPSh2W5xdWwZ82Wom4X3zZXqBvoyVJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbcwC0x5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dced61e5a3so3247081a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917423; x=1739522223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMvJT/c+JghhwpdhE80H1921el5h9aEwpYt7SaIKlf0=;
        b=gbcwC0x59klzHqNnH3tle63jw3mKpw6f+ofGLOOniGrsUQ+nbcWoTlryeIWAILFW95
         TWd/TVGdzvvkevkawzBfvLqU4Nn5XqdRgebKQdf5Vo0M1rWkBeQzgKqDiaZCBEws4oM6
         AKtpNhbxnkvmDH9wnch3faydkAcDH5xj11FHMFgvJCgz6y+XC7BCkFCgFZA6kFtA64pJ
         iaCHaiEQdT7eKOmni/XkiKndAUlxXNDvfeLiXCP0QUQoETG8xiaqketVBUYVPeM5BX4Q
         7AN3mFeQC8UtFR0m3Sy3ztoUmiLCL4RRC4MKugFJde+Z/bpCXLqKNZ/TGg4OaKRRGpgl
         FZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917423; x=1739522223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMvJT/c+JghhwpdhE80H1921el5h9aEwpYt7SaIKlf0=;
        b=Hl9OR3dUWTdbJX/71P5mA8CkW/XsooJBL/e06h+LMNG/mn5HoIXunHuaISsDcqLAKb
         JDzLjo4SO0yZU1KMaflUBJSVww60t6gdGhyOPUc4fgOlzq5J4pP6ERoFeUW6mUz5h974
         fxy0kwGJJtTUjBbWmjb+BK1v0Q4A8a4ZoQaptr0FObYM+I/HwpfXP80tbh85EndXkg7j
         AhFu4e7sKHj1Z7k6LD4Vw2wXKIv215onSrnQD+79J7zQgoXvIsmIo9wTS5kBud9++Dv0
         zuBdZqMWx1Ga3HxnhooMsMofgEPhI8T4ekIenfnBF7RW44QBICAZYL04exyOgsjxLbP3
         YCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAdCMsSmGfc2UNdwLVJ9hfGspjgg4OfggJjgi1WHzDiHh6sr35zHJzuDIIVTJ2kET4lFDkyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAW4UmkVDUliPAuPZ2a3EzUyQfRqp4Bubo/Eko8SHbwjvGxZER
	iq3JqcCKF/JNf2nBBoBCA2W/cJfDQ1MlIJNPjUg0y0+xsnaQAxnTgv+uScOwiSwXgrrfa4+5Qph
	6sMkf9NiTn6JvQSQ4pFbZb+sHLT/rmi7jlIz8
X-Gm-Gg: ASbGncsK5BlRvcSgDjP+DsaWNr7sEwCzCk7VTXJPFZaylnJjqRHvHKpX87Mi77ajZ78
	bVGzgE6ypVJIED/MAQ1+haYHVUuHieCaJp9nwXCeCaOqQ4+IvJhISylGjpcQa81MfcbQ9A8iS
X-Google-Smtp-Source: AGHT+IFJPyCcZ1HBgvaP53O7iU8rG+mbEegJ3gvQ0NU+JE9Tl/2ZRaEL0gkbN8274OsLQDmfkZeWE0+peknuWDZm/uM=
X-Received: by 2002:a05:6402:2106:b0:5dc:7425:ea9c with SMTP id
 4fb4d7f45d1cf-5de451074d9mr2574890a12.26.1738917422598; Fri, 07 Feb 2025
 00:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-9-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:36:50 +0100
X-Gm-Features: AWEUYZkPrdAp01Do9X9eP92bUU5yzAsaHhxRPE_MRUI1e84DLRp6JVLzulLPs9M
Message-ID: <CANn89iL+yp_hN0sm6Uavivem63zbCrehzUvBd6dbhhhRRsbLWg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 8/8] net: fib_rules: Convert RTM_DELRULE to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
> from vrf_newlink() in case something fails in vrf_add_fib_rules().
>
> In the latter case, RTNL is already held and the 4th arg is true.
>
> Let's hold per-netns RTNL in fib_delrule() if rtnl_held is false.
>
> Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

