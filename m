Return-Path: <netdev+bounces-225397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B3B93709
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92A27ADA7A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120F73019AB;
	Mon, 22 Sep 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RLXI2VsT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CE23C516
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579015; cv=none; b=rzE0q8qnMk7qnhgMGWcnx+yg/arviUDh67CeZ7sJcU1f6n7KOCorqoC4IZUDuqJ9YHvaGsCk0njMh//JiamOZ+ZFoUvF9t1ofWmecMUcWvzFBs59oV2dqxvnzpu09rkf4t+XRyOr1wyeWC3TWSbuPwN5p5qEiG+cxIKDJDdNLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579015; c=relaxed/simple;
	bh=20hNPRoiSo9eeYh2/WqnMMEHn20AD8bo0nWMtUjzCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFBYfaY0Rte6pD+AXjlaV3Qh3hT8irolhGWcNqbwSpxQ9FHuBYuEacYndwV+moQd0TdbVOh22hoBjN6jt8fxpLT2+JaAq152v+QvQGGFutn8mJfd/BujeLUtKOKedPwotnwfBpwRqR8PuwswoqqkrxbAm5/BsBnXgIE4/RgZMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RLXI2VsT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4d3aad01a9dso584971cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758579012; x=1759183812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=RLXI2VsTyhxOfaaCJvkVjQtIS9Ae386+qLljTveQahzCCvVfeZece7v9LLkcAIZA5a
         8yMXPVhK8Oni8lTqwzcKz9wJWSJESy+kTPdGfgQz/RcRMp103Bv82RWWmQsY8Icxx+QR
         9P7aoPHNYdAajJ/5gIQWOMrY3yKlKFii4kMkqu08xemGnmEbMe2aPVZQ+FVVbiaF5hHe
         800e+834NaNBdGLtz57GpzZUrPvido1dvh8BtA2R50QfzkJI3UCCW4PK2exxQNGqSiDY
         8JPk6jKnVFLniQd6Er3tk9yul/zFUx9iKkhRA2eCGGb5efjxF09UBgiam7e2B2RurR+1
         zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579012; x=1759183812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=YGL/PBf7meTCEtiKH6IxV7MXSOwncq28MsneM0qAGH/g+0suj/x7tuqJliEc1rqVTK
         UL4uv8kb4Bzp5IeUEPLPyWyz2wFEfsgaJBOtw3GvreKLU1IL+RrJfETbFHvqqV1kEEIr
         iHcgHPfQ294sekQ8nQJBukMXMAnCMKM8IKfnc5WwMPV4O6Hended6PxdhQ1zRMvBpWaC
         GAmAYMXKmHaP/ZwVNmvWeEc+gzJu1k6L0P1QSnYK2HsfVyUVWu8fk+TU9HGSOdVkrdI8
         p3hjK4IAkfaoVbQg1twuyt0z5tOosGgfM7iEr263DFJJxDQZBEE/PPjOS4OohmlyOxNf
         xx7Q==
X-Gm-Message-State: AOJu0YzZWkkqDSubEwzNeSrSNyFENOXcg137pakYHaPV9pYAwP7+3i3E
	O2HsdpsUdQC7j5b2eL0oxMAUBysWkNU35JGaFWJuXUj8FAxjkZFfUuAjrnKDeLTPiQIihKOn7+E
	nriAgQKM=
X-Gm-Gg: ASbGncu05k2wOafb/nXho9uuCs3JIB1AF4M4ENlJZyhadNKqZBg0E/Um/2b8/atm+aJ
	iWZkUHEK9RO8hrtia4IQ2jtE99/gs5OR+C/6u/ak4vUfZx5sFgvRWssfL2BDEzXeP4CpWg0qV81
	uXRp7xzxI3pnxrYv/jP38wiJARskLFwDKoysiY/DndoDNL+l4fxIWx3DwzpYiT+BvR8TbIwM1yc
	E9Ms5fG4L1FDlbpF5spYEV9ce7sOqfTUuVq+8MN0vJQgPTTudPr+sgG5BXm5uXit4Vpq1zV4Qg1
	4lLCtU+BVllVvm52zM+x6aqxWlKgMs70KHo8aRGiNPUiDdAYgKgYH004i6sWwAHfYrv1xk45rRk
	4OsJY3yA4iHYK0TeDum4oLqGckEbUQSrBqH8r8wvDuvusD2vyVpKXbWrP8ZaNCa+l7GVoI+NkSF
	A=
X-Google-Smtp-Source: AGHT+IHNwvXqEF6vOTcSYqQI5K4auTTQ4rpyZ5n9iBhTRimnCw1sNSJGb5xwuJq4ksxZKKYMV+a4yA==
X-Received: by 2002:a05:622a:138a:b0:4b5:e2fe:31a0 with SMTP id d75a77b69052e-4d36e5ded26mr5451791cf.43.1758579012113;
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm76607461cf.18.2025.09.22.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:10:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/3] iplink_can: fix coding style for
 pointer format
Message-ID: <20250922151008.25c7a19b@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:30 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> checkpatch.pl complains about the pointer symbol * being attached to the
> type instead of being attached to the variable:
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #85: FILE: ip/iplink_can.c:85:
>   +		       const char* name)
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #93: FILE: ip/iplink_can.c:93:
>   +static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
> 
> Fix those two warnings.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

This is ok, to fix. 

