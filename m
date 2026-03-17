Return-Path: <netdev+bounces-268714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLDTCF6iuWmiLQIAu9opvQ
	(envelope-from <netdev+bounces-268714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:50:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB32B12CE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABA453005339
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8103E123D;
	Tue, 17 Mar 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGThrhZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E134DCC4
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773380; cv=none; b=dHxIsDn9E05sbm64el3PnoxKp7DFgXtGrMdQTctvbBggLOopsDQb7Mg53Qrl/JFgfSfXMe4kr4ImZCVxdC4rfFjE9F09wSMkG1f7AfN0IE4VUSWe76NyE2o+W+PxCKAGcVHmLyf47C/V9DrtFRD3LpfnC3KqUpnAoLH+qo/M6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773380; c=relaxed/simple;
	bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBXpoE3xuRHXU2KvcU3ou/JyG6McZfu5s3/CruC/qSNbupfub6QLtqWEcH0lKtA8N3gPF52GszCoBCOlmYBQs76wlkmlhDLQl9RgAdmNNRCq3I9UIQJ+WS5QpVz9H7mzgL4tvUREY8XiPFbWw4V1WSrEYGgDqqhmd3IBrIHf6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGThrhZ3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c741692db4cso62197a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773379; x=1774378179; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
        b=bGThrhZ3iIU9T+FWRxPHnh5lHqDFZRRmRQeScJpqa85lV/yx1EO2W6lpQ0tdHq8Pzu
         psjvnSddvYs/JGw4VJrVMmMEZK87PAkYNiaJMZvhGL479vi3HMm8wev3yqbDuX+YXb6M
         t5CxDJAH1DQ9cC92ZYjoAud+hnTKXbVDX8Cs32HWan7RgEaWL0k5A1CssD/h1GGf1FaX
         OtmerThvm+jP3c6kcS67SQlxxLb4GlPbbKp+g0tY8Qsvz9g8R/qy1c4bpOziht1NBp53
         3Q9cIEp2TgHkt/vCwcAMFNYQlf3WQCXgbq9u9mDbt5zBuPpvZva5vDGUXgD2CWfhxk6/
         eeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773379; x=1774378179;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn4xRhGUeUFSqpXwVFn4olG8Lc/o5U5g9uUQbuHmFrQ=;
        b=QqLy6j4c6x4wfd5PU0dwjjLwktqfUbN2VRp8r1sj9mwhzu9mKyNbAp/E1YwBXe2WEa
         DEfJe1htKPugpw4I/Vj7GJVvIkSs+wsemDteE5c+ZhGC/bUa0S2E/OO8LqDbvRMZZ2a1
         M1HWXpBTCthH8x3EhX4XnD5B+rK/gEYZHUPd0p/cp2eXqWaXENViZEvPMFKS4caMkY8P
         T68XAU2MPZNuIyBvNJAvWsRyg8Zz3tPAeIWIb6c5FIXi2sPmtiT+NFnji1yFL2lz3ODR
         /4VU68Uyg+q00Nyq17nmHPTaV3Y8hQLlFUPPxT1GSrJBcA0MLMMDVVLe1u76iECUtBY3
         C/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWcrVSf7wyGava9ZaWsNDhmoes210l4YWMjc+NLMXpEJXF3/m4Zk9uzHawyGT1y7JLHnlaHcqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEsyBzOOZIk9Qv28VWPqEmROZEsiGSjVPyDcLqMPKFsX1Hcm6
	SejKYVLCxWZ4ZulRqzOSUSBaJFygwd5lOkhrHVr+nLtd22mwDpV/cLLm
X-Gm-Gg: ATEYQzwU2jZyRRcmeeskphNGTf9i+LuF8gBzSIjKTB0nxV1xx1jRSYPAxZYsViHtNTn
	ERQXNhoQsriksFoRzE3iP8qrBxnDYgnEn0DE8EhPC9G2HtL7baCP2dEvPgex7/nmfa/aYb16dDO
	7LkIRQDTWi/DG4W1Y3MWYdr195V6XSmvKGClquKCMS0TKq72LdAufjc/8ErQtRbdYDIgJ5wX1A1
	gNQblcPAVlbxvbajdI+hIvnPoOT/RQ5sgv1yt9JF8+9wyQGF1eBVdxD4J49X8R7n01gLcePKlxP
	1GECR3ggh7Nf27Ou2Yv7QerdfUtnJGPyz2uR5fqdneVhMm1XoVVa2+KqY5idyTrpfzo0hd/lyDQ
	QLa5Zr6LbBZW4fdheTXmgP1rfZL47ryG/K7ttkx1MjtwvzLHZdt5LA9ITErVCmjUYqdng6VMInt
	9L5aC0LAU4ODoTTXuEz0vuaiE/Dlu86cNffJyJokobkTl5z52uvDsv
X-Received: by 2002:a05:6a20:d43:b0:398:5f66:bf59 with SMTP id adf61e73a8af0-39b7e0766e4mr3735686637.36.1773773378682;
        Tue, 17 Mar 2026 11:49:38 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e546877sm328725a12.17.2026.03.17.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:49:38 -0700 (PDT)
Message-ID: <c867fba43c9182113604fa2435abff782bea254c.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@kernel.org>, Kernel Team	 <kernel-team@meta.com>
Date: Tue, 17 Mar 2026 11:49:35 -0700
In-Reply-To: <CAMB2axOmWD8oDc-TVxS2NzWjvvwXCo+N-kyqj2UWV8OTe5_yiw@mail.gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
	 <20260307064439.3247440-6-ameryhung@gmail.com>
	 <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
	 <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
	 <CAMB2axOmWD8oDc-TVxS2NzWjvvwXCo+N-kyqj2UWV8OTe5_yiw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-268714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27AB32B12CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-11 at 16:46 -0700, Amery Hung wrote:
> On Wed, Mar 11, 2026 at 3:30=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Wed, Mar 11, 2026 at 3:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:

[...]

> > One more thing...
> >=20
> > How does it interact with reg_is_init_pkt_pointer() ?
> >=20
> > That pointer has to have id =3D=3D 0.
>=20
> I haven't looked deep into the case. Currently, skb is non-referenced
> for non-qdisc programs, so skb dynptr won't need to track it.
>=20
> If there is ever a need to track it, we can assign a reserved non-zero
> id to the unmodified pkt pointer. For reg_is_init_pkt_pointer(), it is
> already checking tnum_equals_const(reg->var_off, 0), so maybe it is
> fine to drop the id check (not sure).

Looks like dropping id =3D=3D 0 check in reg_is_init_pkt_pointer() should b=
e fine.

