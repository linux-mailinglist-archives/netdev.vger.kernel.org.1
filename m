Return-Path: <netdev+bounces-145342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4509CF223
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2F12818BF
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9B1CEE9F;
	Fri, 15 Nov 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pVl4oq7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164761BC069
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689514; cv=none; b=kDwyKdiG/U9AfpI4L5JZnZE/Fwq4x9MJzWMdLCC/bEFZapmER0OMSJ7Fp7mN2rRV1cXNhi7tSBZyW9+HFTGupqUzE4qtDlM/O6E1mpXUowYCgLj+IXuvzfmqXdsplMtdosBUlBko5YvRg5m343HluPJApoTm2t+OoXKoJa2naL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689514; c=relaxed/simple;
	bh=n4r7i5g+YnrvU9lW0FUevRBMcVXOgtfTIy9ZMp4BpYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpRMEOIKZjbpHUXhlLtA5LiDqPc7ZnoJgUqIf6V8LVRv8g5pZpfhnRis+1sAvJXVoVvAmH4Q9c7j6bS+X3c/FJcMeYsVIIO5Q0x1Juw9QBRDOiNo15CklDwr3oCUDHgcWEq6/Nat2tifjNKLJCzRIMD1KS2YtByxSxlSaNgyBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pVl4oq7n; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20caea61132so19072175ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731689512; x=1732294312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54smHQyScSFMmSBuGHCG1uRbRQ0M6ylJ3o4cUtfcUWc=;
        b=pVl4oq7n8IS53+47nA9vdj/TGiEcQRQ7zU9dzbKIxarsy2FlfBMN98x8GD8Czo5IzR
         fIx5VvZij7QNsB33BqF2ezA2D4MTj7CiT+Uc65yl2MbXC6OsduBqdJ3mdb8D5XqAaF3d
         euwmiUpviScv5xFllFcdzf8Rk5lsIiXahaidsy1RwhoGGPHkKd2+BrTyr3l1bk5GPTRw
         755l9lEIah5kEqYm06f+HW3EBXgxvB1jTFxo73x7H9/lzGXtY4p4IgiX84ivHIJ82hb8
         WS5Mkm76V6RJhzdDYY/Spx6YfkRx92VgW7lH76bFnGqeU8UlfJo2tutLq3oCXpf9pW99
         76JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689512; x=1732294312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54smHQyScSFMmSBuGHCG1uRbRQ0M6ylJ3o4cUtfcUWc=;
        b=bbR3tfKsb9CQ/Zyx8Iu6ft1FqHkkNZN5PUOmQx8ainKCCmWpTUrQ4X5syhMMBh4ghg
         0WjjExTVecoAC82PtUMe8F7JMhXiNCJOi+s11VtdniIplGqO30Prftkg5zce+qo+eq8E
         +Xms3zAjL+ZdfTmnHPPxAUCkFvRS+1Pb+jFwDcblNxfOQR66GVxEZ0ND750hzcAABfX3
         63IikXBZgNUYDjQVAqW++lo9v36MTLyAY0huPmwkKJR50FT4rPK7+E+Dqb6Fx0JABdOe
         4weDa+UEAIHcQ23GZucqtyXyzZRQIHBk1oOtgf+w/VV1HMBjBhn8oAae023e3kzAKKgi
         ERBA==
X-Gm-Message-State: AOJu0YzyiSl0NcmtWi++sPD02XknEwh/zu1MpO1ivdT1dE9NrY6Qo7+r
	VOFLHeadJtUkOhDqBubEODPF2cH/XjuaNLV1BJ6i9BhW4YK/oFfWOqJBhHhG2KU=
X-Google-Smtp-Source: AGHT+IFgl1pUccM0+IWuH051CK6HB75QCutu1wBvwsUrCEpKrHdEFnduI+DYpzokjRdK/oUV47chIA==
X-Received: by 2002:a17:903:2447:b0:210:fce4:11db with SMTP id d9443c01a7336-211d0d8ac96mr52193025ad.22.1731689512404;
        Fri, 15 Nov 2024 08:51:52 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec90b7sm14372175ad.75.2024.11.15.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:51:52 -0800 (PST)
Date: Fri, 15 Nov 2024 08:51:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next] add .editorconfig file for basic
 formatting
Message-ID: <20241115085150.62d239ae@hermes.local>
In-Reply-To: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
References: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 00:08:27 +0900
Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:

> EditorConfig is a specification to define the most basic code formatting
> stuff, and it is supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> 
> It allows to define formatting style related to indentation, charset,
> end of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configurations to *.{c,h}, *.json or *.yaml.
> 
> In linux related projects, defining a .editorconfig might help people
> that work on different projects with different indentation styles, so
> they cannot define a global style. Now they will directly see the
> correct indentation on every fresh clone of the project.
> 
> Add the .editorconfig file at the root of the iproute2 project. Only
> configuration for the file types currently present are specified. The
> automatic whitespace trimming option caused some issues in the Linux
> kernel [1] and is thus not activated.
> 
> See https://editorconfig.org
> 
> [1] .editorconfig: remove trim_trailing_whitespace option
> Link: https://git.kernel.org/torvalds/c/7da9dfdd5a3d
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> For reference, here is the .editorconfig of the kernel:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/.editorconfig
> ---
>  .editorconfig | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 .editorconfig
> 
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 00000000..4cff39f1
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +root = true

Maybe add something generic across all files. Then you only need to specify overrides

[*]
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
charset = utf-8
indent_style = tab
tab_width = 8
max_line_length = 100

> +
> +[{*.{c,h,sh},Makefile}]
> +charset = utf-8
> +end_of_line = lf
> +insert_final_newline = true
> +indent_style = tab
> +indent_size = 8
> +
> +[*.json]
> +charset = utf-8
> +end_of_line = lf
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 4
> +
> +[*.yaml]
> +charset = utf-8
> +end_of_line = lf
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 2


