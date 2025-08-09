Return-Path: <netdev+bounces-212336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7A7B1F622
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9528C189D5DB
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670F277CA8;
	Sat,  9 Aug 2025 20:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.nospprt.eu (gw.nospprt.eu [37.120.174.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E727510E
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.174.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754770422; cv=none; b=haoT20C+dPvHCLEF9sc5rr2iZfVjSwrnMk7VNj7CfOlj6bqRu1pqOh6OUuX4yqAsD1XNmrFEpfo8NXbUtKAi2UO94mU9mnwcwhSqKSjnluBj6gHX0CTP+avBiguUOKFoK6kTp8OYFtKOdAhoXVUKHLU2uON6ppEbQa1OZZ29hUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754770422; c=relaxed/simple;
	bh=SOgEzzV7lkRyZTEgHL8rG+fKMK85sfV8e/cbzPH2mB8=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=PobMRGhozlUEtOZYUFG8K7SDNpdBqoMLK3Y+fqRfDSX/8Usutjup+LHqkc62HPA6hCCoT9HEfHjOW5AmkczpcDTzrY527nwi+iRqmcOXzvyb4qkTCZSt6MB19oK4iW3brr+pzTzfC/7muVtqCjsIq9mR+bFqskBtH4hB/CBiNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sh.werbittewas.de; spf=pass smtp.mailfrom=sh.werbittewas.de; arc=none smtp.client-ip=37.120.174.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sh.werbittewas.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sh.werbittewas.de
Received: from imap.nospprt.eu by smtp.nospprt.eu  with ESMTP id 579K3Ast030427 for <netdev@vger.kernel.org>; Sat, 9 Aug 2025 22:03:14 +0200
Received:	by imap.nospprt.eu with ESMTPSA
	id iO5RO4Gpl2iZcwAAsBFz6g
	(envelope-from <lkml-xx-15438@sh.werbittewas.de>)
	for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 22:03:11 +0200
To: netdev@vger.kernel.org
From: lkml-xx-15438@sh.werbittewas.de
Subject: problems with hfsc since 5.10.238-patches in sched_hfsc.c
Message-ID: <ab86a457-aab0-1ea3-3161-2630491585d7@moenia.de>
Date: Sat, 9 Aug 2025 22:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de
Content-Transfer-Encoding: 7bit

hi.

hopefully the right list for this problem, else please tell me the right
one.

Problem:
after updating to 5.10.238 (manually compiled) hfsc is malfunctioning here.
after a long time with noch changes and no problems, most packages are
dropped without notice.

after some tries we've identified the patches

- https://lore.kernel.org/all/20250425220710.3964791-3-victor@mojatatu.com/

and

-
https://lore.kernel.org/all/20250522181448.1439717-2-pctammela@mojatatu.com/

which seems to lead to misbehaviour.


by changing the line in hfsc_enqueue()

"if (first && !cl_in_el_or_vttree(cl)) {"

back to

"if (first) {"

all went well again.


if it matters: we're using a simple net-ns-container for
forwarding/scheduling the local dsl-line


maybe we're using a config of hfsc, which is not ok (but we're doing
this over several years)

our hfsc-init is like:


/sbin/tc qdisc add dev eth0 root handle 1: hfsc default 14

/sbin/tc class add dev eth0 parent 1: classid 1:10 hfsc ls m2 36000kbit
ul m2 36000kbit

/sbin/tc class add dev eth0 parent 1:10 classid 1:14 hfsc ls m1
36000kbit d 10000ms m2 30000kbit ul m1 30000kbit d 10000ms m2 25000kbit

(normally there are further lines, but above calls are sufficant to
either forward the packets before .238 or let them drop with .238 or
later. we're using an old tc (iproute2-5.11.0) on this system.


so, it would be nice, if someone can tell us, why the above
hfsc-init-calls are bad, or if they're ok and the changes in 5.10.238
have side-effects, which lead to this behaviour.


thanks a lot.

regards

x.

