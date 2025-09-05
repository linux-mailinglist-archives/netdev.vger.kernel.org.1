Return-Path: <netdev+bounces-220225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3022B44CAE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 06:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EB5564EFC
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879B232369;
	Fri,  5 Sep 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htMXJrRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714C75809
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046364; cv=none; b=sUrkXoZpgGNHu8cq6EE/0/0KDPRCc+NDxhgeaVDNaLbjnj/gwo/K6NNpnKFIcq3ILd8UAbJ+LC3SfT8o9o+WUnpzScouw9YQItPT8TODQKxZiUGdG7fm9SS1XfV93Gjk8YvoAD3hmZeUet+MM2PYXHbGxZZUV5xKq1dA4Sa93VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046364; c=relaxed/simple;
	bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKRFVcp0qrdTU2Bnx7Id4b56okYgCT8goOpoS6Lu86WV6qwFbonJgzlXFTSHK17nSdZfh56xkp3qu5shA4hWhwaDBfpBIm6aYaX1wOxmJ7+SoSdnehDbdnE4PJxkg51Wjey4XY6Axdd11xcLg9E3UCT5VXcNUtiZkyHmrrGZzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=htMXJrRR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f720ffe34so2246092e87.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757046361; x=1757651161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
        b=htMXJrRRMGYyCmihQClevvmjDrLBJX7Z/3XgUtOCOU7dthuqse7P5iUGq8/t1mW3V8
         fcpakuzx0HKkJ30QzYlnKffMhb+SdxpVUetVkESl6QcwonkAFCf2bUV1fGGzNQiN2Pve
         2oEnzR5onaauL8sipAf9CWGwPWzL2IUhU1GmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757046361; x=1757651161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHmo68YQ7L/duddAgclVIEvUtWdksnELEMP5v/s9PNQ=;
        b=PiKlLZU9EJ6AcTCUqINXGsxexrRonV0nefQtqNb4+hTzPHY0vLDBdWHEjPcBMGvurD
         u2A64ZXfu1j1rhDcKUvs8Amj34KcDvDJwHxnvC4jnv4FWbJXH2OSTnS8bECk5NPHaFG+
         9FybwspVHTdIJnS6h7Q0eFp48SrNk3wrN4TA68bVmcQWU6H3L6lE1VuGudJRREtchR4s
         m7gRqnFrRpdlpjXlMTQqQEeczfr3eVe5R4wx9rml357dhVv8OTeCfvOq9ebM+UST3lCs
         qbyJTcr9KNvVq4x8n1hFddt1hVBUPlLI2IhygO6P8hVYHR5yO5ik5qlqVZVlx6A3iA95
         OBeA==
X-Forwarded-Encrypted: i=1; AJvYcCWrS91HOKu/nlm15cA2ftK3uTWRtf7SHlyy3+i6YkMxj1YyN/RikTl+R7RNIcMgRivmLNWrk8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//46343OP3C4c0VGfw4O9HzJanrsmhieXK6HgqmjXcwaWbWNt
	KtLLgUHvTbLbQIOwc51QIrmilH2uFbGGVdc42QSB/Yv1QEsBNThUxPoRPHs/LY8DBAO+32g40KG
	Enc1k3wCeGu7WWSHOvNSnQjwWR5/CEcyP1DXSm6qh
X-Gm-Gg: ASbGnctC34WoOB55ooMAJTbrHdswCXlhiO8HrMAGAOtriBgPqsSd17gdC9BYrPGFnT8
	BdO3m9IxERFgpTLhNApUUE5qN1ZXth0lTqqSLHvWgg5ZXzv0Ba+SBeuPp4T+6CdeTaBgynPMDft
	1yH2DP9x40/Aba1/tpF1ZEY3HL085ndsT0dw97CMiszEzgKpYcTgafmEuvKXrAGNqECLvMqb+/l
	kNRrUFzubNhSW+J3gFqkLKlNiTEbqpHfRoV4w==
X-Google-Smtp-Source: AGHT+IH5pWHA8nQf6AbDXyeEcMeTEINpq+oHNFsdmhAJKkVR1+KEZHE+PC3gHq59gfSmiiSALqCN4LCODqxkvK4xsXI=
X-Received: by 2002:a05:6512:3c93:b0:55f:552c:f731 with SMTP id
 2adb3069b0e04-56099453ef8mr666761e87.7.1757046361254; Thu, 04 Sep 2025
 21:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-8-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-8-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:25:50 +0800
X-Gm-Features: Ac12FXzDHpGuz6HiaGhCY4WidH-LRTm2axo9L1u6x0u8-eqIT-uiyLk75FyGJCg
Message-ID: <CAGXv+5FgKsg0sM6EXeTL=du2BY1xgH6jVmtQtb2M0kY3iix-tA@mail.gmail.com>
Subject: Re: [PATCH v5 07/27] clk: mediatek: clk-gate: Add ops for gates with
 HW voter
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 use a HW voter for gate enable/disable control. Voting is
> performed using set/clr regs, with a status bit used to verify the vote
> state. Add new set of gate clock operations with support for voting via
> set/clr regs.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

