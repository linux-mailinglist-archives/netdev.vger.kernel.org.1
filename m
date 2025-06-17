Return-Path: <netdev+bounces-198500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C2ADC71F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC4D16E35C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D22E4269;
	Tue, 17 Jun 2025 09:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1C2BEC3F;
	Tue, 17 Jun 2025 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153818; cv=none; b=odDmQfOVhTYHbryTC5FfVvnB3LtXfTbavi13TLPQVxkAbdI5cyEn9aUvpFt7dnSaFzt9/B+gwMxTo/XSNM0LLrSiuxMtmV3a/JW+TOZt5ggkCs5SA77Uw0XelJxo5j2j1Q/rZIWS2aj1X3qC5ivaSRtSrIlbUKbf2KQiDnRtfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153818; c=relaxed/simple;
	bh=YH8snW+HQzPkJeXMoGvcgRiLRIoHK3vIXAy0/dbKPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhASUgrFWdJQhFQVsoakRELqk6gfu5bytzxQjCaFxL267vgv/Yeqm6swIOpyMbsyn3Bdzzji4zAiJxVRQyE/3dAuxUZbMxK1iChu+aMFXm2nUeih+l9BKhU0lqrThrjcEyNkTMu99ubJJaaxrCBOH6uPSwAKFFR1pXtRYVGjQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so1015268066b.3;
        Tue, 17 Jun 2025 02:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153815; x=1750758615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH8snW+HQzPkJeXMoGvcgRiLRIoHK3vIXAy0/dbKPZI=;
        b=SYKA5iefyaticxCC7Ksl3setSKZGVbFczoPXGTzkrTsVbheIKXohuPllm/k5RY32f2
         /G6nL6icjDn2q9geRxib3uvazVLiJiN5BTPfWMz6y1kTZ/6+BOhSOfiPxarK6n4eKdPC
         pC6tPfrKYr7GtLOpp8DKJwmsWZvZo8pv4jmB3WfO8rbuvmX8REqFSgot280abXnXXlz9
         MOMlnst0l56WTgEBWsNZ7Xnh2G3uVMxAVWD3JOlapmJXZJ9eHADhQ0WIm9VzJQGSJe87
         pEUXfysyW97nfpVFeViL1HjQjXAJDTnRPgapTb8ldrZg0mDGQbc7vhU5caaRQ1cFG0+J
         1Ypw==
X-Forwarded-Encrypted: i=1; AJvYcCUIpdNptlk/SDPzDhIp2B0ku/ENEWYhAbbmh9sJ48Lc6Q+Ja0IwI1dw/XBQrBNXAuxcGh1NVJ52@vger.kernel.org, AJvYcCWIp1xZ0GOhnlJC0DZjuei3dX0Einftj6ceGNfZjErfDbwwUbuVZWaceJ60GUpk8V8oGkhjcz/iT2jiJtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjldqOsu17jzw3rwsPpXmV2DnEvdN1CreVhciYgJmPtXjysz+N
	lGJEvfkIqR5bIN9fITCk9oPnpFeSlRw9xe4N/2FXfsruB1X0tI/wDH/D
X-Gm-Gg: ASbGncs17nIUUFY4IBOuwQdHysdGjT7vCAb49zt9mM+JXztSM3/JjI+ABOwGRBYNII0
	XdShNOrED1X/2nI6q6uXTXegtbV4AfbXoUWZ1OVtuBvLXd5EbHevaje3HhZOn2UtW3V5ISfbk7m
	THgjB7xWT9vTxRuPnLyJm6HdUFX78rhbHPFwLGFRxMPZ3aTZhpSvwULE96BPVOtYSyTeoOAW7DG
	HCtaD7jxzHwAxP/I/i7niJzsMoGFzL9NzPkcb1k3BABuo6Rgi/YrLdcp5HizGv56cASs6+9XOSY
	4z8ugEdz1NIfIkG6JdqfCRyjhHgwhVjVidGgSyQLVbmKE9w/82EF5Q==
X-Google-Smtp-Source: AGHT+IHn2FJqs9RO9flMz3wqH58LiFdg5OFFDyapqZw3NxqVXI1mx4LABvm24mwAZpwVpNqg2v/fsQ==
X-Received: by 2002:a17:907:1ca0:b0:adb:2bee:53c9 with SMTP id a640c23a62f3a-adfad29d046mr1234466066b.3.1750153814797;
        Tue, 17 Jun 2025 02:50:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8977545sm844022366b.147.2025.06.17.02.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:50:14 -0700 (PDT)
Date: Tue, 17 Jun 2025 02:50:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v5 09/15] tools: ynl_gen_rst.py: clanup coding style
Message-ID: <aFE6U9e1Y3Qu+v62@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>

On Tue, Jun 17, 2025 at 10:02:06AM +0200, Mauro Carvalho Chehab wrote:
> Cleanup some coding style issues pointed by pylint and flake8.

Sorry, forgot to mention that there is a typo in the commit title.

