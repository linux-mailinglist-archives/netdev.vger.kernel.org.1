Return-Path: <netdev+bounces-233781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B8C18415
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 05:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 180D2350AF4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AA2877DA;
	Wed, 29 Oct 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUrGlVvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADA285CBA
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713299; cv=none; b=bbZJlzy1/NfVwfE0IFMrHHwI69wxoD07gPOmhOZmUhVsqzidJdR7jhlyokV1ry6YE7vuYj5Now9AO85zjM6HvhEC77WpDk727J7Jf17IMUst7wn24N6hku9u6hMOY+pW4iZVbSg+VPhbYqdweQBekrvykAj2zdyJV0gtj0Dnj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713299; c=relaxed/simple;
	bh=kHz9dCjzGPr/TBnbHcUyEuqYu5rhLLgZPHHmF3a5zR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+9f2AFAc5nx/jWW1Jh0sAs1L5XU/46wtL7Sc94hF+STQK3XrPgn6bRWL2QVygTbu/YUFDTdPgLWYut0bPaHA3ijCiJBY37yjVL7j0iyXis+PbGOE8+3YnBgezGqUGgJxKQt303Xe5gat+EEbL0WySfIyd4ggEka58j5+skeJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUrGlVvm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so13148207a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761713296; x=1762318096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbq9nt56FgGYWix4HcpRFcizCDr6bw5OvUlM+bYyv48=;
        b=aUrGlVvm2vWzoIrD0vxd0zYhoYI7uh5FT6ImD5xYjkC+Y9Q9mhbrfd5169hZwnmd9c
         Dw9v4HLVoD9afyO1zoUZpD553SkWmbl1pSFAvrkJQ2VJ3ZSr7+86lJOq+IigG6D9D4SK
         szn1bqMYU/eKKYexvV/KdPAd8o0rX36atASg/e3zDZ4dgj2g+vIIe5Y9Lx9Shig64Asq
         6yjYU4swhw7ramNsT5Pq4ZwDU5Yl5KiMRCn4RKeKD2HUQmkXE9/2bB+OMbSxGSojykTJ
         7wd/6l1Uvf5YkLnvn+xUxvc6Wvu6ZwT9MJXgaVpUNEob7Y1kLoOsATsfQEaNUNwzXWp6
         AD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761713296; x=1762318096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbq9nt56FgGYWix4HcpRFcizCDr6bw5OvUlM+bYyv48=;
        b=ZxwrNKCbMfOe8qnkViUE+GQLUPOAso4sTndiYiyJ04vT4xbTl39TtTe/6DfKBj3um4
         QyNfqN4MFMEYizEer6xZPVMU+nGg+KWH1yf3d9laIyYmoU1Y2I88DGiNGrDJzqj19BhK
         6rzmIKCe54nL7aJ6iekK3PfjqtXJihqViTo87oPcMweaEEWuaSqYhIwJ99dRdABiphlN
         SyNInlJqi86TV902YjF200xYZnz1k9OpG8CRRI1PqstRhDyzeXcTWTTnBy3MQhjgGUwb
         +t37IkTBvDKJP5H3NO2Xx2cG+0sidpMK6eO8SS4Ybcwj9SLO0yzF2BKaOCdNx9J9ZaMA
         12XQ==
X-Gm-Message-State: AOJu0Ywl6e4oCIaHawznZMxSpOW8bVRYJOF6g+e8nY/Ba51LCs5hRF84
	j+/Dy5sSwGZHpooseMA/EpZ40MjLsdJ/DufTw5RMN65/BLD7D/4EJ2LFIuKuQqrSGqwwzRgYi8O
	KcVZIn7ZYjD3b1Gk4X2OQQ0tpTLahDOk=
X-Gm-Gg: ASbGnct1REE8ooFDhSL68nxPDyrBuOylGCFDWGHCF/rwwC9TycGCEnn0u5e/BI7jZMC
	SuX2fZUMPI2IecfCHlDS/apc+Miyb8QyFBVmUjKsogS0q4pbPIjarLElWbb2y0SRgPYMmzG2Tvo
	RBhYvwrB6Fc26PJqws7Bd6X7Cvv30NPqxK9rLAc1PkKOy56JXI/ZgEVYRJTuYVNWDYc5VvR7fMz
	0JumqCcP6p5c29lHy2kyznsjm2rSmDaB82+sjCzgR/MOiGh7zos9ik47BpvBZ1Xe/cYnYqScbqj
	7ku2/aiid0amauYaRsrkUo8JBzF0Kbn3Z9jlzd+w0Q==
X-Google-Smtp-Source: AGHT+IG/Y3CfWbdVX41gQBZzCyhI7Mz/jKAEDyoSdZ9xeIABB9XbwtrOeNPc5GqcWolvq+reBSqHpgCJ1sBQNXdIxSM=
X-Received: by 2002:a17:906:8a54:b0:b70:4757:eaf0 with SMTP id
 a640c23a62f3a-b704758054amr7191366b.44.1761713296230; Tue, 28 Oct 2025
 21:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20251028174222.1739954-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 29 Oct 2025 10:18:04 +0530
X-Gm-Features: AWmQ_bnX6Xg8VY3oeRVLdkgI_IKLI94gd2JcIj2LeqnuQY3vbZpxM7rRQ_Ai5L4
Message-ID: <CAPrAcgMPFnypR_zczpCbrxN3h9grBrS1WhH6u1bJfO+H0UjGWQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH net-next v3 0/2] net: Split ndo_set_rx_mode into
 snapshot and deferred write
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, jacob.e.keller@intel.com, 
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,
     I forgot to cc you on the original patch. Here's the link:
https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

Thanks,
Viswanath

