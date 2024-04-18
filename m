Return-Path: <netdev+bounces-89261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75CE8A9DF0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F19285E50
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787DA16ABC3;
	Thu, 18 Apr 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4e7Y3xy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C816ABC5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452689; cv=none; b=k14U6KPpV0hhhCMezzTssbAg3ASehlwDe8XTE52GOjJNfxv7QZlbakHq06foEkAOpkQlgRgDZPx7aVTylbbTf844VMuXKiPo/HGe8AIs59C7fvnLogNSGLS7lk81kIy/IZeCYrKLRLpoqSFY+bAQs9BAQaf0r2mis3WGLXIlWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452689; c=relaxed/simple;
	bh=cWNVDZPjCs0qd9dW06PNgxM5LIGV1RocW7cocZWbKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SujtH2CE8O3zOzUocRcOIuB6vyvXLINGnQxOsZLBLJXWq7wZywrBWLREKrxgVzBTsDbGbifUOC4RwQ3I0IPVACbQwfEc9lP28pYyyYeUZP6K37GQfa0lT6SK2dFyeeQJGcT47JzoxhB7yxUzjzJf9XjEBzD9vSfSpvOqwZFW0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4e7Y3xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB98C113CC;
	Thu, 18 Apr 2024 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452688;
	bh=cWNVDZPjCs0qd9dW06PNgxM5LIGV1RocW7cocZWbKwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4e7Y3xy+h6Givh7aeaaAHUAgTQfVswLFWVSgQa10mvTDUmURyseTh4MFBl4wCwSB
	 muQ1JiQWhkaQcNjOc3nQwbDOfstAIKtO/AlYRz8d2VWcyeWbkNvQAab0v9ELc8jIN/
	 kEn8ZEuTnYisgSmDc0kHuIHkjxOFXEsSAL4FeOp5TL/8YjVRFdmojJAyBaHIte3MlM
	 Gck1pjaERdbXQIXyqme2rs5YGLGritJG8QBgikb8rOAEWV6J8oLPkFsSPyDokzDrpR
	 QgeZKt3vN2jcPGQiEz5s4nYjccHwF0bnCtKBg+Zi788wsaTUv85EWya5uuwaXT/14E
	 g4rXtkH0e5gFQ==
Date: Thu, 18 Apr 2024 16:04:44 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 11/14] net_sched: sch_hfsc: implement
 lockless accesses to q->defcls
Message-ID: <20240418150444.GF3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-12-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073248.2952954-12-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:45AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, hfsc_dump_qdisc() can use READ_ONCE()
> annotation, paired with WRITE_ONCE() one in hfsc_change_qdisc().
> 
> Use READ_ONCE(q->defcls) in hfsc_classify() to
> no longer acquire qdisc lock from hfsc_change_qdisc().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


