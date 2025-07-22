Return-Path: <netdev+bounces-209126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB0B0E6B3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F961C8827B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592BF280A51;
	Tue, 22 Jul 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NQbMiq6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F44C92
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224624; cv=none; b=WChB8woJ52njxfyJ9P/MVcAP5jEUMnyyxVYROq5ymhIa/nO886GOvB04tZZAoO5Q/nLAevxzN9MwtR6zoATJQMFVPGGpO4AOJGRtZ6KwaHXYdg1EKBC3KSGPbtLjbnBAD1MTKLQrLRrj0+AUzKUibt2oaxZP2njolc6SgmIqoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224624; c=relaxed/simple;
	bh=enAcN10mvlsFzRAtxkyXhmWPR0Xzn/abi7ke2a+kaZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwRfuVXvBAHRNXYmWE858I+nFclNy+hfqURelqWVOrk5DhZwqWT4CQ8EG2XpYF8rZ7MV/wNk+KovbGwrPELemcsq3MKtkJq6U0y6IoZ1fXPkMPB1wV5g3UvWDuDV8JV8aOFU9lHXWGDFZriZ+/TosogFWz+N8VlM7nmZ1jLOp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NQbMiq6r; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b440afa7so56365275ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753224622; x=1753829422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/vhVxMUqtZpT10bNo1OFTBNDsTJRyeeSF2rb6zaHQk=;
        b=NQbMiq6rS1PHp8uFj5vixSvo4cv/a8Mao0IFy3pq3zpVO8EPwhUFCy22i+GAweZKa1
         pKgok2iu/x4hOFuG+0q2fX44uvKWxYcFlJ89fu+dFLQ4rV5lxLS/vA+KJlvJ+m288rEV
         DPRx8qRnL1LZvH33+4oSJuL6Z0GzBww96ZQi+pg4tY7/RWWXsMTHW5NTwMXB2L/Ll3RZ
         5Hxy8mO0yHWYuyX+Aw5Lm+1yWWC92gBIeLnLi7fajWCiTAApK4hE1BXmnt5bnmQv+y1o
         nxpNQJpzod/OiQv0nqAdzDSXWLFa93gghh++Rau/d0sr+wsmusjAXKvxf7iQi5Rlw55e
         x19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224622; x=1753829422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/vhVxMUqtZpT10bNo1OFTBNDsTJRyeeSF2rb6zaHQk=;
        b=O1tgqGrRGGXfCHVxZQaUSuh+OaLhMs1kIP4Q8IDvC1AI+gYUQ6KDTenfLH16U2eS5b
         MbMXHTMMQzH4wQCo3fPCGis9MYJGR39j6j14Gu6H7qge+g2ks409Ve8+/EmuUprFFfNo
         j3mCuO7P9BfxovKTtPKDHO/Yr+m8JYcWgd/5mBB9G/j7YLBXoWtXy4VxaH3dC6yX3tN9
         rVcSLD7LpQFZpve5HdCdxWGdTavxLCcHZ872I01WtRA4GRBnQ6uWslrnzFHY+6gzH096
         2IIXHxgSvdrv8Rbsul51LghHbQOyqa6x1eCkxZ/81NIrl2oeVKQz7ve9q5mjlnlAYdD2
         V98A==
X-Forwarded-Encrypted: i=1; AJvYcCU1l7jux4jqACF5bQ2nwgLuPmoX7BPe+4n42ZQarg97I5CpDJ77Jm7nK5Qy5PJAdC4hNR6sEmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DLAX2yA0qmLkmy2DlqZjO9JPMcfLE0tYNdt8zxzFX2FxGZcA
	cSyCIDWoIrcVC2SBNXCpMJ2hv5dBr83GoDmV5esa7/r5N4fiE4MWP0AYH1j5ZMKtNeY=
X-Gm-Gg: ASbGncsQgUo5tPL7P4NRnvZEO5zJHd/+14cnYFTVe6WhYnK8IrJD4O0uv9xakmJkhmF
	FG7jYOnssdk85vJew4cp+hYz4Z5CmlzMaCV6yQ126OTag1FiaSvmvSs15hgzt2eDG+jIRJ2+6d8
	Lg6gISiUVSV7xx/sqFXnLF//Tf6602ZDhmmPjzIBQ5qAUw7zZ2Wy45N0J86Q3lpxW4ensHxEl5R
	5m9iUhN/t9HYXd6lf+J75ROt763NZasZ9gPqd4gd3ykfbuDNrMRX+YOmy/OpP4GGYJi8sD66lYk
	1+x1CZD8IrMEgw2FFiVeI1+GPWFNMZUraG1rJY0RDYcirZU7QZLfxyA8cCT6VnCFtAUa6W7HLpO
	QOiC8II+6FrSvnH2MA+X7+IwJiKHFUhfZIjtdNn3N741qkvgxG9YboMEzg2NrnVAyqztflmyrt1
	OtMJfW33mGBQ==
X-Google-Smtp-Source: AGHT+IH6QdqHikvWWWFS4uMo5fel9o4AvXYJ/Ulv5jITj0xamrgqfX0KU/9j1DVayEGbpYtj3tpDGw==
X-Received: by 2002:a17:902:d512:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-23f98194d3bmr9282545ad.27.1753224622089;
        Tue, 22 Jul 2025 15:50:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d199fsm83474425ad.134.2025.07.22.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:50:21 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:50:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples:pktgen: This file was missing shebang line, so
 added it
Message-ID: <20250722155020.6f73f632@hermes.local>
In-Reply-To: <20250722221110.6462-1-unixbhaskar@gmail.com>
References: <20250722221110.6462-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 03:40:18 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This file was missing the shebang line, so added it.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

NAK
This file is not meant to be executed directly. It is sourced from other files.

