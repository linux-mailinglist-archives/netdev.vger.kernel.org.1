Return-Path: <netdev+bounces-293977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG+6N7xEHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:49:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59521627644
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93EF3061094
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459834CFBA;
	Tue,  2 Jun 2026 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ5YceGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153533A9CB
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368274; cv=none; b=osYF6fIwT4NvrGZY3q+9LB6msx3eiC0vAoqd/MhfgfTnRhaTi/3R4rzuf9yFBbfY5JH+J2GcxP4fQtb6RCw3ntuDPla2k+Q15N1m6RD4uYavi7HYJi17wGvzXr7yfrlW9vqZjXXUgYiD/tkd4QQzcoKwtxmuXhonc2bqPXShd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368274; c=relaxed/simple;
	bh=TZkQNwWN6VYnWo0YvI6uSSAyoPzLFY6/JUHxsX7qNvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV+py2geekXY32d85qNuZc05UfTQ9kHPmVehfxX+fYWaWqlt4nfhlGCwHDTueKGNHn+n09+kGnLPstkIm2lgswLcfCIN9p98P5uGZbPZhEAqGsUDXGABX//2CPWtOxM+trYcb/gSUuCSbpOu5i1mG6PqeTYC85QTncY3SzP0GR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ5YceGm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F41F00893;
	Tue,  2 Jun 2026 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368273;
	bh=dFFuChmYplNNx9X0hbVn7PVO2TG6qfnVQolx9Gg5QtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQ5YceGmGS3o0HIb09yg4KCJODCDddpYeZWnIT79SkcabJ2Hq7KGyj04BZv88XpQB
	 fGHAznJwdZ64llPDMwQbEwIEcoQFJNlhAbfXSYWbjk2KlUfVT1QL6kYfOLIPrMWTiy
	 hU594ClCsUS/GDUnYHki3ekbJ/s9Td7U+HHHLE/XKBGunZv4suIpCqOM4nwtcyget5
	 CHt/EoaAUgQZIUUSikkIdPI0ELtxrHQ4x2ScvmKSbDMOxi47ueEsOmegRtaNjaksvK
	 00nK20rboIgRN/zV1ayACiI95gs5l91bCgiD7YkBEMsuYQbq5QRS7RRHIwtVNyJd+6
	 GjI/A128246+w==
From: Jakub Kicinski <kuba@kernel.org>
To: oscmaes92@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew@lunn.ch
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during napi_complete_done
Date: Mon,  1 Jun 2026 19:44:28 -0700
Message-ID: <20260602024428.1664921-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528140320.5556-1-oscmaes92@gmail.com>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293977-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 59521627644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pcnet32: stop holding device spin lock during napi_complete_done

This commit removes the lp->lock spinlock hold around napi_complete_done()
to avoid a potential deadlock with pcnet32_start_xmit() if a GRO flush
were to occur.

> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> index 911808ab13a79..4f3076d4ea34e 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>  		pcnet32_restart(dev, CSR0_START);
>  		netif_wake_queue(dev);
>  	}
> +	spin_unlock_irqrestore(&lp->lock, flags);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		spin_lock_irqsave(&lp->lock, flags);

[Severity: High]
Does dropping the spinlock before napi_complete_done() introduce a race
condition with shared IRQs that breaks NAPI interrupt mitigation?

If napi_complete_done() clears the NAPIF_STATE_SCHED bit, marking the
NAPI poll as complete, a shared IRQ could fire on another CPU.

If pcnet32_interrupt() then acquires lp->lock and checks csr0 without
checking the INTR bit, could it process pending events and successfully
call napi_schedule_prep()?

If pcnet32_interrupt() schedules NAPI and releases the lock, this code
would then resume, re-acquire lp->lock, and unconditionally unmask
device interrupts.

This could leave the system in a state where NAPI is scheduled but
hardware interrupts are enabled, resulting in an interrupt storm on
every subsequent packet.

>  		/* clear interrupt masks */
>  		val = lp->a->read_csr(ioaddr, CSR3);
>  		val &= 0x00ff;
> @@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>  
>  		/* Set interrupt enable. */
>  		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
> +		spin_unlock_irqrestore(&lp->lock, flags);
>  	}
>  
> -	spin_unlock_irqrestore(&lp->lock, flags);
>  	return work_done;
>  }
-- 
pw-bot: cr

