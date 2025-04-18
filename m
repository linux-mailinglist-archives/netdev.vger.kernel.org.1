Return-Path: <netdev+bounces-184112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E838EA935FE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A719E7DA2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3AC26FDB0;
	Fri, 18 Apr 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qDbGE5sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317C1DED76
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972021; cv=none; b=fNFPH6HLNGREWxQXce55OplXgPT1E9dPAEn9C0fSQFUFwTGDf6gYiOYgvnmwa9B4lQ6A9kg0llDqfZEWnbMld7X8ZFGdfwYeaEUO7oeParU1Ia0iARU+KAu7Dxr1ss4Wjo5/nyW6Zy+O7WxIs8yDMYGmcfOH4To09cndup/k4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972021; c=relaxed/simple;
	bh=AhDMAvR6Y0N0xilTkkBBlrdMlUSttI7hT7pOnKkca7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubj8L7kXjsqUw5DOit/QZ7cwKHfO5YeybKIti4QNWurbDFyjZpsN1gUG+6RX1Fwsc7hvUzNBzG5tuk9FsVOqNohlmDfW1a0DRzMdB2vOjtOVqWdEbCaGSaoZ5VmbNBcv+Lw8VnpJbya9kosxxbJRNZILicU3pUwYfQEvkn/4w+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qDbGE5sz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1175832f8f.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744972017; x=1745576817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyF8cUyrsCUAOR5COVOs1K+3uf8aTnMier1Oni0UNDI=;
        b=qDbGE5szaiRPJm2xhoYcCeq/HB7qVMGG/aDnt2/frbTazIjw+DN73o4Kqpy05f1rEi
         QDg70ph9QnYiPk/b68inQkz0t1cjWijRClVSIOMwO2/1+BCTxYkQVXUbc4E24XfT8sbh
         Q33SHDJzApGLRRA3TOVNicC2fm1m52kH7WbLi59FFSIlxqMzk33837kHtrSLdFPdXtYB
         2eX6m2mOhkLf2CtubmyikCvbKFrpEHMbo+KCs4ojUlNQ6OPJf7Do46kMtgMuqh2QdxMI
         c3MDrV5pS8nLhOkPm/tjx9U0409W7dAVKUlFqzlvUfdPAdY8XZNULwWljsdfa0r1lTNB
         7G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744972017; x=1745576817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyF8cUyrsCUAOR5COVOs1K+3uf8aTnMier1Oni0UNDI=;
        b=jsN28YngDDQ3fnNl9s/OBF/HReDw1ARBbCrfaRJfa181yUK8X6SZBIjHx/crV1cqyk
         ciVVtPB8Y1fCrI8Va5es5h9vumBrglX74ofodVuZNhpYdbYmTbEHPXMsm9wGXSLSshi3
         G81ZUvfckCr7OoegPN5BkqQzLaCDkg2IQacNOnYKo7iLMuUgrx+yNT4BjTfY2j/NNBbK
         uuslItgf/wTNjw79ArPXJDcrp0q1dxTCeNyQHFu+EFYvptWoyGNPztx7gHF/VR5zwiJE
         86rdy7wbSKmAhnfHYWgVuI21LRjf06FLidkAq2al/9F1F/LuDiuhczQclyVBDf41TEzU
         qx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/Da+QwAeN8NLs1aLggrjGI+MUpTpGleWb2j9YY1hXJ1D2gBVQMrRk48tzwmUSzNdGd+zGg9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoC4+Ci8qm8ra0nySR5xOEbpsJiBtvg2ol0ywHtFB2bjt+CMXM
	26ZBmQV+TMc+kx4cUyddcSuQmtNkChAYLPnevC+lwfo2LBs7CJwowqIADOhoz1E=
X-Gm-Gg: ASbGnctn3mQeP3nDnIlW5IqpdwN5FVpwWEEtPIPwXf8yuSFHKjgFtyD/uFRlP9PELxi
	/diFz7441HBDJ0R1sH74t1We8i++eQzhVtSiF8hg1iU6L+qO58iDQqKr1OzY64ADwaxtTujFMvL
	a2YL9Xzpv2JAuv2xYRqpaqaA0bGXJPfa3DdHFWeg40w8XZY/xaE4moYePHOQ05CIi6ufuC9xP8+
	HJg/+VBk7w7b589pBla818OHVP67YBKjvU8COVyGPpkIgQakyJXEcMGbObXO33LHPUqYpTgLZLh
	GOd6l03fQR1/DH5xg73QjiSuy3mjL0DCiPJTcrBBK+l6D70r
X-Google-Smtp-Source: AGHT+IFrfOuqMN9uKYocPpw4AsJuXc8TP55qB+tXlKCAM3rgVt50bp9eLIgTn8vJRtoXc+j5m8bU8g==
X-Received: by 2002:a5d:6d8d:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-39efbace2ffmr1486834f8f.37.1744972017548;
        Fri, 18 Apr 2025 03:26:57 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43cbf1sm2399026f8f.54.2025.04.18.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:26:57 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:26:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 01/14] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <bctzge47tevxcbbawe7kvbzlygimyxstqiqpptfc63o67g4slc@jenow3ls7fgz>
References: <20250414195959.1375031-1-saeed@kernel.org>
 <20250414195959.1375031-2-saeed@kernel.org>
 <20250416180826.6d536702@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416180826.6d536702@kernel.org>

Thu, Apr 17, 2025 at 03:08:26AM +0200, kuba@kernel.org wrote:
>On Mon, 14 Apr 2025 12:59:46 -0700 Saeed Mahameed wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Devlink param and health reporter fmsg use attributes with dynamic type
>> which is determined according to a different type. Currently used values
>> are NLA_*. The problem is, they are not part of UAPI. They may change
>> which would cause a break.
>> 
>> To make this future safe, introduce a enum that shadows NLA_* values in
>> it and is part of UAPI.
>> 
>> Also, this allows to possibly carry types that are unrelated to NLA_*
>> values.
>
>I don't think you need to expose this in C. I had to solve this
>problem for rtnl because we nested dpll attrs in link info. Please see:
>
>https://github.com/kuba-moo/linux/commit/6faf7a638d0a5ded688a22a1337f56470dca85a3
>
>and look at the change for dpll here (sorry IDK how to link to a line :S)
>
>https://github.com/kuba-moo/linux/commit/00c8764ebb12f925b6f1daedd5e08e6fac478bfd
>
>With that you can add the decode info to the YAML spec for Python et al.
>but there's no need do duplicate the values. Right now this patch
>generates a bunch of "missing kdoc" warnings.
>
>Ima start sending those changes after the net -> net-next merge,
>some of the prep had to go to net :(

I may be missing something, I don't see how your work is related to
mine. The problem I'm trying to solve is that kernel sends NLA_* values
to userspace, without NLA_* being part of UAPI. At any time (even unlikely),
NLA_* values in kernel may change and that would break the userspace
suddenly getting different values.

Therefore, I introduce an enum for this. This is how it should have been
done from day 1, it's a bug in certain sense. Possibility to carry
non-NLA_* type in this enum is a plus we benefit from later in this
patchset.
>

