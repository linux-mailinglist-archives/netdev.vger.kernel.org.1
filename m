Return-Path: <netdev+bounces-72153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFC1856BD0
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EAA1C21092
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC713848E;
	Thu, 15 Feb 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7j0pfEl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7F136995
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020031; cv=none; b=pNZaz3o/oFbSFBRLujOZMnSk2qradnax0DmIEx51TU0zxkczQbaQhppFxoK+npmj21e5GG33NgOYgVE7e2ezMdQvdt6KdjNBpnKFIwEjo7Xk5VklrUfZ1RiJ/V0bQXEJhBrALdhysOcWBQkESsswN9A1wCaFebhrN6BII5nRGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020031; c=relaxed/simple;
	bh=Ewks1KSKMZE/5FKOLwqiLlEnmGTEup08tVXYlkkXo/Y=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzZrV7BUh45+izDAysmr5CxSTtrodpGwhQ/VmOAZeqelQh8tlDGiV5Ixo357GX4MzJwhvLskQDei8IAewRtBkWKitqOdsZropTht1kOH26EfAQyBKrZ4CJuNZPeSif8AgwGgQUujahqT0pkegY2c1DMhHXtHVreKYPSFLLI4y5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7j0pfEl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708020028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G5lguk93gTD6qpeik1vqHfX1oWMt+Ae5AYgN6rGWcE=;
	b=f7j0pfElsXQTlRWKuRG7iFgZ4YU5n6TZrpYRBfKqngPoQ9A4bEAvPBA9Cu2oein4+wJAA+
	OTm8ZsbycNi6ATKmryg5qvQenPQxqXGtYCV2Y6Xu8Z34oyhEoyzqo0GzsvF8XSUVxTSBX0
	7ExqTkYCipOd5HIKMgDFGf1XG15c6uk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-4ROKz19eMaask7iqw6UEFw-1; Thu, 15 Feb 2024 13:00:27 -0500
X-MC-Unique: 4ROKz19eMaask7iqw6UEFw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-561601cca8eso773248a12.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 10:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020024; x=1708624824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/G5lguk93gTD6qpeik1vqHfX1oWMt+Ae5AYgN6rGWcE=;
        b=OB954c2gomYNAtVBgKZ+ST3VnOM77uyqykb7zU5KJwdS2EnWjEyCnm0kt5a7VC7iwy
         q/UZfhxem2X9ZjpVO0Pb7JwxDR3QylAjynorvhzakt09i8Dis4kK11V5KNJRZTFcL9zo
         I1T0Py4InGCHXCEN/J6wtsDa6wXp7Kw1VA+PMNRd/MifE6IDLz5iyrTmWxu2Kx/IQIXY
         lx7K4A9xItRoJSgeeEJPRgOTESkB00fa9VAbABGKCz03/+0NU7gtASubq2QqtaZF80IB
         xZnBZxu9XK+qXiJ38wX5JdbqMOnY8cfK8TZPURn4OvRHzUa6Vh1aWIjDWu6BXEs7ng0S
         uagA==
X-Forwarded-Encrypted: i=1; AJvYcCVDTvXwOprxVNC6tne6uGaajM1uyGdRVLlAVNkUdQHciRteP3uIQ6p7GcTkn/aPTnYYb31mzFJ24s8gB0skw2tz8ui+S2Bx
X-Gm-Message-State: AOJu0YwqA0Gmh/w/IAungMp5TcuPelEoa3hxbPYCj3wmEB9quiVO7wHm
	sp/admliP9yg3sXhUtYd9mzuElkQNxG0PjdFyWaJjp6O5hUbvB/FtBuIBfVzVEbIH8hl9bquFP4
	Y1kv54VNnd5spbUEhff94prP9RaFIyHVvbf7lsGTplD2sRcKG/UkiNg6m2bMP00TgXOS/jqXayx
	QU8DQEY0tppmqMIQDuBJh8XzEbohlsr2CC0o8k
X-Received: by 2002:a50:ef0c:0:b0:55f:fc6f:835a with SMTP id m12-20020a50ef0c000000b0055ffc6f835amr1945633eds.31.1708020024806;
        Thu, 15 Feb 2024 10:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt5/2XZHqnW+bw+e2xQmI5SA0wHRscwwZ8k8k+My0Czfk4P01c6nuWd39BUwAH29EiSVWVAM2AqF5Up0waUHA=
X-Received: by 2002:a50:ef0c:0:b0:55f:fc6f:835a with SMTP id
 m12-20020a50ef0c000000b0055ffc6f835amr1945614eds.31.1708020024507; Thu, 15
 Feb 2024 10:00:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Feb 2024 10:00:23 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240215160458.1727237-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215160458.1727237-1-ast@fiberby.net>
Date: Thu, 15 Feb 2024 10:00:23 -0800
Message-ID: <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 04:04:41PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
...
> Since we use TC flower offload for the hottest
> prefixes, and leave the long tail to Linux / the CPU.
> we therefore need both the hardware and software
> datapath to perform well.
>
> I found that skip_sw rules, are quite expensive
> in the kernel datapath, sice they must be evaluated
> and matched upon, before the kernel checks the
> skip_sw flag.
>
> This patchset optimizes the case where all rules
> are skip_sw.

The talk is interesting. Yet, I don't get how it is set up.
How do you use a dedicated block for skip_sw, and then have a
catch-all on sw again please?

I'm missing which traffic is being matched against the sw datapath. In
theory, you have all the heavy duty filters offloaded, so the sw
datapath should be seeing only a few packets, right?

  Marcelo


