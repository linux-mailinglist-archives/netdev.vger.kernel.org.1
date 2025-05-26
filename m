Return-Path: <netdev+bounces-193448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2AAC412F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE6A3A6B02
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8C433AC;
	Mon, 26 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQpznsxs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6328EA
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269193; cv=none; b=tIejhpbuemZCONQTnYFMHzhzsGqKL+eLo6nqXotQlEaO03qY1J54bGlbFIpwRlSi/rNdBI0JcFBm9YfP0pVpZ5rUm5BUxophovgJ+xQHYlqiJFWdBAuVWpE+ecp2LsShQtXwbaOU/PTNAwjV1WUYFNlb3anSlbblnnJ06YvwM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269193; c=relaxed/simple;
	bh=QPZsjHJP8+qN9iJVyhMRNNNvTGgEI/GLHNRsj22ggc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsFm3vDkAMkqTmWfnXOuJ6sILLJ4/Nz5eMmSPzO+DfE4mlOHMYyFgmtSOe8N8vpqgIPRTfn//lEd6XESErmyjMZ+wJy/RoTytLKDuv9ygligXueorDgA2FNWBWilvc3idvGg9C+SzTy38MXmxinJnaQNbAqfsJUwI7S9ALY5rFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQpznsxs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4c95fc276so273706f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748269190; x=1748873990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPZsjHJP8+qN9iJVyhMRNNNvTGgEI/GLHNRsj22ggc4=;
        b=HQpznsxsEMFjW6C0eoC55HDmJgPn7gJ2+I1gHLxtvZi/9me2n3jRDQurG6sllutA4q
         aBYbffX3iInM6NmNjlr2g0Vha2Ny83oOE1o4ZcuKBoLGqBw+shOTY4gHQn3/j/aTJyvf
         TpnJAtDPlfLO2e+c0wEPm4Sw5lLt6NJo+tORJ9ILYFI0zJqf/3i3iOfWaMCEINhyhqPu
         uC5NGkrjgbltNAkrk+e+RKOdqYoIaB2EhZICNzw/gn3ZO+dJ/ORpuWwgw2osoE3AKHM8
         rOF2uAnwhSmQZH/4+WLoFDeZd+mPU29TnVkK1fp2r0Dq7G6+eLTIU8lruTUgiGs3Y2YY
         edzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748269190; x=1748873990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPZsjHJP8+qN9iJVyhMRNNNvTGgEI/GLHNRsj22ggc4=;
        b=OfZHRbd+TscLyLmmZIUe4Y6pTfX86pYK3GtX24ONC7FFsZRUUM0F2O9lsu2JUQyPbw
         h5UVkoQJaBDyZOd0Hv/+wwxHU7drah8DaXXMGxh4IELWl2wMPhpm6IUvxQhOUUh1AzYA
         vpX3y6xKk90OgOt6AhS3/xe2Jqyts+1q8qq1PTEE1EUAwPjjzho+0eOerFlYjR+Tl20I
         TjxllKbqEltkBrs2BH1QgIVygpYETzYlSqU0m0lrhm5uwwk2dsb39tXLEKeCSI8gCRiZ
         Dr0c3zGOTERK1P+P/tve0FMbkXwGgSdPCG04KToYW9nx7KLxlwt75QN3uYov9dT3KVw9
         DZKA==
X-Forwarded-Encrypted: i=1; AJvYcCUiK3FAEsPK0upxgnNzelWnMnYXP/aTWdoi4XrYe5v62v2bP59qZj6fHXNeOSdqm0jLZ+wVY8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZRGi/Sv9PMe5oYaZA351taSEFNvExG1xC7Ym9dl3cLxose+b
	IddEvH6PugHKyHuYzIYAhZbSLHAjgUcFCYJTCQPEFVWj8lxlaJ9WHgs9yUiEFLkaTINKczfOli3
	JBw5nXICS2OoguST8nkmhOrbBUNBLhOA=
X-Gm-Gg: ASbGncvOfpL9lwJeGDbW3+RNvNWKOKJ7TM89pq8VOCtyqE7Ku+c5H+R9cXP33gCK7Rl
	B068rutDrJEltkaMRwRSIVKt4Ej5mL8xyIOk1m4KSwk8B8fukiarakHaf8GnIvFi4EDXLv+9fDf
	/GAH6nx2QlROBaa/LmuW8CYA6E055JSert7JVNRCzq
X-Google-Smtp-Source: AGHT+IGjXEuX6gp5Puu8K64b5FIOY8mVNMUcKhbK1MtNBaCQfAHA1YY6beoSPhJTt6rJZQ4riMgn75a+gKr4k6yB5tA=
X-Received: by 2002:a05:6000:4383:b0:3a4:d5e8:e33e with SMTP id
 ffacd0b85a97d-3a4d5e8e396mr4230466f8f.21.1748269189754; Mon, 26 May 2025
 07:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526130519.1604225-1-dnlplm@gmail.com> <CAFEp6-06ATV_rh_KWvjgNoiw67WPvAE-gF_gU-DJdcycDiYVqA@mail.gmail.com>
In-Reply-To: <CAFEp6-06ATV_rh_KWvjgNoiw67WPvAE-gF_gU-DJdcycDiYVqA@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Mon, 26 May 2025 16:09:26 +0200
X-Gm-Features: AX0GCFvMgV1zDWgJLvbau9slHdyRsphNwCIIP4EFHjmyMBzlRRGWPYOWQwLstus
Message-ID: <CAGRyCJGESxV2M9e34dJw89=0NFt0+hrXCOCW=MaYdVfn42DZTw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Slark Xiao <slark_xiao@163.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic,

Il giorno lun 26 mag 2025 alle ore 16:06 Loic Poulain
<loic.poulain@oss.qualcomm.com> ha scritto:
>
> Hi Daniele,
>
> On Mon, May 26, 2025 at 3:19=E2=80=AFPM Daniele Palmas <dnlplm@gmail.com>=
 wrote:
> >
> > When creating a multiplexed netdevice for modems requiring the WDS
> > custom mux_id value, the mux_id improperly starts from 1, while it
> > should start from WDS_BIND_MUX_DATA_PORT_MUX_ID + 1.
> >
> > Fix this by moving the session_id assignment logic to mhi_mbim_newlink.
>
> Currently, the MBIM session ID is identical to the WWAN ID. This
> change introduces a divergence by applying an offset to the WWAN ID
> for certain devices.
>
> Whether this is acceptable likely depends on how the MBIM control path
> handles session addressing. For example, if mbimcli refers to
> SessionID 1, does that actually control the data session with WWAN ID
> 113?
>

yes, quoting from a QC case we had:

"There was a change in QBI on SDX75/72 to map sessionid from MBIM to
muxids in the range (0x70-0x8F) for the PCIE tethered use.
So, if you are bringing up data call using MBIM sessionId=3D1, QBI will
bind that port to MuxId=3D113. So, the IP data packets are also expected
to come from host on MuxId=3D113."

Regards,
Daniele

> Regards,
> Loic

