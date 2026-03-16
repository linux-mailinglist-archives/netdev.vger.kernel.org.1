Return-Path: <netdev+bounces-268326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ2HORCKuGmJfgEAu9opvQ
	(envelope-from <netdev+bounces-268326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:54:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 898002A1BEC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F0A305F3E9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304B372B2C;
	Mon, 16 Mar 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNQFh/t9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E5364E9F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701541; cv=none; b=jerjaf+6ECq6eSkvrTC5y9++pnI+UCghtb7O0ko8twWz6LXcWMh1h1l+Pw1wwmXcsX60xNDuk/oMlBDpe8+3KXG2vHZJUUSG0jhH3w/XaN/uyt1z17G9ICaDl5dunyIwVmdYtqNkJj7DVxdV5Pvp9G85f5M6MfqAry8SIXvPuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701541; c=relaxed/simple;
	bh=nXKKpVU0EaOuK0WL/FjvLMBDolhz9xqKdL1OufHkpxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrTs9UtrjpWIGzYy76mV0+3tFpF1k9iojLHb4/1mrX9iMXINB/s6fZLYjyei8E0vU6r1MR7nGtzOmR29BS6LhhovUhoyPvchhOYUUjE+OZvCz7DyWmQ4nOlf4H/+8GLAbkaB7TBOc0fT7e6qqbkBuFQmrCCeIy5FbG76WX6kwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNQFh/t9; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12732e6a123so537386c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773701540; x=1774306340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgmlfZZe7YWlllpAdANad5O+7C+v/m6YJ647o+2yW2k=;
        b=lNQFh/t9M0HY6QqhfPcLcKuzvXO7lvZEe+5ZEj+m7mmmalpWApEQOQXq4fVlR0xKSt
         GdfVfHnhaGE1DkEAPfw67s/UShMFxGHYivqhFwBbv4kiv82wgE9m9CQ3EBkCiIolzfvW
         VvafzTUZDTC0jaSSeB3okYi8HaX08jSIb5MGON/xxgL+EA24JVPNpkckLaRwUOo1bQyI
         VFRPQbQTjJEKHB+j6yALd/ELHrqWPcDbllGbnk+/yFxB4Gqn0ji8I3z0q1+kdbHTCT4q
         p1SL58UzGWf09KdZuUpctIsIdjuYQe2cFlgHu7Y36oz2Q0AgNvKxMJZLaN8ZnCEvO5lZ
         mhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701540; x=1774306340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgmlfZZe7YWlllpAdANad5O+7C+v/m6YJ647o+2yW2k=;
        b=G1y2rP3eXSKUcxH3O9OVmiLfzk+vLu82uDHGYLAHqg58FYj6adNjuCYnuy/DFHr0dt
         pXyZxLWuc/a4i6ckMxBXry6sW3Smf8zzFOcZYSiQsSYIMjs5Vwb1dlKX3WDfaQHXWY1G
         /9eVGkmAHDqEKyHQKklbgxPeYUjA3Bee9whFvRRQyFxdfvi1kSSyfysbPbiNFtTAj1/Y
         RvN8JSYjqJTyJlPzKXqpZjmIC7LJ/SH177a7WCMcvvUkag9w6Mt2melOpsJ9LbZZOPOb
         lXs8AVOqRv+f6XOiSZM6qtLT0r/8ajxq4tOc/b7vjhseNiZRezM2j4kl5Ve/sTGI5xZY
         Ptxw==
X-Gm-Message-State: AOJu0YwNAcZW2P9kJJpEYTPF7ic24sSLDTi01SzP3+yG7KnRDDpAQCPe
	PxMl2oWQeuCCfLA+zVlpKAYlj6jyYJPU0W2iv3aXE+Znr/SyyzT2fBXZ
X-Gm-Gg: ATEYQzxSBapshBiGIMRaVKoSnIn+y1W3fO1C452zisaIcDbjLX9VrMxR9coRfyITNZF
	9c7BpKVvJ1X8FA34FRi2DcgzuZixegZqhTlkhODWjxEFZN7oinQxKGbjL5EkLAP83GJU3+e1LcS
	De3XmK6150z0TEbyJYKhEmHKMeuOipSovIYyS8yMJaKbMIdd3EexYaCBiiQVKxpXHTJYgHTVlMW
	v61AeJh2vnZqOxoXTA8iKVXnpH+VZq0I8mRkYyO5Wy8C11HmYbhYkFbUsSusWMHJyxgQCIIzUZb
	TIwAMFc0fW62fSSh20VEbUNQKFE1WFETVvc3aGu4s9mPVPWookNitPYcQZwY8xn/t5kWInqIvtU
	6MvmkKHkOO0lBm2ieZcZd0GiBgOhKYlmcXShD+2YBJH0FRpe/DHDL0WQAjhnss1Y7gW1Ni/VsCm
	0eyaOkrs5oTk+yPZ0aByZn/CuVnBWAYKFmByC5EEQN3Oun9dhLJcdusRVG4eM=
X-Received: by 2002:a05:7022:7a4:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-128f3df7206mr7239752c88.36.1773701539661;
        Mon, 16 Mar 2026 15:52:19 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm16688566c88.15.2026.03.16.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:52:19 -0700 (PDT)
Message-ID: <9c6173d7de643bceb8bd35eec185155d4172b123.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Date: Mon, 16 Mar 2026 15:52:17 -0700
In-Reply-To: <20260307064439.3247440-4-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-268326-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 898002A1BEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-06 at 22:44 -0800, Amery Hung wrote:
> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> initialized dynptr in process_dynptr_func() so that we can easily
> retrieve the information for verification later.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, int regno, int insn
>  		}
> =20
>  		err =3D mark_dynptr_read(env, reg);
> +
> +		if (initialized_dynptr) {
> +			struct bpf_func_state *state =3D func(env, reg);
> +			int spi;
> +
> +			if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> +				spi =3D dynptr_get_spi(env, reg);
> +				reg =3D &state->stack[spi].spilled_ptr;
> +			}
> +
> +			initialized_dynptr->id =3D reg->id;
> +			initialized_dynptr->type =3D reg->dynptr.type;
> +			initialized_dynptr->ref_obj_id =3D reg->ref_obj_id;
> +		}

Nit: Maybe fill `initialized_dynptr` unconditionally (regardless of
     MEM_UNINIT check above I mean)?
     Remembering under which conditions it is filled might be a bit
     cumbersome when working with this function in the future.

[...]

