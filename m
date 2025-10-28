Return-Path: <netdev+bounces-233604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53636C1646C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81E444FEFF4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75534B41E;
	Tue, 28 Oct 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mev9YXuM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB1199FAC
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673329; cv=none; b=pRyyL1yZ1DJKfuaEr8QPzwsvrmab+ClOaXEdcXFLxXa9s1HIk4oilIh35GqG/8a4FeFzn/wSyzA2GB793vyhxr/K+MsByqgsh5roDTUUVkmTL4brmB8s/HXgGJlVxvT8FvmjCHlNKSixIXLeRldBo/cAgdTLtGvuHwQkjk2L8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673329; c=relaxed/simple;
	bh=Im6VzXUuwdDDmZDQbOVnf4aGedh78bR8cSlODEcvMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLpRte6dPkdR9RU1z3he4gQQVA7GCjI9n33D5esOFo1GhDIvl2irWF1IYlpllX+cGQc/9XUumh1n8kpE2dN5sdROi1dV+6shrALmrcKMnS6MeGmncy7Nf1iD9hb+GCdzDjTf5zdb1re5tIEZec0iVIee1FpnJIjAfHhVvg7AA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mev9YXuM; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7a26b9a936aso3700233b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673326; x=1762278126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=mev9YXuMu+qGoKD5lO6M3V82corZbeb3NZfCrDXaH1LDRt4woQP5QwrwwbJkiMJfCq
         1twF+S2v6rhmhlOlGUwYLeGnaEM2/BgKcd3SNbx4fldJXXGfeRm3D2+pT7ZQkpVCQ1j5
         5oYGP1mEviDdX2A/lX6Al9kcOZFJriJIOIpG2hNpSuq0J/+TznBAG48X+99zpOPP4Nch
         4qTwLOqDvGsYmwmuLLlTNpLrg7hOyCh4ix1Xb6MojWH+dzoW2g3tZtbdmSKYBl2OoJsG
         yzjYTY+X9uvCpszPm5kUECSy29R0ARE52nN0Yy/IAbi2ho8QoP5bR5F49wrYMmZBoXJP
         6Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673326; x=1762278126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=dZLrfOz+v3IXfztIPhNE7gNDSYl6Twj+4TwimDvF2DipUu3y6h5pWvR/St6U8IJf4c
         j7EI6Yi3fmUBDAE/CWrzBNaNXE/mrHJ6hpbFn2bXOtfyzY5zOSFRo3CdeKukFBAKQ7T3
         sKzf10Al7J1O1BHphfP5rD8Q8wACSypnhn4dRNKCq2YoXwzqRsWrp3sq61jywTfDeaSg
         d5iK/jXCPfZY+3pnqNMbVOSeq0HVGf+IGavBTUaBaCbvnpYKYS62Uz3wd9ucH1/bdce1
         0OGMXWgxU8YNb7yiGnjFk3EAVpLFnfa6l7W9P5UGQy6aTCqw0/hMNk/G2IbWNNdH3KkY
         DHcg==
X-Forwarded-Encrypted: i=1; AJvYcCWqQwsF0HH1rMO6Q/XpWSnRA0VTTdo4dEZ3iozg9J1DfpIepZEGE2Gix0NVPAT63NErkmeOOaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKueX27dJXZBcW7yZxOCBwELFLnNc8OyrB5t9DpV6dKrnooI8A
	itFdDhN3u/fnClyb31I8rETsOQ02DYFZ7Ti8al81icZtv3yHC1f/yp38lNZou4ihgfQ=
X-Gm-Gg: ASbGncu5F0RUz4EGk68fOyUkcoDEGIOTwFiOVFyPNm7OjYmuB4TkR7QNbH0WtBjDrmw
	ABxw/4poNsEh2GeoCD7RfHSaBWuNLNp4zYW8uVzzzUSWoEemtjhG+2er5I+L3hc2XPY0ZE2P8Hm
	BpzEOhdZatT7DqqalZOl3M/mW8GMfqFcLNBta+zUDVONbFXk8+mo41NZ7zglGutWOlwbXF/Y7je
	JaLuQpQlHSB1w638jBpa21c4rYYSbpoB2fl47t0Dm9BtXxOqjCzJ2FIsHkwsM614Dcnfxq8FNxu
	DNeMKctl0crEhSgEWUYLBQKoxcQgIpkiEqegla0hXcxkMZylRzknrf+aXCYQ+cG7mK7fwhT2wm0
	sO37nl/4ZLkR9fVU2NxZsmInZlGeoM9fGvVNVnD9fZfiqPD4d8Yf2yGSd/TWebF53xxnV3YI0+L
	41DgzIOV7vb8YVlEIzAo0=
X-Google-Smtp-Source: AGHT+IHY648HfWpg/1mCsYtX8S4x0CTFltDo3CpRCwoMSOqHKLBzLVsRp/I93hYx56RK6MNiNgUYAA==
X-Received: by 2002:a05:6a20:2588:b0:341:84ee:7596 with SMTP id adf61e73a8af0-344d228adf8mr5688460637.16.1761673326191;
        Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm11197981a12.6.2025.10.28.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:11:56 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v2] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQEAZLv8V0asoe4r@fedora>
References: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>

Hi, 
Forgot to include changelog section in v2. 

Changelog:
v2: 
- formatting fixes compared to v1

v1: https://lore.kernel.org/linux-kselftest/20251026174649.276515-1-ankitkhushwaha.linux@gmail.com/

Thanks
--
Ankit

