Return-Path: <netdev+bounces-125207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4306396C423
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF410284C7B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32DE1DC07B;
	Wed,  4 Sep 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xOdbMBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC961DA319
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467469; cv=none; b=AQb0dfFNeJDwbfcawLjDfgO4Pzk5YHytVJSEn/oBMXCBZ8muNNfbvWg6Da0xYHxbb1GOSnTvdob+Onrq1WRSace7a9MaVW34EymdpftzKlZ0EuDl0YfDEEzUpajSF2T80gXI03TipWHa0sYo6jEuKABkpr61xz/9wYQWnir29BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467469; c=relaxed/simple;
	bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAz1UsS+HsaS9q2NxwCovdFG6XNiD+dZzOSLHMDzApKBSBDpaanil7qIZXVFcaPa8GJueZIb2GGpQfaoNgAnkn6XPQLsh5ir9kehVtsxTQ2ksngW3qMj92DkMKgJw7/mxgH7X4GYt0Jf318/eFOSW0MfCvy1rbZtqM3vfi3ReKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xOdbMBA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so1994914a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725467466; x=1726072266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
        b=2xOdbMBAQTGo+KtqMgR5Q84qR8QaCy+lZZ77X+o4B0/YoHWTjjFbNvq0A94QGhZrG+
         uUOzLWBM0c/HdQlpOvkPHvRGSdR5mrId1wpC5G+QvcemV6N0PDyPA03nHJwKmGhqcPZk
         qDM7oiKatUsHoQvU04WA0ABoOXLe/rUww+k1tdqyVIrGO96q8fkYf9bEQwUT4aGm5Zo7
         M39SWMatMF32oSVm2ZOS8oM2W6bmSYl3QiLpX0hL0TJ6n0SxDrQlCjJU/wMKspQvC7PZ
         oNlDUI5p4ILkunwlx769nX5p1TJBdOYT7IeFYff+6kGlC5IRhTYDWMy6ZWhEC1/donzN
         FIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467466; x=1726072266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
        b=i9hN6EVE8gojluAEXqeOVno2lzAGH38PBU3OrT563ZL11dmqGFdDgyIE82+NsxTdfV
         KhOPsWZB+u9yniP0GYSlm8wb5O0oj6tPG3VTjrHH6l+C4egj8bgywyQzi7bM+wgOoBHe
         8H3fxMzg3EaxgpEhOI0pw/7ukHI1i8A2Nm5Jrhwr737Zf3vppunBLQQ7jfv4edYVnvDw
         f8HPMiUxzZ3O4rCQKeg4O5/rqA6sgsbU1ia3SB1ocC7uMHYBQkt7LOCCDIRLppirLCvg
         GmsCr8WCTG4ik7MUt8mrzaOfh5MN1xCppAYn1sgqSm6JA/H7n+Duqh/ycDoB9EudWcuB
         yBGw==
X-Forwarded-Encrypted: i=1; AJvYcCVrqIMOxzZ/zNAEoLcBGh+CSQMDreMNjwr6K3gQAWeEWyWsExgc8mw+MOBsUO0JK2VEohY+7f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxsvD45Fxxe070j0gzcKM6MUPOZtwFVK7OyoFpJ9FEE9V1/Ib
	xRGCaz78x7hWLEIhIzt5zP8tta2Kad1mA+y7fOL+4XmHVvj6jj90x4qc1uiwiKx7PUdRhsW/ZJK
	IKwEVROi+nKHJp/mtu5cKZin0gzAaagLCGlhG
X-Google-Smtp-Source: AGHT+IF62n2pBXCDxyXxkgckfOehREKGzP3yBwNSv6m+Is52LgdpPKWra4hUhuMQlWJrolmrZOd2fpYLEdlvpcFXArQ=
X-Received: by 2002:a05:6402:234a:b0:5c3:c530:e98d with SMTP id
 4fb4d7f45d1cf-5c3c530ea76mr1178119a12.30.1725467465494; Wed, 04 Sep 2024
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903184334.4150843-1-sean.anderson@linux.dev> <20240903184334.4150843-4-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-4-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 18:30:52 +0200
Message-ID: <CANn89iKJiU0DirRbpnMTPe0w_PZn9rf1_5=mAxhi3zbcoJR49A@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum checks
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:43=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> The partial rx checksum feature computes a checksum over the entire
> packet, regardless of the L3 protocol. Remove the check for IPv4.
> Additionally, packets under 64 bytes should have been dropped by the
> MAC, so we can remove the length check as well.

Some packets have a smaller len (than 64).

For instance, TCP pure ACK and no options over IPv4 would be 54 bytes long.

Presumably they are not dropped by the MAC ?

