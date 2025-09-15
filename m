Return-Path: <netdev+bounces-223074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E47B57D3F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC714C060C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58585314A8D;
	Mon, 15 Sep 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGd85hzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E1313278
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943128; cv=none; b=naHyMAP/EKvGarAdPHNs/j0pAx2QmzXvGQIkgg2C4JnyZw1HRF+NwHxOCIHyjE2EUNwVfbunJq1+S5vfxnE/y1HRYjE20INE42tmJoO2NFbvuT8ghGx69ASTMgMXsKRYOiyHdBzqYiW5Gnsq4zrqt4oqNrJNs/XTB75i15WGHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943128; c=relaxed/simple;
	bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBNnXPqMgXVTm/fOpumCkTl2tzGXzlnw4xih81NdsILe0XnVf+cAG7hEi/S+yU8Iuy0zBCNeFAqI8Nj1chBAny55E18F6xoTuVlOW3Z0+4fxx/Aj8OEH6yOFl3wxASS6HG/yxPIPsBlOsgzx9Sn7MNqu5VHuqww3rTpVl6AZxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGd85hzs; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42401f30515so7496145ab.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943126; x=1758547926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
        b=LGd85hzsfk1nNzH7s5/7tXTpCxt2WY2llck9gqA8uriwATDcJoevE2S1g7DJNZkV0c
         wIxxHySlgksLch7wSGFUoNlqEsKOrasxoAKg42NHoOOMEC7lN1sVfWo2c859AG6wVB6y
         0G8txQuWYZKmNnOtcVKr40MzqKdfGKi9BmjWpjDID0cTwl/mGYObCZh/5Q9EPRrKoCrD
         sawUwWPruqZHUaxqEz+y5XQzFe6mdg6WsSiPkN48ofpYwslpGct+ZD4+bRMz61fy8+iH
         wJ07WZcPsOc1T/eCnB2wNl5827rN0IlUVlj6WGUUssuuQAn8FtjxenlsNvStJW+OzC8a
         Lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943126; x=1758547926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuAfAE/DQ6C0D2lXfJ9FEF35Ereo/GyutU1m8Vt32xM=;
        b=QQYsqCwXyAuDSKOnHLGeN/GxuKeKw0yKbisrTa58gdfCBLcCv48YwjKJXdAirhSlDZ
         tEgDoPoBG/pGBS9DYuoKQ6Osy4jW30coDI7mG7FMBJV939Wa4ajX6xY3diLIrSHjbrR3
         p+hUTtjVlPn5hisFT1qH8aC9t1RXe23nKK2qm4WCZXilkUf4cjNjhcq+U7RbvY8SCa7B
         b0nTx8WLPAqolSw5Spuf37YgUtTtP4NkF0tegh8QQV/JdF+i8eNX/q32Hq97TsZiJQay
         pl8dByrbIZUdwsu0FNoN9gbzz4IGkabAnJ39s0HjiPaQdFp23HYT4cOGlrHJTzlS1ZqL
         PH8g==
X-Forwarded-Encrypted: i=1; AJvYcCXooDgpFiuZHyxsUjPTAyq/9OWVnTVHjCF0RDPV6gIDYKSfFGc6kSdyBBJJG4SvbeHX7O6KWto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGkuID4jmfrlo6xFx0HsVSArRiAXM5Bbm2YX2Cu5aoW988RMb
	c9KN/eszm1L74wK68+aYOM3i4zjP8zYpJ/CjeyoCHrP2nOELKrQDz8OTCZaV7JMMAkc0VH2i4FQ
	XPDVSqw61HwT0yBb7tjvXaYFvvE/f5Js=
X-Gm-Gg: ASbGncuerZEv3MdusZnDei02tatWMpTOz/CmOwavsfI3BB+UYyS13VM6Ngmqg5FXZoy
	dWg+mbcGgrkRTIqAFRxsR9qoNM+iDVSe1i37rqcbIFkhE7Pg8MhXbG/S+lLYjHzPdy2Bc9SfCMY
	wLdDu/v8SzX+Zyc4ojx2njW1Q1dGCWk4SQxufWR9ls0puqy1guxsz7GU6QfK7kDYPK1jCX8PC/k
	Cu1Qw==
X-Google-Smtp-Source: AGHT+IGam6DvCP5qsiaCB14TjREG+7uYzPOTczFKePk1aQFZiI0UEOoWy07XYRuywR01Hd1k0m30wxyZJyBQaaHvyQQ=
X-Received: by 2002:a05:6e02:2168:b0:423:fe62:568a with SMTP id
 e9e14a558f8ab-423fe62571amr51750835ab.10.1757943125603; Mon, 15 Sep 2025
 06:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915120148.2922-1-magnus.karlsson@gmail.com>
In-Reply-To: <20250915120148.2922-1-magnus.karlsson@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 15 Sep 2025 21:31:29 +0800
X-Gm-Features: AS18NWBhZh0TBZjUCC6NY3tqZ2Dcwk953fVOyw0JO2qzZ422l706jJbh5z-mOfI
Message-ID: <CAL+tcoCcTuD_usfbpQWn5Y=rT=Kw2iu7kze2YqqP9V0AzjXWRw@mail.gmail.com>
Subject: Re: [PATCH bpf] MAINTAINERS: delete inactive maintainers from AF_XDP
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:04=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Delete Bj=C3=B6rn T=C3=B6pel and Jonathan Lemon as maintainer and reviewe=
r,
> respectively, as they have not been contributing towards AF_XDP for
> several years. I have spoken to Bj=C3=B6rn and he is ok with his removal.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Oops, well,...

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

