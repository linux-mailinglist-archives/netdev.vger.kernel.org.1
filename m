Return-Path: <netdev+bounces-117511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCF94E24E
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17AFB212FE
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14201547C9;
	Sun, 11 Aug 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tDUEH0xL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C091537BE
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394150; cv=none; b=NKjjRjo4hbEAjlJVqYPeJXa5PlM/vEGqesN4ncRTk5YHIjtfGg69VbBc9BmCOrw+sVyJ/QNU7EsWRCK8c775vd9RlO9efPGNbDLBRBSsloXDDvgF6itmmbWeiYzj/igukBBvbC350/2XTJxFWehHxcKh5W1Em43LJ89E19+vQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394150; c=relaxed/simple;
	bh=K5Q/qDF/vB6+ByYhK825OFd9KkAdy/IKMEmoUGikr0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpCKY9WWRk/viFE53HDvR009T3N9gAtz7v3uLGvpSYBgtnLp/VhCi6/5cMf92I+FC9xlKo+cCAbEJ+0zFq/RRlw1GrbCRGpCh8Mxv7HonZmI5dfAPMXk/px9gscbKKTQbCCaBofrl8USZ6M2XfeX85cN7MxY0UDCsB3cP4ZVXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tDUEH0xL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-200aa78d35aso12214645ad.3
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723394148; x=1723998948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOW17F1DngMKq69xDq/s1xLe0Y0ak/ddlcdurf/5tdU=;
        b=tDUEH0xLxn9f0/3RWw9OdAt74otavLEdTLAF5wvVgNZu0vOAbb+Kzj6ZTKBv/mM605
         J2zcOmRbFxBPDEPdgC6S5oJ3h5SNbEpAj2iZjN1bhKRgx5iEBpkkopZ65GS8FJPl0TG3
         tEJ1PJ7EYr5AfMsYSkEceiBPez0vxi1ZnUa6X9wRCbev6k+3EU9Cg7BuvE0rKSqr5VfJ
         oKiueIq8o7MmJcXqyB9fIGL4JKhgCpBehEN88aq4BW4GgC9mESFrqa+eMBshmDPLD5t7
         FeQMf5rW0CwVpe5MEzXJ1dFK3hD5Bp/r5TAfeU1/PYt8XLI/IMdYhDva68Fd5DdHtQKW
         mBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723394148; x=1723998948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOW17F1DngMKq69xDq/s1xLe0Y0ak/ddlcdurf/5tdU=;
        b=EEw6XjtOzTbyxz1f77sasUzwye/umoUF8t4ogOiFuvVm0jC88HNLyvGilQewgm21Nr
         V5rL3Dk4CvDd3e4xVsWwlsKXnhSJ0lYPYIKJACPX9kQGYaZwOL0XI8BmaeejVpdRgCxT
         G7osIsGBxMHVJLez566tgX6gwM6/qtNGPEKzhzPpyi1Nze5++PWQSa7tipg89RgB9pTO
         /YZY/2/gJlZ3c7QWaxAFoZHeYr6Xubn6aH8zFI5CJ6RGMwoA1wYGvVJIY9fhc52AcixW
         CbD0h9imEQXuszfK2ux7xqaVV/yLf9MLyqCNsSI4ZabvQfk8DUQl/xCpW+v9VUt6vwtE
         jhig==
X-Gm-Message-State: AOJu0Yzz7v4V3j2wGy8kNUkDsDa9oDMH48zbpZYsUc/h35FwPD0JZ+wf
	QH2U3Bx6+caKzagOswI+p5JQbUo0Vz5ZNjliPNHziVQMUBtlt/I243zNfwlfF/0=
X-Google-Smtp-Source: AGHT+IFy8yZ+jcFLLtmABoCZG0iyhtcd/HZKT+0AhPQvJBZ32jsdoAVMl03eqiyCKhplcbUjQH2kbA==
X-Received: by 2002:a17:902:f691:b0:1fd:9c2d:2f27 with SMTP id d9443c01a7336-200ae597567mr49833975ad.24.1723394147752;
        Sun, 11 Aug 2024 09:35:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eeebbsm24468355ad.2.2024.08.11.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:35:47 -0700 (PDT)
Date: Sun, 11 Aug 2024 09:35:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?= <tcm4095@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] tc-cake: document 'ingress'
Message-ID: <20240811093546.52c88499@hermes.local>
In-Reply-To: <20240811142756.12225-2-tcm4095@gmail.com>
References: <20240811142756.12225-2-tcm4095@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Aug 2024 21:26:17 +0700
L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng <tcm4095@gmail.com> wrote:

>  .SH OTHER PARAMETERS
> +.B ingress
> +.br
> +	Indicates that CAKE is running in ingress mode (i.e. running on the dow=
nlink
> +of a connection). This changes the shaper to also count dropped packets =
as data
> +transferred, as these will have already traversed the link before CAKE c=
an
> +choose what to do with them.
> +
> +	In addition, the AQM will be tuned to always keep at least two packets
> +queued per flow. The reason for this is that retransmits are more expens=
ive in
> +ingress mode, since dropped packets have to traverse the link again; thu=
s,
> +keeping a minimum number of packets queued will improve throughput in ca=
ses
> +where the number of active flows are so large that they saturate the lin=
k even
> +at their minimum window size.
> +
> +.PP

Hadn't looked at the man page for CAKE in detail before, but it appears
to be trying to pre-format lots of stuff rather than using man format (nrof=
f)
like other man pages.

For example: indenting the start of the paragraph in nroff source is odd
and unnecessary.

