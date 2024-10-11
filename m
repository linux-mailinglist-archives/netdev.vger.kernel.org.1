Return-Path: <netdev+bounces-134561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4399A1FE
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1F1F22F0E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B992141B5;
	Fri, 11 Oct 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvPYGP1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83965213EC9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643897; cv=none; b=B6bLPjDb3ECm4lps7/4ZGHnA6acuGcFQH8DP6iLmzFvrhvmQx0joyyxU3mElMGQUbJlmX+EvaHri6VuHMRJ1JQwirCxtzKHSJWW+W7VVWTCyG8ykiJEK0Fed1Zg+puJfKIeDj6dUzvtIgJc3yxz8onC7FdnhzpuEpl2ozpEnxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643897; c=relaxed/simple;
	bh=hHAn92o32H32gPh96beQWnQ/ZmBeuLm5ekkuwM5z5QY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SvUT3N0f74xgjx3BtZGF+awhGQsCgONfNua2Voz3AudbOs8zkkgKyfKqujaSNuKWlXAMh/upf/009Lw5RHzlKBfnFtbSB3ck4fMAKWKU2NFQ1ha1H6W0vtvEudvZSmoRkCdq1mKvOsiPt8kaY+V6ZaAaUb3hym14pVcjwq8dnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvPYGP1T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so970219f8f.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643894; x=1729248694; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHAn92o32H32gPh96beQWnQ/ZmBeuLm5ekkuwM5z5QY=;
        b=JvPYGP1TNr6fPSndwCb5SJ5NUlBGGrOfwUqvPjwUPiNVDBtAKwpKAZnwUE0eC362P3
         8i+oWrwFdWSFrmxXCncw640As5GcjikdtFob/7gAjmmMTZhKz4uV5Cu9N496FHW3BLaW
         3yqTzUS75Vf1iIjGAK1ZkhlMYcmvJeK80eoP8FH6l19qHSOtrU0ixX3/vvcvRXiGtYbJ
         asyUEg2ms0eul4csAkJuGKBywiVG1KbsjwH15XE9Up7kdYgZ6LUGhSNQdAsIcl+MmNG1
         /rSN3/gFvT8/Nf8x5cwQZYwa2h6MDDX9Q4XMNqiZcrUoFqOKij5PY7QQgDKP5+c/ciUb
         6uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643894; x=1729248694;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHAn92o32H32gPh96beQWnQ/ZmBeuLm5ekkuwM5z5QY=;
        b=lkiXVq5JrlPgE/VOZ7sbtmBRWqzROxmlidaPYb5thAJi7WwDqgRRABZrj/eyO0jkPq
         /TjgY9q/Z3VvDshs8w2l+ckFADWaHfsUnVs+GgV2CjSPVzTFQy3n0HrsOL0n2PV3LEBq
         tIQ56LJJC/AIh/ZCwc7CVlrzVC7KmaB+Fm0n/k5yji/N/dINNOs3Ul3ex0F6DN6ponHc
         e+i2BOBST3fUcVq07Iv0aAyWg+QTzBlBV/kUtUYwzPxEq4a9GhYJKdVBMPRdl3qh9oW6
         r1ZESEkXfkgZOv7tnIoaTGOJhIfeStPq8YV+N3SWnkFMrxO6IELyUzA46u4egWEROP5i
         X1LA==
X-Forwarded-Encrypted: i=1; AJvYcCXE0irI94GZiwC7OF0RmHyVP9wjM3B08A+1FBZsxpJr+vxBdFqzFTVsjBcLQYiSasr2F1vWyMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dvsj1o8WZDuIa3KztPy8T1SvcRGZdu7xzTNY5J2Z1idc1DJ8
	P4yMF0ipm6DAsp8KYP7o7KTtj24I3ycJ4m7GpMUHHZwJnLSp1wJR
X-Google-Smtp-Source: AGHT+IETfDhmZxb9O982Zm2cRQJKhW5upTUaIiWBLX5B69Q6eaitqABrCUnx7PMKdHdEoQoZp70DCQ==
X-Received: by 2002:a5d:53cd:0:b0:37c:c4bc:181c with SMTP id ffacd0b85a97d-37d55184de1mr1632588f8f.11.1728643893584;
        Fri, 11 Oct 2024 03:51:33 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:c9b8:df99:9ba5:b7d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm71274295e9.11.2024.10.11.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:51:33 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next] selftests: drv-net: add missing trailing
 backslash
In-Reply-To: <20241010211857.2193076-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 10 Oct 2024 14:18:57 -0700")
Date: Fri, 11 Oct 2024 11:43:27 +0100
Message-ID: <m28quuzzqo.fsf@gmail.com>
References: <20241010211857.2193076-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Commit b3ea416419c8 ("testing: net-drv: add basic shaper test")
> removed the trailing backslash from the last entry. We have
> a terminating comment here to avoid having to modify the last
> line when adding at the end.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

