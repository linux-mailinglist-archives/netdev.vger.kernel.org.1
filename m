Return-Path: <netdev+bounces-132028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E1990295
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800761C20F69
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EC15B140;
	Fri,  4 Oct 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laGkxXYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485A148316
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043039; cv=none; b=TrIY+0gHWz/t/jfUffT/ofC/93OMJO9c6g9Nnj3lasVHqCaPHaGeJJP/RUs6uxzxwjbeDbOBmKe8wlbH90MLI3oQIfsT8ASEH6/rJ+HbxKQbz9Jh2/9MFtEpZFvxdXDomzq34Oq2q5uq70B9Ua25Fa5ER+tF8NwhKnBkMMVcrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043039; c=relaxed/simple;
	bh=PiAxEWCQdhTt1IgYutVWz7F704b+qGwn2hjT+7jGqZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4st86lMBXlB835DnjdRx+V8K9EK9BYNS4kZBDmOEThxP2lsNFgA6gBxjnUQ0bLG2j3q622acZ1sqFGYhlzvc/J59uQ9pyAOE6qV82GcPqqiBPAZLOFZn5o3A/TTX6virw05pfugtFtWvM5BfE+G28xEizvU73awULBKgiUS38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laGkxXYy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a765f980dso29096366b.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728043036; x=1728647836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hmsVcFU5dLSiKIuqrtEYH6E4opptLJL10d/9I/1Uws=;
        b=laGkxXYyz0/Mb96YoBhKWkchvSYd7qjB+G4gBwpX6eXXic4fXPQB/UCdgSDhTJIc4a
         7EqJET2IcggAOKEMClTM61FpLaltmqxqXBZ2nE/k39xqS6RQPY1HS2zteGULXVM7Uk/w
         +eYJcIYiRKCxcfMKHkl/vGozRtuQ0hAoIPIVk+sHGzJTb6rj9VLRyb00+UHGALXHew0m
         vuhjHSwiOkOjtzdUPfq5KbNn74mu7z9BYdyrWtwJ2D5mNhA0eKt23RICT22KEsWHjKpJ
         lIyrfHXIPuvO8nfdoC9o3HQ8u67Sn5Dz90UGbi/sN9qNa7cQHKiRp9kNLV6WNu3/ixik
         Ot0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728043036; x=1728647836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hmsVcFU5dLSiKIuqrtEYH6E4opptLJL10d/9I/1Uws=;
        b=A1WDF86HXNuYjd+C+xfyXFOLCvM7ZngLhRSqQkfX9OZMhJ5QRr7qbU6hzPieT2QPk6
         aIGWX1JHZ1duzYbzkD8Vd9L7deLJWeUUqMFqehJZ240PXtm8ApDQBCC0CQmuNQ8GKzWZ
         qUFYdS2AMQHbPkD8JMvUyg7UA5X08/2+LjVdezO4Tzzvq/yLhWeCsAOEhoaSZmx9c61n
         282eg2fEtDMi4tylOTmUTBWF6IbPvuIEaDIHc/tjZR8uX6U2mELQku3Ym4suaou3jftj
         0QRmYAI7lIEYPqAbh+CagtRqjjU1h8CW4ub3ErJdl2f+bj9kVwd2HC3IPrGUZFMweGF+
         wHxQ==
X-Gm-Message-State: AOJu0YwAeh9YRY2FYL1aiCgKV8/s78n5hFdPuC3fO+K96nn0IAAWOyr3
	9rZ4pEbhKvaUAo9UZ+5/goNY6zNySkWmirQDgYpc14rTl33EtZve
X-Google-Smtp-Source: AGHT+IFIDHgdSRRw8zHPxDW8PfRQu44Xi0Hfbl9V+QQYzby1Mql6drAE25hCBuVN4fG9eEzzO/yBuQ==
X-Received: by 2002:a17:906:7310:b0:a8d:2624:1a84 with SMTP id a640c23a62f3a-a991bed1a26mr115145866b.11.1728043035363;
        Fri, 04 Oct 2024 04:57:15 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910472ba1sm215835366b.161.2024.10.04.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 04:57:14 -0700 (PDT)
Date: Fri, 4 Oct 2024 14:57:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net v4] net: dsa: lan9303: ensure chip reset and wait for
 READY status
Message-ID: <20241004115712.taqv5oolktcfhvak@skbuf>
References: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>

On Fri, Oct 04, 2024 at 01:36:54PM +0200, A. Sverdlin wrote:
> From: Anatolij Gustschin <agust@denx.de>
> 
> Accessing device registers seems to be not reliable, the chip
> revision is sometimes detected wrongly (0 instead of expected 1).
> 
> Ensure that the chip reset is performed via reset GPIO and then
> wait for 'Device Ready' status in HW_CFG register before doing
> any register initializations.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> [alex: reworked using read_poll_timeout()]
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I see you're missing a Fixes: tag (meaning in this case: backport down
to all stable tree containing this commit). I think you can just post it
as a reply to this email, without resending, and it should get picked up
by maintainers through the same mechanism as Reviewed-by: tags.

