Return-Path: <netdev+bounces-199954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCBAE2871
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E231188C2C9
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32851F3BB0;
	Sat, 21 Jun 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyeRGXGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0B3595C;
	Sat, 21 Jun 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750499939; cv=none; b=JRllSj2AAvnk9OEqOUdkL/ywy09aLPIm2HHvNA2A6Y+gb6Cubcnvcjo4WSm8mPesErmwVEHJ13DtHVPMOckO2giGyzhV3zACnKnSWhUiF0EnNjUbV0TxQvmrVnNDS2v+I+Av9brobEsUNDA+jhGcskSUk+478yybS0phHQk8ep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750499939; c=relaxed/simple;
	bh=+lWQaton8jHYGURu3o/Xz4rmZfTqgU21wSWj8U0z2do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfABJNUWCQRaNmuYIG0xZAwGjMV6mSZuVzSdWg5Gky65KJjFNr2SayzhelUtYshQT95p/hwl6Xs/X0XVXHPXrAjdtqZ3QdF5DNynA1920uPEB9VBWQ8flOOSMhqUvYtnDSvfCKu3zzAKAHrDzGjONwTLBG9WDTOEjxdHvumcVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyeRGXGa; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e82278512bfso61873276.2;
        Sat, 21 Jun 2025 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750499937; x=1751104737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFvZD+u/OKU7mgFfbU+SKlo3LtBUSpTtmgMflnAmtV4=;
        b=YyeRGXGaECYXZoPpv8WwUzfIJu0oEQ3ASrTWCXqgwxrZ1ttUPbs8Gk83iQwZOiavkd
         KKc+7P4+fZvtC7siJ6Jd4zDLe2Q39hPbDkvFVGuTAA90VTBKmgiJU+ERwEclgNRsqqiX
         s0XmDPPJR5E2XNzA72eyWGl/B+eisxUygtTXFJZ+ooHsNuR7+Dqnb2x1ESJGuIsAGt+J
         H0eIjvVaE3ZsMqQRamAJHfEHB+hyC5lQKhSdVU4sp4aT40PzAA4ZIS2ADo6icCBA++P4
         UPDIuvNEE2153CPxvRA6zpxDGBKwgX7fb7t765pzOR7q2o5Amy0jsZ/hsCDkduS32K6o
         nPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750499937; x=1751104737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFvZD+u/OKU7mgFfbU+SKlo3LtBUSpTtmgMflnAmtV4=;
        b=BR+9x3z1Udy5b4YK7jmnlr+k/enntG6sF2whUM68PpEj/7+TF51IRhvVH89IZ0bB3e
         jVgNGTIL3v5mY1NqWSffo5YZwi/sLAgdQjGz3v412PMURvwk78kBq5dOkaFSue7JzJqe
         sa8mNdmyhNxO0mVHtXzfFjFQXwWQvI1C97YVSPQZ9TXSrqrSZeGI9dJy0jDvDTpMTdxa
         uu28BBS5kgicCipWXlljs/d6Lp1I3wq+I58UiahD8QR/0lA4VIQVU5tt4Sd9sUoZh/pQ
         5Md57Zuc26ToRO1GcG8+42cEsnju6BdsMI3NCUQqm+4JEAFxbaSqHAnspW67FtzvRMFB
         jWWA==
X-Forwarded-Encrypted: i=1; AJvYcCXQyIr0NHkD4bj55vgsr91diynD0UfWMBeyfhpU6JGWv9DcxQt4Kx+qGvnuoT+VgqPIXSpsjJiL6eo=@vger.kernel.org, AJvYcCXndonioVBqqIcrcx+9mjlUF6hkCZ/l6wujcauTPnhhgqVyLRnEEli7ub5iOg/rbyRencTPeYd32SA6XAUe@vger.kernel.org, AJvYcCXomh7CZzDy2O/cIsbG9bzjzZvA99pk7/7JO5sGDRuLnBBOPNVWMd6jhu9vrGL1mQ7oGJ804ht5@vger.kernel.org
X-Gm-Message-State: AOJu0YyTg02lq4t26QHoYbSOnS6BwqAAoNgrpIlS7bh5yHx3ohzj6cpb
	cfD57cI3svRpdfImRJJEL8pI4lhIWVP1aHrX1w4N+3gVbSPcdTrqh09cPoD5XTH/joub/DcIkNF
	Zq7tBk/qvMIcY98R1O0U13PYKUAqkq5c=
X-Gm-Gg: ASbGncsBlVzdqTBSV5DCusbYRzmIR+9V8UI2EPCyCbqYTGE87BWV6NlDbroxJVZ1vhD
	cGy7yfp5gQsiCpsv7UDjXu9EcHaSUl5d2Du0Mq54kygExpHVlGnisRl4j646g8z2F2uGeswxt54
	hhrMOFp43ZK/jM0j9LcbxHorbCNQEdD6UdjpBbyKWXtAM=
X-Google-Smtp-Source: AGHT+IE3jUH9yvUkBqwnWN2W2/DtvMHIbOBVHjaS2/kK3aydl2tVZaeZ5XtQ8+m3Ch04z0IPOyasJl2Pg/J1sR/f0MU=
X-Received: by 2002:a05:6902:1141:b0:e82:9831:2b4c with SMTP id
 3f1490d57ef6-e842bcf8390mr3687988276.6.1750499936944; Sat, 21 Jun 2025
 02:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620215542.153440-1-abdelrahmanfekry375@gmail.com> <aFZ5OhP3Ci5KzOff@archie.me>
In-Reply-To: <aFZ5OhP3Ci5KzOff@archie.me>
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Date: Sat, 21 Jun 2025 12:58:46 +0300
X-Gm-Features: Ac12FXwmUAbCTzej24qH0z0oXWiUTmicey_DtDZEHg4BcYYXxuh3p054DU3NHkw
Message-ID: <CAGn2d8OT0SS+wYphKBmM21Lo__N_ZFRyZCQ8pL34c0Z0bqDoag@mail.gmail.com>
Subject: Re: [PATCH net-next v3] docs: net: sysctl documentation cleanup
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.com, jacob.e.keller@intel.com, 
	alok.a.tiwari@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Sat, Jun 21, 2025 at 12:20 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sat, Jun 21, 2025 at 12:55:42AM +0300, Abdelrahman Fekry wrote:
> > +     Possible values:
> > +     - 0 (disabled)
> > +     - 1 (enabled)
> > +
> > +     Default: 0 (disabled)
>
> I see boolean lists as normal paragraph instead, so I have to separate
> them:
>

Thanks for the fix , should I resend it or is your modification enough?

