Return-Path: <netdev+bounces-115318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9A945D38
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8A9B235B7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEC1E212F;
	Fri,  2 Aug 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSrXsJJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907C1E210A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597827; cv=none; b=OT5/0V9ZZ7F8oekOMOoGAQJmZ5jlK4Y5Z0Wb/BcPnNdIejZEKVDpZXKrQLD/XIGkcb9bWCsWvIJmcyibzMCp/WSLro36XSIW8JCBMcxCl0fe0kpOLHv2jDM8DPk/bgaPnQDXwENd8fNn7wzrjhHfUWqwFVnhysNIvP7Dwqjf/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597827; c=relaxed/simple;
	bh=VCMnpltAgLcnIlUjr6dJwB7StRfY7JdRLsILPreNNOs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZYtFazv3FJfX19WLBQliXERgzGGbpRRkS0ljNpkJARUcu3JPdYljv7oiKoVfxfWET+9saXwuwbmYvMwEuVHL2ABOI+hH9xcBxSEtTdq1Kgm0BBW/F3eM98kvy3uKU+tkk1YKazZIMxz0y6tGDDNfhbEUWWq0Z/YJza4/fhKBvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSrXsJJ+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so91382221fa.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722597824; x=1723202624; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONdrsL7JDomhRRs1wygKDPeZPHuYxZxLLbqcvLxVU1Q=;
        b=eSrXsJJ+pWwOiW9Qg9HYyx0qL/aNFs2/k/bblGvZSAM6AcTaeUCh6vY3llFzdKUQQP
         XMdTpPZO7NnDWXMkcl06VNQzhal5uamT5ifg0obubDLFRyIhcjyza9dpvnJW2zi6cLuC
         GiMtegC5RPd41jkipliJOfO5pbweDKPqeFPagL7eFBEpIQ3OeSjwt7dmZ5CbADQBUWNJ
         LpUkYtBUviDhvTAIQkMZ1P+X58SyaOamNR5oeqwG79gi4iD83rbroYIWAFwNYDpeNeID
         FFOY1B+exNsAcuaSmHpvmdm5bw91XOtP2PzlKYedG/mjXkUO5bWgyT+V52afb+3kF0NT
         t60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597824; x=1723202624;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONdrsL7JDomhRRs1wygKDPeZPHuYxZxLLbqcvLxVU1Q=;
        b=IsuDPO8B9H23S4zZLqoIM2Y0Xfim2gbfsf5eXYSAauRgpnwB71LsRNob2B6po7bZkP
         wO3G7JSpY2bZYzA/ciCPmzJfoOW/3PqjNgJxKk4KJTJtEgtHDXeF0opTHPTH1fQ3eSwf
         SufQzBvAdTGq2N2sUKBEs+QQ1icMIP2li04NBzs8y+540/muQVDaSgNSKCIsNCiDQl+O
         HQorTLxz5YIF3UkXwHZqFsrPnRvSbHqjp36ejIxHxthOhCH0SeuJ0rmaM0EdXzSMmi1g
         pOVr087U2ygAkjttrbIqSDZqn69qFYDlN1WhAWQmg76eL+jT9b+5aI65a3q2z+9CCYBL
         nydQ==
X-Gm-Message-State: AOJu0Yx7lfPXB49MOcbYJSqjKf0R4xkkv4QzKwb6lLdXvWL4dOMp/BGg
	56ft54BqFD/PsR9uAjipKksxjiNhMXFrI13U8oVzjeozsQ7IZhIQ
X-Google-Smtp-Source: AGHT+IHM7XUxrK6QlIpJnrFTESar/5ckjDHR8p4BCy1XGDYw3JgpQhl861vjXQrytqhtW/Jf3KDZ0g==
X-Received: by 2002:a2e:9c8d:0:b0:2ef:2e8f:f3b3 with SMTP id 38308e7fff4ca-2f15aaa446emr21932071fa.21.1722597823339;
        Fri, 02 Aug 2024 04:23:43 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e8ca:b31f:8686:afd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ada30sm86787835e9.19.2024.08.02.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:23:42 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Madhu Chittim <madhu.chittim@intel.com>,  Sridhar
 Samudrala <sridhar.samudrala@intel.com>,  Simon Horman <horms@kernel.org>,
  John Fastabend <john.fastabend@gmail.com>,  Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 06/12] netlink: spec: add shaper introspection support
In-Reply-To: <8f7b753a8eb346d3f9ed2990f60f12d3bb5a6f4a.1722357745.git.pabeni@redhat.com>
	(Paolo Abeni's message of "Tue, 30 Jul 2024 22:39:49 +0200")
Date: Fri, 02 Aug 2024 12:21:47 +0100
Message-ID: <m2r0b7np9w.fsf@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<8f7b753a8eb346d3f9ed2990f60f12d3bb5a6f4a.1722357745.git.pabeni@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:
> +      -
> +        name: support-nesting
> +        type: flag
> +        doc: |
> +          the device supports nesting shaper belonging to this scope

Nit: capitalize all the doc strings for consistency.

> +          below 'detached' scoped shapers. Only 'queue' and 'detached'
> +          scope and flag 'support-nesting'.

'and flag' looks like a typo. Do you mean 'can have flag'?

> +    -
> +      name: cap-get
> +      doc: |
> +        Get / Dump the shaper capabilities supported by the given device
> +      attribute-set: capabilities
> +
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - scope
> +        reply:
> +          attributes: &cap-attrs
> +            - support-metric-bps
> +            - support-metric-pps
> +            - support-nesting
> +            - support-bw-min
> +            - support-bw-max
> +            - support-burst
> +            - support-priority
> +            - support-weight
> +
> +      dump:
> +        request:
> +          attributes:
> +            - ifindex
> +        reply:
> +          attributes: *cap-attrs

scope is missing from the dump reply

