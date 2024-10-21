Return-Path: <netdev+bounces-137594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C49A716A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D6B22799
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1771EABD1;
	Mon, 21 Oct 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aES25T0K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E11CBEB6;
	Mon, 21 Oct 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533191; cv=none; b=VWcgCy79vJCPNTzxjAEYfSsHJb7MYLZNaeeDvOUQVT0le1BSkSjobN5xZKulIZGWVRG2udr+xoot/JatrAsaisYeW0NdhYMz0otTDFTv2x7EBy2tk/FhumxTYv2RmUTH8sYUmjgqqwnc1J7zkh8QDC9LJijAwOLfm/k7IIpaXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533191; c=relaxed/simple;
	bh=dGEHLL7GlnvTK+ikCYmTEGZS19Drc7emvofWAAegQ58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j415znDxcys17QgjTICs65fN4bLFKpXBg92pRImPCQmvxreoe0JfgwsqEQu1B5H+8kZ76rtAx5S/BQPLrfBm0hIKgdwuZrfxJcroDFL+Svtdz4qppaFRlt/ODTvKHbQPxKeBLqdAcYO3y+YKkCZlB5oxZe/FLlJOQiZCEg968kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aES25T0K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729533190; x=1761069190;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dGEHLL7GlnvTK+ikCYmTEGZS19Drc7emvofWAAegQ58=;
  b=aES25T0KKWjHoPrLfPOhl3wJBo3lhrIFtB2TyiMeSkVVxA+35Z3JmXji
   aMO5fDUlsznSyKNgjCeG6TmvY2TP7YrXE+1/BINkyZzCzeRQfiHYnZHHg
   yh8t9XitxBOUNIzn0ywa7jhJdNZpp/+mXbY7YMVBiOH1xHgm/T1IvU6lO
   HNqCVF7kO5NUoxMNR8RVZbO2Rzs0sMte3w2EeN+Z/NKNNnV8yw5J0MxTz
   9Hgq0p0a9HMQ53npbN9LFsSx0zWShUC0WKSXxJ1K12wIHopN2kPA3GbqL
   lZ/knVf2XbffmbTNfPI16d/WinMPyv37d6MufkGugWzXWm4alt17qmM4W
   A==;
X-CSE-ConnectionGUID: 0G8FeQf6T4uJZ/TX+puWAA==
X-CSE-MsgGUID: xmkzHXzUTc+RrKa1lDLW6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29148691"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29148691"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:53:09 -0700
X-CSE-ConnectionGUID: KIAgIRt5T3yUc8lfnh981g==
X-CSE-MsgGUID: pi6whwP0Rx6oYF+rREC91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80422863"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.26])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:53:08 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sched: etf: Use str_on_off() helper
 function in etf_init()
In-Reply-To: <20241020104758.49964-2-thorsten.blum@linux.dev>
References: <20241020104758.49964-2-thorsten.blum@linux.dev>
Date: Mon, 21 Oct 2024 10:53:07 -0700
Message-ID: <87v7xlfim4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Remove hard-coded strings by using the helper function str_on_off().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

