Return-Path: <netdev+bounces-249842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75107D1F0F6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C9E3014BD0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4039B4B0;
	Wed, 14 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GlebQonK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3C1FDE31
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396821; cv=none; b=TSU0sQ5IG4dWc666fRsoDUKOZJq+IXAo6SStZFc2kdEiJbgQvTQ9hX6ZMtXVUWCLrPrl5tJ14K/69bC73wUWfIVjKX7GHl8AJFGw45ACEvWJoNrJUH5WLDS82oSGU9H0UTtHma5myziiE7CodVaHejArRL8vuZ/y7YXw+T8iSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396821; c=relaxed/simple;
	bh=tXOp5Q+91Ev71kEJDwNUHqTl/QTwmM0CMtRXuMN58II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es4PXDKi1uNty+1pc6M438JxMnvh1pWVZ1Ud4LvtJlEokgVqdapPrYaUcKtoa2NKZV2c1p7wV0RDqhbtd01ntIi2LxSOLfaaEualLIVgqoTNov+inUxSHkkAiuwFNV/SvTinfKiMk/B0U6JjweZdakLZNLZnWW8/gnB8Mp6gB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GlebQonK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305882so4735618f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396817; x=1769001617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=GlebQonK1BdB5DbGUyi9LiHoN8EziU92CFCkVI0QFOq3zEhwH6N5lbaRdR+rY/gCBJ
         Fg2NFXOcXLM1sjMYh2EL+pPASArlb7dn5JYQ7xAsAHxn9ooNPyk8HFEWSqJ0AKiLb8Jy
         OQSWVcr/+nNTLUeQmGlmWpTFmRkrVv42YP0mJNxo52tq3Z9CmAHgnisMw8pXZTj3j6iw
         W9dqlfWz3lgvzZ7jhta9fOBYyatVRtFEe5eB3muxZaEykIAOGsy8r+eNHdfFZhS6yWUF
         ROqkPhLwPP8lxjeZu4RqCxL6fdAD5MnzbZZlLD2XpYbBoT63LePeeYvof/5bXqQB6xDM
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396817; x=1769001617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=tRbSAgGx1heCSO6DWj0OuIAuopGYXNmmqNOezo1nR7tNOJLcsbuthw2ZS2vHFTsVCI
         BCn4WDUJz8I6xJdmUn/vwuMr2shAFVCNt+r8anNABuG374q4msIDylahVjTmQNzFeYuT
         KYILudX97F0d+HahV9stIIV9s3TubRqW4SeI7EnlTZ4Amo58MijTJ7sGNwbdEsvPjY5i
         IhFY4P4eEReDqJ7udgdEK02hX1p/FpSdgSdBRh1G/+MCyU63pYCkJAaXfI8YYzkhTF16
         2EIrAnXd4Ksymm+9QHZHXhbjGyGM61RY/TTaxCr0qMW7g0NFMp20TsQZBOzIp2GRDNBi
         DGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4qpGGd2U9wNCQ4Urh+UpDpQ8teIzLYGfDpnS3CTCFjPoSdMrV6MnOa8LHbWKPmaR7PbyZQTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwHDqKhWO4V/2JZf1H7XbIoiWzvlUO+H2OdUsgcYGzBTzkvdqp
	QCRQLHzZysS7COSN/EShBBC8p7DBRYVHC8VRIe1zVt2cX4cgJDlWprdAlwGnpXhTFpk=
X-Gm-Gg: AY/fxX5i/jShmf7mPEVQCN/cWRqth2UgOHdZErmZqHRpjoax6HgOl1bg6UMbAlRPbV/
	XpF+S+ru/uwHV3mKAVDkDgZBO1l0WJgTNebJ9Ty4n6JL/QeFkoBhMQ6uVN28YCakv8oed/IP6Aq
	4MBKrPXf6h9euc3tAHXS0MYvvhx9jiyg3RsUx9YDBJZ9oZpyMSQKctNrae40wn47pfZKzjOWkQm
	rQTDixn2u9MBtQ0BvFUA7bniA+H8dww/yK/CbZWnCIu/MRUXIubNqRpDPFf/G+WZ3wbLHTRumjf
	mezV5mgRYiAptpAHtwlJagi/CK+RiTrtkSQLhDZnaFr6EevfdQxY3eUohZOAys/G6BRWpf2pRqG
	98Tnhxu9rsIYWhWXMVvqYmTnk8V1mdZ0kOtWlMN0xd9NIyv2tEpk7evFCEWniyU2MoZcbnbBAH+
	f/aWAzGoeu1BoMsA==
X-Received: by 2002:a05:6000:2511:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-4342d5b2ab9mr2581603f8f.24.1768396817421;
        Wed, 14 Jan 2026 05:20:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49153435f8f.4.2026.01.14.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:20:16 -0800 (PST)
Date: Wed, 14 Jan 2026 14:20:14 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume
 functions
Message-ID: <aWeYDoMsdBNkJEqO@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:12, Marcos Paulo de Souza wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The improved comments would have helped to understand the previous patch.
I would either merge it into the previous patch or switch the
ordering.

If this stays as a separate patch, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

