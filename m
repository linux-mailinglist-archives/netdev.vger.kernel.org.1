Return-Path: <netdev+bounces-222839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C8B5671B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 08:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA43818977D7
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310627817F;
	Sun, 14 Sep 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxPo1rCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BC25A334
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757832037; cv=none; b=Nofim0hmdb6hxSsJ1ZnqNV5J7K1RgNK9jmQsgk2RYIasCpNYnl2ysiqH62PFb3GwInqYy1g8M5M/rXgl+IS+o1cBE5OKInWSyGwjw1yylPYQP7ZJ5/rQDfKXH6NOjHaVrtKm4DXCF8qJz0hzvzmqCYdWkHoACXI09K6T7NP3N5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757832037; c=relaxed/simple;
	bh=W9mBKKhO1nDG9kgofix3fJ5jAhsSVWPySySJxafsDg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz25P28fMhnDd+ahsnmyhRxWCTTTgKCFU6NkcTRaIScVXUYwSObAuI++SL3nWYMu1qEVCl/1xYy+v06n1TUDDbmk4FFKnFQbLDlau19rMncl14nsixJSDZExejZ49ISSZ8ARYsLSjp1ZlOSuJry+iNvqWHx8yetKcLghx/HZ7ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxPo1rCC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ea3e223ba2so93079f8f.2
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757832034; x=1758436834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9mBKKhO1nDG9kgofix3fJ5jAhsSVWPySySJxafsDg4=;
        b=ZxPo1rCCkZgBARQNa0334DlqqyphPP7cfa00eKMT4TNHqSX/ec5xVB/PdU7KJhJ9WX
         stjGWdo6g+CcxnV3fNWNptJMZNrLUcYXDv0lLQLhKCDllMfb3C3fFm+2BLE3VC2Mfiji
         QpdE9y97Wf5RGh9Lu1shjrLITGs9ulo3B/Or1A+byhZTgydNgLMvm9V5O3XRP1EKnp+i
         VGwg2//+0/VmBlB1bFjOZQ2NI7Sc1OkV35RgSIJJaBluhuNWUBtlJCGf3TSssnwqS4f6
         9GyGz38O3ZgJb3ToqqSB98v2R+okQjUh7jV0knzn0NPYAIMXpE5LQ/z9fvP+AXX7VZsp
         EJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757832034; x=1758436834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9mBKKhO1nDG9kgofix3fJ5jAhsSVWPySySJxafsDg4=;
        b=J7whYVYycVptK7iFqUmuL0C+VJKUVVg5ln4DTuLnDkTP55cU+bA1FXpKDevdFsW/cr
         QoL83bulaZd1G4J9PxOAsn15d29Ba1z32UJp+ZMO5UXycJUxRSEdckhNKX78fEJnxk3L
         WdDrVLfwZxtnURzFQU+lfu0bhivGjZ2/2fOQOfgVlgu/U1+L6tRFkoleEVPxyVHtWeNI
         iHkaLAKisoiKUmbsz8WPYRoIaYGkBCuoE7L2M3qJKqgegP9Uj4dBNZF/o+J3pJu9Jr1Y
         hCBjouICTQyjcamyJBy9oXjEzjnv4xIjZuzAfhU/ARrfvc/9/NZRDmyUdSu7vKB8ycCN
         WtWg==
X-Forwarded-Encrypted: i=1; AJvYcCVTiAB/gyW7OMt2tI5JF/K4GqPeQ5/7R9bDCaUN3otJuL1gLhnSf+p1vOyQZazSI4jwLKjei2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QlzIi3ccihJ3GfJTJHk3TZiMleVjfJFGBPLbEOPjnMDEIlaB
	+XdSGmL+h/bsGTTHdetHDlsorMFoBeSF0h8hRKUxTJ5CKmx2sRQSmaqD7XSbsNjuKIlSmNu1ioy
	Hc+EBdj/3EM/opgMxaZHN82SZX3jpDWM=
X-Gm-Gg: ASbGncu9sQEWCjfTieY8RKfKeO3RlMn4askeCfZ4j+3jf0Uj3QoW3kDLVB+DS25Ny5j
	7WT/rTB72zKeHx7+aZbbo9ds9Lqp7nz11B6WttIDXfiVBCTDSA5PzIhjZvY7MuW6RGEZ6OQTwZi
	x16ehURX+w2jRo9tMDyycOs3pIrCk4ld5u+nRhCbJbu8oegQh760BB8Lr7lIZ7IMVYuAHELHs8i
	9G0yuXd8FUMzczUvUii0jK1FJPHXlk5IzKSZA==
X-Google-Smtp-Source: AGHT+IG7BfAN8YgdMhPRHfWg9au31LmiMJ4FCAqPBRvsfgGJrVZfq2uKb4GWTOHEh/+vDSJLANy6x4rVX46AhqFQA44=
X-Received: by 2002:adf:edd1:0:b0:3e7:ff60:cace with SMTP id
 ffacd0b85a97d-3e7ff60cba5mr3742532f8f.56.1757832033848; Sat, 13 Sep 2025
 23:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <aMXZm_UL58OkoHlG@strlen.de>
In-Reply-To: <aMXZm_UL58OkoHlG@strlen.de>
From: Elad Yifee <eladwf@gmail.com>
Date: Sun, 14 Sep 2025 09:40:22 +0300
X-Gm-Features: AS18NWDanC3VAORRnntTzRI-0ysMkY5yJY0vhKytcbLTgHpDzFeIHXwTC1H6sDI
Message-ID: <CA+SN3sqzRMWVF5ZTW+hjsKjGfvsGzCn2qUt+uvNWAzeYD-54hw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 11:52=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Under what circumstances can flow->ct be NULL?
I thought it could be NULL in a few cases. I=E2=80=99ll verify this on the
inet/IPv4/IPv6 path and report back in the next spin.
In any case, the null-guard is harmless, so I kept it.

> This looks almost identical tcf_ct_flow_table_add_action_meta().
>
> Any chance to make it a common helper function? act_ct already depends
> on nf_flow_table anyway.
agreed. If there are no objections to the main idea (exporting CT
metadata on the nft flowtable path),
I=E2=80=99ll prepare a new series that factors the fill logic into a shared
helper and converts both act_ct and the nft exporter to use it

Thanks for your feedback

