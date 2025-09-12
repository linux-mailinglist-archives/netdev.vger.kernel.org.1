Return-Path: <netdev+bounces-222562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCACB54D04
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 218E74E307F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE67322A34;
	Fri, 12 Sep 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK17vNLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770B3218D3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678934; cv=none; b=tR/NkiZHqJazOB1AILL6ZCAF+WNVs5K/561O4v09ASwuEqTUkV7CR/AzFlnNlGhNmOo6zaS2TV0N8AJwbkCOaNPiI6wd4Mm2Tb6ypdEdBfyburpumjZofi0D7rz5mX/JyyDM4pCKgr8zy9bCGIva0h+LcLdX19qsX41thtbmmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678934; c=relaxed/simple;
	bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZW9cBZDVZTcQ2ZbvhrohsQn75NHgZOFXFDrfytUNHpszNLHReTbJGe3HDl4iFG/ex/b2+EVom+1EUF8D6ak4KGgCk6xR1i3NEOzIq85akcgFaJKdFduI8l6kartRaE1aqtsqEwCCetzIX7NMaJHUliLsDnNLkewHaySmJOaQ7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK17vNLO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so5155985e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678931; x=1758283731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
        b=aK17vNLO3FWypqeHtCtGViEf/AACbNqqr1aobsHvHd70tNvEJLvNVO6V9ib/6dbtW9
         1659OC0X7WwHLO5I+fSBPAbTEXQQll20pooTXhDWqeg6CTeciB5Jl7IHpfO+ia0Lsn3h
         JIxDGDQK9DeAKy1KtuJRNEGWoxx8TEd8WoLuOPTPizgOkjaPv8lv4mnm01nxDxTDIpT1
         5sST5WznhYi0MC8G62+4+q9LY9lrrHN+EeY8logmrQc2OqKf0CIThPtFgyEq/jMb2nI/
         NJHekOwMkqhHYWhcrJA15oKuJqQjfE1EvJsJeWqyAJbm5h3Rhyvalzxhe3rScog7qybV
         UHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678931; x=1758283731;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqPZ8RULX7eu8BAG8aFIfDKASv+ULLACp+JE+crY35g=;
        b=TyW6tIV5PwV72jMZ4ZF4t89Be6tDFrJtJCM3KEErSeS7xvcYtvSEkjavPonPU8COIH
         AY3Fg89J4+5EzVfkCvLnIcCmSZfPEkmhuXjFG74aA/Cdb5TVXmgfiGVxDiQ1TVZ3xV5X
         IpgLE5cflvfz3UkMgsCrGD/Mo1uh372zjlifp2DslASc7gg0rr+uUibx7a37xlq93817
         S903tMwCsDdOBPQ253JZvumktNMCF/THhHtrXf07c4LE1fxY4Dbxyl3Y/lexBhiXeJlW
         RlpCf+UpD5jdIX7AzifL+cq2XOKICl55ucGQnkyGMOcl8IhtynUcXU7fEgImBIjZTv5w
         hefQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSb9Ax/UMTEG57ZgSiaA2xKpcnzzFCVVdrPgl6vxo84GRblLh+cTjLlquv08UzAq788VZs8PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1QcIBXkoR+Q8dOjp2XN18IJ20Lc+QkcscSlfe+CopTU7Ob2v
	TOseLXq6sHVAAn3x++CQTy1jGNfbgKn6jXjVzB6JZnMdo6KWTuj2WE5US/F+gg==
X-Gm-Gg: ASbGncs0H7trcQ1DaozbIQlGPDpph0pa3FQ5OwrSZdYdER1VsUYRG5Nlle3v/cfWsgh
	4XggQ7EWvrwVmQQUm3zx2zJ1U9UPnqT0F6ro9Bmvplw+jmTII4bSNsPctd40dBD4YDlCFA8IWjT
	Niye5OEmm8urS7sY3PuxmQ/MvSLwxj4AUdsqPNJjiKozechiKyJfB9r23XiaQJ6e5n5i2YCzN4n
	7S+ctlkeEik4UUfEqZw9tDZiMaOYCFRJT52iAekV+FomNm42v3LrOJvOE7MyxdHuB9NY83wgmQ7
	4YbwrfzfI+eo6HMqB83RIoMR12hloUBJOr33wbMDWDE1YqwrONmbUi2vBc/4v2G//3NNj8jvBzC
	CEw+wpkpsAWpigtHSbVkhYTbC8l+SazKwSefgDEXhrDub
X-Google-Smtp-Source: AGHT+IFcON1v4F5KgBV9t7GPfhbJioy7Wd6FGUuDsb9CuUxnRc9simG96y0fBd2RO2HzmYnS97o6Tw==
X-Received: by 2002:a7b:c84d:0:b0:45d:da7c:b36 with SMTP id 5b1f17b1804b1-45f211f67camr17284045e9.19.1757678930584;
        Fri, 12 Sep 2025 05:08:50 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d7595sm59573645e9.24.2025.09.12.05.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:50 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/13] tools: ynl-gen: deduplicate
 fixed_header handling
In-Reply-To: <20250911200508.79341-7-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:24:32 +0100
Message-ID: <m25xdnvrpr.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-7-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Fixed headers are handled nearly identical in print_dump(),
> print_req() and put_req_nested(), generalize them and use a
> common function to generate them.
>
> This only causes cosmetic changes to tc_netem_attrs_put() in
> tc-user.c.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

