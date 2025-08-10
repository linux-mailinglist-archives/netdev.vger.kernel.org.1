Return-Path: <netdev+bounces-212355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A2B1FA13
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3938D189863D
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002E246BB4;
	Sun, 10 Aug 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pCz5wP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249A1917F1;
	Sun, 10 Aug 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754831206; cv=none; b=oWjszl+DAM5cLb2Ir7WPRCYJ3ftopEFj5EgnK7Xo26nsf7WTQNGcWVFxJldG48D6QABVtoI1cp+AVchX3aALndC8Ox+BJ1QiQtqMNgeoXqASsAvueOJfFfG2PMRIe8NOeMSn3iElZNughSvv2nc24E7X4SOkYjjai49fJM6T7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754831206; c=relaxed/simple;
	bh=RyfMCrWYOKwQNTm8axnN3JIutgR1L4y7NjdVwqMY1A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8XgPvc9mOxNPHl8T1mVY2tYKEJfKp9VEHnuuD2uNL4XUFTSlRpnmXRG1Cwy60OSBfeyV8pQf3ZXcBFdPAhgHgW0jsTuJBYA+Douvlu7ETGK6oLK7uV2rig71D1qZEvkKG2RsTR3ZNMy1Jrk1qL49q7U98m4x6qLG7yw40Ju91Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1pCz5wP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4594440145cso5301765e9.1;
        Sun, 10 Aug 2025 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754831202; x=1755436002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5N2Rw3sNZJowKb+nsB/JJIYLG27c3f06gJZVcYSVHU=;
        b=C1pCz5wPJBU2qub1rD/ujKSfKmLkumSwvqOovt+NXOtDwH5J6pCibjRbZQ4vJ/HneP
         hMq7EPvBcrEbt5swu8gzjjpNU54kaivvtsiJ8rh+WkeG+iOqZOL/gc654PKDxBHK5fNW
         BX0G/gIvAajBBZO0dexDb2GHIcp07e/r6QPj2lH9kpYSk20+txC5gv2y/v9vx5eEG2Af
         N+X4JF5wb80fLx0VFr9iajPy3NNS4wfosBJCNBLe/wJcL+pZPJAL+MgHnvynMhmrCg8S
         ZoldkbR9kImGUrmqRj0Ezvj8pfwUnHkoMo+ydllzuW4EYOU+Ydi9rBNAxfj7uU8t5hNc
         hysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754831202; x=1755436002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5N2Rw3sNZJowKb+nsB/JJIYLG27c3f06gJZVcYSVHU=;
        b=J9j5Ap8yBPRA7fSt1awZV39NV3cPVsP3UkzaSthyakUhhBIA8TsrO3XWrjv7PZ97fS
         ycMs95MG1TZevhAaJgeYrALEBDL1N6bIs6Q2yFoEDWQGtv/R5lrezwRvccaNHsBJOnaJ
         KYFCKbuyoH+iDhi9zK7zuyyyHtXsAFfaAbcmL3Blr3Y8wp95PqPFt2hBVkH3c4eSR/Sk
         SaO/AQiJ1ZOP6ED86EqzXCE2kTocK5uJJ548rjgmbaPikbTPCRtqk312ngGB7oHCQ4hV
         Wyw/DPYFdrU9xZR8ekx6/o1IheRV4gP4R8hnZ0XHGWGVxBtvOWVU71fhi4z1j85qM5NM
         3tzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHUF9Ajf6sEJ6LdpSKcVdfddz0Tmhm+9tuYRM+NCOA40jT+Xs1UstGO4dL4Qu+kNKDE5nAuz/spjKjVeA=@vger.kernel.org, AJvYcCWsyN82feo7OmgvIit08LeZT4EskLEL9qxYFT1gE3a3GgT0R+x/6+AVVWbhs0xTwCT5c2C5nzkb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdf7V+vVtizQHwK614RF9jSexGTHH3+ezHwMtkbi2gOGd7vnP+
	BWA/HN06WxP6y5CTUcEblfvESUmh2ZElvqTatFno2gl07enGZ9JXZ1OH
X-Gm-Gg: ASbGncsK/qEkWV5h8Ai1QI5EgB12nIaf0xID9BJUQ5jSxi5D7udpP8DFjgCF2CKir3g
	jxedBoLgg5ujdOVz+S7uR8APW0cr+clMLS6ThngfJUyrhCzijvi9wvnpkSenA57y//PTCCG4kU8
	v+miYjd7ZoY0JrgeCsaeA/utB9U44b8FwF2/wK7Ut3YybvoYG39UVm0iHHtoC4N1ZzYV5jj2xl/
	ascKD+5xMkjUMD4BanGX/VptRjIVmuQAvbnVqA++EZmvy/yFM3oixWiOQ5EGrVtFd9q0hWygPHd
	1OP3X6wUD7C3vn4eqxo4cXtXWKtGzPSiuIATjsdWEqFFUByp9W+F9FRr8oTby1IOmi+NftOg5xN
	AuyVwcIbEvvtNdic=
X-Google-Smtp-Source: AGHT+IFfJMsUOXJGjAstM8beoWQvm/lKJJxEwSr4aOJPNSuDeI2OU1G79f8MVx3SVimgQrY5x2106g==
X-Received: by 2002:a05:600c:6749:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-45a03a319d0mr8310675e9.5.1754831201450;
        Sun, 10 Aug 2025 06:06:41 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:c963:cdb5:238c:dd0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm258180475e9.17.2025.08.10.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 06:06:40 -0700 (PDT)
Date: Sun, 10 Aug 2025 16:06:37 +0300
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
Message-ID: <20250810130637.aa5bjkmpeg4uylnu@skbuf>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>

On Sat, Aug 09, 2025 at 11:35:28PM +0100, Daniel Golle wrote:
> Commit c9eb3e0f8701 ("net: dsa: Add support for learning FDB through
> notification") added a dev_close() call "to indicate inconsistent
> situation" when we could not delete an FDB entry from the port. In case
> of the lantiq_gswip driver this is problematic on standalone ports for
> which all calls to either .port_fdb_add() or .port_fdb_del() would just
> always return -EINVAL as adding or removing FDB entries is currently
> only supported for ports which are a member of a bridge.
> 
> As since commit c26933639b54 ("net: dsa: request drivers to perform FDB
> isolation") the dsa_db is passed to the .port_fdb_add() or
> .port_fdb_del() calls we can use that to set the FID accordingly,
> similar to how it was for bridge ports, and to FID 0 for standalone
> ports. In order for FID 0 to work at all we also need to set bit 1 in
> val[1], so always set it.
> 
> This solution was found in a downstream driver provided by MaxLinear
> (which is the current owner of the former Lantiq switch IP) under
> GPL-2.0. Import the implementation and the copyright headers from that
> driver.
> 
> Fixes: c9eb3e0f8701 ("net: dsa: Add support for learning FDB through notification")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

1. The dev_close() call was removed in commit 2fd186501b1c ("net: dsa:
   be louder when a non-legacy FDB operation fails"); what kernel are you
   seeing failures on?

2. The call paths which set DSA_DB_PORT should be all guarded by
   dsa_switch_supports_uc_filtering(), which the gswip driver doesn't
   fulfill (it's missing ds->fdb_isolation). Can you put a dump_stack()
   in the DSA_DB_PORT handler and let me know where it's called from?

3. You haven't actually explained the context that leads to
   gswip_port_fdb() returning -EINVAL. It would be great to have that as
   a starting point, perhaps a dump_stack() in the unmodified code could
   reveal more.

