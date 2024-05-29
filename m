Return-Path: <netdev+bounces-99019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607BC8D3661
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485201C22080
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DB181301;
	Wed, 29 May 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Mu5HFaL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C71181300
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985703; cv=none; b=t8u2X7TP/eWqPt7WRKNtdVavicLxow+ur3t3gojWDv1A7VlRoJEWobatYTVg6fIP7c0h9Exdxn+OaqjO0rifH8TEVxjxqnfBXQ2ViFcqRnibywaiuJ94S/Ts5ymLfe39bcCQENWCikYAXeEWXC9O2zMyHAMcbQvutqPZmVMGnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985703; c=relaxed/simple;
	bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YpwHFMgaQBhsoU0DDcCMFdlRGmm6/4ZFU60EFcWN0gxlyF0fwcF0JPYCojnECWjmmFeFc8G23eBMDGYs+x39oZK+3Sq2aOsku+iE6huAcpF13moDFY+QrSICbsv8Cw0snf7xiVnB3OGl8VIYKF+zJTb8unBmThYIIQjdteZgIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Mu5HFaL+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b4fcbf078so473927e87.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716985700; x=1717590500; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
        b=Mu5HFaL+XbDLrI/NqUYLqGXy7E8GuH07LvPvq0mmP4VaTrrXjaIJBJnQ+aRO72F2nx
         1yeZ5bHelP/9OFNMorIYqiuhgR1hgz22s0rW6kx/2yN8LSWdMYhMWX9i07pafLwSSbZT
         s+vE5LmhH2fgLwFWWwNsjl4/V4eZ9poTaqZUcxKxIXbrEL0DmXPS0Z3HJ5BgSnHwnm6s
         kGl5vsf/+/IWDFgPJQO/zt59v8HXAIPqZc7VI5gjWQouTwTGdoeezJmUZGIAIPOXTk+q
         3gEfSzCVBhKdlBx+SWFtqDx1SZmHptPAzMlSFOssyRzpnhM1xNRxzz1EhFDx9+O9+mDu
         wflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985700; x=1717590500;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
        b=LVBwyfGOLd9Z4AUYqidcM2+jIcRjHbakwxIy0PqJ3XKDlZzj7welCrD1A52tiy8mnz
         FVlBMWtZtWFsXrJC0Qxrm/gdFCGm5+QXWq4JxMV692FAJVq0SCleC0WCBdbE20mOp6yV
         gCMoGV4QYE62uiaQYSiDBZjDBtTuYF0zvSXe14iwJK8jDc2CcRiVToIezXQnVb8H6bBk
         OAoeHz1r5TZhoFqyd7LK5O36Db8pyq4LYTxJsabH5KQZedbL5skx9rMSLHbnR9xiZ7zo
         pAt0RX+BettZ0KmS7tJ+37RDYf4imYUy512RNxD0N7zmFk2QBha+EN35DWFg3fyp8Zll
         Uy6w==
X-Forwarded-Encrypted: i=1; AJvYcCUopNAIas2RpZcJrrEw88EWzPEuCDgbMueIkyvqr1d1DEgO3te5rrk5m9uwQG8mHhRyrWUjAS4hRgfTRK1DfC4onSsPc4qa
X-Gm-Message-State: AOJu0YxHixGyePr+bmIJdYv3Vsdc0wvLYEHtfSGWGX0DhdHOnwwePx94
	aL/VTd2KVfpMSwra9sjU1yqbSshdyJrjZCnUcwV/qgORsJAkXBu9iPBUjRaw/ZM=
X-Google-Smtp-Source: AGHT+IFrWAzaE8PQPbS1lHEQsHNbjtPO4EvO4xqjbtrm6Bmcj+RR+5EVYRO2id5/xurwQ7KIt7jVaw==
X-Received: by 2002:a05:6512:1388:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-5296410a55dmr11510790e87.3.1716985700463;
        Wed, 29 May 2024 05:28:20 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:cd2:ba1a:442b:4269])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bb86bsm8025057a12.97.2024.05.29.05.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 05:28:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net] net: smc91x: Remove commented out code
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <6f596a8bf3f0ff2c498e7b6cf922fa28bd0dbef4.camel@redhat.com>
Date: Wed, 29 May 2024 14:28:08 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CDEA048-9955-4822-ADA7-DE4A5E85383C@toblux.com>
References: <20240527105557.266833-2-thorsten.blum@toblux.com>
 <6f596a8bf3f0ff2c498e7b6cf922fa28bd0dbef4.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 28. May 2024, at 15:36, Paolo Abeni <pabeni@redhat.com> wrote:
> This is net-next material, please re-submit targeting the correct tree
> in the subj prefix.

Hi Paolo, I resubmitted the patch [1] with the correct prefix.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/20240528160036.404946-2-thorsten.blum=
@toblux.com/=

