Return-Path: <netdev+bounces-80980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBD885643
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C3D282442
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E13BB35;
	Thu, 21 Mar 2024 09:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D212B81
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012432; cv=none; b=t4siKXaXKFEtOgGNBtX1Hi6D5kEf4vdbxMwvH6dOrkz4Exfs0OIs8vH1Zk75OWZe2HDR6Sp8P5QhD61xBtlI4syoTnGXLq4jtcuw9GgiUbtjWuYMh7KoRBh6whlquyBrgCHgnvd/orrnv+G1QyP5oTAsplXF0qR+vihZh3QaCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012432; c=relaxed/simple;
	bh=fo4gtK5z5PyFuB28Yk40tv9Ltho3oCAUMTrB1OFrr/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbnigfqeDQLrzbxvC0gcnosf9nUADyoAE23lzqAeAO4vnC5MK7oSAG/kdFxakJSwEl/RnFKkBqhf5KhqhUb6cFLlEkZwhwN/g3QgyiFb1G+2mcy6MsPLkeTrGWRSeLRkGka+B0kkA8SZY1DutqN2s6wTlrjsOZIL41ErpFJ6wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568a53d2ce0so957566a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 02:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711012429; x=1711617229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu1CPOXxxTeFPRVEqGjdY1c+JYzwQ/+HNzCVCyHRYsE=;
        b=IHwoC5fmlQARHwXpaWMKs9TzwbKyYJq6pH0GVJpi12dNc9I/1hkz4w8sfJQNo4RCgy
         fiv7ukVeZwu3ndYTlbbwTzJQbwafLYT6U0pjckCnAu81bMol+veD0UUM+WpgLddlhvR6
         jwwxj/4/o4iuBORpeAayByczUnlnaWvpGMnaAjqSkEmz3EiJ8OA14YAGYcslsDGoxbho
         MJ41zmlB+iF5Tn7LxNhHnlsxiS54OjKoiVgHcp2k6sN3N61dCQqxIkaUrLcWBQOGSo0d
         h0aHbPAH0IkWZhRurkwE9yQWCocThg1fYwFx6V/cSbKBR9nd/nQJyfz+gEKFoCSbG7n/
         473A==
X-Forwarded-Encrypted: i=1; AJvYcCVg6Nb3buRB8elY5E8EdDbCT9ep5g+3oaAhn8JVlMT62MLr67yyeZxFTifrAlWN4czlFL9Kfg+XVg3uHVW0EtvLtjKb4W3A
X-Gm-Message-State: AOJu0YxKXlWC8eMMJve37Nv8PHwKKaRQ9OlDr57oHTHZ9V6l5QEHN1EW
	wpXDvvGMPRqhsEwVq1cIyz6IN6uKylydAdiEfRgjnT75NF+w6/nHwgHVRVu/
X-Google-Smtp-Source: AGHT+IGUBBwVl0SlpzBG5lYulXLO9rGnsueKl7Dk31MRESA41cWBlZKeWv/5f/aKbzUXMnFAxUuODQ==
X-Received: by 2002:a17:906:36d0:b0:a46:f69b:49b1 with SMTP id b16-20020a17090636d000b00a46f69b49b1mr931147ejc.46.1711012428924;
        Thu, 21 Mar 2024 02:13:48 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id be7-20020a1709070a4700b00a46a9c38b16sm5929726ejc.138.2024.03.21.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:13:48 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:13:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sdf@google.com
Subject: Re: [PATCH net] tools: ynl: fix setting presence bits in simple nests
Message-ID: <Zfv6SocBxYXCFmQF@gmail.com>
References: <20240321020214.1250202-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321020214.1250202-1-kuba@kernel.org>

On Wed, Mar 20, 2024 at 07:02:14PM -0700, Jakub Kicinski wrote:
> When we set members of simple nested structures in requests
> we need to set "presence" bits for all the nesting layers
> below. This has nothing to do with the presence type of
> the last layer.
> 
> Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

