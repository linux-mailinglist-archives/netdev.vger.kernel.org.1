Return-Path: <netdev+bounces-129049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD3897D34C
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BDD1F20FB0
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559B6F2F3;
	Fri, 20 Sep 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="q8fToQmr"
X-Original-To: netdev@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D4537FF
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823163; cv=none; b=iNyyNwsmBa+7RmsFvgQoafCh0lDyxy6jNm4lqAHzoQhcXbap1C2qd5U4WRVgxcRFwLVXov6UnuW0EC9qR9gvr9Ld3AmLr0Om+t3A6Bgwlx8eokKQSlLRKNdmgSFaUCQbSIhuXohrjoTxuJDYVQGBIkGOeK8QGyl4VdVHzieWlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823163; c=relaxed/simple;
	bh=y6bAUwUvmTJY0Eu/zng9Byy8BU7m3mFe+wihbXxBvr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rST1eFfPTfTWdhXnllpU5HgJbopTqhITC7HX5/ikVCDMiUjzOl1CV3honS9wAFGruZpX9bEsj3oHk4Ju7q+h+U2l/o35c3e4XLFPoG7RZns802OhL7UVgFlPeSTJgxLecgCo40sklTPmm+ccGCJoSBF/RDLULnRhYELYfHPTA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=q8fToQmr; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2d4c:0:640:de18:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id B382E60E28;
	Fri, 20 Sep 2024 12:05:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id n5LxRq5Ff4Y0-AwFqTlWL;
	Fri, 20 Sep 2024 12:05:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1726823151; bh=UEBcz737VjRfrccZMorQh71TLAZRu2/fDd0rKIxy4bw=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=q8fToQmr00nV73z/71w4B76a89qSQ1Q0L1lFQxK31LSkY2mm9N7VXBeK38q8vhH3v
	 ZZkLHPucJSotC67hOKTE0ODPQR+gBsqHNbj6fW79bK9dgVOoW3RbmOPeqfTpG6hRub
	 UQckQew8B2Eyt2HOuKadMRoAdOJMD/jJT5/zHIFA=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <7a2e969a-4a17-42a7-902b-d8aca4e59297@yandex.ru>
Date: Fri, 20 Sep 2024 12:05:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] net: sched: fix use-after-free in
 taprio_change()
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20240904120842.3426084-1-dmantipov@yandex.ru>
 <87seuenud6.fsf@intel.com>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
In-Reply-To: <87seuenud6.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just a friendly reminder. Note the net-next counterpart of this
series (https://lore.kernel.org/netdev/87wmjqnufp.fsf@intel.com/T/#t)
is already merged (both to net and net-next).

Dmitry

On 9/5/24 3:43 PM, Vinicius Costa Gomes wrote:
> Dmitry Antipov <dmantipov@yandex.ru> writes:
> 
>> In 'taprio_change()', 'admin' pointer may become dangling due to sched
>> switch / removal caused by 'advance_sched()', and critical section
>> protected by 'q->current_entry_lock' is too small to prevent from such
>> a scenario (which causes use-after-free detected by KASAN). Fix this
>> by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
>> 'admin' immediately before an attempt to schedule freeing.
>>
>> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
>> Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>> ---
>> v5: unchanged since v4 but resend due to series change
>> v4: adjust subject to target net tree
>> v3: unchanged since v2
>> v2: unchanged since v1
>> ---
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> 
> Cheers,


