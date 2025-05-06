Return-Path: <netdev+bounces-188457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA047AACE16
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF40523C8D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C967262D;
	Tue,  6 May 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koB+y26a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376C12E7F;
	Tue,  6 May 2025 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559975; cv=none; b=hJKWN0G0tqD7EElKxlPpkIZ88SQarQwa84Q4B3S7N/WF3VWR0H1nxyM89lfGtGMZbZ80xGCZqf/u0bc2nM1VlOACr99vjxwdaOtIINzuGQsS9WrzRMKBXNm4Cn6f4N0bR+cnReb1cocvNjXj3Esconos1hlgTP+aQHJWAH636ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559975; c=relaxed/simple;
	bh=r8DvrKG8gn3dN787r2tmNGHcO7PIkHUQ3Z4vU/nW5Fw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KgSy1jhhJg0YVhv3buuNLo9jwHTWgZkEU+JbR7tjq48yg7gUg2G1gfIexIBDMINGF/qrOD2YO3ehT7ARL6fJQC3fqBCHCeRTkXu3LxXF2YDb7h8uzcpA4lWDGUW4SppHqLGH0dUrnEUmxGsMbIZtIMWQlqpZAitNvFbX+TlvA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koB+y26a; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476b89782c3so73460121cf.1;
        Tue, 06 May 2025 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746559973; x=1747164773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs71N6GnYmn4MqaZvHsKWMqNJF0JCifRIWX9ZIs1JKY=;
        b=koB+y26aHDPzVA+5dalo/Yu+Dh2yTR364aIY5KwM6edj8u1qNWTWAGu/MV58s68aA2
         H7AqXAJ8PbwhIJkYpTokYPGkzIdG0cbn4dpjJ38QN7dp6AMzlX0R6L+D3hWjrk66DpDN
         AAU0mVw4OHHuLM1xbkkn0D+Z+33kT1W3EQBDgR+ajQYSNNweNP7mkvRmpxPqtxkQZayV
         uqiyueYbSI7fPjWU7NYvRBLWZ09+sh1vwY8LUD6bnBIAooS4xfp2upZ6JC4vT8/COWjY
         L78VTNZpntuTuCsCsRi4A56y6t/ZewH2T3MqbIBgjo18QdndvB/Bk3WtvdPa2sILzCy9
         OTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746559973; x=1747164773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cs71N6GnYmn4MqaZvHsKWMqNJF0JCifRIWX9ZIs1JKY=;
        b=OW4zp3X8NY8Zqy+lNtkhqlSIZBYtpHYz938QGlk4pUo1St4cswe/xq8PTt76EB/dw5
         G5Xl5N6RXdvI4vF+tTBzbzQpozLLKmAhNk2Jm3FWDsq9OXkzXI5xWUEQg7ypxwHwWZ3D
         mZ4x70uj9c6Ug7cDgiwBO8+LXYRr3ocX02+uMp0Yopxdtw/KKjJmLQ7PCtihzkt0OwZ6
         zY+3UpmE5X5uMZ9qzpsQiwm1f1LcmHkCAGNNJ++6QZoBXJ52s/a/JcduF42lTfD6w0JN
         50om7AhFi3lelPBapwMoUvN36qhbGMunP1IsHrb/bE3Wu3TMVI1vscrcPCk+QBfPohZG
         TTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVK5FhD3JuzI0+F0sHqB+JEXs7T7nKBETXqgQRZjTxjy5dNLTHCHcIGnBmKskR3XIWU2PifGKu4y8XR1OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcYq6QqcgDiRzLYzjUXxgd3oOj1Nz6chjvDoRWMGNsS+16M9O
	mtBhhpClCR0pJxKzU2eMPFuBTsyYbuPS2Nfphb9yssXYA4HPBtou
X-Gm-Gg: ASbGncvy3wthhNqr7dougndyCBj4YyQEO/JQz7I/ZD4Olyj/Y7OuPsfYVmHccoJKOI1
	tWoNl0CfRaA7TKLLcDNducQyJgK4P4UGnAzcZ7yJkpC8hXnS2DNuWiCIhD+f+QmZzRN0CraNlK2
	estSnO/AcvX66h4X930siE/8APD+vWjFAoV8E//+1lSIjUXf9UfKb41Oot0WeMm3cA8CPSJCZxC
	1Z70GB3ZNsRksW0nH4B4bTn7gKELWjLQALuhiIAkioJ/NPXhofAvul3eCZkNu7eA+PtGeQIIfbI
	1TGJBYTL7czZu82hvHUBptiPlJO1copqdsQsiAFpzQaYC3OFLMVf+9L55M9dbMzkw8EcpJ7Z937
	FqF047oFdU/t7JdH/8nYA
X-Google-Smtp-Source: AGHT+IFofjG6nPXVtzMt5Y0CsWO/tGj669+qkVznvVfA7OuWByxfPQxw3OZ6XxR3s7vjxwVyUdwSSg==
X-Received: by 2002:a05:622a:4c12:b0:48d:d1fb:3eee with SMTP id d75a77b69052e-4922620b317mr6475081cf.23.1746559972627;
        Tue, 06 May 2025 12:32:52 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4922174b4casm1609311cf.36.2025.05.06.12.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:32:52 -0700 (PDT)
Date: Tue, 06 May 2025 15:32:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Alexander Shalimov <alex-shalimov@yandex-team.ru>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <681a63e3c1a6c_18e44b2949d@willemb.c.googlers.com.notmuch>
In-Reply-To: <24a121fd-aa4d-43db-8c8c-477bca99a7ae@intel.com>
References: <20250506154117.10651-1-alex-shalimov@yandex-team.ru>
 <c02e519b-8b7d-414c-b602-5575c9382101@lunn.ch>
 <24a121fd-aa4d-43db-8c8c-477bca99a7ae@intel.com>
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jacob Keller wrote:
> 
> 
> On 5/6/2025 9:07 AM, Andrew Lunn wrote:
> > On Tue, May 06, 2025 at 06:41:17PM +0300, Alexander Shalimov wrote:
> >> This patch exposes per-queue utilization statistics via ethtool -S,
> >> allowing on-demand inspection of queue fill levels. Utilization metrics are
> >> captured at the time of the ethtool invocation, providing a snapshot useful
> >> for correlation with guest and host behavior.
> > 
> > This does not fit the usual statistics pattern, which are simple
> > incremental counters. Are there any other drivers doing anything like
> > this?
> I don't recall ever seeing anything like this. If there are, I feel it
> is a mistake regardless, and we shouldn't repeat it without good reason.
> 
> +1 to looking at another option for reporting.

Perhaps bpftrace with a kfunc at a suitable function entry point to
get access to these ring structures.

