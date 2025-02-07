Return-Path: <netdev+bounces-163869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CAA2BE1F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D210A3A2CB3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A881A727D;
	Fri,  7 Feb 2025 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9U4VvB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D427DA8C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738917368; cv=none; b=snAY75iGIgYtEzgsuYUzsYKDl/ttn57e1RyCZnXosaSwpbXnyM9KLKdRuo2p4PLsd44F55lxquPT6/+cjAvGcWSlvMIIJdRWxKJoUl+uLIhECzr8nHG97u/Mn0wB8Rp8d1xMXX3T/Nu0XPxFEOUihpyUYl6A1Jh8C1F1Ew5ndIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738917368; c=relaxed/simple;
	bh=yjBYJzpI0rSdebfdCZIlxsNGdxWgVxhN/dwpdK8BElQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9CAVeBMGaJKbTRj5lwn0gD7Msbbycxgv9lHPIJgsNvPyl4ylv7LK9STqwkjIQ0GtXg60nKwMHxsbAb6LFJTU5KcPnhXdc9mBDdOY+fH865XJU19svNPaOkIfzVVddSPdSNaVWfOJPFR7/ED4vEVavNs2Lqipw5ut/bJKxuXscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9U4VvB6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3621313a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 00:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738917365; x=1739522165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjBYJzpI0rSdebfdCZIlxsNGdxWgVxhN/dwpdK8BElQ=;
        b=F9U4VvB6iKb2XzGqgI7Pn5/QFwz3KapbluJDy8or0sfC0kHRsMrfTd4SHSMPaO5pt8
         aqxaaxUKAfbXnY7rvLJw22XMy0Wdh9dprQYP/433s5Gv5LAOWIZlc2PrMO+tDljNXUCJ
         8o1KLDl2LTrlqSfMMN6rGlY+yMHXNxQ+k4fF0rJFfT5bckeDDcoqwZhkw2ogj9YSdaoz
         7lQfbZ1oatZmM6sWWh45qX/pq7EyFLyzmKYaLew0lJ1ukzYUyNCFDqZKzofyGuelnIVP
         LIjAiv+SXhYuorFR+jpHMPp5l+fBme4PFTBGJPwQGIBUP4NzEzugw1b+Z/mOKsbdZxZ9
         INfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738917365; x=1739522165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjBYJzpI0rSdebfdCZIlxsNGdxWgVxhN/dwpdK8BElQ=;
        b=jI65wtDq0ok92tXqmaOEYfGncNfD3NkzhlCaNogYnTk3UJVNTKvK7PJ+Ub8vrXAOTN
         kr7MygkQbTuryPXvQOb0Tkw8ey4ZaYrK3kVcV0/ktj36YT0WSOSKRdRPQB0j1WThZMSx
         o3pfrIVmXiWg98ba/+kVRZiUgWcj7l3mdTCxl1EvcfSXgPfhmhHzBLW57zyVwHy7SNni
         ro5mkYYPhZg6LqKw7swt9P/h78XbKH8kRJ8fTJAjK6dxi8tB4QluMGCJ6PePBIrZdxx5
         qZyIv5X4KcDEFdPJWE8/I4lSD6DgBC120X1bulTXHm9yJ9uAu09/fLMIPxh9Yy797xrk
         zvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXetBcvFz+T28MSWoOJbTEcCpTk9xSoZOjPfLH8IcNryCoXD3bD7HMath7E0uJsXIEFJbqw0bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCAU2Qh5nZcER6x+ja0Ukec3t/h3Q9jSvdfpVE+8oiQD7JXLT
	HZEE6QmtGFSmu3Jl2zZUbi4634HSiar/SObjGfyuKZLpVyi+fCUy10JPfe6v7aHQtxaJx+Xzv9z
	C5HuyMQxahybHXBvLDhLGwMtNVOYWPJspb6Y45zqi/GkjJk7xihUB
X-Gm-Gg: ASbGncu6e6lu++3JOKDzgE8N54Ggqxb4/o+6Xy1b9A+P6BAeYsTS/vbCq+wcLv9hDgb
	PqWHOFxcz4NzKX+oQh5rsvdYk5updyMucB04tfwzcLIVy9kyWlfloAZtW+02LtucWTEYpT2xK
X-Google-Smtp-Source: AGHT+IG8wFTXGuX9g/qo2DBOugkQXeQcswE/yy2b5YaGcvVpys7Yh+iMbp8pnk0Rrm/30NCBUfcCzBc60OJDwmuOCVw=
X-Received: by 2002:a05:6402:e97:b0:5dc:88fe:dcd1 with SMTP id
 4fb4d7f45d1cf-5de45047a40mr2667565a12.12.1738917365499; Fri, 07 Feb 2025
 00:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207072502.87775-1-kuniyu@amazon.com> <20250207072502.87775-7-kuniyu@amazon.com>
In-Reply-To: <20250207072502.87775-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Feb 2025 09:35:54 +0100
X-Gm-Features: AWEUYZlcgqsEj7JqBeGVxsiLJi6eFBMa7pEgxB5M9jQpHBOQd4kD1XAz-flJ8Z0
Message-ID: <CANn89i+cw4+3kFoEkiEFvzsUNsb_sRhBV+9psc3LiSJKimizdg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/8] net: fib_rules: Convert RTM_NEWRULE to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 8:27=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> fib_nl_newrule() is the doit() handler for RTM_NEWRULE but also called
> from vrf_newlink().
>
> In the latter case, RTNL is already held and the 4th arg is true.
>
> Let's hold per-netns RTNL in fib_newrule() if rtnl_held is false.
>
> Note that we call fib_rule_get() before releasing per-netns RTNL to call
> notify_rule_change() without RTNL and prevent freeing the new rule.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

