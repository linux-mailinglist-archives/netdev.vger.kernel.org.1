Return-Path: <netdev+bounces-186702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D8AA0732
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96667B23DD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B72C108F;
	Tue, 29 Apr 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyeBRnC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73652BF3E1
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918849; cv=none; b=EHFc8HJNTcq9VYy1B5lqxl5fBKd8q36KiluuTCcV2rU7l8jvJuHmyYgp7A3P8tIo9UwRKSKp6OJCiPAre0Y/Ebzss6NCpg1hVto1jpZ9T57ArhlUhXm8a/PYCpWOVb5bpDZ79XXUBzUNja3KV7fc/b7dVv49MhElml2ULJesQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918849; c=relaxed/simple;
	bh=WiGmdXOEmoX+7IlHcTwmrk7e3/CdrErcXmuW92bNmck=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qR9ElcvgzeC8fvlGLtx1PBO0xRCBQYOEmXx3HNUSKYAR2Qyw3sism1fiKP3EMgJeJQFQGMGasClMXzU2YleQb3JVlNAM7UU5MyTqsLKkC6S3mCkZOuoqa9Ubf5V2onnutTlCCdlSvlgUA1cH89rjC28AdytMfN9dkSTfmronZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyeBRnC5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac9aea656so6656286f8f.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918846; x=1746523646; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUlYRV7PFMRo2HMEDRLPVfOS1NQ0zKl4zQvRiDz5+ZM=;
        b=kyeBRnC5QgrC65FvOzqZmyLK6ZBcFwfrkyo4H+CdJtKfZf6vP/oZvkDX3X2s1J262j
         1EyDpP96tiRw+yoGfzWqd7YNkfhgVCgE2QlBXyc9xQsS66oo0UHY6L7v5DaKztfmnHAp
         ab0d5/k4WHINaAXzyIvlMlBlNCArcKMxacK93wshOOfzVOslsRHpkl5JwfzEOSHAGJXg
         63BdgVbBDmEKJdlWoGfpIDA62qQRkGiJ6AUFyPJUFS/MjpHh5FQTGaFtxOGtI0DQezvT
         4SZCpT6xQefXVINcCMtNiKW1sRimkiG6Mi4TdY1Lqr/QaQMuEPQIY3r8+vdjYkEqVxxW
         y2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918846; x=1746523646;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUlYRV7PFMRo2HMEDRLPVfOS1NQ0zKl4zQvRiDz5+ZM=;
        b=ERXBEJWBP5ZbW9YhV6WqB3kbzLomwlKq6t3fOqrRe/6zo26DAKSX+OH4h0U+NduS8b
         6VMVwAL9q8MM1QDG+iI2UFLVQwdmzRUI8yaUOPLTpJ0StvOc7jscqmjAPeGsRmJjpvnm
         6z5lhVA34aajdvhKeYa6a9/atXToIJUrMT4XtS497EXCJwDKIvKA/6AOGpynGgITvm+G
         J/vTjaXVDluyHAYAg45swVkpp8ZaDP5V2zvLHvsPeRmCy2+TTNHusXo2J2V+tiy9aNoH
         zHeZXdbIGXvFYdvaTwCSGZEx2+2TW6kAax4zwUWZvNqbRB7u4PPkEp6UWIKeKvmwe+w8
         xXAA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Kj/MXkfADMfwDfpF2UXhC5OM7iHxfsPyNa1iGhMlaw20I/vsxmU4Lxhipgd59CaZqwvpPj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2gb+JLO4TtU6uoKQaMRJJM8EmhtioxSbi0aiG9IpeWqCLrDG
	Hd8sgaerpvSDd1fzRd88wfEUeykauXEJ0WxKOROBOeZf1mt9UddQ
X-Gm-Gg: ASbGnctOBi9w+NgFbR6uh9GJD/Kbex4KUEy/54vEXxKFPNWpsjAXGL0CnFijaipZKGf
	HS+ggeeL8Nwe5U6f6tcAUzr/MIZUw97W6bOWcKL4C4cbTm+MyLVsj5p86aFTTlTOuWsmo+8Rv6U
	dWUZQCPrG9FucHkyEk55YZg1K3r4QqNY8/Bcis87qhDQkv9VGNRAftgo1cJppvZp8pn23GRNA6s
	QYI6uww936jk568yiOs1ICvOr6PeJRmxVbNn0cHkh19DUiEdGVQxXAm1o+FMJ8rltrV1u0jHCc+
	enWYdrWF60tbPZt3cFB0NwE0U0YyZz/VubxRYggZu85hNekiJbhAFnKgOBtBh2Ce
X-Google-Smtp-Source: AGHT+IHc9DSSZBYbLLgTO1N4GzWFMFgzKcTlqIGcdVWlHntZZpoBZFKdJZwrzuiVzMw6IwmWfjovtw==
X-Received: by 2002:a5d:59a7:0:b0:390:f0ff:2c11 with SMTP id ffacd0b85a97d-3a0890a516cmr2501179f8f.2.1745918845909;
        Tue, 29 Apr 2025 02:27:25 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca5225sm13636429f8f.33.2025.04.29.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 06/12] tools: ynl-gen: support CRUD-like
 notifications for classic Netlink
In-Reply-To: <20250425024311.1589323-7-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:05 -0700")
Date: Fri, 25 Apr 2025 10:21:16 +0100
Message-ID: <m2plh0r3zn.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Allow CRUD-style notification where the notification is more
> like the response to the request, which can optionally be
> looped back onto the requesting socket. Since the notification
> and request are different ops in the spec, for example:
>
>     -
>       name: delrule
>       doc: Remove an existing FIB rule
>       attribute-set: fib-rule-attrs
>       do:
>         request:
>           value: 33
>           attributes: *fib-rule-all
>     -
>       name: delrule-ntf
>       doc: Notify a rule deletion
>       value: 33
>       notify: getrule
>
> We need to find the request by ID. Ideally we'd detect this model
> from the spec properties, rather than assume that its what all
> classic netlink families do. But maybe that'd cause this model
> to spread and its easy to get wrong. For now assume CRUD == classic.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

