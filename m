Return-Path: <netdev+bounces-291645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OecMwx3FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D38725D4391
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57A130985C5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2403DD52E;
	Tue, 26 May 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uUSnBmdV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8593D891B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791185; cv=none; b=d61721D7I3DFxPAda7XVW9oVrlyUEi+W8HVUXrMZDzuWmvd0eoErYDaoueF+UJ4ktRPsZkFoTHoqPNcaZhIBUDfNj7WYjT3FoD88P9Ci9zYWf7amUy6YSr67gmIL3FB0XYvUHuGyz3OYjrQ/TQ2niUENFhy8I6/Oq93b78dhBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791185; c=relaxed/simple;
	bh=t7xAFcJcddCqBkMtbx99nB+3gb9bAOWTdZMQyotFhYY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCSuLlIBG9yaG6q5GOT106BeFEj2+s5J2PhYRusZDnutKsnT6PTnZgFfDv/xFWhAETcPBnGP5pV1kLzR+Z3Nf8bG2sc02rW9iOKg7qpd6wWWgBzYi95XZxhOafi32/KI1nKmZ0m5OiDPvwRPw91UAoTTimu+9XC4/aiYoNXb8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uUSnBmdV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E2FDA20185;
	Tue, 26 May 2026 12:26:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfXsX9NTBRdF; Tue, 26 May 2026 12:26:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E6405205DD;
	Tue, 26 May 2026 12:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E6405205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779791179;
	bh=CJesOZBlLhbJMyqWSry7232znwrcg76vehuiWe92sek=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=uUSnBmdVUqaxzTLHHQg2O2Ol5jjJbr7LgnoMMWah/szr/9E+xZBv3qehMW2bZTEHr
	 kB1xvBmjWw56DzokpCda9ydzt9TQFQfpG5QwqT6OC0nxxyl72Vo1lSG5jl3efkod86
	 Mihwv8CGXYSVVvfnkSaZ8VslndyKg+Y4mQx90muyuHrptIMV3gAU8xHXOGKVg8QYPi
	 t65I07pyKVa/LRea4pxkur+HAf98k+vgyYLBCm+5JrR+NOcUqSY6895UQHCU46Axu5
	 /szrjAm5dk1SDxFV9B9Ao2+EOnH9pDzEPgH7tyQd8jpEYFVAeFPf7j0A5vrI4p3N/i
	 Eco73M9gYEdrQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 12:26:18 +0200
Received: (nullmailer pid 225246 invoked by uid 1000);
	Tue, 26 May 2026 10:26:18 -0000
Date: Tue, 26 May 2026 12:26:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <sd@queasysnail.net>, <yuantan098@gmail.com>,
	<bird@lzu.edu.cn>, <tr0jan@lzu.edu.cn>, <zcliangcn@gmail.com>
Subject: Re: [PATCH net 1/1] xfrm: input: hold netns during deferred
 transport reinjection
Message-ID: <ahV1SnF_EnN_c2qe@secunet.com>
References: <cover.1779308659.git.zcliangcn@gmail.com>
 <a7cc27e87359c7624522fa5bb8c6a2d9af928824.1779308659.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a7cc27e87359c7624522fa5bb8c6a2d9af928824.1779308659.git.zcliangcn@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,davemloft.net,queasysnail.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-291645-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:mid,secunet.com:dkim,lzu.edu.cn:email];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D38725D4391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:31:55PM +0800, Ren Wei wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> Transport-mode reinjection stores a struct net pointer in skb->cb and
> uses it later from xfrm_trans_reinject(). That pointer must stay valid
> until the deferred callback runs.
> 
> Take a netns reference when queueing deferred reinjection work and drop
> it after the callback completes. Use maybe_get_net() so the queueing
> path does not revive a namespace that is already being torn down.
> 
> This keeps the existing workqueue design and fixes the netns lifetime
> handling in one place for all users of xfrm_trans_queue_net().
> 
> Fixes: 7b3801927e52 ("xfrm: introduce xfrm_trans_queue_net")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4

Applied, thanks a lot!

