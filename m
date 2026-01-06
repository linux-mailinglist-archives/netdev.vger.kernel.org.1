Return-Path: <netdev+bounces-247486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32948CFB3A9
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4996302412A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388352848A8;
	Tue,  6 Jan 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjobh6QU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E130F530
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737652; cv=none; b=eRA2ChmECp9Pog8Z0DY9Nfcx61gSnC8yC56wP4o+Np7K5nOCCl64HC/kKLzcUqQq9VF935NK5DNhYg9gfhD9kf0iSLnVCzl/pi8QZ2hLgbeJW5v3esJk5aqJQylmVI9svV86Nj3dLvAP8xewaiYsSrtXVr/+tYjWWZ9+NICeXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737652; c=relaxed/simple;
	bh=BKVgYfecIlwaEfG2yIYO31DYcPw5TzZyRT9d/OzC59g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V92IDe7cnJMh9eMwxQPVJHUX8Y3rIndSH9rC3e/mUPaimINMhiBh4FByXLfeHmmgM4hLIfExnm+6FCLZUMau1UBVE2eILIBrCcypo06mi4TDL/rbioYp68GGlwawvrsKIyfM3RiwFpdPRyOjXAYj4/6dWLBS0iAddUjArEQ8LFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjobh6QU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fba1a1b1eso5031377b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767737647; x=1768342447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXTAUGOjyeJOlTuz196szGLfvzOOt7OotlkuHVJJ76k=;
        b=jjobh6QUB9YiJCKjS5JSiCLsJeXUFqsG5JMYxzEkuQjNwWWcaTAu24fGx4DI+boXha
         MCRvD4W06vqO3EE2woQuV4/R88qWeswUeBnzhn1QbHJ5CP+/DfrUt5lq/X3tPTAerqIX
         xbK+FGeJoWay9Xa8B5xjlD8hkhXUSpDDxskTeog0qT0q2A2lf4VLfHn0myaZYvb0lYII
         fARBHrFCmhnIIMOCxTw1DO5OeIxeSpciRqPLl6iwPhHpmHuT2fsYKHkQ853RtCzIq2by
         E0C6fm1SP/36xxR4JYbx+gVPME+2qyHcjE9QsnIwPN+YZOgfvwgvB/1eqaJW8COpCwKw
         8/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737647; x=1768342447;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXTAUGOjyeJOlTuz196szGLfvzOOt7OotlkuHVJJ76k=;
        b=MlAw/YFVW1ER2Ra6/3/uRJJXRAMO2/XuJ5XCUbCK5vMvQ5fXICiWgWEYDzPSIoGk/M
         QNAe+00OIm3DDw6SE0VzrmFHhN/NBZYyEINmqd96BJk0zvAI9hcAbYUhyRyQj7hND5PO
         +bW58+uV5mCGQvX4a63Hlyg9gV7z9swZF8getF/uDF5UMyXDaEPNl0pq7PQskgNGSVpj
         07ZUWvDWm+apMGi4VkBZx9qDVxRXb1rtf7fNe2EaKK6eEjcXQvA9ugTBw6liMvGUg4GX
         Q29GP5YpqKkuozI1PAU3VI4rQZO4WC548yh/5vPmK9D+ce9FY97tLA03jIWGu8jY9AzK
         5FsA==
X-Gm-Message-State: AOJu0YzilS8d0cQGvXnSh4eoT379fE0zq5PQwpbeb8Ly4A0NKL3y+ctz
	5Hj4Af4X/1FdzAogVKsI9p34rkGCOkgKNTHkIrgb9lLtc0yw8mW2dG3H
X-Gm-Gg: AY/fxX6odnNmNdW21bAW+eSlswYTjZ8Sz3Fm6HCUEQ1lfMMUILlVM8AjBXQn0R7q6q/
	tgt6VX8EMu9fyoUk688hxz15KqyHUs75cEkpGJEQ6jvs7xvDxBbGihD1B7pnDmqzV/xl2SNYyNx
	KzQfJRquNKRnNmnlbzM6Noucztpi6dOnmtuNglvPwRzDuuv8YMRk9MfjDMm0lP9Zf58ze/0m1Be
	VTaCYFA66GJ0+JZdR7dQ2ZIKAlAh7zAjiQIleQiebmC3vqOoYk2lzV+G/T4+qzl+Q5qvbT/nNxg
	TtQ0pcIue8HQZ0MuQWmAoi1RrLTD1nVh6mW22ZTiSzpQGB7ne4uRTbtScy6T2Dbxl4QwpSG4D+1
	PRwdJxqRpaoChbcgKsRuYaujHHVd2+WJZUjzZgInWMICEIy0NYxS8kjckWXgl1Zqi75Pa1jmbB8
	xOQCBn72urdeD+nzCScHHmZioZvQ9dSQsJ8H41iNunRvzh8G58kqlXUR7wVjY=
X-Google-Smtp-Source: AGHT+IFVw2/A2IyvOueA9fhhC+wh3ph13++iKFZyzR0whc4WRr2nxsaHNxNq0kyCG35wbd92xWDOPQ==
X-Received: by 2002:a05:690e:d8a:b0:644:6c19:8a26 with SMTP id 956f58d0204a3-647166aa310mr513038d50.19.1767737646993;
        Tue, 06 Jan 2026 14:14:06 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d89d607sm1338464d50.12.2026.01.06.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:14:06 -0800 (PST)
Date: Tue, 06 Jan 2026 17:14:05 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xu Du <xudu@redhat.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
In-Reply-To: <cover.1767597114.git.xudu@redhat.com>
References: <cover.1767597114.git.xudu@redhat.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Du wrote:
> The primary goal is to add test validation for GSO when operating over
> UDP tunnels, a scenario which is not currently covered.
> 
> The design strategy is to extend the existing tun/tap testing infrastructure
> to support this new use-case, rather than introducing a new or parallel framework.
> This allows for better integration and re-use of existing test logic.
> 
> ---
> v3 -> v4:
>  - Rebase onto the latest net-next tree to resolve merge conflicts.
> 
> v3: https://lore.kernel.org/netdev/cover.1767580224.git.xudu@redhat.com/
>  - Re-send the patch series becasue Patchwork don't update them.
> 
> v2: https://lore.kernel.org/netdev/cover.1767074545.git.xudu@redhat.com/
>  - Addresse sporadic failures due to too early send.
>  - Refactor environment address assign helper function.
>  - Fix incorrect argument passing in build packet functions.
> 
> v1: https://lore.kernel.org/netdev/cover.1763345426.git.xudu@redhat.com/
> 
> Xu Du (8):
>   selftest: tun: Format tun.c existing code

We generally don't do such refactoring changes. But in this case for a
test and when the changes are minimal, it's ok. Thanks for pulling
then into a separate commit.

>   selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
>   selftest: tun: Refactor tun_delete to use tuntap_helpers
>   selftest: tap: Refactor tap test to use tuntap_helpers
>   selftest: tun: Add helpers for GSO over UDP tunnel
>   selftest: tun: Add test for sending gso packet into tun
>   selftest: tun: Add test for receiving gso packet from tun
>   selftest: tun: Add test data for success and failure paths
> 
>  tools/testing/selftests/net/tap.c            | 281 +-----
>  tools/testing/selftests/net/tun.c            | 919 ++++++++++++++++++-
>  tools/testing/selftests/net/tuntap_helpers.h | 602 ++++++++++++
>  3 files changed, 1526 insertions(+), 276 deletions(-)
>  create mode 100644 tools/testing/selftests/net/tuntap_helpers.h

That's a lot of code, also to maintain long term.

Is there an alternative that has less code churn? For instance, can
the new netlink code be replaced by YNL, whether in C or called from
a script?

For instance patch 5 which sets up an env, is probably more concisely
written as a script. That may or may not work with the existing KUnit
framework.

Iff not, it would be better if the code moved out of existing files
into tuntap_helpers.h is moved in a separate NOOP move patch. Such as
netlink (e.g., rtattr_add) and the build_.. functions.



