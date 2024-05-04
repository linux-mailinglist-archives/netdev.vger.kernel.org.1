Return-Path: <netdev+bounces-93428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600478BBB23
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A766282A74
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D12208C4;
	Sat,  4 May 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yP63KKc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255B210E6
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825023; cv=none; b=qlPrQ1OYnpBXvYjMCMU13bvRHEB2FezAT1v6odzsfH4x3jgkcp8X7RL8b8Cr6qKB/xLcixsaKN6JcfcvWnLLQrHWkxYXmY97Bx88gioEacn0/Hh+1cnTBgmyuW+EtQTbS1VUVucBTg5YwtpP66MJ2z5nL37txfUlpfNeXZKym3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825023; c=relaxed/simple;
	bh=669O3y//f07tj9sHQFVeirnJEWT9tHeeDzQOoN3zNjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV78uWuQdNpPSWv8iHQF7fLWieCp2W47WHCwn7Lwq1zPE/9Jh/tawpKfe8dsN2gEzjxt3jnod/4CAzrnYTkeMwgzFjSIWiiaiwoIdAwwxXW4kJdJREyhBmq2+5togCAiDvxH0xEFjSOSjShBeszQ27wcTAOa2fqcEbgJ+sigK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yP63KKc5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so469488e87.2
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714825020; x=1715429820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ea8eUTmJJojcjwmqPaOSu/nCryeFpydpEbWC7pWZbY=;
        b=yP63KKc5xHt2ApMLNNNLvbQRIUbkKmEEubrjXVwy9Vb86h2E38ghIOAzeHQFhwbuzW
         xr4iVPwDwAM10uMi4RmUZ8oG4PWXFUOr1cOEPMdos4Qokv0LO5g+U9s1k6BXa32BsNFz
         ZJBvPuhsVmYPFL1rze0XStdonJ1dR/EHm3fNp0qbxXJ0T7NNNgrx0Cz+HQCQgLUtWjjD
         +Q7J3k5OAit/2hwZPeOEe1/feubko2l5DdaV7Fo5+SZSA08nc9Z3pDXi+Uk3pFDZ6nFo
         RPBMiQwLxcjxhJNUtvM4iIZwHwlUEyMjlGKQIGn6J3ifVW5Qqp+Oo7Pu7IsX00ueHY0p
         VoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714825020; x=1715429820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ea8eUTmJJojcjwmqPaOSu/nCryeFpydpEbWC7pWZbY=;
        b=n/k/fUhRyO54df8eCLJUSv7wRnD0jIx082f4eIl92V0YspqlEknpRCJ26CE52Ycfsl
         CkXJmG1mvl07KJ2lYHuXOl0nTkx9plpbXUetPFFoHE1t5F5M4KOcQHOW5Rfkv34Fjepr
         LjGxOH6it8LocSNr1dN9VQHSknXw6Vj4Aa0IxZZ7GExlMXttUE4SVxwbeOXJNvhIM7ZJ
         ueDx4A8B4Ue6xwk+jFEFWGMO+YimKJre22JYLW6oaYnt1S2k1nmrUnRQm299jldOuSS0
         Wu4oFb0dMoXbiQy3dY5dJLGG+hDkU5O5xECmpShsd0pJ+uLaq1JRKGUitdchWGcAbROt
         zSQg==
X-Forwarded-Encrypted: i=1; AJvYcCVcZlRAm+uaxXrII4BwiIESmnU8dz6Njy30FcfaS8+JkV6zx8JvaLpbfzEVewtgqSPlg/f6C5PVr8ZTF8MJKex0rpe5wXLx
X-Gm-Message-State: AOJu0YyF8Zrbia9dHJY3vxYGwZU9kkJWkrpz4QsvEYO5cpaZ8lE4F1YP
	HxcIeZBulb2omJScF6U6tygWBhD/K0841lGFQ8qEEKrnPIINT9AN+kVAQqOIH50=
X-Google-Smtp-Source: AGHT+IELxPWHXfQa5E+mJoBDo1dTtGGNHRm8J/13XW2AKQRYu/irxBpk75nxOWfED6zV/3b1O2vfXA==
X-Received: by 2002:a05:6512:368d:b0:51e:fa8c:47cc with SMTP id d13-20020a056512368d00b0051efa8c47ccmr3756879lfs.30.1714825019963;
        Sat, 04 May 2024 05:16:59 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0041c120dd345sm9082267wmq.21.2024.05.04.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:16:59 -0700 (PDT)
Date: Sat, 4 May 2024 15:16:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Kellogg-Stedman <lars@oddbit.com>
Cc: Duoming Zhou <duoming@zju.edu.cn>, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, jreuter@yaina.de
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <1e14f4f1-29dd-4fe5-8010-de7df0866e93@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
 <78ae8aa0-eac5-4ade-8e85-0479a22e98a3@moroto.mountain>
 <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ekgwuycs3hioz6vve57e6z7igovpls6s644rvdxpxqqr7v7is6@u5lqegkuwcex>

On Fri, May 03, 2024 at 07:40:32PM -0400, Lars Kellogg-Stedman wrote:
> On Fri, May 03, 2024 at 11:36:37PM +0300, Dan Carpenter wrote:
> > Could you test this diff?
> 
> With that diff applied, there is no kernel panic, but I see the same
> refcount errors that I saw before the latest series of patches from
> Duoming:

Wait, which panic is this?  The NULL dereference introduce by the
"ax25_dev" vs "res" typo?

> 
>   refcount_t: decrement hit 0; leaking memory.
>   refcount_t: underflow; use-after-free.

Hm...  Is there a missing netdev_hold() in ax25_bind() on the
"User already set interface with SO_BINDTODEVICE" path?  That would
fit with the commit 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by
ax25_cb_del()") which introduced the bug.

I'm not really sure I understand how netdev_hold() works.

(My patch here is correct, but apparently that's not the bug).

regards,
dan carpenter

