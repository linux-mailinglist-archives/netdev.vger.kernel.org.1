Return-Path: <netdev+bounces-190733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A9AB8898
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6377ACF03
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E219DF8D;
	Thu, 15 May 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eSmpYmn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF418C322
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317391; cv=none; b=lKla8TxayxX8tKlcUjJmtO2MgjEkojTDCrTDbLLIvM85SQ0PJ0eYPaBIp6tcbw85bRRV2Nn45BwF77jPNu41FiLmWnymyMY2GmBLDc9vTkUoNRzWgLx03vnWooGXvrLv5iLyrh9ToNGPl1TZDxr5Gz6sLRYi+0skgypIg+3ZgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317391; c=relaxed/simple;
	bh=Sa7GETTQgwfVClLUd5WysYho63CW2Ury9OOVP7i4C9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBMeD7vnXp3BPJ7jo2KJQrnKHg6nYH8jnBrlcMr0k1MOsOmDAuDXdTYezAmnySO1ii5mToVHVZtlrLHpFBp2cvxcWr/V1DSPOm/rKZm1J7MiETiSJgB1NnCqwZttoilHErVLsNKP+2SkKh4/YtuGwU6ZgwEnUDnODyu9AmHUsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eSmpYmn1; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54fcc593466so1064271e87.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747317387; x=1747922187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=eSmpYmn1Iqh85u9V2kvbtizkz5IuhNwsCxMFXJ3JWMHEM9hDezYfUMf4SERrjznqgj
         M5AW/pYk4myxOrz2rDN1HxUfSmtjQDvE/laJn3yuKs5oXWUGqgp2q3u4KscinaH01CeY
         ZMctDsdcl8UKK9/v6T0YYvMVBl5sd/4tm6R2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317387; x=1747922187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=r2D+A3i2vakvyCNxabRLyiLVYNGS7hbqxY+VnLfdk7zr4RVjKqwL67+GN5UXDcrAEg
         bbJMh3NBZoPP/BJxKF2yQJ9EyL7YamNRNpEf+rW0/KXwS+zb2B3N4LiTg/0kQtDJcf4D
         goXKF+MwOoDSGb3Bi+bZr2/2Wq777r6PnR543cHT5eltllQJvlKtgx46OyjwtuIcH8NZ
         W0NZKR9p4HqkWSj3NSwj//pxI24Q7EX1OgQZ1xODWcEar4iLR18qQQE+iLw5YAvK0A5W
         RU4iYpHMW5JdZU7ildNDgLQTF9UgLMzmQOqQ8jeBtn1irCz5H/2bE+jULgXMBdDiweM8
         o76w==
X-Forwarded-Encrypted: i=1; AJvYcCUSfkMNbtC24hcobUtBRu4nC8I38Njb82aA6IDAMwFKSwjb67KG7EIeH6CSuo2lPOf8jJxfEVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Sx4KnRIoop9nUzV2CN/wxUG6afu3x3XiXxxD3z6H+aO9J+Pd
	k/GhZoc5LXROqJomc5oI75hJr1EC9VyzlO2jriWg9TvtiCeUzQqpOvNemKUBTj8gcy02n/dSVYH
	lneUlq1IWsnkqt6r/6aEu2MAs3eVMdswCYZjkdg==
X-Gm-Gg: ASbGncuX49mejKIopmm6zNRTxOS+SeoYEOVV6WjMxXXOBGs+CJl+nE1EKpd2focHB0r
	aTNlf9KW/xWga3sCoTeKYXmCxDJNiJZzTIpeOXLQPjCveWTQ2dEvRPXICnnirErTr3HMfLX0Q9u
	LFHPcA9Qx5rCob7YL8j2Ryd37Ug+9QhxV9mA==
X-Google-Smtp-Source: AGHT+IHGJpz7aWTwl9mwnxLim4Wu4UpJRoyZSChwbFUtfQOjHxlGMmgBOj6a+6ZvRKFBtH84qKDoTSz+2awicFIRtmo=
X-Received: by 2002:a05:6512:3183:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-550dd00417amr888488e87.23.1747317385975; Thu, 15 May 2025
 06:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:56:14 +0200
X-Gm-Features: AX0GCFtkXNTU1UNhCQJwYHTj0HQMppT1zbtgyuIpAsA_JMgRpL61RCC5l6sfyU8
Message-ID: <CAJqdLrq4sCbCV7pjVdtSktsgwA-PWrgrY=_gFn0pVTQ59ZTtNw@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bfc4a32f737c..6ee38e3da108 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1240,6 +1240,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
>
>  static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
>  static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
> +static char core_modes[] = {
> +       "file\npipe"
> +#ifdef CONFIG_UNIX
> +       "\nsocket"
> +#endif
> +};
>
>  static const struct ctl_table coredump_sysctls[] = {
>         {
> @@ -1283,6 +1289,13 @@ static const struct ctl_table coredump_sysctls[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +       {
> +               .procname       = "core_modes",
> +               .data           = core_modes,
> +               .maxlen         = sizeof(core_modes) - 1,
> +               .mode           = 0444,
> +               .proc_handler   = proc_dostring,
> +       },
>  };
>
>  static int __init init_fs_coredump_sysctls(void)
>
> --
> 2.47.2
>

