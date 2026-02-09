Return-Path: <netdev+bounces-257996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPWHO0FeimkWJwAAu9opvQ
	(envelope-from <netdev+bounces-257996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:22:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B61150A6
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 23:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281D33019175
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B440314A7A;
	Mon,  9 Feb 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="tYbJ3lt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A859314A74
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675775; cv=none; b=FhEgWbVTtZquNP83FvhfOn8e3ipMLRSrHXPMEVzqsR9AK3LF69HkXjKVFe0OXhrYt2yr+kw9Y0KMC0koJ5hNt0BM1F/snFVZVaBynPfw2CaMDIlW/zBzXwSPxmMdfiJ1eC7wvT694k8r3thPsrvMxms8Qk7wPNsEJgpFYQ1Qbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675775; c=relaxed/simple;
	bh=IBLwnVU/4unr1TAe1Xaw3Fxm7LFVZW00j0znCPrppO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYZ8YGER2ed5OWRKqybRHUe8uB8UOGkELisfzUgC6/iVvn/wSgmTxlylOeWgP3dxlzIj7GWldhZ3Q1qgheWxDZbsbAltf82tdT+YAUR+Pz4m0LRMiqTLNVU5ceV6jpy7prtKotD8FNMNDYGe1QxF+8LBU1+2eXw/76WvDvdBHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=tYbJ3lt7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c626bd75628so77794a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 14:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1770675774; x=1771280574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdb0Rs0Jgi++Yb80WzelPaBX5oyxkLoYNwrTp+10nbE=;
        b=tYbJ3lt79Zvyc4ayQzjw6D3oSbnP6GcBiI0osghyleSavCR9C/gOkX83IQyjd9u3rA
         lYyYJSAuNEbeJYoDDqjr87Zbd2cb7vhl55ZZ+H1FwS9QBtHh4i5y4TocABjgmtlIeZtI
         xmcDpvcBoIOnM4ikce7+3oyYdBE47PzQ6Pdwl2iGusi2bX/c/8tQr7flY90334klmOuZ
         NFT81/O91K2PZ7EDaHTXUBo3pON70oOY/WrQNr64Lvx0LTz3jeJ6M/kTSt6+A48QWSVm
         nFe4WTIR7kx7BWujO9ZH+PDszSpJVWuRM2xYK2EBrlLoQOtzTIHdWjpDaTblumn7V4IM
         1nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675774; x=1771280574;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdb0Rs0Jgi++Yb80WzelPaBX5oyxkLoYNwrTp+10nbE=;
        b=NrBRkow5Z0vm83xkXFRuZBFJOi0R/JrZmaZxj7ARGeJIcHsBJLGX0IXdLCuUmPIzqp
         hJo4iHYrn0Re5ponXU4qi1UToEczZiRgk9RRot/lx5bJGbLEhxDpr2z2j6WBR/gc2d/M
         InYblWXOzLc5xzMuWY9eSIlDQHsG/peJwKPSZzz7U7f/WcMIWHOw9SGtcqVDBu2zFR6a
         k53NaPApqMKAuw6KO8P3GhXiYBXC/oOA6mRG3I6MrqmqAtcTd6ehOx5yiL1Dsc//Tht0
         muhi1ZYGBjKQczyAtJoLI/iACKPbp3p/zp6Y8CphThSYc+hy5bl1YJycqL7jtutVnyDp
         mhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhDhPrV/lpqep2nTPtjn8gIhLmzjdZLMTdGfmJHtwOuc0kw6E5/mm0uNLUq1FPM27lOWfQHLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhp7pxlLYOKfiNXi51KywQShxDiqw8agLOs8zM9fEZxR0DSsNO
	zlywBofB7KpmJiMkpxgWZ98YVICJX40bo+Gv1NF+kXGtjfIWt1fazBR5c6sOiUHKhI0=
X-Gm-Gg: AZuq6aJyRZoHV6vBXExQz2I55UgFl7bquNVn/E+lETKQ1kBsAQkmVLVjWF99sYCNLuA
	P4xSUizZWwO0o2FVd4KPEQ2PhXn7GyAM9HuqQN3uOdfjNeLHAg437MP3ABwG5o49ohW9SMk+lua
	FTHHrtMlHa1mOCrYIWl1OuOzbcBdultJ3nC4dLTCKCjY4m6uHtx91uqlfi/pVbjAHjXVAWNlzS1
	7aZ3R1u9z9dTR1+V7JZyTeodi7I/ep7ttLCwAeHaZWXF3xSiCxDKoVIAeNZ2x3dfjj+FD0wj2rb
	/ucJhfnth8xEGl7WUIhf7MlUITfIjFh8HRxq6snqUAgRIQTI+EgPSmVnVikODFNjUR2+DUpx6eI
	TKR7glsL1D8quXleyUSVr60fedmyifAhr/9F62qNeiaRH8gMffH2JVTeiAnQU4Vzh3UE=
X-Received: by 2002:a17:903:19c8:b0:2aa:de68:98c1 with SMTP id d9443c01a7336-2aade68b5ddmr68759745ad.26.1770675773607;
        Mon, 09 Feb 2026 14:22:53 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f8cb6sm120866775ad.79.2026.02.09.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 14:22:53 -0800 (PST)
Date: Mon, 9 Feb 2026 14:22:52 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 2/2] bnxt_en: Check RSS contexts in
 bnxt_need_reserve_rings()
Message-ID: <aYpePGDbEnwWBVfO@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
References: <20260207235118.1987301-1-michael.chan@broadcom.com>
 <20260207235118.1987301-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207235118.1987301-3-michael.chan@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 6C2B61150A6
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 03:51:18PM -0800, Michael Chan wrote:
> bnxt_need_reserve_rings() checks all resources except HW RSS contexts
> to determine if a new reservation is required.  For completeness, add
> the check for HW RSS contexts.  This makes the code more complete after
> the recent commit to increase the number of RSS contexts for a larger
> RSS indirection table:
> 
> 51b9d3f948b8 ("bnxt_en: Use a larger RSS indirection table on P5_PLUS chips")
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

