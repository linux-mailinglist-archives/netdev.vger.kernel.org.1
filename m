Return-Path: <netdev+bounces-285490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LiVMsH8/GmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E44EF089
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C9AA3019142
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613463033C6;
	Thu,  7 May 2026 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="R/Hf/hdj"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA852F8EAC
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187455; cv=none; b=Z1lcqBl5QGwsNJBG1KzmHZYKylSRkA4S1m8bBE2/IuziKPzp6/SmdLsqsmz0gpcXgPiycgZkSttQuqKjhSitcALFFCTpsbUWGndrNKJdXK4kdFWFkCGbdoDYrmD9U8nSoNWCbipIwcCpKXlLiX7VOEbXCIeptjXY7qCEAzYDEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187455; c=relaxed/simple;
	bh=t80X5BPUGmVpO62XoQ1ic3S9abIWlczIk/GA+oTjLyQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=joggVLrJR3AP04uED1AecTdv8J+TFoXMB280n2sf8yv4yHI2O/yzkJcmoKBa9bUm0oA+K4hPak4qeYM+/qb839mSd0HliZfSL0lhbKzIehHcvLm3Zow/GpwWPZMbWRijs4mbVLNiJIesNYvQyTXNRQv3B4tjWmhs84m2IMzfxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=R/Hf/hdj; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3195520DD3;
	Thu, 07 May 2026 20:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778187445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDJLEQFq4xW1obvMFv3XH4Ldn5o/0Tg+hnOb+zRZDEk=;
	b=R/Hf/hdjw0y+UELP8T3Fg+VxzucNzyg/X17+ck5ZLPs28DbgX+un6i6Fb+cB3JHbmWcMHX
	NjHOlyGmJqHkK4yUKl7eYAiuWTmRpdYxqIWGf4RKyA9bk4OszQxldYxcPbOuiTfFG74AMn
	w+RdTl48V6iLnm49OZg/Z8kx+wZ9TI0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH batadv 1/1] batman-adv: fix tp_meter counter underflow
 during shutdown
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, yuantan098@gmail.com, yifanwucs@gmail.com, 
 tomapufckgml@gmail.com, bird@lzu.edu.cn, rakukuip@gmail.com
In-Reply-To: <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
References: <cover.1778118303.git.rakukuip@gmail.com>
 <df73e607bda0c84b22d64d80f8ac887190242baf.1778118303.git.rakukuip@gmail.com>
Date: Thu, 07 May 2026 22:56:49 +0200
Message-Id: <177818740941.228652.6887332849423368018.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=sven@narfation.org;
 h=from:subject:message-id; bh=t80X5BPUGmVpO62XoQ1ic3S9abIWlczIk/GA+oTjLyQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJl//szpFZu+Mcjk0/yLfLVGy/f7PXjbcnxKdceuMOdb2
 uz6tvUPO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATUdvG8E9hmtmmuCdxrqX/
 55jI1a25acnWeqxAid9sqX/JjY8HLzAx/C93OfhK0e7je/bs4Ffbf3y0PjJnb4S1dOpBi/32i7r
 PvuMBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: 440E44EF089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285490-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[narfation.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,gmail.com,lzu.edu.cn];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 07 May 2026 23:49:46 +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 2e42f6b348c8..4c582443f67c 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -435,7 +435,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
>  static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
>  				      enum batadv_tp_meter_reason reason)
>  {
> -	if (!atomic_dec_and_test(&tp_vars->sending))
> +	if (atomic_xchg(&tp_vars->sending, 0) != 1)
>  		return;
>  
>  	tp_vars->reason = reason;

What about:


	/* ensure nobody else tries to stop the thread now */
	if (atomic_dec_and_test(&tp_vars->sending))
		tp_vars->reason = err;
	break;


in batadv_tp_send()? If shutdown is called and then batadv_tp_send reaches
this part, isn't this also ending up at -1?

Regarding the netdev mail situation: Please don't send it to
netdev@vger.kernel.org directly - they want us to first handle it internally
before forwarding it later to netdev. This should reduce the patch volume for
them. There is already a change to the MAINTAINERS file to remove the
batman-adv paths from the NETWORKING section (netdev@....) queued up
- but it was not yet forwarded to net-next (and I am just wondering whether I
should ask Simon to directly submit it to net).

Regards,
	Sven

-- 
Sven Eckelmann <sven@narfation.org>

