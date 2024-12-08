Return-Path: <netdev+bounces-149958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E079E832C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5087E1622A7
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE671CF9B;
	Sun,  8 Dec 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuQf7pCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FA1B960
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625835; cv=none; b=KidR4+x8lOCcXED8HRdYfwlVQtx8Qcm8YfEc8enjOwYF1WP5GbenjEFtNk6Li8Y3dppEPSB2vM4UCfDbnIgxHwqk060vyXGCdWRzWCZpstEdqq2z/JPL/Amgq3zdnhqx0jGe57x3Xs2pte7jc8dZjAcYAH6O0SX1nJmp92/4X48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625835; c=relaxed/simple;
	bh=HSCzG3w85/vDQDIPfd9TLNOBKR4D6vnGpttqchgottg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJ64geYSBI2PdNuAjSf45yHXxQi6LzzQI9JuM+bv34GOQnzsGaulIfr8dhdAart/2REYO0+dJftv6mh4cxPR8w1i32qaiWxhE4Kd3ItcNaEnBi+GSHWifjiUSQDp530cPx/+zLu9Y05C7eBAY1Qb5PuqTRAcKdbovj3DzpbQbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuQf7pCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FCC4CECD;
	Sun,  8 Dec 2024 02:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733625833;
	bh=HSCzG3w85/vDQDIPfd9TLNOBKR4D6vnGpttqchgottg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EuQf7pCFz2UmzlQ7DlthVMGIteaHu82Ug9n5ARYXW9GGZV7hf6bCXF751vy2MLe9C
	 WHAmnK3yDYSHkxzt8S68xVkbodlGsZR9xmi5AyMHeLv/qC+/oGMxnZzjGlsvy1DtNp
	 sXIrd/sBS3pEhSV+lIUZtfW6kf2dRiaSvsDoHxnyS16NmVCLiKX7MVf0GiAKhlKIJZ
	 RAaqUAaeF4028itxakOCzRFt47pfVZZyc4G3wUw2HOlxpvd7kj+FU0eNLY0iRtbaOu
	 30CK+mf/uASjYWq3/39QXSo+/URReUM+/9HS9udGn9g8DKTZh0xHRh1y4CjPhElBXk
	 HCY6J8GJkY0kQ==
Date: Sat, 7 Dec 2024 18:43:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next] net_sched: sch_fq: add three drop_reason
Message-ID: <20241207184352.512e5971@kernel.org>
In-Reply-To: <20241204171950.89829-1-edumazet@google.com>
References: <20241204171950.89829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 17:19:50 +0000 Eric Dumazet wrote:
> Add three new drop_reason, more precise than generic QDISC_DROP:

FTR I applied this a while back, thanks!
-- 
pw-bot: accept

