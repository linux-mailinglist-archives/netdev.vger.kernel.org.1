Return-Path: <netdev+bounces-198589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C09ADCC70
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4D83BEF52
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304312F364F;
	Tue, 17 Jun 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJxlkya/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999D2ECEB1;
	Tue, 17 Jun 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165218; cv=none; b=L1Cu7IvNA2d+TZkzvFlcSw1JrxualMuIzg2hYEOI1jMzDhIOBL/XhKqLKsCgr2ZGwrcVhkT+AlSvFrS8ZySLm12H0Hc8vCXga9lBcroJxVBP+BTx3dchFrLBQfPzNxq39RrzaEOto9ra9r85+GMVmhyBqc+lGQzmRZIwTtBZ6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165218; c=relaxed/simple;
	bh=pY/Rn21IGkkLCho6oeyaQyXDQlKMPUPwymU60FIcdug=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WPpo+pGspNt7KrlHwwBwBkoifcEK5cmRfvs3jzbNt+nelNM6ERjTt1h8yFIQWFR5yHsFOHYOyRB0AszOv1iHIJCtpfcSbVg6EhAUZe+nDsLREdhPZ7TKAPDiYB3pV/c+wKR7fz3+ugprEChr9RGWGl8x+Fg5B8tjlfRX65zmAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJxlkya/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso5520205f8f.1;
        Tue, 17 Jun 2025 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165213; x=1750770013; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pY/Rn21IGkkLCho6oeyaQyXDQlKMPUPwymU60FIcdug=;
        b=WJxlkya/0aljnBbzUSxdQczT6Sw6dXhR+IGnywvP/G8D8Z6WObGu2m9oF9w6i17juK
         nbhxbwO80/6iS011bev7WtaBrEqLBgJpxtNybjEy/LaL+Yz6V02v2f8gtVokbM5rPFO3
         9MIwbKKe1UvCyHEl2w/+TEz8cDdEKioRiGRusYysBOzKM+fS7CkwZ3w7KzE7/uCUYgFb
         3K9i0dJnd9KFBaeVEAdllsoyllHHoSjEtfMtRFogcJ9va3jq2I1Ufqg2EyTYHFo5+JD5
         BmyHuS+Dzz45NF12YokkJLHZ5aLRl12jbqd+Hc+RRGPsMkpTNRHROTQXY+kqbw9vJJBw
         Prdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165213; x=1750770013;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY/Rn21IGkkLCho6oeyaQyXDQlKMPUPwymU60FIcdug=;
        b=jA5A7JKieXi/lVQjnAeKgw+HW089Ay8IvogMd+OdLNT0sOyqNaYYDnZrp9evT6QAn2
         Ww6cO3upGpZt0oMgwWGN8Jjr99NKwqzWPgCbtR69cW5BP7Ht1za+QNlqGQjPy/7oeAC+
         trZ93B9Og7MaUqFzBAwg+DTh7IjaJJz6IQDQwG8wMAx8dmSeO6PYTiYc4LxzXjKjxRYC
         pYM3VKoh/EGzRCJqvhZea76Lnuhhv39WOJWDOjcInpMZgFRCPpHJFwKRdZK46mkuxsFD
         FOtdV1uXmwAj+Wt8uPOvv3fFpOSRxXTUyNehTzGdFgFizVi2PJKoJ4f0A+hm/Wri6kS8
         bf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzNmUZ0X61OCOdUycXqIewToumLiyEPtKhjdfCRpyepsECwtMSniQryVIdNoFg9LAx9I5T3boD0ufkCcU=@vger.kernel.org, AJvYcCWQWcy0Y7I7vEY/AoCvJLg63lPLaEVLqvGe9XPKhZimEE2mb8knFE92rGkcWgxE3bezw/lscgkh@vger.kernel.org
X-Gm-Message-State: AOJu0YzUx23FxC4QOpcr1IwwFO9MJOFSqD44j3ut/CfYuIhBvN3pG8lj
	Ox5X3k3REsYK+mY+x2XWsR0zgs4Q6iTsWK1/RdOPEzBYGjx49IsC1kfu
X-Gm-Gg: ASbGncswQXeasrnPo2kQ4s2gXHH+mi8Z6S4ElnTtcjLfqTr49UlW2VOa3ZkM3MV7ZiQ
	MwwBsqqvf9S6IurI3JgXHsxfaAZ04XbCwnGcJx77OCtXurUz19zjFXXjO3GQBhDdtPEb3kfM+uN
	Gs7OejlBYj4JxJggRAEXc4I6E8EYz5lrNS4JXvp16o6Z1DsTRwp+W8lvAzE2a3rXhc3xjs+hAI5
	Fqb9XGPE3Uyf/zYUcNLbmaq/VETeZx3pqUflxzgJ97TyawXMNwQ8cb2LXMrptLpr4C/aAc72LhF
	pOMWtGhpZPxYgiJQpJT7jYJEHRKEKUZywPSvKMZSVXcTxoV8RlVpkn6qkfgxOF2AlHHiVxyTPeA
	=
X-Google-Smtp-Source: AGHT+IEq1lPlDoDfyXuJE4pI16oJ7f1H1YE55AHQrvWa6rEEYagyr3SEracSN4OqrLLHRXfD5li3ZA==
X-Received: by 2002:a05:6000:4387:b0:3a5:2465:c0a4 with SMTP id ffacd0b85a97d-3a572374adbmr10870066f8f.20.1750165213141;
        Tue, 17 Jun 2025 06:00:13 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b47198sm13724617f8f.81.2025.06.17.06.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:12 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 11/15] docs: use parser_yaml extension to handle
 Netlink specs
In-Reply-To: <f4eecf1c638c0d98369dd16818d5b175e208d138.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 13:45:27 +0100
Message-ID: <m2y0tqiljs.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<f4eecf1c638c0d98369dd16818d5b175e208d138.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Instead of manually calling ynl_gen_rst.py, use a Sphinx extension.
> This way, no .rst files would be written to the Kernel source
> directories.
>
> We are using here a toctree with :glob: property. This way, there
> is no need to touch the netlink/specs/index.rst file every time
> a new Netlink spec is added/renamed/removed.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

