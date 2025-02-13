Return-Path: <netdev+bounces-166014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F328EA33ED9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2213166F1F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB94221542;
	Thu, 13 Feb 2025 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hzluo0Is"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D2227EBE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448658; cv=none; b=Vcsqdkm6ZohWBPKmrcmtWykfnG2xNhjLxuqCYnNWlHR72BCEovLdlV0U9ciK0pVaz0D5G0zS/af84wA/YbmYyUlpmiyAKYh1d55scwIdc6ybjuVFy3K3EQrwh356v3OaQhqDBkVIJb8We8Q9Lx2uj9LmsE8IjETIDd7UgNtMIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448658; c=relaxed/simple;
	bh=k8wkB+UqOieImX6V8LRzycA4MP0DN36r0HLB25ctJSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3BMS5pvze0CTZg70TM19UtjH7w3dOjxr5AHNp+10jFS0nGgkm1M048Z5Ky718pTG1S+uKALI++pHKMEeyFN6vqAbFfZMpWnFPs/t2naNSfZ40viRQMk7tg7hPxv7pUZqmW7hXyW7SThgoqrJu7EC3DVpitjwG+AjrJNxYcLid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hzluo0Is; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739448654; x=1770984654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMg+jYL8Com5N7wlNsq67Ag19pv0l8keBlb6QZUGMF0=;
  b=Hzluo0IsgdKvtt7zuiOVFSPEF7DwhVNAfEEYh1w0g5kFlz19eqDFJ2tC
   sb/wGzEuTrYybUSO0fdUg/jUOQP1iQD5MNkihYGxkz6Alyfikk3HvclKv
   q510rJXu6WEvctZ/9mD92rPRZRgw798nYaYZRFxEiLCzaNL8BNcl6JqMs
   w=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="798481095"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 12:10:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:48048]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525] with esmtp (Farcaster)
 id 18a59c25-0b3b-43cf-8580-b6809e5df008; Thu, 13 Feb 2025 12:10:45 +0000 (UTC)
X-Farcaster-Flow-ID: 18a59c25-0b3b-43cf-8580-b6809e5df008
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 12:10:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 12:10:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <apw@canonical.com>, <davem@davemloft.net>, <dwaipayanray1@gmail.com>,
	<edumazet@google.com>, <horms@kernel.org>, <joe@perches.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<lukas.bulwahn@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next] checkpatch: Discourage a new use of rtnl_lock() variants.
Date: Thu, 13 Feb 2025 21:10:28 +0900
Message-ID: <20250213121028.48711-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <410f016d-2ea6-45ae-895c-96fc34fdd1a3@redhat.com>
References: <410f016d-2ea6-45ae-895c-96fc34fdd1a3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 13 Feb 2025 12:03:51 +0100
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7b28ad331742..09d5420436cc 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6995,6 +6995,12 @@ sub process {
> >  #			}
> >  #		}
> >  
> > +# A new use of rtnl_lock() is discouraged as it's being converted to rtnl_net_lock(net).
> > +		if ($line =~ /^\+.*\brtnl_(try)?lock(_interruptible|_killable)?\(\)/) {
> 
> I think you need to add '\s*' just before  '\(' to avoid the test being
> fooled by some bad formatting.

Will add that.  BTW, it's also caught by another warning.

  WARNING: space prohibited between function name and open parenthesis '('
  #18: FILE: net/core/rtnetlink.c:79:
  +	rtnl_lock ();


> Also I'm unsure if the '^\+.*' header is strictly required - it should
> but some/most existing tests don't use it, do you know why?

I didn't notice but exactly, the following matches only + line.

  if ($line =~ /\brtnl_(try)?lock(_interruptible|_killable)?\s*\(\)/) {

Looks like the '-' diff is filtered, matching '-' doesn't make sense.

This function looks suspicious ? (maybe wrong, I'm not familiar with perl)

---8<---
sub raw_line {
        my ($linenr, $cnt) = @_;

        my $offset = $linenr - 1;
        $cnt++;

        my $line;
        while ($cnt) {
                $line = $rawlines[$offset++];
                next if (defined($line) && $line =~ /^-/);
                $cnt--;
        }

        return $line;
}
---8<---

Thanks!

