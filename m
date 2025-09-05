Return-Path: <netdev+bounces-220249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7BB450E1
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7462F18966B6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A72FFDE9;
	Fri,  5 Sep 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Btp6hzfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D291F4262
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059486; cv=none; b=ZuZRpRyx1d8DhxTjrMCoXAYmnFHv6A20OEZCcm8d1hEZl3xa1jWcbYckag5oWMWnxn/NTFVPVX8CjAEfQ7XCf59k5PxUSRBR9k8R3r37MQqMnY7VoFMvwgS4h3npLpKobBu+d1r8GrCvmxQxsxF3c5nJMKiNob97a0xwYyr7ZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059486; c=relaxed/simple;
	bh=3J4+g2V4sWrtHtemeApia0D1CwSCabpiECH2Gc7jqHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0uuVpJX/QhPrzcUTpE+Drp1yK58LQjV5rHERap6A1RhkptjjUacEjsM3KBsDp68qdf3mbQNJafZeUbUipXreanKh6lHHHjuLePKhT+6ftjV/owoKqAYfX9ktnzNU371oCg8LnspbPawndFD0AknDEbOeYAUhg2hFI/086uBwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Btp6hzfz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336b88c5362so17946051fa.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757059483; x=1757664283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J4+g2V4sWrtHtemeApia0D1CwSCabpiECH2Gc7jqHs=;
        b=Btp6hzfz4fIMQsarTFsMnLAfWVos9BkEPbBYhpuEYLDx26tordIN89lnk28EowcLDu
         Q0jXZGTXpVQtlsKCOFau9WlFu41K8TSr21Z6X2DbsH/kUm65eyg4FxoMMUt5ZSwZDWfn
         wns9vAoveW4954lfmyROdyO4NHh+xajzi7N+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059483; x=1757664283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J4+g2V4sWrtHtemeApia0D1CwSCabpiECH2Gc7jqHs=;
        b=ki//p5yR3xov0seJMnRGey/OI+9dMMR5YIORJG3FcKa7UxryERQez4QVeFJP0zVl0k
         WDRoLAwinvidGkcGVYvd3Y/O207C5k2NprWv3f7s0K2xUbzGTwz1yocAuenBV1Rg3yI7
         4d8td9fOvbavGoDp3tH7FXG7BVRen6dTNpp7cHSZVNJ+u9h+Tv/eiTiLS6es4iYQbZTI
         xAoWwKdq8hLr2aRn3x3hwZ6Nl8v7ZzTDyJ5Zsqz6TpZcMA1IQaGFcfZp1hHf9iXM9ACn
         elz15r0xk+24PLDigc9FwGzpuvcao5+ppnCv0LTVcDJnNg1JqVDDikbxcPJCSl4MJmxX
         7NPg==
X-Forwarded-Encrypted: i=1; AJvYcCWO6iybBz9vwrbgnzZb5CFYgWm5ynFqSZYA5KrPGx8ojxBGpc6G4Hc7Lv94pDvIdHl1Jped/0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMOooqo29bZ8eeXKTwhtfgYuci+ZSNfKWTA1ZjpxxVbJxNDEF
	5R9QF4gC2l/efdgstCSPw9R9x8ziPDXDnJx0fW1/u/VGB04ZwkmFjD3fD0t1ohXFSju+4Xr4z8/
	DACvR1MFh/goThUtnTKvUPkWplf4TtWUWOB5lJ18b
X-Gm-Gg: ASbGncvpdEtIVHiGQHA/8LVl0h7PNSQDSYytXLa+M5dPGkScgF7goeRsoe48Ke0jDuw
	Y4qcClf1F/LYyKsdaik185Dpt6sIJe+g55MQczHxpY/xQNhbZGeOLytyDhZrPF58rXlEtbmQtnF
	1pPvBWpc1TzC1i68i+AeFasKugQ2RuViYbYxS9naD86kc7tkufcKQb0cevg9XJ3rY/hCZQo8Xm9
	Nt/wyjrKVDJyJGmetQb1CAYTu+ENRaJnykDH3dLFKwFiVID
X-Google-Smtp-Source: AGHT+IFYc+QgjrNQcnNX0OlLPGUtYQKqYiLrIJbM/loEuXaaE2NFn67DssV7d5/BEdo89ntnizvXLq3xRVbqrk9nj5U=
X-Received: by 2002:a05:651c:2106:b0:336:e176:cd3c with SMTP id
 38308e7fff4ca-336e176d479mr52475301fa.38.1757059483084; Fri, 05 Sep 2025
 01:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-20-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-20-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 16:04:32 +0800
X-Gm-Features: Ac12FXyKW6bhjZsI-yGgtsh7BXxxyLqh5BQG4iFyVSU7pOJ_sKap2vxzQ5qbqlw
Message-ID: <CAGXv+5F0pWn5+iE+3pgpZ+GMoXDV-eoEx4zKTfsmV5cpa-WC5Q@mail.gmail.com>
Subject: Re: [PATCH v5 19/27] clk: mediatek: Add MT8196 mdpsys clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 mdpsys clock controller, which provides clock
> gate control for MDP.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

IMO removing CLK_OPS_PARENT_ENABLE is the right thing to do.

However if the hardware ends up does having a requirement that _some_
clock be enabled before touching the registers, then I think the
MTK clock library needs to be refactored, so that a register access
clock can be tied to the regmap. That might also require some work
on the syscon API.

Whether the hardware needs such a clock or not, we would need some input
from MediaTek. There's nothing in the datasheet on this.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE remo=
val

