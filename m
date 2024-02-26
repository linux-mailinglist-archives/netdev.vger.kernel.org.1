Return-Path: <netdev+bounces-74858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAA866F71
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B3B28224D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D253E05;
	Mon, 26 Feb 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DMGPGHHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AD524B5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939499; cv=none; b=TM85rvMTeyOzV9qr5LPHIqdGyXuUPRWvidR0/vH9gQq7pGMtwS6G8Wmr5v68CJEmPpO4ipkvQj7qgIatjsfXoNJAxPzfSg0XHXBarGu9TJouwuAVWeF2m3rB4Bgw8LDet0qbUjC0XcjcnCJAEK4DQ6QsIZl8M6GrtYtrxAe5OmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939499; c=relaxed/simple;
	bh=KDm3zUp8zkRu/r4C3EOkXlcvSwHeRKt1G1Pg6U+Sn0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmH6pYUZ9EXSXM539si9LXzBh1ov8yh+M00IVsQWlmB57JqC5VqpYhhoqcjeDBSQeCneZ/aHZsbsrMe7RqIWB6LG5poYYxPUtMV38c+tlUNFVJpItKY5+xYF222TY523E5LxsMu5NxGQkfcwRT35ZPO8w2DiHJ4S+KV2/KDsERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DMGPGHHE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f6f263a6so798055e87.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708939496; x=1709544296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDm3zUp8zkRu/r4C3EOkXlcvSwHeRKt1G1Pg6U+Sn0s=;
        b=DMGPGHHEifo0Bjm9rbYswnSfb+UQBUN3HvF2evbvTkSM5aSfvpD8kFRFkjPeBQrO9R
         DAeymaSphFyTsQrtTfHcHd5gNptZtYFIpuoX5aYpfIEQF2pF6o+wbHzZaDGezLAdCb9G
         UfSMiaU+7uo4MuXqMeaA/r+QrY17lQ2EEduc8NOpk47+2ixIHfzEYn5LDX4LTkZUUZvl
         lH/oDeRE7LPxeMpLbj2T3/Qp16nopcintr/3vIxDqRnuhdW+KyEvTkSwen37gbxEV+F4
         Cce3rkmA73TJrSBiNdRGTbh7ITUFyqMa6ehu3tfrr4PZZrUfnNeJpDUFgzCmPCAQsZwa
         gwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939496; x=1709544296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDm3zUp8zkRu/r4C3EOkXlcvSwHeRKt1G1Pg6U+Sn0s=;
        b=gKWDEv1XSNy7xU8RTBDmbg5XV8GRCsivjXtkA81cOhjYbADAtNZlWlzKR0G19VLYhA
         R8cY2dn5CMk3/7qdtokQncZ6FlDAvOtHHxVzpn/DOWF7r988yTmVwAivfsMq03IfUBnp
         Wk6eMCf1mcXhy44g6TRkXmXUrSLXSq1gAWo1RnKVZS8302d1E4zTi4p93soTztK0LBxT
         +gvySWlBjx7KAqUnraOoR4z3zrPPJ1qJCxLHSQFVKivkNZWCCzkgJCHYiI+X54bBUyQo
         5Id8zz3/SME2bRvSeRMivsA2wUrVagJ/vRUFJbrxVKSplkkSWYOAmfdXkohJ4VCtOquT
         qFgg==
X-Forwarded-Encrypted: i=1; AJvYcCVdLDvJ4O1Utpw+Ngh2Vs2NbZJsBL4BBOKLvVGLr/b7WWqAvcpmlsIFzNem5wk3ApqD42gLDIw/qQPprR3yaryTGgfjrksY
X-Gm-Message-State: AOJu0YynJsiOVSAMDXCAR0TM+skZ2s7Wyhu1s/b98+SvfIHRpXFh3T+e
	79eJ2e0bdn4bm8EZ5mAhDe90GoJb42RxyVw49bWVuBaqNV3+zxUm3jsGHGHGTZo=
X-Google-Smtp-Source: AGHT+IFxmadF1CFcWTvSIqOIm+TEqY8ZzrjSiBldW5ZMoXA+UFJ34f0JrQDQxXgWW3T2GgUSjwmprQ==
X-Received: by 2002:a05:6512:3119:b0:512:901a:eb9e with SMTP id n25-20020a056512311900b00512901aeb9emr4195773lfb.58.1708939495714;
        Mon, 26 Feb 2024 01:24:55 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b004123b049f86sm7788798wms.37.2024.02.26.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:24:55 -0800 (PST)
Date: Mon, 26 Feb 2024 10:24:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] selftests: netdevsim: be less selective for FW
 for the devlink test
Message-ID: <ZdxY5vj22RSSUOXv@nanopsycho>
References: <20240224050658.930272-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224050658.930272-1-kuba@kernel.org>

Sat, Feb 24, 2024 at 06:06:58AM CET, kuba@kernel.org wrote:
>Commit 6151ff9c7521 ("selftests: netdevsim: use suitable existing dummy
>file for flash test") introduced a nice trick to the devlink flashing
>test. Instead of user having to create a file under /lib/firmware
>we just pick the first one that already exists.
>
>Sadly, in AWS Linux there are no files directly under /lib/firmware,

Ah :)


>only in subdirectories. Don't limit the search to -maxdepth 1.
>We can use the %P print format to get the correct path for files
>inside subdirectories:
>
>$ find /lib/firmware -type f -printf '%P\n' | head -1
>intel-ucode/06-1a-05
>
>The full path is /lib/firmware/intel-ucode/06-1a-05
>
>This works in GNU find, busybox doesn't have printf at all,
>so we're not making it worse.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

