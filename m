Return-Path: <netdev+bounces-171788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B3A4EAC9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7617613A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C427D78D;
	Tue,  4 Mar 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5GQj2rz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080D25BAB9
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110397; cv=none; b=XZqDWjKXsL1piZWLd4VapTxgKRtjwIQt7b5yojf8CnkwDCzuGT/iBRAc/l3zA0LTX9BBxumkrTdspxGm54hr76ASYc6RqLXfWnk24lBjwLIBnETwzfJeXRpvpRetTvHgI3kMzSgH28JHMW3Y8FlBbSpZpDmHMzcbG/9m8fzUT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110397; c=relaxed/simple;
	bh=O6VWdWUqnMGN0+Vi1iLYH/MfWU6VCuSN6uPKJvHH6d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K11bmXF5LIalW5GvDhtokJK+VtlRaUCald9FX+ok24HJjLvv4Manb42EfX9APro6BGTNuUizqQASK0P5SYobTwC0MXrc+ELVNj89FtssC1yPfILXZQyFg/64spaoq/XZVpMGI0QBcMCvGlX8GyiA+r/gahXua09rwfq8oPWn/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5GQj2rz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso136a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741110394; x=1741715194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6VWdWUqnMGN0+Vi1iLYH/MfWU6VCuSN6uPKJvHH6d0=;
        b=R5GQj2rzAucKknD2yb/6n1lxXcq+QdEKksivwe2NDt22awfgpHQfxVPc1C7u2oe3cJ
         DkX9m4IfADdRiYp7Fxh6C6BJa8dzeSfLPhKM5b62rwrozKpOqeWnVbVMm2YU5BMuFG1n
         7F427PreZTg12XHH2s62HV196/zfwk71Tup0AICz+huWCYMK6PLzXvypC1uEevsGbwpP
         Seva/oZicq9/ke4nhxpNR9aF0UZZhlX8XnR5/7p24zPLonlABEa0EdqZnIwAkKvXL6Fz
         LKCMRTWb1HSfp0txDfgqpfXNHxxPPYZCn0VpF9CVC9ZQw+1Y0KXsum5FBi29j6TzxGp/
         rYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110394; x=1741715194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6VWdWUqnMGN0+Vi1iLYH/MfWU6VCuSN6uPKJvHH6d0=;
        b=Sp0ei5mx1hNm8sK21dH2nedqqlWnSJp53iPCixvdHzFTcdTRP5I/aFP6iIpFW61UIg
         FsrulvzJSNve33HSZhfMLAnxYbZ3m6yXkFRfTStPNDcM8YM05IJGG0+khwk+VNnW14rV
         ob4TxZ6ZMuxPhwbswgxrplz9P/9+KqO3EdmB1KqIjLTZ7u15r63hmzagrhlh4ejOYLdP
         QVfipcVWsbvkccashCR+v0M9yUaHfAQPBysOzSQC6fnJYFg5hdVRIpQPm7pA5TuO0lpL
         heVZlPzGqIGVCVAL69ommswdNW/3UdMBm5+MkIEzbS9jfX/lnooxIRibTeeN9hCG1PiR
         9OJg==
X-Gm-Message-State: AOJu0YwpoBR9/195k/P7MvvHH2ifF7FgejbROeKKWJUmwoInaG33fKuB
	gJyXV8tJH46SRjFkA7ExhJzH/tQ+oozJH0keyTesh+Sw3lO/5MLSvZIgSDVzlg8QWQZGC1ERfA3
	+XIY0xhx3CAWQ47k/CdET1zbIWrD+AXI8+E0Ep7OabH+vfmNB/JOdZRU=
X-Gm-Gg: ASbGncsJGgmcjTHDyEbGa9zK51XFTwgbKBmjzMDAKP0d1B4s74cOu6ROWZioAr1g0Lh
	PDHiyca+/F56G06QDyytFM6va86pFooEvood/zs5SQq2Q/2eXRI0I7awsjuuVUyalOk2+NFx7Gz
	vxM/kb4uUsW2iGjstvldRfXz7m/cg=
X-Google-Smtp-Source: AGHT+IFhjmXfe3o60QbooVrEm5ZuppKWnkQOLLdUm2uN4anQ0HTxa6deTSHczhLhYsD63cOvc9es12sJy1YDHLhCRuE=
X-Received: by 2002:a50:ed8f:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5e59d467c7emr18157a12.2.1741110393684; Tue, 04 Mar 2025
 09:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304003900.1416866-1-jrife@google.com> <Z8Z1uxRd_kNO6Ibv@zx2c4.com>
In-Reply-To: <Z8Z1uxRd_kNO6Ibv@zx2c4.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 4 Mar 2025 09:46:20 -0800
X-Gm-Features: AQ5f1Jo1LJgzL6fz2qBW6KRM9L5CK-Rmzx7CwCzqkl3m0m68Z_iCROdej4lA7zo
Message-ID: <CADKFtnT1vTsbh3saFfeWkCL8ZnjL1-BRkcp40D-L8+DVd8G1AA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	wireguard@lists.zx2c4.com, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

> No. I'll take this through the wireguard tree like usual. This patch and
> the wg(8) patches ARE going in; I like them a lot. I've been very behind
> as of late but am catching up.

Sounds good, that would be my preference as well. I assume you're
referring to v3 with the wg-based self tests and everything?

-Jordan

