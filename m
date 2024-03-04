Return-Path: <netdev+bounces-77067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18AD87008A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1F91C215D8
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5C3B297;
	Mon,  4 Mar 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvxjh2XD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB33B189
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552486; cv=none; b=kC2Qi66Hr1QcqdQ0DsjyXC6wCHs7K8IM88GHqhaUMw+0lSbn1FQjAW/skP/SzK7fh9UkJAXmLdhb2bW1ywgUSP1l2yhK2E92CRQxjG0LH66x4hlRoKVg3R/AfHiKa7251vMfIpQCJUshLbUpvoWa59nXAkBJVjSyF+fhhUykT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552486; c=relaxed/simple;
	bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=b9fbIKu3+k5YKkDSQYIo+J0wAncwtfEzh6LHNLtYFWlkN3Y5vF5N8rMFVWxVgd9FzdDxNi9HTs6g+nDaST2pRNhdwjzdbdEarWxTy45C/aHhwDCmWbhOZwvIa03I5TACqGu/UfgJWdlV3F0m144Nzdzdyw+mdH+Z+9EISK00YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvxjh2XD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e4619e5eso4829195e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552482; x=1710157282; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
        b=Wvxjh2XDptkUWnAr9WZ9kTp+r4PIJ2uc1lRvJABCRg/mRnuRX5FczdM5B2KhTBOO5J
         sZB9Bs7VIjapM7poi1C1L80YfJZ/DrmiU4lIqGiYFQv4ILk99Y9jyAI+ztmjQ7wn/beR
         Hqnr9PDLINFYFERFaAorodSFHPNAYjpXttvPtQnf8+5/dniBZU4PuKnMdjSI/jNCcqZh
         f/pCagDfSvP0hcfnuKOBAgngecmbsupkBss3CtTkJAXuoMQX0buRQ22IwM4MgNp7HEFN
         jkpkAUnPagplHxaKHBPxNcLzQlfS3g6RNMkwVGxSNIlnGEyg2CcIs0rigbXQfxgwqcuq
         Ubfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552482; x=1710157282;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu000iZMKv3zclEMUmjlT2fMuGnV5pMNcJ11wZBYFl4=;
        b=Ac8F2RuLazyu7tGMjH4eb+P/Gy9EusFhPFYafHehXkoaVFuykFhIyHlZF1m7ZDGkSn
         hvDrGgyQ+sb3LCx+f0KpD7IuUfzYh9M1KGiFUscZ9ynskRW3PLjynPQRSvJ5BfoAzrmF
         TH2Ai3KVhG/P9FLvlPwFCTf1fjLPWzpHGVPC1nk6BfrOronR6qLFigB735A1bbZkoWIN
         goSH9c4rnNpeHHCe12lwosvsNE81LESy+beI60Y1PjmoEgaHSB9W4YHwC7p3wKm3icWU
         m5opbOOVHn0djJxCiKeCnEL33DwYmc5GtJnGYMKfEsBSWw+nMFigi6vz97tSY2Lyw0F4
         Amkg==
X-Forwarded-Encrypted: i=1; AJvYcCVlFSg/rwJTk697iDJM4XbMeNnTAGtvCb2YhURzsz++XVhdwDfC4fYB7XkF3FN4+2DJxjSxuuffTkXAokO6mjg6UhpKdOjD
X-Gm-Message-State: AOJu0Yz5JR6pv1KbY0ubE+Kcvmrd/rd2g0PgfpHvi64DA75XVUAKiw3C
	LYYWwRRrXCpDY97/8wkCG8Eav6o+q4bBOBwnADMVTUtYXVBS8lZS
X-Google-Smtp-Source: AGHT+IHWwulpvlOWPnTDf5+DjhBat7d1/ObIBufeHAAuiNZt1PduXKP3IYXY/w/5haRClYRVd47QbQ==
X-Received: by 2002:a05:600c:4686:b0:412:a48c:139a with SMTP id p6-20020a05600c468600b00412a48c139amr6443855wmo.6.1709552482643;
        Mon, 04 Mar 2024 03:41:22 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id v25-20020a7bcb59000000b00412706c3ddasm17124141wmj.18.2024.03.04.03.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:22 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 2/2] tools: ynl: remove __pycache__ during clean
In-Reply-To: <20240301235609.147572-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:56:09 -0800")
Date: Mon, 04 Mar 2024 10:23:40 +0000
Message-ID: <m2a5nel2hf.fsf@gmail.com>
References: <20240301235609.147572-1-kuba@kernel.org>
	<20240301235609.147572-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Build process uses python to generate the user space code.
> Remove __pycache__ on make clean.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

