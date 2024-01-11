Return-Path: <netdev+bounces-63137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08882B545
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C8A281D85
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561555E47;
	Thu, 11 Jan 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JyYSRSFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4AE524AB
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso45598455ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705001997; x=1705606797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZwzk4K3qgenrCoxWq4VzEjX4W2+qtiYXRON74lI9aw=;
        b=JyYSRSFnubXQnbnjbRc1RCZ3TR+hjcfjqRrz2XEqwczxPDsAClbfWDpKrue09DO5Kx
         yZ4jK2KuiOWeflU77UEUbAFL6gCbTkWf3JZBRxxT2A3Ul7ePjLYrD67qJsHahnZw6chE
         d5+E8gfjMdssskCucfWDuap3z8yHJ5g1iADJlzbT7vFyZ4qoOI2FxRkLwFZ6gfIi8a8C
         9P6UmxlbPXECccMd6bA+77oLMVgl0Sc/1EQh5olJWqGLiMl87adG1r4rHx36PKIBdq7p
         BRsC2vUIeXcI2hCTGE87M5e/RrAfEj4pppTXq3Rmy/BfzuKqVM2NTGWlPL1E+DaoLCdh
         sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001997; x=1705606797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZwzk4K3qgenrCoxWq4VzEjX4W2+qtiYXRON74lI9aw=;
        b=bh4fGmPt0CrCBAyayXFifQQigg/soNCs6U9CEtkjpq5dOAvR/MuAW/sE9r4LR/w9LO
         1g7303paQL6k+aOJ3RqJ7HJEw329LZKkcFc1bDmAPmLmafFlFuBdckUWK+TAkMOIZw5I
         41EsOA93eW0VXwcM+whXQ59j6mj8L/33eGbJE1ky9c2BuBpCzKGS1fBtfFxNJjD0T/a5
         LWW/xyf8A213WkxRkpY6yHudcLZ2ipcArdYbta93v2RexjPymZfpNYFjxzPqfxweb9ky
         5qc3W+hi6iEhnthB4ZC7sjXZtqKO33sXrY8ZPmi3UrnGjs1sRB/Otd66+Pr185Yqe4dp
         Wkhg==
X-Gm-Message-State: AOJu0YywepcfJ9YybCGFhqG4LFqnNRHq+HmnZ94yFH740qJptRDTGzNG
	MAzbNtn+Liu6NU2XgoiUqFk1ddEjZeIyzw==
X-Google-Smtp-Source: AGHT+IH8DmuLKnC6gfZLJzVt7VKqvIxy5/xv7W2oixFmD4vGJ/Y3aFqUywLVV1+fljoVoh7nQ/wzUw==
X-Received: by 2002:a17:902:ec86:b0:1d5:a1c3:3702 with SMTP id x6-20020a170902ec8600b001d5a1c33702mr241437plg.49.1705001997117;
        Thu, 11 Jan 2024 11:39:57 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001d52198a83esm1509772plg.153.2024.01.11.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:39:56 -0800 (PST)
Date: Thu, 11 Jan 2024 11:39:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 1/2] docs, man: fix some typos
Message-ID: <20240111113955.1824844d@hermes.local>
In-Reply-To: <cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
References: <cover.1704816744.git.aclaudi@redhat.com>
	<cda844f5f7fe512ca9b7f87a6545157394b9d9ae.1704816744.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jan 2024 17:32:34 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> diff --git a/doc/actions/actions-general b/doc/actions/actions-general
> index a0074a58..41c74d38 100644
> --- a/doc/actions/actions-general
> +++ b/doc/actions/actions-general
> @@ -116,7 +116,7 @@ The script below does the following:
>  - If it does exceed its rate, its "color" changes to a mark of 2 and it is
>  then passed through a second meter.
>  
> --The second meter is shared across all flows on that device [i am surpised
> +-The second meter is shared across all flows on that device [i am surprised
>  that this seems to be not a well know feature of the policer; Bert was telling
>  me that someone was writing a qdisc just to do sharing across multiple devices;
>  it must be the summer heat again; weve had someone doing that every year around

Don't bother fixing this file, it will be dropped in next release.

