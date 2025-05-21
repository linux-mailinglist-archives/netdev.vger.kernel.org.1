Return-Path: <netdev+bounces-192355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D90ABF940
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C457AA109
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD91DE3C0;
	Wed, 21 May 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b="IEKx7Zhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E971C84BC
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841360; cv=none; b=kmXGiCUiyaHJgRfQWoa61SYhlUuoZ/nnz2aey62VTf/OJP6RVfhoGtFLErl2GwtqDyfVDwHUI+HN2wPBMc1bu8595ZLnFOf9jscRsyiZ2z7iZa8pJN3MS4KWRAJMci1jHhSSdYsVRMeqcmmT5ByOZPj/1aGtgJOaCbc+Pn2uCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841360; c=relaxed/simple;
	bh=7nWWEv+jnbfPKYgX4evf6Q5zY4gGPSNC6aUTceX8buc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAXRW7j5rJh4Mytu63ZlWAzTrmtE8Aj0EHQ24azDtCuHogyo+Qk0cS524voA9pWjRfcqfIjven++pG7Fgkx+opIiiJpkzeLHIJm2qkpEibBNRwaBt56t2a59IwFaef56HQ+l/NAv/7Lpq3a8+juzPiMwEy4vKmoEZZ8PpdHbafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com; spf=pass smtp.mailfrom=deepl.com; dkim=pass (2048-bit key) header.d=deepl.com header.i=@deepl.com header.b=IEKx7Zhk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deepl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepl.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499614d3d2so8530389e87.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deepl.com; s=google; t=1747841356; x=1748446156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf0W+8r0lAaXCaP5Hb43jL1LAgK7mc2n4CJlLh3FM/E=;
        b=IEKx7Zhkr1OIpWuXJ8AbmblGQ348FQPyw9XwoRsJR8S31RsIi8PR+eGcrDHyTohe8z
         /o5fSPfvpWRFFWd9Xyj+FrQ4HOsnxDRNNg55jDMlcMeMWlvyRszEZODQ13bkp0RqSh2w
         Q0+XtyJjqphVbSa1lOGLvJcKx1ATAixoPzH20XXet19Zh8ykDotBthA1SZQ1U5Awi6aU
         2MPqRFswBLhbWaoU2AFbmsQqY31E+l2oDetjzuAPPG5iKz4heyjkhupthZqD9Vk6VbRy
         EexO2ifc0jB2IIfHolNrT8b6fK1fWdj4QFTU9gq8xytDfVCKRLKh/l65AZszQ6MnyDjb
         HEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841356; x=1748446156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pf0W+8r0lAaXCaP5Hb43jL1LAgK7mc2n4CJlLh3FM/E=;
        b=m8Jcc4/XHfEcTN9J1qaneRkModQ1RZmzu1QEBJA9+0n0DvCKL17MFk6ZCYp2ubkwsW
         tYJ++5izsFUZ6dT1oZW3sFRuJKCaibVXH7to7gyCTV7mA2ANkH8k6keO/2XaSK7VAepE
         4hjlcN9ceU5GuddSHSBWjP1Gyb93ScNvgSwe1XiJ/umUkfHJlechCqHhrCQELld6tx9O
         SOoYsqpFqGWgPrYQZrezx+ki1gXPQ264zsZCcXeoSvscT837s928sDVkO4kIGTFerEvg
         BA2R6hK34vGFZI3DCPMDXl9YDhvzPHd9XPJZ7LWfqLepMxyp+c3aua3DE1c0hS4phXGJ
         KLhg==
X-Gm-Message-State: AOJu0YwDOcwRdw+xeV36cOpEJzg+X27kJh/AiEpajI5Ve1Z8fwoAbeKZ
	1/nmgdvXRaKecXRk19AK8/U1u8t7933AshLi+T4G3rr8zR314qdWoZXtj5I698rrGK6w6xn8bBU
	m+Vx81AAtz2B5ZWu/oTB4KVSKsQIkRhlu/7bFrLr0wQ==
X-Gm-Gg: ASbGncuPiKXpvWXMJuiljlrBxmPtDnim8pnBugT/oyenGOzM/n2fYDVhX1GlsbnOJv3
	tDoB85hw3Ivpq+PgF/dNyqKIHBxpPebT5v+CyC5FaP4qCpQujDwCOZuJ6iI6cUq9Y+dnQQlRgNm
	jUDhunLzVVJIONLd4C6IWSglsHcxfjxBT3DZop+0OGRssAOb7vmoN5gZUJp5AGL/wK6K4=
X-Google-Smtp-Source: AGHT+IHnn7ewNBnAM15v9rbFnDhJkaXKGyTnSr0wlKrmFqRLlom+5yrSMLIi7UtloRNQCHFcupAFuN2wU5j2BLqcc9Q=
X-Received: by 2002:a05:651c:31d9:b0:30b:c6fe:4530 with SMTP id
 38308e7fff4ca-328076e8922mr61910991fa.3.1747841355842; Wed, 21 May 2025
 08:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAHxn9-ctPXJh1jeZc3bYeNod6pdfd6qgYWuXMb9uN_12McPAQ@mail.gmail.com>
 <CADVnQy=RRLaTG4t5BqQ1XJskb+oxWe=M_qY0u9rzmXGS1+b7nQ@mail.gmail.com>
 <CAAHxn98G9kKtVi34mC+NHwasixZd63C8+s5gC5T5o-vKUVVoKQ@mail.gmail.com> <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
In-Reply-To: <CADVnQyn=MXohOf1vskJcm9VTOeP31Y5AqCPu7B=zZuTB8nh8Eg@mail.gmail.com>
From: Simon Campion <simon.campion@deepl.com>
Date: Wed, 21 May 2025 17:29:04 +0200
X-Gm-Features: AX0GCFvm3rOnH3l-v8vSm-dKXipt4IfuMhgsDoQeh5DRy-2lVNOZB0YhvuvR6Mo
Message-ID: <CAAHxn9-A4JbXWOWG=jtUx7CbapqrCbJSyS7PyXumaV62VvafLg@mail.gmail.com>
Subject: Re: [EXT] Re: tcp: socket stuck with zero receive window after SACK
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"

(Sorry---resending with different subject to hopefully get this into
the correct thread.)

Great to hear we have a potential lead to investigate!

We've now seen this problem occur several times on multiple different
nodes. We tried two workarounds, without success:
* As far as we see, the patch Neal mentioned was included in the
6.6.76 release. We rolled back some nodes to an earlier Flatcar image
with kernel 6.6.74, but we saw the issue occur on 6.6.74 as well.
* We disabled SACK on the Ceph client nodes. But the problem occurs in
the absence of SACK as well:
05:59:05.706056 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[P.], seq 306:315, ack 1, win 0, options [nop,nop,TS val 2554169028
ecr 1041911222], length 9
05:59:05.706142 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], ack 315, win 501, options [nop,nop,TS val 1041916342 ecr
2554169028], length 0
05:59:07.846543 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], seq 1:609, ack 315, win 501, options [nop,nop,TS val 1041918483
ecr 2554169028], length 608
05:59:07.846569 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[.], ack 1, win 0, options [nop,nop,TS val 2554171168 ecr 1041918483],
length 0
05:59:10.826079 eth1b Out IP 10.70.3.80.57136 > 10.70.3.46.6920: Flags
[P.], seq 315:324, ack 1, win 0, options [nop,nop,TS val 2554174148
ecr 1041918483], length 9
05:59:10.826205 eth1b In  IP 10.70.3.46.6920 > 10.70.3.80.57136: Flags
[.], ack 324, win 501, options [nop,nop,TS val 1041921462 ecr
2554174148], length 0

Another important piece of information (which I should've included in
my first message!): we set net.ipv4.tcp_shrink_window=1. To test
whether this setting triggers the issue, we disabled it. We will
report back whether this appears to fix it or not.

