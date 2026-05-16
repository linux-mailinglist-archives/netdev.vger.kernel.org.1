Return-Path: <netdev+bounces-288607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHqDLLpFCGq8hQMAu9opvQ
	(envelope-from <netdev+bounces-288607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:23:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7555B1EB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AC8300E711
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643703D2FE6;
	Sat, 16 May 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCWw5y5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F13C7DF1
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778927032; cv=none; b=TVwPpjaQTuHQ/U/ovEHB1H/FfS303KX6H+f6PdCJZia0XwtubxmGij2zmgw85AuKg0ZWPQSc5SJuI+/mRawVw5mRMOBQ05mOTkRT1SrOYfoo321NW7lIREI5GQTCqwXne7GbOdEyh8I7Y1FMQksRLwltD6ds/igXo3wV5zN2oJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778927032; c=relaxed/simple;
	bh=ucgpvPucluLLQch/91ovzgYsoGv18AD07LlNLTU7ITU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC4SVBDFREOnEE/p39yle19T5pmH1dtACUNJ+Hlv72RrXhiraEB8joIKVQRh83g+lxNaln99lelCaxGHEo/C/KYjpHQ/omNeWSal4U965QnL/vMTLvjdJNFJzx+XCiPAXbLVbKtVa5LgdMj8UFAuIrQbx77GONShnPOJq0Iqp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCWw5y5h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0046078so5250195e9.1
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778927029; x=1779531829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVa4zsTQ3V9QXphBLyT/aBBAE+kxgZ/pSmpG3ndrOMc=;
        b=gCWw5y5hJKventJP1RWXKmDUtTDKxhNTOkf4bQv71HPYRCQU4tfeuHC0R9Ynoo8hr+
         Yx9cqL1/F8JyyFOQ2oX/GVi+cnAFpfsx00oeIii7/8R9gkyT67P4kOu1pBcD4tCskBn3
         HL90+JKyDtcgBjH+TOwLJALGGUYoajfBc98/DsQYSvy7DluRVMET27AjFB9viSOjkL0q
         ULqujvEoAGnSxHasvrRR/iXMc1TlOvpuQkroX8AFk/AgZCaR5Pb9l1SbY5uFeZlUTZ7w
         UzrKZHKMsju2YpnoLhDC/0SR2suztuMOhDkpkbeQuXLJEoBlvvyI4Ms5XB+K20T+rTlO
         7H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778927029; x=1779531829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVa4zsTQ3V9QXphBLyT/aBBAE+kxgZ/pSmpG3ndrOMc=;
        b=LTezkoooHk/sjGM2CyXkkx/eTWX9XDlnu8ZEIYPUWyJ3kCkqNHFzGWOZkLS+G4U9a9
         MGTipjIWAwSletEWKFW6vX8ypE83+2Togymrq23msZ/OGIjbzTiYdHpAZ4KisQ18DbrC
         aj+4DPC+NmObOp4yK05Z+fO16jYNLxdcGQx9HXCtBiN1p7eOe+8WFAhJWz+ZodZ4Qgxs
         qLHfO/+n4Y0UoVvcsifKY50cQSLX6gV3yvWVtxGamWs2uearOZXY43N4+FlBBJkSaa3G
         PfOm9qvHqrPJh763rPhnBZVPE3G+eluBEt4RA+B5aUKbDsmsI/CiiI3Rdtz+1sY6Oaq+
         Jadw==
X-Gm-Message-State: AOJu0Yy78fhNqJZH+tIJoveratHh+6pFnKEIA9jPOe8tHypt2o73rGBv
	AVxMq8unXx1fCTz8SgF677F3SGpa5co8eYGrfzfh/VMiCVx/mvJzW5WafCF1MyRA
X-Gm-Gg: Acq92OHhcDhhiO3iYLm1xyxd12/iNS1C+aleyVQgBD4uHa056vO9cmzMpZlikTb77ux
	iTXw6POhhgpYz6ycL1lWMKXHn2TOO/Be1CW6r3xXeniduniAS78lRquCypfP0KWQQs9hSZIbWa0
	B5Xaffsj+EVl7DOk/pqRrPJfk5KyKliZynQ0DnwXpzMJVnRUj4moNwL25IfOjloDdzsoenC51Rl
	p3EASsUrssaDeInXWu8d16GFEOdwe3D5HcPpOoPl927X2FV8UJclJg8gTr9yBFSM3ElIt8YqxOH
	SrX5sJGy2VoJpXFIMSTJm19IlFQlZEdWbaz6tMo/ouspoq/kQ3WcDghxfreF4oAbreZQtYGIOkW
	lpYMmozl2+JsJ+8AMxrqGW3Jpde92nCCUCgaNwPD03AC0dOn1OS0Jd8XlD1iq2+tGNQgRv2lWs/
	JeLJEBu0YXrrk6KfWQud+6ZjzxTHXlt/46yl1OCxS82S7hWVukq8G5/P3WkPKg
X-Received: by 2002:a05:600c:1505:b0:48f:ed68:6760 with SMTP id 5b1f17b1804b1-48fed6867famr40993135e9.29.1778927029071;
        Sat, 16 May 2026 03:23:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5821fsm33738735e9.14.2026.05.16.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 03:23:48 -0700 (PDT)
Date: Sat, 16 May 2026 11:23:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] llc: avoid sparse cast-truncates warning in
 counter clamps
Message-ID: <20260516112347.68aba670@pumpkin>
In-Reply-To: <20260513092253.3035961-1-avinash.duduskar@gmail.com>
References: <20260513092253.3035961-1-avinash.duduskar@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 19C7555B1EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Wed, 13 May 2026 14:52:53 +0530
Avinash Duduskar <avinash.duduskar@gmail.com> wrote:

> llc_conn_ac_inc_npta_value() and llc_conn_ac_inc_tx_win_size()
> clamp their counters to the maximum valid 7-bit value via
> (u8) ~LLC_2_SEQ_NBR_MODULO. LLC_2_SEQ_NBR_MODULO is defined as
> ((u8) 128) in include/net/llc_pdu.h,

That (u8) cast is entirely pointless.
Whenever the value is used it is subject to integer promotion
and becomes a signed 128.

> but the (u8) cast does not
> prevent integer promotion of the operand of ~: ~128 is computed
> as int (0xffffff7f), and the surrounding (u8) cast truncates
> back to 0x7f. The result is correct (127), but the implicit
> truncation is flagged by sparse:
> 
>   net/llc/llc_c_ac.c:1008:38: warning: cast truncates bits from
>       constant value (ffffff7f becomes 7f)
>   (and three more at lines 1009, 1099, 1100)
> 
> Replace the (u8) ~LLC_2_SEQ_NBR_MODULO expression with
> LLC_2_SEQ_NBR_MODULO - 1, which evaluates to 127 directly and
> silences sparse.
> 
> The same ~LLC_2_SEQ_NBR_MODULO pattern also appears in
> include/net/llc_pdu.h:148 as part of PDU_GET_NEXT_Vr, but there
> the result is immediately &-masked, so the int promotion is
> harmless and sparse does not flag it; it is left alone.
> 
> This patch is the minimum diff to silence the warning. The
> counter-clamp idiom itself could be modernized to
> min_t(u8, ..., LLC_2_SEQ_NBR_MODULO - 1), but that is a
> separate cleanup left for another patch.

Using min_t() (especially with u8 or u16) is a very bad idea.
Consider what would would happen if the limit were 255.

> 
> No functional change.
> 
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
> Built with CONFIG_LLC2=m; full kernel build clean, sparse no
> longer warns on the touched lines.
> 
>  net/llc/llc_c_ac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
> index 0779daa8aa8f..ab86c720b3ec 100644
> --- a/net/llc/llc_c_ac.c
> +++ b/net/llc/llc_c_ac.c
> @@ -1005,8 +1005,8 @@ static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb)
>  		llc->dec_step = 0;
>  		llc->dec_cntr = llc->inc_cntr = 2;
>  		++llc->npta;
> -		if (llc->npta > (u8) ~LLC_2_SEQ_NBR_MODULO)
> -			llc->npta = (u8) ~LLC_2_SEQ_NBR_MODULO;
> +		if (llc->npta > LLC_2_SEQ_NBR_MODULO - 1)
> +			llc->npta = LLC_2_SEQ_NBR_MODULO - 1;

If you rewrite it, do the check before the increment.
The compiler doesn't know that llc->npta isn't 255 - when the result
of the above is 0. That can generate rather more code.
Probably best to do:
		if (llc->npta < LLC_2_SEQ_NBR_MODULO - 1)
			llc->npta++;

-- David

>  	} else
>  		--llc->inc_cntr;
>  	return 0;
> @@ -1096,8 +1096,8 @@ int llc_conn_ac_inc_tx_win_size(struct sock *sk, struct sk_buff *skb)
>  	struct llc_sock *llc = llc_sk(sk);
>  
>  	llc->k += 1;
> -	if (llc->k > (u8) ~LLC_2_SEQ_NBR_MODULO)
> -		llc->k = (u8) ~LLC_2_SEQ_NBR_MODULO;
> +	if (llc->k > LLC_2_SEQ_NBR_MODULO - 1)
> +		llc->k = LLC_2_SEQ_NBR_MODULO - 1;
>  	return 0;
>  }
>  
> 
> base-commit: 8ebd24a7822cbae25beeafba49b2159d6a68a5f2


