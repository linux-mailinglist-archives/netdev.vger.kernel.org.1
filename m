Return-Path: <netdev+bounces-205517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4AAFF07D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D082C189461E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1046F23644F;
	Wed,  9 Jul 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="P7rIzh/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB221ABD5
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084528; cv=none; b=SM0qPNQm6evnyIqPFU7gXoM0wQkIWOAXHWxmNa5M/9OCymOQFzbX+3CqS9zMTrZxZXkRdGm3LopMFV/xtJ9jFEu5UB9exIW6UjxgxsXFjBW1L46mtnEwlNl5MSS3PRMnzi5QbdJio6NkbVSVcVQ67M7sB2jqZqga0wbI45AdUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084528; c=relaxed/simple;
	bh=2b8QVEDzgGdbmhSI7XBKiQYvzAmc+bP7D5FA8hZ4RPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIXVb4StBAkds3+aUe2B4Z9M9eUCAt00OPvRSpq0GkmA/qxf9soUfYpjZb3oV5F3rh6sKvWVmDGys0rvUGSJKroH6Vl5+vEIx+YpxdzeftWeOBm5fEvCq47baNedlibjKfk2PuRNyNG+S5UffDIBybFk9uokC7DTPVKEHMo7OkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=P7rIzh/a; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fabe9446a0so1845396d6.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752084525; x=1752689325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b8QVEDzgGdbmhSI7XBKiQYvzAmc+bP7D5FA8hZ4RPA=;
        b=P7rIzh/agA0tExGOuvmbZekfyU76Y+gEyCfkAPNY6d53UOrCOlkZKpXFwnqueUVQIo
         rqqoVoNjnTz/bNInS4RCHmLQPhS+FP2VvnpMJA2J8BwuLjNu7Yohr37NGlBkOw8vDYm8
         nDb9rjtzXWLdyPYW6HRHZKE3DPV93mti4w4yC58SNvM0veGvGIhArUd/tsh1Dx7B7yyP
         RiuAGeg1s5Z42FMds4ep3vSY6cUU9++FWHWFhaSOKFfdFyx0FxgGYhz3cfgBFA3SNZ9W
         MoTdt+pEvsRMkyZSOr6NIYldo68wkpGsAZq+6gEIXwbuI0g0lU5flxRV0kcwgFgo2Dzk
         ihWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084525; x=1752689325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b8QVEDzgGdbmhSI7XBKiQYvzAmc+bP7D5FA8hZ4RPA=;
        b=tveuJsB51dEhGzgIAdrBVleAei4Kiz5+0yOOQaa00pi4cDmjU0m+jUm9KVP6E0uq9O
         CTQihrlkKDpsp4RgM3Q6AKy/C8BFlm875yoE0vYRnCLq+g7BExw6hL87eZ3TMipD7d30
         1R3W0Rkt3y5hvf+k+suWLt0ovk0fHUxK2IHJWwmBnpThlR78mufqYbKbN2jNdwyfBQYd
         p4PE40lLr1ZiEhY2mVssYCdz6XfvaapgOFgrsk0ubJTRacay0GreyibkVWDfEcQbqr4S
         y4odSQavlX1pR2uIYmZUZTd8EfhEA7GpNuoeB+4+dJhS/N579Z6OBysnZICxZxubs2KU
         xlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX50jPt2Ew2J45vPs9xz/8Z7SJzeJ063MyyqcqENM1f1+Wzj1BFaFYRJHkAFfksxZ41Ff32X7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyMKbnz+zH4oifBr4X/AzgOpH3pVRzftfCFtPMZn8iWVMHJWN
	ie40Dz6o6ko6SSWbV1I/7jUaG2a9KsV94gJG5YSEf8W25xxpXhd/AmbbU5BsB6twAzBY2Nc7tO+
	NEDxG8gpMT9Y/M1hcEDukZZjO7b4Qn8Rhwm6QP8AXUbb5rI94uhVHHg==
X-Gm-Gg: ASbGncs5fsQTeF9DuZ7zcS24vd9VgxU5nYdaSlaaNyfCsu+FYASNeSnQiRQOEXBr48y
	ZtzHPkXPQmttWrgIsD4O9sCXQQsmsm26lvKeO9TkhHR1t1jwBHEbRJxClpBmbk2KREVneGNY+dn
	CCadxInoCQadmwXXM1Fr14vnurHJbvjo1JwXT+UEdeIkktOA==
X-Google-Smtp-Source: AGHT+IE2z657BdT6q5hpY4bUBRGMsJpkk8q0f1yrnDUGGehSk21WeORSXuOGwG8mY7zabj+dMIiXGnFQHSnlLyHKUmc=
X-Received: by 2002:a05:6214:4002:b0:704:78bd:ddf6 with SMTP id
 6a1803df08f44-7048ba88d18mr50201846d6.41.1752084525187; Wed, 09 Jul 2025
 11:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGdevOopELhzlJvf@pop-os.localdomain> <20250705223958.4079242-1-xmei5@asu.edu>
 <aGwMBj5BBRuITOlA@pop-os.localdomain> <aGxgzS2dZo8fKUw5@xps> <20250708031818.GA4539@1wt.eu>
In-Reply-To: <20250708031818.GA4539@1wt.eu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 9 Jul 2025 11:08:34 -0700
X-Gm-Features: Ac12FXzFgHgGXNORh0913IXssZebzS1VFAjVQl815kqSyXMDmAGR_VLe1YNoWp4
Message-ID: <CAPpSM+QEgEtkHFnaV4gJ5XyPK5EdBuz=A8St4m27ZBa8hbna5g@mail.gmail.com>
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on qfq_aggregate
To: Willy Tarreau <w@1wt.eu>, Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, 
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanations.
v2 is sent with Reported-by and Fixes tags.


On Mon, Jul 7, 2025 at 8:18=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> On Mon, Jul 07, 2025 at 05:05:33PM -0700, Xiang Mei wrote:
> > I have two more questions:
> >
> > 1) Is the patch provider the person who usually adds the "Reported-by" =
tag?
>
> Yes, usually when one person authors a patch to fix a problem reported
> by someone else, a Reported-by tag is added to credit that reporter.
> When it's the same person as the one who authors the patch, it's not
> needed.
>
> > 2) Am I allowed to request a CVE number for this race condition bug?
>
> No, this will happen automatically once the fix is considered for
> backporting by the stable team, and the cve team decides which fixes
> need a CVE. The process is described here: Documentation/process/cve.rst.
>
> Regards,
> Willy

