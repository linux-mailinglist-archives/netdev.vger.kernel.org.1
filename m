Return-Path: <netdev+bounces-127567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DCA975BD7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993E41C21241
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849E414C5AF;
	Wed, 11 Sep 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCmmK6Mk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D124B14D6E9
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087017; cv=none; b=FYr3aizQAC/DderrC96vDVC6k9Z6tFTsLlQYUFMG2pY+zVtJXDuyfusnCZK+qknWGWH8XxsT/zc4eZCqlbAXguyT3c1L/Id7ZawEIgQRZYYmkzua/YqHsslbk9jbPzyzLr7YM9voT5sdHeduV0+FvXXIo8vnHBwOrwtcuSWqbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087017; c=relaxed/simple;
	bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUKTGHeLPiYRHsrdaRjkGgkIYuuSDd3XS4Wp5VI7LHunn0OqJG+S8V+aUBGjAdwQlcU9DBtTXjq1L4nIvOnb3xWtjDQK7RsCHmPhlIIq5tBOVHQDJWkbO+74si2UP4nOzoUpYQszM2mqa23WKzSwwMayazsjeoY7F3C7heY3MhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCmmK6Mk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso29124766b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087014; x=1726691814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
        b=uCmmK6Mkgqqr+cDYCM9EtiXzngEgUgjzDne9WsRHG0jUSycpJ1P95ZsD50HOxWMrgH
         fgHIxBe6dKn0Bv6G/Oc3PAf6279ARTg9Ejpu6SRCttBqMsaLyOqW4P8sWeC7r/4tRogP
         5mUAIq4HdZT1cp8EEZXRvs4r3dKO3xS1JYq/iUPA204v3O9RR9lbwRifZoCa12IdQniQ
         +y99/QrzjadlvVPdonc6z4dzD7+VbZ0eS+8xbNrrYsRMX/NKfDFJYJELIGuhgDDa8xmC
         gZc26BozrONm0mblumOSgRxqO9bASr/EvRUYkvgFU/wzZCOpvzPyiDq/7hy/FNeaygbl
         Ul1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087014; x=1726691814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw9yAXR8rk4p9Ffamo+FQ8Lvj3P8KR87sahb6gOn9js=;
        b=AAKJGZSIl8WXL3eBN4EvgY0pkz3kExgvvTBMS51/hz/SleIWaVfcf7MB0K3rAJbVtv
         sVO32YoDKePmmfH2GTTtPU2V6yc5hb5VztstsTK4lEoi4rTlhfoqVGDykLtnZjMx03n5
         U+e3aaCRc+duwv/wWBAmQoyxOz+YdNtJGuDBLqWlPlMu3sHJF1zmFyVehtn3cL305B7I
         B/UMNZmXQnIdMNaojRh4VF0lD+DuPX2HL5d5JkkMS+mdlON5A1Ycsd8ctm+ZkA7R2JxJ
         wSegVGJ7LkouGtjRnivIEqCX6vw0XokKxKEsxUmhi/wGwk/lDkBBkAedq0LSM/snNpDH
         GC8w==
X-Forwarded-Encrypted: i=1; AJvYcCWuELSGn+3dv2ci3Fx1X2ox5b8PCU/LAEdq5NrMxAmEfSlmbFDGLRcLIZF3rj/EwUzZTA3z+0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YweiVGyxbIZwbg+tEx6hYwO6dFuY0eEzXzzFenVxDRFU4Bxqn/4
	U9/KrPijAA1uX1heMN12BxPvWQWAxtQBvX9cIEMQCqaF5zR6e9X99sXeWlxToHCn6ThYbHu2PPB
	4NqWcbzBnbFTtG2H8PT4EfKG9EKyXBU8H/qc=
X-Google-Smtp-Source: AGHT+IFlRA/31VVjyLO6IgPZgimZuNZEpPlP6ku769FDbIwcGpgPhwzV47lU293LtufUhrwsWjhHkWk8LifM+eC1/3o=
X-Received: by 2002:a17:906:f592:b0:a8d:3705:4101 with SMTP id
 a640c23a62f3a-a90294cdcc7mr55683966b.39.1726087013614; Wed, 11 Sep 2024
 13:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-13-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:36:41 -0700
Message-ID: <CANDhNCqoaK0o_8Us2BgDb7DjEU-f3YmXE6iOA+SBqX8o_jSfRw@mail.gmail.com>
Subject: Re: [PATCH 13/21] ntp: Move time_adj/ntp_tick_adj into ntp_data
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:18=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Continue the conversion from static variables to struct based data.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Running out of steam to review them all closely, but they look sane
and simple, so for the rest of this set:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

