Return-Path: <netdev+bounces-247897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E321D00521
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A22130060D1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC342D23A5;
	Wed,  7 Jan 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCNQWds0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB702C11FE
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825145; cv=none; b=rFZREiTlxoOTn48iIsrhJv0CKMNgjHvEg0p3eYFHsp79Oz9OzqhM5uMdwADux54FLLXezR6NDQ4SUPOLaAZOre1hNyH3ypIT2crZoKhf1r7neAmUOLArZRefjqx2NoUuaofR6kbEzhnS3eRW38W5Uz22fJ0e3TTfJglYYCGx7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825145; c=relaxed/simple;
	bh=hxJpW78Jq3c6dYdI5Bg33vN9yB0fU2t2fXYtYPPwvvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWzQQFYFN+WwpXwIEbN9NdpZczlAZFGlB27Mh4ZSrDuC5c4kvVb+8OwMU/c65X1wBaFeG6uXZPtMVDH1SF6+OOPI+TkX5ddFCmwM3yhxvcHroZzuqImxvAmls/BY49B+m8wPWbFDjGQLZDRmbpVaCbUx8OCxLbvk63s4+i/ntCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCNQWds0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-459ac606f0bso1513296b6e.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 14:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767825143; x=1768429943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1RSvXf5TMr3Lj+5hiKndUKWf/wAY/TBMJfBbSZAKH/E=;
        b=NCNQWds0h5PuVJ05jbq35u0u/pmj/hlZmFBKVQ3S2KRI8WSJ2g3RlSwaoo0vYa/11j
         gRbNgu2ctDUVcF7craSLBptTS7z8JwVkZlkBJrCg8y+wznXFD53tVYQxhOB/nS46MRQW
         FQ2reAzCuco+QZv7ym72MAzZrCbL+Zsvg5L+SXD6zHH5HozFbF8wCZMB9qlsyPP/+7zi
         OuCXx00mlNfluC0rjxe8xgEy1foX7C/VV1SqaS+0ryn532cNvtpG6R/atec85v+T4ZgJ
         9RiIJQOtLfiYCGruRvGFjuOllBSGsWiozFdCzHObsK2Jzo0AHtL21BXDHe/SkK36D2QV
         kjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767825143; x=1768429943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RSvXf5TMr3Lj+5hiKndUKWf/wAY/TBMJfBbSZAKH/E=;
        b=tQL+v8l7/n4U+ErPGx075RuOpDzF8SsLfM+zESk3xIjt2wepDimIqtb/rvCeakEw+p
         sB2+lByD61S2UHZwed2uAw4izVqGJimVdlftD7kN14AzpFLl9yfyaxRJQWgxkg36JRuq
         ataKa6H/9CMAiRv/+CO7QJU8QYzllzOXBLm8Nfr3qqVBlMdBlLet95ctzRJkJiTk9WFu
         Q0l0xcVsoePLhvoxWWEvhmikrzxn8g5oAATbviaRnQnyvQM9JIK88uiuQt9I1ILvhy01
         v6nnF/5uSa8llCXvnwQClp47auc0p7b02kIhidz+penXsVu4wuuvuXVvmK76cRVfXkFv
         wzsw==
X-Forwarded-Encrypted: i=1; AJvYcCUpkqywHvxQopt/pg8TJafaujSTWgadO14MlnRaaEpvKaS1KRwN9JFufYG0+M8/oAQ8BSPM6UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjNdT1s8oQBk4EEfiBkUFtBgj8YfET4ewCdOA4P5pjy9BKhER
	+3X4lLo26hv2tQSe+HEpNEVUrQCUhH7MCnfRi3+xzeKulAeVHKDchzgp66SdrW76r4h63zHzwVO
	gTJQvuuet4QVNCa42WADNc23E1fvgHwI=
X-Gm-Gg: AY/fxX4TgW3p1q5dfZs3h3Vueu7y70HF5HgXAMrcZN57ZeSlf0qyG0RdpzHfEvmi8Ka
	wOE6CWMjXfjklbCLJNo72RaRIopCCEI8eV+jh0rZZno+cJP6rJXOt1V6qxqPGnSuSvp+N0oTx64
	29kFapian0z2FbnnWl4RY2WOauCzaRYK3+0JOAvBzacDvoofHFW6PVIF+/h2og70ZQL4V04X5nB
	S6OhtFVwLxjUZtuTjd03gTx5bx7ynu39VE0lDCDoB5o6F8zytCMGech2n3B1I9nxsns8AX10TV1
	O64oswUL0wkd+XwHieL3DDPAHg==
X-Google-Smtp-Source: AGHT+IFJFvNQOXoLxMqgYnEkDy9xwipEEyGtPrq6QaFTT6gsdBkEwhR8BblgfxSO6DXqZD0W4FnoMVG7ma8qseKjoUU=
X-Received: by 2002:a05:6808:6909:b0:450:2854:405a with SMTP id
 5614622812f47-45a6be8b0admr2035976b6e.45.1767825143211; Wed, 07 Jan 2026
 14:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107122143.93810-1-donald.hunter@gmail.com>
 <20260107122143.93810-14-donald.hunter@gmail.com> <20260107084534.11dcb921@kernel.org>
In-Reply-To: <20260107084534.11dcb921@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Wed, 7 Jan 2026 22:32:11 +0000
X-Gm-Features: AQt7F2o3Zxr-a8RiBnHk7NS8uf1usOPLSsMdKl-fU-dkVfmDg6uyjsLYw3TeWyk
Message-ID: <CAD4GDZzZVJgiRv05sFktmvmOD4K60YpFiP=xbtfVRGU=5QHOVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 13/13] tools: ynl-gen-c: Fix remaining pylint warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Gal Pressman <gal@nvidia.com>, Jan Stancek <jstancek@redhat.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Nimrod Oren <noren@nvidia.com>, netdev@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Ruben Wauters <rubenru09@aol.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 16:45, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  7 Jan 2026 12:21:43 +0000 Donald Hunter wrote:
> > -                     'return ynl_submsg_failed(yarg, "%s", "%s");' %
> > -                        (self.name, self['selector']),
> > -                    f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
> > +                     f'return ynl_submsg_failed(yarg, "{self.name}", "{self['selector']}");',
> > +                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
>
> This one breaks build of tools/ with old Python, unfortunately:
>
>   File "/home/virtme/testing/wt-24/tools/net/ynl/generated/../pyynl/ynl_gen_c.py", line 946
>     f'return ynl_submsg_failed(yarg, "{self.name}", "{self['selector']}");',
>                                                             ^
> SyntaxError: f-string: unmatched '['

Yep, this showed up in the AI review as well. I'll fix it along with
the other AI review issues.

Thanks,
Donald

