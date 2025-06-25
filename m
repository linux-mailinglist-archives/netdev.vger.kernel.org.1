Return-Path: <netdev+bounces-201039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B85AE7E88
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3663AF350
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F529E106;
	Wed, 25 Jun 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak8qLMJ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28229E0EB
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845977; cv=none; b=BjG0vetf5fp8LmfGeXLRf0oadsAy95Q2VCIFmrfqpeZ4PwGxxVLMaSCgFdSVUKKkq56lSz6QhVMW+ZfwF/jGEkAijoK3ffbhYYTy8WB2x+4eVMwNOe5GE3//+J1/lSPBt1Lt1MSCmJpIoJVDdcS8DH5GYM8MRqwDP9CaDjoUswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845977; c=relaxed/simple;
	bh=uExCJTNIcp6HXLuCH7W20LBDwalW50GYGnV6tULmG0w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Bx/hQSKH8ONcFhlECf5tC/jrAR/owFJ0xG+WGb988RMBfgPA7ZkbL4OnGgKQlWN5cEaAT7GmOMGAFEvmmngQ21/EKW5sI9kaTv/ncG76Kat1/12W3RvqmBML5XqWb2ZtOi6cRlXrHXg3eYrTG28tbWx9BHl1J4Gh+3GXRoxkwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak8qLMJ9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a365a6804eso890045f8f.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845972; x=1751450772; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uExCJTNIcp6HXLuCH7W20LBDwalW50GYGnV6tULmG0w=;
        b=ak8qLMJ90SQi/vcN1AtQ3JlogjCfLbXlM0hsydai9Jo/tXEcinHNcDQ4qAZBVRKHVe
         0q5dE9TMOYqP1hVRjYYSaqyR+Ch5jadC7piA9XOOxQsQ66g4f1mkY3nkgACq6/tNzPl6
         G4nEvkLxJF7B3bvhPtmkiwgBjWPbUGU0m6KWe+gfzQyCM9RyAvbbOz/lcgGj3cNZobP/
         ohEBAcXhWtIs5klGhEtm0NTs02x0BJ+t/qy2/C+r90bCoNxc6gVWbWJ2NnyKmCZyoc+T
         KFpweMon6ji/2NJjNJsDNIxjtMft/uaiYXbem+yamsnT6CR9HB/kpRLHk1uGZNYxesjV
         oulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845972; x=1751450772;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uExCJTNIcp6HXLuCH7W20LBDwalW50GYGnV6tULmG0w=;
        b=ZR84ll/nnnsOUS5e39wt+TXx+MCwXCY0+SmkHLKxHMOJ7KrTv0LCW03qSuCubPGPqe
         /wWMC0ADGvAIeI1GaZ1W6LCoSrv5yZO+Ngcx7cJQDrA++NhaXLuzczc2fn8nwgL3x7Sy
         EkdmTTkuPR5F42mXWlsh1+zAruwyin4/Y2q9WdodghgXpmNqcqQGYkv4+UffcUyHH4+O
         5MfrruNR5lthr1799vf8PE5kKkWd7qUfa/oecOE15OP9yOzNwS3FDN2hQtCt56KgaTtB
         iBRSYc+c5mB1CKajGX5A55MHs2Ay06sJDuwROgBw8aPJd2lH1NPMUOSv9eWw8v6WQZxm
         Z4wg==
X-Forwarded-Encrypted: i=1; AJvYcCUtnJ5IWwGDNme+BYXTIXdZOo6yS2zm457Iciu/rG2ydqMEeAiFHf02F+voIcySSfn3R2T09WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4mzVt5rX88n3ZitSg8mvl2Vj9dSeUjbr05T1aSnYj/ab/TJv
	OBgH8mm3q4bvXQeXunWlYz89weEWjndg2ME34UGuMk+GbE4JpJkZxWja
X-Gm-Gg: ASbGncvoR/cjgvY6jH9vFaqQrkSAMrI+/r0FIG8yfDJQPjOf33ccqi/du81hJaIu8cp
	T1Vw3i/nv+YxQ8xuXErmC7bhAPv+tsHyOiXin7y9w6P+mPsYUDDlYoj/Z+fLv+eprwFrxXcwNfC
	vjQxEEDGUe0eMV4O71kWd21bvoaJPkXXs21nCmajep8LcYjXG4GbI1SXaOqVsu0qW4key6ULnz2
	KlxF7OO9nrmmPUdRrzlXvwHxwKManc76IpqY1H1a0TZKXQYc6inH3Ly9Wl8NK0v3I0Ls4Yh3J5x
	yYj/OTBASkO2/Gh6Ut35/27OVTMbM00R/PJxPZwa6N3GvOA1khL51D6pPNkHugI+EOq/RHNzxbA
	=
X-Google-Smtp-Source: AGHT+IGTcyFFMnwbXOzEIUUpdwqZMgj52hkNaQTUI6XmsquNt/YtctWhEomU2mvZeEWHOC0sm/jvAw==
X-Received: by 2002:a05:6000:1885:b0:3a5:2cf3:d6af with SMTP id ffacd0b85a97d-3a6ed66e26fmr1614820f8f.45.1750845972383;
        Wed, 25 Jun 2025 03:06:12 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811049bsm4155660f8f.88.2025.06.25.03.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  i.maximets@ovn.org,  amorenoz@redhat.com,  echaudro@redhat.com,
  michal.kubiak@intel.com
Subject: Re: [PATCH net 06/10] netlink: specs: ovs_flow: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-7-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:52:42 +0100
Message-ID: <m234bocfmd.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-7-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

