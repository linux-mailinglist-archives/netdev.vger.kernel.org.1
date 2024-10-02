Return-Path: <netdev+bounces-131346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD098E35A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F2284EA7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613111D1E8A;
	Wed,  2 Oct 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4nME4RF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF918AE4;
	Wed,  2 Oct 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896686; cv=none; b=fCmL3dEfkuOZVxEq2+2jN5Dg7VV2ll+f2bumcq809+iDygXjB5n5Obu9jFrWP0hvmiJuWJRpFnmeZX7CVMuwfaXEpnofhZ0d0kQqgd/J6U3FYeCWrjY5QErTI6wapA+tYDfCwov0nHTSCI2wYbRKHOFz/1mxcoCmmQW4OmaEZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896686; c=relaxed/simple;
	bh=c9U+HiXLCAaRmS3rPnP2xVajPcacDynpI9iuharVdAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REfAzndxVPnWm2/n7QtR40wf/p1C7k6xQuyObXZT5D6/2eQ48Bq6WpgZm96zb+cGAssBw42+pKgKxsDDOauTGtXo/ySCunFoo7n4h+chNBbz04lAC5rp7Lc+v+D3LgsNzFTzF2XotLfkP7aKzNXCCb33fZQ8LaaVu3cuxbA/gtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4nME4RF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db20e22c85so1710277b3.0;
        Wed, 02 Oct 2024 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727896684; x=1728501484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9U+HiXLCAaRmS3rPnP2xVajPcacDynpI9iuharVdAs=;
        b=H4nME4RFaK++0Mxk0bSmOudsQXQE3xRgQY8jZ5WQ87irx+f6dEgi2gcRVEGpl9DB0x
         JAp6a5kfsnW+6TUXEOMyQnSC+tPqiO7dWG0oIlsBMXLdQWqX0A09EteJV2R2U99BuDrQ
         oRNzvpOYTHWJxTZ7s6SUXkC04MsH6xIiyDPTcYSiWBfdwt5+dpO3dRhloLscwbjQKyz9
         WrZ8QCJqy306ev+X72yV1PMrXvWP/RW/oiutMIvDkCc/BZwppUfuaSXniLYl4RSBTqAO
         QdhQ05pZfShMkMUMEKisrmvygIlwykCEqxcUfN+KZ4o/6kEP81oSTCEjSt1mbxpO2puJ
         uKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727896684; x=1728501484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9U+HiXLCAaRmS3rPnP2xVajPcacDynpI9iuharVdAs=;
        b=bw7vnh4n888eGKj10Ma0qiY6i6un/6882z6lf3yplNLTPK2vrrFpKmbRCTrkKgA9EN
         wINlWz5BbjapuV0E9gtSosG/m6cLmMlV6biXTsMMNSxylKDGm9XuqenWajnWvLz07h8s
         jdRK9c5qF1TnwMkjwXf2bnHTrefp68EQ4P7WyJf0dvgvA5bld+p8YJ8AqTyfhxyamYhv
         5i1DRbblemg9CSVipIO78xDibXIRoem0MQeetniZP0ZUJyBuUxuVzL1uRNHRgiZNpJ03
         emJatseqAiHFg60+DIfU9LMIwL1RzFCggERX8nQRycfe9rkIJgiVGg6Ri/twNWfCCwvd
         BUUA==
X-Forwarded-Encrypted: i=1; AJvYcCXimpE4GUzV2SdRVsX9ImNBfKqbOCIMvYSETtTXKV3sbOhhfQNFVz7bpt4rhhrOMUP0Z6+Cv+UlK1+VAeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWTir4AIUS44W9QMvCbgv6rGRLANG8yCCr3lujYqO963VQe8e
	gZDSkwhmrGWelcqeQv9lLjx+x5zxL/QH1aV1woz0jU0Y30PjHGGU//M08uj7WMHoB7wKHcl60Lc
	+tOOTMVwZIK7dJ5RAq2QLIG5DLyc=
X-Google-Smtp-Source: AGHT+IE8wcxMdmxW4haFCEloB3mS/g1Z+ObxUXrmZ73ow39RaipxCAdOqq8hXujri+SKfCPueLiJ1RbLFY/Oii6D0Ok=
X-Received: by 2002:a05:690c:2c88:b0:6d3:f283:8550 with SMTP id
 00721157ae682-6e2a2e4b3cdmr31886087b3.28.1727896683778; Wed, 02 Oct 2024
 12:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930224056.354349-1-rosenp@gmail.com> <20241002053214.4a05ba33@kernel.org>
In-Reply-To: <20241002053214.4a05ba33@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 2 Oct 2024 12:17:52 -0700
Message-ID: <CAKxU2N9aHtfjdk3XYvOXxX3LRwbv+WFfe9omXmxLTBRVTDsRqg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] net: smsc911x: clean up with devm
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	steve.glendinning@shawell.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:32=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 30 Sep 2024 15:40:48 -0700 Rosen Penev wrote:
> > It happens to fix missing frees, especially with mdiobus functions.
>
> Do you have the real hardware and have you tested this on it?
>
> Please always include such information in the commit message.
> Random conversions to devm are discouraged in networking.
That's unfortunate.

