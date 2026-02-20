Return-Path: <netdev+bounces-259746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC9ZKl2YmGlaJwMAu9opvQ
	(envelope-from <netdev+bounces-259746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:22:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0118169ADB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF8133008CBA
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83A318BB6;
	Fri, 20 Feb 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="roAVVOeJ"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07A1DFD8B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608150; cv=none; b=cspPas0n9nyqXk2qVgjB39CuWOPvVDj7yv8EapFOt5Y3BUBv8BdWhZjMWE0Ewx4D341gxKpgowliiNE7CAFB/38nGC6tkY/IXCG6cAail7YEca5F6puGAmRV9Oo6jaERaJc0iG3k6dowAKpYaC/mMexj7PohIXrpAOpza9bjYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608150; c=relaxed/simple;
	bh=KKwanZ237qGXGgpXRzgGnu2FATHU9y1broq022IIjgA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KcM4p8MfWBfxzVXomJijLz9tDj6OGUKGxXCuYvOqmz2wd+SR0kyfLzr5ceAe0Gyq3nctdsIvLXob8N7+A3/dd2fiQtSOzuiHIAWrjhdr+DkMkm3MWGfLgsyvPabz46guv5pp7VY4fuFer3PKLaEhe2yLF3NVybMadUD1pgIjZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=roAVVOeJ; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 681C22CF54C
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:22:23 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 214CEC40072
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:22:16 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4096E13C2B0
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:22:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4096E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771608134;
	bh=KKwanZ237qGXGgpXRzgGnu2FATHU9y1broq022IIjgA=;
	h=Date:To:From:Subject:From;
	b=roAVVOeJLb0aoIZvj3tKdOUVanFgBW7G7wwzdzYTQA0R8sUZgAA5N0nHmRHZCtHxI
	 C3g4324iY4sI7oJ30cVNA94hOWuhTxqy1/wQVUR8SVhSIt3OwGATfoVp1LngzcFx4G
	 cb9o+QURIMZM8vSwVc9QLKHQ4GSfQupOMEyuaqew=
Message-ID: <0c9951cd-f9d7-d7e9-f3ec-c9d26b274322@candelatech.com>
Date: Fri, 20 Feb 2026 09:22:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Suggestions for debugging skb use-after-free in tcp stack?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1771608136-SHBuzsfvHGE9
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1771608136;SHBuzsfvHGE9;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TAGGED_FROM(0.00)[bounces-259746-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: C0118169ADB
X-Rspamd-Action: no action

Hello,

I'm still trying to track down a use-after-free in the tcp stack.
It is difficult to reproduce, and I've only seen it when using the intel iwlwifi
driver, and only reliably reproducing now against one certain AP.

 From debugging efforts, it appears that a freed skb is accessed when tcp is walking
the rbtree retransmit skb collection.

After taking a closer look at skbuff.h, I notice that rbnode is in a union so
that it would be easy to corrupt that if skb was also placed into some other list.

I did not see any existing option to reliably catch a case where skb was inserted
into rbtree twice, or if it was inserted into rbtree while also being in a list.

Any suggestions for debugging this problem?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


