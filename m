Return-Path: <netdev+bounces-210450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A609B1360E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1913AAA6E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F1220F38;
	Mon, 28 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tDzDbQNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8E19E97A
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690022; cv=none; b=aWaAuF72A6qe3V6UgwnGU1/+I4ilPrkb0IPX0S15GvWnbkd4LBQy/NoU+SGA4e1lZWV/EGl/rPPqvMKQIRbz2HUbNT4lQLgtbynfL1eloL15feFjwrVz3HScLByHmRM2PGDK+a0hYdtKdXQNsBYAkgaKyGCk0pJHlwxlEgp38P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690022; c=relaxed/simple;
	bh=il6F1V3EZvaPgxXuexkA60ipkgxSFbEms1cYfVuykjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFpLExZSWtDF9uerN141qeNY1+eJgf3TzL7zNtYIQXAWrOR6QFS6SkxScVlhONDjMkb/SM1CUW8DiVg4x1M0l966FUOjIA4Rof1eB3k+rAIa62w3lfI87DzGOVc8bYoqVN/0urqFENA6hoRjagUduImTjE/0B98MUdIgQjl48Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tDzDbQNq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae9c2754a00so838128366b.2
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753690019; x=1754294819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEoNvXLK4SEQ+X3J17Qj8vDT7ozZpc00fO4Rtvit2Lo=;
        b=tDzDbQNqOgAdBHLygZmJhm1HkFQrsVF0T5czwpZyMaHtCOJFylqaxVEBsugghLbJGt
         qtcicVTi+RwKNBm2y6rEXBFRM1m9/lGm2Txu5p8TbySfhlzqQLe3jgqdNL7yY7DqFCk7
         Rs05CI4AwN+qV4yj6/MyyKJ9KLSC4Lck50RR3qntJV6g/05eRNbpgLLjwmoYwlpVWNDC
         N2+KKNIE4qKwiMQoW8lzBC6CPDNFsP6Nlss75eQ//8pMC6FpKfR+u99Ms9crBSzyn2Gs
         QZpVCws+ETv+k7AJGYP5S89mB1+wda9qXe6DsL4Ar6fwe8ybUqObZDUBYhJ7TfJCzPiX
         R3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690019; x=1754294819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEoNvXLK4SEQ+X3J17Qj8vDT7ozZpc00fO4Rtvit2Lo=;
        b=PM6a/XDE7sq0oYbRCXfmhoYKHk06fH5uyiG+up7kxDqP73J+bdwgTgbXa1oTk65IK/
         V5emzQ2UMFeAaAdOk+XNeslU2+pqAn4n+PM0F9KQ5qcOXrEx16WWvkupvYbp3p3QtRCX
         bqA0VL6pg3PxudiNCVBA4XgA8ye01tWkHRM7uhr0KaeAHKMY3SCghqwF1XRDVgdWkej6
         27gAxqcfYzDQlLJZnkA+XHxXdlbR2idiJTPutrhp6j4N0AUWrQdPQbkoKt2sVPbvsDLm
         b75UOWqRBNRbn9BfuQNnAovDp2Lvdzxov9NwU8PulBrcLbztO3hHQ1AgSGt/7oyaiF6Q
         5aDg==
X-Gm-Message-State: AOJu0Yze4WVs9V7arhpGQFXl1X1wE6FbGlZpCPsrT7TEXGXumVUSbYSp
	Ln+aJmRmm7AHvHc5PH4ISK1BrtKATlpmKqPBj15Ael34TxovJzT9OiDZbcjTLHo8RBw=
X-Gm-Gg: ASbGncuGXTP6v/uYhhWngNF/RgCAChfoMq6Meoa6GxVifZiguYqk0TW8LUZfKpAMun+
	sTDxvUORsJ9SXipURMR6Po3e9V8bTsJ4nu04M5J4WR/GcECbzS66YAFdv+KBXDuQUwKysqSL8sa
	QHgF/srArHlfDylFIaiwX0ejoIbE7l30SZvGw+mLo5gGycxY8u2WDf6V1G8GZRRO8IjIS6HNzI1
	ZyNs4Th3x9pf3ur9xTMEKAPvZSr2xFe+egFgHOep7k4miHD6Q61Qy9O0caPOjJCnZcdp2FFDOfc
	P04vvY5jqr5ghQDO+kLeiw8Gf3TjTeQwhvwlrKdcke8Vf5mKJvkJVzhfXekDEM9oFZxicRU445+
	mPGysFnTyr6dS4XWnUHceS4WjENiKVGjzt0d+42g=
X-Google-Smtp-Source: AGHT+IERxblnoOCYOHAQiO6rqytlBsYokSKccm9wl4WU+Wi8aQMeTB+VQcGSWt1hqYjD8PuGuUuIDg==
X-Received: by 2002:a17:907:2d28:b0:af2:5229:bd74 with SMTP id a640c23a62f3a-af617d0491dmr1281521166b.26.1753690018504;
        Mon, 28 Jul 2025 01:06:58 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff45sm391864266b.5.2025.07.28.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:06:57 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:06:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 26/27] can: kvaser_usb: Add devlink port support
Message-ID: <hjhpopnmorqqo65mw7psmlzmqvzhn2d6x22y2aq5miqsevdkmi@oak2s6kxfght>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
 <20250725161327.4165174-27-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725161327.4165174-27-mkl@pengutronix.de>

Fri, Jul 25, 2025 at 06:05:36PM +0200, mkl@pengutronix.de wrote:
>From: Jimmy Assarsson <extja@kvaser.com>
>
>Register each CAN channel of the device as an devlink physical port.
>This makes it easier to get device information for a given network
>interface (i.e. can2).
>
>Example output:
>  $ devlink dev
>  usb/1-1.3:1.0
>
>  $ devlink port
>  usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
>  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false
>
>  $ devlink port show can1
>  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

Looks fine to me. Out of curiosity, do you have some plans to extend use
of devlink port in the future, or this is it?

