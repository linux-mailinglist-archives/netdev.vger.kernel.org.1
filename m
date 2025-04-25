Return-Path: <netdev+bounces-185973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A13A9C791
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FDC1B8158C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A90253951;
	Fri, 25 Apr 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UXjUD6ju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27335253949
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580378; cv=none; b=FFThtvPMAulB2TnS/Bal4gacdHzffzR8wDmfi5wondlKHe5LusgoqBo1gKusYxYG3R5WlhGrVXmWd9JSesFIu/L3Zghi9ireQ2enxwJRoWC2AqPMClVUQraMmsZPUWVEspYgMSjV8DSVIlyTl/p9g5P9uO7RRfPPQYCc25LP9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580378; c=relaxed/simple;
	bh=TbOi3l6eQ1ZjiJNkRpjWBtJRww8/p5ZYN6oETyfDeR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZTcS1HObth3iSHXvtlDhNn4m3ixPyQ8G1e3Wu56TogJJQbDDrMchQW/V0QVv/Kxx8wUjPxFi2rP8AnaMpbtg+RkGKNFHy5ioijpzA8+iZfPaQMxeCPR9Oy4oBOFoeN4MTgSAi+qdp8C05aXViQCcQ0tjuFd82Bp6g2a8EsO3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UXjUD6ju; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso17305415e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745580373; x=1746185173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSss1QzBq0N72AWJKw63wc2GhbDCTVccqMU/TWHvlQY=;
        b=UXjUD6juyJpKZB0dJB/FaT+DKMNa5abQ0o3BYRjWYg7x6HAq/KPMEgIaXu4SdwKQJY
         A8K/3Cxk5GXn1KfnqZDWcTUWLF5srfI/ZZxXhXph07u76qgZ/pZnJuB+HcN0QMzTjecG
         TSa8eR1f0NL4a1iTOcOPE+4XATDb93mE20e0FSV8rXPJFPphK1/QtlfC7XPjqTX51TQS
         1BzHrJIOZIhPqhdxuybBTL/9anbSRY9QoapKfJTKZxhINZEqIVGqvghBMge7E3h2fR8p
         I7OL6ATfX1OvQhuqbjPGEo8XZBivRTSmI1ZTgRVx+R5e3WWkqp/TFrEl3pL/tR/l3F1+
         L6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580373; x=1746185173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSss1QzBq0N72AWJKw63wc2GhbDCTVccqMU/TWHvlQY=;
        b=jQdsPpHF1wTJ5bJMKlFM2Cv4xeLbdaOu07z5HNuJ0K8416NPFLXMQqvZoNwhZYO50v
         i0xJtZD3ZdC1g76zDZhM/ZfMG7MgduiwHjy7KJthC6NJad39vrbKCk3lyHjmjEhrpLqa
         eEaZIjXjwmwslzeAehh+FtFiKNr7NuvLDe5J16cGrCyZ/JHwXHOgmK/1Gd1wpOZFy6Lc
         PhUNtnDG7f1ROY8a9eyrd/X2omsJbfFfX+5lGdTwphUxYBWxrkW7tA44j1IvJH89nlvf
         7Qm2ns17m6PkN2xfpS0smcP1w+ayRQgQ1lvT2idl3/eg1j3ZuQuyCTKogKWdrAry7GyG
         Xq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8FcMNiJZVGSNeveNXypEE1IniKlv248rE/3AKnp+xkS4tQkcrkGCWejbjgbHCvhojfzUNuuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6QfnGNtctgUGRXTdsls8ZAecM7LepU7MESaljcBWVB2ZNsBY
	quXD+O7s3YP42P2IoJTOPuAVJ5rvqmcO6PEEUkljilV7uoI/DtW4OzEhCNURxg8=
X-Gm-Gg: ASbGncsWToA8U/tM3LYWmjEk/VC6R1GZtZorwBzQ0L1gIgTKKQikZZUf07yXJRG0BdI
	f6VKapED0jJK1Ue2ciIK32dctyDsl+y0ezEan67HTLiDWUn7fDQNe9pBa/OTVDID7H6crZitBZJ
	4Zio+Z/UDVYqZEjuNENY1mCyAigmPD7Vi6FjkMzQc8ri4kfvpmOKfDIVEnrDNzzKs8cwmXlyFRA
	xOgIeex0tZqjK8zhbLyZwmwFOdf+0WeJ1qbA9LcbF+bVnRYpfC9++Q5Wsvj2WcTz2BspVN9ooWR
	UAD0fNvFx2vRS3aPUjwF5qsBfiU7AZaDybGzOLNUQl2S70LU
X-Google-Smtp-Source: AGHT+IEI3xJBemslTKCGQtGigxkywC+RTy/gVwTIEFxKTl75RCKKLvh8q88N/8Q39oAosB6LSkqf8g==
X-Received: by 2002:a5d:64a5:0:b0:391:45e9:face with SMTP id ffacd0b85a97d-3a074fae1c4mr1444471f8f.54.1745580372733;
        Fri, 25 Apr 2025 04:26:12 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073bbeb5esm2138502f8f.0.2025.04.25.04.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:26:12 -0700 (PDT)
Date: Fri, 25 Apr 2025 13:26:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <l5sll5gx4vw4ykf65vukex3huj677ar5l47iheh4l63e3xtf42@72g3vl5whmek>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424162425.1c0b46d1@kernel.org>

Fri, Apr 25, 2025 at 01:24:25AM +0200, kuba@kernel.org wrote:
>On Wed, 23 Apr 2025 16:50:37 +0300 Moshe Shemesh wrote:
>> A function unique identifier (UID) is a vendor defined string of
>> arbitrary length that universally identifies a function. The function
>> UID can be reported by device drivers via devlink dev info command.
>> 
>> This patch set adds UID attribute to devlink port function that reports
>> the UID of the function that pertains to the devlink port. Code is also
>> added to mlx5 as the first user to implement this attribute.
>> 
>> The main purpose of adding this attribute is to allow users to
>> unambiguously map between a function and the devlink port that manages
>> it, which might be on another host.
>> 
>> For example, one can retrieve the UID of a function using the "devlink
>> dev info" command and then search for the same UID in the output of
>> "devlink port show" command.
>> 
>> The "devlink dev info" support for UID of a function is added by a
>> separate patchset [1]. This patchset is submitted as an RFC to
>> illustrate the other side of the solution.
>> 
>> Other existing identifiers such as serial_number or board.serial_number
>> are not good enough as they don't guarantee uniqueness per function. For
>> example, in a multi-host NIC all PFs report the same value.
>
>Makes sense, tho, could you please use UUID?
>Let's use industry standards when possible, not "arbitrary strings".

Well, you could make the same request for serial number of asic and board.
Could be uuids too, but they aren't. I mean, it makes sense to have all
uids as uuid, but since the fw already exposes couple of uids as
arbitrary strings, why this one should be treated differently all of the
sudden?

