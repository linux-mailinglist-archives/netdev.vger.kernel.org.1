Return-Path: <netdev+bounces-212386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3899FB1FC19
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 23:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61F887AA1F8
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 21:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34B1F4161;
	Sun, 10 Aug 2025 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO7dI0Qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344A1E1C22;
	Sun, 10 Aug 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754859727; cv=none; b=g6/vG9JToQT0qcN4TqW7zZrj+NzDxJNCBdoOTZ+a6hJexFSXHisAxCjFuiZiakENb83USMCrQFy9mLkuENT4SzyTZKCkGJ1hRa2raU5uA3+mAHf1zRdTfthu4YBAao6UkF8vACWrtVxOffimC7d605PJpfP/PKiuTEnIOLVVUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754859727; c=relaxed/simple;
	bh=MTXpiQqqPMFlsP0/kHI84hBYDr03N6s0a9a8p8cA+js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rd4LPrSIYKym3K+cJHgFyvHOSa3IIG3wI9qJ7C9C+vlK8H2cQwpR+r4qEkEIWiP2IUzUkPvvg3gWpgWCu3J6Ju9k0B7FO/syltXZUqxlbPl9RMyFYERPaf4Sa8l+6ChuDidFyPcNqhK5ap0CoMgo0SOwOxnag+IfIVv1Gsw9PMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO7dI0Qn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78110816cso498942f8f.3;
        Sun, 10 Aug 2025 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754859724; x=1755464524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icmOYryH7gKnxyHk0FI5g2O7kLHyCbYHHIR+yF/LTpA=;
        b=IO7dI0QnhtNCXhswWlOWV+nnQY8DBw0Ymjq1fjDKjh5t8fySAYdx4Bg6x7pH9CNlxr
         QajpCTuMsJqe/6rll7keHSIwhg4xr4DPprsAjjbWhuNiAUYJXo2GTylI94PU5oemCcTw
         1K/bpgdi3XRsOKPGiwKdNt/T+8FQ8zm56ZDPFZCJzwP28fPWFdmK8lA6amxOVQhbb7n7
         my1Z1f9fFnQB20Nqx6YJdZgXDZoO/IAbDpr9fMsxyKtyPViVWjj474i95odvqY91ZV/Z
         AkjRvE4p8SfbdG+CNVbZed/rjykdwWkXe31iK5IbvIAUg9ljNY/t4FQo3Gg23ceh7W1B
         vqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754859724; x=1755464524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icmOYryH7gKnxyHk0FI5g2O7kLHyCbYHHIR+yF/LTpA=;
        b=UuBtWTSfzLe95MGu/X0lGiLWf3s9UwJLesGMhhVuSw7JrmdbtwvN2YCj5ITOOoZfsy
         /vWtHdB9+ZzGE1p84hFAls1t98X5kZCYrCvTDa4UsY7geZfW/GjyuD1onPbACNrTz2aB
         4iwleUNbN8P+uUoQirjzBcPVB7Q64NfDZjRXncZZYkNGDskAgF5BfpBky6vDD6sI8F2F
         DZR+xxnuLBiNDZqq0JziIj6eJ7SV9ink1pgQEqOD2+FY26Hhgmmix/H5j4iX2SBc9Lit
         jSKYgUquvmNxL4sErmwj55Dr3skrJgCS66D1OR/VCtd5oaetjvwBhgpLyvrB7ytL2W2T
         3ZzA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Th8xGt7WGkLO8PeTcQMYfTOYRyostoFHkaTvAIjaC7biRXgrAlaU1numazrw+TIjoI2bhSGp@vger.kernel.org, AJvYcCWRCLc6ZBsE7TlSGs4OkpXxl4YEU7dKhzOKVCoxE5swzXGBlx644yrLVLcldi+qruGsCTAR9Jh2IlvGU5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVSPBWEHZbVFT1aTUZpHSNFPeislQoyUtqXAypUEvks/DFStlO
	lMP50sWHtH/CpOfkIqBSmaRhNRQz3A8eb2P79v/gXJil9Dk18qLJL0wB
X-Gm-Gg: ASbGncuGYdxrr6B7vaSreXwaenHvlnaOrzvII0lD1dNeHPzqDf+/i3iH0sbMdNtdYhR
	dZPJcMSfg5FQCbmt2x+40gObaPVAD2CltuEr8hThBHe23dG692xxYLr821CTvfDEwxq2fjLomUJ
	r5Ze/LpWKNoO/10nxIDPDdUm47E3LxFF8H5c/UsQYoJ5i39WXC6K/zJwH2xBJAW1i4UF8S75cw1
	Bgg2UDrJKyqxJZPc/98ZTMIjO9l/PLAfM5907BX9V9NpcfFAXecymLFmjpllkg8vPSmpbbG1TLA
	H+/TAZIpLNdzHZ/TYVYNAmTRHc0AXMO/r2RvuXrHjJ/rtGvt6rLalpVLlUQAhndEHFxOXemJL41
	9g7OJuImxSRX6GY6n99vexJuGSQ==
X-Google-Smtp-Source: AGHT+IF3cK3YJXTrG0mJgB/AvVE8OALybbZ5XANg6amBb0MDC+vj2TUp0Gz/9EM8XFqZ8GvmvZoSfw==
X-Received: by 2002:a05:6000:238a:b0:3b7:8b61:2bb9 with SMTP id ffacd0b85a97d-3b906e6f195mr1725625f8f.8.1754859724175;
        Sun, 10 Aug 2025 14:02:04 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:f9ef:f5a3:456e:8480])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm38588999f8f.66.2025.08.10.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 14:02:03 -0700 (PDT)
Date: Mon, 11 Aug 2025 00:02:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <20250810210200.6n3xguqi5ukbybm2@skbuf>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
 <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
 <20250810163229.otapw4mhtv7e35jp@skbuf>
 <aJjO3wIbjzJYsS2o@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJjO3wIbjzJYsS2o@pidgin.makrotopia.org>

On Sun, Aug 10, 2025 at 05:54:55PM +0100, Daniel Golle wrote:
> As it would be nice to have the proper fix backported at least all the way
> down to linux-6.1.y, do you think it would be ok to have that solution
> I proposed (and picked from the GPL-2.0 licensed vendor driver) applied to
> the 'net' tree (with a more appropriate Fixes: tag and commit description,
> obviously) and either just not fix it for linux-5.15.y, or only there
> replace the 'return -EINVAL;' with a 'dev_warn(...); return 0;'?
> 
> In fact, commit c26933639b54 ("net: dsa: request drivers to perform FDB
> isolation") also touches drivers/net/dsa/lantiq_gswip.c and does add
> struct dsa_db as parameter for the .port_fdb_{add,del} ops. Would it be
> ok to hence target that commit in the Fixes: tag?

Generally the commit from the Fixes: tag is the one which "git bisect"
points to, when monitoring the described problem.

If the problem are the error messages, the proper fix which restores
previous behavior would be returning zero with no further logging.

If the problem is the lack of host FDB entries from the hardware, the
new logic to be properly tested in a context where it makes a real difference.
I suggest tools/testing/selftests/net/forwarding/local_termination.sh
once dsa_switch_supports_uc_filtering() returns true. Otherwise, the CPU
port must be in the flood mask of bridged user ports in order to receive
unknown traffic, and for the basic usage, I don't see much practical
benefit from adding host FDB entries to hardware. One situation is when
there are 2 bridged ports A and B, and the station connected to A wants
to talk to the CPU (the bridge net device), what will happen is the
station connected to port B will also see this traffic due to flooding.
Anyway, that behavior has existed since forever for drivers which don't
learn the MAC SA from host-transmitted packets, and don't have functional
software-based host RX filtering.

So I'm concerned that if you try to push solution B for problem A, and
test it only for problem A's circumstances and current requirements,
this will create the premise for a never-ending rabbit hole of further
fixups onto the new logic, sent to stable kernels.

