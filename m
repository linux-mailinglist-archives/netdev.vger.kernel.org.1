Return-Path: <netdev+bounces-179516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA6A7D409
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43067188D09F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503D52253BA;
	Mon,  7 Apr 2025 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="T67kECPf"
X-Original-To: netdev@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A83C0B;
	Mon,  7 Apr 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007450; cv=none; b=PEv0759mqsnqS71yjd9BCHWHMNAM3afRgrZoSriKzkY0WwoQBZL2JHng2LkXGqeuxrJ+WxMrjlbINSThqJXhr47DwvEBn39IxqnOW7UexT2aQXi3tAVhOSvmhsifujmie0gO2+JMEUAqmRR8GrRLe43bw3e8d3ZAmSiPBxnc8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007450; c=relaxed/simple;
	bh=Mbsqq+6fCCPLoE8/BcquABwEHP6K3EYwcjR7Z+gthvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rm2t49/XqUyS7IlCSLacROzfyUfiDhyD740tpu6OTw/50S0YfJ+kUsOJFiLteNRSn820dSiwbEqKinjR3zVxXrwZubGrnszLanOaqvFfmVpJy5NJf6tXLCrkv2SJDrY09aW1dH0u/26ksctNIQ5Y/Yri7QWojLen0+6m3iQmW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=T67kECPf; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id CB416635B040;
	Mon, 07 Apr 2025 08:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1744006859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vjO3TAnFOqalGZ8xSYfbpH7cqt+Bfn6P2ZGcPBU9VrA=;
	b=T67kECPfT42QpBEFPxPp59Fv0xiLmj2hM27rMbf3PfIKcxYgnmWvIuC9rghujRZRFdM0Lg
	OXW+pL+q8oqvHeq1MxJ33fg7ygvcgVzndpV6ERoQYM+RUooRVmY8vFRu0DRzGp9UfDT57I
	jR5vQAtmHZab6o88WIQahsLsJEnageU=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 08:20:45 +0200
Message-ID: <4970551.GXAFRqVoOG@natalenko.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1916258.tdWV9SEqCh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1916258.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Subject: objtool warning in ice_free_prof_mask
Date: Mon, 07 Apr 2025 08:20:45 +0200
Message-ID: <4970551.GXAFRqVoOG@natalenko.name>
MIME-Version: 1.0

Hello.

With v6.15-rc1, CONFIG_OBJTOOL_WERROR=y and gcc 14.2.1 the following happens:

```
drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0() falls through to next function ice_free_flow_profs.cold()
drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0.cold() is missing an ELF size annotation
```

If I mark ice_write_prof_mask_reg() as noinline, this warning disappears.

Any idea what's going wrong?

Thank you.

-- 
Oleksandr Natalenko, MSE
--nextPart1916258.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmfzbr0ACgkQil/iNcg8
M0vZkhAA1tXUFHurvbvtwTDQNNs1ru9REB1w9TKVmN62Dgv9US35rAtlFot4wulq
43xzWuIcgR6OrHd9/39OZ9BJE2RVzOBIcBHYexgXCnX9BkH0A+y9LobJA8cMrLt+
bp/TNhJqxbobWt+YPLAWgIujNANpeepexdN/oJoW857M1dj2QQmLLHkPdAGyOhTv
jXPA+Ul+TJm4PN+u/q3WdWpUZHhXrWn5ICfyx+dzYqoYRpgQD84B/YMUasqA2R5d
ClWK5PTQq80ynDVdVLh1KKb3gXBornnQumLcalZijIz/Mwc8ELLfjt9Xv2XNdS5n
vlCw49IH2rvU+1zYhMx4DLkVh3n22pyL+Msp3UQt8klFlQ88ko8aK9Gh2Y5q+BLr
oHMokSoj92aZKjznihYWdsBst/QpFOmGTMOEtD0cHtxobZVfQnfHfd/i4yLPHWwS
ouogXxD5lx0Kx8SS4unDa4UtNP4ZQHcOmUt4l2EYeI0rnwus0NBDWGb7jdGgtuU7
1IJcJ+zs9uCEELgLDuPV67Q+2WBhqebZlJZC48vgLV47AuZ+r2XQP8BDl2F0Bh6J
cIDAiz07u3LBAaPByYdTQY0YZVr8z79MvNpGxKwNXt2LYE1yksOgpzmeUsYp+Mjb
gGBSJckC6a4KwNCG/i2gaYB/65jUaBVypebWMEGnDvF4qSLhFDw=
=UuCv
-----END PGP SIGNATURE-----

--nextPart1916258.tdWV9SEqCh--




