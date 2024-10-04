Return-Path: <netdev+bounces-132319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263F4991349
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623151C22B51
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505015444E;
	Fri,  4 Oct 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idvxjFbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED102148857;
	Fri,  4 Oct 2024 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085802; cv=none; b=a1TJ/gYvykcTkrDjNuIvbzu+27eGa26Seg18a/P9M6UM5Y7CXonvYMXknoABADGFuv/0n+YEoT+KJXqNbb/vS2eWbcbi71T+RLt+CNGdmdvDfxPFitm8xGHAwsa0dFC8VR3n92G6EmOAafBsZGVIQhx5mk2nER0l2X16sAXEyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085802; c=relaxed/simple;
	bh=IU0uKQ7NNSwfhAvmIZe5KqaQE8LjFvT25OV4aOVkGpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DriwxJPbMGVKIx2FeA4rFC903ait+G816J4eDOxmOrjARk/9ppGjGgs+ql+4vWMBsklkDw1V5jk266DHtQe+5E5pUK+27xqde17vprfsWzmD4QxSxrkV3Um8ksQ50vyVKKZtf8pzYnqIKAWSA5+Wu8M05SGjDfTBy3FBeIBIaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idvxjFbb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e235a61bcbso25198987b3.1;
        Fri, 04 Oct 2024 16:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085799; x=1728690599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OuB8gV0+K6en0YKg8lKAiMSJyhnKncWwHTQm8Hm1+g=;
        b=idvxjFbbev1fXEIHQMeSXGM5FWa88Q1GHWWwU1MA/YP+IH1OiadzXC7xSajsC7is25
         8VKuQXL8R/4qmwV8up909VageBt0DvBPAMN+xNrShxaajTLFxeDEB/zIdQiZSagFSTKZ
         CX2Ov7KMc/wvxEXeAftJyF8Hz7On8cfRfN0MRMZ98uWwp+KCq1wjgLfHFqWzwknlhWAR
         8kepuC4QpYAnUoB1jKQBUmWCWnpdn2OrbaMF08Op6GmyIMNR/u/TXjFsUA6jfZx4RUZI
         VRDSPe/HY15/iP8+XBf3S93vKQtpDHIQ2nYFxIoauSSVvkuv8zsaFa0S00z9Svh1p7mo
         UTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085799; x=1728690599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OuB8gV0+K6en0YKg8lKAiMSJyhnKncWwHTQm8Hm1+g=;
        b=QbgCsixSunVrKPLN0Fjq7NM1KY3Do6c5p7c6AnVlVzTPm/cWTwt85F812thbyh32wG
         asnOBA9EmBlbktKPc33vbs0q6a1PxeP9cIxQjgRSnJZuG/mEFZz5ykTwlv1fxwbRer+I
         JXXRkT8oR4u9EH9N99r0l6jlAXwqq47eJYuQLBLaxhf6ZhoYONCXu7yP8+/A5RjSG41Q
         BwVP7F/+2Pdax8ZqNHbicUJ9SkmByL1v1tTKX9oL8dLwUG7OOiv3sMfUJJYfIVd/edAD
         DpbOL4vaZo4v3smoJJrxcQkLSxBVDvXrsiBZAc4ekzZeqTkRaK4xny9IQjamtdH028bh
         5OZA==
X-Forwarded-Encrypted: i=1; AJvYcCUJn+MxJr4/wk3W/MdWknYIhUcgEtPKY2ueQXFMJ463onp9W19cL0u5u5GQEV+hK+GqyNaNSJcNJ61w+4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37a0E75Y4l++Z28wqnQ6qk9RHOwBV9bzjrwEegRiZUqXA+rZH
	AlKbDPOQf1Wm8DHmTgq83SdSz8fhnOIzGVO3oeS1AJ5J8tcBbLOy9k35/A78Q2/P9UGIDzkOboK
	qhc1xj6j84+xyrpPxBzD930Edc1g=
X-Google-Smtp-Source: AGHT+IEshj4Ix4marHxQfTyObrTWdBhuGm6EYlpou5ri4H8M4QKf36M6ccw/3E948OxmApn6jhTp6cX8nJvubeWqyRc=
X-Received: by 2002:a05:690c:610d:b0:6e2:a250:a1bc with SMTP id
 00721157ae682-6e2b540695amr64076467b3.22.1728085798929; Fri, 04 Oct 2024
 16:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021135.1952928-1-rosenp@gmail.com> <20241003021135.1952928-17-rosenp@gmail.com>
 <20241004163541.67a15dd3@kernel.org>
In-Reply-To: <20241004163541.67a15dd3@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 4 Oct 2024 16:49:48 -0700
Message-ID: <CAKxU2N9GMRUAmeAsFO+fdbxsBctqH-LeOc1-zfGFf2tNrSY5Aw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 16/17] net: ibm: emac: mal: add dcr_unmap to _remove
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 19:11:34 -0700 Rosen Penev wrote:
> > It's done in probe so it should be done here.
>
> second done -> undone ?
> Also is this not a bug fix?
Correct. Looking at git blame dcr_unmap has never been in remove.

