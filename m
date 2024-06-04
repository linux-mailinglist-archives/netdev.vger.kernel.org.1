Return-Path: <netdev+bounces-100744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D58FBD6A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597A71C20A56
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B814A09A;
	Tue,  4 Jun 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dHgVnqcH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B51487F6
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533365; cv=none; b=u6+4bJkCARvXtuuauosz9kIwsLdnqDgOWM5aAQQ4AvETnD1BDQDhEniM8cYDOlb+Ty1qjUM2Lo7qCNvbdrNKo4Mrl8cHIdhlEjgYOAQ4cQgqr2KAoGqJD5sc8sM9iGZjZPC9sdgaCoy45UMeQLBcFicBFiei0Mwydpgs44sGE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533365; c=relaxed/simple;
	bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXo5trDsFjPoYELjrWPqaDgbyt58dz2JZ3CyglBiFgkl690h4FkqxcxQXOCgmlo3sUMkzJL0kE14eSXtchIhQNRUE3hKIWuIAELnBRwYxYtF0aZF9xdF1R11bmYN6Aw6e8nlFPggUfHKxGhZJEnKi1MIiIvKRY2QnNxYKjkIwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dHgVnqcH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68ca4d6545so42327566b.0
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717533362; x=1718138162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
        b=dHgVnqcHFrnRw5sGe4aUBURDzoRUGwc1SUz2affHv/M84UfGr7Nl5+LlRV7eo8XJ56
         drufYjM4MRh3sgWsoA/Gx+ls3BksK/Qy6r+kiCCgZIS2C7vw8on4ApZEbNZ7byhRwK5a
         9ds3zkZ3jO+Zz8PvygQToQqRpPTpPNmT5hfuUFXiz1fR8YvlzEXDMqJK8PQ7xneuFb6J
         XuySI0ztCm+GYc7vKjllZmyuINN9Fwlm1902wLDwKRetpNBByqCeRcewnybmTGX6x/S8
         z94HL9PN4+aEq6guVoYNEIIjrwD2i0V9pd25qcNPXedBcvepr4O8tEq4a60TELdVuEul
         a5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717533362; x=1718138162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kw0WK4LgZ2pBTVOQHCU/y7rL+3v5EE1TW6bU6Qi7vFs=;
        b=q9CBuEY6tokEVTIgwa9akP39v7hHbcj+NZOwiYD2ESfXqg/uHHpRM41ASP78gtdDgv
         6vtm6lMwsg+CmnjUTWbft5pJvyAF8cvjbHsOD415Dlab+hc3vVCRV7K1M6ByFOPXbtZG
         EtcSU327yDvMj9nmpX07ed7vYcVcKIgugmNCxqduDdn/5YfDvC3vM0A2lGk5sYETsUN0
         DJWs95XDxz7rFTsmvn6xezAoDFqeYJbJ4aIxL3iqzjIjGAmQbaXBwYEc4UC/+CjIHSyX
         J/xlim2NsWyojmZrfkfY6r2fMQnNfvxmfnEPBFAHefPa/ezOoMipJVQEHIVU2NYk8dgX
         EItQ==
X-Gm-Message-State: AOJu0YwLa0eZwW/BY+11ARCjKHsgk41q4E085eC5b5nPcvxk+HNZrVxM
	1iJCCJXtm+cf5o3qus9MJnPI08fLTAawpCUpG0faFngTdQ+EXL+1uLTQCgaVsUFXjU28UOs3og5
	sdS/y47nkKKh0+CNMSynvxLmY6uNyQP5wkSpXlQ==
X-Google-Smtp-Source: AGHT+IH47JnZhJOybQc5gcJ/AwMiCtPanTsbQ/2dDaHpwnspzZp+GkeP2c+vghvxW2lkT/7SCpOhkoDPJTPhwbk8TV8=
X-Received: by 2002:a17:907:601:b0:a69:20ba:43cd with SMTP id
 a640c23a62f3a-a699d63f706mr54310066b.26.1717533362584; Tue, 04 Jun 2024
 13:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717206060.git.yan@cloudflare.com> <b86569aac8c4a2f180e7d3e22389547ff2e26cdc.1717206060.git.yan@cloudflare.com>
 <20240604151855.GT491852@kernel.org>
In-Reply-To: <20240604151855.GT491852@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 4 Jun 2024 15:35:51 -0500
Message-ID: <CAO3-PbrC3JkKO8XMouBrZ44JT+5WmErSCc37vONGVftZkqffgQ@mail.gmail.com>
Subject: Re: [RFC v2 net-next 7/7] af_packet: use sk_skb_reason_drop to free
 rx packets
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Mina Almasry <almasrymina@google.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, David Howells <dhowells@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

HI Simon,

 Thanks for spotting the problem. I somehow missed the test bots
warning on V1 for this thread. Will add the missing tags in the next
version.

Yan

