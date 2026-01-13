Return-Path: <netdev+bounces-249423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82442D188CD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DFB13002D3E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F084310777;
	Tue, 13 Jan 2026 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu5a1ZsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0F285068
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304794; cv=none; b=EMR/70ofd4OORUTUcSlWcG7upY3V2NhOAtCjmM7BRMiM00LAbWVon8DyiQUwKhQEEx4sJqyFCyyUeDkvoOvt+bP3czg6DxMS/2ulbKfgjW6t+WtUeZhKh6jH/AXYnVUBAoi+/RFb2FuEXshsNofxL6C4nPGQQ/G2bU1FAhCeGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304794; c=relaxed/simple;
	bh=CCJZStNkevtK0D3tDh1SsnssYFTA/9KZp8lN9lLNq4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmUh2DMidgEYL3H27b8BprV5saJrigth0CUPnO7z6dwsTEsHk22dYy2ze6Ezo2p8y/Jkhkai15qMeo1/4M66NL1lp94a+wK/h02d/vrpZBrHhABwv9BDkngFTwhv1WVxA/ewR2Kb+diHfavN9ZpYBLP9DwPporb2GRgG5A9Q7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu5a1ZsQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c2c36c10dbso691743985a.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768304792; x=1768909592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wld4JHDvl74USRHZxzj3j60PfC/46/AQrbLBbLYQ4C4=;
        b=gu5a1ZsQb9SVq/4P//PLhqt42zdR+mSuYIG78k9HZFHaQL0XU2c1cncc2j8zjs51Zh
         QQD1dgROaFBNbsLI0wxfXSfHT2dgOkPQwHL2wlObJdYGt7g33vlMrAW3C8hTGaPfprkB
         40hM628Icw7qECs+9eEM4aiFfbedpXPfYkTPn6kfULRkOoJ08+afCa6DTBatMvBDPaRd
         z0x3n2M4l1b5inOb23YrhW2ar/JWTfgjNDGxfNBw/cQF1s/tBK6dn/WrMgl00NYfblWF
         bFVvwCJj/TtWB0LpF25KUwZRHmohLTYxRpk3fxrvPYmAXImWiNd4GPyIztftQyL3jhcr
         LoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768304792; x=1768909592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wld4JHDvl74USRHZxzj3j60PfC/46/AQrbLBbLYQ4C4=;
        b=nNWKHi768GyK+Nb5bdOaVtHI2BEteheT2xeirOiQke3nUemcZZznn8NESY4l57yZuZ
         lHo5l64K84lwt+fYvwesVcPLjzn2UXUe4N6sjmt9ZWQ72i12ksjtC1cfXmHADVsS/NW1
         xKziSWZ9J0MuLm5ylA9rQemtDriIuYRd/n5ozYL7Sr2ZN5XxOMal1I+dr8qXhCpZ8yf+
         7TJs/QUl8IlKpcRRDN+6t6H9mlH/hPPrIr4Gx1xcOB5W1y6lhV1zuOBtDsA699xXAPtg
         wBP2UcWVirh8rhmAAPlXHMe1spdWChWaVuCVkyrKOIcGAAhFF/RIN+m8TSLvg1mc+s1/
         YbnA==
X-Forwarded-Encrypted: i=1; AJvYcCU0tt6s0iohCnftd85aRmGRPwa/8+/DJ6xpGGk3ub7x9H4D/pf4YxQx+2bEPJh9+IX4yO4e11c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaD9DNE26dPXsznT4WyrOoPagPNdG3EEovUFJz8oezOmo9AZq
	SGCbMXbIwFoVmn19ve9o38ypp65NH2LELm5I7cIV2NEZ6AbbeJQBfrgiCGvrdq5UzypX9S7+cKr
	03PIO6fYTHJLAN5MJO2ZIjzdXcOTI6uY=
X-Gm-Gg: AY/fxX5dbSXBaLwsaUCXzst0kaE7T0g4ys1fXBoU9WgGViuwfEdZS+WA2BmPmVnemrz
	lQ4NWtOXnEO4DzCp1e/nS9OqQHIF1GZroCV0s5FL41yHkQn/J0tFh9TTjkWRblI6cWnFa4j1qWb
	cU+d7jd8rJBW/R+4tNaIEJIS3DR4LdzIPOi2jnF4xBxvlPO4kqLO1koHaGewhtDTSWAv3PcNz4Q
	vJD0gJkQ0G+aMAbp2eipsTrlqPQjcJeKIjmbb1vj45OMI/TrdPpPHiZdBZtzbjb3iwfHQ9jrQ==
X-Google-Smtp-Source: AGHT+IEW9z+SsV3vzeGkzaJY5E0OocSsMZ7aN9k0LIJiTbCgdiCXTZfaXWY0MCgCuU2FMmArC7myKIrB8n7sAwFASyE=
X-Received: by 2002:a05:6214:268f:b0:882:437d:282d with SMTP id
 6a1803df08f44-890841ae54amr316662036d6.30.1768304791816; Tue, 13 Jan 2026
 03:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106122350.21532-2-yyyynoom@gmail.com> <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>
In-Reply-To: <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Tue, 13 Jan 2026 20:46:19 +0900
X-Gm-Features: AZwV_Qi9mDW3Zp2wj66KmzvlBW2Aq_ym4Vldid0DCF8V8aMsX43oEvf9iXKeLlk
Message-ID: <CAAjsZQx9MqjuKW9tJqH3Jt+t3TJdAg0EMy3pfmm-=8jePvJ7_g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count tx_dropped when dropping skb
 on link down
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> You might want to consider converting this driver to phylink.
>
>           Andrew
One more note: I=E2=80=99ve started looking into phylink based on your sugg=
estion,
and I appreciate you pointing me to that keyword.

It seems useful not only for this issue, but also for improving
the driver more generally.

Thanks for the pointer.

