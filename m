Return-Path: <netdev+bounces-151547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF199EFF67
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAF62864FC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BA1DD0FF;
	Thu, 12 Dec 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dk4nXoEm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D819CC0F
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042718; cv=none; b=IxJ/nkf/+mbaL/e+HIkDcIZGa/Vi825qYOCZq4qiZmPZ6qX0+XYwIU5jYSCnAWleAl1aMI7D2mnNiuEthp9jtFDDypQttqfCLqmHwHJ7/qr0R0cEjYHO/OKDthPVJvBd33zv6TqJDbgaol2xfESFcx+y4GUnb1lXIjXwoLm+xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042718; c=relaxed/simple;
	bh=pA+8zqupfBFDmt4qMmv07ENz1H7Uu6iKpzyR6Qsp5w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkIaZh65PS86tbEnNzToMQ1rlRvHe7JyK7XopK7O0vhivC/2ZVryyU11l9SIrMJcC7wL2F910qfFttdhHbXQbvRSX3aWd1eUFsbpEwzGGSvgCWcTRSetyjua7Bd4hkLUQTpCuN+NtOPkFHOmQBn9bDJFxpemTULTUGb82mCgFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dk4nXoEm; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so9570056d6.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1734042715; x=1734647515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSoAXlJ6Zprog6XxVRiaV+HV0cPvdNUNPJcmRmBytG0=;
        b=dk4nXoEmFQA9PkRm2rmpyUzudW9MOJDcIjuaYr+LcJh6Cy2ClvqvwZFGLREHYSd8sS
         nwlM6WEEwPTv3UmLISIpBK+fcViCJfEdBvmf1kcgL6K6hKEQXyGOB8JXF201/fZ27REq
         jzFUz1p/09ilUCko+0bD2ItDpPEpZaXZk2QUxPEHPl7SWbh5zFQrXHiGa06bLo6H1T8V
         9EF4yS08FZwYUjPyGpnobjNMlg4R3ZbHRzA13J7edC5RojmlbaWipo2AuXg8hdWUpVbi
         V8QB3r0NU/yN58LiMhA2jKRrEBa40ViKR4E8fNuCu0nGP3DNvf12gBlYjUdo/NILjDDC
         F+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042715; x=1734647515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSoAXlJ6Zprog6XxVRiaV+HV0cPvdNUNPJcmRmBytG0=;
        b=YDDzzpYtnBLM9urcww9kTvA6yWissucORFnlQJScgcDK01SZ0r47tiNhitBrrUbsbX
         DBUjQAqFuF8BWziYbltLRIgGFhAQNBF1QoC5QjdgEM2UhxEW2UCxvGxmRfKzXckN2SIT
         y1ZswXNqknw8yx5w5DbLufwcX23UHgylo+ruZ3kDzGRFCrBBzY00tIE1gt/sfAOLh+/b
         BjPmT/nQai8bGi/BRBNtGyB1U4HneH3jFGgHG2aAG/o8iJhz2yJh/LR74Cz+Sf7k3b2N
         g9sOk0C4TznWbu7Uk4Fv5GegRfeTgZTS8lev2OkaS2VAxHPVHLB4yjTUatBvMb20YKcK
         9qvA==
X-Forwarded-Encrypted: i=1; AJvYcCWikzKUymkg0rVPKIPUXzuOOJuac1ySZnx0kLDbuK2MOsVJTRJOln6JVNdagtI3dcI+zmjymL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGTyU2pXgH665zcqiSz1xnsRwhqTUCWTdoq1L7PIKK/AIdeeo
	L40pKaiuLpF8cO4oKY7e3CSpGc3SFsKlhBkPs8t5LzXdwA+F8oA7X0BL+tQvC31f97BZVhGeeAS
	Gog15tjMRZYwKoYQbfJRi+ZuIuWS6uoJcRV3nOrn7Ljq+JhTG
X-Gm-Gg: ASbGncupBxOsunPfc1KfUbmSKU+vxZfSlJmiTo+zDhD8Aqz8vLCg/sBQdCCEfiayAn7
	OGl2D/Gb2YrP4Pn3LjluCnHKgsso00uxajuFWrjDzC0JIsWjeulq07+1WlsIHxmCXa/1Gnks/s4
	RUD3WEb2AL2rGrcGQF/mihNxkA1NxFWaMfv8Lca16amBNYgSY7GJK0sQrcb4pnZ8Id73cjfIgF/
	CzcSrWwP+GdNj5lYyxFt3rFZge0RbI6OHiOpkFbqC9KbunRTQCnLlyRHCdNffFxyUYsGxAlM6uA
X-Google-Smtp-Source: AGHT+IH56sOCE6AkMB1NOqGAghBKxtUHjKlgsak4gHXU9LCsz1gAmmoQahmcgKqrKFvFM+c2/vTxN1mhlThe
X-Received: by 2002:a05:6214:c4d:b0:6d4:211c:dff0 with SMTP id 6a1803df08f44-6dc8caad1aemr4676616d6.29.1734042715018;
        Thu, 12 Dec 2024 14:31:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6d8e5f4bd31sm7915456d6.34.2024.12.12.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:31:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 290F03401BC;
	Thu, 12 Dec 2024 15:31:54 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 1BDEDE55E56; Thu, 12 Dec 2024 15:31:54 -0700 (MST)
Date: Thu, 12 Dec 2024 15:31:54 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <Z1tkWqxwF+3JpGcv@dev-ushankar.dev.purestorage.com>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20241212101156.GF2806@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212101156.GF2806@kernel.org>

On Thu, Dec 12, 2024 at 10:11:56AM +0000, Simon Horman wrote:
> Also, as this is a new feature, I wonder if a selftest should be added.
> Perhaps some variant of netcons_basic.sh as has been done here:
> 
> * [PATCH net-next 0/4] netconsole: selftest for userdata overflow
>   https://lore.kernel.org/netdev/20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org/

Sure, I can add a test. That patchset does some refactoring that I'd
like to use though. Can it be merged? It looks like it's ready.


