Return-Path: <netdev+bounces-89464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634DA8AA5C8
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34EDB220D0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1C58119;
	Thu, 18 Apr 2024 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD73m/Tj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996652E41C;
	Thu, 18 Apr 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482859; cv=none; b=Yb1v+5j2c5LiBGba5Mdejmrs19f8Uk2pZvcbCIhn7KE5fGDlZ7m/rfHSBFCMdoEJExIAoF4CWxG7atVzMvoTh/vX+PG2JGTDSv95DtAYe5ImTMDEtx0w9L0QYoytX7yfXUPJjGNUXz8TUogRD7Ao0AKZ//qlbCVpbqlETBzEa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482859; c=relaxed/simple;
	bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq2z5GvNfmXDBKMYGhn1pfAdi/Cfeq5E7pPqaeJC/h8W6xFS+PVk1lzvd92hNqK35eUTwL05pWcYXrPHdL+WAmYC9c9XTjXDe4qBZw4SF9kuPRm2DW8zUU8OL2sWSp0Dhayz8EG8GbXlLUDeSVYhg98s4N/1WwSTEerbD0Z4Fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD73m/Tj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-346b09d474dso1350884f8f.2;
        Thu, 18 Apr 2024 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713482856; x=1714087656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
        b=bD73m/TjCeKZrcLOSReNKYc7vDW/lCilpyb5g1oRD/s2CR+hOqWuyn4eP5+YsW/nSq
         qAFg7dV1+6VJtZBjM6pJvKfzLGaDjC20Xot340pytAKR4vcGmXucbWuc9+WMoaraWkTF
         O9JcfGI05KF2AZDtNxb6ydGDdZZdyF5ORtgHpnPF6mIQdmCZeGmD88MNWBDgyREm2fT4
         WFsJl9KnSh3DR+Q92i4v0jQG4kID5qXfUjZEaJqJ0wFKLWoit+uD471HKgDiwCq/nm4X
         a3wJwYcjTeOK82y7IEIje3rW8zVqVbFZPPeTdJP61/I35O9f1DRWq0Fv7ejG8Ziw+off
         ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482856; x=1714087656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xizDYZulULm1cor7kU1CBg+oGHqLt4pe1urWfkCgvDo=;
        b=P4Ju2p5ob68fWDsighP0PNgr3AxqU8QNQ61NxWQZJNfecunIHGfU9ZFna9WREVOgcN
         z9ygxr7cSzm5aImXXEOsyC1PqA/cwG+VbpsUUOSKnrSuxEvyUc/pafCB0X7/pSQma3iR
         /dNkO8D7SokL83qZLJqOyq979SnvMho1Ysbox68uN1kXmUc3RmD7rl2D/hPs2p11X8BJ
         foHa9CA5nZ3+Aqa4mGZMIkeMs6fmoraVvtyLToRkrCCofDXlYWIlLza80Tie04HGjcH6
         AWIIEsjeNv+olgSkHAxrV3Q5Y8TNIwk/E63HglEUbTq0DJbokx3OrRLjSbtOrQ83kgLf
         gz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgygtx0fnH+VJ/AN7r6EYUdzyuNoF2aP0HPDbhwULjldzhKMAJtNV3LZcofsTGj8y9jU25SWSQFyFGaMuRi/1lxxz2UARcRivbExi2ffxLzI6E7vpHGPY55UnvnW5hYn67rJoFUc1cw11h
X-Gm-Message-State: AOJu0YzeHz0cgaCdkqXUa81P87hLKpMuBk8/a8tvOsuWK/LlWN971o+5
	KvDJ13NrulFkWgCACxnB5WQZBy8uPDVSiWsbHmuQt79i5ejDvdWY6U8mHpi2T8qXvTf5WNF2Ggr
	JsID3hCiTxqIM3W/ekFx0WiHLpfU=
X-Google-Smtp-Source: AGHT+IGx1cA9bIs5ny5tYrBbOqozFvluuDaWI9b5II0BFVbz7OLtPuXGmvlvVRvsL1YUhwViEmwaAfmQH3671sqJBLo=
X-Received: by 2002:a5d:522d:0:b0:34a:d2a:5905 with SMTP id
 i13-20020a5d522d000000b0034a0d2a5905mr261746wra.31.1713482855640; Thu, 18 Apr
 2024 16:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
In-Reply-To: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 07:26:58 +0800
Message-ID: <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> When I said "If you feel the need to put them in a special group, this
> is fine by me.",
> this was really about partitioning the existing enum into groups, if
> you prefer having a group of 'RES reasons'

Are you suggesting copying what we need from enum skb_drop_reason{} to
enum sk_rst_reason{}? Why not reusing them directly. I have no idea
what the side effect of cast conversion itself is?

If __not__ doing so (copying reasons one by one), for passive rests,
we can totally rely on the drop reason, which means if we implement
more reasons for skb drop happening in reset cases, we don't need to
handle reset cases over and over again (like adding rst reasons just
after newly added drop reasons if without cast conversions). It's
easier to maintain the reset reason part if we can apply the current
patch series.

Thank you.

