Return-Path: <netdev+bounces-267646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIQVJHGmtGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:06:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C794028AD2C
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16216310F1DF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2420ED;
	Sat, 14 Mar 2026 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="d1RZ/pEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736484207A
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446627; cv=none; b=qJhVkXuzVGFWo4o1tx16b+ytjj7cvaZ85See5xv3O34aDafeXDoWblFIqvWCsi8PhtBeIQr575NX8PGrbEj2JltRsmE4eMGMiz/2hSDtQNzhBYQMyTcWEZgnZ4+tuogta7oco1aPtTCmt0pucx1jwq5sjliQfQBFDBtda7R1gaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446627; c=relaxed/simple;
	bh=1IpDbn8F8zKHinBsi3h9EdQBKvspX2BPCv/f104MPeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHslapzG5doHyqppN4QmaTRnrxUNCXVxaL+UAfksRKRh1hpKSuEERNr4KHruBJJQSYl46uDwrITBPsEH54VKeaUP87MlBXldMBQ5gl2BMHeFPX4TWajtkhdeEUdg4afh0LiEnWGbq+MRsK9mwgBhxpBUpv32ZpZliOp7Eaa59GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=d1RZ/pEK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-356337f058aso1820882a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446626; x=1774051426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+XiywP7V0UQEUfGj2DiJzWJSmdJ2SC9ctDq/9BKbNI=;
        b=d1RZ/pEK4u6XBSe4J2xY5iGXz+Yl1yGGsNE2x5UYMF2PHqHwn6KjwAOAWoX7Qovkco
         +Xp2zLNcm5sDymTAqmrDJabMD3VnTPsT9oRhDD+jJKJqOJK/szPe7kEu1VNG/xdXyY5k
         llqc3ZljEwC79BjWAqxfPYF3VOwYgelA/78+JwSVIWGu/JBFkjkjb2gishQlZmjm/6kc
         ljMtWAx2N5EQPFLWESoVAj/6+rhi3SoeQdNmAJB59fzewr7p6nzDbKbUtUeDmVhD8jnj
         2vEXOIsdkhQkcTGis/ZH0ZmQk820xhPZYOjN8n13rCEHfTjVog87z0xE5o5DuEkoUXX/
         oIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446626; x=1774051426;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+XiywP7V0UQEUfGj2DiJzWJSmdJ2SC9ctDq/9BKbNI=;
        b=tLavnIXjTVhcw+cwY8EWkPrtnpy1isMQmZaXeZ5EerQcB79YUPibAisbjE4kmhok0/
         5h6aXOyppfC6k7CYN99jCjSDXYfy/XT9BNq/V0rwdt0Uyyy8VZ+PiUX0wtfem0Jv4oH4
         eAdOxLeCrsXuHX0DWyasrkedTC+DFVexMFxtc7bkiDxOdKC3ah2k4xECpRndYINZ0USh
         9fNFzlRwxkudBMaUz6dtjg7up9f23pUiR/7xk4+BFRiTpkYSfIiq/dQH8BzhnT+Stu94
         pqBMgAfr+qiBTGotg3/Tbri/i7oPZo68Bajhiny7Ral0zsH/A8Wbwjmb/bhMYAzfeSqv
         9QvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMCgeqVRJT0CgO79NXH4ycd1bjj8N02oZ4UeADxQCs0R4xTA1rvy/U6xAktw5F3lxhfGQCNOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTq02R9h0UEiRzvntCD5St8J5J0MH0oCcpjGZ1uKm2LJx7XncX
	VmHATyJCezE3puRoiM9vH7IO844OZ6TPwWqwQuZgncPEwJzTvYIkmRSAN3mj7JZzlK0=
X-Gm-Gg: ATEYQzw+X66upF05kqXVIT/PJoI29PA4t0jMyF0frQAh/WZSPUoiRefHjntnXlrWo0v
	ThR40b/lYlWyp7H3NT+8Lay9UP3VJmeBQflxe25rZRC1KWvkEnL+lY/04xX9CK3t8dx/KHFX6MZ
	3nn0Hly4USiwEZyXc7cDDL2Dw81o0r37oHK5eXG8n62oSI3b5o5SWn6TxSfzNansKdhF+k/nM26
	ZAbLxiSbSAXVnDsj7L6kDOLo0BCToYbl/dgaAa/rgO0f0Thwbd62kbrtTf6jtuO1EeTcd8+zsUt
	LIxXLpc1JgXKqWPMPGIHNBd7z1G7g0AHGgIi1CzJrcLoof4y1roRXULXUts7rgM5PNfrSGYS4PF
	8MO6mRlWfv/gSUUWERE/oNA9I2oPAOWFrh9GFAogpH23dfLBNOwa7P75igMwKp7quOxuSwjJZO/
	uR/HzC
X-Received: by 2002:a17:90b:4c48:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-35a220fb316mr4566826a91.25.1773446625823;
        Fri, 13 Mar 2026 17:03:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm10340191a91.5.2026.03.13.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:03:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:03:44 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <abSl4GNkVtsL+r+E@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-5-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-5-carges@cloudflare.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267646-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,cloudflare.com:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: C794028AD2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 05:27:34PM -0500, Chris J Arges wrote:
> This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> This re-uses bnxt_rss_ext_op to provide similar functionality. One
> limitation is for L4 hash-types, protocol-specific bits can't be
> determined.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v4: re-uses bnxt_rss_ext_op
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>

