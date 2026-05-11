Return-Path: <netdev+bounces-286832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHPyJN9KAmpaqQEAu9opvQ
	(envelope-from <netdev+bounces-286832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:32:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD205164EE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1889302E0E3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339AA4D8D96;
	Mon, 11 May 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2y9gkDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647B3AE1AF
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535133; cv=none; b=S1yqj3D7nihpPdbhKgnDY9GD2fs7EKOH9M9u8mru3gq6ch2wzIo6VaLSmZwreb5AMr0irvTyd04CCQ7D9rm57eUdwXWEbH9SKRmPBejtlPs1qzjdaIbQRkDkUNd2hvGRzEj0K7+sPQrcaOOajYMnV4fb3nRn+hO2UbRla83SPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535133; c=relaxed/simple;
	bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lk0kLRBzrDT1nGYPvAibuqgKFlC/o/fjcEjS5QfyFeJqY0XeEysTmDZmqyc29ozdnbCKp48OhI4oUL84K1wrZh9BaCuhWlGGAiaZz4Yi/anJ5+wiRrLfHrJ8qAugLxU3iJgUc6DQpy2q6d6YnB3+IMdvtbbDC/l+xxuF5O/2slI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2y9gkDX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80227c9572so2147840a12.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535131; x=1779139931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
        b=T2y9gkDXrilVfvgA6e6123+PJ3wjEgQV1BPlAt8gXLvYeNdFaDCphZx08xL4HzrNiT
         ENX6q6kyhBgvlApti0Whh/Gt0NML5BbgvPckglRqOBTANv2FH2EQUy7Y0kaTdMRBnJgl
         XCrbR74XC+kx9IoSZI4EIVb10PB6bxwTTUveySULMyvapb7WnTo4vryXtrN87+cYOnb8
         vgzE/oclQdFlpOlEVZsmc8QeTCWUGVj4Z1aMJDikFzM7HvkUk7h/xYwhvQfKa5Xy+m1r
         EEkNG/PcyhesZrvcf/bD1HPYMunkB/oeoeNVB87W1W+JKHzBCSTvDQWdBLIXy0pAIkjk
         AoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535131; x=1779139931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
        b=oIUK/jXlQ05WCut8Pbq71j0Hgf6KYx4tsoNduRc7UyvnXxTCi8ZSBhuRyqaSpDxF9a
         Aa/70HO7jRJmRPhWgZj4Nm8P8CrTPfeGNV/u8GaVMS5fUALnKMVHUue4/Rnn43UQ8myL
         3R/ntw2BKs9cCMai2YWoJxV/gJsYHsHn0hA0pg52Lc5ScHR6HYAtgKE+SJAFnlM528DY
         w27/UgtCyosVg+rrszb1xKwRJpK8UFlYJmrmVrIWcD0+CUNTJx1BKuPJL3DFfUy54HVU
         ukMgnz8CuUN4Y/A97lZRbfhjdVgsN6QN5zvWHdlv9fPynfbsYxaRkW5/KvP6yqNRRxtQ
         jvvA==
X-Gm-Message-State: AOJu0YyPy9q95AVIS9GFK6M6GkTbqzNimZttmrAgUU7AX9LIK81pz3yy
	HHFeVGY6qzVE69qA/y22Klu9eZJErYfkcKhx9ADcWkxwLV+XdClqH1Yq
X-Gm-Gg: Acq92OHmZXYHXgg7JU4kABF2oXjPyTB4jnGTx9SgqXViiVUOOCGEXcJkPdnAzgTssLc
	vWGY0n0EXoBvPauczCLVM+QWzpXNOID6bxaOV/hztfdhJDiGqcbBt4YKayC37p4woNzQM8puJDB
	uHPBmua+HqMasY16W5YB/H/zHsWTSys9TuI/+e5i8LDfZuageJYzqqdCt+SeCR0fy6r/ot5VSFF
	ntl5kme3TkCfb779CwvPDzXxskBFtt2b2KWpTN/578M73oTbMJGk3XlPDKp2U4ENQP4Vtvdwd/l
	tCPhvzrEqtdI0P6m5M7dFEE5fLMDzqVxPklLgYBdnNRxeyY8VI34PGyHTg8eNOgCur2WUlMzgvs
	Hg3pSRIbW5dx28XoiG0FNXRX2BEEmXndea891c3aX0RHvJHo14VQNKKcJOXNJC1sL1i8raDE5dw
	lNVjXOllmv4tGCnzSpHVg2PtOYk7WCk18GBUobkgyI11y7+xr0kdVI
X-Received: by 2002:a05:6300:8b0f:b0:39b:dea7:5624 with SMTP id adf61e73a8af0-3aa5ab0fd90mr29046701637.47.1778535131400;
        Mon, 11 May 2026 14:32:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267688fe2sm13220236a12.9.2026.05.11.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:32:11 -0700 (PDT)
Message-ID: <ec274df02803a681bd85f4db57aee5fe0477e80a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 14:31:38 -0700
In-Reply-To: <20260506142709.2298255-4-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0DD205164EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-286832-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

