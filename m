Return-Path: <netdev+bounces-127564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAD975BB8
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E7C284A86
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8913C1BB687;
	Wed, 11 Sep 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2Escrqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58181B9B58
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086514; cv=none; b=PUbCzAwau3JfWqoW89NVNiq1jEgN8f1w03sCrHqD+J3Zdu+IUw1zBdItTbcC3xpQnVFY4+dw1hLfaKN8DInSfBgWruegVPPXfXabogw0LD8lLjaKJmEnqi7/TOzEpmhaqgnSy9XABlC/owYVuqH/2vq1W2qQRmGo07rXlgXhqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086514; c=relaxed/simple;
	bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG5YzS1IlLmqw9ic0xlOXftBZT5JcmxWSsnihtc2yneguZcMahM3NuFqMKeQ8oE+i6dqXjttHeKOoGcs2cgChUMWFyI5OdMHplrwazuxRTsVEmQiRrY8X+h1PScnGc+R/TgR14+DZWR31abJICM4I9dWZwjK/HyP2tErL8GbHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2Escrqw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso32726766b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086511; x=1726691311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
        b=y2EscrqwpVH3pB/UhU5NfSo/A9OhSB3kz1RpCXA0vfUE8YjNidl7zSeI82XaZowlWY
         yY/YHV/JX//3qPVGkY8h3wUdiPt8BCApYGROFNjEP4KMQO3Za0twr13t20ChIpNolT//
         L+50YqQo+rSe8TnvsHNT7K3e5GFujYl9B6xSR3nKD23gXiJHQIzyJjZkAkB7GfuOj661
         BCM+l6oKJkGkNd+NClm+1IwK/wMb2c6nVcS2Xr/gi+yHYoF9HVoo1JwSUHkzAXoOBpYY
         ISpTW1VHn8lb6GAoBrox01NKv/GCLi6gG1/3vca+c4tZIJdYCOFs6SLGj4s82KWbbj8Z
         6nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086511; x=1726691311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
        b=NJAgwDdhhusoBGRDzb09fhhbUqIeSA68vay3T6wKLBO52cOl5put1YKArS+B8Ol6tj
         NoMhssDLLSlERd+BErIG7DVP2wlGt5L9LFBvi6OpuzgCRw17fx3TtmgK1gCl3+2/N+4F
         JsHMqPgXrs0PY92r02zwoUJF7jhG8vBpUBr7LKa0/nVLFpLGWoOsmfIr8Igd3j7N+cXv
         FBBTqKyUNDKzThyAXRo1QpIt9yQdMkeS7XmxUxQP7f9vNV2g3foFLS39oC1mzl7oxfju
         JqbZUzLIPI8+9LIxzR1ZO363cTaMwlqEQQmSkDH+tf/di0+tcgoRNIXAsXhLjaCuK6+J
         PgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKTrE1JBcOUsikxApJXYzvL/+IpuDOVMskK834QBX86Dl6ifvzF9l06C8PENUc0b0aaT+374=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQqZDIj7ZoUCIwWwRdh1mK2cH3FeSWTNtT9nZFJC1HF/z5VID
	jwJtag+lhqWI06lP5hfMAerT2N40yx8TFG0miq2+BwQxj3f8HFHUUWuPDBWNZb7oXsDGtmGN89Z
	9Ps/BE/y0WjB8hJ79a5Mk1PSeuju2dAAegg4=
X-Google-Smtp-Source: AGHT+IE1JTK1sFQHs97L4wT9wvWzmtPa73nwdZf7uQ5sD1TNdIQ8j8nbn+WMup9JYuaytW3c7ndvgccSw+DzEe4DBzw=
X-Received: by 2002:a17:907:6e88:b0:a86:7b71:7b74 with SMTP id
 a640c23a62f3a-a90296789b0mr49993666b.55.1726086510729; Wed, 11 Sep 2024
 13:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:28:18 -0700
Message-ID: <CANDhNCro1syRWZcWA61ViowNV2CPCsOaUFAkDi_XGvgOKXYqeA@mail.gmail.com>
Subject: Re: [PATCH 02/21] ntp: Make tick_usec static
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There are no users of tick_usec outside of the NTP core code. Therefore
> make tick_usec static.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

