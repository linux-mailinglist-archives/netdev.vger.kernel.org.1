Return-Path: <netdev+bounces-145341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911B9CF211
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E7F1F2AD3A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A31474DA;
	Fri, 15 Nov 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XQaQT/AD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DB13A409
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689379; cv=none; b=o64HrSOjbC9xcYt4cA1Y3MjSUWUzPI1xXzDj2jhDT/cN8cYK12Js8VWN9jwALlUIQlx7NqPvznn9n0DuyjXzJliQJZo8U/jkhA1i9KRv6Jtn4EC0cCbGy/J7nsrMHpf/7FwGZPxihvHXy7PRiXDPvck3wI0tRL5krX5WzrrKbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689379; c=relaxed/simple;
	bh=gRmgXmWw/qEeqRapPrcW/MeSD7MAK9dNUuMzgrZH9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEnrMY6sjCCeFfLCGLlrcZB1S+iPJzx+ChDE2Z/RIcjDOHgIKj2aB7wA1bP/yVOASp402b+2LHQlBOVgUBJA5SzpYwa3Q3keo2JM+dueiJH3ATXWuDlkUaXHzLuNc1mj9/dL6G3cdQ8oAcThuw/0YjR51xqPFm3KPK/VJSVmpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XQaQT/AD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so22946815ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1731689376; x=1732294176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXMagtWimVN0ioRCY+CmIJ4ypspz/2fORU17wLs/TqE=;
        b=XQaQT/ADJKAC0Uq/VRf4kF8x0gDmfVFTrBJqTLmtowx2gc3bTt77eYX3KZILX58dmg
         nBahlSWlzm7aJkoTfYIrI8OOrUs1XodlYHA0co/0+QbOrB+4njGoGJ1uD0VDIeVgd/+l
         1vQB1QwTqXsMZk492Db7+dwnb1hYiovCa3glMZjeS8wdD0J6hQ1s7ZlCllBJHVmEybPm
         Hn69l6+fsgF9NDo2EoZb1IrJ6Sq1g+yJWWkd+DhPENgTmMV6BUchfUBA+hwB4KX214yU
         dtSa8X3sGkNczYdeUqweCjoQZliXyqL0IYo/urlGlOR6G9RHN8Tn3AdceQXGQRaT62uP
         QTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689376; x=1732294176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXMagtWimVN0ioRCY+CmIJ4ypspz/2fORU17wLs/TqE=;
        b=uew+3MVX/YI8wkLIITIKo0pUzA065RfsRjF1PL93N6xe1TuPJIV4OMGulGwg6F6eqJ
         wWqXtVVDMPVHf5PGAXKboh/T7N5ktsJglwFF/kG6maCc2NRfu5qCFeELHDyZxrnDoPGc
         T3gB00oVfqaZpHc1StlBUDN0mtOnwFeoH+LUlyRVgRzq2lDidnK1k8eBa6J7aS+9U8u5
         OMC7Zr5m1XpKhEGLt33ZF8SQ4mc/H6plZwG+fsw2P7ADAQUL4dGCD0JcLrSQEC8+ba6k
         QCrphHn7IL8qZCgFDXROIP9nLvlWsW5qCoBXXoa6s8jSVQAsoP7vCaqulsAIxiM0uLBz
         1yxA==
X-Gm-Message-State: AOJu0YyjzN2Mzj1167sIuG3w0nfr7demhBQFAoN/hdwaM+87dJlzmCs4
	7J7TuiYmLT+p5L8zWjOkbjO5rkWmxd6heETo9t5Ynw2mEllAcE7yNVE0C0vc+hHfw2Rz8rc7dZJ
	t
X-Google-Smtp-Source: AGHT+IHWtelaelHe8hHeD7d+/e/EMNU4Bhte5ee0rg+kbyT6RSBKvj5K//e17e3PrUlhQoYr4OkiFg==
X-Received: by 2002:a17:903:22cc:b0:20c:d2e4:dc33 with SMTP id d9443c01a7336-211d0d64d72mr43776885ad.14.1731689376619;
        Fri, 15 Nov 2024 08:49:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54283sm14362515ad.243.2024.11.15.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:49:36 -0800 (PST)
Date: Fri, 15 Nov 2024 08:49:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next] add .editorconfig file for basic
 formatting
Message-ID: <20241115084934.5a9ac7c6@hermes.local>
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

> +
> +[*.yaml]
> +charset = utf-8
> +end_of_line = lf
> +insert_final_newline = true
> +indent_style = space
> +indent_size = 2
> -- 

Ok, but there are no .yaml files in iproute2-next

