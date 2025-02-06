Return-Path: <netdev+bounces-163432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D004A2A3AC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331713A8022
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401B22578E;
	Thu,  6 Feb 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB5DOncZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B71222570
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832100; cv=none; b=fKMTJOFy4naM3ilKT5zySO6PzSQQL69mKFbZ3Qy078yP60iZCSVDmNnAsQwetUVvOlOKS8PDK7F423l1twKli017sXTzJzRXhhvMWFHSeW3WEtMPnBFLiBP/li7iMGP+i0CxtEoLFaVaJpWx0dkUBUXQX21liaDDal/6oXlHGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832100; c=relaxed/simple;
	bh=Wcu7Ed3WxWpIZTpgSe4AEYA4xjESjcUxk4eT3EboN9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRpICjR8001rLbRcKRVpAG4eV5TSFBI581NTegMUoNavBVS1VM2+Z7VKGrKwEoMeNtvSCpsdEwyPMad01JiYCiExXsjZvUzuuOjcSDvetFAcJei49HKjWcFqnLcUGyJyrMfaXekLxXr8WiDqrIYlEgPSKFGVPROQ6HqZBdMxaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB5DOncZ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b7f9158b97so191018fac.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 00:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738832097; x=1739436897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcu7Ed3WxWpIZTpgSe4AEYA4xjESjcUxk4eT3EboN9I=;
        b=GB5DOncZn5AjQ+Io6yWJ3mrNe3T3Aw1oVoXwtIvvI/6/x0JnXCWtac1y2bUDB0g6Ci
         yjEj/gaq207/Bf+H5iJGr6dx5aupkAFo63H+jTl2z3SStC7b2s3L/BtCuex6nO0A5v3k
         9J0XhG+5SbVGt5FDcNcnXLpEZGh5xWeWQtk15IudlsRALygWFPTvVL0l91p4/fDnJzJX
         7jmqDWCkoQSM6uif3fr+XR3gAUzvOV3rf2WRwAkv51pkMjIg9a1GXlX8sS2xXwc85cVa
         cb6aW9/QF8EOvgA4S8F5NI9NzyqBZfa8Q2/+sPXzSYhLQ8HVtkPqKEsdt3zljil8W4F5
         w0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738832097; x=1739436897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wcu7Ed3WxWpIZTpgSe4AEYA4xjESjcUxk4eT3EboN9I=;
        b=KGJ2l5h3xrT0+JX1VpoUNPgwz8tXltPPkipuvlY/pFREWWNj02Da89qqE3CdOMZTdM
         V1dSrQbT+35tTTPoJfDxK94f270fsL50PfVqOmhy8hz3OSEnHChplt5WXWRCzs5jyy+8
         LDaFMDP5L/AST5PhUr9BlqAFmH0SFJUzCXHITVcX9M3AmhiqAnr6oA3ZTwxT37KAANKi
         jX9CD5Z3lULMZTPLEWjq/RAh/hJZqNcTpzdR6uv+jGFenx6xEJL9IkQilVHfj6LpuTKY
         z7s5DWI+GGaS1odjgWyWoBo3zlZkLNbS8YIjbccovcssD2ZRtGQ389tZFgIYbyjC9p+8
         uvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAG1KihVkQ1Fixgkq5ybMMpLus435LV8LGZYQKxF/hVaUJ/7iAosP/lNtsWToMaXMNbLg4R/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfjl+wDv6sodY+O5IFdysaEx8JbVVtmu4uYpdtLYMuYL3VUR/
	4gK5DNM+OGiBG+gq4k70O30gSdabe2Y50e5NwZ2UpYMT1GseTGJ8hqWVpJZUJPmjDwvFNiqdbte
	JYCEKs7eliXiYqYW/bQcZLO+abiU=
X-Gm-Gg: ASbGnctAOcK8iNp9czEEwyhKISkTNteVYiv92x8ouE0V6zlH6QO1icQlPE8XnlygznH
	ASEpWuK4EoLMu8gXQkRnUAO6ExhVlLkrzQya7CXyqFuzEI4r46uoqqyFtRa7Mqjf8d+4lZRf70x
	lJQFr/j0fngXabBRtCeP4WCZfdpmU=
X-Google-Smtp-Source: AGHT+IE6ccwu8UuDUNkbctOquhUxWNSWqyNVSV7RAVNH+aYOtdH3ep0JQw+KwE7JppLBin90c2DlmJtqy3enbnYfwTM=
X-Received: by 2002:a05:6870:41cd:b0:29d:c624:7cad with SMTP id
 586e51a60fabf-2b804ed55e4mr3944559fac.3.1738832097527; Thu, 06 Feb 2025
 00:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173352.446704-1-kuba@kernel.org>
In-Reply-To: <20250205173352.446704-1-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 6 Feb 2025 08:54:46 +0000
X-Gm-Features: AWEUYZljq0DLqnN1zAv7smsTtZy5IFtLQkQkZlHRf_zgCLQ_QGTvTmexWCw7-Ig
Message-ID: <CAD4GDZxO8O4L1Zj2gSXZp9utSmKTE4_6AegTKEf=9vqN697-2g@mail.gmail.com>
Subject: Re: [PATCH net-next] tools: ynl: add all headers to makefile deps
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	danieller@nvidia.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 17:33, Jakub Kicinski <kuba@kernel.org> wrote:
>
> The Makefile.deps lists uAPI headers to make the build work when
> system headers are older than in-tree headers. The problem doesn't
> occur for new headers, because system headers are not there at all.
> But out-of-tree YNL clone on GH also uses this header to identify
> header dependencies, and one day the system headers will exist,
> and will get out of date. So let's add the headers we missed.
>
> I don't think this is a fix, but FWIW the commits which added
> the missing headers are:
>
> commit 04e65df94b31 ("netlink: spec: add shaper YAML spec")
> commit 49922401c219 ("ethtool: separate definitions that are gonna be generated")
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

