Return-Path: <netdev+bounces-248586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7121ED0BF5F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C61030A2A06
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77272DFA3A;
	Fri,  9 Jan 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO2J9qtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663912DFA46
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984615; cv=none; b=Jj/cFqmMlqEkKCDYu8nWOCSXheDdreTydRjVHdxbGf05zpAUG1PegpaNRgfvG7ptJ/wRWKSGYUlv9dgg7E3OOzcresrDw/UaZ+NX3WDE9v2LBqeYYnxBgdbuhwe25vro2M6SGSKRUv5jXPCXnmVn3JjuKGgI0v+numCLae4dwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984615; c=relaxed/simple;
	bh=qdrDeP7oprKx2hl9E9Pi32hmF3i+aNgOFf4WXNKh7T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg4942rsyKPD+4/kX4wd4BUuoDXNQG3fnInc9ncut9SO/iewjKDnkwiVHGH0z2yy9jsq9VmW5HOkB8CD8kX7CYHF0nNsn+ZLVUIv0T36QVanpyt0dqSvEmk6AByQ/uoLE6eff1ZFsjFA4d3yfZl6JtArF8Ef/zidmnMwHbNZUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO2J9qtG; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446704997cso4044447d50.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984613; x=1768589413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK7bh/7p/7tkMzi/lq2Lx054ktT2ALu+WlVe58YV9B0=;
        b=iO2J9qtGhH7RLRhMIy3Og+zVYRQ2aHHoOPq3L0MKcdzovGgqjB1n8Ej+DoO+QPWsoW
         MZn3YectmDhdNbMETqFPqj1XRM0+WNrzhRdrmq7/3y0hstcAZ+rpOLoMm6yj/R74WLYE
         ph2TpnBPtvHM4PQShpTrt36TyvFGJPr1UV5dcvhU5mWMg0a/S64IpREeSOwedQi33XyY
         EVyiph0kwC0fKwYEKTenYaGKnsYWo8YA3EtlzYKcGrSv3pmCTUKZN4liiFunE+wPYrgv
         Iua/7JaknwbLS/FyDAK4BTSfIIvId0X+1JAJpiOb22SRW7P5+zb9jlvBNbF+s7shk5fK
         eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984613; x=1768589413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wK7bh/7p/7tkMzi/lq2Lx054ktT2ALu+WlVe58YV9B0=;
        b=oGqCDkge3SRRRlMXFzy8EftpjPq0E37ky/PZ7jlqBYnH30MAjbf1MGDCtlTWPQgHzk
         aBfClAo5/tvX/PYusGSZ0ritwyhm51nDAwk50i+qYmbh+DicTpBs7hEa8R6CWYA8eVLW
         2CgsWHvhA7a4Nd3/5V9Xe7GrMNFmr90Zf13cCcMs9h0YBmcES38UjeI15jUJnanljEhR
         zm9V6DK+mz02SdAbCSJt1sIbSB117y/25DiYJwm4ArhqolGfQ/PoewvE4ReIVkd8ugfx
         GoZ9nhkgEriYwT7xN7RAcWqwLWkW/VdFxULen2EEdp05Rb9A9fL3FkAib/PzpE77DbCC
         Knww==
X-Gm-Message-State: AOJu0YxuSbh8cq1DONSJFnO+gIC5t5KlxKKkZDzqSmCSlbdTw/evjGSe
	tzo/m7vvBpRbFTGdlkAJ8HE+Gu9+eWwNomIdi9yAbQOorHJZygpiOMYmk3cwCLD7Hy7vhQVsz4c
	t9C0FFq/WnrdPJRtHmSExiNMylhpDlF4=
X-Gm-Gg: AY/fxX7xxKi3qkAHwYrerEou57z0go2M5E+Qhn6GQbZapv8iw5A2t+ONgr5cCQkClg+
	nvDUWubziB03gg/BQAkBm+OlpQWpwMF+2ZwQMbtDMtjUlS5hqTfXhE0GyHcNPuLVOvp4T+EG5qF
	DIWZV0Cvi+cepPuuTGadE+j7y0ElCiccLEYsJoXmVbqKtDNYRWmvcW6wqnGpjxE05wRx57VxkIV
	ReUpU3Va+qRq/rq0z1uKZIfQFahwQgXHza1sE2HiyjHccsByTVX2zqRABSoLIh28PPPOinC56nP
	LQs+L/1aUsM=
X-Google-Smtp-Source: AGHT+IH/QwK3C6Uya9V1E/1NniDk5L5dUAHhO4HowjaQmZEhpYanC5C6VYaeq0F2tfr3FgPQgIsfVoX+0vVcvCgI9hE=
X-Received: by 2002:a05:690e:1c08:b0:644:4625:8853 with SMTP id
 956f58d0204a3-64716ba3653mr8290815d50.34.1767984611368; Fri, 09 Jan 2026
 10:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218175628.1460321-1-ameryhung@gmail.com> <20251218175628.1460321-4-ameryhung@gmail.com>
 <429e4120-b973-4b26-9c50-2e03c104253a@linux.dev>
In-Reply-To: <429e4120-b973-4b26-9c50-2e03c104253a@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 9 Jan 2026 10:49:59 -0800
X-Gm-Features: AQt7F2qoc8qq_Oyv6fLiOa5JXKdeBc18ZjOYglzW3h7ak5WXpPgk1mY-8Nz-D50
Message-ID: <CAMB2axPv+wHfj7N7Txcqyar8p9kByZgiChkoW64E+XFJxN2f3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/16] bpf: Open code bpf_selem_unlink_storage
 in bpf_selem_unlink
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 9:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 12/18/25 9:56 AM, Amery Hung wrote:
> > @@ -396,17 +369,39 @@ static void bpf_selem_link_map_nolock(struct bpf_=
local_storage_map *smap,
> >
> >   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reus=
e_now)
>
> bpf_selem_unlink() will not be used by bpf_local_storage_map_free() in
> the later patch, so the "bool reuse_now" arg is no longer needed and
> should be cleaned up.
>

Ack

>
>

