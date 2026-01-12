Return-Path: <netdev+bounces-248859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD8D10500
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19AE8300E8C0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD952F28FC;
	Mon, 12 Jan 2026 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI1T6aih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48E2F2607
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768183570; cv=none; b=SHULUI8r+tHwQ/UeAAoFYglzn/UzgF+iGVWx1L4+RpRgH8TS4wVS79oWyt2t9PNK1KCvEE6O2BT5HPcsfZEbvRV+m0Zbu0h4GPJl60h9Qc+eGTxm5jgszI+T0tdE/Yn3Fo5DHQwe4qc+lQFRCgu+hJ3Sx/p6bB6C0KD8/fhticI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768183570; c=relaxed/simple;
	bh=HplJvjVXh3XgVn/O75kAZByh701pzL+HFM5MeTe3ZVc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Z84W/EFmAFVrB68coi+t5k3gVepCcimKw6E30j9TmVgEtzf48vizvD2Pe5QNgt6VLvvx31vK3rKZCNvhW08VIQPSZ60binzSgQqvcPoHT7LCly0K9ztMfqCjaMFDccVcSbUKty4kPjWjBJDXZxYDvi9rXw0JzRvzEP6euqzwESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI1T6aih; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc3056afso3297615f8f.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 18:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768183567; x=1768788367; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qweyjd9R9Q/2wrPHDGzk0DCpC39cnFylpDq9whItX+8=;
        b=cI1T6aih0tGS8IavXH5ZHISeRzfbd8ohTxg7fkxay2iyHYCUT1aBZP3uTUS6hxXwUc
         ixflKT8eMYEeY3Kllh8NPNrdx5Vq/7/bSimgwfhgdepLrE5ImF9B/ujGjQTB3SgruEnf
         MOXwfFzr1UU+0sAk5gs8xyauAd0hwahTC/fx9INI1wUqLBgkelqUrT183Y+VzAqu3RCy
         pE5RbpHB5cRZadl8REN+CdtFeYq8Flqyt2NIITHjW59fK5pvE1TGRDTEdjHqJNA0kB9K
         UZwHob7654QaCrNTDys/CL382pzA9HPRSe79wCnjNIQpRz3UHnIGnhQg/Mw+/6Hz7XJ2
         aUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768183567; x=1768788367;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qweyjd9R9Q/2wrPHDGzk0DCpC39cnFylpDq9whItX+8=;
        b=wJ1GPhGZlK/4JIhv+eVYZjjZBJb7Ljj+JtzqNr37gxQ/dix2PLW/kOMR91R/HQ+iQV
         SVs/Fj3vwasoHt4VRJxpWyo8rswabDvI0M0xsQJokUznBnNn9OTnpF5juR6R35wy7N+E
         Znyas8xFF+NVL/1ghXwmkg4FDiCnLTozXFnTAk8SLBFrvzeY8GBB5y+Vc/yCEnbIVfez
         qd54Ik56VdthsOMbAu+QBBiBYGLrDRhr66Q9oAHkkIAUrzQS6EVwtkWtd8P05ofEALyt
         1e73L1oDSGOgL3vC3WdCHRbtM8LtOpAIqM0y88jK6YAaRwVCh28otbJA7emze8RszDCL
         kPow==
X-Forwarded-Encrypted: i=1; AJvYcCXU+bTBKPyD8FFQLme44ojoT1ckihddG7xVPZhb8PNU/nQFZ00b/kNysnSTTfb1LUZLtQCwiHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLtG/J6tb5y37Gh9E0esoXQDpSLhfX6Nw8PM0JHmV/xq2B//U
	TepGP7xyRPGmC/LJ5H4i4MCUE5qTPtGG0DPkxlRUB/J2u8teF9RWQ62x
X-Gm-Gg: AY/fxX4ps04iY7Xswc/6duqmqSrOk3OXo52nBudn4QtPezh2A/AbNuDDsqd4dOX8vFF
	vvsLziT5P5jajuounAZAomfqaS2wYU0f5XMu00SkClDp1Zp8uv7tLLwDqmvQqgSEc8qV9o+6tWc
	MJHo2vpLkfcYHOzFUcsOMPNNE/78JIenpw/LC9p68kILf5HZpPxoM+NbfaUsQ+K14vySeWuJfem
	M/2TF9sY2kAEdMhnZZtthHTR2i9ERTu1BwhSObbwG6NJv/yeHEKdSvnrFirZys2cuwFWbVMNZtB
	7VpC6DFOaUiYcciFAATlHOBEzCiM2LQ7EKqBfOwygIMH9bBYhvrzRHGE6Z+8ewv2fFSKwrxv0g4
	hHSzauNyFBK6QBL/TeeslLDa6o6jrVLRViZTYii7Oz3MREY/EnFiIhST1cB3hwrX0dtxz9uMcQC
	FZSKKdDhk3mXMCL3RG3Jk6y3A=
X-Google-Smtp-Source: AGHT+IHO2q5biZiP4qUeliFTuvtzVZUcZS8XjgGeKy6V3T7v95GYmQ3rUf3URFa4DFL8p54pW2d9nA==
X-Received: by 2002:a5d:5d11:0:b0:432:84f9:8c04 with SMTP id ffacd0b85a97d-432c36340e3mr18383270f8f.24.1768183567125;
        Sun, 11 Jan 2026 18:06:07 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:217b:2f6a:2e03:b900])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e175csm35437156f8f.14.2026.01.11.18.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 18:06:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  gal@nvidia.com
Subject: Re: [PATCH net-next v2 0/7] tools: ynl: cli: improve the help and doc
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>
Date: Mon, 12 Jan 2026 02:05:58 +0000
Message-ID: <m2secbvb3t.fsf@gmail.com>
References: <20260110233142.3921386-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> I had some time on the plane to LPC, so here are improvements
> to the --help and --list-attrs handling of YNL CLI which seem
> in order given growing use of YNL as a real CLI tool.
>
> v2:
>  - patch 2: remove unnecessary isatty() check
> v1: https://lore.kernel.org/20260109211756.3342477-1-kuba@kernel.org
>
> Jakub Kicinski (7):
>   tools: ynl: cli: introduce formatting for attr names in --list-attrs
>   tools: ynl: cli: wrap the doc text if it's long
>   tools: ynl: cli: improve --help
>   tools: ynl: cli: add --doc as alias to --list-attrs
>   tools: ynl: cli: factor out --list-attrs / --doc handling
>   tools: ynl: cli: extract the event/notify handling in --list-attrs
>   tools: ynl: cli: print reply in combined format if possible
>
>  tools/net/ynl/pyynl/cli.py | 207 ++++++++++++++++++++++++++-----------
>  1 file changed, 144 insertions(+), 63 deletions(-)

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

