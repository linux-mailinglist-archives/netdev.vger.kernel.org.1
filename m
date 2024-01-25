Return-Path: <netdev+bounces-65969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E183CB45
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F42B1C20AAC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A11DA52;
	Thu, 25 Jan 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWZ77zs9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D9667C4E
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207978; cv=none; b=j0oIJ0ZbqK4OR/s7Adf9Q7bt/+tGRpHT8/23beouICkoOLbvffgOHwDC2J8FDFHADoXqPLdf2MQIbTc2U80Dr6oPHyqr+BMvIT8W5F3MJdJDNzeThiu+PICXBv6XF2EsUMrueIMww/fFCEt/5GwHsvvE7L6id14tPD2iMvCxz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207978; c=relaxed/simple;
	bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djISfo8ZTQz47FJZNVHhqA8gX0sahadNdeLAWO5xUBQTVjI3x2kaRq4B1z4XgipBa+jRU0V6jD1EKmLR/u36Zf8f67c9yF6dYpOc5s+HY0X1x1v7YfSFoOzww3FVri45c/dEmqpKwacxBRSr2yL1BS5no3SRjWzT6Tb1XeVrhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWZ77zs9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55d1d32d781so1181a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706207975; x=1706812775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
        b=IWZ77zs9J/qoWM5QZKQB4pfqTSLSiqa9VJk/UmhF5N99G5vD/eiT8tCHlzT1efZKL4
         uvKO9ekrDpy8n5GCcfRKhDE9A87K7pMzlueZ+Kps5W5PJqUEPU2gwzRatU51zhMRgpEF
         VxCKhC7mrzmRcpZXfZyaxdNVVaU65IJic5gV9wGuXKLK2CRgtXe5dLgxPniUVk+Zdz2N
         lGvtpfaqJzFEPPE8U59i3T1Xv8galiP+rRbM01rL37XNwjZSKGLOMmOniUXxHI8thW5w
         XemnqDvhyyTI/BlH91JWBqqNugncsA9/RclTAyJTycWTHzjRm2BbGfSyzHCvcfo6L4hQ
         utcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207975; x=1706812775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qzr72NVpztS+VsR8Xuz4H4tBUfqz1ueMQ10iqiK5so=;
        b=lHUmJPNg3ZKDktL3cqPALLNhBbGMGHRP0ZDTNwYVpAvanuLfl3bR4BpzrADMJ8Tenw
         /xdUSSjSvL1wSpm4ZZRGlC6aVMdXGyov9qOn5DQrQsXdtFxEjUCqHuDeqOh1HqPVCy09
         W4TK8TlhNnPTRRRlSL3qwND//j3HrOAw10MYUtdqZMH74U0oxg/yaFRKAOBWsPLak5Ad
         vHTuRKmtNha1dEbvc95nhIe+8OVbdpl2l3G6HmWJqbU3ioizTgCzI++/9bgeIXtPF9Ar
         reLbrcOmLjFzMSqenTVprpZIXeYM74P0FYLR7WzmCGCIfEF8E/14joURP7wb3TlXYyBy
         R7/w==
X-Gm-Message-State: AOJu0Yztrdldl8fGocC6odxS33hvy+5Xlo40HCXYXVq1NWLaH6Xy1ShW
	l/42a7b4qZg/KXCYrMKh5T04m36w0TRftePh3kRsE+NoPQ0GovqWGEZ5kaZbdsNPzQ29nSglRKW
	I3MmvNW2u/lIHgR8FTdlYZkpfclq3NjBSeW4+
X-Google-Smtp-Source: AGHT+IE9TufAul9ACVnK63eRhhh6wJX0wYTC4/+m7Dv2ToPVvg2UJpJEaTqAJohERIMgBrXj9v5cbCdqcG0/q3edQzs=
X-Received: by 2002:a05:6402:a44:b0:55c:ebca:e69e with SMTP id
 bt4-20020a0564020a4400b0055cebcae69emr221508edb.5.1706207975328; Thu, 25 Jan
 2024 10:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
In-Reply-To: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 19:39:22 +0100
Message-ID: <CANn89iLjpY=YZRBQdJdqOTvS_HKdSXeuaOA1OY2k5VujATz3iQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: give more time for GRO aggregation
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:09=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The gro.sh test-case relay on the gro_flush_timeout to ensure
> that all the segments belonging to any given batch are properly
> aggregated.
>
> The other end, the sender is a user-space program transmitting
> each packet with a separate write syscall. A busy host and/or
> stracing the sender program can make the relevant segments reach
> the GRO engine after the flush timeout triggers.
>
> Give the GRO flush timeout more slack, to avoid sporadic self-tests
> failures.
>
> Fixes: 9af771d2ec04 ("selftests/net: allow GRO coalesce test on veth")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Eric Dumazet <edumazet@google.com>

