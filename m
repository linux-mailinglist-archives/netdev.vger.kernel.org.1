Return-Path: <netdev+bounces-55374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A480AAB7
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FE41F210A3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35239867;
	Fri,  8 Dec 2023 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Mb5EZy0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E2E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:27:04 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d06d42a58aso21663945ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702056423; x=1702661223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RcOBIzRYOMS5JsQCRUsvT0D4LEmFXOmUM5r/xRrc8o=;
        b=Mb5EZy0RJEX/EacPdwVwpizMEGyeguFxTwLMOJIh2Wm1rUog8P3hsNyHOL+kI30vLQ
         SYP0k3jOpmM5F5VaVZ7l3UehBLuzjrciHQNnULGBkRQVhzjAjIoAGcT2p1HDAbroSmj2
         y6j4pDlyroGm1vIVUZHomDzhE0oG1+qESKi9nfVfG2ksD/UHpnIb/QJpiISDugjozFm1
         SQj/iJXd43/8hV53ULbOb5z/iqoTUm5LKXiCBkUkaJkWYksYk/AJzMMg7adRm+L5vlwY
         z9YsjWJZQULL3tBCf7hB02mqhMWoZdF2U7BYFs5av4xV6O8PiM4yM9vcJea9IiJKY4UG
         NiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056423; x=1702661223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RcOBIzRYOMS5JsQCRUsvT0D4LEmFXOmUM5r/xRrc8o=;
        b=T6B1XO7G7qMha8CX7UurLbJ0EH/idzZs9rnN1BeyrZl1Mq9Q/+pygaZ12LOasBh5xp
         4l9qfn0q9VnbSvPS1eizaRutqZHEj9W9s+ZLz9IIDaGj6wXv2TiOoK+NBlsGmnMq1lwY
         ilm0Yd1K3DPC9zqVP7yZnKG7xA0VmOnbT3VMdDZtc3pxKPhlpvEtg3spWYHarrT+JJx7
         BRycHLiqDwI6i8mUikct3BYYCXUsXP5kSSxL6HhjgSF9XN5sgIK+BYFc9hI+SrX5o7ed
         grMiuYaepAF4E+TwCXCaTAxVXYp3FMR6cBsGFy0yn3Uv2V1f1HJ5Crtxp89KnaJpTjAh
         OQTQ==
X-Gm-Message-State: AOJu0YwUhcOa+ZDPfy4NeG7vMjRHcbA7Urt4Zs7ZUqzzCQNb+lVw2FbY
	+JDogT9RWoPaPBSrCJrJBJUvtpXZBZ0SqQO/ChGusWPZ
X-Google-Smtp-Source: AGHT+IEhYtASvh7DZilRhvRj4wAh7m878GYFCaiysztLlSDUz+nOsm8xW5LIHgRw+xsqVN5DYmKf+A==
X-Received: by 2002:a17:902:ce85:b0:1cf:ad5f:20ab with SMTP id f5-20020a170902ce8500b001cfad5f20abmr349972plg.19.1702056423603;
        Fri, 08 Dec 2023 09:27:03 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001cfc170c0cfsm1948962plb.119.2023.12.08.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:27:03 -0800 (PST)
Date: Fri, 8 Dec 2023 09:27:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: Re: [PATCH 0/3] ss: pretty-printing BPF socket-local storage
Message-ID: <20231208092701.52101740@hermes.local>
In-Reply-To: <7f656048-314b-4c04-bc2e-cd29ab649f8b@naccy.de>
References: <20231128023058.53546-1-qde@naccy.de>
	<20231128144359.36108a3d@hermes.local>
	<7f656048-314b-4c04-bc2e-cd29ab649f8b@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 16:01:56 +0100
Quentin Deslandes <qde@naccy.de> wrote:

> I've submitted a v2 to fix Martin's comments and also improve the printing
> behavior. The updated revision reduces the number of lines added by 50%.

Not sure about what best format for this is.

> 
> Regarding the JSON output, is it specifically for socket-local storage, or
> more generally, for the whole tool? I agree with you anyway, but I would argue
> that it doesn't fit this series, although I can work on this as a next step.

It is more for the whole tool in future.

